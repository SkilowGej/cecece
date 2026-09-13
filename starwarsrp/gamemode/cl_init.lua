include("kernel/libraries/sh_loader.lua")

include( 'shared.lua' )
function GM:SpawnMenuOpen()
	if not LocalPlayer():IsAdmin() then
		return
	end

	-- GAMEMODE:SuppressHint( "OpeningMenu" )
	-- GAMEMODE:AddHint( "OpeningContext", 20 )

	return true
end