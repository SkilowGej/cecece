--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include('shared.lua')

function ENT:Draw()
	if LocalPlayer():IsSuperAdmin() then
		self:DrawModel()
		local camangle = EyeAngles()
		local campos = EyePos()
		cam.Start3D2D(self:GetPos() + Vector(0, 0, 30), Angle(0, camangle.y - 90, 90), 0.1)
		draw.SimpleText("Punkt spawania materiału", kotecraftsysspawnpoint3d2dfont, 0, 0, Color(255, 255, 255, 255 - campos:DistToSqr(self:GetPos()) / 500), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		cam.End3D2D()
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
