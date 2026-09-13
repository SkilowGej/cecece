if not sql.TableExists("player_tracking") then
    sql.Query([[
        CREATE TABLE player_tracking (
            steamid TEXT PRIMARY KEY,
            first_join INTEGER,
            total_time INTEGER,
            kills INTEGER,
            deaths INTEGER,
            money_spent INTEGER,
            money_earned INTEGER
        )
    ]])
end

local PLAYER = FindMetaTable("Player")
function PLAYER:LoadTrackingData()
    local steamID = self:SteamID()
    local data = sql.QueryRow("SELECT * FROM player_tracking WHERE steamid = " .. sql.SQLStr(steamID))

    if data then
        self:SetNWInt("JoinTime", os.time())
        self:SetNWInt("FirstJoinTime", tonumber(data.first_join))
        self:SetNWInt("TotalTime", tonumber(data.total_time))
        self:SetNWInt("KillCount", tonumber(data.kills))
        self:SetNWInt("DeathCount", tonumber(data.deaths))
        self:SetNWInt("MoneySpent", tonumber(data.money_spent))
        self:SetNWInt("MoneyEarned", tonumber(data.money_earned))
    else
        self:SetNWInt("JoinTime", os.time())
        self:SetNWInt("FirstJoinTime", os.time())
        self:SetNWInt("TotalTime", 0)
        self:SetNWInt("KillCount", 0)
        self:SetNWInt("DeathCount", 0)
        self:SetNWInt("MoneySpent", 0)
        self:SetNWInt("MoneyEarned", 0)

        sql.Query("INSERT INTO player_tracking (steamid, first_join, total_time, kills, deaths, money_spent, money_earned) VALUES (" ..
            sql.SQLStr(steamID) .. ", " ..
            self:GetNWInt("FirstJoinTime") .. ", 0, 0, 0, 0, 0)")
    end
end

function PLAYER:SaveTrackingData()
    local steamID = self:SteamID()
    local currentTime = os.time()
    local totalTime = self:GetNWInt("TotalTime") + (currentTime - self:GetNWInt("JoinTime"))

    sql.Query("UPDATE player_tracking SET " ..
        "first_join = " .. self:GetNWInt("FirstJoinTime") .. ", " ..
        "total_time = " .. totalTime .. ", " ..
        "kills = " .. self:GetNWInt("KillCount") .. ", " ..
        "deaths = " .. self:GetNWInt("DeathCount") .. ", " ..
        "money_spent = " .. self:GetNWInt("MoneySpent") .. ", " ..
        "money_earned = " .. self:GetNWInt("MoneyEarned") ..
        " WHERE steamid = " .. sql.SQLStr(steamID))
end

function PLAYER:InitializeTrackingData()
    self:LoadTrackingData()
end

function PLAYER:IncrementKillCount()
    self:SetNWInt("KillCount", self:GetNWInt("KillCount") + 1)
end

function PLAYER:IncrementDeathCount()
    self:SetNWInt("DeathCount", self:GetNWInt("DeathCount") + 1)
end

function PLAYER:AddMoneySpent(amount)
    self:SetNWInt("MoneySpent", self:GetNWInt("MoneySpent") + amount)
end

function PLAYER:AddMoneyEarned(amount)
    self:SetNWInt("MoneyEarned", self:GetNWInt("MoneyEarned") + amount)
end

function PLAYER:GetTimeOnServer()
    return self:GetNWInt("TotalTime") + (os.time() - self:GetNWInt("JoinTime"))
end

function PLAYER:GetTrackingData()
    return {
        JoinTime = self:GetTimeOnServer(),
        FirstJoinTime = self:GetNWInt("FirstJoinTime"),
        TotalTime = self:GetNWInt("TotalTime"),
        KillCount = self:GetNWInt("KillCount"),
        DeathCount = self:GetNWInt("DeathCount"),
        MoneySpent = self:GetNWInt("MoneySpent"),
        MoneyEarned = self:GetNWInt("MoneyEarned")
    }
end

hook.Add("PlayerInitialSpawn", "InitializeTrackingData", function(p)
    p:InitializeTrackingData()
end)

hook.Add("PlayerDisconnected", "SaveTrackingData", function(p)
    p:SaveTrackingData()
end)

hook.Add("PlayerDeath", "TrackPlayerDeath", function(victim, inflictor, attacker)
    if IsValid(victim) and victim:IsPlayer() then
        victim:IncrementDeathCount()
    end

    if IsValid(attacker) and attacker:IsPlayer() and attacker ~= victim then
        attacker:IncrementKillCount()
    end
end)

hook.Add( 'onMoneyAdded', 'MoneyTracking', function( p, money )
    if money > 0 then
        p:AddMoneyEarned(money)
    else
        p:AddMoneySpent(money)
    end
end )

/*
-- For example:
hook.Add( 'PlayerMoneyAdded', 'example', function( p, moneyCount )
    p:AddMoneyEarned(moneyCount)
end )

hook.Add( 'PlayerMoneySpent', 'example', function( p, moneyCount )
    p:AddMoneySpent(moneyCount)
end )
*/

hook.Add( 'ShowSpare2', 'GameMenu:Show', function( ply )
    if not IsValid(ply) or not ply:Alive() then return end
    ply:SendLua("GameMenu:Show()")
end )