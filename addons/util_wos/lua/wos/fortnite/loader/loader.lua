--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


--[[-------------------------------------------------------------------
	Fortnite Dancing Addon Real Loader:
		We do all the actual loading here
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

local dir = "wos/fortnite"

if SERVER then
	AddCSLuaFile( dir .. "/vgui/vgui_tauntcam.lua" )
	AddCSLuaFile( dir .. "/core/sh_core.lua" )
	AddCSLuaFile( dir .. "/core/cl_net.lua" )
	AddCSLuaFile( dir .. "/core/cl_core.lua" )
	AddCSLuaFile( dir .. "/core/cl_wcpanel.lua" )
	--include( dir .. "/core/sv_core.lua" )
	include( dir .. "/core/sv_concommands.lua" )
	include( dir .. "/core/sv_net.lua" )
else
	include( dir .. "/vgui/vgui_tauntcam.lua" )
	include( dir .. "/core/sh_core.lua" )
	include( dir .. "/core/cl_net.lua" )
	include( dir .. "/core/cl_core.lua" )
	include( dir .. "/core/cl_wcpanel.lua" )
end

include( dir .. "/core/sh_core.lua" )

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
