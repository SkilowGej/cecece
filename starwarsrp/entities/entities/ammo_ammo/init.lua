AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.Model = "models/props/g_ammo_bag_6.mdl"
ENT.AmmoType = "ar2"
ENT.AmmoCount = 50

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	phys:Wake()
	
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	timer.Simple(90, function()
		if IsValid(self) then self:Remove() end
	end)
end

function ENT:Use(activator)
	self:InventoryUse(activator)
	self:Remove()
end

function ENT:InventoryUse(activator)
	activator:GiveAmmo(self.AmmoCount, self.AmmoType)
	activator:EmitSound("items/ammo_pickup.wav")
end