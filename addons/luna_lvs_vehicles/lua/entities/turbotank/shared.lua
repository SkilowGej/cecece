--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ENT.Type = "anim"
ENT.Base = "lvs_base_fakehover"

ENT.PrintName = "Turbotank / Juggernaut"
ENT.Author = "Dec"
ENT.Information = ""
ENT.Category = "[LVS] SW-Vehicles"

ENT.Spawnable		= true
ENT.AdminSpawnable	= false

ENT.MDL = "models/vehicles/sky/turbotank/turbotank_s.mdl"
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

ENT.MaxVelocityY = 0
ENT.BoostAddVelocityY = 0

ENT.ForceAngleMultiplier = 1
ENT.ForceAngleDampingMultiplier = 1

ENT.ForceLinearMultiplier = 2
ENT.ForceLinearRate = 0.8

ENT.MaxVelocityZ = 0
ENT.BoostAddVelocityZ = 0

ENT.MaxHealth = 18000
ENT.MaxVelocityX = 650
ENT.BoostAddVelocitX = 850
ENT.IgnoreWater = false

ENT.MaxTurnRate = 0.5

ENT.GroundTraceLength = 50
ENT.GroundTraceHull = 100

ENT.Stopturn = false

ENT.AnglGot = false

function ENT:OnSetupDataTables()
	self:AddDT( "Entity", "GunnerSeat" )
	self:AddDT( "Entity", "SecondGunnerSeat" )
	self:AddDT( "Entity", "ThirdGunnerSeat" )
	self:AddDT( "Bool", "SpotlightToggle" )
end


function ENT:GetAimAngles( ent, vers )
    local trace = ent:GetEyeTrace()
	local AimAngles
	if vers == 1 then
    	AimAngles = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld(Vector(55.63,-1.86,320.27))):GetNormalized():Angle() )
	elseif vers == 2 then
		AimAngles = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld(Vector(-225,0,300))):GetNormalized():Angle() )
	elseif vers == 3 then
		AimAngles = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld(Vector(250,0,250))):GetNormalized():Angle() )
	end
    return AimAngles
end


	
function ENT:InitWeapons()
	
	self.FirePositions = {
		Vector(300,-32,100),
		Vector(300,-42,100),
		Vector(300,59,100), 
		Vector(300,49,100),
	}

	self.RocketPositions = {
		Vector(275,-125,250),
		Vector(275,125,250),
	}

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/hmg.png")
	weapon.Delay = 0.35
	weapon.Ammo = 300
	weapon.Attack = function( ent )
		ent.NumPrim = ent.NumPrim and ent.NumPrim + 1 or 1
		if ent.NumPrim > #ent.FirePositions then ent.NumPrim = 1 end
        --if not ent:GetVehicle():WeaponsInRange( ent ) then return true end
		local pod = ent:GetDriverSeat()

		if not IsValid( pod ) then return end

		local dir = ent:GetAimVector()
		
		if ent:AngleBetweenNormal( dir, ent:GetForward() ) > 15 then return true end

		local trace = ent:GetEyeTrace()

		local veh = ent:GetVehicle()

		veh.SNDTail:PlayOnce( 100 + math.Rand(-3,3), 1 )
		
		local CurPos = ent.FirePositions[ent.NumPrim]

		local bullet = {}
		bullet.Src = ent:LocalToWorld( CurPos )
		bullet.Dir = (trace.HitPos - bullet.Src):GetNormalized()
		bullet.Spread 	= Vector( 0.01,  0.01, 0.01 )
		bullet.TracerName = "lvs_laser_blue_long"
		bullet.Force	= 10
		bullet.HullSize 	= 25
		bullet.Damage	= 100
		bullet.Velocity = 18000
		bullet.Attacker 	= ent:GetDriver()
		bullet.Callback = function(att, tr, dmginfo)
			local effectdata = EffectData()
				effectdata:SetStart( Vector(0,0,255) ) 
				effectdata:SetOrigin( tr.HitPos )
				effectdata:SetNormal( tr.HitNormal )
			util.Effect( "lvs_laser_impact", effectdata )
		end
		ent:TakeAmmo()
		ent:LVSFireBullet( bullet )
	end
	weapon.OnSelect = function( ent )
		ent:EmitSound("physics/metal/weapon_impact_soft3.wav")
		self:SetBodygroup(self:FindBodygroupByName( "rockets" ),0)
	end
	weapon.OnThink = function( ent )
		if self:GetThrottle() > 0.3 then
			if self:GetAI() or IsValid(self:GetDriver()) then
				local AimAngles = self:GetAimAngles( ent, 3 )
				if self:GetAI() == false then
					if IsValid(self:GetDriver()) then
						if self:GetDriver():KeyDown( IN_BACK ) == true then 
							AimAngles.y = AimAngles.y * -1
						end
					end
				end
				self:SetPoseParameter("tank_steer", (AimAngles.y * 4) )
			end
		end
	end
	weapon.OnOverheat = function( ent )
		ent:EmitSound("lvs/overheat.wav")
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local Col = (ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > 15) and COLOR_RED or COLOR_WHITE

		local Pos2D = ent:GetEyeTrace().HitPos:ToScreen() 

		local base = ent:GetVehicle()
		base:PaintCrosshairCenter( Pos2D, Col )
		base:PaintCrosshairOuter( Pos2D, Col )
		base:LVSPaintHitMarker( Pos2D )
	end
	self:AddWeapon( weapon )

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/spotlight.png")
	weapon.Ammo = -1
	weapon.Delay = 0.1
	weapon.HeatRateUp = 0
	weapon.HeatRateDown = 1
	weapon.StartAttack = function( ent )
		if self:GetSpotlightToggle() == true then
			self:SetSpotlightToggle(false)
		else
			self:SetSpotlightToggle(true)
		end
	end
	weapon.OnSelect = function( ent ) 
		ent:EmitSound("physics/metal/weapon_impact_soft3.wav") 
		self:SetBodygroup(self:FindBodygroupByName( "rockets" ),0)
	end
	weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	self:AddWeapon( weapon )

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/missile.png")
	weapon.Ammo = 160
	weapon.Delay = 1
	weapon.HeatRateUp = 0
	weapon.HeatRateDown = 0.08
	weapon.Attack = function( ent )

		ent.NumPrim = ent.NumPrim and ent.NumPrim + 1 or 1
		if ent.NumPrim > #ent.RocketPositions then ent.NumPrim = 1 end

		--if not ent:WeaponsInRange() then return true end
		local veh = ent:GetVehicle()
		local Driver = ent:GetDriver()

		local pod = ent:GetDriverSeat()

		if not IsValid( pod ) then return end

		local dir = ent:GetAimVector()

		local RurPos = ent.RocketPositions[ent.NumPrim]

		if ent:AngleBetweenNormal( dir, ent:GetForward() ) > 45 then return true end

		for i = 1, 20 do
			timer.Simple( (i / 7) * 0.75, function()
				if not IsValid( ent ) then return end

				if ent:GetAmmo() <= 0 then ent:SetHeat( 1 ) return end
	
				ent:TakeAmmo()
				local trace = ent:GetEyeTrace()
				local Start = RurPos
				local Dir = (ent:GetEyeTrace().HitPos - veh:LocalToWorld(Start)):GetNormalized()
				local projectile = ents.Create( "lvs_missile" )
				projectile:SetPos(veh:LocalToWorld(Start))
				projectile:SetAngles( Dir:Angle() )
				projectile:SetParent( )
				projectile:Spawn()
				projectile:Activate()
				projectile.GetTarget = function( missile ) return missile end
				projectile.GetTargetPos = function( missile )
					return missile:LocalToWorld( Vector(150,0,0) + VectorRand() * math.random(-10,10) )
				end
				projectile:SetAttacker( IsValid( Driver ) and Driver or self )
				projectile:SetEntityFilter( ent:GetCrosshairFilterEnts() )
				projectile:SetDamage( 550 )
				projectile:SetRadius( 350 )
				projectile:Enable()
				projectile:EmitSound( "LVS.TURUB.FIRE_MISSILE" )
				projectile:EmitSound( "LVS.TURUB.FLY_MISSILE" )
			end)
		end

		ent:SetHeat( 1 )
		ent:SetOverheated( true )
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local Col = (ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > 45) and COLOR_RED or COLOR_WHITE

		local Pos2D = ent:GetEyeTrace().HitPos:ToScreen() 

		local base = ent:GetVehicle()
		base:PaintCrosshairCenter( Pos2D, Col )
		base:PaintCrosshairOuter( Pos2D, Col )
		base:LVSPaintHitMarker( Pos2D )
	end
	weapon.OnSelect = function( ent )
		ent:EmitSound("weapons/shotgun/shotgun_cock.wav")
		self:SetBodygroup(self:FindBodygroupByName( "rockets" ),1)
	end
	self:AddWeapon( weapon )

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/hmg.png")
	weapon.Delay = 0.10
	weapon.Ammo = 1000
	weapon.Attack = function( ent )
        --if not ent:GetVehicle():WeaponsInRange( ent ) then return true end
		local pod = ent:GetDriverSeat()

		if not IsValid( pod ) then return end

		local dir = ent:GetAimVector()
		
		if ent:AngleBetweenNormal( dir, ent:GetForward() ) > 360 then return true end

		local trace = ent:GetEyeTrace()

		local veh = ent:GetVehicle()

		veh.SNDTail2:PlayOnce( 100 + math.Rand(-3,3), 1 )

		local ID_1 = self:LookupAttachment( "top_2" )
		local Muzzle1 = self:GetAttachment( ID_1 )
		
		local Pos = Muzzle1.Pos				

		local bullet = {}
		bullet.Src = Pos
		bullet.Dir = (trace.HitPos - bullet.Src):GetNormalized()
		bullet.Spread 	= Vector( 0.01,  0.01, 0.01 )
		bullet.TracerName = "lvs_laser_blue"
		bullet.Force	= 10
		bullet.HullSize 	= 25
		bullet.Damage	= 65
		bullet.Velocity = 10000
		bullet.Attacker 	= ent:GetDriver()
		bullet.Callback = function(att, tr, dmginfo)
			local effectdata = EffectData()
				effectdata:SetStart( Vector(0,0,255) ) 
				effectdata:SetOrigin( tr.HitPos )
				effectdata:SetNormal( tr.HitNormal )
			util.Effect( "lvs_laser_impact", effectdata )
		end
		ent:TakeAmmo()
		ent:LVSFireBullet( bullet )
	end
	weapon.OnSelect = function( ent )
		ent:EmitSound("physics/metal/weapon_impact_soft3.wav")
	end
	weapon.OnOverheat = function( ent )
		ent:EmitSound("lvs/overheat.wav")
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local Col = (ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > 360) and COLOR_RED or COLOR_WHITE

		local Pos2D = ent:GetEyeTrace().HitPos:ToScreen() 

		local base = ent:GetVehicle()
		base:PaintCrosshairCenter( Pos2D, Col )
		base:PaintCrosshairOuter( Pos2D, Col )
		base:LVSPaintHitMarker( Pos2D )
	end
	weapon.OnThink = function( ent )
		if self:GetAI() or IsValid(self:GetGunnerSeat():GetDriver()) then
			local AimAngles = self:GetAimAngles( ent, 1 )

			local AimAnglesy = AimAngles.y -- 45 
			--[[
			if (AimAngles.y) < 0 then
				AimAnglesy = AimAngles.y + 45
			else 
				AimAnglesy = AimAngles.y - 45
			end]]


			self:SetPoseParameter("turret1_elevation", -AimAngles.p )
			self:SetPoseParameter("turret1_rotation", AimAnglesy )
		end
	end
	self:AddWeapon( weapon, 2 )

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/hmg.png")
	weapon.Delay = 0.15
	weapon.HeatRateUp = 0.4
	weapon.Ammo = 200
	weapon.HeatRateDown = 0.1
	weapon.Attack = function( ent )
        --if not ent:GetVehicle():WeaponsInRange( ent ) then return true end
		local pod = ent:GetDriverSeat()

		if not IsValid( pod ) then return end

		local dir = ent:GetAimVector()
		
		if ent:AngleBetweenNormal( dir, ent:GetForward() ) > 360 then return true end

		local trace = ent:GetEyeTrace()

		local veh = ent:GetVehicle()

		veh.SNDTail3:PlayOnce( 70 + math.Rand(-3,3), 1 )

		local ID_1 = self:LookupAttachment( "end_1" )
		local Muzzle1 = self:GetAttachment( ID_1 )
		
		local Pos = Muzzle1.Pos				

		
		local bullet = {}
		bullet.Src = Pos
		bullet.Dir = (trace.HitPos - bullet.Src):GetNormalized()
		bullet.Spread 	= Vector( 0.01,  0.01, 0.01 )
		bullet.TracerName = "lvs_laser_blue"
		bullet.Force	= 10
		bullet.HullSize 	= 25
		bullet.Damage	= 150
		bullet.SplashDamage	= 100
		bullet.SplashDamageRadius	= 250
		bullet.Velocity = 20000
		bullet.Attacker 	= ent:GetDriver()
		bullet.Callback = function(att, tr, dmginfo)
			local effectdata = EffectData()
				effectdata:SetStart( Vector(0,0,255) ) 
				effectdata:SetOrigin( tr.HitPos )
				effectdata:SetNormal( tr.HitNormal )
			util.Effect( "lvs_concussion_explosion", effectdata )
		end
		ent:TakeAmmo()
		ent:LVSFireBullet( bullet )
	end
	weapon.OnSelect = function( ent )
		ent:EmitSound("physics/metal/weapon_impact_soft3.wav")
	end
	weapon.OnThink = function( ent )
		if self:GetAI() or IsValid(self:GetSecondGunnerSeat():GetDriver()) then
			local AimAngles = self:GetAimAngles( ent, 2  )
			local AimAnglesy
			local AimAnglesp
			if AimAngles.y < 0 then
				AimAnglesy = (AimAngles.y + 180)
				AimAnglesp = (AimAngles.p + 35)
			else
				AimAnglesy = (AimAngles.y - 180)
				AimAnglesp = (AimAngles.p + 35)
			end
			self:SetPoseParameter("turret2_elevation", -AimAnglesp )
			self:SetPoseParameter("turret2_rotation", -AimAnglesy )
		end
	end
	weapon.OnOverheat = function( ent )
		ent:EmitSound("lvs/overheat.wav")
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local Col = (ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > 360) and COLOR_RED or COLOR_WHITE

		local Pos2D = ent:GetEyeTrace().HitPos:ToScreen() 

		local base = ent:GetVehicle()
		base:PaintCrosshairCenter( Pos2D, Col )
		base:PaintCrosshairOuter( Pos2D, Col )
		base:LVSPaintHitMarker( Pos2D )
	end
	self:AddWeapon( weapon, 3 )

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/hmg.png")
	weapon.Delay = 0.10
	weapon.Ammo = 1000
	weapon.Attack = function( ent )
        --if not ent:GetVehicle():WeaponsInRange( ent ) then return true end
		local pod = ent:GetDriverSeat()

		if not IsValid( pod ) then return end

		local dir = ent:GetAimVector()
		
		if ent:AngleBetweenNormal( dir, ent:GetForward() ) > 80 then return true end

		local trace = ent:GetEyeTrace()
		
		local veh = ent:GetVehicle()

		veh.SNDTail:PlayOnce( 100 + math.Rand(-3,3), 1 )
		
		local bullet = {}
		bullet.Src = veh:LocalToWorld(  Vector(335,-0,300) )
		bullet.Dir = (trace.HitPos - bullet.Src):GetNormalized()
		bullet.Spread 	= Vector( 0.01,  0.01, 0.01 )
		bullet.TracerName = "lvs_laser_blue"
		bullet.Force	= 10
		bullet.HullSize 	= 25
		bullet.Damage	= 55
		bullet.Velocity = 30000
		bullet.Attacker 	= ent:GetDriver()
		bullet.Callback = function(att, tr, dmginfo)
			local effectdata = EffectData()
				effectdata:SetStart( Vector(0,0,255) ) 
				effectdata:SetOrigin( tr.HitPos )
				effectdata:SetNormal( tr.HitNormal )
			util.Effect( "lvs_laser_impact", effectdata )
		end
		ent:TakeAmmo()
		ent:LVSFireBullet( bullet )
	end
	weapon.OnSelect = function( ent )
		ent:EmitSound("physics/metal/weapon_impact_soft3.wav")
	end
	weapon.OnOverheat = function( ent )
		ent:EmitSound("lvs/overheat.wav")
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local Col = (ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > 80) and COLOR_RED or COLOR_WHITE

		local Pos2D = ent:GetEyeTrace().HitPos:ToScreen() 

		local base = ent:GetVehicle()
		base:PaintCrosshairCenter( Pos2D, Col )
		base:PaintCrosshairOuter( Pos2D, Col )
		base:LVSPaintHitMarker( Pos2D )
	end
	self:AddWeapon( weapon, 4 )
end

function ENT:CalcMainActivityPassenger( ply )

end


ENT.EngineSounds = {
	{
		sound = "turbo_tank/loop.wav",
		Pitch = 70,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 30,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		UseDoppler = true,
		SoundLevel = 110,
	},
	{
		sound = "turbo_tank/stop.wav",
		Pitch = 70,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 30,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		UseDoppler = true,
		SoundLevel = 70,
	},
	{
		sound = "turbo_tank/startup.wav",
		Pitch = 70,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 30,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		UseDoppler = true,
		SoundLevel = 70,
	},
	{
		sound = "turbo_tank/loop.wav",
		Pitch = 70,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 30,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		UseDoppler = true,
		SoundLevel = 100,
	},
	{
		sound = "turbo_tank/dist.wav",
		Pitch = 70,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 30,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		SoundLevel = 80,
	},
}

sound.Add{ {
	name = "LVS.TURUB.FIRE_MISSILE",
	channel = CHAN_WEAPON,
	volume = 6.0,
	level = 3000,
	pitch = 105,
	sound = "sound/turbo_tank/missile_launch.wav"
 } }

 sound.Add{ {
	name = "LVS.TURUB.FLY_MISSILE",
	volume = 8.0,
	level = 2000,
	pitch = 105,
	sound = "sound/turbo_tank/missile_flight.wav"
 } }

ENT.LAATC_PICKUPABLE = true
ENT.LAATC_DROP_IN_AIR = true
ENT.LAATC_PICKUP_POS = Vector(-350,0,-200)
ENT.LAATC_PICKUP_Angle = Angle(0,0,0)


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
