--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local function clearLuaMemory()
    local before = collectgarbage('count')
    collectgarbage('collect')
    local after = collectgarbage('count')
    local difference = before - after

    prometheus.Print('Cleared %dmb from memory', math.Round(difference / 1024))
end

timer.Create('prometheus.ClearMemory', 60, 0, function()
    jit.flush()
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
