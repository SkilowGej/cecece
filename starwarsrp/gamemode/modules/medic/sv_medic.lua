local LEG_BROKE_ENABLED = true -- Переключатель включения/выключения ломания ног
local SPEED_THRESHOLD = 650
local SPEED_MULTIPLIER = 0.5
local JUMP_POWER_MULTIPLIER = 0.625

local function isValidPlayer(ply)
    return IsValid(ply) and ply:Team() ~= TEAM_CONNECTING and ply:Team() ~= TEAM_SPECTATOR and ply:Team() ~= TEAM_UNASSIGNED
end

local function breakLeg(ply)
    ply:SetNWBool("legBroke", true)
    ply._medic_RunSpeed = ply:GetRunSpeed()
    ply._medic_WalkSpeed = ply:GetWalkSpeed()
    ply._medic_JumpPower = ply:GetJumpPower()
    ply:SetRunSpeed(ply:GetRunSpeed() * SPEED_MULTIPLIER)
    ply:SetWalkSpeed(ply:GetWalkSpeed() * SPEED_MULTIPLIER)
    ply:SetJumpPower(ply:GetJumpPower() * JUMP_POWER_MULTIPLIER)
end

local function repairLeg(ply)
    ply:SetNWBool("legBroke", false)
    ply:SetRunSpeed(ply._medic_RunSpeed or DEFAULT_PLAYER_STATS['RunSpeed'])
    ply:SetWalkSpeed(ply._medic_WalkSpeed or DEFAULT_PLAYER_STATS['WalkSpeed'])
    ply:SetJumpPower(ply._medic_JumpPower or DEFAULT_PLAYER_STATS['JumpPower'])
    ply._medic_RunSpeed = nil
    ply._medic_WalkSpeed = nil
    ply._medic_JumpPower = nil
end

hook.Add("GetFallDamage", "LegBroke_GetFallDamage", function(ply, speed)
    if not LEG_BROKE_ENABLED or not isValidPlayer(ply) or ply:GetNWBool("legBroke") then
        return
    end

    if speed > SPEED_THRESHOLD then
        breakLeg(ply)
    end

    return speed / 16
end)

hook.Add("PostPlayerDeath", "LegBroke_PostPlayerDeath", function(ply)
    if ply:GetNWBool("legBroke") then
        repairLeg(ply)
    end
end)

hook.Add("PlayerSpawn", "LegBroke_PlayerSpawn", function(ply)
    if ply:GetNWBool("legBroke") then
        repairLeg(ply)
    end
end)

hook.Add("PostPlayerLoadout", "LegBroke_PostPlayerLoadout", function(ply)
    if LEG_BROKE_ENABLED and isValidPlayer(ply) and ply:GetNWBool("legBroke") then
        breakLeg(ply)
    end
end)

local pMeta = FindMetaTable("Player")
function pMeta:RepairLeg()
    repairLeg(self)
end