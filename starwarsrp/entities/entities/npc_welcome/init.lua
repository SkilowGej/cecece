AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/machine/phoenix/empire_base/prop/stormtrooper_m_02.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	-- Wake the physics object up
	local phys = self.Entity:GetPhysicsObject()

	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Wake()
	end

	self:SetDialogue("welcome")
	self:SetJobName("TK-11575")
end

