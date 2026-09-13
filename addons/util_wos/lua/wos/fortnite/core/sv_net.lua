--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--[[-------------------------------------------------------------------
	Fortnite Dancing Server Net:
		Networking functions for the server
			Powered by
						  _ _ _    ___  ____  
				__      _(_) | |_ / _ \/ ___| 
				\ \ /\ / / | | __| | | \___ \ 
				 \ V  V /| | | |_| |_| |___) |
				  \_/\_/ |_|_|\__|\___/|____/ 
											  
 _____         _                 _             _           
|_   _|__  ___| |__  _ __   ___ | | ___   __ _(_) ___  ___ 
  | |/ _ \/ __| '_ \| '_ \ / _ \| |/ _ \ / _` | |/ _ \/ __|
  | |  __/ (__| | | | | | | (_) | | (_) | (_| | |  __/\__ \
  |_|\___|\___|_| |_|_| |_|\___/|_|\___/ \__, |_|\___||___/
                                         |___/             
----------------------------- Copyright 2019 ]]--[[
							  
	Lua Developer: King David
	Contact: www.wiltostech.com
]]--

wOS = wOS or {}
wOS.Fortnite = wOS.Fortnite or {}

util.AddNetworkString( "wOS.Fortnite.StartTauntCamera" )
util.AddNetworkString( "wOS.Fortnite.CancelEmote" )
util.AddNetworkString( "wOS.Fortnite.WeaponSelect" )

net.Receive( "wOS.Fortnite.CancelEmote", function( len, ply )

	ply:SetNWBool( "wOS.Fortnite.EmoteEnabled", false )

end )

net.Receive( "wOS.Fortnite.WeaponSelect", function( len, ply )

	local wep = ply:GetActiveWeapon()
	if not IsValid( wep ) then return end
	if not wep:GetClass() == "wos_fortnite_dancer" then return end

	local seq = net.ReadString()
	if not wOS.Fortnite.ValidEmotes[ seq ] then return end
	
	wep.SelectedAct = seq

end )

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
