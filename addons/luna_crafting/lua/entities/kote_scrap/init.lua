--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel('models/sterling/crafting_scraps.mdl')
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetSkin(1)
	self:SetUseType(SIMPLE_USE)
	self.ProtalVector = false
	self:SetCollisionGroup(20)
	self:SetNW2Int("kotecraftsys_scrap_value", math.random(kotecraftsysminscrap, kotecraftsysmaxscrap))
	self:SetHealth(500)
	-- Wake the physics object up
	local phys = self.Entity:GetPhysicsObject()

	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Wake()
	end
end

function ENT:Use(activator, caller)
	if IsValid(activator) and activator:IsPlayer() then
		if IsValid(self:GetOwner()) == false then return end
		self:GetOwner():SetNW2Int("kotecraftsys_spawnedscarp", 0)
		self:Remove()
		kotecraftsysgivescarp(activator, self:GetNW2Int("kotecraftsys_scrap_value", 0))
	end
end

function ENT:OnTakeDamage(dmg)
	self:SetHealth(self:Health() - 100)

	if self:Health() <= 0 then
		self:GetOwner():SetNW2Int("kotecraftsys_spawnedscarp", 0)
		self:Remove()
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
