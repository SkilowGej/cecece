--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include('shared.lua')

function ENT:Initialize()
	self:SetColor(Color( 80, 80, 255, 255 ))
	self:SetMaterial("models/shiny")
end

function ENT:Draw()
	self:DrawModel()
	if !LocalPlayer() or !IsValid(LocalPlayer()) or !LocalPlayer():Alive() then return end
	local range = self:GetNWInt("Range")
	local pos = self:GetPos()
	local ang = LocalPlayer():EyeAngles()
	local pos2 = self:GetPos() +Vector(0,0,30)
	ang:RotateAroundAxis(ang:Forward(),90)
	ang:RotateAroundAxis(ang:Right(),90)
	plweap = LocalPlayer():GetActiveWeapon()
	if IsValid(plweap) and plweap:GetClass()=="gmod_tool" and plweap:GetMode() == "kotenpctool_npctool" then
		if LocalPlayer():GetEyeTrace().Entity == self then
			render.SetColorMaterial()
			render.CullMode(MATERIAL_CULLMODE_CW)
			render.DrawSphere( pos, range, 30, 20, Color( 0, 0, 255, 60 ))
			render.CullMode(MATERIAL_CULLMODE_CCW)
			render.DrawSphere( pos, range, 20, 20, Color( 0, 0, 255, 60 ))
		end
		cam.Start3D2D(pos2,Angle(0,ang.y,90),0.5)
			draw.DrawText("Autoassigner","default",0,0,colText,TEXT_ALIGN_CENTER)
			draw.DrawText("Range: "..range,"default",0,10,colText,TEXT_ALIGN_CENTER)
		cam.End3D2D()
		--self:DrawModel()
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
