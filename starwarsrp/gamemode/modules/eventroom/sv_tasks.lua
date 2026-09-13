netstream.Hook('EventRoom_StartTimer', function( pl, time_end )
    if not pl:IsAdmin() then return end

    local tasks = GetGlobalTable('EventTask', {text = '', title = '', player = pl})

    tasks.timer = { ['end'] = time_end, ['start'] = CurTime() }

    SetGlobalTable('EventTask', tasks)
end)

netstream.Hook('EventRoom_ChangeTask', function( pl, data )
    if not pl:IsAdmin() then return end

    SetGlobalTable('EventTask', {text = data.text, title = data.title, lines = data.lines, player = pl})
    BroadcastLua("surface.PlaySound(\"luna_sound_effects/rankup/triumph.mp3\")")
    --BroadcastLua("surface.PlaySound(\"luna_sound_effects/info/infoobnovleno\"..math.random(1,4)..\".mp3\")")
end)