--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ENT.Type = "anim"
ENT.Base = "lvs_base_fakehover"

ENT.PrintName = "TX-130 / Tkaro"
ENT.Author = "Dec"
ENT.Information = "Republic Fighter Tank"
ENT.Category = "[LVS] SW-Vehicles"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/tkaro/starwars/vehicle/tx130/tx130.mdl"
ENT.GibModels = {
	"models/tkaro/starwars/vehicle/tx130/gibs/tx130_charge_gib.mdl",
	"models/tkaro/starwars/vehicle/tx130/gibs/tx130_flap_gib.mdl",
    "models/tkaro/starwars/vehicle/tx130/gibs/tx130_hatch_gib.mdl",
	"models/tkaro/starwars/vehicle/tx130/gibs/tx130_main_gib.mdl",
	"models/tkaro/starwars/vehicle/tx130/gibs/tx130_sidegun_gib_1.mdl",
	"models/tkaro/starwars/vehicle/tx130/gibs/tx130_sidegun_gib_2.mdl",
	"models/tkaro/starwars/vehicle/tx130/gibs/tx130_model_turret_gib.mdl",
	"models/tkaro/starwars/vehicle/tx130/gibs/tx130_wing_gib_1.mdl",
	"models/tkaro/starwars/vehicle/tx130/gibs/tx130_wing_gib_2.mdl",
}

ENT.AITEAM = 2

ENT.ForceAngleMultiplier = 3
ENT.ForceAngleDampingMultiplier = 3

ENT.ForceLinearMultiplier = 3
ENT.ForceLinearRate = 3

ENT.SpawnNormalOffset = 50

ENT.MaxHealth = 3000
ENT.MaxShield = 250
ENT.MaxVelocityX = 400
ENT.BoostAddVelocitX = 500
ENT.IgnoreWater = false

ENT.MaxTurnRate = 1
ENT.RotorPos = Vector(-68,0,18)

ENT.GroundTraceLength = 50
ENT.GroundTraceHull = 100


function ENT:OnSetupDataTables()

	self:AddDT( "Entity", "GunnerSeat" )
	self:AddDT( "Entity", "SecondGunnerSeat" )

	self:NetworkVar( "Vector",18, "RotorPos" )

	self:NetworkVar( "Int",18, "DoorMode" )
	self:NetworkVar( "Bool",19, "BTLFire" )
	self:NetworkVar( "Bool",21, "RearHatch" )
	self:NetworkVar( "Bool",22, "WeaponOutOfRange" )
	self:NetworkVar( "Bool",23, "FrontInRange" )

end

function ENT:CalcMainActivityPassenger( ply )
end

function ENT:CalcMainActivity( ply )
	local guner = self:GetGunnerSeat()

    if ply ~= guner:GetDriver() then return self:CalcMainActivityPassenger( ply ) end

    if ply.m_bWasNoclipping then 
        ply.m_bWasNoclipping = nil 
        ply:AnimResetGestureSlot( GESTURE_SLOT_CUSTOM ) 
        
        if CLIENT then 
            ply:SetIK( true )
        end 
    end 

    ply.CalcIdeal = ACT_STAND
    ply.CalcSeqOverride = ply:LookupSequence( "idle_all_02" )

    return ply.CalcIdeal, ply.CalcSeqOverride
end


sound.Add( {
	name = "TX_FIRE",
	channel = CHAN_WEAPON,
	volume = 0.6,
	level = 125,
	pitch = {95, 105},
	sound = "lfs/tx130/twincannonlaser.wav"
} )

sound.Add( {
	name = "TX_ROCKET",
	channel = CHAN_ITEM,
	volume = 1.0,
	level = 90,
	pitch = 100,
	sound = "lfs/tx130/rocket.wav"
} )

sound.Add( {
	name = "TX_ROCKETPODS_RAISE",
	channel = CHAN_ITEM,
	volume = 1.0,
	level = 90,
	pitch = 100,
	sound = "lfs/tx130/rocketpods_raise.wav"
} )

sound.Add( {
	name = "TX_ROCKETPODS_LOWER",
	channel = CHAN_ITEM,
	volume = 1.0,
	level = 90,
	pitch = 100,
	sound = "lfs/tx130/rocketpods_lower.wav"
} )

sound.Add( {
	name = "TX_DIST",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 110,
	sound = "lfs/tx130/dist.wav"
} )

sound.Add( {
	name = "TX_TWINCANNON_ACTIVATE",
	channel = CHAN_ITEM,
	volume = 1.0,
	level = 90,
	pitch = 100,
	sound = "lfs/tx130/twincannon_activate.wav"
} )

sound.Add( {
	name = "TX_TWINCANNON_DEACTIVATE",
	channel = CHAN_ITEM,
	volume = 1.0,
	level = 90,
	pitch = 100,
	sound = "lfs/tx130/twincannon_deactivate.wav"
} )

ENT.EngineSounds = {
	{
		channel = CHAN_STATIC,
		volume = 1.1,
		level = 120,
		sound = "lfs/tx130/engine.wav"
	},
	{
		channel = CHAN_STATIC,
		volume = 1,
		level = 90,
		sound = "lfs/tx130/interior.wav"
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

ENT.LAATC_PICKUPABLE = true
ENT.LAATC_PICKUP_POS = Vector(-200,0,30)
ENT.LAATC_PICKUP_Angle = Angle(0,0,0)


function ENT:WeaponsInRange( ent )
    local AimAngles = self:GetAimAngles( ent )

    return not (AimAngles.p >= 360 or AimAngles.p <= -360)
end



function ENT:InitWeapons()
	local COLOR_RED = Color(255,0,0,255)
	local COLOR_WHITE = Color(255,255,255,255)
	self.curfire = false

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/hmg.png")
	weapon.Delay = 0.5
	weapon.HeatRateUp = 0.40
	weapon.HeatRateDown = 0.8
	weapon.Attack = function( ent )
		for i = 1, 1 do
			timer.Simple( (i / 2) * 0.2, function()
				local pod = ent:GetDriverSeat()

				if not IsValid( pod ) then return end

				local dir = ent:GetAimVector()
				

				local trace = ent:GetEyeTrace()

				ent.SwapTopBottom = not ent.SwapTopBottom

				local veh = ent:GetVehicle()

				veh.PrimarySND:PlayOnce( 70 + math.Rand(-3,3), 1 )
				local ID_1 = self:LookupAttachment( "muzzle_left" )
				local ID_2 = self:LookupAttachment( "muzzle_right" )
				local Muzzle1 = self:GetAttachment( ID_1 )
				local Muzzle2 = self:GetAttachment( ID_2 )


				ent.MirrorPrimary = not ent.MirrorPrimary

				local Pos = ent.MirrorPrimary and Muzzle1.Pos or Muzzle2.Pos
				local Dir =  (ent.MirrorPrimary and Muzzle1.Ang or Muzzle2.Ang):Up()

				--local Pos = Pos + Vector(25,0,10)
				local Pos = self:WorldToLocal( Pos ) + Vector(100,0,15)	

				local bullet = {}
				bullet.Src 	= self:LocalToWorld(Pos)
				bullet.Dir 	= Dir
				bullet.Spread 	= Vector( 0.01,  0.01, 0.01 )
				bullet.TracerName = "lvs_laser_green_short"
				bullet.Force	= 10
				bullet.HullSize 	= 25
				bullet.Damage	= 150
				bullet.SplashDamage	= 100
				bullet.SplashDamageRadius	= 200
				bullet.Velocity = 10000
				bullet.Attacker 	= ent:GetDriver()
				bullet.Callback = function(att, tr, dmginfo)
					local effectdata = EffectData()
						effectdata:SetStart( Vector(0,0,255) ) 
						effectdata:SetOrigin( tr.HitPos )
						effectdata:SetNormal( tr.HitNormal )
					util.Effect( "lvs_concussion_explosion", effectdata )
				end
				ent:LVSFireBullet( bullet )
				util.ScreenShake(self:GetPos(), 35, 10, 0.5, 550, true )
			end)
		end
	end
	weapon.OnThink = function( ent, active )
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
	self:AddWeapon( weapon )

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/missile.png")
	weapon.Ammo = 20
	weapon.Delay = 0.5
	weapon.HeatRateUp = 0
	weapon.HeatRateDown = 0.9
	weapon.Attack = function( ent )
		timer.Simple( 0, function()
			if self:GetDoorMode() == 0 then return end
		
			local ID1 = self:LookupAttachment( "left_launch_tube_1" )
			local ID2 = self:LookupAttachment( "right_launch_tube_1" )
			local ID3 = self:LookupAttachment( "left_launch_tube_2" )
			local ID4 = self:LookupAttachment( "right_launch_tube_2" )
			local ID5 = self:LookupAttachment( "left_launch_tube_3" )
			local ID6 = self:LookupAttachment( "right_launch_tube_3" )
			local ID7 = self:LookupAttachment( "left_launch_tube_4" )
			local ID8 = self:LookupAttachment( "right_launch_tube_4" )
			local ID9 = self:LookupAttachment( "left_launch_tube_5" )
			local ID10 = self:LookupAttachment( "right_launch_tube_5" )
		
			local Muzzle1 = self:GetAttachment( ID1 )
			local Muzzle2 = self:GetAttachment( ID2 )
			local Muzzle3 = self:GetAttachment( ID3 )
			local Muzzle4 = self:GetAttachment( ID4 )
			local Muzzle5 = self:GetAttachment( ID5 )
			local Muzzle6 = self:GetAttachment( ID6 )
			local Muzzle7 = self:GetAttachment( ID7 )
			local Muzzle8 = self:GetAttachment( ID8 )
			local Muzzle9 = self:GetAttachment( ID9 )
			local Muzzle10 = self:GetAttachment( ID10 )
			
			local FirePos = {
				[1] = Muzzle1,
				[2] = Muzzle2,
				[3] = Muzzle3,
				[4] = Muzzle4,
				[5] = Muzzle5,
				[6] = Muzzle6,
				[7] = Muzzle7,
				[8] = Muzzle8,
				[9] = Muzzle9,
				[10] = Muzzle10,
			}
			
			if not FirePos then return end
			self.FireIndex2 = self.FireIndex2 and self.FireIndex2 + 1 or 1
			if self.FireIndex2 > 10 then
				self.FireIndex2 = 1
			end
			self:EmitSound( "TX_ROCKET" )
		
			local Pos = FirePos[self.FireIndex2].Pos
			if not IsValid( ent ) then return end

			if ent:GetAmmo() <= 0 then ent:SetHeat( 1 ) return end
			ent:TakeAmmo()
			local Dir =  FirePos[self.FireIndex2].Angle
			--[[

			print(Dir)

			local projectile = ents.Create( "lvs_missile" )
			projectile:SetPos(Pos)
			projectile:SetAngles( Dir )
			projectile:SetParent( )
			projectile:Spawn()
			projectile:Activate()
			projectile.GetTarget = function( projectile ) return projectile end
			projectile.GetTargetPos = function( projectile )
				return projectile:LocalToWorld( Vector(150,0,0) + VectorRand() * math.random(-5,5) )
			end
			projectile:SetAttacker( IsValid( Driver ) and Driver or self )
			projectile:SetEntityFilter( ent:GetCrosshairFilterEnts() )
			projectile:SetDamage( 550 )
			projectile:SetRadius( 350 )
			projectile:Enable()
			]]
			local trace = ent:GetEyeTrace()

			local Driver = self:GetDriver()

			local Pos = self:WorldToLocal( Pos ) + Vector(25,0,10)	
			local projectile = ents.Create( "lvs_protontorpedo" )
			projectile:SetPos( self:LocalToWorld(Pos) )
			projectile:SetAngles( self:GetAngles() )
			projectile:SetParent( ent )
			projectile:Spawn()
			projectile:Activate()
			projectile.GetTargetPos = function( projectile )
				return projectile:LocalToWorld( Vector(150,0,0) + VectorRand() * math.random(-5,5) )
			end
			projectile:SetAttacker(Driver)
			projectile:SetEntityFilter( ent:GetCrosshairFilterEnts() )
			projectile:SetDamage( 1500 )
			projectile:SetRadius( 300 )
			projectile:Enable()

			ent:SetHeat( 1 )
			ent:SetOverheated( true )

			local PhysObj = self:GetPhysicsObject()
			if IsValid( PhysObj ) then
				PhysObj:ApplyForceOffset( -self:GetAngles():Forward() * 20000, Pos )
			end
		end)
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local Col = (ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > 30) and COLOR_RED or COLOR_WHITE

		local Pos2D = ent:GetEyeTrace().HitPos:ToScreen() 

		local base = ent:GetVehicle()
		base:PaintCrosshairCenter( Pos2D, Col )
		base:PaintCrosshairOuter( Pos2D, Col )
		base:LVSPaintHitMarker( Pos2D )
	end
	weapon.OnSelect = function( ent )
		ent:EmitSound("weapons/shotgun/shotgun_cock.wav")
	end
	self:AddWeapon( weapon )

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/laserbeam.png")
	weapon.Ammo = 20
	weapon.Delay = 0
	weapon.HeatRateUp = 0.8
	weapon.HeatRateDown = 0.4
	weapon.Attack = function( ent )
		local Pod = self:GetGunnerSeat()
		local Driver = Pod:GetDriver()
		if self:GetBodygroup(1) == 1 then
			if IsValid( Driver ) and IsValid( Pod ) then
				local veh = ent:GetVehicle()
				self:SetBTLFire( true )
				if self.curfire == false then
					veh.SecSND:PlayOnce()
					self.curfire = true
				end
				
				local ID = self:LookupAttachment( "lazer_cannon_muzzle" )
				local Muzzle = self:GetAttachment( ID )
							
				local Dir = Muzzle.Ang:Up()
				local startpos = Muzzle.Pos
						
				local Trace = util.TraceLine( {
					start = startpos,
					endpos = (startpos + Dir * 50000),
				} )
					
				self:BallturretDamage( Trace.Entity, Driver, Trace.HitPos, Dir )
			end
		end
	end
	weapon.FinishAttack = function( ent )
		self:SetBTLFire( false )
		self.curfire = false
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		if self:GetBodygroup(1) == 1 then

			local Pos2D = base:TraceBTL().HitPos:ToScreen()

			base:PaintCrosshairCenter( Pos2D, color_white )
			base:PaintCrosshairOuter( Pos2D, color_white )
			base:LVSPaintHitMarker( Pos2D )
		end
	end
	self:AddWeapon( weapon, 2 )

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/laserbeam.png")
	weapon.Ammo = -1
	weapon.Delay = 1.5
	weapon.HeatRateUp = 1
	weapon.HeatRateDown = 0.4
	weapon.StartAttack = function( ent )
		if (self.turmount) then
			self.turmount = false
			self:SetBodygroup(1, 0)
		else
			self:SetBodygroup(1, 1)
			self.turmount = true
		end
	end
	self:AddWeapon( weapon, 3 )

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/spotlight.png")
	weapon.Ammo = -1
	weapon.Delay = 0.1
	weapon.HeatRateUp = 0
	weapon.HeatRateDown = 1
	weapon.StartAttack = function( ent )
		if self.lighton == true then
			self:SetBodygroup(9, 0)
			self.lighton = false
			self:EmitSound( "buttons/lightswitch2.wav", 75, 105 )
		else
			self.lighton = true
			self:SetBodygroup(9, 1)
			self:EmitSound( "buttons/lightswitch2.wav", 75, 105 )
		end
	end
	self:AddWeapon( weapon, 3 )
end



function ENT:TraceBTL()
	local ID = self:LookupAttachment( "lazer_cannon_muzzle" )
	local Muzzle = self:GetAttachment( ID )

	if not Muzzle then return end

	local dir = Muzzle.Ang:Up()
	local pos = Muzzle.Pos

	local trace = util.TraceLine( {
		start = pos,
		endpos = (pos + dir * 50000),
	} )

	return trace
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
