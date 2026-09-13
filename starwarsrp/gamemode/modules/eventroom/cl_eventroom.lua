netstream.Hook("OpenEventroomMenu", function(characters)
	if IsValid(CreationMenu) then
		CreationMenu:Remove()
	end

	local task = GetGlobalTable("EventTask") or {
		text = "",
		title = "",
		lines = {}
	}

	CreationMenu = vgui.Create("DFrame")
	CreationMenu:SetSize(ScrW(), ScrH())
	CreationMenu:SetPos(0, 0)
	CreationMenu:SetDraggable(false)
	CreationMenu:SetTitle("")

	CreationMenu.Paint = function(self, w, h)
		local x, y = self:GetPos()
		draw.DrawBlur(x, y, self:GetWide(), self:GetTall(), 2)
		draw.RoundedBox(6, 0, 0, w, h, Color(52, 73, 94, 250))
	end

	CreationMenu:MakePopup()

	local Center = vgui.Create("Panel", CreationMenu)
	Center:SetSize(ScrW() / 1.6, ScrH() / 1.8)
	Center:SetPos(CreationMenu:GetWide() * .5 - Center:GetWide() * .5, CreationMenu:GetTall() * .5 - Center:GetTall() * .5)


	local Settings = vgui.Create("Panel", Center)
	Settings:Dock(RIGHT)
	Settings:SetWide(Center:GetWide() / 4)
	Settings.Items = {}

	local HeaderText = vgui.Create("DLabel", Settings)
	HeaderText:Dock(TOP)
	HeaderText:SetTall(20)
	HeaderText:SetText("Ustawienia")
	HeaderText:SetFont(luna.MontBase24)
	HeaderText:DockMargin(0,0,0,5)

	HeaderText:DockMargin(0,0,0,5)
	local function addItem( text )
		local RulePanel = Settings:Add( "DPanel" )
		RulePanel:Dock( TOP )
		RulePanel:DockMargin( 0, 1, 0, 0 )
		table.insert( Settings.Items, RulePanel )

		local ImageCheckBox = RulePanel:Add( "ImageCheckBox" )
		ImageCheckBox:SetMaterial( "icon16/accept.png" )
		ImageCheckBox:SetWidth( 24 )
		ImageCheckBox:Dock( LEFT )
		ImageCheckBox:SetChecked( false )
		RulePanel.ImageCheckBox = ImageCheckBox

		local DLabel = RulePanel:Add( "DLabel" )
		DLabel:SetText( text )
		DLabel:Dock( FILL )
		DLabel:DockMargin( 5, 0, 0, 0 )
		DLabel:SetTextColor( Color( 0, 0, 0 ) )
	end

	-- Adding items
	addItem( "Zezwól na włączanie latarek" )


	local LeftPanel = vgui.Create("Panel")
	local RightPanel = vgui.Create("Panel")

	local Divider = vgui.Create("DHorizontalDivider", Center)
	Divider:Dock( LEFT )
	Divider:SetWide( Center:GetWide() / 1.35 )
	Divider:SetLeft(LeftPanel)
	Divider:SetRight(RightPanel)
	Divider:SetDividerWidth(4)
	Divider:SetLeftMin(Divider:GetWide() / 3)
	Divider:SetRightMin(Divider:GetWide() / 3)
	Divider:SetLeftWidth(Divider:GetWide() / 2)
	

	do -- left div
		local Save = vgui.Create("DButton", LeftPanel)
		Save:Dock(BOTTOM)
		Save:SetText("")
		Save:SetTall(30)

		Save.Paint = function(self, w, h)
			draw.RoundedBox(6, 0, 0, w, h, Color(92, 184, 92))
			draw.SimpleText("Zapisz", luna.MontBase22, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
		end

		local Header = vgui.Create("Panel", LeftPanel)
		Header:Dock(TOP)
		Header:SetTall(50)
		Header:SetText(task.title or "")

		local HeaderText = vgui.Create("DLabel", Header)
		HeaderText:Dock(TOP)
		HeaderText:SetTall(20)
		HeaderText:SetText("Zadania")
		HeaderText:SetFont(luna.MontBase24)
		HeaderText:DockMargin(0,0,0,5)

		local TitleEntry = vgui.Create("DTextEntry", LeftPanel)
		TitleEntry:Dock(TOP)
		TitleEntry:SetTall(30)
		TitleEntry:SetText(task.title or "")
		TitleEntry:SetPlaceholderText( "Nazwa" )
		TitleEntry:DockMargin(0,5,0,0)
		-- TitleEntry:DockMargin(0, 0, 15, 0)

		local TimerButton = vgui.Create("DButton", Header)
		TimerButton:Dock(RIGHT)
		TimerButton:SetSize(200, 30)
		TimerButton:SetText("")
		TimerButton:DockMargin(5, 0, 0, 0)

		TimerButton.Paint = function(self, w, h)
			draw.RoundedBox(6, 0, 0, w, h, COLOR_HOVER)
			draw.SimpleText("Uruchom timer", luna.MontBaseSmall, w / 2, h / 2, COLOR_WHITE, 1, 1)
		end

		local TimerWang = vgui.Create("DNumberWang", Header)
		TimerWang:Dock(FILL)
		TimerWang:SetTall(30)
		TimerWang:SetText(0)

		local TextEntry = vgui.Create("DTextEntry", LeftPanel)
		TextEntry:Dock(FILL)
		TextEntry:SetMultiline(true)
		TextEntry:SetText(task.text or "")
		TextEntry:DockMargin(0, 5, 0, 0)
		TextEntry:SetPlaceholderText( "Krótki opis zadania" )
		local lines = task.lines or {}

		for i = 10, 1, -1 do
			local Panel = vgui.Create("Panel", LeftPanel)
			Panel:Dock(BOTTOM)
			Panel:SetTall(30)
			Panel:DockMargin(0, 4, 0, 0)

			local TextEntry = vgui.Create("DTextEntry", Panel)
			TextEntry:Dock(FILL)
			TextEntry:SetText(task.lines and task.lines[i] or "")
			TextEntry:SetPlaceholderText( "Zadanie #" .. i )

			-- local Label = vgui.Create("DLabel", Panel)
			-- Label:Dock(LEFT)
			-- Label:SetText(i .. ".")
			-- Label:SetWide(30)
			-- Label:SetFont(luna.MontBase22)

			TextEntry.OnChange = function(self, value)
				lines[i] = self:GetValue()
			end
		end

		-- local parsed = markup.Parse( "" )
		-- TextEntry.OnTextChanged = function( value )
		--     parsed = markup.Parse( TextEntry:GetValue() )
		-- end
		-- DPanel.Paint = function( self, w, h )
		--     parsed:Draw( TextEntry:GetWide(), 0, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
		-- end
		TimerButton.DoClick = function()
			netstream.Start("EventRoom_StartTimer", CurTime() + TimerWang:GetValue())
			CreationMenu:Close()
		end

		Save.DoClick = function()
			netstream.Start("EventRoom_ChangeTask", {
				title = TitleEntry:GetValue(),
				text = TextEntry:GetValue(),
				lines = lines
			})

			CreationMenu:Close()
		end
	end

	do -- right div
		local OriginalRightPanel = RightPanel
		local SubDivider = vgui.Create("DHorizontalDivider", OriginalRightPanel)
		local RightPanel = vgui.Create("Panel")
		local SoundPanel = vgui.Create("Panel")

		SubDivider:Dock(FILL)
		SubDivider:SetRight(RightPanel)
		SubDivider:SetLeft(SoundPanel)
		SubDivider:SetLeftMin(SubDivider:GetWide() * 2)
		do -- PlayList
			local SoundHeaderText = vgui.Create("DLabel", SoundPanel)
			SoundHeaderText:Dock(TOP)
			SoundHeaderText:SetTall(20)
			SoundHeaderText:SetText("Playlista")
			SoundHeaderText:SetFont(luna.MontBase24)
			SoundHeaderText:DockMargin(0,0,0,5)
			local Scroll = vgui.Create("DScrollPanel", SoundPanel)
			Scroll:Dock(FILL)
			local DButton = vgui.Create("DButton", SoundPanel)
			DButton:Dock(TOP)
			DButton:SetText("")
			DButton.Paint = function(self, w, h)
				draw.RoundedBox(6, 0, 0, w, h, COLOR_HOVER)
				draw.SimpleText("Dodaj utwór", luna.MontBaseSmall, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
			end
			local DComboBox = vgui.Create( "DComboBox", SoundPanel )
			DComboBox:Dock( TOP )
			DComboBox:SetValue( game.GetMap() )
			DComboBox:DockMargin(0,5,0,0)

			for k, v in pairs(re.maplist) do
				DComboBox:AddChoice( k )
			end
			local Play = vgui.Create("DButton", SoundPanel)
			Play:Dock(BOTTOM)
			Play:SetText("")
			Play:SetTall(30)

			Play.Paint = function(self, w, h)
				draw.RoundedBox(6, 0, 0, w, h, Color(255,64,64))
				draw.SimpleText("Uruchom playlistę", luna.MontBaseSmall, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
			end
			local entries = {}
			local function AddEntry()
				local Panel = vgui.Create("Panel", Scroll)
				Panel:Dock(TOP)
				Panel:SetTall(30)
				Panel:DockMargin(0, 4, 0, 0)

				local TextEntry = vgui.Create("DTextEntry", Panel)
				TextEntry:Dock(FILL)
				TextEntry:SetText("")
				TextEntry:SetPlaceholderText( "Track #" .. #entries + 1 )


				table.insert(entries, 1, TextEntry)
			end

			DButton.DoClick = function(self)
				AddEntry()
			end
			Play.DoClick = function(self)
				local values = {}
				for i, v in ipairs(entries) do table.insert(values, v:GetText()) end
				netstream.Start("EventRoom_PlayMusic", values)
				
			end
		end
		local HeaderText = vgui.Create("DLabel", RightPanel)
		HeaderText:Dock(TOP)
		HeaderText:SetTall(20)
		HeaderText:SetText("Zmiana karty")
		HeaderText:SetFont(luna.MontBase24)
		HeaderText:DockMargin(0,0,0,5)

		local Scroll = vgui.Create("DScrollPanel", RightPanel)
		Scroll:Dock(FILL)

		local DButton = vgui.Create("DButton", RightPanel)
		DButton:Dock(TOP)
		DButton:SetText("")

		DButton.Paint = function(self, w, h)
			draw.RoundedBox(6, 0, 0, w, h, COLOR_HOVER)
			draw.SimpleText("Dodaj slajd z tekstem", luna.MontBaseSmall, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
		end

		local DComboBox = vgui.Create( "DComboBox", RightPanel )
		DComboBox:Dock( TOP )
		DComboBox:SetValue( game.GetMap() )
		DComboBox:DockMargin(0,5,0,0)

		for k, v in pairs(re.maplist) do
			DComboBox:AddChoice( k )
		end

		local Change = vgui.Create("DButton", RightPanel)
		Change:Dock(BOTTOM)
		Change:SetText("")
		Change:SetTall(30)

		Change.Paint = function(self, w, h)
			draw.RoundedBox(6, 0, 0, w, h, Color(255,64,64))
			draw.SimpleText("Zmień mapę na \"" .. DComboBox:GetValue() .. "\"", luna.MontBaseSmall, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
		end

		local Start = vgui.Create("DButton", RightPanel)
		Start:Dock(BOTTOM)
		Start:SetText("")
		Start:SetTall(30)

		Start.Paint = function(self, w, h)
			draw.RoundedBox(6, 0, 0, w, h, Color(64,255,64))
			draw.SimpleText("Uruchom slajd", luna.MontBaseSmall, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
		end

		local entries = {}

		local function AddEntry()
			local Panel = vgui.Create("Panel", Scroll)
			Panel:Dock(TOP)
			Panel:SetTall(30)
			Panel:DockMargin(0, 4, 0, 0)

			local TextEntry = vgui.Create("DTextEntry", Panel)
			TextEntry:Dock(FILL)
			TextEntry:SetText("")
			TextEntry:SetPlaceholderText( "Slajd #" .. #entries + 1 )

			-- local Label = vgui.Create("DLabel", Panel)
			-- Label:Dock(LEFT)
			-- Label:SetText("Слайд #" .. #entries + 1)
			-- Label:SetWide(100)
			-- Label:SetFont(luna.MontBase22)

			table.insert(entries, 1, TextEntry)
		end

		AddEntry()

		DButton.DoClick = function(self)
			AddEntry()
		end

		local function ChangeLevel(bool)
			local texts = {}

			for i, p in ipairs(entries) do
				texts[i] = p:GetValue() or ""
			end

			netstream.Start("EventRoom_ChangeLevel", texts, bool)

			CreationMenu:Close()
		end

		Change.DoClick = function()
			ChangeLevel(true)
		end

		Start.DoClick = function()
			ChangeLevel(false)
		end
	end
end)

local restart_text
local alpha, lerp_alpha = 0, 0
local bg_alpha, lerp_bg_alpha = 0, 0
local toggle = false
netstream.Hook("EventRoom_ChangeLevel", function( texts, time_end )
	if texts == false then
		restart_text = nil
		bg_alpha = 0
		toggle = false
		return
	end

	local i = #texts
	restart_text = texts[i]
	local function next_slide()
		timer.Simple(time_end / #texts + (1.5 * #texts), function()
			i = i - 1
			restart_text = texts[i]
			next_slide()
		end)
	end
	next_slide()

	RunConsoleCommand("stopsound")
	timer.Simple(0.2, function()
		surface.PlaySound("luna_sound_effects/commando_intro/swrc_music.wav")
		--surface.PlaySound("venty/music/oneshot/nightlobby.mp3")
	end)
end)

local buff_text
hook.Add("PostRenderVGUI","PostRenderVGUI_HUD",function()
	-- if not restart_text then return end

	if buff_text ~= restart_text then
		alpha = 0
		timer.Simple(1.5, function()
			alpha = 256
			buff_text = restart_text
		end)

		if not toggle then
			bg_alpha = 256
			toggle = true
		end
	end

	lerp_alpha = Lerp(.05, lerp_alpha or 0, alpha or 0)
	lerp_bg_alpha = Lerp(.05, lerp_bg_alpha or 0, bg_alpha or 0)

	if not restart_text or lerp_bg_alpha == 0 then return end
	surface.SetDrawColor(Color(10,10,10,lerp_bg_alpha))
	surface.DrawRect(0,0,ScrW(),ScrH())

	if not buff_text then return end
	text = util.textWrap(buff_text or "", "font_base_24", ScrW()/2)

	surface.SetFont("font_base_24")
	local _, th = surface.GetTextSize(text)

	surface.DrawShadowTexts(text, "font_base_24", ScrW() / 2, ScrH() / 2 - th / 2, Color(122, 194, 255, lerp_alpha), COLOR_BG, TEXT_ALIGN_CENTER, 1, 1)
end)

netstream.Hook("EventRoom_PlayMusic", function(tracks)
	local count = 1
	co = coroutine.create(function()
		while count ~= #tracks do
			sound.PlayFile("sound/"..tracks[count], "", function(station, errCode, errStr) end)
			count = count + 1
			coroutine.yield()
		end 
	end)
	sound.PlayFile("sound/"..tracks[count], "noplay", function (station, errCode, errStr)
		if IsValid(station) then
			--print('fuck')
			station:Play()
			count = count + 1
		end
	end)
end)