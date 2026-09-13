--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')
include('shared.lua')
function ENT:Initialize()
    self:SetModel('models/props_combine/breenglobe.mdl')
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    if SERVER then self:PhysicsInit(SOLID_VPHYSICS) end
    self:PhysWake()
    self:SetUseType(SIMPLE_USE)
    self:Activate()
    self.dietime = CurTime() + sup_inv.DIETIME
    self.wpn = nil
end
function ENT:Think()
    if CurTime() >= self.dietime then
        self:Remove()
    end
    self:NextThink(CurTime() + 15)
end
function ENT:Use(ply)
    if not self.wpn then return end
    ply:Give(self.wpn)
    self:Remove()
end
function ENT:SetInfo(class)
    self.wpn = class
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
