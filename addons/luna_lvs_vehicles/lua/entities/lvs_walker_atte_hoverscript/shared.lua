--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


ENT.Base = "lvs_base"

ENT.PrintName = "[LVS] Generic Hover"
ENT.Author = "Luna"
ENT.Information = "Luna's Vehicle Script"
ENT.Category = "[LVS]"

ENT.ForceLinearMultiplier = 1

ENT.ForceAngleMultiplier = 1
ENT.ForceAngleDampingMultiplier = 1

ENT.HoverHeight = 140
ENT.HoverTraceLength = 200
ENT.HoverHullRadius = 20

ENT.HoverCollisionFilter = {
	[COLLISION_GROUP_DEBRIS] = true,
	[COLLISION_GROUP_DEBRIS_TRIGGER] = true,
	[COLLISION_GROUP_PLAYER] = true,
	[COLLISION_GROUP_WEAPON] = true,
	[COLLISION_GROUP_VEHICLE_CLIP] = true,
	[COLLISION_GROUP_WORLD] = true,
}

function ENT:SetupDataTables()
	self:CreateBaseDT()
end

function ENT:GetCrosshairFilterLookup()
	if self._EntityLookUp then return self._EntityLookUp end

	self._EntityLookUp = {}

	for _, ent in pairs( self:GetCrosshairFilterEnts() ) do
		self._EntityLookUp[ ent:EntIndex() ] = true
	end

	return self._EntityLookUp
end

function ENT:GetVehicleType()
	return "walker"
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
