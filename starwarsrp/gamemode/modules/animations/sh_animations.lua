local GESTURE_SLOT_CUSTOM = GESTURE_SLOT_CUSTOM

local function IsValidPlayer(ply)
    return IsValid(ply) and ply.AnimRestartMainSequence
end

function GM:PlayerShouldTaunt(ply, actid)
    return false
end

concommand.Remove('act')

local DEFAULT_ANIMATION = { -- Crutch, in essence, these values ​​need to be entered in config for each animation
    taunt = nil,
    sequence = nil,
    update = function(ply, elapsed) end,
    loop = false
}

if CLIENT then
    local function UpdatePlayerAnimation(ply)
        local anim = ply.sup_animation_data
        if anim then
            local elapsed = CurTime() - (ply.sup_animation_start_time or 0)
            if anim.update(ply, elapsed) == false and not anim.loop then
                ply.sup_animation = nil
                ply.sup_animation_data = nil
                ply:AnimResetGestureSlot(GESTURE_SLOT_CUSTOM)
            end
        end
    end

    netstream.Hook("PlayAnimation", function(ply, act)
        if not IsValidPlayer(ply) then return end
        
        local animation = SUP_ANIMATIONS[act]
        if not animation then return end

        animation = table.Merge(table.Copy(DEFAULT_ANIMATION), animation)
        
        ply.sup_animation = act
        ply.sup_animation_data = animation
        ply.sup_animation_start_time = CurTime()
        
        if animation.taunt then
            ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, animation.taunt, true)
        elseif animation.sequence then
            ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, ply:LookupSequence(animation.sequence), 0, true)
        end
    end)

    hook.Add("Think", "UpdateCustomAnimations", function()
        for _, ply in ipairs(player.GetAll()) do
            if IsValidPlayer(ply) then
                UpdatePlayerAnimation(ply)
            end
        end
    end)
end