--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include('shared.lua')

function ENT:Initialize()
	self.StartTime = CurTime()
	self.height = 0
	self.buildtime = 1.5
	self.isshield = true
end

function ENT:Draw()
	local max = self:OBBMaxs()
	if CurTime() >= self.StartTime + self.buildtime then
		self:DrawModel()
	else
		self.height = ( max.z / self.buildtime ) * ( CurTime() - self.StartTime )
		local normal = self:GetUp() 
		local pos = self:LocalToWorld(Vector(0, 0, max.z - self.height))
		local distance = normal:Dot(pos)
		
		render.EnableClipping(true)
		render.PushCustomClipPlane(normal, distance)
		self:DrawModel()
		render.PopCustomClipPlane()
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
