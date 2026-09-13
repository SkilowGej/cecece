luna.loader.Client 'core/cl_core.lua'
luna.loader.Server 'core/sv_core.lua'

luna.loader.Client 'ui/cl_util.lua'

luna.loader.Client 'tabs/cl_gmap_admin.lua'

luna.loader.Client 'ui/cl_frame.lua'
luna.loader.Client 'ui/cl_info.lua'
luna.loader.Client 'ui/cl_planet.lua'
luna.loader.Client 'ui/cl_wrap_text.lua'
luna.loader.Client 'ui/cl_canvas.lua'
luna.loader.Client 'ui/cl_checkbox.lua'
luna.loader.Client 'ui/cl_entry.lua'
luna.loader.Client 'ui/cl_combobox.lua'
luna.loader.Client 'ui/cl_button.lua'
luna.loader.Client 'ui/cl_horiz_scroll.lua'

function GetTickets()
    return GetGlobalInt( 'Tickets', 0 )
end
