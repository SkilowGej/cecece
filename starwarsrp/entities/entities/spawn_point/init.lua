AddCSLuaFile('shared.lua')
AddCSLuaFile('cl_init.lua')
include('shared.lua')
function ENT:Initialize()
	self:SetModel('models/maxofs2d/cube_tool.mdl')
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:DrawShadow(false)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Wake()
	end

	self:SetCustomCollisionCheck(true)
end

function ENT:Use(activator, caller)
	-- if not (activator and IsValid(activator)) then return end
	-- local kid = self:GetNetVar('GetPlayerKidnapper')
	-- if kid then
	--     kid:SetHandcuffed(true,activator)
	-- end
	-- self:Remove()
end