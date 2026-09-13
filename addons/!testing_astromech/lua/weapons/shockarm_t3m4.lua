--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


if ( CLIENT ) then

	SWEP.PrintName			= "Szok Astromecha"
	SWEP.Slot			= 1
	SWEP.SlotPos			= 1
	SWEP.Author			= "T3M4"
	SWEP.DrawAmmo			= false


	SWEP.DrawCrosshair		= true
	SWEP.ViewModelFlip		= true



end


SWEP.Category		= "SUP • Różne"
SWEP.Purpose		= "It makes your enemy's blood boil inside their bodies."
SWEP.Instructions	= "Hold mouse1 to fire. "
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true

SWEP.ViewModel				= "models/weapons/c_smg1.mdl"
SWEP.WorldModel				= "models/droid_arm/t3m4/t3m4_droid_arm.mdl"


SWEP.ShowViewModel 	= false
SWEP.DrawViewModel 	= false
SWEP.ShowWorldModel 	= true
SWEP.UseHands 		= false


SWEP.VfxMuzzleParticle 		= "tbolt_muzzle"
SWEP.VfxMuzzleRule 		= 2
SWEP.VfxMuzzleColor 		= Color( 100, 130, 255, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 		= 120
SWEP.VfxMuzzleFarZ 		= 420

SWEP.Primary.Automatic		= true
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Ammo		= "none"


-- resource.AddSingleFile( "ambient/energy/electric_loop.wav" )
util.PrecacheSound( "ambient/energy/electric_loop.wav" )
-- resource.AddSingleFile( "common/NULL.wav" )
util.PrecacheSound( "common/NULL.wav" )

sound.Add( {
	name = "scifi.tbolt.fire",
	channel = CHAN_WEAPON, 
	volume = 1, 
	level = 50, 
	pitch = PITCH_NORM,
	sound = "ambient/energy/electric_loop.wav"
} )

local function ResE_CamSmooth(player, pos, angles, fov)
	if player:GetNWBool("re_cam_on") == fasle then
	return false

	elseif player:GetNWBool("re_cam_on") == true then
		angles = player:GetAimVector():Angle()

		local tpos = Vector(0, 0, 60)


		player:SetVar("tp_pos", pos)

		player:SetAngles(angles)
		local tfov = fov 
		
		pos = player:GetVar("tp_pos") or tpos
		
		pos.x = math.Approach(pos.x, tpos.x, math.abs(tpos.x - pos.x))
		pos.y = math.Approach(pos.y, tpos.y, math.abs(tpos.y - pos.y))
		pos.z = math.Approach(pos.z, tpos.z, math.abs(tpos.z - pos.z))
		
		local offset = Vector(0, 0, 0)
		
		offset.x = player:GetNWInt("re_swep_cam_back")
		offset.y = player:GetNWInt("re_swep_cam_right")
		offset.z = player:GetNWInt("re_swep_cam_left")
		
		local t = {}
		t.start = player:GetPos() + pos
		t.endpos = t.start + angles:Forward() * -offset.x
		t.endpos = t.endpos + angles:Right() * offset.y
		t.endpos = t.endpos + angles:Up() * offset.z
		t.filter = player
		local trace = util.TraceLine(t)
		pos = trace.HitPos
		if trace.Fraction < 1 then
			pos = pos + trace.HitNormal * 5
		end
		player:SetVar("tp_viewpos", pos)

		fov = player:GetVar("tp_fov") or tfov

		fov = math.Approach(fov, tfov, math.abs(tfov - fov))
		player:SetVar("tp_fov", fov)

		return GAMEMODE:CalcView(player, pos, angles, fov)
	end
end

hook.Add("CalcView", "ResE_CamSmoothing", ResE_CamSmooth)

function SWEP:Deploy() 
	if SERVER then
		self.CamEnt = ents.Create("prop_dynamic")
		self.CamEnt:SetModel("models/props_junk/PopCan01a.mdl")
		self.CamEnt:Spawn()
		self.CamEnt:SetRenderMode(RENDERMODE_NONE)
		self.CamEnt:SetSolid(SOLID_NONE)
		self.CamEnt:SetMoveType(MOVETYPE_NONE)
		self.CamEnt:SetParent(self.Owner)
		self.CamEnt:SetAngles(self.Owner:GetAngles())
		self.CamEnt:SetPos(self.Owner:GetPos())
		self.Owner:SetViewEntity(self.CamEnt)
		self.Owner:SetNWBool("re_cam_on",true)
	end

	self.Owner:SetNWInt("re_swep_cam_back",85)
	self.Owner:SetNWInt("re_swep_cam_right",0)
	self.Owner:SetNWInt("re_swep_cam_up",65)
end

function SWEP:Holster()
	self:disablecam()

		
	return true
end

function SWEP:disablecam()


	self.Owner:SetNWBool("re_deployed",false);

	if SERVER then
		self.Owner:SetViewEntity(self.Owner);
		self.Owner:SetNWBool("re_cam_on",false);
		if IsValid(self.CamEnt) then
			self.CamEnt:Remove();
		end
	end
end


function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire( CurTime() + 0.08  )

	local cmdDamage = GetConVarNumber( "sfw_damageamp" )

	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()
	local pOwnerEA = self.Owner:EyeAngles()
	local fw = pOwnerEA:Forward()
	
	if ( SERVER ) && ( self.Owner:IsNPC() || self.Owner:KeyDown( IN_USE ) ) then
		if ( !self:CanPrimaryAttack( 19 ) ) then return end
		
		if ( CLIENT ) then return end
		
		local bolt = ents.Create( "sfw_thor_ent" )
		bolt:SetPos( self.Owner:GetShootPos() )
		bolt:SetAngles( pOwnerEA )
		bolt:SetOwner( self.Owner )
		bolt:Spawn()
		
		local physBolt = bolt:GetPhysicsObject()
		physBolt:ApplyForceCenter( pOwnerAV * 2048 )
		
		self:SetNextPrimaryFire( CurTime() + 0.5 )
		

		return
	end

	local cone = ents.FindInCone( pOwnerSP, pOwnerAV, 256, 0 )
	local scan = util.TraceHull( {
		start = pOwnerSP + fw * 32,
		endpos = pOwnerSP + fw * 256,
		filter = function( ent ) if ( IsValid( ent ) && ( ent ~= self.Owner || ent:GetOwner() == self.Owner ) ) then return true end end,
		mins = Vector( -128, -128, -128 ),
		maxs = Vector( 128, 128, 128 ),
		mask = MASK_SHOT_HULL,
		ignoreworld = true
	} )
	local trace = self.Owner:GetEyeTrace()
	local iDmg = 1
	local dissa = 256

	if (IsValid( scan.Entity ) && ( scan.Entity:IsNPC() )) then
		local npc = scan.Entity:GetClass()

		if npc == "npc_antlionguard" then
			iDmg = iDmg * 2
		end
	end

	local ptru = {}
	ptru.Num = 1
	ptru.Spread = Vector( .2, .2 )
	ptru.Tracer = 1
	ptru.TracerName = "tbolt_tracer_cheap"
	ptru.HullSize = 4
	ptru.Distance = dissa
	ptru.Damage = iDmg
	ptru.Force = 0.1
	ptru.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( DMG_ENERGYBEAM ) 
	end
	
	local boff = {}
	boff.Num = 1
	boff.Spread = Vector( 0, 0 )
	boff.Tracer = 0
	boff.HullSize = 4
	boff.Distance = 128
	boff.Damage = 1
	boff.Force = 0.1
	boff.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( DMG_ENERGYBEAM )

		util.ParticleTracerEx( 
			"tbolt_tracer_cheap",
			self.Owner:GetShootPos(),
			tr.HitPos,
			self:EntIndex(),
			0,
			-1
		)
	end

	local bullet = {}
	bullet.Num = 2
	bullet.Src = pOwnerSP
	bullet.Dir = pOwnerAV
	if ( IsValid( scan.Entity ) && ( scan.Entity:IsPlayer() || scan.Entity:IsNPC() ) ) then -- Woo, intelligent lightning. :/ What will come next?
		local tEntitySP = scan.Entity:WorldToLocal( scan.Entity:EyePos() ) 
		local tPosition = scan.Entity:GetPos() + ( tEntitySP / 2 )
		
		bullet.Dir = bullet.Dir + ( tPosition - pOwnerSP ) * 0.002
	end
	bullet.Tracer = 1
	bullet.HullSize = 16
	bullet.TracerName = "tbolt_tracer"
	bullet.Distance = dissa
	bullet.Damage = iDmg
	bullet.Force = 0.1
	bullet.Spread = Vector( .2, .2 )
	bullet.Callback = function( attacker, tr, dmginfo )

		dmginfo:SetDamageType( DMG_ENERGYBEAM )


		
		if ( table.HasValue( cone, scan.Entity ) ) then
			local tEntitySP = scan.Entity:WorldToLocal( scan.Entity:EyePos() ) 
			local tPosition = scan.Entity:GetPos() + ( tEntitySP / 2 )
			
			ptru.Src = tr.HitPos - pOwnerAV * 16
			ptru.Dir = ( tPosition - ptru.Src )
			self.Owner:FireBullets( ptru, false )
		end

		boff.Src = tr.HitPos - pOwnerAV
		boff.Dir = ( tr.Normal + tr.HitNormal )
		self.Owner:FireBullets( boff, false )
	end

	self.Owner:FireBullets( bullet, false )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( -0.2, 0, 0 ) )

	end
end

function SWEP:SecondaryAttack()


	if ( CLIENT ) then
		EmitSound( "common/NULL.wav", self:GetProjectileSpawnPos( true ), self:EntIndex(), CHAN_WEAPON, self.Owner:EntIndex(), 100, bit.bor( SND_IGNORE_NAME, SND_STOP ), 100 )
	end
	
end

function SWEP:Think()

	if (self.Owner:GetAmmoCount("ar2") >= 1)  then
	
		if self.Owner:KeyPressed(IN_ATTACK) then
			if (SERVER) then
				self:EmitSound( "ambient/energy/electric_loop.wav")
			end

		end

		if self.Owner:KeyReleased(IN_ATTACK) then
			if (SERVER) then
				self:StopSound( "ambient/energy/electric_loop.wav" )
			end

		end
	end

	if (self.Owner:GetAmmoCount("ar2") == 0) then
		if self.Owner:KeyPressed(IN_ATTACK) then
			if (SERVER) then
				self:EmitSound( "LoudSpark", 48, 100 )
				self:StopSound( "ambient/energy/electric_loop.wav" )
			end
		end
	end

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end
	if ( SERVER ) then return end
	
--	print( util.GetSurfacePropName( tr.SurfaceProps ) )

	ParticleEffect( "tbolt_hit", tr.HitPos, tr.Normal:Angle(), self )
	sound.Play( "LoudSpark", tr.HitPos, SOUNDLVL_GUNFIRE, math.random( 90, 100 ), 1.0 )
	

	
	return true

end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
