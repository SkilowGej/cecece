

include("shared.lua")

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

function ENT:Use(ply)
	
	ply:ConCommand("bodyman_openmenu")
	self:EmitSound("luna_sound_effects/shop/purchase_01.mp3", 100, math.random(75,100))
end

-- function ENT:OnTakeDamage( dmginfo )
-- 	self.health = self.health - dmginfo:GetDamage()

-- 	if self.health <= 0 and BODYMAN.ClosetsCanBreak == true then
-- 		local ed = EffectData()
-- 		ed:SetOrigin( self:GetPos() + self:OBBCenter() )

-- 		util.Effect( "Explosion", ed )

-- 		SafeRemoveEntity( self )
-- 	end
-- end

function ENT:Initialize()
	self:SetModel("models/props_furniture/scifi_armory_armorstand.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
	self:SetModelScale(0.8)
end