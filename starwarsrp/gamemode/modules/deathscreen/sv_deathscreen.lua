util.AddNetworkString("DTMenu")
util.AddNetworkString("PlayerRespawnRequest")
util.AddNetworkString( 'firstpersonDeath' )

local damageInfo = {}
local playerDeathTimes = {}
local NO_COLLISION_DURATION = 4

local function cleanupDamageInfo(ply)
    damageInfo[ply] = nil
    playerDeathTimes[ply] = nil
end

local function DisableCollision(ply)
    ply:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
    timer.Simple(NO_COLLISION_DURATION, function()
        if IsValid(ply) then
            ply:SetCollisionGroup(COLLISION_GROUP_PLAYER)
        end
    end)
end

-- hook.Add("PlayerSpawn", "DisableCollisionOnSpawn", function(ply)
--    DisableCollision(ply)
--end)

hook.Add("PlayerDeath", "DTDoSmthng", function(victim, inflictor, attacker)
    if not IsValid(victim) or victim:Alive() then return end

    playerDeathTimes[victim] = CurTime()

    net.Start("DTMenu")
    net.WriteEntity(victim)
    net.WriteTable(damageInfo[victim] or {})
    net.WriteInt(RESPAWN_TIME, 32)
    net.Send(victim)

    cleanupDamageInfo(victim)
end)

hook.Add("EntityTakeDamage", "DTMthDmg", function(target, dmginfo)
    if not (IsValid(target) and target:IsPlayer()) then return end

    damageInfo[target] = damageInfo[target] or {}

    local attacker = dmginfo:GetAttacker()
    local damage = math.max(1, dmginfo:GetDamage())

    if IsValid(attacker) then
        local attackerName = attacker:IsPlayer() and attacker:Nick() or attacker:GetClass()
        
        local existingEntry = nil
        for _, entry in ipairs(damageInfo[target]) do
            if entry.attacker == attackerName then
                existingEntry = entry
                break
            end
        end
        
        if existingEntry then
            existingEntry.damage = existingEntry.damage + damage
        else
            table.insert(damageInfo[target], {
                attacker = attackerName,
                damage = damage
            })
        end
    end
end)

net.Receive("PlayerRespawnRequest", function(len, ply)
    if IsValid(ply) and not ply:Alive() then
        local deathTime = playerDeathTimes[ply] or 0
        local timeSinceDeath = CurTime() - deathTime
        
        if timeSinceDeath >= RESPAWN_TIME then
            ply:Spawn()
            DisableCollision(ply)
        else
            local remainingTime = math.ceil(RESPAWN_TIME - timeSinceDeath)
            ply:Notify("Подождите с возрождением еще " .. remainingTime .. " секунд.")
        end
    end
end)

hook.Add("PlayerDisconnected", "CleanupDTDamageInfo", cleanupDamageInfo)

hook.Add("PlayerDeathThink", "PreventDefaultRespawn", function(ply)
    return false
end)