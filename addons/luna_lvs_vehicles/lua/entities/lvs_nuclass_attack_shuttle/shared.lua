--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


ENT.Base = "lvs_base_repulsorlift"

ENT.PrintName = "NU-Class Attack Shuttle"
ENT.Author = "Durian"
ENT.Information = "The Nu-class attack shuttle, also known as the Republic attack shuttle, was a vessel used by the Grand Army of the Republic during the Clone Wars."
ENT.Category = "[LVS] - Republic Vehicles"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/swbf3/vehicles/nu_attackship.mdl"

ENT.AITEAM = 2

ENT.MaxVelocity = 2000
ENT.MaxThrust = 1750

ENT.ThrustVtol = 55
ENT.ThrustRateVtol = 1

ENT.TurnRatePitch = 0.3
ENT.TurnRateYaw = 0.45
ENT.TurnRateRoll = 0.45

ENT.MaxPitch = 60
ENT.MaxRoll = 0

ENT.ForceLinearMultiplier = 1

ENT.ForceAngleMultiplier = 1
ENT.ForceAngleDampingMultiplier = 1

ENT.MaxHealth = 13000
ENT.MaxShield = 2000

function ENT:OnSetupDataTables()
	self:AddDT( "Bool", "WingsDown" )
	self:AddDT( "Bool", "HatchOpen" )

	if SERVER or CLIENT then
		self:NetworkVarNotify( "WingsDown", self.OnWingsChanged )
	end

	if SERVER or CLIENT then
		self:NetworkVarNotify( "HatchOpen", self.OnHatchChanged )
	end
end




function ENT:InitWeapons()

	self.FirePositions = {
		Vector(470,120, 150),
		Vector(470,-120, 150),
		Vector(470,-120, 175),
		Vector(470,120, 175)
	}

	local weapon = {}
		weapon.Icon = Material("lvs/weapons/dual_hmg.png")
		weapon.Ammo = 1250
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
			bullet.Spread 	= Vector( 0.03,  0.03, 0.03 )
			bullet.TracerName = "lvs_laser_green"
			bullet.Force	= 10
			bullet.HullSize 	= 25
			bullet.Damage	= 150
			bullet.SplashDamage = 110
			bullet.SplashDamageRadius = 400
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
		weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/vehicles/imperial/overheat.wav") end
	self:AddWeapon( weapon )

		local weapon = {}
			weapon.Icon = Material("lvs/weapons/dual_mg.png")
			weapon.Ammo = 1250
			weapon.Delay = 0.5
			weapon.HeatRateUp = 0.4
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
				bullet.Spread 	= Vector( 0.01,  0.01, 0.01 )
				bullet.TracerName = "lvs_laser_blue"
				bullet.Force	= 10
				bullet.HullSize 	= 25
				bullet.Damage	= 280
				bullet.SplashDamage = 100
				bullet.SplashDamageRadius = 50
				bullet.Velocity = 60000
				bullet.Attacker 	= ent:GetDriver()
				bullet.Callback = function(att, tr, dmginfo)
					local effectdata = EffectData()
						effectdata:SetStart( Vector(50,50,255) ) 
						effectdata:SetOrigin( tr.HitPos )
						effectdata:SetNormal( tr.HitNormal )
					util.Effect( "lvs_laser_impact", effectdata )
				end
					for i = -1,1,2 do
						bullet.Src 	= ent:LocalToWorld( Vector(470,120 * i, 150) )
						bullet.Dir 	= ent:GetForward()
	
						local effectdata = EffectData()
						effectdata:SetStart( Vector(50,50,255) )
						effectdata:SetOrigin( bullet.Src )
						effectdata:SetNormal( ent:GetForward() )
						effectdata:SetEntity( ent )
						util.Effect( "lvs_muzzle_colorable", effectdata )
	
						ent:LVSFireBullet( bullet )
					end
	
					for i = -1,1,2 do
						bullet.Src 	= ent:LocalToWorld( Vector(470,120 * i, 175)) 
						bullet.Dir 	= ent:GetForward()
	
						local effectdata = EffectData()
						effectdata:SetStart( Vector(50,50,255) )
						effectdata:SetOrigin( bullet.Src )
						effectdata:SetNormal( ent:GetForward() )
						effectdata:SetEntity( ent )
						util.Effect( "lvs_muzzle_colorable", effectdata )
	
						ent:LVSFireBullet( bullet )
					end
	
				ent:TakeAmmo()
	
				ent.SecondarySND:PlayOnce( 100 + math.cos( CurTime() + self:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )
			end
			weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav") end
			weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/vehicles/shuttle/overheat.wav") end
		self:AddWeapon( weapon )

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/gunship_reardoor.png")
	weapon.Ammo = -1
	weapon.Delay = 0
	weapon.HeatRateUp = 0
	weapon.HeatRateDown = 0
	weapon.StartAttack = function( ent )
		if not self:GetHatchOpen(false) then
			self:EmitSound("lvs/vehicles/vwing/sfoils.wav")
			self:SetHatchOpen(true)
			self:ManipulateBoneAngles(1, Angle(0,0,-90))
			self:ManipulateBoneAngles(2, Angle(0,0,180))
			
		else
			self:EmitSound("lvs/vehicles/vwing/sfoils.wav")
			self:SetHatchOpen(false)
			self:ManipulateBoneAngles(1, Angle(0,0,0))
			self:ManipulateBoneAngles(2, Angle(0,0,0))
		end
	end
	self:AddWeapon( weapon )

end

ENT.FlyByAdvance = 0.5
ENT.FlyBySound = "lvs/vehicles/shuttle/flyby.wav"

ENT.EngineSounds = {
	{
		sound = "lvs/vehicles/nuclass/engine.wav",
		sound_int = "lvs/vehicles/nuclass/engineint.wav",
		Pitch = 100,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 40,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		UseDoppler = true,
	},
	{
		sound = "^lvs/vehicles/shuttle/distance.wav",
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
