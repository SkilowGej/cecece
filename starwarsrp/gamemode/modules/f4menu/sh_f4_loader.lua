luna.loader.Client 'core/cl_util.lua'
luna.loader.Client 'core/cl_core.lua'
luna.loader.Server 'core/sv_core.lua'

luna.loader.Client 'interface/cl_frame.lua'
luna.loader.Client 'interface/cl_category.lua'
luna.loader.Client 'interface/cl_close.lua'
luna.loader.Client 'interface/cl_char.lua'
luna.loader.Client 'interface/cl_link.lua'
luna.loader.Client 'interface/cl_logo.lua'
luna.loader.Client 'interface/cl_modelpanel.lua'
luna.loader.Client 'interface/cl_sidebar.lua'

luna.loader.Shared 'modules/achievements/sh_cfg.lua'

luna.loader.Client 'tabs/cl_achievements.lua'
luna.loader.Client 'tabs/cl_character.lua'
luna.loader.Client 'tabs/cl_division.lua'
luna.loader.Client 'tabs/cl_info.lua'
--print 'asasasdasdasd'
-- luna.loader.Client 'tabs/cl_galactic_map.lua'
--print 'asdadakdfghfthoifgho'

function NewFormatTime(seconds)
    local days = math.floor(seconds / 86400)
    seconds = seconds % 86400
    local hours = math.floor(seconds / 3600)
    seconds = seconds % 3600
    local minutes = math.floor(seconds / 60)
    seconds = seconds % 60

    local formattedTime = ''
    if days > 0 then
        formattedTime = formattedTime .. days .. ' d '
    end
    if hours > 0 or days > 0 then
        formattedTime = formattedTime .. hours .. ' h '
    end
    if minutes > 0 or hours > 0 or days > 0 then
        formattedTime = formattedTime .. minutes .. ' m '
    end
    if seconds > 0 or formattedTime == '' then
        formattedTime = formattedTime .. seconds .. ' s '
    end

    return formattedTime
end