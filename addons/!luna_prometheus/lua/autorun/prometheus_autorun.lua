--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--[[
    ██████████████████████████████████████████████
    █────█────█────█─███─█───█───█─██─█───█─█─█───█
    █─██─█─██─█─██─█──█──█─████─██─██─█─███─█─█─███
    █────█────█─██─█─█─█─█───██─██────█───█─█─█───█
    █─████─█─██─██─█─███─█─████─██─██─█─███─█─███─█
    █─████─█─██────█─███─█───██─██─██─█───█───█───█
    ██████████████████████████████████████████████

    -- A clean, optimization library.
--]]

prometheus = prometheus or {}
prometheus.cfg = prometheus.cfg or {}

local includeServer = (SERVER) and include or function() end
local includeClient = (SERVER) and AddCSLuaFile or include
local includeShared = function(path) includeServer(path) includeClient(path) end
local realms = {
    ['client'] = includeClient,
    ['shared'] = includeShared,
    ['server'] = includeServer,
}

local printInfo do
    local colorTag = Color(22, 137, 245)
    local colorDebug = Color(0, 204, 255)
    local colorWarning = Color(255, 145, 0)
    local colorError = Color(255, 0, 0)
    local textTag = 'SUP.optimization • '

    local function doPrint(color, tag, text, ...)
        MsgC(colorTag, textTag, color or color_white, tag or '', color_white, string.format(text, ...))
        MsgN('')
    end

    function printInfo(text, ...)
        doPrint(nil, nil, text, ...)
    end

    function prometheus.PrintDebug(text, ...)
        doPrint(colorDebug, '[DEBUG] ', text, ...)
    end

    function prometheus.PrintWarning(text, ...)
        doPrint(colorWarning, '[WARNING] ', text, ...)
    end

    function prometheus.PrintError(text, ...)
        doPrint(colorError, '[ERROR] ', text, ...)
    end
end
prometheus.Print = printInfo

local function includeDirectory(directory, realm)
    local files = file.Find(directory .. '/*.lua', 'lUA')
    local funcLoad = realms[realm]
    for _, name in ipairs(files) do
        funcLoad(directory .. '/' .. name)
        --printInfo('Loaded file \'%s\' in %s realm', name, realm)
    end
end

local configFilePath = 'prometheus/prometheus_config.lua'
if (SERVER and not file.Exists(configFilePath, 'LUA')) then
    ErrorNoHalt('Missing garrysmod/lua/' .. configFilePath .. '\n')
    printInfo('Missing configuration file.')
end

luna.library.Print(false, 'SUP.optimization • Inicjalizacja...')
    includeShared(configFilePath)
    includeDirectory('prometheus/server', 'server')
    includeDirectory('prometheus/client', 'client')
    includeDirectory('prometheus/shared', 'shared')
luna.library.Print(false, 'SUP.optimization • Inicjalizacja zakończona!')

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
