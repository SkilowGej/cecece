--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/reality_development/bf2_furniture/misc/misc_blaster_turret_stand.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetUseType(SIMPLE_USE)

	self.phys = self:GetPhysicsObject()
	self.phys:EnableMotion(false)
	if (self.phys:IsValid()) then
		self.phys:Wake()
	end
	
	self:SetHealth(500)
	self:SetMaxHealth(500)

	self.turret = ents.Create("prop_physics")
	self.turret:SetModel("models/reality_development/bf2_furniture/misc/misc_blaster_turret_head.mdl")
	self.turret:SetPos(self:GetPos())
	self.turret:SetAngles(self:GetAngles())
	self.turret:Spawn()
	self.turret:SetHealth(self:Health())
	self.turretphys = self.turret:GetPhysicsObject()
	self.turretphys:EnableMotion(false)
	self.turretphys:Wake()
	self.turret:SetParent(self)

	local CREATION = self:GetCreationID()

	timer.Simple(0, function()
		if IsValid(self:GetDeviant_TurretOwner()) then
			self:GetDeviant_TurretOwner().PLAYER_PLACEABLE_TURRET = self
		end
	end)

	self.bullseye = ents.Create("npc_bullseye")
	self.bullseye:SetPos(self:GetPos())
	self.bullseye:SetParent(self)
	self.bullseye:SetHealth(300)
	self.bullseye:Spawn()

	self.bullseye:CallOnRemove("RDV.DESTROY_TURRET",function(ent) 
		local vPoint = self:GetPos()
		local effectdata = EffectData()
		effectdata:SetOrigin( vPoint )
		util.Effect( "Explosion", effectdata )

		self:EmitSound("addoncontent/turret/undeploy.wav")

		self:Remove()
	end)

	if self.SelfDestruct.Enabled then
		timer.Simple(self.SelfDestruct.Time, function()
			if IsValid(self) then
				self.bullseye:Remove()
			end
		end)
	end
	
	for k, v in ipairs(ents.GetAll()) do
		if v:IsNPC() and v:GetClass() ~= "npc_bullseye" then
			v:AddEntityRelationship( self.bullseye, D_HT, 99 )
		end
	end

	self.shootcld = 0
end

hook.Add("PlayerSpawnedNPC", "RDV.TURRET.HATE", function(ply, ent)
	if not ent:IsNPC() then return end

	if ent:GetClass() == "npc_bullseye" then
		return
	end

	for k, v in ipairs(ents.FindByClass("rdv_bf2turret")) do
		if v:IsValid() and v.EnemyNPCs[ent:GetClass()] then
			ent:AddEntityRelationship( v.bullseye, D_HT, 99 )
		end
	end
end)

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos - tr.HitNormal * 0.1
	local SpawnAng = ply:EyeAngles()
	SpawnAng.p = 0
	SpawnAng.y = SpawnAng.y + 90
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:SetAngles( SpawnAng )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:OnRemove()
	if not IsValid(self.turret) then return end
	self.turret:Remove()
end

function ENT:FindTarget()
	local ang = self:GetAngles()
	local pos = self:GetPos()
	if not self.target then
		local l = ents.FindInCone(pos, self:GetRight():GetNormalized(), 2000, math.cos(math.rad(90)))

		for k, v in ipairs(l) do
			if IsValid(v:GetParent()) and v:GetParent():GetClass() == "rdv_bf2turret" then
				continue
			end
			
			if v:IsNPC() or v:IsNextBot() then

				local tr = util.TraceLine( {
					start = self.turret:LocalToWorld(self.turret:OBBCenter()),
					endpos = v:LocalToWorld(v:OBBCenter()),
					filter = {self.turret, self},
					mask = MASK_BLOCKLOS_AND_NPCS,
				} )

				if not tr.Entity:IsValid() or tr.Entity ~= v then
					continue
				end

				if not self.EnemyNPCs[tr.Entity:GetClass()] then continue end

				self.target = v
			end
		end
	else
		if not IsValid(self.target) or self.target:GetPos():DistToSqr(pos) > 2000 ^ 2 or self.target:Health() < 1 then 
			self:TargetLost()
		end
	end
end

function ENT:TargetLost()
	self.target = nil
	self.returntocenter = CurTime() + 2
end

function ENT:Think()
	self:NextThink(CurTime())

	if not IsValid(self.turret) then self:Initialize() return true end

	self:FindTarget()
	self:TurnTurret()
	self:PitchTurret()

	if not IsValid(self.target) then
		self.returntocenter = self.returntocenter or 0

		if self.returntocenter >= CurTime() then
			self.TargetAng = 0
			self.TargetPitch = 0

			return true 
		end

		local ang = self.turret:GetAngles()
		local yaw = self:WorldToLocalYaw(ang.y).y
		if math.abs(self.TargetAng) ~= 70 then
			self.TargetAng = 70
		end
		if math.abs(math.Round(yaw)) >= 70 then
			self.TargetAng = -self.TargetAng

			self:EmitSound("addoncontent/turret/enemy_ding.ogg")
		end
	else
		if self.target:Health() < 1 then 
			return true 
		end

		local EnemyAng = (self.target:LocalToWorld(self.target:OBBCenter()) - self.turret:LocalToWorld(Vector(0, -29.738224, 29.035156))):Angle()

		self.TargetAng = math.Clamp(self:WorldToLocalYaw(EnemyAng.y).y+90, -70, 70)
		
		if math.Clamp(self:WorldToLocalYaw(EnemyAng.y).y+90, -70, 70) ~= self:WorldToLocalYaw(EnemyAng.y).y+90 then self:TargetLost() return true end


		//Why tf does it only work if use the returned roll instead of pitch lmao? well it works so it's best not to question it
		self.TargetPitch = math.Clamp(self:WorldToLocalPitch(EnemyAng.p).r, -45, 45)

		if math.Clamp(self:WorldToLocalPitch(EnemyAng.p).r, -45, 45) ~= self:WorldToLocalPitch(EnemyAng.p).r then self:TargetLost() return true end


		if CurTime() > self.shootcld then
			local pos
			
			if self.shootcycle then
				pos = self.turret:LocalToWorld(Vector(-3.009195, -29.738224, 29.035156))
			else
				pos = self.turret:LocalToWorld(Vector(3.024153, -29.738283, 28.528320))
			end

			self:FireBullets({
                Attacker = self,
                Src = pos,
                Dir = self.turret:GetRight():GetNormalized(),
                Spread = Vector(0.01,0.01,0),
                Num = 1,
                Force = 0.1,
                Tracer = 1,
                Damage = 20,
                TracerName = "tfa_tracer_blue",

			})
			
			if self.shootcycle then
				self.shootcycle = false
			else
				self.shootcycle = true
			end
			self:EmitSound("addoncontent/turret/fire.wav")

			self.shootcld = CurTime() + 0.2
		end

		if !self.foundSound or self.foundSound < CurTime() then

			if !self.shootcld or self.shootcld < CurTime() then
				self:EmitSound("addoncontent/turret/enemy_ding.ogg")
				self.foundSound = CurTime() + 0.07
			end
		end
	end

	return true
end

function ENT:TurnTurret()
	local ang = self.turret:GetAngles()
	local yaw = ang.y
	self.TargetAng = self.TargetAng or 0

	if IsValid(self.target) then
		self.turret:SetAngles(Angle(ang.r, math.ApproachAngle(yaw, self:LocalToWorldYaw(self.TargetAng).y, FrameTime()* self.RotationSpeed), ang.p))
	else
		self.turret:SetAngles(Angle(ang.r, math.ApproachAngle(yaw, self:LocalToWorldYaw(self.TargetAng).y, FrameTime()* (self.RotationSpeed * 2)), ang.p))
	end
end

function ENT:PitchTurret()
	local ang = self.turret:GetAngles()
	local pitch = ang.p
	self.TargetPitch = self.TargetPitch or 0

	self.turret:SetAngles(Angle(ang.r, ang.y, math.ApproachAngle(pitch, self.TargetPitch, FrameTime()*self.RotationSpeed)))
end

function ENT:WorldToLocalYaw(yaw)
	local pos, ang = WorldToLocal( vector_origin, Angle(0, yaw, 0), vector_origin, self:GetAngles() )
	return ang
end

function ENT:LocalToWorldYaw(yaw)
	local pos, ang = LocalToWorld( vector_origin, Angle(0, yaw, 0), vector_origin, self:GetAngles() )
	return ang
end

function ENT:WorldToLocalPitch(pitch)
	local pos, ang = WorldToLocal( vector_origin, Angle(0, 0, pitch), vector_origin, self:GetAngles() )
	return ang
end

function ENT:LocalToWorldPitch(pitch)
	local pos, ang = LocalToWorld( vector_origin, Angle(0, 0, pitch), vector_origin, self:GetAngles() )
	return ang
end

hook.Add("PlayerDisconnected", "RDV.BF2_TURRET.DISCONNECTED", function(ply)
	local TURRET = ply.PLAYER_PLACEABLE_TURRET

	if IsValid(TURRET) then
		TURRET.bullseye:Remove()
	end
end)

hook.Add("PlayerDeath", "RDV.BF2_TURRET.DEATH", function(ply)
	local TURRET = ply.PLAYER_PLACEABLE_TURRET

	if IsValid(TURRET) and TURRET.RemoveOnDeath then
		TURRET.bullseye:Remove()
	end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
