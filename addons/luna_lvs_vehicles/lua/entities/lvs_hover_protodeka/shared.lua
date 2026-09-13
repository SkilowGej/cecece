--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


ENT.Base = "lvs_base_fakehover"

ENT.PrintName = "Protodeka Hovertank"
ENT.Author = "Salty"
ENT.Information = "Null"
ENT.Category = "[LVS] - Star Wars"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/salty/protodeka-boss.mdl"
ENT.GibModels = {
	"models/gibs/helicopter_brokenpiece_01.mdl",
	"models/gibs/helicopter_brokenpiece_02.mdl",
	"models/gibs/helicopter_brokenpiece_03.mdl",
	"models/combine_apc_destroyed_gib02.mdl",
	"models/combine_apc_destroyed_gib04.mdl",
	"models/combine_apc_destroyed_gib05.mdl",
	"models/props_c17/trappropeller_engine.mdl",
	"models/gibs/airboat_broken_engine.mdl",
	"models/salty/protodeka-boss.mdl"
}

ENT.AITEAM = 1

ENT.MaxHealth = 11100
ENT.MaxShield = 1200

ENT.ForceAngleMultiplier = 2
ENT.ForceAngleDampingMultiplier = 1

ENT.ForceLinearMultiplier = 1
ENT.ForceLinearRate = 0.25

ENT.MaxVelocityX = 500
ENT.MaxVelocityY = 500

ENT.MaxTurnRate = 0.7

ENT.BoostAddVelocityX = 135
ENT.BoostAddVelocityY = 135

ENT.GroundTraceHitWater = true
ENT.GroundTraceLength = 50
ENT.GroundTraceHull = 100

ENT.LAATC_PICKUPABLE = false
ENT.LAATC_DROP_IN_AIR = false

function ENT:GetAimAngles()
	local trace = self:GetEyeTrace()

	local AimAnglesR = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld( Vector(-452,-192,90) ) ):GetNormalized():Angle() )
	local AimAnglesL = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld( Vector(-452,192,90) ) ):GetNormalized():Angle() )

	return AimAnglesR, AimAnglesL
end

function ENT:WeaponsInRange()


	local AimAnglesR, AimAnglesL = self:GetAimAngles()

	return not ((AimAnglesR.p >= 25 and AimAnglesL.p >= 25) or (AimAnglesR.p <= -45 and AimAnglesL.p <= -45) or (math.abs(AimAnglesL.y) + math.abs(AimAnglesL.y)) >= 45)
end

	local COLOR_RED = Color(255,0,0,255)
	local COLOR_WHITE = Color(255,255,255,255)
	
function ENT:InitWeapons()
	local weapon = {}
	weapon.Icon = Material("lvs/weapons/hmg.png")
	weapon.Delay = 0.12
	weapon.HeatRateUp = 0.15
	weapon.HeatRateDown = 0.50
	weapon.Attack = function( ent )
        if not ent:GetVehicle():WeaponsInRange( ent ) then return true end
		local pod = ent:GetDriverSeat()

		if not IsValid( pod ) then return end

		local dir = ent:GetAimVector()
		
		if ent:AngleBetweenNormal( dir, ent:GetForward() ) > 45 then return true end

		local trace = ent:GetEyeTrace()

		ent.SwapTopBottom = not ent.SwapTopBottom

		local veh = ent:GetVehicle()

		ent.PrimarySND:PlayOnce( 85 + math.cos( CurTime() + self:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )
		
		local bullet = {}
		bullet.Src = veh:LocalToWorld( ent.SwapTopBottom and Vector(568.3,-139.38,244.93) or Vector(568.3,139.38,244.93) )
		bullet.Dir = (trace.HitPos - bullet.Src):GetNormalized()
		bullet.Spread 	= Vector( 0.001,  0.001, 0.001 )
		bullet.TracerName = "lvs_laser_red"
		bullet.Force	= 10
		bullet.HullSize 	= 25
		bullet.Damage	= 55
		bullet.SplashDamage = 50
		bullet.SplashDamageRadius = 50
		bullet.Velocity = 30000
		bullet.Attacker 	= ent:GetDriver()
		bullet.Callback = function(att, tr, dmginfo)
			local effectdata = EffectData()
				effectdata:SetStart( Vector(255, 0, 0) ) 
				effectdata:SetOrigin( tr.HitPos )
				effectdata:SetNormal( tr.HitNormal )
			util.Effect( "lvs_laser_explosion_aat", effectdata )
		end
		ent:LVSFireBullet( bullet )
	end
	weapon.OnSelect = function( ent )
		ent:EmitSound("physics/metal/weapon_impact_soft3.wav")
	end
	weapon.OnOverheat = function( ent )
		ent:EmitSound("lvs/overheat.wav")
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local Col = (ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > 45) and COLOR_RED or COLOR_WHITE

		local Pos2D = ent:GetEyeTrace().HitPos:ToScreen() 

		local base = ent:GetVehicle()
		base:PaintCrosshairCenter( Pos2D, Col )
		base:PaintCrosshairOuter( Pos2D, Col )
		base:LVSPaintHitMarker( Pos2D )
		end
	weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav") end
	weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	self:AddWeapon( weapon )

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/missile.png")
	weapon.Ammo = 100
	weapon.Delay = 1
	weapon.HeatRateUp = 0
	weapon.HeatRateDown = 1
	weapon.Attack = function( ent )
		if not ent:WeaponsInRange() then return true end

		local Driver = ent:GetDriver()

		local MissileAttach = {
			[1] = {
				left = "rocket_pod_l_12",
				right = "rocket_pod_r_12"
			},
			[2] = {
				left = "rocket_pod_l_2",
				right = "rocket_pod_r_2"
			},
			[3] = {
				left = "rocket_pod_l_3",
				right = "rocket_pod_r_3"
			},
		}

		for i = 1, 3 do
			timer.Simple( (i / 5) * 0.75, function()
				if not IsValid( ent ) then return end

				if ent:GetAmmo() <= 0 then ent:SetHeat( 0.03 ) return end

				local ID_L = ent:LookupAttachment( "rocket_pod_l_11" )
				local ID_R = ent:LookupAttachment( "rocket_pod_r_11" )
				local MuzzleL = ent:GetAttachment( ID_L )
				local MuzzleR = ent:GetAttachment( ID_R )

				if not MuzzleL or not MuzzleR then return end

				local swap = false

				for i = 1, 2 do
					local Pos = swap and MuzzleL.Pos or MuzzleR.Pos
					local Start = Pos + ent:GetForward() * 50
					local Dir = (ent:GetEyeTrace().HitPos - Start):GetNormalized()
					if not ent:WeaponsInRange() then
						Dir = swap and MuzzleL.Ang:Up() or MuzzleR.Ang:Up()
					end

					local projectile = ents.Create( "lvs_concussionmissile" )
					projectile:SetPos( Start )
					projectile:SetAngles( Dir:Angle() )
					projectile:SetParent( ent )
					projectile:Spawn()
					projectile:Activate()
					projectile.GetTarget = function( missile ) return missile end
					projectile.GetTargetPos = function( missile )
						return missile:LocalToWorld( Vector(150,0,0) + VectorRand() * math.random(-10,10) )
					end
					projectile:SetAttacker( IsValid( Driver ) and Driver or self )
					projectile:SetEntityFilter( ent:GetCrosshairFilterEnts() )
					projectile:SetSpeed( 4500 )
					projectile:SetDamage( 300 )
					projectile:SetRadius( 150 )
					projectile:Enable()
					projectile:EmitSound( "LVS.PROTO.FIRE_MISSILE" )

					ent:TakeAmmo( 1 )

					swap = true
				end
			end)
		end

		ent:SetHeat( 1 )
		ent:SetOverheated( true )
	end
	weapon.OnSelect = function( ent )
		ent:EmitSound("weapons/shotgun/shotgun_cock.wav")
	end
	self:AddWeapon( weapon )
end

ENT.EngineSounds = {
	{
		sound = "protodeka/protodeka_lp_1.wav",
		Pitch = 100,
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
		sound = "lvs/vehicles/iftx/dist.wav",
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
	name = "LVS.PROTO.FIRE_MISSILE",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 125,
	pitch = {95, 105},
	sound = "protodeka/medium_rocket_fire.wav"
} )


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
