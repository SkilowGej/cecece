--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "wk_heavyweapons_base"
ENT.PrintName = "Autocannon"
ENT.Category = "[WK] Structures: Emplacements: Emplacements"
ENT.Spawnable = false
ENT.Model = "models/ordoredactus/emplacements/heavyweapons_autocannon.mdl"

ENT.ClipSize = 24
ENT.ClipCurrent = 24
ENT.ReloadDuration = 15

ENT.AutomaticFrameAdvance = true

function ENT:Draw()
	self:DrawModel()
end

function ENT:AddAmmo( amount )
	self:SetAmmo( self:GetAmmo() + amount )
	if self.ClipCurrent <= 0 then
		timer.Simple( 0.5, function()
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
	
		ParticleEffect( "WKWeapons.Cannon1.MuzzleFlash", Attachment.Pos, Attachment.Ang )

		self:AddGestureSequence( self:LookupSequence( "fire" ), true   )
		sound.Play("WKEmplacements.Autocannon1", Attachment.Pos, 100, math.Rand( 90, 110 ), 1)
		
		self:RateOfAttack( self, CurTime() + 0.5 )
		self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 4000 )
		util.ScreenShake( self:GetPos(), 2, 1, 0.5, 128 )

		orve.FireProjectileWeaponProfile( Attachment.Pos + Attachment.Ang:Forward() * 10,  Attachment.Ang:Forward(), WeaponUser, self, "AutocannonHE" )

		self:AddAmmo( -1 )
	end
end

function ENT:CanAttack( self )
	self.NextAttack = self.NextAttack or 0
	return self.NextAttack < CurTime()
end

function ENT:TurnToItem()
	if SERVER then
		WKItems.ItemSpawn( "heavyweapons_autocannon", self:GetPos(), self:GetAngles(), {} )
		self:Remove()
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
