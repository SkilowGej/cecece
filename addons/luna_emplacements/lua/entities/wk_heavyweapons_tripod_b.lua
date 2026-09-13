--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Wysoki trójnóg"
ENT.Category = "[WK] Structures: Emplacements"
ENT.Spawnable = true
ENT.LastUse = 0

ENT.WKInteractible = true
ENT.WKInteractionName = "złożyć"
ENT.InteractionTime = 1
ENT.wk_CanPickUp = true
ENT.wk_CanInteract = true
ENT.wk_CanCarry = false
ENT.MiscColor = Color( 255, 255, 255, 255 )

function ENT:SpawnFunction( ply, tr, ClassName )
	if ( !tr.Hit ) then return end

	local ent = ents.Create( ClassName )
	ent.Owner = ply
	ent:SetPos( tr.HitPos + tr.HitNormal * 6 )
	ent:SetAngles( ent:GetAngles() + Angle( 0, 180, 0) )

	ent:Spawn()
	ent:Activate()

	return ent

end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()
	self:SetNWBool( "wk_CanUse", true )

	if SERVER then
		self:SetModel( "models/ordoredactus/emplacements/tripod_b_deployed.mdl" )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:DrawShadow( false )
		local pObj = self:GetPhysicsObject()
		pObj:Wake()
	end
end

function ENT:Use( activator, caller, usetype )
	WKUtils.INTER.WKInteractibleUse( self, activator, caller, usetype )
end

function ENT:WKFinishInteraction( entity, player )
	self:TurnToItem()
end

function ENT:TurnToItem()
	if SERVER then
		self:EmitSound( "WKEmplacements.TripodUndeploy" )
		WKItems.ItemSpawn( "heavyweapons_tripod_b", self:GetPos(), self:GetAngles(), {} )
		self:Remove()
	end
end

function ENT:Think()
	return true
end



--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
