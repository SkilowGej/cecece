local DPanel = DPanel or nil
local layout = layout or nil
local PlayerPanels = PlayerPanels or nil
local alpha_lerp = 0
local alpha = 0
local mat_radiowave1 = Material('luna_menus/hud/walkie-talkie.png', 'smooth noclamp')
local mat_radiowave2 = Material('luna_menus/hud/wave.png', 'smooth noclamp')
local mat_gradient1 = Material('luna_menus/hud/gradient1.png', 'smooth noclamp')
local defcons_buttons = {}
local line_wide = 750
local function OpenContextMenu()
	alpha_lerp = 0
	alpha = 0
	surface.PlaySound('sup_sound/deny.wav')
	-- local SearchPanel
	if IsValid(Menu) then
		Menu:SetVisible(true)
	else
		Menu = vgui.Create('DFrame')
		Menu:SetSize(ScrW(), ScrH())
		Menu:SetPos(0, 0)
		Menu:SetDraggable(false)
		Menu:SetTitle('')
		Menu:ShowCloseButton(false)
		Menu:SetAlpha(0)
		Menu:AlphaTo(255, .2, 0)
		--local str_points = markup.parse('<font=luna.MontBase24Markup>У вас <color=71, 121, 252><img=materials/celestia/cwrp/rep1.png,32x32,71, 121, 252> ' .. (LocalPlayer():GetCharSkillPoints() or 0) .. '</color> оч. навыков и <color=255,215,0><img=materials/celestia/cwrp/hud/currency.png,20x24,255,215,0>' .. formatMoney(LocalPlayer():GetMoney()) .. '</color></font>', 500)
		--local charLevel = LocalPlayer():GetCharLevel()
		--local charExperience, charNeedExperience = LocalPlayer():GetCharExperience(), LocalPlayer():GetCharNeedExperience()
		Menu.Paint = function(self, w, h)
			local x, y = self:GetPos()
			alpha = 160
			alpha_lerp = Lerp(FrameTime() * 6, alpha_lerp or 0, alpha or 0) or 0
			-- draw.DrawBlur( x, y, self:GetWide(), self:GetTall(), alpha_lerp/100 )
			draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 180))
			local rating = LocalPlayer():GetNWString('rating') or ''
			rating = rating or ''
			local features = LocalPlayer():GetNetVar('features')
			local features_string = ''
			for i, b in pairs(features or {}) do
				if b then features_string = features_string .. ' • ' .. FEATURES_TO_NORMAL[i].name end
			end

			-- draw.RoundedBox(6, w / 2 - line_wide / 2, h - 100, line_wide, 30, COLOR_BG)
			-- local exp_percent = charExperience / charNeedExperience
			-- draw.RoundedBox(6, w / 2 - line_wide / 2, h - 100, line_wide * exp_percent, 30, ColorAlpha(COLOR_WHITE, 230))
			-- draw.SimpleText(charLevel .. ' уровень', luna.MontBase24, w / 2, h - 110, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
			-- draw.SimpleText(math.Round(charExperience) .. ' / ' .. math.Round(charNeedExperience), luna.MontBase18, w / 2 - line_wide / 2, h - 110, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
			-- str_points:draw(w / 2, h - 40, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.ShadowSimpleText(LocalPlayer():Name(), luna.MontBase54, w - 30, h - 100, team.GetColor(LocalPlayer():Team()), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            
			local money = "Finanse: " .. (LocalPlayer():GetMoney() and formatMoney(LocalPlayer():GetMoney()) or "Niedostępne")
			local infoText = team.GetName(LocalPlayer():Team()) .. ' • ' .. rating .. features_string
			
			local combinedText = money .. ' • ' .. infoText
			
			local moneyWidth = surface.GetTextSize(money)
			
			draw.ShadowSimpleText(combinedText, luna.MontBaseHud, w - 30, h - 58, COLOR_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end

		-- local level = LocalPlayer():GetNW2Int( 'wOS.SkillLevel', 0 )
		-- local xp = LocalPlayer():GetNW2Int( 'wOS.SkillExperience', 0 )
		-- local reqxp = wOS.XPScaleFormula( level )
		-- local lastxp = 0
		-- if level > 0 then
		--     lastxp = wOS.XPScaleFormula( level - 1 )
		-- end
		-- local rat = ( xp - lastxp )/( reqxp - lastxp )
		-- if level == wOS.SkillMaxLevel then
		--     rat = 1
		-- end
		-- draw.RoundedBox( 0, (w - w*0.33 )/2, h-40, w*0.33*1, h*0.02, Color( 25, 25, 25, 90 ) )
		-- surface.SetDrawColor( Color(0,0,0,0) )
		-- surface.DrawOutlinedRect( ( w - w*0.33 )/2, h*0.005, w*0.33, h*0.02 )
		-- surface.DrawRect( (w - w*0.33 )/2, h-40, h*0.005, h*0.02 )
		-- surface.SetDrawColor( color_white )
		-- surface.DrawRect( (w - w*0.33 )/2, h-40, w*0.33*rat, h*0.02 )
		-- draw.ShadowSimpleText( ( level == wOS.SkillMaxLevel and 'MAX' ) or lastxp, luna.MontBase18, ( w - w*0.33 )/2 - w*0.005, h-30, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
		-- draw.ShadowSimpleText( ( level == wOS.SkillMaxLevel and 'LEVEL' ) or reqxp, luna.MontBase18, ( w + w*0.33 )/2 + w*0.005, h-30, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		-- draw.ShadowSimpleText( level..' уровень', luna.MontBase24, w*0.5-4, h-58, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
		-- draw.ShadowSimpleText( formatMoney(LocalPlayer():PS_GetPoints()), luna.MontBase24, w*0.5+4, h-58, Color(92,184,92), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		Menu:MakePopup()
		local Radio = vgui.Create('Panel', Menu)
		Radio:SetSize(200, 300)
		Radio:SetPos(Menu:GetWide() - 200 - 35, 350)
		local Top = vgui.Create('Panel', Radio)
		Top:SetSize(200, 60)
		Top:Dock(TOP)
		Top.Paint = function(self, w, h)
			draw.Icon(w - 48, 0, 48, 48, micro_s and mat_radiowave1 or mat_radiowave2, color_white)
			draw.ShadowSimpleText('Częstotliwość:', luna.MontBase24, 85, 14, COLOR_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		end

		local RadioWang = vgui.Create('DNumberWang', Top)
		RadioWang:SetSize(50, 30)
		RadioWang:SetPos(90, 10)
		RadioWang:SetPaintBorderEnabled(true)
		RadioWang:SetFont(luna.MontBaseHud)
		-- RadioWang:SetText('')
		local radio = LocalPlayer():GetNetVar('radio') and LocalPlayer():GetNetVar('radio') or 0
		RadioWang:SetValue(radio)
		RadioWang:SetZPos(10)
		RadioWang.OnValueChange = function(self, value)
			value = value and value ~= nil and value ~= '' and tonumber(value) >= 100 and 100 or tonumber(value) or 0
			self:SetValue(value)
			netstream.Start('WalkieTalkie.ChangeChannel', {
				channel = value
			})
		end

		RadioWang.Paint = function(self, w, h)
			draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(COLOR_BLACK, 90))
			self:DrawTextEntryText(Color(190, 190, 190, 255), COLOR_HOVER, COLOR_WHITE)
		end

		table.insert(no_close_onedit, RadioWang)
		if RadioScroll and IsValid(RadioScroll) then RadioScroll:Remove() end
		RadioScroll = vgui.Create('DScrollPanel', Radio)
		RadioScroll:Dock(FILL)
		RadioScroll.Paint = function(self, w, h) end -- draw.RoundedBox(2,0,0,w,h,color_white)
		RadioScroll.VBar = RadioScroll:GetVBar()
		RadioScroll.VBar:SetWide(6)
		function RadioScroll.VBar:PerformLayout()
			local Wide = self:GetWide()
			local Scroll = self:GetScroll() / self.CanvasSize
			local BarSize = math.max(self:BarScale() * (self:GetTall() - Wide * 2), 10)
			local Track = self:GetTall() - BarSize
			Track = Track + 1
			Scroll = Scroll * Track
			self.btnGrip:SetPos(0, Scroll)
			self.btnGrip:SetSize(Wide, BarSize)
			self.btnUp:SetPos(0, 0, 0, 0)
			self.btnUp:SetSize(0, 0)
			self.btnDown:SetPos(0, self:GetTall() - 0, 0, 0)
			self.btnDown:SetSize(0, 0)
		end

		RadioScroll.VBar.Paint = function(self, w, h) end
		RadioScroll.VBar.btnGrip.Paint = function(self, w, h) draw.RoundedBox(2, 0, 0, w, h, Color(255, 255, 255, 190)) end
		local RadioList = vgui.Create('DListLayout', RadioScroll)
		RadioList:Dock(FILL)
		RadioList:SetPos(0, 0)
		RadioList.Paint = function(self, w, h) end -- draw.RoundedBox(2,0,0,w,h,ColorAlpha(team.GetColor(v:Team()), 90))
		if radio and radio ~= 0 then
			-- for i = 1, 10 do
			for k, v in pairs(player.GetAll()) do
				if v:GetNetVar('radio') == radio and IsValid(v) and v:Team() then
					-- table.remove(radio_players, k)
					-- radio_players[k] = nil
					local RadioPlayer = vgui.Create('DPanel')
					RadioPlayer:SetTall(32)
					RadioPlayer.Paint = function(self, w, h)
						if not (v and IsValid(v)) then return end
						draw.RoundedBox(2, w - 32 - 4, 2, 4, h - 4, ColorAlpha(team.GetColor(v:Team()), 90))
						draw.Icon(0, 0, w - 36, h, mat_gradient1, color_white)
						draw.SimpleText(v:Name(), luna.MontBase24, w - 45, h / 2, color_white, TEXT_ALIGN_RIGHT, 1)
					end

					local RadioPlayerAvatar = vgui.Create('AvatarImage', RadioPlayer)
					RadioPlayerAvatar:SetSize(32, 32)
					RadioPlayerAvatar:Dock(RIGHT)
					RadioPlayerAvatar:SetPlayer(v, 32)
					RadioList:Add(RadioPlayer)
				end
			end
			-- end
		end

		-- local SaveRadio = vgui.Create( 'DButton', Menu )
		-- SaveRadio:SetSize( 30, 30 )
		-- SaveRadio:SetText('')
		-- SaveRadio:SetPos( Menu:GetWide()-338, 10 )
		-- SaveRadio:SetZPos(10)
		-- SaveRadio.Paint = function( self, w, h )
		-- 	draw.RoundedBox(2, 0, 0, w, h, Color(92,184,92))
		-- 	draw.SimpleText('a', 'Marlett', w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1)
		-- end
		-- SaveRadio.DoClick = function( self )
		-- 	netstream.Start('WalkieTalkie.ChangeChannel', { channel = RadioWang:GetValue() })
		-- 	Menu:Remove()
		-- end
		-- local Person = vgui.Create( 'DButton', Menu )
		-- Person:SetSize( 128, 30 )
		-- Person:SetText('')
		-- Person:SetPos( Menu:GetWide()-172, 10 )
		-- Person:SetZPos(10)
		-- Person.Paint = function( self, w, h )
		-- 	draw.RoundedBox(2, 0, 0, w, h, Color(52, 73, 94))
		-- 	draw.SimpleText('Третье лицо', luna.MontBaseSmall, w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1)
		-- end
		-- Person:SetZPos( -10 )
		-- Person.DoClick = function( self )
		-- 	thirdperson_enabled = not thirdperson_enabled
		-- 	-- Menu:Remove()
		-- end
		local buttons = {
			-- {
			-- 	text = 'ПНВ',
			-- 	doclick = function(self)
			-- 		show_nightvision_overlay = not show_nightvision_overlay
			-- 	end,
			-- 	show = function() return true end
			-- },
			-- return (GetJob(LocalPlayer():Team().control ~= )
			{
				text = 'Menu Jedi',
				doclick = function() RunConsoleCommand('lscs_openmenu') end,
				show = function()
					return LocalPlayer():Team() == TEAM_JEDI or TEAM_JEDI1 or TEAM_JEDI2 or TEAM_JEDI7 or false
					-- return re.jobs[LocalPlayer():Team()] == TEAM_JEDI or TEAM_JEDI1 or TEAM_JEDI2 or TEAM_JEDI7 
				end
			},
			--show = function() return LocalPlayer():Team() == TEAM_JEDI or TEAM_JEDI1 or TEAM_JEDI2 or TEAM_JEDI7 end
			--show = function() return LocalPlayer():IsAdmin() end
			{
				text = 'Hełm',
				doclick = function()
					net.Start('helmet')
					net.SendToServer()
				end,
				show = function() return re.jobs[LocalPlayer():Team()].Type == TYPE_CLONE or TYPE_ROOKIE end
			},
			{
				text = 'Admin mod',
				doclick = function() show_adminmode = not show_adminmode end,
				-- Menu:Remove()
				show = function() return LocalPlayer():IsAdmin() end
			},
			{
				text = 'Wprowadzenie graczy',
				doclick = function() __NOESP = not __NOESP end,
				-- Menu:Remove()
				show = function() return LocalPlayer():IsAdmin() and show_adminmode or LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP end
			},
			{
				text = 'Zdejmij jetpack',
				doclick = function() RunConsoleCommand('pe_drop', 'sneakyjetpack') end,
				show = function() return LocalPlayer():IsAdmin() end
			},
			{
				text = 'Katarn',
				doclick = function() netstream.Start('KatarnToggle') end,
				-- show_adminmode = not .show_adminmode -- Menu:Remove()
				show = function() return LocalPlayer():Team() == TEAM_COMMANDO end
			},
		}

		local i = 1
		for _, b in pairs(buttons) do
			if not b.show() then continue end
			local btn = vgui.Create('DButton', Menu)
			btn:SetSize(162, 40)
			btn:SetText('')
			btn:SetPos(Menu:GetWide() - 10 - 162, Menu:GetTall() - 160 + i * -36)
			btn:SetZPos(10)
			btn.Paint = function(self, w, h)
				-- draw.RoundedBox(2, 0, 0, w, h, Color(0,0,0,140))
				draw.Icon(0, 0, w, h, mat_gradient1, color_white)
				draw.SimpleText(b.text, luna.MontBase22, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
			end

			-- btn:SetZPos( -10 )
			btn.DoClick = b.doclick
			i = i + 1
		end

		local max_x, max_y = 120, 100
		local Slider = vgui.Create('DSlider', Menu)
		Slider:SetSize(200, 200)
		Slider:SetPos(Menu:GetWide() - Slider:GetWide() - 35, 35)
		Slider:SetLockX()
		Slider:SetLockY()
		Slider:SetSlideY(tonumber(thirdperson.z:GetString()))
		Slider:SetSlideX(tonumber(thirdperson.y:GetString()))
		Slider.Knob:SetSize(14, 14)
		Slider.Knob.Paint = function(self, w, h)
			-- local col = self.Depressed and Color(0,165,255,255) or (self:IsHovered() and Color(190,190,190,255) or color_white)
			draw.RoundedBox(10, 0, 0, w, h, COLOR_HOVER)
		end

		Slider.Paint = function(self, w, h)
			draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 90))
			local y, z = self:GetSlideX(), self:GetSlideY()
			surface.SetDrawColor(COLOR_WHITE)
			-- surface.DrawLine(y*w,0,y*w,h)
			-- surface.DrawLine(0,z*h,w,z*h)
			surface.DrawLine(0, w * .5, w, w * .5)
			surface.DrawLine(h * .5, 0, h * .5, h)
			-- draw.SimpleText(' '..y*100, 'DermaDefault', y*w, 0, color_white, 1, 0)
			-- draw.SimpleText(' '..z*100, 'DermaDefault', h, z*h, color_white, 2, 1)
			thirdperson.y:SetString(y)
			thirdperson.z:SetString(z)
			-- surface.SetDrawColor(COLOR_HOVER)
			surface.DrawOutlinedRect(0, 0, w, h, 3)
		end

		local ZSlider = vgui.Create('DNumSlider', Menu)
		ZSlider:SetSize(200, 24)
		ZSlider:SetPos(Menu:GetWide() - ZSlider:GetWide() - 35, 233)
		ZSlider.Paint = function(self, w, h)
			draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 90))
			surface.SetDrawColor(COLOR_WHITE)
			surface.DrawOutlinedRect(0, -3, w, h, 3)
		end

		-- surface.DrawLine(w*.5,0,w*.5,w)
		ZSlider:SetConVar('thirdperson_x')
		ZSlider:SetMin(40)
		ZSlider:SetMax(200)
		ZSlider:SetDecimals(0)
		ZSlider.PerformLayout = function()
			ZSlider:GetTextArea():SetWide(0)
			ZSlider.Label:SetWide(0)
			ZSlider.Slider:SetPos(0, 0)
			ZSlider.Slider.Knob:SetSize(20, 20)
			ZSlider.Slider.Paint = function(self, w, h) end
			ZSlider.Slider.Knob.Paint = function(self, w, h)
				-- local col = self.Depressed and COLOR_HOVER or ColorAlpha(COLOR_HOVER, 230)
				local pos_x = ZSlider:GetValue() == ZSlider:GetMax() and -1 or ZSlider:GetValue() == ZSlider:GetMin() and 1 or 0
				draw.RoundedBox(4, pos_x + 2, 0, w - 4, h - 4, COLOR_HOVER)
			end
		end

		local Close = vgui.Create('DButton', Menu)
		Close:SetSize(30, 30)
		Close:SetText('')
		Close:SetPos(Menu:GetWide() - Close:GetWide() - 20, 20)
		Close.Paint = function(self, w, h)
			draw.RoundedBox(6, 0, 0, w, h, COLOR_HOVER)
			draw.SimpleText('X', luna.MontBase22, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
		end

		Close.DoClick = function(self) Menu:SetVisible(false) end
		do
			local i = 1
			local tbl = SUP_ANIMATIONS
			for command, act in pairs(tbl) do
				local btn = vgui.Create('DButton', Menu)
				btn:SetSize(162, 22)
				local height = btn:GetTall() + 2
				btn:SetPos(19, 100 + i * 24)
				btn:SetText('')
				btn.Paint = function(self, w, h)
					draw.RoundedBox(6, h + 4, 0, w - h - 4, h, Color(0, 0, 0, 140))
					draw.RoundedBox(6, 0, 0, h, h, Color(0, 0, 0, 140))
					draw.SimpleText(act.text, "font_base_18", (w + h) / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
					-- -- surface.SetDrawColor(255,255,255,36)
					-- surface.DrawOutlinedRect(0, 0, w, h)
					if act.icon then draw.Icon(0, 0, h, h, act.icon, color_white) end
				end

				btn.DoClick = function(self) RunConsoleCommand('sup_act', command) end
				-- PrintTable(command)
				-- ConCommand('act '..command)
				i = i + 1
			end
		end

		do
			if TEAMS_CANUSE_DEFCONS[LocalPlayer():Team()] then
				local i = 1
				for name, text in pairs(DEFCON_TYPES) do
					defcons_buttons[i] = vgui.Create('DButton', Menu)
					defcons_buttons[i]:SetSize(160, 34)
					defcons_buttons[i]:SetPos(10 + 180, 86 + 38 * i)
					defcons_buttons[i]:SetText('')
					defcons_buttons[i].Paint = function(self, w, h)
						draw.RoundedBox(6, 0, 0, w, h, Color(0, 0, 0, 140))
						draw.SimpleText(name, luna.MontBase22, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
						surface.SetDrawColor(255, 255, 255, 0)
						surface.DrawOutlinedRect(0, 0, w, h)
					end

					defcons_buttons[i].DoClick = function(self)
						netstream.Start('SendCommandDefcon', {
							name = name
						})
					end

					-- RunConsoleCommand('act', command)
					i = i + 1
				end
			end
		end
	end
end

function GM:OnContextMenuOpen()
	gui.EnableScreenClicker(true)
	no_close_onedit = no_close_onedit or {}
	OpenContextMenu()
end

function GM:OnContextMenuClose()
	gui.EnableScreenClicker(false)
	surface.PlaySound('sup_sound/deny.wav')
	no_close_onedit = no_close_onedit or {}
	if Menu and IsValid(Menu) then
		local no_cl = true
		for k, v in pairs(no_close_onedit) do
			if v and IsValid(v) then
				if v.IsEditing and v:IsEditing() then return end
				if v.GetToggle and v:GetToggle() then return end
			end
		end

		if Menu:IsVisible() and no_cl then
			-- Menu:SetVisible(false)
			Menu:AlphaTo(0, .2, 0, function() Menu:Close() end)
		end
	end
end

hook.Add('OnReloaded', 'ContextMenu_OnReloaded', function() if Menu and IsValid(Menu) then Menu:Remove() end end)
if Menu and IsValid(Menu) then Menu:Remove() end