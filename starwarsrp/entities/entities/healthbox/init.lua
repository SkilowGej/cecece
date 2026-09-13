-- ==================================================== --
-- =     АКЛАЙ В АРМИИ - ЛОХ  //  ЯЩИК СДЕЛАН МНОЮ    = --
-- ==================================================== --

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/props/g_medic_bag.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	phys:Wake()
	
	self:SetCollisionGroup( COLLISION_GROUP_WORLD )

	timer.Simple(30, function()
		if IsValid(self) then self:Remove() end
	end)
end

function ENT:SpawnFunction(ply, tr)
	if not tr.Hit then return end

	local SpawnPos = tr.HitPos + tr.HitNormal*16 --базовый спавн, нужный для каждого ентити 
	local ent = ents.Create("healthbox")
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:Use(activator, caller )
	-- if ( activator:IsPlayer() ) then 
	-- 	activator:GiveAmmo(50,"Tibanna_MediumDensity")

	-- 	-- self.uses = (self.uses - 1)
	-- 	self:SetUses(self:GetUses() - 1)
	-- end

	if ( activator:IsPlayer() ) then
		local health = activator:Health()
		self.difference = (200 - health) 

		if  health <  200 then
			activator:SetHealth(health + self.difference) --армор выдавать?
			self:SetUses(self:GetUses() - 1)
		end
	end

	if (self:GetUses() < 1) then --если нет патронов, ящик пропадает :(
		self.Entity:Remove()
	end
end



