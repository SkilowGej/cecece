--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
--AddCSLuaFile( "cl_prediction.lua" )
AddCSLuaFile( "sh_turret.lua" )
include("shared.lua")
include( "sh_turret.lua" )

ENT.SpawnNormalOffset = 20
local seats = {
	{ Vector(-30,-10,35), Angle(0,180,0) },
	{ Vector(-70,-10,35), Angle(0,180,0) },
	{ Vector(-30,10,35), Angle(0,0,0) },
	{ Vector(-70,10,35), Angle(0,0,0) },
}

local WheelMass = 500
local WheelRadius = 14
local WheelPos = {
	Vector(-45,-60,-5),
	Vector(-5,-60,-5),
	Vector(40,-60,-5),
	Vector(-45,60,-5),
	Vector(-5,60,-5),
	Vector(40,60,-5),
}


function ENT:OnSpawn( PObj )
	PObj:SetMass( 5500 )

	local cannon = ents.Create("base_anim")
    cannon:SetModel("models/kuro/sw_battlefront/weapons/bf1/dlt19.mdl")
   cannon:SetPos(self:LocalToWorld(Vector(10,15,70)))
   cannon:SetAngles(self:LocalToWorldAngles(Angle(0,0,0)))
   cannon:SetParent(self)
   cannon:Spawn()
   cannon:Activate()

   local bipod = ents.Create("base_anim")
    bipod:SetModel("models/sw_battlefront/weapons/2019/dlt19_bipod4.mdl")
   bipod:SetPos(self:LocalToWorld(Vector(02,15,105)))
   bipod:SetAngles(self:LocalToWorldAngles(Angle(70,0,0)))
   bipod:SetParent(self)
   bipod:Spawn()
   bipod:Activate()

	local DriverSeat = self:AddDriverSeat( Vector(-30,0,43), Angle(0,-90,0) )
	DriverSeat.HidePlayer = true

	local GunnerSeat = self:AddPassengerSeat( Vector(-90,0,80), Angle(0,-90,0) )
	GunnerSeat.HidePlayer = true
	self:SetGunnerSeat( GunnerSeat )

	local CoSeat = self:AddPassengerSeat( Vector(-5,15,50), Angle(0,-90,0) )
	CoSeat.HidePlayer = true
	self:SetCoSeat( CoSeat )

	for i, seatData in ipairs( seats ) do
		local seat = self:AddPassengerSeat( seatData[1], seatData[2], seatData[3], seatData[4], seatData[5] )
		seat.HidePlayer = true
		seat.PlaceBehindVelocity = 1000
	end
	
	for _, Pos in pairs( WheelPos ) do
		self:AddWheel( Pos, WheelRadius, WheelMass, 10 )
	end

	self:AddEngineSound( Vector(0,0,30) )

	local ID1 = self:LookupAttachment( "muzzle_l_front" )
	local Muzzle = self:GetAttachment( ID1 )
	self.SNDLeft = self:AddSoundEmitter( self:WorldToLocal( Muzzle.Pos ), "tx225/fire1.wav", "tx225/fire1.wav" )
	self.SNDLeft:SetSoundLevel( 110 )
	self.SNDLeft:SetParent( self, ID1 )

	local ID3 = self:LookupAttachment( "muzzle_top_left" )
	local Muzzle3 = self:GetAttachment( ID3 )
	local ID4 = self:LookupAttachment( "muzzle_top_right" )
	local Muzzle4 = self:GetAttachment( ID4 )
	self.SNDAA = self:AddSoundEmitter( self:WorldToLocal( Muzzle.Pos ), "tx225/fire2.wav", "tx225/fire2.wav" )
	self.SNDAA:SetSoundLevel( 110 )
	self.SNDAA:SetParent( self, ID3, ID4 )

	local ID2 = self:LookupAttachment( "muzzle_r_front" )
	local Muzzle = self:GetAttachment( ID2 )
	self.SNDRight = self:AddSoundEmitter( self:WorldToLocal( Muzzle.Pos ), "lvs/vehicles/iftx/fire.mp3", "lvs/vehicles/iftx/fire.mp3" )
	self.SNDRight:SetSoundLevel( 110 )
	self.SNDRight:SetParent( self, ID2 )

	self:AddArmor( Vector(50,0,45), Angle(20,0,0), Vector(-45,-45,-20), Vector(40,45,10), 750, 2500 )
	self:AddArmor( Vector(-60,0,35), Angle(0,0,0), Vector(-40,-45,-30), Vector(70,45,30), 250, 2500 )
	self:AddArmor( Vector(-100,0,35), Angle(0,0,0), Vector(-40,-45,-30), Vector(0,45,30), 10, 500 )
	self:AddArmor( Vector(0,50,15), Angle(0,0,0), Vector(-140,-25,-10), Vector(130,30,30), 50, 1000 )
	self:AddArmor( Vector(0,-55,15), Angle(0,0,0), Vector(-140,-30,-10), Vector(130,25,30), 50, 1000 )

	elf:AddArmor( Vector(-100,0,75), Angle(0,0,0), Vector(-40,-40,-10), Vector(50,35,30), 10, 2500 )

end

function ENT:OnIsCarried( name, old, new)
	if new == old then return end
	if new then
		self:SetPoseParameter("left_gun_pitch", 0 )

		self:SetPoseParameter("right_gun_pitch", 0 )
		
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
		self:EmitSound( "niksacokica/tx-427/engine_onnew.wav" )
	else
		self:EmitSound( "niksacokica/tx-427/engine_offnew.wav" )
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
