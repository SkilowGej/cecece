--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


ENT.Base = "lvs_base_fakehover"

ENT.PrintName = "TX-210 ISTr 'Stalwart'"
ENT.Author = "EOJ"
ENT.Category = "[LVS] - EOJ"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/eoj/lfs_vehicles/tx210ist.mdl"
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

ENT.MaxHealth = 15000

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
		self:SetPoseParameter("left_gun_pitch", 0 )

		self:SetPoseParameter("right_gun_pitch", 0 )
		
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
	local COLOR_RED = Color(255,0,0,255)
	local COLOR_WHITE = Color(255,255,255,255)
	self.RearGunAngleRange = 35

	self.DualGunAngleRange = 20
	local COLOR_RED = Color(255,0,0,255)
	local COLOR_WHITE = Color(255,255,255,255)
	local weapon = {}
	weapon.Icon = Material("lvs/weapons/dual_mg.png")
	weapon.Ammo = -1
	weapon.Delay = 0.4
	weapon.HeatRateUp = 0.3
	weapon.HeatRateDown = 1
	weapon.Attack = function( ent )
		local pod = ent:GetDriverSeat()

		if not IsValid( pod ) then return end

		if ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) >= 20 then return true end

		local startpos = pod:LocalToWorld( pod:OBBCenter() )
		local trace = ent:GetEyeTrace()
	
		self:EmitSound( "lvs/slavei/blaster2w.wav" )
		local bullet = {}
		bullet.Spread 	= Vector( 0.01,  0.01, 0.01 )
		bullet.TracerName = "lvs_laser_green_short"
		bullet.Force	= 2
		bullet.HullSize 	= 10
		bullet.Damage	= 200
		bullet.SplashDamage = 150
		bullet.SplashDamageRadius = 150
		bullet.Velocity = 40000
		bullet.Attacker 	= ent:GetDriver()
		bullet.Callback = function(att, tr, dmginfo)
			local effectdata = EffectData()
				effectdata:SetStart( Vector(50,255,50) ) 
				effectdata:SetOrigin( tr.HitPos )
				effectdata:SetNormal( tr.HitNormal )
			util.Effect( "lvs_laser_impact", effectdata )
		end
		
		for i = -1,1,2 do
			bullet.Src 	= ent:LocalToWorld( Vector(100,8 * i,20) )
			bullet.Dir 	= (trace.HitPos - bullet.Src):GetNormalized()
			local effectdata = EffectData()
			effectdata:SetStart( Vector(50,255,50) )
			effectdata:SetOrigin( bullet.Src )
			effectdata:SetNormal( ent:GetForward() )
			effectdata:SetEntity( ent )
			util.Effect( "lvs_muzzle_colorable", effectdata )
			
			ent:LVSFireBullet( bullet )
		end

		ent:TakeAmmo()

		ent.SNDLeft:PlayOnce( 100 + math.cos( CurTime() + ent:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )
	end
	weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav") end
	weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	weapon.HudPaint = function( ent, X, Y, ply )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		local RearGunInRange = ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > base.DualGunAngleRange

		local Col = RearGunInRange and COLOR_RED or COLOR_WHITE

		local Pos2D = ent:GetEyeTrace().HitPos:ToScreen() 

		base:PaintCrosshairCenter( Pos2D, Col )
		--base:PaintCrosshairOuter( Pos2D, Col )
		base:LVSPaintHitMarker( Pos2D )
	end
	self:AddWeapon( weapon )

	
	self.EmpGunAngleRange = 40
	self.RearGunAngleRange = 70
-- emplacement cannons
	local weapon = {}
	weapon.Icon = Material("lvs/weapons/hmg.png")
	weapon.Ammo = -1
	weapon.Delay = 1
	weapon.HeatRateUp = 0.4
	weapon.HeatRateDown = 0.6
	weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	weapon.Attack = function( ent )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		if ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > base.EmpGunAngleRange then return true end

		local trace = ent:GetEyeTrace()

		local Pos,Ang = WorldToLocal( Vector(0,0,0), (trace.HitPos - self:LocalToWorld( Vector(-400,0,158.5)) ):GetNormalized():Angle(), Vector(0,0,0), self:LocalToWorldAngles( Angle(0,180,0) ) )

		if not IsValid( ent ) then return end
		ent:TakeAmmo()

		local mru = self:LookupAttachment( "muzzle_bottom_left" ) 
		local RightMuzzleUp = self:GetAttachment(mru)
		local mrd = self:LookupAttachment( "muzzle_bottom_right" ) 
		local RightMuzzleDown = self:GetAttachment(mrd)

		local mlu = self:LookupAttachment( "muzzle_top_left" ) 
		local LeftMuzzleUp = self:GetAttachment(mlu)
		local mld = self:LookupAttachment( "muzzle_top_right" ) 
		local LeftMuzzleDown = self:GetAttachment(mld)

		if not RightMuzzleUp or not RightMuzzleDown or not LeftMuzzleUp or not LeftMuzzleDown then return end
		local muzzles = { RightMuzzleUp, LeftMuzzleUp, RightMuzzleDown, LeftMuzzleDown }
	--	self:EmitSound( "tx225/fire2.wav" )

		self:EmitSound( "lvs/slavei/atstw.wav" )
		for i, muzzle in ipairs( muzzles ) do
			local bullet = {}
			bullet.Src 	= muzzle.Pos
			bullet.Dir 	= (trace.HitPos - muzzle.Pos):GetNormalized()
			bullet.Spread 	= Vector( 0.045,  0.045, 0.045 )
			bullet.TracerName = "lvs_laser_green"
			bullet.Force	= 500
			bullet.HullSize 	= 5
			bullet.Damage	= 2000
			bullet.SplashDamage = 200
			bullet.SplashDamageRadius = 200
			bullet.Velocity = 40000
			bullet.Attacker 	= ent:GetDriver()
			bullet.Callback = function(att, tr, dmginfo)
				local effectdata = EffectData()
					effectdata:SetOrigin( tr.HitPos )
					effectdata:SetNormal( tr.HitNormal )
				util.Effect( "lfs_tx-427_main_explosion_green", effectdata )
			end
			ent:LVSFireBullet( bullet )
		end
		ent:TakeAmmo()
		ent.SNDAA:PlayOnce( 100 + math.cos( CurTime() + ent:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )

		local base = ent:GetVehicle()
		local PhysObj = base:GetPhysicsObject()
		if IsValid( PhysObj ) then
		PhysObj:ApplyForceOffset( PhysObj:LocalToWorldVector(Vector(40,0,20)) * -25, Vector(40,0,20) )
		end
	end

	weapon.OnThink = function( ent, active )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		

		local trace = ent:GetEyeTrace()

        local _,AimAnglesR = WorldToLocal(Vector(0,0,0),(trace.HitPos - self:LocalToWorld( Vector( 0,0,0)) ):GetNormalized():Angle(), Vector(0,0,0), self:LocalToWorldAngles( Angle(0,0,0) ) )

		base:SetPoseParameter("sidegun_pitch", AimAnglesR.p )
		
	end

	weapon.HudPaint = function( ent, X, Y, ply )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		local RearGunInRange = ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > base.EmpGunAngleRange

		local Col = RearGunInRange and COLOR_RED or COLOR_WHITE

		local Pos2D = ent:GetEyeTrace().HitPos:ToScreen() 

		--base:PaintCrosshairCenter( Pos2D, Col )
		base:PaintCrosshairOuter( Pos2D, Col )
		base:LVSPaintHitMarker( Pos2D )
	end
	weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav") end
	weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	self:AddWeapon( weapon )

	local weapon = {}
		weapon.Icon = Material("lvs/weapons/mg.png")
		weapon.Ammo = -1
		weapon.Delay = 0.07
		weapon.HeatRateUp = 0.3
		weapon.HeatRateDown = 0.4
		weapon.Attack = function ( ent )
			
			local pod = ent:GetDriverSeat()
			
			if not IsValid( pod ) then return end
			
			if ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) >= 40 then return true end
			
			local startpos = pod:LocalToWorld( pod:OBBCenter() )
			local trace = ent:GetEyeTrace()
			
			self:EmitSound( "lvs/slavei/mgshoot.wav" )

			local bullet = {}
			bullet.Src 	= ent:LocalToWorld( Vector(50,0,-8) )
			bullet.Dir = (trace.HitPos - bullet.Src):GetNormalized()
			bullet.Spread 	= Vector( 0.01,  0.01, 0.01 )
			bullet.TracerName = "lvs_laser_red"
			bullet.Force	= 100
			bullet.HullSize 	= 1
			bullet.Damage	= 16
			bullet.Velocity = 40000
			bullet.Attacker 	= ent:GetDriver()
			bullet.Callback = function(att, tr, dmginfo)
				local effectdata = EffectData()
					effectdata:SetStart( Vector(255,50,50) ) 
					effectdata:SetOrigin( tr.HitPos )
					effectdata:SetNormal( tr.HitNormal )
				util.Effect( "lvs_laser_impact", effectdata )
			end
			ent:LVSFireBullet( bullet )

			ent:TakeAmmo()
			local base = ent:GetVehicle()
		local PhysObj = base:GetPhysicsObject()
		if IsValid( PhysObj ) then
		PhysObj:ApplyForceOffset( PhysObj:LocalToWorldVector(Vector(40,0,20)) * -25, Vector(40,0,20) )
		end

		end
		weapon.OnThink = function( ent, active )
			local base = ent:GetVehicle()
	
			if not IsValid( base ) then return end
	
			local trace = ent:GetEyeTrace()
	
			local _,AimAnglesR = WorldToLocal(Vector(0,0,0),(trace.HitPos - self:LocalToWorld( Vector( 0,-20,0)) ):GetNormalized():Angle(), Vector(0,-20,0), self:LocalToWorldAngles( Angle(0,0,0) ) )
	
		end
		weapon.HudPaint = function( ent, X, Y, ply )
			local Col = (ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > 40) and COLOR_RED or COLOR_WHITE
	
			local Pos2D = ent:GetEyeTrace().HitPos:ToScreen() 
			local Pos2D2 = ent:GetEyeTrace().HitPos:ToScreen() 
			local Pos2D3 = ent:GetEyeTrace().HitPos:ToScreen() 
	
			local base = ent:GetVehicle()
			--base:PaintCrosshairCenter( Pos2D, Col )
			--base:PaintCrosshairMiddle( Pos2D3, Col )
			base:PaintCrosshairOuter( Pos2D2, Col )
			base:LVSPaintHitMarker( Pos2D )
		end
		self:AddWeapon( weapon, 3)

	self:InitTurret()
end

ENT.EngineSounds = {
	{
		sound = "niksacokica/tx-427/engine_loopnew.wav",
		Pitch 			= 100,
		PitchMin 		= 90,
		PitchMax 		= 90,
		PitchMul 		= 40,
		FadeIn 			= 0,
		FadeOut 		= 0,
		FadeSpeed 		= 1.2,
		UseDoppler 		= true,
		SoundLevel 		= 100,
	},
	{
		sound = "niksacokica/tx-427/engine_loopnew.wav",
		Pitch = 95,
		PitchMin = 95,
		PitchMax = 255,
		PitchMul = 30,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.2,
		UseDoppler = true,
		SoundLevel = 100,
	},
	{
		sound = "niksacokica/tx-427/engine_loopnew.wav",
		Pitch = 100,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 30,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.2,
		SoundLevel = 100,
	},
}


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
