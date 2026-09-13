--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--[[-------------------------------------------------------------------
	Fortnite Dancing Concommands:
		Well you need to have console commands to control serverside settings
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

local ACTS = CreateConVar( "wos_fortnite_allowact", "1", { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Should players be able to use the act_wos_fn command to perform an emote without the SWEP?" )

wOS.Fortnite.ValidEmotes = {
	bestmates = "wos_fn_bestmates",
	boneless = "wos_fn_boneless",
	breakdown = "wos_fn_breakdown",
	dancemoves = "wos_fn_dancemoves",
	discofever = "wos_fn_discofever",
	eagle = "wos_fn_eagle",
	electroshuffle = "wos_fn_electroshuffle",
	flippinincredible = "wos_fn_flippin_incredible",
	flippinsexy = "wos_fn_flipping_sexy",
	floss = "wos_fn_floss",
	fresh = "wos_fn_fresh",
	gentlemandab = "wos_fn_gentlemandab",
	groovejam = "wos_fn_groovejam",
	handsignals = "wos_fn_handsignals",
	hype = "wos_fn_hype",
	infinidab = "wos_fn_infinidab",
	intensity = "wos_fn_intensity",
	jubilation = "wos_fn_jubilation",
	laughitup = "wos_fn_laughitup",
	livinglarge = "wos_fn_livinglarge",
	orangejustice = "wos_fn_orangejustice",
	poplock = "wos_fn_poplock",
	rambunctious = "wos_fn_rambunctious",
	reanimated = "wos_fn_reanimated",
	starpower = "wos_fn_starpower",
	swipeit = "wos_fn_swipeit",
	takethel = "wos_fn_takethel",
	trueheart = "wos_fn_trueheart",
	twist = "wos_fn_twist",
	wiggle = "wos_fn_wiggle",
	youreawesome = "wos_fn_youreawesome",
	zany = "wos_fn_zany",
}

concommand.Add( "act_wos_fn", function( ply, cmd, args )

	if not ACTS:GetBool() then return end
	if not IsValid( ply ) then return end
	
	local act = args[1]
	if not act or #act < 1 then return end
	act = string.lower( tostring( act ) )
	
	if act == "list" then
		ply:PrintMessage( HUD_PRINTCONSOLE, "---------------wiltOS Fortnite Emotes-------------------" )
		for emote, _ in pairs( wOS.Fortnite.ValidEmotes ) do
			ply:PrintMessage( HUD_PRINTCONSOLE, "--------     " .. emote )
		end
		ply:PrintMessage( HUD_PRINTCONSOLE, "--------------------------------------------------------" )
		ply:ChatPrint( "[wOS - Fortnite] All emote names have been pasted into your console!" )
		return
	end
	
	if not ply:Alive() then return end	
	if ply:InVehicle() then return end
	
	local sequence_name = wOS.Fortnite.ValidEmotes[ act ]
	if not sequence_name then return end
	ply:SetNWString( "wOS.Fortnite.Emote", sequence_name )
	ply:SetNWBool( "wOS.Fortnite.EmoteEnabled", true )
	net.Start( "wOS.Fortnite.StartTauntCamera" )
	net.Send( ply )

end )

hook.Add( "PlayerSpawn", "wOS.Fortnite.ResetAnim", function( ply )
	ply:SetNWBool( "wOS.Fortnite.EmoteEnabled", false )
end )

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
