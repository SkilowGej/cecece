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
	self:SetSkin(8)

	self:AddDriverSeat( Vector(-105,-0,29), Angle(0,-90,0) )
	
	self:SetBodygroup(1,1)

	self:AddEngine( Vector(-130,-21,23.20) )
	self:AddEngine( Vector(-130,21,23.2) )
	self:AddEngineSound( Vector(100,0,0) )

	self.PrimarySND = self:AddSoundEmitter( Vector(118.24,0,49.96), "lfs/jsf/TIE Laser 2D.mp3", "lfs/jsf/TIE Laser 2D.mp3" )
	self.PrimarySND:SetSoundLevel( 110 )

	self:ResetSequence(self:LookupSequence("TopOpen"))
end


function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:SetModel("models/starwars/lordtrilobite/ships/delta7/delta7_flying.mdl")
		self:EmitSound( "lfs/jsf/JSF Startup.mp3" )	
		self:SetBodygroup(1,0)
	else
		self:SetModel("models/starwars/lordtrilobite/ships/delta7/delta7_landed.mdl")
		self:EmitSound( "lfs/jsf/JSF Shutoff.mp3" )	
		self:SetBodygroup(1,1)
	end
end

function ENT:OnVehicleSpecificToggled()
	if not self:GetHatchOpen(false) then
		self:EmitSound("lvs/vehicles/laat/door_close.wav")
		self:SetHatchOpen(true)
		self:SetBodygroup(1,0)
	else
		self:EmitSound("lvs/vehicles/laat/door_open.wav")
		self:SetHatchOpen(false)
		self:SetBodygroup(1,1)
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
