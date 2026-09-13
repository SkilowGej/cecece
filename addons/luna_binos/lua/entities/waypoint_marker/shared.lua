--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Waypoint"
ENT.Category = "Waypoint System"
ENT.Spawnable = true



local pointname = ""
if SERVER then
	net.Receive("wpname", function(len, ply)
		pointname = net.ReadString()
	end)
end

function ENT:SetupDataTables()

	self:NetworkVar( "Int", 0, "ColorType" )
	self:NetworkVar( "String", 0, "WaypointName" )
	self:NetworkVar( "Entity", 0, "WPOwner" )

	if SERVER then
		self:SetColorType( 1 )
		self:SetWaypointName(pointname)
	end

end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
