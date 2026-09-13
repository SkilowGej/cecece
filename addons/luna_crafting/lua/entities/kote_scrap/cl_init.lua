--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include('shared.lua')

function ENT:Draw()
	self:DrawModel()
	local camangle = EyeAngles()
	local campos = EyePos()
	cam.Start3D2D(self:GetPos() + Vector(0, 0, 30), Angle(0, camangle.y - 90, 90), 0.1)
	surface.SetDrawColor(255, 255, 255, 255 - campos:DistToSqr(self:GetPos()) / 500)
	surface.DrawLine(0, 200, 100, 0)
	-- draw.RoundedBox(0, 100, 0, 160, 50, Color(7, 110, 203, 255 - campos:DistToSqr(self:GetPos()) / 500))
	-- surface.SetDrawColor(255, 255, 255, 255 - campos:DistToSqr(self:GetPos()) / 500)
	-- surface.DrawOutlinedRect(100, 0, 160, 50, 2)
	draw.SimpleText("Materiał", kotecraftsysspawnpoint3d2dfont, 105, 0, Color(255, 255, 255, 255 - campos:DistToSqr(self:GetPos()) / 500), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	cam.End3D2D()
	self:DrawShadow(true)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
