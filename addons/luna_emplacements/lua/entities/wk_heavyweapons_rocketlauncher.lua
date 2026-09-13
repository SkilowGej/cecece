--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "wk_heavyweapons_base"
ENT.PrintName = "Rocket Launcher"
ENT.Category = "[WK] Structures: Emplacements"
ENT.Spawnable = false
ENT.Model = "models/ordoredactus/emplacements/heavyweapons_rocketlauncher.mdl"

ENT.LastUse = 0
ENT.ClipSize = 100
ENT.ClipCurrent = 100
ENT.ReloadDuration = 6

ENT.AutomaticFrameAdvance = true

function ENT:Draw()
	self:DrawModel()
	if IsValid( self:GetNWEntity( "User", nil ) ) then
		self:SetRenderBounds( Vector(-128,-128,0), Vector(128,128,128), Vector() )

		render.SetMaterial( Material( "effects/laser1" ) )

		local LaserAttachment = self:GetAttachment( 3 )

		local tr = util.TraceLine( {
			start = LaserAttachment.Pos,
			endpos = LaserAttachment.Pos + LaserAttachment.Ang:Forward() * 99999,
			filter = self,
		} )
		
		render.DrawBeam( LaserAttachment.Pos, tr.HitPos, 8*math.Rand(.5,1), 0, 1, Color( 0, 255, 0, 50 + math.random( -50, 50 ) ) )
		render.SetMaterial( Material( "sprites/light_glow02_add" ) )
		render.DrawSprite( LaserAttachment.Pos, 16, 16, Color( 0, 255, 0, 50 ) )
		render.DrawSprite( tr.HitPos, 32, 32, Color( 0, 255, 0, 50 ) )
	end
end

function ENT:AddAmmo( amount )
	self:SetAmmo( self:GetAmmo() + amount )
	if self.ClipCurrent <= 0 then
		self:ReloadAmmo()
	end
end

function ENT:Attack( WeaponUser )
	--orve.FireHitScanWeaponProfile( ( self:GetPos() + Vector( 0, 0, 100 ) ), -self:GetAngles():Forward(), self, self, "HeavyBolter" )
	
	if SERVER then
		local ID = self:LookupAttachment( "muzzle" )
		local Attachment = self:GetAttachment( ID )

		local effectdata = EffectData()
			effectdata:SetOrigin( Attachment.Pos )
			effectdata:SetAngles( Attachment.Ang )
			effectdata:SetEntity( self )
			effectdata:SetAttachment( ID )
			effectdata:SetScale( 5 )
		util.Effect( "wh_cannonmuzzle_medium", effectdata, true, true )

		local effectdata = EffectData()
			effectdata:SetOrigin( Attachment.Pos + Attachment.Ang:Forward() * -100 )
			effectdata:SetAngles( Attachment.Ang + Angle( 0, 180, 0) )
			effectdata:SetEntity( self )
			effectdata:SetAttachment( ID )
			effectdata:SetScale( 5 )
		util.Effect( "wh_cannonmuzzle_medium", effectdata, true, true )

		self:EmitSound("WKEmplacements.BigRocketFire")
		self:RateOfAttack( self, CurTime() + 12 )
		self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 4000 )

		local ID2 = self:LookupAttachment( "start" )
		local Attachment2 = self:GetAttachment( ID2 )
		
		local ang = Attachment2.Ang

		local ent = ents.Create( "wk_projectile_rocket_heavy" )
		ent:SetPos( Attachment2.Pos )
		ent:SetAngles( Attachment2.Ang )
		ent.Owner = WeaponUser
		ent.SourceWeapon = self
		ent.SourceWeaponMount = self
		ent.EntityFilter = { ent, self, self.Mount, WeaponUser }

		ent:Spawn()

		util.ScreenShake( self:GetPos(), 30, 5, 1, 300 )

		self:AddAmmo( -100 )
	end
end

function ENT:TurnToItem()
	if SERVER then
		WKItems.ItemSpawn( "heavyweapons_atgm", self:GetPos(), self:GetAngles(), {} )
		self:Remove()
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
