--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

luna.observer = luna.observer or {}
luna.observer.types = luna.observer.types or {}
luna.observer.renderall = true

if CLIENT then
    function luna.observer:RegisterESPType(type, func, optionName, optionNiceName, optionDesc, bDrawClamped)  
        luna.observer.types[string.lower(type)] = {string.lower(optionName) .. "ESP", func, bDrawClamped}
    end
    
    function luna.observer:ShouldRenderAnyTypes()
        for _, v in pairs(luna.observer.types) do
            if (luna.observer.renderall) then
                return true
            end
        end
    
        return false
    end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
