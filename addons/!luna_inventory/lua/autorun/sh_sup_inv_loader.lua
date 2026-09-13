--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local function dbgpr(ms)
    return MsgC(Color(58, 187, 204), '| [ARLAN LOADER] ', ms .. '\n')
end

local function includeDir(dir, debg)
    local shFiles = file.Find(dir .. '/*.lua', 'LUA')
    local clFiles = file.Find(dir .. '/cl/*.lua', 'LUA')
    local svFiles = file.Find(dir .. '/sv/*.lua', 'LUA')
    dbgpr('Shared Files: ' .. tostring(#shFiles))
    dbgpr('Client Files: ' .. tostring(#clFiles))
    dbgpr('Server Files: ' .. tostring(#svFiles))
    for _, v in ipairs(shFiles) do
        local filePath = dir .. '/' .. v
        if SERVER then
            AddCSLuaFile(filePath)
            include(filePath)
            if debg then dbgpr('Included (SHARED): ' .. filePath) end
        elseif CLIENT then
            if debg then dbgpr('Included (CLIENT): ' .. filePath) end
            include(filePath)
        end
    end

    for _, v in ipairs(clFiles) do
        local filePath = dir .. '/cl/' .. v
        if SERVER then
            AddCSLuaFile(filePath)
            if debg then dbgpr('AddCSLuaFile (CLIENT): ' .. filePath) end
        elseif CLIENT then
            include(filePath)
            if debg then dbgpr('Included (CLIENT): ' .. filePath) end
        end
    end

    for _, v in ipairs(svFiles) do
        local filePath = dir .. '/sv/' .. v
        if SERVER then
            include(filePath)
            if debg then dbgpr('Included (SERVER): ' .. filePath) end
        end
    end
end

local function Load()
    MsgC(Color(255, 229, 0), '| [ARLEKIN4??] ', Color(255, 255, 255), 'Status: ', Color(255, 111, 0), 'Loading..\n')
    includeDir('coredata_inventory', true)
    MsgC(Color(255, 229, 0), '| [ARLEKIN4??] ', Color(255, 255, 255), 'Status: ', Color(0, 255, 132), 'Loaded Successfully!\n')
end

-- if SERVER then
--     resource.AddFile('materials/rotatedbox.png')
-- end
Load()
-- timer.Simple(1, function() Load() end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
