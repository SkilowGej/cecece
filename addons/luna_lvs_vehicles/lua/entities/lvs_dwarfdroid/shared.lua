--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


ENT.Base = "lvs_walker_atte_hoverscript"

ENT.PrintName = "Dwarf Droid"
ENT.Author = "JohnyReaper"
ENT.Information = "Assault Walker of the CIS"
ENT.Category = "[LVS] - Johny's Star Wars"

ENT.Spawnable		= true
ENT.AdminSpawnable	= false

ENT.MDL = "models/macieg/starwars/spider.mdl"
ENT.GibModels = {
}

ENT.AITEAM = 2

ENT.MaxHealth = 1000

ENT.ForceLinearMultiplier = 1

ENT.ForceAngleMultiplier = 1
ENT.ForceAngleDampingMultiplier = 1

ENT.HoverHeight = 62.5
ENT.HoverTraceLength = 400
ENT.HoverHullRadius = 5

ENT.TurretTurnRate = 100

ENT.LAATC_PICKUPABLE = false
ENT.LAATC_DROP_IN_AIR = true
ENT.LAATC_PICKUP_POS = Vector(-220,0,-145)
ENT.LAATC_PICKUP_Angle = Angle(0,180,0)

ENT.CanMoveOn = {
	["func_door"] = true,
	["func_movelinear"] = true,
	["prop_physics"] = true,
}

ENT.lvsShowInSpawner = true

function ENT:OnSetupDataTables()
	self:AddDT( "Entity", "TurretEnt" )
	self:AddDT( "Entity", "TurretSeat" )
	self:AddDT( "Entity", "GunnerSeat" )

	self:AddDT( "Float", "Move" )
	self:AddDT( "Bool", "IsMoving" )
	self:AddDT( "Bool", "IsCarried" )
	self:AddDT( "Bool", "IsRagdoll" )
	self:AddDT( "Vector", "AIAimVector" )

	self:AddDT( "Float", "TurretPitch" )
	self:AddDT( "Float", "TurretYaw" )

	if SERVER then
		self:NetworkVarNotify( "IsCarried", self.OnIsCarried )
	end
end

function ENT:GetContraption()
	return {self}
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

function ENT:GetAimVector()
	if self:GetAI() then
		return self:GetAIAimVector()
	end

	local Driver = self:GetDriver()

	if IsValid( Driver ) then
		return Driver:GetAimVector()
	else
		return self:GetForward()
	end
end

function ENT:GetMainAimAngles()
	local trace = self:GetEyeTrace()

	local AimAngles = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld( Vector(0,0,100)) ):GetNormalized():Angle() )

	local ID = self:LookupAttachment( "barrel" )
	local Muzzle = self:GetAttachment( ID )

	if not Muzzle then return AimAngles, trace.HitPos, false end

	local DirAng = self:WorldToLocalAngles( (trace.HitPos - self:GetDriverSeat():LocalToWorld( Vector(0,0,33) ) ):Angle() )

	-- print(DirAng.p)

	return AimAngles, trace.HitPos, (math.abs( DirAng.p ) < 30)-- and math.abs( DirAng.y ) < 80)
end

-- function ENT:GetAimAngles( ent, base, RearEnt )
-- 	local trace = self:GetEyeTrace()

-- 	local Pos = self:LocalToWorld( Vector(208,0,170) )
-- 	local wAng = (trace.HitPos - Pos):GetNormalized():Angle()

-- 	local _, Ang = WorldToLocal( Pos, wAng, Pos, self:LocalToWorldAngles( Angle(0,0,0) ) )

-- 	return Ang, trace.HitPos, (Ang.p < 30 and Ang.p > -10 and math.abs( Ang.y ) < 60)
-- end

function ENT:ShootBottomWep(ent)

	-- if (!self:GetTurretEnt()) then return end

	local ID1 = self:LookupAttachment( "barrel" )

	local Muzzle1 = self:GetAttachment( ID1 )

	if not Muzzle1 then return end

	local AimAngles, AimPos, InRange = ent:GetMainAimAngles()

	local Pos = Muzzle1.Pos
	local Dir = (AimPos - Pos):GetNormalized()

	if not InRange then return true end

	local bullet = {}
	bullet.Src 	= Pos
	bullet.Dir 	= Dir
	bullet.Spread 	= Vector( 0.01,  0.01, 0 )
	bullet.TracerName = "lvs_laser_red_short"
	bullet.Force	= 10
	bullet.HullSize 	= 30
	bullet.Damage	= 100
	bullet.SplashDamage = 200
	bullet.SplashDamageRadius = 200
	bullet.Velocity = 8000
	bullet.Attacker 	= ent:GetDriver()
	bullet.Callback = function(att, tr, dmginfo)
		local effectdata = EffectData()
			effectdata:SetStart( Vector(255,50,50) ) 
			effectdata:SetOrigin( tr.HitPos )
		util.Effect( "lvs_laser_explosion", effectdata )
	end
	ent:LVSFireBullet( bullet )

	local effectdata = EffectData()
	effectdata:SetStart( Vector(255,50,50) )
	effectdata:SetOrigin( bullet.Src )
	effectdata:SetNormal( Dir )
	effectdata:SetEntity( ent )
	util.Effect( "lvs_muzzle_colorable", effectdata )

	ent:TakeAmmo()

	-- self:GetTurretEnt():PlayAnimation( "idle" )

	if not IsValid( ent.SNDPrimary ) then return end

	ent.SNDPrimary:PlayOnce( 100 + math.cos( CurTime() + ent:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )

end

function ENT:InitWeapons()
	local weapon = {}
	weapon.Icon = Material("lvs/weapons/hmg.png")
	weapon.Ammo = 400
	weapon.Delay = 0.6
	weapon.HeatRateUp = 0.2
	weapon.HeatRateDown = 0.2
	weapon.Attack = function( ent )
		if ent:GetIsCarried() then ent:SetHeat( 0 ) return true end

		-- if (self:GetDriverGunAngles() == 1) then return end
		-- 	ent:GetDriver():PrintMessage( HUD_PRINTCENTER, "NAJPIERW WYŁĄCZ TRYB STACJONARNY ABY STRZELAĆ Z TEJ BRONI" )
		-- return end

		return self:ShootBottomWep(ent)

		
	end
	weapon.OnThink = function( ent, active )
		local base = ent:GetVehicle()

		if IsValid( base ) and base:GetIsCarried() then return end

		-- if (self:GetDriverGunAngles() == 1) then return end

		local AimAngles = ent:GetMainAimAngles()

		-- print(AimAngles)

		local p = math.Clamp(AimAngles.p, -25, 35)
		-- local y = math.Clamp(AimAngles.y, -78, 78)

		ent:ManipulateBoneAngles(2,Angle(AimAngles.y,0,0))
		ent:ManipulateBoneAngles(3,Angle(0,0,p))

	end

	weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	self:AddWeapon( weapon )

	-- self:InitTurret()
	-- self:InitGunner()




	-- self.LegRotate = 0
	-- self.KnockbackAnim = 0

end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
