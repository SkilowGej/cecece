--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Heavy Rocket"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

function ENT:Initialize()
	if CLIENT then return end

	self:SetModel( "models/ordoredactus/emplacements/rocket.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )

	self:SetCollisionGroup ( COLLISION_GROUP_PROJECTILE )

	local phys = self:GetPhysicsObject()

	phys:EnableGravity( false )
	phys:EnableDrag(false)
	phys:EnableDrag(false)
	phys:Wake()

	ParticleEffectAttach("wk_explosives_rocket_trail", 4, self, 1 )

	phys:SetVelocityInstantaneous( self:GetAngles():Forward() * 4000 )

	constraint.NoCollide( self, self.Owner, 0, 0 )
	constraint.NoCollide( self, self.SourceWeapon, 0, 0 )
	constraint.NoCollide( self, self.SourceWeaponMount, 0, 0 )

	self.snd = CreateSound(self, "weapons/flaregun/burn.wav")
	self.snd:Play()
end

function ENT:Think()
	if CLIENT then return end

	local LaserAttachment = self.SourceWeapon:GetAttachment( 2 )

	local tr = util.TraceLine( {
		start = LaserAttachment.Pos,
		endpos = LaserAttachment.Pos + LaserAttachment.Ang:Forward() * 99999,
		filter = { self, self.SourceWeapon },
	} )

	local currentangle = self:GetAngles()
	local targetangle = ( tr.HitPos - self:WorldSpaceCenter()):Angle()
	ang = WKUtils.ApproachAngle( currentangle, targetangle, 0.3 )
	self:SetAngles( ang )
	

	local phys = self:GetPhysicsObject()
	phys:SetVelocityInstantaneous( ang:Forward() * 4000)

	local FixTick = FrameTime() * 66.666

	local trace = util.TraceHull( {
		start = self:GetPos(),
		endpos = self:GetPos() + self:GetVelocity():Angle():Forward()  * FixTick,
		filter = { self.Owner, self, self.SourceWeapon, self.SourceWeaponMount },
		mins = Vector( -5, -5, -5 ),
		maxs = Vector( 5, 5, 5 ),
		mask = MASK_PLAYERSOLID
	} )

	if trace.Hit then
		self:SetPos( trace.HitPos )
		self:Explode()
	end

	self:NextThink(CurTime())
	return true
end

function ENT:PhysicsCollide( data )
	self:Explode()
end
	
function ENT:Explode()
	ParticleEffect( "WKExplosives.HE.3", self:GetPos(), Angle( 0, 0, 0) )
		sound.Play( "^wk_explosives/grenade_explosion.wav", self:GetPos(), 100, 100, 1 )
		local dmginfo2 = DamageInfo()
			dmginfo2:SetDamageType( DMG_BLAST ) 
			dmginfo2:SetDamage( 7500 )
			dmginfo2:SetAttacker( self.Owner )
			dmginfo2:SetInflictor( self )
		util.BlastDamageInfo( dmginfo2, self:GetPos(), 300 ) 
	self:Remove()
end

function ENT:OnRemove()
	if SERVER then
		self.snd:Stop()
	end
end

function ENT:Draw()
	self:DrawModel()
end

sound.Add({
    name = "wk_rocket_start",
	channel = CHAN_AUTO,
	volume = 1,
	level = 90,
	pitch = {95,105},
	sound = { "wk_weapons/rocket_start.mp3" }
})

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
