-- ==================================================== --
-- =     АКЛАЙ В АРМИИ - ЛОХ  //  ЯЩИК СДЕЛАН МНОЮ    = --
-- ==================================================== --

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
		self.Entity:SetModel("models/props/g_ammo_bag_6.mdl")
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
	local ent = ents.Create("engbox")
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:Use(activator, caller )
	if ( activator:IsPlayer() ) then 
		activator:GiveAmmo(100,"Tibanna_MediumDensity")
		activator:GiveAmmo(100,"Tibanna_HighDensity")
		activator:GiveAmmo(100,"Tibanna_LowDensity")
		activator:GiveAmmo(100,"grenade")
		activator:GiveAmmo(100,"ar2")
		activator:GiveAmmo(100,"RPG_Round")
		-- self.uses = (self.uses - 1)
		self:SetUses(self:GetUses() - 1)
	end

	-- if ( activator:IsPlayer() ) then
	-- 	local armor = activator:Armor()
	-- 	self.difference = (100 - armor) 

	-- 	if  armor <  100 then
	-- 		activator:SetArmor(armor + self.difference) --армор выдавать?
	-- 	end
	-- end

	if (self:GetUses() < 1) then --если нет патронов, ящик пропадает :(
		self.Entity:Remove()
	end
end



