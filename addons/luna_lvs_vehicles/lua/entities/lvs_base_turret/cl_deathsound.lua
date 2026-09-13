--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


function ENT:OnDestroyed()
	if not self.DeathSound then return end

	if self:GetVelocity():Length() <= self.MaxVelocity * 0.5 then return end

	self._sndDeath = CreateSound( self, self.DeathSound )
	self._sndDeath:SetSoundLevel( 125 )
	self._sndDeath:PlayEx( 1, 50 + 50 * self:CalcDoppler( LocalPlayer() ) )
end

function ENT:StopDeathSound()
	if not self._sndDeath then return end

	self._sndDeath:Stop()
end



--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
