--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if ( SERVER ) then
	
	-- needed for custom vgui controls in the menu
	AddCSLuaFile( "vgui/stackercontrolpresets.lua" )
	AddCSLuaFile( "vgui/stackerdnumslider.lua" )
	AddCSLuaFile( "vgui/stackerpreseteditor.lua" )
	
	-- convenience modules
	AddCSLuaFile( "improvedstacker/improvedstacker.lua" )
	AddCSLuaFile( "improvedstacker/localify.lua" )
	
else

	-- needed for custom vgui controls in the menu
	include( "vgui/stackercontrolpresets.lua" )
	include( "vgui/stackerdnumslider.lua" )
	include( "vgui/stackerpreseteditor.lua" )

end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
