--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_ikfunctions.lua" )
AddCSLuaFile( "cl_camera.lua" )
AddCSLuaFile( "cl_legs.lua" )
AddCSLuaFile( "cl_prediction.lua" )
AddCSLuaFile( "sh_turret.lua" )
AddCSLuaFile( "sh_gunner.lua")
include("shared.lua")
include("sv_ragdoll.lua")
include("sv_controls.lua")
include("sv_contraption.lua")
include("sv_ai.lua")
include("sh_turret.lua")
include("sh_gunner.lua")

ENT.SpawnNormalOffset = 0
ENT.SpawnNormalOffsetSpawner = 0

function ENT:OnSpawn( PObj )
	PObj:SetMass( 10000 )

	self:SetCannonMode(0)
	self:SetDriverGunAngles(0)

	local DriverSeat = self:AddDriverSeat( Vector(0,0,238), Angle(0,-90,0) )
	DriverSeat.HidePlayer = true
	DriverSeat:SetCameraDistance( 0.05 )
	DriverSeat.ExitPos =  Vector(0,50,338)
	-- DriverSeat.PlaceBehindVelocity = 1000

	self.SNDPrimary = self:AddSoundEmitter( Vector(100,0,168), "lvs/vehicles/atte/fire.mp3", "lvs/vehicles/atte/fire.mp3" )
	self.SNDPrimary:SetSoundLevel( 110 )

	self.SNDPrimaryTurret = self:AddSoundEmitter( Vector(150,0,248), "lvs/vehicles/atte/fire_turret.mp3", "lvs/vehicles/atte/fire_turret.mp3" )
	self.SNDPrimaryTurret:SetSoundLevel( 110 )

	self.SNDTurret = self:AddSoundEmitter( Vector(45,0,300), "lvs/vehicles/atte/fire_turret.mp3", "lvs/vehicles/atte/fire_turret.mp3" )
	self.SNDTurret:SetSoundLevel( 110 )

	local TurretSeat = self:AddPassengerSeat( Vector(-50,0,300), Angle(0,-90,0) )
	TurretSeat.HidePlayer = true
	TurretSeat.PlaceBehindVelocity = 1000
	self:SetTurretSeat( TurretSeat )

	local ID = self:LookupAttachment( "gunT" )
	local Attachment = self:GetAttachment( ID )

	if Attachment then
		local Pos,Ang = LocalToWorld( Vector(0,-5,8), Angle(180,0,0), Attachment.Pos, Attachment.Ang )

		TurretSeat:SetParent( NULL )
		TurretSeat:SetPos( Pos )
		TurretSeat:SetAngles( Ang )
		TurretSeat:SetParent( self )
		TurretSeat.ExitPos =   Vector(-80,0,300)
	end

	-- self:BecomeRagdoll()

	-- armor protecting the weakspot
	self:AddDSArmor( {
		pos = Vector(00,0,250),
		ang = Angle(0,0,0),
		mins = Vector(-60,-110,-80),
		maxs =  Vector(110,110,30),
		Callback = function( tbl, ent, dmginfo )
			-- dont do anything, just prevent it from hitting the critical spot
		end
	} )

	-- -- weak spots
	self:AddDS( {
		pos = Vector(-110,0,200),
		ang = Angle(0,0,0),
		mins = Vector(-50,-50,-25),
		maxs =  Vector(50,50,75),
		Callback = function( tbl, ent, dmginfo )
			if dmginfo:GetDamage() <= 0 then return end

			dmginfo:ScaleDamage( 2 )

			if ent:GetHP() > 4000 or ent:GetIsRagdoll() then return end

			ent:BecomeRagdoll()

			local effectdata = EffectData()
				effectdata:SetOrigin( ent:LocalToWorld( Vector(0,0,80) ) )
			util.Effect( "lvs_explosion_nodebris", effectdata )
		end
	} )

	
end

function ENT:InitRear()
	if IsValid( self:GetRearEntity() ) then return end

	local ent = ents.Create( "lvs_walker_atte_rear" )

	if not IsValid( ent ) then
		self:Remove()

		print("LVS: couldn't create 'lvs_atte_rear'. Vehicle terminated.")

		return
	end

	self:SetRearEntity( ent )

	ent:SetPos( self:GetPos() + self:GetForward() * 55 )
	ent:SetAngles( self:GetAngles() )
	ent:SetBase( self )
	ent:Spawn()
	ent:Activate()
	ent:DeleteOnRemove( self )
	ent:SetNoDraw(true)
	ent:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	self:DeleteOnRemove( ent )
	self:TransferCPPI( ent )

	local rPObj = ent:GetPhysicsObject()

	if not IsValid( rPObj ) then 
		self:Remove()

		print("LVS: missing model. Vehicle terminated.")

		return
	end

	rPObj:SetMass( 5000 ) 

	-- local Friction = 0
	local ballsocket = constraint.AdvBallsocket(ent, self,0,0,Vector(35,0,228),Vector(35,0,228),0,0, -1, -1, -1, 1, 1, 1, Friction, Friction, Friction, 0, 1)
	ballsocket:DeleteOnRemove( self )
	ballsocket:DeleteOnRemove( ent )
	self:TransferCPPI( ballsocket )

	self:AddToMotionController( rPObj )

	self.SNDRear = self:AddSoundEmitter( Vector(0,0,0), "lvs/vehicles/atte/fire.mp3", "lvs/vehicles/atte/fire.mp3" )
	self.SNDRear:SetSoundLevel( 110 )

	self.SNDRear:SetParent( NULL )
	self.SNDRear:SetPos( ent:LocalToWorld( Vector(-245,0,165) ) )
	self.SNDRear:SetParent( ent )

	-- clear the filters, because they might have been build by now
	self.CrosshairFilterEnts = nil
	self._EntityLookUp = nil
end

function ENT:OnTick()
	-- self:InitRear() -- this fixes a gmod bug
	self:ContraptionThink()

	-- if (self.KnockBack) and (self.KnockbackAnim < 1) then
	-- 	self.KnockbackAnim = math.Clamp(self.KnockbackAnim + 1 * FrameTime(), 0, 1)

	-- 	if (self.KnockbackAnim >= 1) then
	-- 		self.KnockBack = false
	-- 		self.KnockbackAnim = 0
	-- 	end

	-- 	self:SetAngles(self:GetAngles() + Angle(self.KnockbackAnim,0,0))
	-- end

	-- print(self:GetAngles(), self.OldAngle)

	-- 	self.KnockbackAnim = math.Clamp(self.KnockbackAnim + 5 * FrameTime(), 0, 1)

	-- 	if (self.KnockbackAnim >= 0.9) then
	-- 		self.KnockBack = false
	-- 	end

	-- 	-- self:SetAngles(self:GetAngles() - Angle(self.KnockbackAnim,0,0))

	-- elseif (self.KnockbackAnim > 0) then

	-- 	self.KnockbackAnim = math.Clamp(self.KnockbackAnim - 5 * FrameTime(), 0, 5)

	-- 	self:SetAngles(self:GetAngles() + Angle(self.KnockbackAnim,0,0))

	-- end
	-- print(self:GetAngles())
end

function ENT:OnMaintenance()
	self:UnRagdoll()
end

function ENT:OnLegsChanged()

	local FirstWep = self.WEAPONS[1][1]

	if (self:GetCannonMode() == 1) then

		self:SetTargetSpeed(0)
		self:SetTargetSteer(0)

		-- self:ManipulateBoneAngles(1,Angle(0,0,0))

	else
		-- self:ManipulateBoneAngles(3,Angle(0,0,0))
	end

	self:ApproachTargetSpeed(700)

	timer.Simple(0.6, function()
		if (!self) or (!IsValid(self)) then return end
		self:SetTargetSpeed(0)
		self:SetTargetSteer(0)
	end)

end

function ENT:AlignView( ply, SetZero )
	if not IsValid( ply ) then return end

	timer.Simple( 0, function()
		if not IsValid( ply ) or not IsValid( self ) then return end

		ply:SetEyeAngles( Angle(0,90,0) )
	end)
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
