--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "wk_heavyweapons_base"
ENT.PrintName = "Lascannon"
ENT.Category = "[WK] Structures: Emplacements"
ENT.Spawnable = false
ENT.Model = "models/ordoredactus/emplacements/heavyweapons_lascannon.mdl"

ENT.LastUse = 0
ENT.ClipSize = 10
ENT.ClipCurrent = 10
ENT.ReloadDuration = 18

ENT.AutomaticFrameAdvance = true

function ENT:Attack( WeaponUser )
	--orve.FireHitScanWeaponProfile( ( self:GetPos() + Vector( 0, 0, 100 ) ), -self:GetAngles():Forward(), self, self, "HeavyBolter" )
	
	if SERVER then
		local ID = self:LookupAttachment( "muzzle" )
		local Attachment = self:GetAttachment( ID )

		local effectdata = EffectData()
			effectdata:SetOrigin( Attachment.Pos )
			effectdata:SetAngles( Attachment.Ang )
			effectdata:SetEntity( self )
			effectdata:SetScale( 2 )
		util.Effect( "wh_lasermuzzle_medium", effectdata, true, true )

		self:AddGestureSequence( self:LookupSequence( "fire" ), true   )
		self:EmitSound("lascannon_fire")
		self:RateOfAttack( self, CurTime() + 4 )
		self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 4000 )

		orve.FireHitScanWeaponProfile( Attachment.Pos, Attachment.Ang:Forward(), WeaponUser, self, "Lascannon" )

		timer.Simple( 3, function()
			if IsValid( self ) then
				self:EmitSound("lascannon_reload")
			end
		end)

		self:AddAmmo( -1 )
	end
end

function ENT:TurnToItem()
	if SERVER then
		WKItems.ItemSpawn( "heavyweapons_lascannon", self:GetPos(), self:GetAngles(), {} )
		self:Remove()
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
