--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--[[-------------------------------------------------------------------
	Fortnite Dancing Client Core:
		Core functions for the client
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

hook.Add( "CreateMove", "wOS.Fortnite.TauntCameraMove", function( cmd )

	if not wOS.Fortnite.TauntCamera then return end
	return wOS.Fortnite.TauntCamera:CreateMove( cmd, LocalPlayer(), true )

end )

hook.Add( "CalcView", "wOS.Fortnite.TauntCameraView", function( ply, origin, angles )

	if not wOS.Fortnite.TauntCamera then return end
	return wOS.Fortnite.TauntCamera:CalcView( { origin = origin, angles = angles, fov = fov }, LocalPlayer(), true )

end )

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
