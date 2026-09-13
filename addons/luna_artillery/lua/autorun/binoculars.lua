--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if (GetConVar( "rpw_binoculars_hold" ) == nil) then
	CreateConVar( "rpw_binoculars_hold", 1, FCVAR_ARCHIVE, "0 or 1, whether or not binoculars are toggle-to-use rather than hold-to-use." )
end

function rpw_PopulateOptionsMenu_Binoculars( CPanel )	
	CPanel:AddControl( "Checkbox", { Label = "Hold to Aim", Command = "rpw_binoculars_hold" } )
end

hook.Add( "PopulateToolMenu", "rpw_PopulateOptionsMenu_Binoculars", function()
	spawnmenu.AddToolMenuOption( "Options", "RPW", "RPW_Binoculars", "Binoculars", "", "", rpw_PopulateOptionsMenu_Binoculars )
end )

hook.Add("InitPostEntity", "OBBMapMinsMaxs", function()
    OBBMapMins = Entity(0):OBBMins()
    OBBMapMaxs = Entity(0):OBBMaxs()
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
