--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.SpawnNormalOffset = 25

function ENT:OnSpawn( PObj )
	PObj:SetMass( 2000 )

	self:AddDriverSeat( Vector(-12,0,14), Angle(0,-90,9) )

	self:AddEngine( Vector(-215.42,122.3,8.38) )
	self:AddEngine( Vector(-215.42,-122.3,8.38) )
	self:AddEngineSound( Vector(100,0,0) )

	self.PrimarySND = self:AddSoundEmitter( Vector(49.91, 0, -42.09), "lfs/v19/v19_shoot.wav", "lfs/v19/v19_shoot.wav" )
	self.PrimarySND:SetSoundLevel( 110 )

	self:SetWingsDown(false)
end

function ENT:OnVehicleSpecificToggled(bOn)
	local trH = util.TraceLine({
		start = self:LocalToWorld(Vector(0,0,0)),
		endpos = self:LocalToWorld(Vector(0,0,-300)),
		filter = self
	})

	if bOn and trH.HitWorld == false then
		self:EmitSound("lvs/vehicles/vwing/sfoils.wav")
		self:SetWingsDown(true)
	else
		self:EmitSound("lvs/vehicles/vwing/sfoils.wav")
		self:SetWingsDown(false)
	end
end

function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/start.wav" )
		self:ManipulateBonePosition( 4, Vector(0,46,0) )
	else
		self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/stop.wav" )
		self:ManipulateBonePosition( 4, Vector(0,0,0) )
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
