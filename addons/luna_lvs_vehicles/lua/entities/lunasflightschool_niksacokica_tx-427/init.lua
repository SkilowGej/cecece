--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
--AddCSLuaFile( "cl_prediction.lua" )
AddCSLuaFile( "sh_turret.lua" )
AddCSLuaFile( "cl_hud.lua" )
include("shared.lua")
include( "sh_turret.lua" )

ENT.SpawnNormalOffset = 20
local seats = {
	{ Vector(-30,-30,35), Angle(0,0,0) },
	{ Vector(-70,-30,35), Angle(0,00,0) },
	{ Vector(-30,30,35), Angle(0,180,0) },
	{ Vector(-70,30,35), Angle(0,180,0) },
}

local WheelMass = 25
local WheelRadius = 14
local WheelPos = {
	Vector(-85,-60,-5),
	Vector(-5,-60,-5),
	Vector(80,-60,-5),
	Vector(-85,60,-5),
	Vector(-5,60,-5),
	Vector(80,60,-5),
}


function ENT:OnSpawn( PObj )
	PObj:SetMass( 2500 )

	local DriverSeat = self:AddDriverSeat( Vector(-30,0,43), Angle(0,-90,0) )
	DriverSeat.HidePlayer = false

	local GunnerSeat = self:AddPassengerSeat( Vector(-80,0,120), Angle(0,-90,0) )
	GunnerSeat.HidePlayer = true
	self:SetGunnerSeat( GunnerSeat )

	local CoSeat = self:AddPassengerSeat( Vector(40,0,35), Angle(0,-90,0) )
	CoSeat.HidePlayer = true
	self:SetCoSeat( CoSeat )

	for i, seatData in ipairs( seats ) do
		local seat = self:AddPassengerSeat( seatData[1], seatData[2] )
		seat.HidePlayer = true
		seat.PlaceBehindVelocity = 1000
	end
	
	for _, Pos in pairs( WheelPos ) do
		self:AddWheel( Pos, WheelRadius, WheelMass, 10 )
	end

	self:AddEngineSound( Vector(0,0,30) )

	local ID = self:LookupAttachment( "turret_muzzle" )
	local Muzzle = self:GetAttachment( ID )
	self.SNDTurret = self:AddSoundEmitter( self:WorldToLocal( Muzzle.Pos ), "niksacokica/tx-427/cannon_big.wav", "niksacokica/tx-427/cannon_big.wav" )
	self.SNDTurret:SetSoundLevel( 110 )
	self.SNDTurret:SetParent( self, ID )

end

function ENT:OnIsCarried( name, old, new)
	if new == old then return end
	if new then
		self:SetPoseParameter("blasters_left_yaw", 0 )
		self:SetPoseParameter("blasters_left_pitch", 0 )

		self:SetPoseParameter("blasters_right_yaw", 0 )
		self:SetPoseParameter("blasters_right_pitch", 0 )
		
		self:SetPoseParameter("missiles_left_pitch", 0 )
		self:SetPoseParameter("missiles_right_pitch", 0 )
		self:SetDisabled( true )
	else
		self:SetDisabled( false )
	end
end

function ENT:OnCollision( data, physobj )
	if self:WorldToLocal( data.HitPos ).z < 15 then return true end -- dont detect collision  when the lower part of the model touches the ground

	return false
end

function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "niksacokica/tx-427/engine_on.wav" )
	else
		self:EmitSound( "niksacokica/tx-427/engine_off.wav" )
	end
end

function ENT:OnVehicleSpecificToggled( IsActive )
	if self:GetSpotlightToggle() == true then
		self:SetSpotlightToggle(false)
	else
		self:SetSpotlightToggle(true)
	end
	self:EmitSound( "buttons/lightswitch2.wav", 75, 105 )
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
