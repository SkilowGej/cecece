include("shared.lua")

local icon_size = 150
local mat_wep1 = Material('luna_icons/bomber.png', 'smooth noclamp')

function ENT:Draw()
	self:DrawModel()
	--self:SetSequence(self:LookupSequence("d1_t01_BreakRoom_WatchClock_Sit"))

	if self:GetPos():Distance(LocalPlayer():GetPos()) < 300 then
		local Ang = LocalPlayer():GetAngles()

		Ang:RotateAroundAxis( Ang:Forward(), 90)
		Ang:RotateAroundAxis( Ang:Right(), 90)

		cam.Start3D2D(self:GetPos()+self:GetUp()*80, Ang, 0.05)
			render.PushFilterMin(TEXFILTER.ANISOTROPIC)
				--draw.RoundedBox(0, icon_size*-.6,icon_size*-.5-80,icon_size,icon_size,Color(22, 23, 28, 150))
				--draw.DrawOutlinedRect(icon_size*-.6,icon_size*-.5-80,icon_size,icon_size,Color(255, 255, 255, 150))
				--draw.Icon(icon_size*-.6,icon_size*-.5-80,icon_size,icon_size,mat_wep1,color_white)
				draw.ShadowSimpleText( 'TK-11575 «Darius»', luna.NPC1, -3, 0, COLOR_SECONDARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
				--draw.ShadowSimpleText( 'Офицер Муги', luna.NPC1Neon, -3, 0, Color(17, 148, 240), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
				draw.ShadowSimpleText( 'Zapoznanie się z bazą', luna.NPC2, -3, 70, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
                --draw.ShadowSimpleText( self:GetUses() .. '/30', luna.NPC2, -3, 110, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
			render.PopFilterMin()
		cam.End3D2D()
	end
end