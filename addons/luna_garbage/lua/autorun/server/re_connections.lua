--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if(!SERVER) then return end

util.AddNetworkString("ConnectionMsg")

local function CM_Message(...)
	net.Start("ConnectionMsg")
	net.WriteTable({...})
	net.Broadcast()
end

hook.Add("PlayerConnect", "CM_Connect", function(name)
	CM_Message(Color(17, 148, 240), name, Color(255, 255, 255), " wchodzi na serwer.")
end )

MsgC( Color(71, 121, 252, 255), "[+] SUP.JoinMessages", Color(255, 255, 255), " - Moduł/Dodatek pomyślnie załadowany!\n")


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
