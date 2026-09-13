--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include('shared.lua')

local mat = Material("color")

local num =  100 ^ 2 
function ENT:Draw()
	local ply = LocalPlayer()
	local ent = ply:GetEyeTrace().Entity
	if ent == self and ply:GetPos():DistToSqr(self:GetPos()) < num then
		render.SetColorMaterial()
		render.SetColorModulation(1, 0, 0)
		self:DrawModel()
	else
		self:DrawModel()
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
