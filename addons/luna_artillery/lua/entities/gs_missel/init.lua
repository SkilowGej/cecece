--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Damage = 15000
ENT.RadiusDamage = 10000

function ENT:Initialize()	
	self:SetModel( "models/weapons/w_missile_launch.mdl" )
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
	self:SetRenderMode( RENDERMODE_TRANSALPHA )

	local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() )
		effectdata:SetEntity( self )
	util.Effect( "lvs_proton_trail", effectdata )

	local phys = self:GetPhysicsObject()
	if phys then
		phys:Wake()
        phys:EnableGravity(false)
	end

	self.TouchWorld = false
end

function ENT:PhysicsUpdate(phys)
    local pos = self:GetPos()
    local ang = self:GetAngles()
    local forward = ang:Right()

	if self.TouchWorld then
		local velocity = Vector(0, 0, -5000)
        phys:SetVelocity(velocity)
	else
		local velocity = self.Direction * 5000
		phys:SetVelocity(velocity)
	end
end

function ENT:PhysicsCollide(data, phys)
	if data.HitEntity == Entity(0) and not self.TouchWorld then
		local projectile = ents.Create( "gs_missel" )
		projectile:SetPos(Vector(self:GetX(), self:GetY(), OBBMapMaxs.z))
		projectile:SetAngles(Angle(90, 0, 0))
		projectile:Spawn()
		projectile:Activate()
		projectile.TouchWorld = true

		self:Remove()
	elseif data.HitEntity == Entity(0) and self.TouchWorld then
		self:Remove()
	end
end

function ENT:Detonate( target )
	if not self.TouchWorld then
		return
	end

	local Pos =  self:GetPos() 

	local effectdata = EffectData()
		effectdata:SetOrigin( Pos )
	util.Effect( "lvs_explosion_small", effectdata )


	util.BlastDamage( self, game.GetWorld(), self:GetPos(), self.RadiusDamage, self.Damage )
	SafeRemoveEntityDelayed( self, FrameTime() )
end

function ENT:OnRemove()
	self:Detonate()
end	

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
