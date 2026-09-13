--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.turretBaseModel="models/macieg/swrp/nohy.mdl"

function ENT:CreateEmplacement()
	local turretBase=ents.Create("prop_physics")
	turretBase:SetModel(self.turretBaseModel)
	turretBase:SetAngles(self:GetAngles()+Angle(0,90,0))
	turretBase:SetPos(self:GetPos())
	turretBase:Spawn()
	self.turretBase=turretBase
	self:SetTurretBase(turretBase)
	
	constraint.NoCollide(self.turretBase,self,0,0)
	
	local shootPos=ents.Create("prop_dynamic")
	shootPos:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	shootPos:SetAngles(self:GetAngles())
	shootPos:SetPos(self:GetPos()-Vector(0,0,0))
	shootPos:Spawn()
	shootPos:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self.shootPos=shootPos
	shootPos:SetParent(self)
    shootPos:Fire("setparentattachment","muzzle")
	shootPos:SetNoDraw(false)
	shootPos:DrawShadow(false)
	--shootPos:SetColor(Color(0,0,0,0))
	-- self:SetDTEntity(1,shootPos)
	self:SetShootPos(shootPos)
	
end


ENT.BasePos=Vector(0,0,0)
ENT.BaseAng=Angle(0,0,0)

ENT.OffsetPos=Vector(0,0,0)
ENT.OffsetAng=Angle(0,0,0)

ENT.Shooter=nil --player.GetHumans()[1]
ENT.ShooterLast=nil



function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 10
	local SpawnAng = ply:EyeAngles()
	SpawnAng.p = 0
	SpawnAng.y = SpawnAng.y-- + 180
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:SetAngles( SpawnAng )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end


function ENT:Initialize()
	
	self:SetModel("models/macieg/swrp/turret.mdl")
	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
	
	local phys = self.Entity:GetPhysicsObject()
	
	if IsValid( phys ) then
	
		phys:Wake()
		phys:SetVelocity( Vector( 0, 0, 0 ) )

	end

	self.ShadowParams = {}
	
	self:StartMotionController()
	if not IsValid(self.turretBase) then
		self:CreateEmplacement()
	end
	self.ShotSound=Sound("eweb_fire_turret")
	self.EmptySound = Sound("Weapon_Pistol.Empty")
	self:SetUseType(SIMPLE_USE)
	self.MuzzleAttachment=self:LookupAttachment("muzzle")
	self.HookupAttachment=self:LookupAttachment("hookup")
	self:DropToFloor()

	local phys = self.turretBase:GetPhysicsObject()

	if IsValid( phys ) then
		timer.Simple(0.5, function()
			if (!self) or (!IsValid(self)) then return end
			if (!phys) or (!IsValid(phys)) then return end
			phys:EnableMotion(false)
		end)
	end

	self.maxAmmo = 500
	self:SetTAmmo(self.maxAmmo)

	self.shootPos:SetRenderMode(RENDERMODE_TRANSCOLOR)
	self.shootPos:SetColor(Color(255,255,255,1))

	self.OffsetAng=self.turretBase:GetAngles()
	self:ManipulateBoneAngles(1, Angle(0,0,0))
	
	sound.Add(
	{
		name = "eweb_fire_turret",
		channel = CHAN_WEAPON,
		volume = 0.7,
		soundlevel = "SNDLVL_GUNFIRE",
		pitchstart = 98,
		pitchend = 110,
		sound = "lvs/vehicles/atte/fire.mp3"
	})
	
end

function ENT:TakeAmmo()
	if (self:GetTAmmo() > 0) then
		self:SetTAmmo(self:GetTAmmo() - 1)
	end
end


function ENT:StartTouch(ent)
-- function ENT:ReplaceBattery(ent)

	if (IsValid(ent)) and (ent:GetClass() == "turret_eweb_ammo") then

		if (self:GetTAmmo() < self.maxAmmo) then
			self:SetTAmmo(self.maxAmmo)
			self:EmitSound("ambient/machines/pneumatic_drill_"..math.random(1,4)..".wav")
			ent:Remove()
		end

	end

end

function ENT:OnRemove()
	
	--> On remove fix!
	if self:GetShooter() != nil then

		net.Start("TurretBlockAttackToggle")
		net.WriteBit(false)
		net.Send(self:GetShooter())
		self:SetShooter(nil)
		self:FinishShooting()
		-- self.Shooter=nil

	end
	
	SafeRemoveEntity(self.turretBase)
	SafeRemoveEntity(self.MagazineCollider)
end

function ENT:StartShooting()
    self:GetShooter():DrawViewModel(false)
    net.Start("TurretBlockAttackToggle")
    net.WriteBit(false)
    net.Send(self:GetShooter())
end

function ENT:FinishShooting()
	if IsValid(self.ShooterLast) then
		self.ShooterLast:DrawViewModel(true)
		
		net.Start("TurretBlockAttackToggle")
		net.WriteBit(false)
		net.Send(self.ShooterLast)
		self.ShooterLast=nil
	end
end





function ENT:GetDesiredShootPos()
	local shootPos=self:GetShooter():GetShootPos()
	local playerTrace=util.GetPlayerTrace( self:GetShooter() )
	playerTrace.filter={self:GetShooter(),self,self.turretBase}

	local shootTrace=util.TraceLine(playerTrace)
	return shootTrace.HitPos
end


function ENT:PhysicsSimulate( phys, deltatime )
	
	phys:Wake()

	if not IsValid(self.turretBase) then
		self:CreateEmplacement()
	end
 
	self.ShadowParams.secondstoarrive = 0.01 
	self.ShadowParams.pos = self.BasePos + self.turretBase:GetUp()*-0.1
	self.ShadowParams.angle =self.BaseAng+Angle(0,self.OffsetAng.y,0)--self.OffsetAng+Angle(0,0,0)
	self.ShadowParams.maxangular = 5000
	self.ShadowParams.maxangulardamp = 10000
	self.ShadowParams.maxspeed = 1000000 
	self.ShadowParams.maxspeeddamp = 10000
	self.ShadowParams.dampfactor = 0.8
	self.ShadowParams.teleportdistance = 200
	self.ShadowParams.deltatime = deltatime
 
	phys:ComputeShadowControl(self.ShadowParams)
	
 
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
