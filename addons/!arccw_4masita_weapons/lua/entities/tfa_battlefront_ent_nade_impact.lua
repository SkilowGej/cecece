--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "arccw_thr"
ENT.Spawnable = false

function ENT:Draw()
    self:DrawModel()
end

function ENT:Initialize()
    if SERVER then
        self:SetModel( "models/forrezzur/impactgrenade.mdl" )
        self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    if (IsValid(phys)) then
        phys:SetMass(1)
    end
        self:DrawShadow( true )
    end
    self.ExplodeTimer = CurTime() + 100000
end

function ENT:PhysicsCollide( data, phys )
    if  (20 < data.Speed and 0.25 < data.DeltaTime) then
    self.ExplodeTimer = 0
    end
end

function ENT:Think()
    if SERVER and (self.ExplodeTimer and self.ExplodeTimer <= CurTime()) then
        self:Explode()
    end
    self:NextThink(CurTime())
    return true
end

function ENT:Explode()
	local effectdata = EffectData()
    effectdata:SetOrigin( self:GetPos() )
    util.Effect("Explosion", effectdata)
    util.BlastDamage( self, self.Owner, self:GetPos(), 150, 100 )
    local spos = self:GetPos()
    local trs = util.TraceLine({start=spos + Vector(0,0,64), endpos=spos + Vector(0,0,-32), filter=self})
    util.Decal("Scorch", trs.HitPos + trs.HitNormal, trs.HitPos - trs.HitNormal)    
    self:Remove()
end

function ENT:OnRemove()
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
