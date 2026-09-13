--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")
--[[
local WheelMass = 35
local WheelRadius = 25
local WheelPos = {
	Vector(-100,-80,-12),
	Vector(0,-80,-12),
	Vector(100,0,-12),
	Vector(-100,0,-12),
	Vector(100,-80,-12),
	Vector(-100,80,-12),
	Vector(0,80,-12),
	Vector(100,80,-12),
}]]

local WheelMass = 35
local WheelRadius = 25
local WheelPos = {
	Vector(-140,-80,-45),
	Vector(0,-80,-25),
	Vector(160,-80,-25),
	Vector(-140,80,-45),
	Vector(0,80,-25),
	Vector(160,80,-25),
}


ENT.SpawnNormalOffset = 80

function ENT:OnSpawn()

	local PObj = self:GetPhysicsObject()

    util.AddNetworkString("Veh_Good_Sceenshake")

	PObj:SetMass( 25000 )
	
	local cpd = "ACT_IDEL"
    local Driver = self:AddDriverSeat(Vector(-68,27,18), Angle(0,-90,15))

	local TXGunnerSeat = self:AddPassengerSeat( Vector(0,0,0), Angle(0,-90,0) )
	self:SetGunnerSeat( TXGunnerSeat )

	local ID = self:LookupAttachment( "driver_turret" )
	local Attachment = self:GetAttachment( ID )
	
	if Attachment then
		local Pos,Ang = LocalToWorld( Vector(0,-60,0), Angle(180,0,-90), Attachment.Pos, Attachment.Ang )
		
		TXGunnerSeat:SetParent( NULL )
		TXGunnerSeat:SetPos( Pos )
		TXGunnerSeat:SetAngles( Ang )
		TXGunnerSeat:SetParent( self, ID )
	end
	
	local Pod = self:AddPassengerSeat( Vector(-68,-23,18), Angle(0,-90,15) )
	self:SetSecondGunnerSeat( Pod )

	for _, Pos in pairs( WheelPos ) do 
		self:AddWheel( Pos, WheelRadius, WheelMass, 10 )
	end
	self:AddEngineSound( Vector(0,0,30) )
	self:SetRotorPos(Vector(-120,0,30))
	self.curpos = 0
	self.targetpos = 0
	self.curposlr = 0
	self.targetposlr = 0

	self.PrimarySND = self:AddSoundEmitter( Vector(-68,27,18), "TX_FIRE", "TX_FIRE" )
	self.SecSND = self:AddSoundEmitter( Vector(-97.34,0.52,87.79), "lvs/vehicles/laat/ballturret_fire.mp3", "lvs/vehicles/laat/ballturret_fire.mp3" )
end

function ENT:OnTick()
	self:HatchControl()
	self:MainGunPoser()
	self:AnimMove()
end

function ENT:BallturretDamage( target, attacker, HitPos, HitDir )
	if not IsValid( target ) or not IsValid( attacker ) then return end

	if target ~= self then
		local dmginfo = DamageInfo()
		dmginfo:SetDamage( 1500 * FrameTime() )
		dmginfo:SetAttacker( attacker )
		dmginfo:SetDamageType( bit.bor( DMG_SHOCK, DMG_ENERGYBEAM ) )
		dmginfo:SetInflictor( self ) 
		dmginfo:SetDamagePosition( HitPos ) 
		dmginfo:SetDamageForce( HitDir * 20000 ) 
		target:TakeDamageInfo( dmginfo )
	end
end

function ENT:GetAimAngles()
	local trace = self:GetEyeTrace()

	local AimAnglesR = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld( Vector(-96.6,58.36,44.34) )):GetNormalized():Angle() )
	local AimAnglesL = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld( Vector(-96.6,-58.36,44.34) ) ):GetNormalized():Angle() )

	return AimAnglesR, AimAnglesL
end

function ENT:MainGunPoser()

	local AimAnglesR, AimAnglesL = self:GetAimAngles()

	self:SetPoseParameter("sidegun_pitch", AimAnglesL.p )
	self:SetPoseParameter("sidegun_left_yaw", AimAnglesL.y )
	self:SetPoseParameter("sidegun_right_yaw", AimAnglesR.y )

	if self:GetBodygroup(1) == 0 then
		self:SetPoseParameter("cannon_pitch", 0 )
		self:SetPoseParameter("cannon_yaw", 0 )

		self:SetBTLFire( false )
	else
		local pod = self:GetGunnerSeat()
		local gunner = pod:GetDriver()
		if IsValid(gunner) then
			local EyeAngles = pod:WorldToLocalAngles( gunner:EyeAngles() )

			local _,LocalAng = WorldToLocal( Vector(0,0,0), EyeAngles, Vector(0,0,0), self:LocalToWorldAngles( Angle(0,0,0)  ) )

			self:SetPoseParameter("cannon_pitch", LocalAng.p )
			self:SetPoseParameter("cannon_yaw", LocalAng.y )
		end
	end
	
end

function ENT:HatchControl()
	local gunners = self:GetGunnerSeat()
	local HasTurret = IsValid( gunners:GetDriver() )

	local Rate = FrameTime() * 5
	self.smHatch = self.smHatch and self.smHatch + math.Clamp((HasTurret and 1 or 0) - self.smHatch,-Rate,Rate) or 0

	if not HasTurret and self.smHatch > 0.7 then self.smHatch = 0.7 end

	self:SetPoseParameter( "open_hatch", self.smHatch )
end


function ENT:OnVehicleSpecificToggled()
	local Driver = self:GetDriver()
	
	if not IsValid( Driver ) then return end
	
	
	local DoorMode = self:GetDoorMode() + 1

	self:SetDoorMode( DoorMode )
				
	if DoorMode == 1 then
		self:PlayAnimation( "rocket_hatch_open" )
		self:EmitSound( "TX_ROCKETPODS_RAISE" )
	end
				
	if DoorMode >= 2 then
		self:PlayAnimation( "rocket_hatch_close" )
		self:EmitSound( "TX_ROCKETPODS_LOWER" )
		self:SetDoorMode( 0 )
	end
	
end

--[[
function ENT:DriveAnim()
	if not self:GetEngineActive() then return end
	local driver = self:GetDriver()
	if IsValid(driver) then
		if self:GetAI() == false then
			if driver:KeyDown( 16 ) == true then 
				self.targetpos = 15
			elseif driver:KeyDown( 8 ) == true then 
				self.targetpos = -15
				if driver:KeyDown( 131072 ) == true then 
					self.targetpos = -20
				end
			else
				self.targetpos = 0
			end
			if driver:KeyDown( 512 ) == true then 
				self.targetposlr = -15
				if driver:KeyDown( 131072 ) == true then 
					self.targetposlr = -25
				end
			elseif driver:KeyDown( 1024 ) == true then 
				self.targetposlr = 15
				if driver:KeyDown( 131072 ) == true then 
					self.targetposlr = 25
				end
			else
				self.targetposlr = 0
			end
		end
	end

	if self.targetpos > self.curpos then 
		self:SetPoseParameter("move_x", self.curpos )
		self.curpos = self.curpos + 0.1
	elseif self.targetpos < self.curpos then 
		self:SetPoseParameter("move_x", self.curpos )
		self.curpos = self.curpos - 0.1
	end
	if self.targetposlr > self.curposlr then 
		self:SetPoseParameter("move_y", self.curposlr )
		self.curposlr = self.curposlr + 0.1
	elseif self.targetposlr < self.curposlr then 
		self:SetPoseParameter("move_y", self.curposlr )
		self.curposlr = self.curposlr - 0.1
	end
end
]]

function ENT:AnimMove()
	local phys = self:GetPhysicsObject()

	if not IsValid( phys ) then return end

	local steer = phys:GetAngleVelocity().z

	local VelL = self:WorldToLocal( self:GetPos() + self:GetVelocity() / 1.2 )  

	self:SetPoseParameter( "move_x", math.Clamp(-VelL.x / self.MaxVelocityX,-1,1) )
	self:SetPoseParameter( "move_y", math.Clamp(-VelL.y / self.MaxVelocityY + steer / 100,-1,1) )
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
