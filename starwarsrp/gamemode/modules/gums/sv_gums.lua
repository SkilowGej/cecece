if GetGlobalTable('gums') == {} then
    local gums = {}
    for i, name in pairs(GUM_ROOMS) do
        gums[i] = false
    end

    SetGlobalTable('gums', gums)
end

hook.Add( "PlayerDisconnected", "Playerleave", function(ply)
    local gums = GetGlobalTable('gums')
    for i, data in pairs(gums) do
        if data and data.ply == ply then
            gums[i] = false
        end
    end

    SetGlobalTable('gums', gums)
end )