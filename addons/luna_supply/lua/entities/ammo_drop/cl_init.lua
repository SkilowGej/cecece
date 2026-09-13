--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

local icon_size = 700
local mat_wep1 = Material('luna_ui_base/etc/expand.png', 'smooth noclamp')

function ENT:Draw()
	self:DrawModel()
	--self:SetSequence(self:LookupSequence("d1_t01_BreakRoom_WatchClock_Sit"))

	if self:GetPos():Distance(LocalPlayer():GetPos()) < 800 then
		local Ang = LocalPlayer():GetAngles()

		Ang:RotateAroundAxis( Ang:Forward(), 90)
		Ang:RotateAroundAxis( Ang:Right(), 90)

		cam.Start3D2D(self:GetPos()+self:GetUp()*140, Ang, 0.05)
			render.PushFilterMin(TEXFILTER.ANISOTROPIC)
				draw.RoundedBox(0, icon_size*-.6,icon_size*-.5-90,icon_size,icon_size,Color(22, 23, 28, 200))
				draw.DrawOutlinedRect(icon_size*-.6,icon_size*-.5-90,icon_size,icon_size,Color(255, 255, 255, 150))
				draw.Icon(icon_size*-.6,icon_size*-.5-90,icon_size,icon_size,mat_wep1,color_white)
				--draw.ShadowSimpleText( 'Амуниция', "lunaMontHUDPrimary", -3, 0, Color(17, 148, 240), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
				--draw.ShadowSimpleText( 'Амуниция', "font_npc1neon", -3, 0, Color(17, 148, 240), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
				--draw.ShadowSimpleText( 'Выдаёт вам 100 единиц аммуниции', "lunaMontHUDSecondary", -3, 70, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
                --draw.ShadowSimpleText( self:GetUses() .. '/300', "font_npc2", -3, 110, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
			render.PopFilterMin()
		cam.End3D2D()
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
