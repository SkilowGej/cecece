--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

ENT.GlowMat = Material( "sprites/light_glow02_add" )
ENT.GlowColor = Color( 0, 117, 245, 235 )
function ENT:Draw()
	self:DrawModel()

	render.SetMaterial( self.GlowMat )

	local pos = self:GetPos()
	local dir = self:GetForward()

	for i = 0, 30 do
		local Size = ((30 - i) / 30) ^ 2 * 128

		render.DrawSprite( pos - dir * i * 7, Size, Size, self.GlowColor )
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
