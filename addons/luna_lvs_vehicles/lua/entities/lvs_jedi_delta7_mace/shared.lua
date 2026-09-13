--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


ENT.Base = "lvs_base_starfighter"

ENT.PrintName = "Mace Windu's Delta 7"
ENT.Author = "Durian"
ENT.Information = ""
ENT.Category = "[LVS] - Republic Vehicles"
ENT.Material = "lunasflightschool_delta7_mace"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/starwars/lordtrilobite/ships/delta7/delta7_landed.mdl"

ENT.AITEAM = 2

ENT.MaxVelocity = 2600
ENT.MaxThrust = 2600

ENT.ThrustVtol = 55
ENT.ThrustRateVtol = 3

ENT.TurnRatePitch = 1.6
ENT.TurnRateYaw = 1.6
ENT.TurnRateRoll = 1.6

ENT.ForceLinearMultiplier = 1

ENT.ForceAngleMultiplier = 1
ENT.ForceAngleDampingMultiplier = 1

ENT.MaxHealth = 4000
ENT.MaxShield = 3000

ENT.GOZANTI_PICKUPABLE = true
ENT.GOZANTI_DROP_IN_AIR = true
ENT.GOZANTI_PICKUP_POS = Vector(0, 0, 0)
ENT.GOZANTI_PICKUP_Angle = Angle(0,0,0)

function ENT:OnSetupDataTables()
	self:AddDT( "Bool", "IsCarried" )
	self:AddDT( "Bool", "HatchOpen" )

	if SERVER then
		self:NetworkVarNotify( "IsCarried", self.OnIsCarried )
	end

	if SERVER or CLIENT then
		self:NetworkVarNotify( "HatchOpen", self.OnHatchChanged )
	end
end


function ENT:InitWeapons()
	self.FirePositions = {
		Vector(16,31.5,36),
		Vector(16,-33,36), 
		Vector(16,32.5,26.5), 
		Vector(16,-32,26.5)
	}

	local weapon = {}
		weapon.Icon = Material("lvs/weapons/mg.png")
		weapon.Ammo = 2000
		weapon.Delay = 0.1
		weapon.HeatRateUp = 0.3
		weapon.HeatRateDown = 0.5
		weapon.Attack = function( ent )
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
			bullet.TracerName = "lvs_laser_green"
			bullet.Force	= 10
			bullet.HullSize 	= 25
			bullet.Damage	= 170
			bullet.SplashDamage = 200
			bullet.SplashDamageRadius = 200
			bullet.Velocity = 60000
			bullet.Attacker 	= ent:GetDriver()
			bullet.Callback = function(att, tr, dmginfo)
				local effectdata = EffectData()
					effectdata:SetStart( Vector(50,255,50) ) 
					effectdata:SetOrigin( tr.HitPos )
					effectdata:SetNormal( tr.HitNormal )
				util.Effect( "lvs_laser_impact", effectdata )
			end
			ent:LVSFireBullet( bullet )

			local effectdata = EffectData()
			effectdata:SetStart( Vector(50,255,50) )
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

	self:AddWeapon( LVS:GetWeaponPreset( "TURBO" ) )
end

ENT.FlyByAdvance = 0.5
ENT.FlyBySound = "lfs/jsf/JSF Flyby 1.mp3" 

ENT.EngineSounds = {
	{
		sound = "lfs/jsf/JSF ENG 1B.wav",
		Pitch = 80,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 40,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		UseDoppler = true,
	},
	{
		sound = "^lfs/jsf/JSF ENG 2.wav",
		Pitch = 80,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 40,
		FadeIn = 0.35,
		FadeOut = 1,
		FadeSpeed = 1.5,
		UseDoppler = true,
		VolumeMin = 0,
		VolumeMax = 1,
		SoundLevel = 110,
	},
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
