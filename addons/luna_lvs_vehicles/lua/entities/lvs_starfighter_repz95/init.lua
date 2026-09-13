--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.SpawnNormalOffset = 50

function ENT:OnSpawn( PObj )
	PObj:SetMass( 1000 )

	self:AddDriverSeat( Vector(0,0,60), Angle(0,-90,0) ).HidePlayer = true

	self:AddEngine( Vector(-95,65,7) )
	self:AddEngine( Vector(-95,-65,7) )
	self:AddEngineSound( Vector(0,0,10) )

	self.SNDLeft = self:AddSoundEmitter( Vector(207.65,303.52,-48.35), "lvs/vehicles/arc170/fire.mp3", "lvs/vehicles/arc170/fire.mp3" )
	self.SNDLeft:SetSoundLevel( 110 )

	self.SNDRight = self:AddSoundEmitter( Vector(207.65,-303.52,-48.35), "lvs/vehicles/arc170/fire.mp3", "lvs/vehicles/arc170/fire.mp3" )
	self.SNDRight:SetSoundLevel( 110 )
end

function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/start.wav" )
	else
		self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/stop.wav" )
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
