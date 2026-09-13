--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local function defuseWidgets()
    hook.Remove('PlayerTick', 'TickWidgets')
    hook.Remove('Tick', 'TickWidgets')
	hook.Remove('PostDrawEffects', 'RenderWidgets')
    hook.Remove('OnEntityCreated', 'WidgetInit')
    hook.Remove("RenderScene", "RenderStereoscopy")
    if widgets then
        function widgets.PlayerTick() end
    end
end

defuseWidgets()
hook.Add('PostGamemodeLoaded', 'prometheus.DisableWidgets', defuseWidgets)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
