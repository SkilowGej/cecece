local DEFAULT_ANIMATION = {
    taunt = nil,
    sequence = nil,
    serverUpdate = function(ply, elapsed) end,
    loop = false
}

local function BroadcastAnimation(ply, animationName)
    netstream.Start(player.GetAll(), "PlayAnimation", ply, animationName)
end

local function UpdatePlayerAnimation(ply)
    local anim = ply.sup_animation_data
    if anim then
        local elapsed = CurTime() - (ply.sup_animation_start_time or 0)
        if anim.serverUpdate(ply, elapsed) == false and not anim.loop then
            ply.sup_animation = nil
            ply.sup_animation_data = nil
        end
    end
end

concommand.Add("sup_act", function(ply, cmd, args)
    if not IsValid(ply) or not args[1] then return end
    
    local animation = SUP_ANIMATIONS[args[1]]
    if not animation then return end

    animation = table.Merge(table.Copy(DEFAULT_ANIMATION), animation)
    
    ply.sup_animation = args[1]
    ply.sup_animation_data = animation
    ply.sup_animation_start_time = CurTime()
    
    BroadcastAnimation(ply, args[1])
end)

hook.Add("Think", "UpdateCustomAnimationsServer", function()
    for _, ply in ipairs(player.GetAll()) do
        if IsValid(ply) then
            UpdatePlayerAnimation(ply)
        end
    end
end)