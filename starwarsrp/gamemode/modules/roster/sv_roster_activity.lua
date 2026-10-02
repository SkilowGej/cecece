if not SERVER then return end

Roster = Roster or {}
Roster.Activity = Roster.Activity or {}

local Activity = Roster.Activity


-- =========================================================
-- DEBUG
-- =========================================================

local function Debug(...)
    if Roster.Config and Roster.Config.Debug then
        print("[ROSTER][ACTIVITY]", ...)
    end
end


-- =========================================================
-- DANE AKTUALNEJ POSTACI
-- =========================================================

function Activity.GetCharacterData(ply)

    if not IsValid(ply) then
        return nil
    end

    local charID = ply:GetNetVar("character")

    if not charID then
        charID = ply.ActiveCharacterID
    end

    if not charID then
        return nil
    end


    local playerID = ply:GetNetVar("player_id")

    if not playerID then
        playerID = ply.ID
    end


    if not playerID then
        return nil
    end


    local teamID = nil

    local job = re.jobs[ply:Team()]

    if job then
        teamID = job.jobID
    end


    return {
        player_id = tonumber(playerID),
        char_id = tonumber(charID),
        team_id = teamID
    }

end


-- =========================================================
-- SPRAWDZENIE CZŁONKOSTWA W ROSTERZE
-- =========================================================

function Activity.CheckRosterMembership(ply)

    local data = Activity.GetCharacterData(ply)

    if not data then
        return
    end


    local query = string.format(
        [[
            SELECT
                id,
                team_id
            FROM re_roster_members
            WHERE player_id = %s
            AND char_id = %s
            LIMIT 1;
        ]],
        MySQLite.SQLStr(data.player_id),
        MySQLite.SQLStr(data.char_id)
    )


    MySQLite.query(query, function(result)

        if not IsValid(ply) then
            return
        end


        if not istable(result) or not result[1] then

            Debug(
                "Postać nie znajduje się w rosterze:",
                ply:Nick(),
                "| char_id:",
                data.char_id
            )

            return
        end


        local rosterMember = result[1]


        -- =============================================
        -- SPRAWDZENIE JOB
        -- =============================================

        if tostring(rosterMember.team_id) ~= tostring(data.team_id) then

            Debug(
                "Postać jest w rosterze, ale aktualny job się nie zgadza:",
                ply:Nick(),
                "| roster:",
                rosterMember.team_id,
                "| aktualny:",
                data.team_id
            )

            return
        end


        -- =============================================
        -- AKTYWNY
        -- =============================================

        Activity.SetActive(
            ply,
            rosterMember.id
        )

    end, function(err)

        print(
            "[ROSTER][ACTIVITY] Database error:",
            err
        )

    end)

end


-- =========================================================
-- USTAWIENIE AKTYWNOŚCI
-- =========================================================

function Activity.SetActive(ply, rosterMemberID)

    if not IsValid(ply) then
        return
    end


    local now = os.time()


    local query = string.format(
        [[
            UPDATE re_roster_members
            SET last_active = %s
            WHERE id = %s;
        ]],
        MySQLite.SQLStr(now),
        MySQLite.SQLStr(rosterMemberID)
    )


    MySQLite.query(query, function()

        if not IsValid(ply) then
            return
        end


        Debug(
            "Aktywność zaktualizowana:",
            ply:Nick(),
            "| roster_member:",
            rosterMemberID,
            "| timestamp:",
            now
        )

    end, function(err)

        print(
            "[ROSTER][ACTIVITY] Update error:",
            err
        )

    end)

end


-- =========================================================
-- POST LOAD CHARACTER
-- =========================================================

hook.Add(
    "PostLoadCharacter",
    "Roster.Activity.PostLoadCharacter",
    function(ply, charID)

        timer.Simple(1, function()

            if not IsValid(ply) then
                return
            end


            Debug(
                "PostLoadCharacter wykryty:",
                ply:Nick(),
                "| char_id:",
                charID
            )


            Activity.CheckRosterMembership(ply)

        end)

    end
)


-- =========================================================
-- OKRESOWA AKTUALIZACJA
-- =========================================================

timer.Create(
    "Roster.Activity.Update",
    Roster.Config.ActivityUpdateInterval or 60,
    0,
    function()

        for _, ply in ipairs(player.GetAll()) do

            if IsValid(ply) then

                Activity.CheckRosterMembership(ply)

            end

        end

    end
)


-- =========================================================
-- DISCONNECT
-- =========================================================

hook.Add(
    "PlayerDisconnected",
    "Roster.Activity.Disconnect",
    function(ply)

        Debug(
            "Gracz opuścił serwer:",
            ply:Nick()
        )

    end
)


-- =========================================================
-- START
-- =========================================================

print(
    "[ROSTER][ACTIVITY] Activity module loaded."
)