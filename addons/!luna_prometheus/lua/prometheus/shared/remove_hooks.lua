--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local function defuseHooks()
    -- Unnecessary halos
    hook.Remove('PreDrawHalos', 'PropertiesHover')
    hook.Remove('PreDrawHalos', 'AddPhysgunHalos')

    -- DOF
    hook.Remove('GUIMousePressed', 'SuperDOFMouseDown')
    hook.Remove('GUIMouseReleased', 'SuperDOFMouseUp')
    hook.Remove('PreventScreenClicks', 'SuperDOFPreventClicks')
    hook.Remove('Think', 'DOFThink')

    -- Frame Blending
    hook.Remove('PostRender', 'RenderFrameBlend')
    hook.Remove('PreRender', 'PreRenderFrameBlend')

    -- B*llshit
    hook.Remove('Think', 'CheckSchedules')
    hook.Remove('LoadGModSave', 'LoadGModSave')
    
    timer.Destroy('HostnameThink')
end

hook.Add('InitPostEntity', 'prometheus.RemoveHooks', defuseHooks)


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
