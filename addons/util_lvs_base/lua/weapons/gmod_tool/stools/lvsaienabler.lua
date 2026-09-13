--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


TOOL.Category		= "LVS"
TOOL.Name			= "#AI Enabler"
TOOL.Command		= nil
TOOL.ConfigName		= ""

if CLIENT then
	language.Add( "tool.lvsaienabler.name", "AI Enabler" )
	language.Add( "tool.lvsaienabler.desc", "A tool used to enable/disable AI on LVS-Vehicles" )
	language.Add( "tool.lvsaienabler.0", "Left click on a LVS-Vehicle to enable AI, Right click to disable." )
	language.Add( "tool.lvsaienabler.1", "Left click on a LVS-Vehicle to enable AI, Right click to disable." )
end

function TOOL:LeftClick( trace )
	local ent = trace.Entity

	if not IsValid( ent ) then return false end

	if not ent.LVS and not ent.LFS then return end

	if isfunction( ent.SetAI ) then
		ent:SetAI( true )
	end

	return true
end

function TOOL:RightClick( trace )
	local ent = trace.Entity

	if not IsValid( ent ) then return false end

	if not ent.LVS and not ent.LFS then return end

	if isfunction( ent.SetAI ) then
		ent:SetAI( false )
	end

	return true
end

function TOOL:Reload( trace )
	return false
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
