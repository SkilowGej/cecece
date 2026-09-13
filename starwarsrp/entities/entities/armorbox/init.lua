-- ==================================================== --
-- =     АКЛАЙ В АРМИИ - ЛОХ  //  ЯЩИК СДЕЛАН МНОЮ    = --
-- ==================================================== --

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/myproject/support_station_lod_high.mdl")
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
	local ent = ents.Create("armorbox")
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:Use(activator, caller )
	-- if ( activator:IsPlayer() ) then 
	-- 	activator:GiveAmmo(50,"Tibanna_MediumDensity")

		-- self.uses = (self.uses - 1)
	-- 	self:SetUses(self:GetUses() - 1)
	-- end

	if ( activator:IsPlayer() ) then
		local armor = activator:Armor()
		self.difference = (200 - armor) 

		if  armor <  200 then
			activator:SetArmor(armor + self.difference) --армор выдавать?
			self:SetUses(self:GetUses() - 1)
		end
	end

	if (self:GetUses() < 1) then --если нет патронов, ящик пропадает :(
		self.Entity:Remove()
	end
end



