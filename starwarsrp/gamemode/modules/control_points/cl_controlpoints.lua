-- local targets = {
-- 	{ pos = Vector('-3823.510254 -5466.013184 5722.686523'), name = 'A Point', active = true },
-- 	{ pos = Vector('-2764.006592 -3929.118164 5685.696289'), name = 'B Point', active = false },
-- 	{ pos = Vector('-676.363892 -6291.225098 5687.080566'), name = 'C Point', active = false },
-- 	{ pos = Vector('-1620.581787 -10587.125000 7903.734863'), name = 'D Point', active = false },
-- }
-- local point_active_lerp = 0
-- timer.Create('PointActive',1,0,function()
-- 	point_active_lerp = 0
-- end)
local scale = 1
local point_active = 0
local mat_cpp = Material('luna_icons/chess-rook.png', 'smooth noclamp')

hook.Add("HUDPaint", "ControlPoints_HUDPaint", function()
	if not show_task:GetBool() then return end
	local cin = (math.sin(CurTime()) + 1) / 2
	local alpha = ((re.wepSelector.alpha * 255) - 255) * -1
	local col = ColorAlpha(color_white, alpha - (cin * 200 + 40))
	point_active = point_active or 0
	point_active = math.Approach(point_active, point_active, math.Clamp(math.abs((point_active - point_active) * FrameTime() * 2), FrameTime() / 2, 1))
	point_active = point_active + .18

	if point_active >= 80 then
		point_active = 0
	end

	local i = 1
	local controls = ents.FindByClass('control_point')

	for k, ent in pairs(controls) do
		ent.point_lerp = ent.point_lerp or 0
		local pos, ang = ent:GetPos(), ent:GetAngles()
		local data2D = (pos + ang:Up() * 10):ToScreen()
		local text_align = TEXT_ALIGN_CENTER
		local text_name_x, text_name_y = 0, 0
		local text_team_x, text_team_y = 0, 0
		local text_chall_x, text_chall_y = 0, 0
		local draw_dist = true
		local title_color = COLOR_WHITE
		local title_font = luna.MontBaseSmall
		local secondary_font = luna.MontBase12
		-- data2D.x = data2D.x > ScrW()-60 and ScrW()-60 or data2D.x < 60 and 60 or data2D.x
		-- data2D.y = data2D.y > ScrH()-60 and ScrH()-60 or data2D.y < 60 and 60 or data2D.y
		local occupied = ent:GetNWInt("Occupied") > 1 and 1 or ent:GetNWInt("Occupied")
		-- ent.point_lerp = Lerp(FrameTime()*3, ent.point_lerp or occupied, occupied or ent.point_lerp)
		ent.point_lerp = math.Approach(ent.point_lerp, occupied, math.Clamp(math.abs((occupied - ent.point_lerp) * FrameTime() * 2), FrameTime() / 2, 1))
		local fraction_id = ent:GetNWString('Team')
		local fraction = CONTROLPOINT_TEAMS[fraction_id]
		if not fraction then return end

		if table.HasValue(ents.FindInSphere(pos, ent:GetNWInt('Radius')), LocalPlayer()) then
			data2D.x = ScrW() / 2
			data2D.y = 140
			text_align = TEXT_ALIGN_CENTER
			text_name_x, text_name_y = 0, 20
			text_team_x, text_team_y = 0, 15
			text_chall_x, text_chall_y = 0, 20
			draw_dist = false
			title_font = luna.MontBlack38
			title_color = ColorAlpha(fraction.color, alpha)
			secondary_font = luna.MontBaseHud
		end

		local x = data2D.x <= 50 and 50 or data2D.x >= ScrW() - 50 and ScrW() - 50 or data2D.x
		local y = data2D.y <= 50 and 50 or data2D.y >= ScrH() - 50 and ScrH() - 50 or data2D.y

		draw.Arc({
			y = y,
			x = x
		}, 0, 360, 40 * scale, 6, 10 * scale, Color(0, 0, 0, alpha - 140))

		render.ClearStencil()
		render.SetStencilEnable(true)
		render.SetStencilWriteMask(255)
		render.SetStencilTestMask(255)
		render.SetStencilReferenceValue(25)
		render.SetStencilFailOperation(STENCIL_REPLACE)

		draw.Arc({
			y = y,
			x = x
		}, 0, 360, 40 * scale, 6, 10 * scale, Color(255, 255, 255, alpha))

		render.SetStencilCompareFunction(STENCIL_EQUAL)
		draw.NoTexture()

		draw.Arc({
			y = y,
			x = x
		}, 0, ent.point_lerp * 360, 60 * scale, 32, 45 * scale, col)

		render.SetStencilEnable(false)

		draw.Arc({
			y = y,
			x = x
		}, 0, 360, 27 * scale, 6, 27 * scale, ColorAlpha(fraction.color, alpha - 90))

		if occupied ~= 1 then
			draw.Arc({
				y = y,
				x = x
			}, 0, 360, 40 * scale + point_active, 6, 1, Color(255, 255, 255, 255 - point_active * 28))
		end

		local dist = math.sqrt(LocalPlayer():GetPos():DistToSqr(ent:GetPos())) * 0.01905
		local icon_size = 32 * scale
		draw.Icon(x - icon_size / 2, y - icon_size / 2, icon_size, icon_size, CONTROLPOINT_ICONS[ent:GetNWString('Icon')] or mat_cpp, ColorAlpha(color_white, alpha))
		draw.ShadowSimpleText(ent:GetNWString('Name') or ent, title_font, x + text_name_x, y + 44 + text_name_y, col, text_align, 1, 1, Color(0, 0, 0, alpha))

		if fraction_id ~= 0 then
			draw.ShadowSimpleText(fraction.name or '', secondary_font, x + text_team_x, y + 75 + text_team_y, col, text_align, 1, 1, Color(0, 0, 0, alpha))
		end

		if draw_dist then
			draw.ShadowSimpleText(math.Round(dist, 1) .. 'м', luna.MontBaseSmall, x, y + 65, col, text_align, 1, 1, Color(0, 0, 0, alpha))
		end

		if ent:GetNWBool("Challenging") then
			draw.ShadowSimpleText('Wyzwanie', secondary_font, x + text_chall_x, y + 52 + text_chall_y, Color(253, 220, 84, 90), text_align, 1, 1, Color(0, 0, 0, 190))
		end

		local line_wide = 100
		-- local x = ((ScrW() / 2) - ((line_wide + 2) * i)) + (#controls * line_wide) / 2
		local x, y = ScrW() - line_wide - 10, 30 * i + 200

		if fraction then
			draw.RoundedBox(0, x, y, line_wide, 4, Color(0, 0, 0, 130))
			draw.RoundedBox(0, x, y, occupied * line_wide, 4, ColorAlpha(fraction.color, 255))
			draw.SimpleText(ent:GetNWString("Name"), luna.MontBase18, x + 100, y - 4, Color(255, 255, 255, 190), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
			i = i + 1
		end
	end
end)

hook.Add("PostDrawTranslucentRenderables", "ControlPoints_PostDrawTranslucentRenderables", function(bDepth, bSkybox)
	render.SetColorMaterial()

	for k, ent in pairs(ents.FindByClass('control_point')) do
		local fraction = CONTROLPOINT_TEAMS[ent:GetNWString('Team')]
		if not fraction then return end
		render.DrawSphere(ent:GetPos(), ent:GetNWInt('Radius'), 30, 30, ColorAlpha(fraction.color, 2))
		render.DrawSphere(ent:GetPos(), -ent:GetNWInt('Radius'), 30, 30, ColorAlpha(fraction.color, 2))
	end
end)