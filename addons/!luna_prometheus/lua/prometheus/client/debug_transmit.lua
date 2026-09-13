--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local cvDebug = CreateClientConVar('cl_prometheus_transmit_debug', '0')
local bDebug = cvDebug:GetBool()
local colorRed = Color(255, 126, 126)
local colorGreen = Color(165, 255, 129)
local entsIn = {}
local entsOut = {}

cvars.AddChangeCallback('cl_prometheus_transmit_debug', function(_, _, new)
    entsIn = {}
    entsOut = {}
    bDebug = new == '1'
end, 'var_internal')

hook.Add('NotifyShouldTransmit', 'prometheus-debug', function(ent, shouldTransmit)
    if (not bDebug) then return end

    if (shouldTransmit) then
        entsIn[ent] = true
        entsOut[ent] = nil
    else
        entsIn[ent] = nil
        entsOut[ent] = true
    end
end)

timer.Create('prometheus-debug.ResetTransmit', 1, 0, function()
    if (not bDebug) then return end

    local amountIn = table.Count(entsIn)
    local amountOut = table.Count(entsOut)

    if (amountIn > 0) then
        MsgC(colorRed, 'Transmitted in ', amountIn, ' entities', '\n')
    end

    if (amountOut > 0) then
        MsgC(colorGreen, 'Unloaded ', amountOut, ' entities from PVS', '\n')
    end

    entsIn = {}
    entsOut = {}
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
