util.AddNetworkString("VotingPlugin")

local votes = {}

hook.Add("PlayerSay", "VotingPluginCommand", function(ply, text)
    if IsValid(ply) and ply:IsAdmin() then
        if string.lower(text) == "!cv" then
            net.Start("VotingPlugin")
            net.WriteUInt(1, 4) -- 1: OpenMenu
            net.Send(ply)
            return ""
        end
    end
end)

net.Receive("VotingPlugin", function(len, ply)
    local messageType = net.ReadUInt(4)

    if messageType == 2 then -- 2: CreateVote
        if not IsValid(ply) or not ply:IsAdmin() then return end

        local voteName = net.ReadString()
        local voteOptions = net.ReadTable()
        local voteResponseType = net.ReadString()
        local voteMinRating = net.ReadInt(32)
        local voteMaxRating = net.ReadInt(32)
        local voteDuration = net.ReadUInt(32)

        -- Well, this is not the best way to do this, but it works, if you not lazy, you can make it better
        if voteResponseType == "Оценка" then
            voteResponseType = "Rating"
        elseif voteResponseType == "Множественный выбор" then
            voteResponseType = "Multiple Choice"
        end

        local voteId = generateUniqueVoteId()
        votes[voteId] = {
            name = voteName,
            options = voteOptions,
            responseType = voteResponseType,
            minRating = voteMinRating,
            maxRating = voteMaxRating,
            duration = voteDuration,
            results = {},
            endTime = os.time() + voteDuration
        }

        for _, player in ipairs(player.GetAll()) do
            net.Start("VotingPlugin")
            net.WriteUInt(3, 4) -- 3: VoteStatus
            net.WriteUInt(1, 2) -- 1: Notify vote
            net.WriteUInt(voteId, 32)
            net.WriteString(voteName)
            net.WriteTable(voteOptions)
            net.WriteString(voteResponseType)
            net.WriteInt(voteMinRating, 32)
            net.WriteInt(voteMaxRating, 32)
            net.WriteUInt(voteDuration, 32)
            net.Send(player)
        end

        timer.Create("VotingPluginTimer_" .. voteId, voteDuration, 1, function()
            CloseVote(voteId)
        end)
    elseif messageType == 4 then -- 4: SubmitVote
        if not IsValid(ply) then return end

        local voteId = net.ReadUInt(32)
        local vote = votes[voteId]

        if not vote then return end

        if os.time() > vote.endTime then
            ply:ChatPrint("Период голосования для этого опроса закончился.")
            return
        end

        if vote.responseType == "Rating" then
            local rating = net.ReadInt(32)
            vote.results[ply:SteamID()] = rating
        elseif vote.responseType == "Multiple Choice" then
            local selectedOption = net.ReadString()
            vote.results[ply:SteamID()] = selectedOption
            vote.results[ply:SteamID() .. "_extra"] = vote.options[nextOptionIndex]
        end

        local voteResults = {}
        if vote.responseType == "Rating" then
            for _, rating in pairs(vote.results) do
                voteResults[rating] = (voteResults[rating] or 0) + 1
            end
        elseif vote.responseType == "Multiple Choice" then
            for _, option in pairs(vote.results) do
                voteResults[option] = (voteResults[option] or 0) + 1
            end
        end

        net.Start("VotingPlugin")
        net.WriteUInt(3, 4) -- 3: VoteStatus
        net.WriteUInt(2, 2) -- 2: Update vote status
        net.WriteUInt(voteId, 32)
        net.WriteTable(voteResults)
        net.WriteBool(false)
        net.WriteString(vote.responseType)
        net.Broadcast()
    elseif messageType == 5 then -- 5: CancelVote
        if not IsValid(ply) or not ply:IsAdmin() then return end

        local voteId = net.ReadUInt(32)
        CancelVote(voteId)
    end
end)

-- Helper functions
function generateUniqueVoteId()
    local voteId = os.time()
    while votes[voteId] do
        voteId = os.time()
    end
    return voteId
end

function CloseVote(voteId)
    local vote = votes[voteId]
    if not vote then return end

    local voteResults = {}
    if vote.responseType == "Rating" then
        for _, rating in pairs(vote.results) do
            voteResults[rating] = (voteResults[rating] or 0) + 1
        end
    elseif vote.responseType == "Multiple Choice" then
        for _, option in pairs(vote.results) do
            voteResults[option] = (voteResults[option] or 0) + 1
        end
    end

    net.Start("VotingPlugin")
    net.WriteUInt(3, 4) -- 3: VoteStatus
    net.WriteUInt(2, 2) -- 2: Update vote status
    net.WriteUInt(voteId, 32)
    net.WriteTable(voteResults)
    net.WriteBool(true)
    net.WriteString(vote.responseType)
    net.Broadcast()

    net.Start("VotingPlugin")
    net.WriteUInt(3, 4) -- 3: VoteStatus
    net.WriteUInt(3, 2) -- 3: Vote results
    net.WriteUInt(voteId, 32)
    net.WriteTable(voteResults)
    net.WriteString(vote.responseType)
    net.Broadcast()

    votes[voteId] = nil
end

function CancelVote(voteId)
    local vote = votes[voteId]
    if not vote then return end

    votes[voteId] = nil

    timer.Remove("VotingPluginTimer_" .. voteId)

    net.Start("VotingPlugin")
    net.WriteUInt(6, 4) -- 6: CancelVote
    net.WriteUInt(voteId, 32)
    net.Broadcast()
end