--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include('shared.lua')

local col1 = Color(0, 0, 0, 0)
local col2 = Color(0, 0, 0, 150)

function ENT:Draw()
	self:DrawModel()
	local maxs = self:OBBMaxs()
	local center = self:OBBCenter()
	local pos = self:LocalToWorld(Vector(maxs.x,0,center.z + 5))
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Right(), -90)
	ang:RotateAroundAxis(ang:Up(), 90)

	cam.Start3D2D(pos, ang, 0.1)
		surface.SetFont(luna.MontBase22)
		local sizex = surface.GetTextSize("" .. self.PrintName) + 20
		-- surface.SetDrawColor(col2)
		draw.RoundedBox(15, sizex * -0.5, -30, sizex, 115, Color(0, 0, 0, 150))
		-- surface.SetDrawColor(col1)
		-- surface.DrawOutlinedRect(sizex * -0.5, -20, sizex, 100, 3)
		draw.SimpleText("" .. self.PrintName, luna.MontBase22, 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText("" .. self.Ressourceamount, luna.MontBase22, 0, 50, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
