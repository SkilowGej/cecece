--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

ENT.EngineColor = Color( 255, 50, 0, 255)
ENT.EngineGlow = Material( "sprites/light_glow02_add" )
ENT.EnginePos = {
	Vector(-130,-21,23.2),
	Vector(-130,21,23.2)
}

function ENT:OnSpawn()
end



function ENT:OnFrame()
	self:EngineEffects()
	self:AnimCockpit()
end

function ENT:EngineEffects()
	if not self:GetEngineActive() then return end

	local T = CurTime()

	if (self.nextEFX or 0) > T then return end

	self.nextEFX = T + 0.01

	local THR = self:GetThrottle()

	local emitter = self:GetParticleEmitter( self:GetPos() )

	if not IsValid( emitter ) then return end

	for _, pos in pairs( self.EnginePos ) do
		local vOffset = self:LocalToWorld( pos )
		local vNormal = -self:GetForward()

		vOffset = vOffset + vNormal * 5

		local particle = emitter:Add( "effects/muzzleflash2", vOffset )

		if not particle then continue end

		particle:SetVelocity( vNormal * (math.Rand(500,1000) + self:GetBoost() * 10) + self:GetVelocity() )
		particle:SetLifeTime( 0 )
		particle:SetDieTime( 0.1 )
		particle:SetStartAlpha( 255 )
		particle:SetEndAlpha( 0 )
		particle:SetStartSize( math.Rand(15,25) )
		particle:SetEndSize( math.Rand(0,10) )
		particle:SetRoll( math.Rand(-1,1) * 100 )
		particle:SetColor( 255, 50, 200 )
	end
end

function ENT:AnimCockpit()
	local Driver = self:GetDriver()
	if not self:GetAI() then
		if IsValid( Driver )then
			if self:GetSequence() == self:LookupSequence("TopOpen") then
				self:ResetSequence(self:LookupSequence("TopClose"))
			end
		else
			if self:GetSequence() == self:LookupSequence("TopClose") then
				self:ResetSequence(self:LookupSequence("TopOpen"))
			end
		end
	else
		self:ResetSequence(self:LookupSequence("TopClose"))
	end

	if self:GetIsCarried() == true then
		if self:GetSequence() == self:LookupSequence("TopOpen") then
			self:ResetSequence(self:LookupSequence("TopClose"))
		end
	end
end

function ENT:OnStartBoost()
	self:EmitSound( "lvs/vehicles/tie/boost.wav", 70 )
end

function ENT:OnStopBoost()
	self:EmitSound( "lvs/vehicles/tie/brake.wav", 70 )
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
