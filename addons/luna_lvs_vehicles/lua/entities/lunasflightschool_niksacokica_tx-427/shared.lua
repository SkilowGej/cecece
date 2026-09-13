--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


ENT.Base = "lvs_base_fakehover"

ENT.PrintName = "TX-427 [Republic Variant]"
ENT.Author = "kavtehman and xn"
ENT.Category = "[LVS] - Orbital Vehicles"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/lfs_vehicles/tx427/tx427_static.mdl"
ENT.GibModels = {
	"models/gibs/helicopter_brokenpiece_01.mdl",
	"models/gibs/helicopter_brokenpiece_02.mdl",
	"models/gibs/helicopter_brokenpiece_03.mdl",
	"models/combine_apc_destroyed_gib02.mdl",
	"models/combine_apc_destroyed_gib04.mdl",
	"models/combine_apc_destroyed_gib05.mdl",
	"models/props_c17/trappropeller_engine.mdl",
	"models/gibs/airboat_broken_engine.mdl",
}

ENT.AITEAM = 2

ENT.MaxHealth = 20000

ENT.ForceAngleMultiplier = 2
ENT.ForceAngleDampingMultiplier = 1

ENT.ForceLinearMultiplier = 1
ENT.ForceLinearRate = 0.25

ENT.MaxVelocityX = 250
ENT.MaxVelocityY = 180

ENT.MaxTurnRate = 0.5

ENT.BoostAddVelocityX = 120
ENT.BoostAddVelocityY = 120

ENT.GroundTraceHitWater = true
ENT.GroundTraceLength = 50
ENT.GroundTraceHull = 100

ENT.TurretTurnRate = 100

ENT.RotorPos = Vector(-130, 0, 100)

ENT.LAATC_PICKUPABLE = true
ENT.LAATC_DROP_IN_AIR = true
ENT.LAATC_PICKUP_POS = Vector(-200,0,25)
ENT.LAATC_PICKUP_Angle = Angle(0,0,0)

function ENT:OnSetupDataTables()
	self:AddDT( "Bool", "IsCarried" )
	self:AddDT( "Entity", "GunnerSeat" )
	self:AddDT( "Entity", "CoDriver" )
	self:AddDT( "Entity", "CoSeat" )
	self:AddDT( "Float", "TurretPitch" )
	self:AddDT( "Float", "TurretYaw" )
	self:AddDT( "Bool", "SpotlightToggle" )

	if SERVER then
		self:NetworkVarNotify( "IsCarried", self.OnIsCarried )
	end
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

function ENT:GetEyeTrace()
	local startpos = self:GetPos()

	local pod = self:GetDriverSeat()

	if IsValid( pod ) then
		startpos = pod:LocalToWorld( Vector(0,0,33) )
	end

	local trace = util.TraceLine( {
		start = startpos,
		endpos = (startpos + self:GetAimVector() * 50000),
		filter = self:GetCrosshairFilterEnts()
	} )

	return trace
end

function ENT:GetAimAngles()
	local trace = self:GetEyeTrace()

	local AimAnglesR = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld( Vector(10,-60,81) ) ):GetNormalized():Angle() )
	local AimAnglesL = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld( Vector(10,60,81) ) ):GetNormalized():Angle() )

	return AimAnglesR, AimAnglesL
end

function ENT:WeaponsInRange()
	if self:GetIsCarried() then return false end

	local AimAnglesR, AimAnglesL = self:GetAimAngles()

	return not ((AimAnglesR.p >= 70 and AimAnglesL.p >= 70) or (AimAnglesR.p <= -75 and AimAnglesL.p <= -75) or (math.abs(AimAnglesL.y) + math.abs(AimAnglesL.y)) >= 180)
end

function ENT:InitWeapons()
	self.RearGunAngleRange = 180
	local weapon = {}
	weapon.Icon = Material("lvs/weapons/missile.png")
	weapon.Ammo = 80
	weapon.Delay = 0.5
	weapon.HeatRateUp = 0.4
	weapon.HeatRateDown = 0.5
	weapon.Attack = function( ent )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		if ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > base.RearGunAngleRange then return true end
		
		local trace = ent:GetEyeTrace()

		local Pos,Ang = WorldToLocal( Vector(0,0,0), (trace.HitPos - self:LocalToWorld( Vector(-400,0,158.5)) ):GetNormalized():Angle(), Vector(0,0,0), self:LocalToWorldAngles( Angle(0,180,0) ) )

		if not IsValid( ent ) then return end
		ent:TakeAmmo()
		
		local ID1 = self:LookupAttachment("missiles_right_muzzle_12")
		local ID2 = self:LookupAttachment("missiles_left_muzzle_11")
		local Muzzle1 = self:GetAttachment( ID1 )
		local Muzzle2 = self:GetAttachment( ID2 )

		ent.MirrorPrimary = not ent.MirrorPrimary

		local Pos = ent.MirrorPrimary and Muzzle1.Pos or Muzzle2.Pos
		local Dir =  (ent.MirrorPrimary and Muzzle1.Ang or Muzzle2.Ang):Forward()

		local ang1 = (trace.HitPos - Pos):Angle()

		local projectile = ents.Create( "lvs_concussionmissile" )
		projectile:SetPos( Pos )
		projectile:SetAngles( ang1 )
		projectile:SetParent( ent )
		projectile:Spawn()
		projectile:Activate()
		projectile.GetTarget = function( missile ) return missile end
		projectile.GetTargetPos = function( missile )
			return missile:LocalToWorld( Vector(100,0,0) + VectorRand() * math.random(-2,2) )
		end
		projectile:SetAttacker( IsValid( Driver ) and Driver or self )
		projectile:SetEntityFilter( ent:GetCrosshairFilterEnts() )
		projectile:SetSpeed( 10000 )
		projectile:SetDamage( 400 )
		projectile:SetRadius( 300 )
		projectile:Enable()
		projectile:EmitSound( "LVS.IFTX.FIRE_MISSILE" )

		if turretPos == "right" then
			ent.directionTurretPos = "left"
		else
			ent.directionTurretPos = "right"
			if turretXPos == 3 then
				ent.turrentRowPox = 0
				if turretYPos == 3 then
					ent.turrentColumnPos = 0
				else
					ent.turrentColumnPos = turretYPos + 1
				end
			else
			end
		end
	end
	weapon.OnThink = function( ent, active )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		local trace = ent:GetEyeTrace()

        local _,AimAnglesR = WorldToLocal(Vector(0,0,0),(trace.HitPos - self:LocalToWorld( Vector( 0,0,0)) ):GetNormalized():Angle(), Vector(0,0,0), self:LocalToWorldAngles( Angle(0,0,0) ) )


		if ent:GetIsCarried() then
			self:SetPoseParameter("missiles_right_pitch", 0 )
			self:SetPoseParameter("missiles_right_yaw", 0 )

			self:SetPoseParameter("missiles_left_pitch", 0 )
			self:SetPoseParameter("missiles_left_yaw", 0 )

			return
		end

		local AimAnglesR, AimAnglesL = ent:GetAimAngles()

		self:SetPoseParameter("missiles_right_pitch", -AimAnglesR.p )
		self:SetPoseParameter("missiles_right_yaw", -AimAnglesR.y )

		self:SetPoseParameter("missiles_left_pitch", -AimAnglesL.p )
		self:SetPoseParameter("missiles_left_yaw", -AimAnglesL.y )
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local base = ent:GetVehicle()
		
		local RearGunInRange = ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > base.RearGunAngleRange
		
		local Col = RearGunInRange and COLOR_RED or COLOR_WHITE
		
		local Pos2D = ent:GetEyeTrace().HitPos:ToScreen()
		
		base:PaintCrosshairCenter( Pos2D, Col )
		base:PaintCrosshairOuter( Pos2D, Col )
		base:LVSPaintHitMarker( Pos2D )
	end
	self:AddWeapon( weapon )


	local COLOR_RED = Color(255,0,0,255)
	local COLOR_WHITE = Color(255,255,255,255)
	self.RearGunAngleRange = 35

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/hmg.png")
	weapon.Ammo = -1
	weapon.Delay = 0.4
	weapon.HeatRateUp = 0.01
	weapon.HeatRateDown = 0.04
	weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	weapon.Attack = function( ent )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		if ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > base.RearGunAngleRange then return true end

		local trace = ent:GetEyeTrace()

		local Pos,Ang = WorldToLocal( Vector(0,0,0), (trace.HitPos - self:LocalToWorld( Vector(-400,0,158.5)) ):GetNormalized():Angle(), Vector(0,0,0), self:LocalToWorldAngles( Angle(0,180,0) ) )

		if not IsValid( ent ) then return end
		ent:TakeAmmo()

		local mru = self:LookupAttachment( "blaster_right_muzzle_up" ) 
		local RightMuzzleUp = self:GetAttachment(mru)
		local mrd = self:LookupAttachment( "blaster_right_muzzle_down" ) 
		local RightMuzzleDown = self:GetAttachment(mrd)

		local mlu = self:LookupAttachment( "blaster_left_muzzle_up" ) 
		local LeftMuzzleUp = self:GetAttachment(mlu)
		local mld = self:LookupAttachment( "blaster_left_muzzle_down" ) 
		local LeftMuzzleDown = self:GetAttachment(mld)

		if not RightMuzzleUp or not RightMuzzleDown or not LeftMuzzleUp or not LeftMuzzleDown then return end
		local muzzles = { RightMuzzleUp, LeftMuzzleUp, RightMuzzleDown, LeftMuzzleDown }
		self:EmitSound( "niksacokica/tx-427/cannon_small.wav" )

		for i, muzzle in ipairs( muzzles ) do
			local bullet = {}
			bullet.Src 	= muzzle.Pos
			bullet.Dir 	= (trace.HitPos - muzzle.Pos):GetNormalized()
			bullet.Spread 	= Vector( 0.015,  0.015, 0.01 )
			bullet.TracerName = "lvs_laser_blue"
			bullet.Force	= 100
			bullet.HullSize 	= 1
			bullet.Damage	= 36
			bullet.Velocity = 40000
			bullet.Attacker 	= ent:GetDriver()
			bullet.Callback = function(att, tr, dmginfo)
				local effectdata = EffectData()
					effectdata:SetStart( Vector(50,50,255) ) 
					effectdata:SetOrigin( tr.HitPos )
					effectdata:SetNormal( tr.HitNormal )
				util.Effect( "lvs_laser_impact", effectdata )
			end
			ent:LVSFireBullet( bullet )
		end
		
		ent:TakeAmmo()

		if ent.MirrorPrimary then
			if not IsValid( ent.SNDLeft ) then return end
			ent.SNDLeft:PlayOnce( 100 + math.cos( CurTime() + ent:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )
			return
		end
		
	end	

	weapon.OnThink = function( ent, active )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		

		local trace = ent:GetEyeTrace()

        local _,AimAnglesR = WorldToLocal(Vector(0,0,0),(trace.HitPos - self:LocalToWorld( Vector(-400,0,158.5)) ):GetNormalized():Angle(), Vector(0,0,0), self:LocalToWorldAngles( Angle(0,0,0) ) )
        local _,AimAnglesL = WorldToLocal(Vector(0,0,0),(trace.HitPos - self:LocalToWorld( Vector(-400,0,158.5)) ):GetNormalized():Angle(), Vector(0,0,0), self:LocalToWorldAngles( Angle(0,0,0) ) )

		base:SetPoseParameter("blasters_right_pitch", -AimAnglesR.p )
		base:SetPoseParameter("blasters_right_yaw",  AimAnglesR.y )

		base:SetPoseParameter("blasters_left_pitch", -AimAnglesL.p )
		base:SetPoseParameter("blasters_left_yaw", AimAnglesL.y )
		
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		local RearGunInRange = ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > base.RearGunAngleRange

		local Col = RearGunInRange and COLOR_RED or COLOR_WHITE

		local Pos2D = ent:GetEyeTrace().HitPos:ToScreen() 

		base:PaintCrosshairCenter( Pos2D, Col )
		base:PaintCrosshairOuter( Pos2D, Col )
		base:LVSPaintHitMarker( Pos2D )
	end
	self:AddWeapon( weapon, 3 )

	self:InitTurret()
end

ENT.EngineSounds = {
	{
		sound = "niksacokica/tx-427/engine_loop.wav",
		Pitch 			= 60,
		PitchMin 		= 20,
		PitchMax 		= 90,
		PitchMul 		= 30,
		FadeIn 			= 0,
		FadeOut 		= 1,
		FadeSpeed 		= 1.5,
		UseDoppler 		= true,
		SoundLevel 		= 105,
	},
	{
		sound = "lvs/vehicles/iftx/loop_hi.wav",
		Pitch = 70,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 30,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		UseDoppler = true,
		SoundLevel = 85,
	},
	{
		sound = "^lvs/vehicles/iftx/dist.wav",
		Pitch = 70,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 30,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		SoundLevel = 90,
	},
}

sound.Add( {
	name = "LVS.IFTX.FIRE_MISSILE",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 125,
	pitch = {95, 105},
	sound = "lvs/vehicles/iftx/fire_missile.mp3"
} )


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
