local SkillsMenu = SkillsMenu or nil
local mat_bg = Material("luna_menus/medsys/background.png", "smooth noclamp")
local mat_lock = Material("celestia/fa/128/solid/lock.png", "smooth noclamp")

local start_pos = {
	x = ScrW() / 3,
	y = 200
}

local size = 64
local icon_size = size * 0.5
local circle_size = size / 2
local COLOR_ACTIVE = ColorAlpha(COLOR_HOVER, 165)
-- local logo = Material("renaissance/logo/newzagolovok.png", "smooth noclamp")
local bgscor = Material("luna_menus/medsys/background.png", "smooth noclamp")

-- local replogo = Material("celestia/cwrp/rep1.png", "smooth noclamp")
-- local cislogo = Material("celestia/cwrp/cis2.png", "smooth noclamp")
function OpenSkillsMenu(noalpha)
	local currentLevel = LocalPlayer():GetCharLevel()

	if IsValid(SkillsMenu) then
		SkillsMenu:AlphaTo(0, .4, 0, function()
			SkillsMenu:Remove()
		end)

		return
	end

	SkillsMenu = vgui.Create("Panel")
	SkillsMenu:SetSize(ScrW(), ScrH())
	SkillsMenu:Center()
	SkillsMenu.CharacterCounts = counts
	if not noalpha then
		SkillsMenu:SetAlpha(0)
		SkillsMenu:AlphaTo(255, .4)
	end
	local SkillPanels = {}
	local line_wide = 750
	local charLevel = LocalPlayer():GetCharLevel()
	local charExperience, charNeedExperience = LocalPlayer():GetCharExperience(), LocalPlayer():GetCharNeedExperience()
	local str_points = markup.parse("<font=font_base_30>У вас <color=71, 121, 252><img=materials/celestia/cwrp/rep1.png,32x32,71, 121, 252> " .. (LocalPlayer():GetCharSkillPoints() or 0) .. "</color> оч. навыков и <color=255,215,0><img=materials/celestia/cwrp/hud/currency.png,20x24,255,215,0>" .. formatMoney(LocalPlayer():GetMoney()) .. "</color></font>", 500)

	SkillsMenu.Paint = function(self, w, h)
		local x, y = self:GetPos()
		draw.DrawBlur(0, 0, w, h, 6)
		draw.RoundedBox(0, 0, 0, w, h, COLOR_BG)
		surface.SetMaterial(bgscor)
		surface.SetDrawColor(255, 255, 255, 150)
		surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
		draw.RoundedBox(6, w / 3 - line_wide / 2, h - 100, line_wide, 30, COLOR_BG)
		local exp_percent = charExperience / charNeedExperience
		draw.RoundedBox(6, w / 3 - line_wide / 2, h - 100, line_wide * exp_percent, 30, ColorAlpha(COLOR_WHITE, 230))
		draw.SimpleText(charLevel .. " poziom", "font_base_24", w / 3, h - 110, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		draw.SimpleText(math.Round(charExperience) .. " / " .. math.Round(charNeedExperience), "font_base_18", w / 3 - line_wide / 2, h - 110, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
		-- draw.SimpleText("У вас " .. (LocalPlayer():GetCharSkillPoints() or 0) .. " оч. навыков", "font_base_24", w / 3, h - 40, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		str_points:draw(w / 3, h - 40, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		-- draw.RoundedBox(0,0,0,w,60,Color(44, 62, 80, 180))
		-- draw.RoundedBox(0,0,h-60,w,60,Color(44, 62, 80, 180))
		-- surface.SetMaterial(replogo)
		-- surface.SetDrawColor(Color(5, 5, 5, 50))
		-- surface.DrawTexturedRectRotated(0, h / 2, 500, 500, (CurTime() % 360) * 10)
		-- surface.SetMaterial(cislogo)
		-- surface.SetDrawColor(Color(5, 5, 5, 50))
		-- surface.DrawTexturedRectRotated(w, h / 2, 500, 500, (CurTime() % -360) * 10)
		-- draw.DrawBlur(x, y, self:GetWide(), self:GetTall(), 6)
		-- draw.RoundedBox(0, 0, 0, w, h, COLOR_BG)
		-- surface.SetDrawColor(255, 255, 255, 170)
		-- surface.SetMaterial(mat_bg)
		-- surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
		for _, pnl in pairs(SkillPanels) do
			if not IsValid(pnl) then continue end

			if pnl.tree.prevSkills then
				for _, sk in pairs(pnl.tree.prevSkills) do
					if LocalPlayer():GetCharSkillLevel(sk) <= 0 then
						pnl._Disabled = true
					end
				end
			end

			if not pnl._Disabled and pnl.tree.needLevel >= currentLevel then
				pnl._Disabled = true
			end

			if not pnl._Disabled then
				pnl._Disabled = pnl.tree.disabled
			end

			local x1, y1 = pnl:GetPos()
			local bg_color = pnl._Disabled and Color(100, 100, 100, 90) or pnl.Color or COLOR_BG

			if pnl.prevPanel then
				local x2, y2 = pnl.prevPanel:GetPos()
				surface.SetDrawColor(Color(255, 255, 255, 190))
				-- for i = 1, 6 do
				surface.DrawLine(x1 + (size / 2), y1 + (size / 2), x2 + (size / 2), y2 + (size / 2))
				-- end
			end

			local skill_level = LocalPlayer():GetCharSkillLevel(pnl.unique)

			if LocalPlayer():GetCharSkillLevel(pnl.unique) > 0 then
				bg_color = COLOR_ACTIVE

				if pnl.tree.max_mult and pnl.tree.max_mult > 1 then
					for is = 1, pnl.tree.max_mult do
						draw.RoundedBox(10, x1 + size + 6, y1 + ((is - 1) * 14), 10, 10, skill_level <= is - 1 and COLOR_BG or COLOR_ACTIVE)
					end
				end
			end

			draw.Arc({
				x = x1 + (size / 2),
				y = y1 + (size / 2)
			}, 0, 360, circle_size, 16, circle_size, bg_color)

			surface.SetDrawColor(COLOR_WHITE)
			surface.SetMaterial(pnl.skill.icon)
			surface.DrawTexturedRect(x1 + (icon_size / 2), y1 + (icon_size / 2), icon_size, icon_size)

			if pnl.tree.needLevel >= currentLevel then
				draw.RoundedBox(10, x1 + size / 2 + 6, y1, 60, 20, Color(145, 145, 145, 90))
				surface.SetDrawColor(COLOR_WHITE)
				surface.SetMaterial(mat_lock)
				surface.DrawTexturedRect(x1 + size / 2 + 6 + 4, y1 + 2, 12, 14)
				draw.SimpleText(pnl.tree.needLevel .. "ур.", "font_base_18", x1 + size / 2 + 6 + 20, y1, COLOR_WHITE)
			end

			if IsValid(pnl.prevPanel) and LocalPlayer():GetCharSkillLevel(pnl.prevPanel.unique) <= 0 or pnl._Disabled then
				draw.RoundedBox(10, x1 + size / 2 + 6, y1, 20, 20, Color(145, 145, 145, 90))
				surface.SetDrawColor(COLOR_WHITE)
				surface.SetMaterial(mat_lock)
				surface.DrawTexturedRect(x1 + size / 2 + 6 + 4, y1 + 2, 12, 14)
			end
			-- function ColorReverb(pnl)
			-- 	pnl.Color = color
			-- 	if pnl.prevPanel then
			-- 		ColorReverb(pnl.prevPanel)
			-- 	end
			-- end
			-- ColorReverb(pnl)
		end
	end

	local Model = vgui.Create("DModelPanel", SkillsMenu)
	Model:Dock(RIGHT)
	Model:SetWide(700)
	Model:DockPadding(10, 10, 10, 10)
	Model:SetCamPos(Vector(300, 400, 50))
	Model:SetLookAt(Vector(10, 0, 50))
	Model:SetFOV(10)
	Model:SetModel(LocalPlayer():GetModel())

	function Model:LayoutEntity(Entity)
		self.Entity:SetSequence(self.Entity:LookupSequence("judge_a_idle"))
		self:RunAnimation()
		-- print(self.Entity:LookupSequence( "walk_all" ))
		-- self.Entity:SetSequence(self.Entity:LookupSequence( "walk_all" ))
		if not ClientsideModel then return end
		if self.Scanner then return end
		self.Scanner = ClientsideModel("models/lordtrilobite/starwars/props/bactatank.mdl", RENDERGROUP_OPAQUE)
		if not IsValid(self.Scanner) then return end
		self.Scanner:SetNoDraw(true)
		self.Scanner:SetIK(false)
		self.Scanner:SetModelScale(1)
		self.Scanner:SetPos(Vector(0, 0, -25))
		self.Entity:SetPos(Vector(0, 0, 18))
		-- print(self.Scanner)
	end

	function Model:DrawModel()
		local curparent = self
		local leftx, topy = self:LocalToScreen(0, 0)
		local rightx, bottomy = self:LocalToScreen(self:GetWide(), self:GetTall())

		while curparent:GetParent() ~= nil do
			curparent = curparent:GetParent()
			local x1, y1 = curparent:LocalToScreen(0, 0)
			local x2, y2 = curparent:LocalToScreen(curparent:GetWide(), curparent:GetTall())
			leftx = math.max(leftx, x1)
			topy = math.max(topy, y1)
			rightx = math.min(rightx, x2)
			bottomy = math.min(bottomy, y2)
			previous = curparent
		end

		-- Causes issues with stencils, but only for some people?
		-- render.ClearDepth()
		render.SetScissorRect(leftx, topy, rightx, bottomy, true)
		local ret = self:PreDrawModel(self.Entity)

		if ret ~= false then
			self.Entity:DrawModel()

			if self.Scanner then
				self.Scanner:DrawModel()
			end

			self:PostDrawModel(self.Entity)
		end

		render.SetScissorRect(0, 0, 0, 0, false)
	end

	local Close = vgui.Create("DButton", SkillsMenu)
	Close:SetText("")
	Close:SetSize(32, 32)
	Close:SetPos(SkillsMenu:GetWide() - Close:GetWide() - 20, 20)
	Close:SetZPos(32760)

	Close.Paint = function(self, w, h)
		draw.RoundedBox(6, 0, 0, w, h, COLOR_HOVER)
		draw.SimpleText("X", "font_base_22", w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
	end

	Close.DoClick = function(self)
		surface.PlaySound("sup_sound/scroll.wav")
		SkillsMenu:Remove()
		surface.PlaySound("venty/planeeditor/pe_reset.mp3")
	end

	local Info = vgui.Create("DPanel", SkillsMenu)
	Info:SetText("")
	Info:SetSize(32, 32)
	Info:SetPos(20, 20)
	Info:SetZPos(32760)

	Info.Paint = function(self, w, h)
		draw.RoundedBox(w / 2, 0, 0, w, h, Color(255, 255, 255, 45))
		draw.SimpleText("i", "font_base_24", w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
	end

	Info.reTooltip = true
	Info.reTooltipWide = 400
	Info:SetTooltip([[<font=font_base_small>Każdy gracz otrzymuje punkty umiejętności po osiągnięciu nowego poziomu. Liczba otrzymywanych punktów zależy od poziomu: do 20. poziomu gracz otrzymuje 1 punkt umiejętności za każdy nowy poziom, po 20. poziomie liczba punktów podwaja się i do 30. poziomu gracz otrzymuje 2 punkty za każdy nowy poziom. Po 30. poziomie gracz otrzymuje 4 punkty umiejętności za każdy nowy poziom.

Gracz może wykorzystać zgromadzone punkty umiejętności i KR (walutę gry) do zakupu umiejętności. Każda umiejętność ma swoją indywidualną wartość, która zależy od jej skuteczności.</font>]])
	SkillsMenu.startTime = SysTime()
	surface.PlaySound("venty/planeeditor/pe_open.mp3")
	SkillsMenu:MakePopup()

	function CreateSkills(data, pos, prevPanel)
		for unique, tree in pairs(data) do
			local skill_id = tree.skill_id
			-- local player_skill_level = IsValid(prevPanel) and LocalPlayer():GetCharSkillLevel(prevPanel.unique) or 0
			local Skill = vgui.Create("DButton", SkillsMenu)
			Skill.prevPanel = prevPanel
			Skill:SetSize(size, size)
			local skill = re.skill.FindByID(skill_id)
			Skill:SetText("")
			Skill.unique = unique
			Skill.skill = skill
			Skill.tree = tree
			Skill.reTooltip = true
			Skill.reTooltipNotFix = true
			Skill.reTooltipWide = 280

			local texture = skill.icon:GetName()
			local data = isfunction(tree.data) and tree.data(LocalPlayer(), math.Clamp(LocalPlayer():GetCharSkillLevel(unique) + 1, 1, tree.max_mult or 1)) or {}
			local cost_string = "<font=font_base_small>Koszt:</font>\n" .. (tree.points and "<color=71, 121, 252><font=font_base_24><img=materials/celestia/cwrp/rep1.png,20x20,71, 121, 252> " .. string.Comma(tree.points) .. " punktów. </font></color>\n" or "") .. (tree.cost and "<color=255,215,0><font=font_base_24><img=materials/celestia/cwrp/hud/currency.png,16x20,255,215,0> " .. string.Comma(tree.cost) .. " KR </font></color>" or "")
			local level_string = "<font=font_base_small>Potrzebny " .. tree.needLevel .. " poziom postaci</font>"
			Skill:SetTooltip("<img=" .. string.Right(texture, #texture - 7) .. ",20x20> " .. "<font=font_base_24>" .. skill.name .. "</font>\n" .. "<font=font_base_18>" .. (isfunction(tree.data) and string.format(skill.desc, unpack(data)) or skill.desc) .. "</font>" .. "\n<font=font_base_small>" .. (isfunction(tree.data) and string.format(skill.subdesc, unpack(data)) or skill.subdesc) .. "</font>\n" .. cost_string .. "\n" .. level_string)
			table.insert(SkillPanels, Skill)

			Skill.Paint = function(self, w, h)
				self.Color = self:IsHovered() and Color(255, 255, 255, 90) or COLOR_BG
			end

			Skill.DoClick = function()
				if tree.disabled then
					notification.AddLegacy("Ten skill jest tymczasowo niedostępny", NOTIFY_HINT, 3)

					return
				end

				if tree.needLevel >= currentLevel then
					notification.AddLegacy("Potrzebny " .. tree.needLevel .. " poziom postaci!", NOTIFY_HINT, 3)

					return
				end

				if tree.prevSkills then
					for _, uni in pairs(tree.prevSkills) do
						if LocalPlayer():GetCharSkillLevel(uni) <= 0 then
							notification.AddLegacy("Musisz najpierw aktywować " .. re.skill.FindByID(re.skill.FindTreeByUnique(uni).skill_id).name .. "!", NOTIFY_HINT, 3)

							return
						end
					end
				end

				if not LocalPlayer():isEnoughMoney(tree.cost) then
					notification.AddLegacy("Nie masz wystarczająco KR!", NOTIFY_HINT, 3)

					return
				end

				if not LocalPlayer():isEnoughSkillPoints(tree.points) then
					notification.AddLegacy("Nie masz wystarczająco punktów umiejętności!", NOTIFY_HINT, 3)

					return
				end

				if LocalPlayer():GetCharSkillLevel(unique) >= tree.max_mult then
					notification.AddLegacy("Osiągnięto maksymalny poziom umiejętności!", NOTIFY_HINT, 3)

					return
				end

				netstream.Start("CharSkillBuy", unique)
				UpdateSkills()
			end

			Skill.DoRightClick = function()
				if LocalPlayer():GetCharSkillLevel(unique) <= 0 then
					notification.AddLegacy("Nie posiadasz tej umiejętności, aby ją dezaktywować!", NOTIFY_HINT, 3)

					return
				end

				if tree.needLevel >= LocalPlayer():GetCharLevel() then
					notification.AddLegacy("Potrzebny " .. tree.needLevel .. " poziom postaci!", NOTIFY_HINT, 3)

					return
				end

				if not LocalPlayer():CanResetSkill(unique) and LocalPlayer():GetCharSkillLevel(unique) == 1 then
					notification.AddLegacy("Musisz najpierw dezaktywować poprzednie umiejętności!", NOTIFY_HINT, 3)
					return
				end

				netstream.Start("CharSkillReset", unique)
				UpdateSkills()
			end

			-- draw.Arc({
			-- 	y = circle_size,
			-- 	x = circle_size
			-- }, 0, 360, circle_size, 16, circle_size, self.Color or COLOR_BG)
			-- surface.SetDrawColor(255, 255, 255, 255)
			-- surface.SetMaterial(skill.icon)
			-- surface.DrawTexturedRect(w / 2 - icon_size / 2, h / 2 - icon_size / 2, icon_size, icon_size)
			local current_pos = {
				x = pos.x + (tree.pos and tree.pos.x or 0),
				y = pos.y + (tree.pos and tree.pos.y or 0)
			}

			Skill:SetPos(current_pos.x, current_pos.y)

			if tree.after then
				CreateSkills(tree.after, current_pos, Skill)
			end
		end
	end

	function UpdateSkills()
		for k, v in pairs(SkillPanels) do v:Remove() end
		timer.Simple(0, function()
			CreateSkills(re.skills.tree, start_pos)
		end)
		-- SkillsMenu:Remove()
		-- OpenSkillsMenu(true)
	end

	CreateSkills(re.skills.tree, start_pos)
end

netstream.Hook("OpenSkillsMenu", OpenSkillsMenu)
netstream.Hook("CharSkillBuy", UpdateSkills)
netstream.Hook("CharSkillReset", UpdateSkills)

-- local time = CurTime() + 1
-- hook.Add("Think", "SprawlMenu_Think", function()
-- 	if input.IsKeyDown(KEY_F3) and time <= CurTime() then
-- 		time = CurTime() + 0.3
-- 		OpenSkillsMenu()
-- 	end
-- end)