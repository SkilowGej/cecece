--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--[[-------------------------------------------------------------------
	Fortnite Dancing Shared Core:
		All shared functions for good prediction between server/client
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

hook.Add( "CalcMainActivity", "wOS.Fortnite.PerformEmote", function( ply )
	
	if ply:InVehicle() then return end
	if ply:GetNWBool( "wOS.Fortnite.EmoteEnabled", false ) then
		if not ply.WOS_FortniteLastBool then
			ply:SetCycle( 0 )
			ply.WOS_FortniteLastBool = true
		end
		local seq = ply:GetNWString( "wOS.Fortnite.Emote", "" )
		seq = ply:LookupSequence( seq )
		if not seq or seq < 1 then return end
		return -1, seq
	end
	ply.WOS_FortniteLastBool = ply.WOS_FortniteLastBool or ply:GetNWBool( "wOS.Fortnite.EmoteEnabled", false )
end )

hook.Add( "UpdateAnimation", "wOS.Fortnite.AnimationSpeed", function( ply, _, __ )

	if not ply:Alive() then return end
	if ply:InVehicle() then return end
	if !ply:GetNWBool( "wOS.Fortnite.EmoteEnabled", false ) then return end 
	ply:SetPlaybackRate( 1 )
	return true
	
end )

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
