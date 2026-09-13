--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

local color_lightwhite = Color(250,250,250)
local color_outline = Color(25,25,25,100)
local color_green = Color(39, 174, 96)

function ENT:Draw()
	self:DrawModel()

	

	local Ang = self:GetAngles()
	local Pos = self:GetPos()

	
	cam.Start3D2D(Pos + Ang:Up() * 20.9 + Ang:Forward()*13.5 + Ang:Right()*4, Ang, 0.07 )

		surface.SetDrawColor(color_green)
		surface.DrawRect(0,0, -95, -95 )

		draw.SimpleTextOutlined("100%", "DermaLarge", -47.5, -47.5,  color_lightwhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_outline )

	cam.End3D2D()

	

end




--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
