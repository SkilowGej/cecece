--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
include('shared.lua')
function ENT:Initialize()
	self:SetModel( "models/jackjack/props/shieldgen.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetUseType(SIMPLE_USE)

	self.phys = self:GetPhysicsObject()
	self.phys:EnableMotion(false)
	if (self.phys:IsValid()) then
		self.phys:Wake()
	end
	
	self:SetHealth(self.health)
	self.usecooldown = 0
	self.isgenerator = true
end

 
function ENT:Use( ply , c )
	if self.usecooldown > CurTime() then return end
	local state = self:GetSequence()
	if state == 0 then
		self:OpenShield()
	elseif state == 3 then
		self:CloseShield()
	end
end

function ENT:Think()
	self:NextThink( CurTime() )
	return true 
end

function ENT:OnRemove()
	if IsValid(self.shield) then 
		self:StopSound("ambient/machines/machine6.wav")
		self.shield:Remove()
	end
end

function ENT:OpenShield()
	self:ResetSequence( 1 )
	self:EmitSound("swrpshield/start.mp3")
	timer.Simple(self:SequenceDuration(1), function()
		if not IsValid(self) then return end
		if self.usecooldown > CurTime() then return end
		if self:GetSequence() != 1 then return end
		self:ResetSequence( 3 )

		self.shield = ents.Create("shield_bubble")
		self.shield:SetModel(self.shieldmodel)
		self.shield:SetPos(self:GetBonePosition(self:LookupBone( "gen" )))
		self.shield:Spawn()
		self.shield.gen = self

		self:EmitSound("ambient/machines/machine6.wav")
	end)

end

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * -1.5
	local SpawnAng = ply:EyeAngles()
	SpawnAng.p = 0
	SpawnAng.y = SpawnAng.y + 180
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:SetAngles( SpawnAng )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:CloseShield()
	self:ResetSequence( 2 )
	if IsValid(self.shield) then 
		self.shield:Remove()
		self:StopSound("ambient/machines/machine6.wav")
	end
	timer.Simple(self:SequenceDuration(2), function()
		if not IsValid(self) then return end
		self:ResetSequence( 0 )
	end)
end

function ENT:Destroyed()
	if self.destroyed then return end
	local effectdata = EffectData()
	effectdata:SetOrigin( self:GetBonePosition(self:LookupBone( "gen" )) )
	util.Effect( "HelicopterMegaBomb", effectdata )

	self:EmitSound("ambient/explosions/explode_7.wav")
	self:SetModel("models/jackjack/props/shieldgen_rekt.mdl")
	if IsValid(self.shield) then 
		self.shield:Remove()
		self:StopSound("ambient/machines/machine6.wav")
		util.ScreenShake(self:GetPos(), 100, 100, 1, 200)
	end

	self.usecooldown = CurTime() + self.disabledtime
	self.destroyed = true
end

function ENT:Repair()
	self:SetHealth(self.health)
	self:SetModel("models/jackjack/props/shieldgen.mdl")
	local effectdata = EffectData()
	effectdata:SetMagnitude(5)
	effectdata:SetScale(1)
	effectdata:SetNormal(self:GetUp():GetNormal())
	effectdata:SetRadius(1)
	effectdata:SetOrigin( self:GetPos() + Vector(0,0,20))
	util.Effect( "Sparks", effectdata )
	self.destroyed = false
end

function ENT:OnTakeDamage( dmginfo )
	if self.destroyed then return 0 end
	local tr = util.TraceLine( {
		start = self:GetPos(),
		endpos = dmginfo:GetAttacker():GetPos(),
		filter = {self}
	} )
	if IsValid(tr.Entity) and tr.Entity == self.shield then return 0 end
	local newhealth = self:Health() - dmginfo:GetDamage()
	self:SetHealth( newhealth )
		if newhealth <= 0 then
			self:Destroyed()
			timer.Simple(self.disabledtime, function()
				if IsValid(self) and self.destroyed then
					self:Repair()
				end
			end)
		end
	return 0
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
