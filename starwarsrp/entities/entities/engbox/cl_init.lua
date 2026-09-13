-- include("shared.lua")

-- function ENT:Initialize()
-- end

-- function ENT:Think()
-- end

-- local icon_size = 128
-- local mat_wep1 = Material('celestia/cwrp/inventory/detonator.png', 'smooth noclamp')

-- function ENT:Draw()
--     self:DrawModel()

--     if self:GetPos():Distance(LocalPlayer():GetPos()) < 300 then
--         local Ang = LocalPlayer():GetAngles()

--         Ang:RotateAroundAxis( Ang:Forward(), 90)
--         Ang:RotateAroundAxis( Ang:Right(), 90)

--         cam.Start3D2D(self:GetPos()+self:GetUp()*20, Ang, 0.05)
--             render.PushFilterMin(TEXFILTER.ANISOTROPIC)
--                 draw.Icon(icon_size*-.6,icon_size*-.5-90,icon_size,icon_size,mat_wep1,color_white)
--                 draw.ShadowSimpleText( 'Пополнение Боезапаса', "font_npc1hit", -3, 0, Color(17, 148, 240), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
--                 draw.ShadowSimpleText( 'дополнительные катриджи для оружия', "font_npc2hit", -3, 70, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
--                 draw.ShadowSimpleText( self:GetUses() .. '/30', "font_npc2hit", -3, 110, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
--             render.PopFilterMin()
--         cam.End3D2D()
--     end
-- end

include("shared.lua")

function ENT:Initialize()
end

function ENT:Think()
end

local icon_size = 200
local mat_wep1 = Material('luna_icons/bullets.png', 'smooth noclamp')

function ENT:Draw()
	self:DrawModel()
	--self:SetSequence(self:LookupSequence("d1_t01_BreakRoom_WatchClock_Sit"))

	if self:GetPos():Distance(LocalPlayer():GetPos()) < 300 then
		local Ang = LocalPlayer():GetAngles()

		Ang:RotateAroundAxis( Ang:Forward(), 90)
		Ang:RotateAroundAxis( Ang:Right(), 90)

		cam.Start3D2D(self:GetPos()+self:GetUp()*18, Ang, 0.05)
			render.PushFilterMin(TEXFILTER.ANISOTROPIC)
				--draw.RoundedBox(0, icon_size*-.6,icon_size*-.5-90,icon_size,icon_size,Color(22, 23, 28, 200))
				--draw.DrawOutlinedRect(icon_size*-.6,icon_size*-.5-90,icon_size,icon_size,Color(255, 255, 255, 150))
				--draw.Icon(icon_size*-.6,icon_size*-.5-90,icon_size,icon_size,mat_wep1,color_white)
				draw.ShadowSimpleText( 'Torba z zapasami', "font_npc1", -3, 0, COLOR_SECONDARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
				--draw.ShadowSimpleText( 'Сумка с припасами', "font_npc1neon", -3, 0, COLOR_SECONDARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
				draw.ShadowSimpleText( 'Wydaje ci 100 sztuk amunicji.', "font_npc2", -3, 70, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
                draw.ShadowSimpleText( self:GetUses() .. '/15', "font_npc2", -3, 110, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
			render.PopFilterMin()
		cam.End3D2D()
	end
end