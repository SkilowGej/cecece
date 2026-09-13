--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Heavy Base"
ENT.Category = "[WK] Structures: Emplacements"
ENT.Spawnable = false

ENT.ClipSize = 100
ENT.ClipCurrent = 100
ENT.ReloadDuration = 10

ENT.AutomaticFrameAdvance = true

function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()
	if SERVER then
		self:SetModel( self.Model )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:DrawShadow( false )
		local pObj = self:GetPhysicsObject()
		pObj:Wake()

		self:SetNWEntity( "User", nil )

		self:StartMotionController()

		self.ShadowParams = {}
		--pObj:EnableMotion( false )
		self.NextUse = 0

		local Attachment = self.Mount:GetAttachment( self.Mount:LookupAttachment( "mount" ) )
		self.TargetAngle = Attachment.Ang

		self:SetNWInt( "ClipCurrent", self.ClipSize )
	end
end

function ENT:StartControl( WeaponUser )
	if not IsValid( WeaponUser ) then return end
	self.NextUse = CurTime() + 0.5
	if SERVER then
		WKUtils.ToggleBlockAttack( WeaponUser, true )
		self:EmitSound( "WKEmplacements.WeaponEnter" )
	end
	WKUtils.SetControlledEmplacement( WeaponUser, self )
	self:SetNWEntity( "User", WeaponUser )
end

function ENT:StopControl( WeaponUser )
	if not IsValid( WeaponUser ) then return end
	self.NextUse = CurTime() + 0.5
	if SERVER then
		WKUtils.ToggleBlockAttack( WeaponUser, false )
		self:EmitSound( "WKEmplacements.WeaponLeave" )
	end
	WKUtils.ResetControlledEmplacement( WeaponUser )
	self:SetNWEntity( "User", nil )
end

function ENT:Use( activator, caller )
	if self.NextUse > CurTime() then return end
	self.NextUse = CurTime() + 0.5
	if not IsValid( self:GetNWEntity( "User", nil ) ) then
		self:StartControl( activator )
		self:SetNWEntity( "User", activator )
	else
		self:StopControl( activator )
		self:SetNWEntity( "User", nil )
	end
end

function ENT:ControlWeapon( WeaponUser )
	if not IsValid( self.Mount ) then return end
	if SERVER then
		local tr = WeaponUser:GetEyeTrace()

		local Muzzle = self:GetAttachment( self:LookupAttachment( "muzzle" ) )
		
		local Mount = self.Mount:GetAttachment( self.Mount:LookupAttachment( "mount" ) )

		local DesiredAngle = WeaponUser:EyeAngles()
		DesiredAngle:Normalize()
		local MountAngle = Mount.Ang
		MountAngle:Normalize()
		local PitchLimit = 30

		local Deviation = - ( DesiredAngle.p + MountAngle.p )
		if Deviation > PitchLimit then 
			DesiredAngle.p = - ( MountAngle.p + PitchLimit )
		elseif Deviation < -PitchLimit then 
			DesiredAngle.p =  ( -MountAngle.p ) + PitchLimit
		end

		local TargetAngle = DesiredAngle 
		self.TargetAngle = Angle( -( TargetAngle.p) , TargetAngle.y + 180, TargetAngle.r)

		local pressKey = IN_BULLRUSH
		if CLIENT and game.SinglePlayer() then
			pressKey=IN_ATTACK
		end
		
		self.Firing = WeaponUser:KeyDown(pressKey)

		if self.Firing then
			if self:CanAttack( self ) then
				self:Attack( WeaponUser )
			end
		end
	end
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

function ENT:GetAmmo()
	return self:GetNWInt( "ClipCurrent", self.ClipCurrent )
end

function ENT:SetAmmo( amount )
	self.ClipCurrent = amount
	self:SetNWInt( "ClipCurrent", self.ClipCurrent )
end

function ENT:ReloadAmmo()
	self:SetNWInt( "ClipCurrent", 0 )
	self:RateOfAttack( self, CurTime() + self.ReloadDuration )
	timer.Create( "ReloadTimer_" .. tostring( self ), self.ReloadDuration / self.ClipSize, self.ClipSize, function()
		if not IsValid( self ) then return end
		self:SetAmmo( self:GetAmmo() + 1 )
	end)
end

function ENT:Attack( WeaponUser )
end

function ENT:CanAttack( self )
	self.NextAttack = self.NextAttack or 0
	return self.NextAttack < CurTime()
end

function ENT:RateOfAttack( self, time )
	self.NextAttack = time
end

function ENT:Think()
	if not IsValid( self.Mount ) then
		self:TurnToItem()
	end
	local WeaponUser = self:GetNWEntity( "User", nil )
	if IsValid( WeaponUser ) then
		self:ControlWeapon( WeaponUser )
		if WeaponUser:GetPos():Distance( self:GetPos() ) > 96 or WeaponUser:Health() <= 0 then
			self:StopControl( WeaponUser )
		end

		if WeaponUser:KeyPressed( IN_USE ) then
			self:StopControl( WeaponUser )
		end
	end

	self:NextThink( CurTime() )
	return true
end

function ENT:TurnToItem()
	if SERVER then
		local entity = ents.Create("wk_item_heavyweapons_bolter")
		entity:SetAngles( self:GetAngles() )
		entity:SetPos( self:GetPos() )
		self:Remove()
		entity:Spawn()
	end
end

function ENT:OnRemove()
	self:StopControl( self:GetNWEntity( "User", nil ) )
end

function ENT:PhysicsSimulate( phys, deltatime )
	if not IsValid( self.Mount ) then return end
	phys:Wake()

	local Attachment = self.Mount:GetAttachment( self.Mount:LookupAttachment( "mount" ) )
 
	self.ShadowParams.secondstoarrive = 0.1 
	self.ShadowParams.pos = Attachment.Pos
	self.ShadowParams.angle = self.TargetAngle
	self.ShadowParams.maxangular = 120
	self.ShadowParams.maxangulardamp = 10000
	self.ShadowParams.maxspeed = 1000000 
	self.ShadowParams.maxspeeddamp = 10000
	self.ShadowParams.dampfactor = 0.3
	self.ShadowParams.teleportdistance = 200
	self.ShadowParams.deltatime = deltatime
 
	phys:ComputeShadowControl(self.ShadowParams)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
