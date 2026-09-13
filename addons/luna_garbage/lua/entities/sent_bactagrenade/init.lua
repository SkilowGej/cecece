--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
 
function ENT:Initialize()
 
    -- Set up the entity
    self.Entity:SetModel( "models/riddickstuff/bactagrenade/bactanade.mdl" )
 
	self.Entity:PhysicsInit( SOLID_BSP )
    self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
    self.Entity:SetSolid( SOLID_BSP )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
    self.Entity:SetColor( Color( 255, 255, 255, 255 ) )
        
    self.Index = self.Entity:EntIndex()
        
    local phys = self.Entity:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end
 
function ENT:PhysicsCollide( data, physobj )
    local entowner = self.Entity:GetOwner()
    local healAmount = 50
    local healRadius = 500

    local tobehealed = ents.FindInSphere( self.Entity:GetPos(), healRadius )
    for _, v in pairs( tobehealed ) do
        if v:IsPlayer() then
            if SERVER then
                local maxHealth = v:GetMaxHealth()
                local currentHealth = v:Health()
                local healValue = math.floor(maxHealth * (healAmount / 100))
                local newHealth = math.min(currentHealth + healValue, maxHealth)
                v:SetHealth(newHealth)
                v:EmitSound("items/medshot4.wav", 75, 100)
            end
        end
    end

    self.Entity:EmitSound("bacta/bactapop.wav", 75, 50)
    local effectdata = EffectData() 
    effectdata:SetOrigin( self.Entity:GetPos() )
    util.Effect("effect_bactanade", effectdata)
    self.Entity:Remove()
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
