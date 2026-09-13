--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include('shared.lua')

function ENT:Initialize()
	self.laserend = nil
	SWRPShield.ents[self] = true
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:OnRemove()
	SWRPShield.ents[self] = nil
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
