--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local colorBlue = Color(120, 161, 255)
local colorRed = Color(255, 109, 109)
local colorGreen = Color(146, 255, 138)
local colorPurple = Color(228, 138, 255)
local convars = {
    'sv_mincmdrate',
    'sv_maxcmdrate',

    'sv_minupdaterate',
    'sv_maxupdaterate',

    'sv_minrate',
    'sv_maxrate',
}

concommand.Add('prometheus_ping_report', function(ply)
    if (not ply:IsSuperAdmin()) then return end

    local sum = 0
    local avg = 0
    local min = math.huge
    local max = 0

    local players = player.GetHumans()
    local amount = #players

    MsgN('\n=====================\n')
    MsgN('Players')

    for _, ply in ipairs(players) do
        local ping = ply:Ping()

        MsgC(color_white, ply:Name() .. ': ' .. ping .. 'ms', '\n')

        sum = sum + ping
        min = math.min(min, ping)
        max = math.max(max, ping)
    end

    MsgN('\nStats')
    avg = math.Round(sum / amount, 1)

    MsgC(colorBlue, 'Average Ping: ', avg, 'ms\n')
    MsgC(colorGreen, 'Minimum Ping: ', min, 'ms\n')
    MsgC(colorRed, 'Maximum Ping: ', max, 'ms\n')

    MsgN('\nSettings')
    for _, cvName in ipairs(convars) do
        local convar = GetConVar(cvName)
        if (not convar) then continue end
        local value = string.Comma(convar:GetInt())

        MsgC(color_white, cvName, ': ', colorPurple, value, '\n')
    end

    MsgN('\n=====================')
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
