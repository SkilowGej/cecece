--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

util.AddNetworkString("SummeLib.Notification")

function SummeLibrary:Notify(ply, type, header, text)
    net.Start("SummeLib.Notification")
    net.WriteString(type or "info")
    net.WriteString(header or "UNDEFINED")
    net.WriteString(text or "UNDEFINED")
    net.Send(ply)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
