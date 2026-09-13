AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
ENT.JobNPC = true

function ENT:Initialize()
	self:SetModel("models/breen.mdl")
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
end

function ENT:AcceptInput(name, ply)
	if name == "Use" and ply:IsPlayer() then
		net.Start("re.dialogue.Open")
		net.WriteString(self:GetDialogue())
		net.WriteEntity(self)
		net.Send(ply)
	end
end