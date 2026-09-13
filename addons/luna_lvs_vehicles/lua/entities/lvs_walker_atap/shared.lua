--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


ENT.Base = "lvs_walker_atte_hoverscript"

ENT.PrintName = "AT-AP"
ENT.Author = "Luna"
ENT.Information = "Assault Walker of the Galactic Republic"
ENT.Category = "[LVS] - Johny's Star Wars"

ENT.Spawnable		= true
ENT.AdminSpawnable	= false

ENT.MDL = "models/sw/atot_veh/AT-AP.mdl"
ENT.GibModels = {
	"models/sw/atot_veh/AT-AP.mdl",
	"models/sw/atot_veh/AT-AP_legBig0.mdl",
	"models/sw/atot_veh/AT-AP_legBig1.mdl",
	"models/sw/atot_veh/AT-AP_legBig2.mdl",
	"models/sw/atot_veh/AT-AP_legBig3.mdl",
	"models/sw/atot_veh/AT-AP_legSmall0.mdl",
	"models/sw/atot_veh/AT-AP_legSmall1.mdl",
	"models/sw/atot_veh/AT-AP_legSmall2.mdl",
	"models/sw/atot_veh/AT-AP_legSmall3.mdl",
}

ENT.AITEAM = 2

ENT.MaxHealth = 6000

ENT.ForceLinearMultiplier = 1

ENT.ForceAngleMultiplier = 1
ENT.ForceAngleDampingMultiplier = 1

ENT.HoverHeight = 215
ENT.HoverTraceLength = 300
ENT.HoverHullRadius = 50

ENT.TurretTurnRate = 100

ENT.LAATC_PICKUPABLE = true
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
	self:AddDT( "Entity", "RearEntity" )
	self:AddDT( "Entity", "TurretSeat" )
	self:AddDT( "Entity", "GunnerSeat" )

	self:AddDT( "Int", "CannonMode" )
	self:AddDT( "Int", "DriverGunAngles" )

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

function ENT:GetBottomAimAngles()
	local trace = self:GetEyeTrace()

	local AimAngles = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld( Vector(265,0,100)) ):GetNormalized():Angle() )

	local ID = self:LookupAttachment( "gunB" )
	local Muzzle = self:GetAttachment( ID )

	if not Muzzle then return AimAngles, trace.HitPos, false end

	local DirAng = self:WorldToLocalAngles( (trace.HitPos - self:GetDriverSeat():LocalToWorld( Vector(0,0,33) ) ):Angle() )

	return AimAngles, trace.HitPos, (math.abs( DirAng.p ) < 22 and math.abs( DirAng.y ) < 55)
end

function ENT:GetMainAimAngles()
	local trace = self:GetEyeTrace()

	local AimAngles = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld( Vector(265,0,100)) ):GetNormalized():Angle() )

	local ID = self:LookupAttachment( "gunM" )
	local Muzzle = self:GetAttachment( ID )

	if not Muzzle then return AimAngles, trace.HitPos, false end

	local DirAng = self:WorldToLocalAngles( (trace.HitPos - self:GetDriverSeat():LocalToWorld( Vector(0,0,33) ) ):Angle() )

	-- print(DirAng.p)

	return AimAngles, trace.HitPos, (math.abs( DirAng.p ) < 21 and math.abs( DirAng.y ) < 11)
end

-- function ENT:GetAimAngles( ent, base, RearEnt )
-- 	local trace = self:GetEyeTrace()

-- 	local Pos = self:LocalToWorld( Vector(208,0,170) )
-- 	local wAng = (trace.HitPos - Pos):GetNormalized():Angle()

-- 	local _, Ang = WorldToLocal( Pos, wAng, Pos, self:LocalToWorldAngles( Angle(0,0,0) ) )

-- 	return Ang, trace.HitPos, (Ang.p < 30 and Ang.p > -10 and math.abs( Ang.y ) < 60)
-- end

function ENT:ShootBottomWep(ent)

	local ID1 = ent:LookupAttachment( "gunB" )

	local Muzzle1 = ent:GetAttachment( ID1 )

	if not Muzzle1 then return end

	local AimAngles, AimPos, InRange = ent:GetBottomAimAngles()

	local Pos = Muzzle1.Pos
	local Dir = (AimPos - Pos):GetNormalized()

	if not InRange then return true end

	local bullet = {}
	bullet.Src 	= Pos
	bullet.Dir 	= Dir
	bullet.Spread 	= Vector( 0.01,  0.01, 0 )
	bullet.TracerName = "lvs_laser_blue_short"
	bullet.Force	= 10
	bullet.HullSize 	= 30
	bullet.Damage	= 100
	bullet.SplashDamage = 200
	bullet.SplashDamageRadius = 200
	bullet.Velocity = 8000
	bullet.Attacker 	= ent:GetDriver()
	bullet.Callback = function(att, tr, dmginfo)
		local effectdata = EffectData()
			effectdata:SetStart( Vector(50,50,255) ) 
			effectdata:SetOrigin( tr.HitPos )
		util.Effect( "lvs_laser_explosion", effectdata )
	end
	ent:LVSFireBullet( bullet )

	local effectdata = EffectData()
	effectdata:SetStart( Vector(50,50,255) )
	effectdata:SetOrigin( bullet.Src )
	effectdata:SetNormal( Dir )
	effectdata:SetEntity( ent )
	util.Effect( "lvs_muzzle_colorable", effectdata )

	ent:TakeAmmo()

	if not IsValid( ent.SNDPrimary ) then return end

	ent.SNDPrimary:PlayOnce( 100 + math.cos( CurTime() + ent:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )

end

local KnockBackAngle = Angle(2,0,0)

function ENT:ShootMainCannon(ent)

	local ID1 = ent:LookupAttachment( "gunM" )

	local Muzzle = ent:GetAttachment( ID1 )

	if not Muzzle then return end

	local AimAngles, AimPos, InRange = ent:GetMainAimAngles()

	local Pos = Muzzle.Pos
	local Dir = (AimPos - Pos):GetNormalized()

	if not InRange then return true end
	
	self:SetAngles(self:GetAngles() - KnockBackAngle)
	timer.Simple(0.1, function()
		if (!self) or (!IsValid(self)) then return end
		self:SetAngles(self:GetAngles() + KnockBackAngle)
	end)

	local Driver = ent:GetDriver()

	self:PlayAnimation( "main_shoot" )

	local projectile = ents.Create( "lvs_atap_cannon" )
	projectile:SetPos( Pos )
	projectile:SetAngles( (Dir):Angle() )
	projectile:SetParent( ent )
	projectile:Spawn()
	projectile:Activate()
	projectile:SetAttacker( IsValid( Driver ) and Driver or self )
	projectile:SetEntityFilter( ent:GetCrosshairFilterEnts() )
	projectile:SetSpeed( 4000 )
	projectile._dmg = 1000
	projectile._radius = 500
	projectile:Enable()

	ent:TakeAmmo()

	if not IsValid( ent.SNDPrimaryTurret ) then return end

	ent.SNDPrimaryTurret:PlayOnce( 100 + math.cos( CurTime() + ent:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )

end

function ENT:InitWeapons()
	local weapon = {}
	weapon.Icon = Material("lvs/weapons/hmg.png")
	weapon.Ammo = 1000
	weapon.Delay = 0.3
	weapon.HeatRateUp = 0.2
	weapon.HeatRateDown = 0.2
	weapon.OnSelect = function( ent )
		if IsValid(self:GetDriver()) then
			self:SetDriverGunAngles(0)
		end
	end
	weapon.OnDeselect = function( ent )
		-- self:ManipulateBoneAngles(1,Angle(0,0,0))
	end
	weapon.Attack = function( ent )
		if ent:GetIsCarried() then ent:SetHeat( 0 ) return true end

		if (self:GetDriverGunAngles() == 1) then return end

		return self:ShootBottomWep(ent)

		
	end
	weapon.OnThink = function( ent, active )
		local base = ent:GetVehicle()

		if IsValid( base ) and base:GetIsCarried() then return end

		if (self:GetDriverGunAngles() == 1) then return end

		local AimAngles = ent:GetBottomAimAngles()

		-- print(AimAngles)

		local p = math.Clamp(AimAngles.p, -13, 16)
		local y = math.Clamp(AimAngles.y, -55, 55)

		ent:ManipulateBoneAngles(1,Angle(0,-y,p))

	end

	weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	self:AddWeapon( weapon )

	self:InitTurret()
	-- self:InitGunner()


	/////////////////////////////////
	//////////// CANNON /////////////

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/protontorpedo.png")
	weapon.Ammo = 100
	weapon.Delay = 1
	weapon.HeatRateUp = 1
	weapon.HeatRateDown = 0.1

	weapon.OnSelect = function( ent )
		if IsValid(self:GetDriver()) then
			self:SetDriverGunAngles(1)
		end
	end
	weapon.OnDeselect = function( ent )
		-- self:ManipulateBoneAngles(3,Angle(0,0,0))
	end
	weapon.Attack = function( ent )
		if ent:GetIsCarried() then ent:SetHeat( 0 ) return true end

		if (self:GetCannonMode() == 0) then 
			ent:GetDriver():PrintMessage( HUD_PRINTCENTER, "Enable stationary mode to shoot" )
			-- ent:GetDriver():EmitSound("buttons/button10.wav")
			ent:SetHeat( 0 )
		return true end

		return self:ShootMainCannon(ent)

		-- if (ent.KnockBack) then return end
		-- ent.KnockBack = true
		-- ent.OldAngle = self:GetAngles()



	end
	weapon.OnThink = function( ent, active )
		local base = ent:GetVehicle()

		if IsValid( base ) and base:GetIsCarried() then return end

		if (self:GetDriverGunAngles() == 0) then return end

		local AimAngles = ent:GetMainAimAngles()

		-- print(AimAngles)

		local p = math.Clamp(AimAngles.p, -7, 12)
		local y = math.Clamp(AimAngles.y, -7, 7)

		ent:ManipulateBoneAngles(3,Angle(0,-y,p))

	end

	-- weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	self:AddWeapon( weapon )

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/leg_mover.png")
	weapon.Ammo = -1
	weapon.Delay = 0
	weapon.HeatRateUp = 0
	weapon.HeatRateDown = 0
	weapon.StartAttack = function( ent )
		local T = CurTime()

		if (ent.NextDoor or 0) > T then return end

		local DoorMode = ent:GetCannonMode() + 1

		ent:SetCannonMode( DoorMode )
		
		if DoorMode >= 2 then
			
			ent:EmitSound( "lvs/vehicles/laat/door_large_close.wav" )
			ent:SetCannonMode( 0 )
			
		elseif DoorMode == 1 then
			ent:EmitSound( "lvs/vehicles/laat/door_large_open.wav" )
		end

		ent:OnLegsChanged()

		ent.NextDoor = T + 1
		
	end
	self:AddWeapon( weapon )

	self.LegRotate = 0
	self.KnockbackAnim = 0

end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
