--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.SpawnNormalOffset = 0

local WheelMass = 25000
local WheelRadius = 34
local WheelPos = {
	Vector(400,120,30),
	Vector(400,-120,30),
	Vector(-300,120,30),
	Vector(-300,-120,30),
	Vector(-450,-120,30),
	Vector(-350,120,30),
}

function ENT:OnCollision( data, physobj )
	if self:WorldToLocal( data.HitPos ).z < 0 then return true end

	return false
end

function ENT:OnSpawn( PObj )
	self:ResetSequence("tank_steer")

	PObj:SetMass( 250000 )

	self.SNDTail = self:AddSoundEmitter( Vector(-387.02,-2862,-431.71), "lvs/vehicles/atte/fire.mp3", "lvs/vehicles/atte/fire.mp3" )
	self.SNDTail:SetSoundLevel( 110 )

	self.SNDTail2 = self:AddSoundEmitter( Vector(52.65,-2.14,328.75), "lvs/vehicles/atte/fire.mp3", "lvs/vehicles/atte/fire.mp3" )
	self.SNDTail2:SetSoundLevel( 110 )

	self.SNDTail3 = self:AddSoundEmitter( Vector(-220.81,-0.22,309.02), "lvs/vehicles/atte/fire.mp3", "lvs/vehicles/atte/fire.mp3" )
	self.SNDTail3:SetSoundLevel( 110 )

	local DriverSeat = self:AddDriverSeat( Vector(250,0,250), Angle(0,-90,0) ) -- 75 0 
	DriverSeat.HidePlayer = true
	DriverSeat.ExitPos =  Vector(250,0,360)	

	local Pod = self:AddPassengerSeat( Vector(55,0,310), Angle(0,-90,0) )
	self:SetGunnerSeat( Pod )
	Pod.ExitPos = Vector(60,0,360)
	Pod.HidePlayer = true
	
	local Pod = self:AddPassengerSeat( Vector(-222.22,0,277.00), Angle(0,90,0) )
	self:SetSecondGunnerSeat( Pod )
	Pod.ExitPos = Vector(-225,0,360)
	Pod.HidePlayer = true

	local Pod = self:AddPassengerSeat( Vector(300,0,325), Angle(0,-90,0) )
	self:SetThirdGunnerSeat( Pod )
	Pod.ExitPos = Vector(175,0,325)
	Pod.HidePlayer = true

	local Pod = self:AddPassengerSeat( Vector(225,0,250), Angle(0,-90,0) ) -- 	Pod.HidePlayer = true 225,0,250
	Pod.ExitPos = Vector(225,0,350)	
	Pod.HidePlayer = true

	local Pod = self:AddPassengerSeat( Vector(200,0,250), Angle(0,-90,0) )
	Pod.ExitPos = Vector(200,0,350)
	Pod.HidePlayer = true

	local Pod = self:AddPassengerSeat( Vector(175,0,250), Angle(0,0,0) )
	Pod.ExitPos = Vector(175,0,350)	
	Pod.HidePlayer = true


	local Pod = self:AddPassengerSeat( Vector(150,0,250), Angle(0,0,0) )
	Pod.ExitPos = Vector(150,0,360)	
	Pod.HidePlayer = true


	local Pod = self:AddPassengerSeat( Vector(125,0,250), Angle(0,0,0) )
	Pod.ExitPos = Vector(125,0,360)
	Pod.HidePlayer = true	

	local Pod = self:AddPassengerSeat( Vector(100,0,250), Angle(0,0,0) )
	Pod.ExitPos = Vector(100,0,360)	
	Pod.HidePlayer = true	


	local Pod = self:AddPassengerSeat( Vector(75,0,250), Angle(0,0,0) )
	Pod.ExitPos = Vector(75,0,360)	
	Pod.HidePlayer = true	


	local Pod = self:AddPassengerSeat( Vector(50,0,250), Angle(0,0,0) )
	Pod.ExitPos = Vector(50,0,360)	
	Pod.HidePlayer = true	


	local Pod = self:AddPassengerSeat( Vector(25,0,250), Angle(0,0,0) )
	Pod.ExitPos = Vector(25,0,360)
	Pod.HidePlayer = true	


	local Pod = self:AddPassengerSeat( Vector(0,0,250), Angle(0,0,0) )
	Pod.ExitPos = Vector(0,0,360)	
	Pod.HidePlayer = true	


	local Pod = self:AddPassengerSeat( Vector(-25,0,250), Angle(0,0,0) )
	Pod.ExitPos = Vector(-25,0,360)	
	Pod.HidePlayer = true	


	local Pod = self:AddPassengerSeat( Vector(-50,0,250), Angle(0,0,0) )
	Pod.ExitPos = Vector(-50,0,360)	
	Pod.HidePlayer = true	

	local Pod = self:AddPassengerSeat( Vector(-75,0,250), Angle(0,0,0) )
	Pod.ExitPos = Vector(-75,0,360)	
	Pod.HidePlayer = true	

	local Pod = self:AddPassengerSeat( Vector(-100,0,250), Angle(0,0,0) )
	Pod.ExitPos = Vector(-100,0,360)	
	Pod.HidePlayer = true	

	local Pod = self:AddPassengerSeat( Vector(-125,0,250), Angle(0,0,0) )
	Pod.ExitPos = Vector(-125,0,360)	
	Pod.HidePlayer = true	

	local Pod = self:AddPassengerSeat( Vector(-150,0,250), Angle(0,0,0) )
	Pod.ExitPos = Vector(-150,0,360)	
	Pod.HidePlayer = true	

	local Pod = self:AddPassengerSeat( Vector(-175,0,250), Angle(0,0,0) )
	Pod.ExitPos = Vector(-175,0,360)	
	Pod.HidePlayer = true	

	local Pod = self:AddPassengerSeat( Vector(-200,0,250), Angle(0,0,0) )
	Pod.ExitPos = Vector(-200,0,360)	
	Pod.HidePlayer = true	



	for _, Pos in pairs( WheelPos ) do 
		self:AddWheel( Pos, WheelRadius, WheelMass, 1 )
	end
	self:AddEngineSound( Vector(0,0,30) )
end

function ENT:OnTick()
	--self:NoTurn()
end

function ENT:PhysicsSimulate( phys, deltatime )
	if self:GetEngineActive() then phys:Wake() end

	local OnGroundMul = self:HitGround() and 1 or 0

	local VelL = phys:WorldToLocal( phys:GetPos() + phys:GetVelocity() )

	local InputMove = self:GetMove()

	self._smMove = self._smMove and (self._smMove + (Vector(InputMove.x,InputMove.y,0):GetNormalized() - self._smMove) * deltatime * self.ForceLinearRate * 10) or InputMove

	local MoveX = (self.MaxVelocityX + self.BoostAddVelocityX * InputMove.z) * self._smMove.x
	local MoveY = (self.MaxVelocityY + self.BoostAddVelocityY * InputMove.z) * self._smMove.y

	local Ang = self:GetAngles()

	if not self:GetEngineActive() then
		self:SetSteerTo( Ang.y )
		self.smY = Ang.y
	end

	if self:GetThrottle() < 0.3 then
		self:SetSteerTo( Ang.y )
		self.smY = Ang.y
	end

	self.smY = self.smY and math.ApproachAngle( self.smY, self:GetSteerTo(), self.MaxTurnRate * deltatime * 100 ) or Ang.y

	local Steer = self:WorldToLocalAngles( Angle(Ang.p,self.smY,Ang.y) ).y

	local ForceLinear = ((Vector( MoveX, MoveY, 0 ) - Vector(VelL.x,VelL.y,0)) * self.ForceLinearMultiplier) * OnGroundMul * deltatime * 500
	local ForceAngle = (Vector(0,0,Steer) * self.ForceAngleMultiplier * 2 - phys:GetAngleVelocity() * self.ForceAngleDampingMultiplier) * OnGroundMul * deltatime * 600 

	local SIMULATE = self:GetDisabled() and SIM_NOTHING or SIM_LOCAL_ACCELERATION

	return ForceAngle, ForceLinear, SIMULATE
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
