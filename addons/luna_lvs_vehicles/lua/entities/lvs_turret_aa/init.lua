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
	PObj:SetMass( 5000 )

	local Pod = self:AddPassengerSeat( Vector(-35,0,30), Angle(0,-90,0) )
	self:SetGunnerSeat( Pod )

	self:AddEngine( Vector(0,0,-10) )

	self.PrimarySND = self:AddSoundEmitter( Vector(0,-40,57), "lvs/vehicles/droidtrifighter/fire_nose.mp3", "lvs/vehicles/droidtrifighter/fire_nose.mp3" )
	self.PrimarySND:SetSoundLevel( 110 )
	
	self.SecondarySND = self:AddSoundEmitter( Vector(0,-40,57), "lvs/vehicles/vulturedroid/fire.mp3", "lvs/vehicles/vulturedroid/fire.mp3" )
	self.SecondarySND:SetSoundLevel( 110 )
end

function ENT:OnEngineActiveChanged( Active )
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
