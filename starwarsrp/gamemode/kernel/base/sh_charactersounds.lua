--Система звуков для SUP
CreateConVar("sv_hurtsounds", "1", {FCVAR_REPLICATED, FCVAR_NOTIFY})

local disablefeed = true

hook.Add("DrawDeathNotice", "DisableKills", function()
    if disablefeed then return 0, 0 end
end)

local female_jedi_models = {
    ["models/tfa/comm/gg/pm_sw_aayala.mdl"] = true,
}

for i = 1, 6 do
    util.PrecacheSound("sup_sound/footsteps/footstep-heavy-0" .. i .. ".mp3")
    util.PrecacheSound("luna_characters/walk/b1/b1_walk_0" .. i .. ".wav")
end

hook.Add("PlayerDeath", "DeathSounds", function(ply)
    if ply and IsValid(ply) then
        local job = re.jobs[ply:Team()]
        if job then
            if job.Type == TYPE_CLONE then
                ply:EmitSound("luna_characters/clone_dead/clone_death_" .. math.random(1, 6) .. ".wav")
            elseif job.Type == TYPE_DROID then
                ply:EmitSound("luna_characters/droid_dead/droid_death_0" .. math.random(1, 9) .. ".wav")
            end
        end
    end
end)

local tblhurtsounds = {
    "clone_hurt_sound_5", "clone_hurt_sound_15", "clone_hurt_sound_21", "clone_hurt_sound_29",
    "clone_hurt_sound_30", "clone_hurt_sound_31", "clone_hurt_sound_38", "clone_hurt_sound_39",
}

local tblhurtsounds2 = {
    "b1_hit_1.wav", "b1_hit_2.wav", "b1_hit_3.wav", "b1_hit_4.wav", "b1_hit_5.wav", "b1_hit_6.wav",
    "b1_hit_7.wav", "b1_hit_8.wav", "b1_hit_9.wav", "b1_hit_10.wav", "b1_hit_11.wav", "b1_hit_12.wav",
}

for _, v in ipairs(tblhurtsounds) do
    util.PrecacheSound("luna_characters/clone_dead/" .. v .. ".mp3")
end

for _, v in ipairs(tblhurtsounds2) do
    util.PrecacheSound("luna_characters/clone_dead/" .. v .. ".mp3")
end

hook.Add("PlayerShouldTakeDamage", "PlayerShouldTakeDamage_Sounds", function(ply, att)
    if ply and IsValid(att) and att:IsPlayer() then
        local job = re.jobs[ply:Team()]
        if job then
            local snd
            if job.Type == TYPE_CLONE then
                snd = "luna_characters/clone_dead/" .. table.Random(tblhurtsounds) .. ".mp3"
            elseif job.Type == TYPE_DROID then
                snd = "b1_hit/" .. table.Random(tblhurtsounds2) .. ".wav"
            elseif job.Type == TYPE_JEDI then
                if female_jedi_models[ply:GetModel()] then
                    snd = "luna_characters/jedi/hurt/female/hurt_0" .. math.random(1, 5) .. ".ogg"
                else
                    snd = "luna_characters/jedi/hurt/male/hurt_0" .. math.random(1, 6) .. ".ogg"
                end
            end
            if snd then
                ply.nextSound = ply.nextSound or 0
                if ply.nextSound < CurTime() then
                    ply.nextSound = CurTime() + 3
                    ply:EmitSound(snd, 100)
                end
            end
        end
    end
end)

hook.Add("PlayerFootstep", "PlayerFootstep_Sounds", function(ply, pos, foot, sound, volume, filter)
    local job = re.jobs[ply:Team()]
    if job then
        local snd
        if job.Type == TYPE_DROID then
            snd = "luna_characters/walk/b1/b1_walk_0" .. math.random(1, 8) .. ".wav"
        end
        if snd then
            ply:EmitSound(snd, 20)
            return true
        end
    end
    return false
end)