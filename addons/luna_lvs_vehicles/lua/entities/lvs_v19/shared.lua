--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


ENT.Base = "lvs_base_starfighter"

ENT.PrintName = "V-19 Torrent"
ENT.Author = "Durian"
ENT.Information = ""
ENT.Category = "[LVS] - Republic Vehicles"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/DiggerThings/v19/4.mdl"
ENT.GibModels = {
}

ENT.AITEAM = 2

ENT.MaxVelocity = 2300
ENT.MaxThrust = 2300

ENT.ThrustVtol = 55
ENT.ThrustRateVtol = 3

ENT.TurnRatePitch = 1.2
ENT.TurnRateYaw = 1.2
ENT.TurnRateRoll = 1.2

ENT.ForceLinearMultiplier = 1

ENT.ForceAngleMultiplier = 1
ENT.ForceAngleDampingMultiplier = 1

ENT.MaxHealth = 400
ENT.MaxShield = 0

ENT.GOZANTI_PICKUPABLE = true
ENT.GOZANTI_DROP_IN_AIR = true
ENT.GOZANTI_PICKUP_POS = Vector(0, 0, 0)
ENT.GOZANTI_PICKUP_Angle = Angle(0,0,0)

function ENT:OnSetupDataTables()
	self:AddDT( "Bool", "WingsDown" )

	if SERVER or CLIENT then
		self:NetworkVarNotify( "WingsDown", self.OnWingsChanged )
	end
end

function ENT:InitWeapons()

	self.FirePositions = {
		Vector(192.86,-387.4,-221.59),
		Vector(192.86,387.4,-221.59), 
	}

	local weapon = {}
		weapon.Icon = Material("lvs/weapons/mg.png")
		weapon.Ammo = 2000
		weapon.Delay = 0.1
		weapon.HeatRateUp = 0.3
		weapon.HeatRateDown = 0.5
		weapon.Attack = function( ent )
			if not self:GetWingsDown(true) then 
				ent:SetHeat( ent:GetHeat() * 0 )
				return
			end
				ent.NumPrim = ent.NumPrim and ent.NumPrim + 1 or 1
				if ent.NumPrim > #ent.FirePositions then ent.NumPrim = 1 end

			local pod = ent:GetDriverSeat()

			if not IsValid( pod ) then return end

			local startpos = pod:LocalToWorld( pod:OBBCenter() )
			local trace = util.TraceHull( {
			start = startpos,
			endpos = (startpos + ent:GetForward() * 50000),
			mins = Vector( -10, -10, -10 ),
			maxs = Vector( 10, 10, 10 ),
			filter = ent:GetCrosshairFilterEnts()
			} )

			local bullet = {}
			bullet.Src  = ent:LocalToWorld( ent.FirePositions[ent.NumPrim] )
			bullet.Dir 	= (trace.HitPos - bullet.Src):GetNormalized()
			bullet.Spread 	= Vector( 0.01,  0.01, 0.01 )
			bullet.TracerName = "lvs_laser_blue"
			bullet.Force	= 10
			bullet.HullSize 	= 25
			bullet.Damage	= 20
			bullet.SplashDamage = 100
			bullet.SplashDamageRadius = 100
			bullet.Velocity = 80000
			bullet.Attacker 	= ent:GetDriver()
			bullet.Callback = function(att, tr, dmginfo)
				local effectdata = EffectData()
					effectdata:SetStart( Vector(50,50,225) ) 
					effectdata:SetOrigin( tr.HitPos )
					effectdata:SetNormal( tr.HitNormal )
				util.Effect( "lvs_laser_impact", effectdata )
			end
			ent:LVSFireBullet( bullet )

			local effectdata = EffectData()
			effectdata:SetStart( Vector(50,50,225) )
			effectdata:SetOrigin( bullet.Src )
			effectdata:SetNormal( ent:GetForward() )
			effectdata:SetEntity( ent )
			util.Effect( "lvs_muzzle_colorable", effectdata )

			ent:TakeAmmo()

			ent.PrimarySND:PlayOnce( 100 + math.cos( CurTime() + self:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )
		end
		weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav") end
		weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/vehicles/tie/overheat.wav") end
	self:AddWeapon( weapon )

	local weapon = {}
		weapon.Icon = Material("lvs/weapons/dual_mg.png")
		weapon.Ammo = 2500
		weapon.Delay = 0.25
		weapon.HeatRateUp = 0.3
		weapon.HeatRateDown = 0.5
		weapon.Attack = function( ent )
			if not self:GetWingsDown(true) then 
				ent:SetHeat( ent:GetHeat() * 0 )
				return
			end
			local pod = ent:GetDriverSeat()

			if not IsValid( pod ) then return end

			local startpos = pod:LocalToWorld( pod:OBBCenter() )
			local trace = util.TraceHull( {
			start = startpos,
			endpos = (startpos + ent:GetForward() * 50000),
			mins = Vector( -10, -10, -10 ),
			maxs = Vector( 10, 10, 10 ),
			filter = ent:GetCrosshairFilterEnts()
			} )
			
			local bullet = {}
			bullet.Dir 	= ent:GetForward()
			bullet.Spread 	= Vector( 0.01,  0.01, 0.01 )
			bullet.TracerName = "lvs_laser_blue"
			bullet.Force	= 10
			bullet.HullSize 	= 25
			bullet.Damage	= 20
			bullet.SplashDamage = 100
			bullet.SplashDamageRadius = 100
			bullet.Velocity = 80000
			bullet.Attacker 	= ent:GetDriver()
			bullet.Callback = function(att, tr, dmginfo)
				local effectdata = EffectData()
					effectdata:SetStart( Vector(50,50,225) ) 
					effectdata:SetOrigin( tr.HitPos )
					effectdata:SetNormal( tr.HitNormal )
				util.Effect( "lvs_laser_impact", effectdata )
			end
			
			for i = -1,1,2 do
				bullet.Src 	= ent:LocalToWorld( Vector(192.86,387.4 * i,-221.59) )
				bullet.Dir 	= (trace.HitPos - bullet.Src):GetNormalized()

				local effectdata = EffectData()
				effectdata:SetStart( Vector(50,50,225) )
				effectdata:SetOrigin( bullet.Src )
				effectdata:SetNormal( ent:GetForward() )
				effectdata:SetEntity( ent )
				util.Effect( "lvs_muzzle_colorable", effectdata )

				ent:LVSFireBullet( bullet )
			end

			ent:TakeAmmo()

			ent.PrimarySND:PlayOnce( 100 + math.cos( CurTime() + self:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )
		end
		weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav") end
		weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/vehicles/shuttle/overheat.wav") end
	self:AddWeapon( weapon )

	local weapon = {}
		weapon.Icon = Material("lvs/weapons/concussionmissile.png")
		weapon.Ammo = 20
		weapon.Delay = 0 -- this will turn weapon.Attack to a somewhat think function
		weapon.HeatRateUp = -0.25 -- cool down when attack key is held. This system fires on key-release.
		weapon.HeatRateDown = 0.25
		weapon.Attack = function( ent )
			if not self:GetWingsDown(true) then 
				ent:SetHeat( ent:GetHeat() * 0 )
				return
			end
			local T = CurTime()

			if IsValid( ent._ConcussionMissile ) then
				if (ent._nextMissleTracking or 0) > T then return end

				ent._nextMissleTracking = T + 0.1 -- 0.1 second interval because those find functions can be expensive

				ent._ConcussionMissile:FindTarget( ent:GetPos(), ent:GetForward(), 30, 7500 )

				return
			end

			if (ent._nextMissle or 0) > T then return end

			ent._nextMissle = T + 0.5

			ent._swapMissile = not ent._swapMissile

			local Pos = Vector( 192.86, (ent._swapMissile and -387.4 or 387.4), -221.59 )

			local Driver = self:GetDriver()

			local projectile = ents.Create( "lvs_protontorpedo" )
			projectile:SetPos( ent:LocalToWorld( Pos ) )
			projectile:SetAngles( ent:GetAngles() )
			projectile:SetParent( ent )
			projectile:Spawn()
			projectile:Activate()
			projectile:SetAttacker( IsValid( Driver ) and Driver or self )
			projectile:SetEntityFilter( ent:GetCrosshairFilterEnts() )
			projectile:SetSpeed( ent:GetVelocity():Length() + 4000 )
			projectile:SetDamage( 800 )
			projectile:SetRadius( 300 )

			ent._ConcussionMissile = projectile

			ent:SetNextAttack( CurTime() + 0.1 ) -- wait 0.1 second before starting to track
		end
		weapon.FinishAttack = function( ent )
			if not IsValid( ent._ConcussionMissile ) then return end

			local projectile = ent._ConcussionMissile

			projectile:Enable()
			projectile:EmitSound( "lvs/vehicles/vulturedroid/fire_missile.mp3", 125 )
			ent:TakeAmmo()

			ent._ConcussionMissile = nil

			local NewHeat = ent:GetHeat() + 0.75

			ent:SetHeat( NewHeat )
			if NewHeat >= 1 then
				ent:SetOverheated( true )
			end
		end
		weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav") end
		weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/vehicles/imperial/overheat.wav") end
	self:AddWeapon( weapon )

	self:AddWeapon( LVS:GetWeaponPreset( "TURBO" ) )
end

ENT.FlyByAdvance = 0.5
ENT.FlyBySound = "lvs/vehicles/vwing/flyby.wav" 
ENT.DeathSound = "lvs/vehicles/generic_starfighter/crash.wav"

ENT.EngineSounds = {
	{
		sound = "lvs/vehicles/vwing/loop.wav",
		sound_int = "lvs/vehicles/vwing/loop_interior.wav",
		Pitch = 80,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 40,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		UseDoppler = true,
		SoundLevel = 90,
	},
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
