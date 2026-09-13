-- Refactored by DuLL_FoX

util.AddNetworkString("CC_HelpPoint_SendPointToPlayer")

local function SendHelpPointToPlayers(sender, data, filter)
    for _, pl in pairs(player.GetAll()) do
        if filter(pl) then
            netstream.Start(pl, "CC_HelpPoint_SendPointToPlayer", {
                type = data.type,
                title = data.title,
                text = data.text,
                pos = data.pos or sender:GetEyeTrace().HitPos,
                time = data.time
            })
        end
    end
end

netstream.Hook("CreateHelpPoint", function(sender, data)
    if not sender:IsAdmin() then return end

    SendHelpPointToPlayers(sender, data, function(pl)
        return re.jobs[pl:Team()] and re.jobs[pl:Team()].control == re.jobs[sender:Team()].control
    end)
end)

netstream.Hook("CreateMedicHelpPoint", function(sender)
    if sender:Alive() then return end

    local data = {
        type = "Ikona Serca",
        title = "Pomocy!",
        text = sender:Nick() .. " potrzebuje pomocy!",
        pos = sender:GetPos(),
        time = 10
    }

    SendHelpPointToPlayers(sender, data, function(pl)
        local features = pl:GetNetVar("features") or {}
        return features["medic"]
    end)
end)