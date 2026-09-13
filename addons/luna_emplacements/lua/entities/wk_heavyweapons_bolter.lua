--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "wk_heavyweapons_base"
ENT.PrintName = "Heavy Bolter"
ENT.Category = "[WK] Structures: Emplacements"
ENT.Spawnable = false
ENT.Model = "models/ordoredactus/emplacements/heavyweapons_bolter.mdl"

ENT.ClipSize = 200
ENT.ClipCurrent = 200
ENT.ReloadDuration = 10

ENT.AutomaticFrameAdvance = true

function ENT:Draw()
	self:DrawModel()
end

function ENT:AddAmmo( amount )
	self:SetAmmo( self:GetAmmo() + amount )
	if self.ClipCurrent <= 0 then
		timer.Simple( 0.2, function()
			self:EmitSound( "WKEmplacements.WeaponDryfire" )
		end)
		self:ReloadAmmo()
	end
end

function ENT:Attack( WeaponUser )
	--orve.FireHitScanWeaponProfile( ( self:GetPos() + Vector( 0, 0, 100 ) ), -self:GetAngles():Forward(), self, self, "HeavyBolter" )
	
	if SERVER then
		local ID = self:LookupAttachment( "muzzle" )
		local Attachment = self:GetAttachment( ID )

		local ID2 = self:LookupAttachment( "ejector" )
		local Attachment2 = self:GetAttachment( ID2 )

		local effectdata2 = EffectData()
			effectdata2:SetOrigin( Attachment2.Pos )
			effectdata2:SetAngles( Attachment2.Ang )
			effectdata2:SetEntity( self )
			effectdata2:SetScale( 1 )
		util.Effect( "ShellEject", effectdata2, true, true )

		self:AddGestureSequence( self:LookupSequence( "fire" ), true   )
		self:EmitSound("wk_vehicle_bolter1")
		self:RateOfAttack( self, CurTime() + 0.10 )
		self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 2000 )
		util.ScreenShake( self:GetPos(), 2, 1, 0.5, 128 )

		orve.FireHitScanWeaponProfile( Attachment.Pos, Attachment.Ang:Forward(), WeaponUser, self, "HeavyBolter" )

		self:AddAmmo( -1 )
	end
end

function ENT:TurnToItem()
	if SERVER then
		WKItems.ItemSpawn( "heavyweapons_bolter", self:GetPos(), self:GetAngles(), {} )
		self:Remove()
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
