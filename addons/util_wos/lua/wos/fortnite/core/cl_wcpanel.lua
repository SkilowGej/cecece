--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--[[-------------------------------------------------------------------
	wiltOS Control Panel Addition:
		Allows people with the control panel to you know, configure things
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

hook.Add( "wOS.CPanel.RequestAddons", "wOS.CPanel.AddBase", function( ADDONS )

	local data = {
		Name = "Last Stand",
		OnSelected = function( dat, PANEL )
			local pw, ph = PANEL:GetSize()
		
			local icon = vgui.Create( "DImage" )
			icon:SetImage( "scripted/breen_fakemonitor_1" )
			icon:SetSize( pw, ph*0.2 )
			PANEL:Add( icon )
			
			local lbl = vgui.Create( "DLabel" )
			lbl:SetWrap( true )
			lbl:SetFont( "GModNotify" )
			lbl:SetText( "Does this example get the point across?" )
			lbl:SetDark( true )	
			PANEL:Add( lbl )			
		end,
	}

	ADDONS:Add( data )
	
end )

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
