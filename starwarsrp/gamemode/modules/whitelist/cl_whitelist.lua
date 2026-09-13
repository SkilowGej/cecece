local WhitelistMenu = WhitelistMenu or nil
local ViewMain
local mat_bg = Material("luna_ui_base/fon.png", "smooth noclamp")
local mat_rcbeta = Material("luna_sup_brand/main_logo_swrp.png", "smooth noclamp")
local mat_lock = Material("luna_ui_base/elements/lock.png", "smooth noclamp")
local function OpenCharWhitelist(char)
	if not WHITELIST_ADMINS[LocalPlayer():GetUserGroup()] then return end
	-- if pl:Team() == 0 or pl:Team() == 1001 then return end
	local jdata = FindJobByID(char.team_id)
	local DPanel = vgui.Create("DPanel", WhitelistMenu)
	DPanel:Dock(RIGHT)
	DPanel:SetWide(400)
	DPanel:DockPadding(10, 10, 10, 0)
	DPanel.Paint = function(self, w, h)
		local pcol = Color(64, 105, 153)
		h = h - 2
		if pl and pcol then
			draw.RoundedBox(2, 0, 0, w, h, Color(pcol.r, pcol.g, pcol.b, 250))
			local rpid = pl:GetRPID()
			rpid = rpid and " " .. rpid .. "" or ""
			local tm = pl:Team()
			local rating = pl:GetNWString("rating") or ""
			local name = pl:Name()
			draw.SimpleText(name, luna.MontBase22, 32 + 1, 4, Color(0, 0, 0, 60), 0, 0)
			draw.SimpleText(name, luna.MontBase22, 32, 4, Color(255, 255, 255, 250), 0, 0)
			-- draw.SimpleText(rpid, luna.MontBase22, 32 + wt + 4 +1, h/2+1, Color( 0, 0, 0, 60 ), 0, 1)
			-- draw.SimpleText(rpid, luna.MontBase22, 32 + wt + 4 , h/2, Color( 195, 195, 195, 255 ), 0, 1)
			-- local tname = tm == 0 and "(Не выбрал персонажа)" or team.GetName(tm)
			-- draw.SimpleText(tname, luna.MontBase22, w/2 +1, h/2+1, Color( 0, 0, 0, 60 ), 1, 1)
			-- draw.SimpleText(tname, luna.MontBase22, w/2 , h/2, Color( 255, 255, 255, 255 ), 1, 1)
			-- if rating then
			--     draw.SimpleText(rating, luna.MontBase22, w/3 +1, h/2+1, Color( 0, 0, 0, 60 ), 1, 1)
			--     draw.SimpleText(rating, luna.MontBase22, w/3 , h/2, Color( 255, 255, 255, 255 ), 1, 1)
			-- end
			local oldname = char.character_name
			surface.SetFont(luna.MontBase22)
			local wt, _ = surface.GetTextSize(" " .. rpid)
			draw.RoundedBox(2, w - wt - 30, 0, wt, 30, Color(pcol.r - 12, pcol.g - 12, pcol.b - 12, 255))
			draw.SimpleText(rating .. " " .. rpid, luna.MontBase22, w - 30 - 4 + 1, 4 + 1, Color(0, 0, 0, 60), 2, 0)
			draw.SimpleText(rating .. " " .. rpid, luna.MontBase22, w - 30 - 4, 4, Color(255, 255, 255, 255), 2, 0)
		end
	end

	local features_panel = vgui.Create("DScrollPanel", DPanel)
	features_panel:Dock(TOP)
	features_panel:SetTall(200)
	features_panel:DockMargin(0, 10, 0, 0)
	features_panel.VBar = features_panel:GetVBar()
	features_panel.VBar:SetWide(6)
	function features_panel.VBar:PerformLayout()
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

	features_panel.VBar.Paint = function(self, w, h) end
	features_panel.Paint = function(self, w, h) draw.RoundedBox(6, 0, 0, w, h, COLOR_BG) end
	features_panel.VBar.btnGrip.Paint = function(self, w, h) draw.RoundedBox(2, 0, 0, w, h, Color(255, 255, 255, 190)) end
	local Rating = vgui.Create("DComboBox", DPanel)
	Rating:SetAutoStretchVertical(false)
	Rating:SetSortItems(false)
	Rating:Dock(TOP)
	Rating:SetTextColor(Color(255, 255, 255, 255))
	Rating:DockMargin(0, 10, 0, 0)
	local teams_search = vgui.Create("DTextEntry", DPanel)
	teams_search:Dock(TOP)
	teams_search:SetTall(30)
	teams_search:DockMargin(0, 10, 0, 0)
	teams_search.Paint = function(self, w, h)
		draw.RoundedBoxEx(6, 0, 0, w, h, COLOR_BG, true, true, false, false)
		self:DrawTextEntryText(Color(255, 255, 255, 240), Color(0, 165, 255, 255), Color(255, 255, 255, 240))
	end

	local DListTeams = vgui.Create("DListView", DPanel)
	DListTeams:Dock(TOP)
	DListTeams:SetTall(300)
	local modify_model = vgui.Create("DComboBox", DPanel)
	modify_model:Dock(TOP)
	modify_model:DockMargin(0, 10, 0, 0)
	modify_model:SetAutoStretchVertical(false)
	modify_model:SetSortItems(false)
	modify_model:SetTextColor(Color(255, 255, 255, 255))
	modify_model.OnSelect = function(panel, index, value) end
	local features_buttons = {}
	local function refact_model(team_index, rating)
		-- print(rating)
		modify_model:Clear()
		local player_job = re.jobs[team_index]
		local features = {}
		for k, v in pairs(features_buttons) do
			features[k] = v:GetChecked()
		end

		local feat_model = false
		if table.HasValue(features, true) then
			local ft = table.KeyFromValue(features, true)
			local norm_ft = FEATURES_TO_NORMAL[ft]
			if norm_ft and norm_ft.models and norm_ft.models[team_index] then
				feat_model = norm_ft.models[team_index]
				modify_model:SetValue(feat_model)
			end
		end

		if not feat_model then
			if player_job.FeatureRatings and player_job.FeatureRatings[rating] and player_job.FeatureRatings[rating].model then
				modify_model:AddChoice(player_job.FeatureRatings[rating].model)
				modify_model:SetValue(player_job.FeatureRatings[rating].model)
			else
				if player_job.WorldModel then
					if istable(player_job.WorldModel) then
						for _, mdl in pairs(player_job.WorldModel) do
							modify_model:AddChoice(mdl)
						end
					elseif isstring(player_job.WorldModel) then
						modify_model:AddChoice(player_job.WorldModel)
					end
				end

				modify_model:SetValue(modify_model:GetOptionText(1))
			end
		end
	end

	local fi = 1
	for k, v in pairs(FEATURES_TO_NORMAL) do
		if v.invisible then continue end
		local features = char.features and char.features or DEFAULT_FEATURES
		features = features == {} and DEFAULT_FEATURES or features
		features_buttons[k] = vgui.Create("DCheckBoxLabel", features_panel)
		features_buttons[k]:Dock(TOP)
		features_buttons[k]:DockMargin(10, 5, 0, 0)
		features_buttons[k]:SetValue(features[k] and 1 or 0)
		features_buttons[k]:SizeToContents()
		features_buttons[k]:SetText(v.name)
		features_buttons[k].OnChange = function(self)
			-- print(self:GetChecked())
			if self:GetChecked() then
				local i = 0
				for _, p in pairs(features_buttons) do
					if p:GetChecked() then i = i + 1 end
					if self ~= p and i > 1 then p:SetValue(0) end
				end
			end

			refact_model(tonumber(DListTeams:GetSelected()[1]:GetColumnText(1)), Rating:GetValue())
		end

		fi = fi + 1
	end

	Rating.OnSelect = function(panel, index, value)
		-- print( value .." was selected!" )
		refact_model(tonumber(DListTeams:GetSelected()[1]:GetColumnText(1)), Rating:GetValue())
	end

	Rating.Paint = function(self, w, h)
		draw.RoundedBox(6, 0, 0, w, h, COLOR_BG)
		self:DrawTextEntryText(Color(255, 255, 255, 240), Color(0, 165, 255, 255), Color(255, 255, 255, 240))
	end

	Rating.DoClick = function(self)
		surface.PlaySound("luna_ui/click3.wav")
		if self:IsMenuOpen() then return self:CloseMenu() end
		self:OpenMenu()
		self.Menu.Paint = function(panel, w, h) end
		-- for k, v in pairs(self.Menu:GetChildrens()) do
		local count = self.Menu:ChildCount()
		for i = 1, count do
			local pnl = self.Menu:GetChild(i)
			local is_last = i == count
			pnl.Paint = function(self, w, h) draw.RoundedBoxEx(6, 0, 0, w, h, COLOR_BG, false, false, is_last, is_last) end
			-- pnl:SetFont(luna.MontBase22)
			pnl:SetTextColor(color_white)
		end
	end

	-- print(tonumber(DListTeams:GetSelected()[1]:GetColumnText( 1 )))
	-- print(DListTeams:GetSelected():GetColumnText( 1 ))
	Rating.DropButton:SetText("")
	Rating.DropButton.Paint = function(panel, w, h) end
	-- local Avatar = vgui.Create("AvatarImage", DPanel)
	-- Avatar:Dock(TOP)
	-- Avatar:SetPlayer(pl, 64)
	DListTeams:SetMultiSelect(false)
	DListTeams:AddColumn("ID")
	DListTeams:AddColumn("")
	-- DListTeams:AddColumn( "Size" )
	for k, v in pairs(re.jobs) do
		DListTeams:AddLine(k, v.Name)
	end

	DListTeams.Paint = function(self, w, h)
		draw.RoundedBoxEx(6, 0, 0, w, h, COLOR_BG, false, false, true, true)
		self:DrawTextEntryText(Color(255, 255, 255, 240), Color(0, 165, 255, 255), Color(255, 255, 255, 240))
	end

	modify_model:AddChoice(char.model)
	modify_model:SetValue(char.model)
	modify_model.Paint = function(self, w, h)
		draw.RoundedBox(6, 0, 0, w, h, COLOR_BG)
		self:DrawTextEntryText(Color(255, 255, 255, 240), Color(0, 165, 255, 255), Color(255, 255, 255, 240))
	end

	modify_model.DoClick = function(self)
		surface.PlaySound("luna_ui/click1.wav")
		if self:IsMenuOpen() then return self:CloseMenu() end
		self:OpenMenu()
		if self.Menu then
			self.Menu.Paint = function(panel, w, h) end
			-- for k, v in pairs(self.Menu:GetChildrens()) do
			local count = self.Menu:ChildCount()
			for i = 1, count do
				local pnl = self.Menu:GetChild(i)
				local is_last = i == count
				pnl.Paint = function(self, w, h) draw.RoundedBoxEx(6, 0, 0, w, h, COLOR_BG, false, false, is_last, is_last) end
				-- pnl:SetFont(luna.MontBase22)
				pnl:SetTextColor(color_white)
				local mdl = vgui.Create("ModelImage", pnl)
				mdl:SetSize(pnl:GetTall(), pnl:GetTall())
				mdl:SetPos(0, 0)
				mdl:SetModel(pnl:GetValue())
			end
		end
	end

	modify_model.DropButton:SetText("")
	modify_model.DropButton.Paint = function(panel, w, h) end
	DListTeams.OnRowSelected = function(panel, rowIndex, row)
		Rating:Clear()
		local job = re.jobs[row:GetValue(1)]
		local ratings = ALIVE_RATINGS[job.Type or 1]
		for _, r in pairs(ratings) do
			Rating:AddChoice(r)
		end

		local player_job = re.jobs[jdata.index]
		if player_job.Type == job.Type then
			Rating:SetValue(char.rating)
			refact_model(row:GetValue(1), char.rating)
		else
			Rating:SetValue(ratings[1])
			refact_model(row:GetValue(1), ratings[1])
		end
	end

	for k, line in pairs(DListTeams:GetLines()) do
		if line:GetValue(1) == jdata.index then
			DListTeams:SelectItem(line)
			break
		end
	end

	-- DListTeams.VBar = DListTeams:GetVBar()
	-- DListTeams.VBar.Paint = function( self, w, h ) end
	local def_list = baseclass.Get("DListView")
	function DListTeams:PerformLayout()
		-- timer.Simple(0,function()
		def_list.PerformLayout(self)
		DListTeams.VBar:SetSize(6, DListTeams:GetTall())
	end

	function DListTeams.VBar:PerformLayout()
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

	DListTeams.VBar.Paint = function(self, w, h) end
	DListTeams.VBar.btnGrip.Paint = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 190)) end
	local function RePaintDListTeams()
		for k, line in pairs(DListTeams:GetLines()) do
			for k, v in pairs(line.Columns) do
				v:SetText("")
			end

			line.Paint = function(self, w, h)
				if line:IsSelected() then draw.RoundedBox(2, 0, 0, w, h, Color(255, 255, 255, 10)) end
				local wi = 0
				for k, v in pairs(line.Columns) do
					wi = k == 1 and wi or wi + line.Columns[k - 1]:GetWide()
					draw.SimpleText(v.Value, "DermaDefault", wi + 4, 0, Color(255, 255, 255, 255))
				end
			end
		end
	end

	RePaintDListTeams()
	for _, colum in pairs(DListTeams.Columns) do
		local text = colum.Header:GetText()
		colum.Header.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, COLOR_BG)
			draw.SimpleText(text, "DermaDefault", w / 2, 0, Color(255, 255, 255, 255), 1, 0)
		end

		colum.Header:SetText("")
	end

	teams_search.OnChange = function(self)
		local value = self:GetValue()
		DListTeams:Clear()
		for k, v in pairs(re.jobs) do
			local heckStart, heckEnd = string.find(v.Name, value:lower())
			if heckStart then DListTeams:AddLine(k, v.Name) end
		end

		RePaintDListTeams()
	end

	-- for k, line in pairs( DListTeams:GetLines() ) do
	--     for k, v in pairs(line.Columns) do
	--         v:SetText("")
	--     end
	--     line.Paint = function( self, w, h )
	--         if line:IsSelected() then
	--             draw.RoundedBox(2, 0, 0, w, h, Color(255,255,255,10))
	--         end
	--         local wi = 0
	--         for k, v in pairs(line.Columns) do
	--             wi = k == 1 and wi or wi + line.Columns[k-1]:GetWide()
	--             draw.SimpleText(v.Value, "DermaDefault", wi+4, 0, Color( 255, 255, 255, 255 ))
	--         end
	--     end
	-- end
	local SpawnCheck = vgui.Create("DCheckBoxLabel", DPanel)
	SpawnCheck:Dock(TOP)
	SpawnCheck:DockMargin(10, 10, 0, 10)
	SpawnCheck:SetText("Spawn po nadaniu")
	SpawnCheck:SetValue(0)
	SpawnCheck:SizeToContents()
	-- local Save = vgui.Create("DButton", DPanel)
	-- Save:SetText("")
	-- Save:Dock(TOP)
	-- Save:SetTall(30)
	-- Save.Paint = function(self, w, h)
	-- 	draw.RoundedBox(6, 0, 0, w, h, COLOR_BG)
	-- 	draw.SimpleText("Выдать и закрыть", luna.MontBase30, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
	-- end
	local function SendProfile(onTime)
		local features = {}
		for k, v in pairs(features_buttons) do
			features[k] = v:GetChecked()
		end

		netstream.Start(onTime and "ProfileWhitelist_ChangeToTime" or "ProfileWhitelist_Change", {
			target = {
				player_id = char.player_id,
				steam_id = char.steam_id,
				char_id = char.char_id
			},
			rating = Rating:GetValue(),
			team_index = DListTeams:GetLine(DListTeams:GetSelectedLine()):GetColumnText(1),
			no_spawn = SpawnCheck:GetChecked(),
			features = features,
			model = modify_model:GetValue()
		})

		WhitelistMenu:Remove()
	end

	-- Save.DoClick = function(self)
	-- 	SendProfile()
	-- 	DPanel:Remove()
	-- 	table.remove(tasks, i)
	-- end
	local Save = vgui.Create("DButton", DPanel)
	Save:SetText("")
	Save:Dock(TOP)
	Save:SetTall(30)
	local icon_clipboard = Material("luna_ui_base/etc/play-button.png")
	Save.Paint = function(self, w, h)
		draw.RoundedBox(6, 0, 0, w, h, COLOR_BG)
		local txt = "Nadaj"
		surface.SetFont(luna.MontBase22)
		local wt, _ = surface.GetTextSize(txt)
		draw.SimpleText(txt, luna.MontBase22, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
		draw.Icon(w / 2 - wt / 2 - 24, h / 2 - 10, 20, 20, icon_clipboard)
	end

	Save.DoClick = function(self)
		surface.PlaySound("luna_ui/click1.wav")
		SendProfile()
		-- DPanel:Remove()
		-- table.remove(tasks, i)
		local features = {}
		for k, v in pairs(features_buttons) do
			features[k] = v:GetChecked()
		end
	end

	local SaveToTime = vgui.Create("DButton", DPanel)
	SaveToTime:SetText("")
	SaveToTime:Dock(TOP)
	SaveToTime:SetTall(30)
	SaveToTime:DockMargin(0, 2, 0, 0)
	local icon_clock = Material("luna_icons/clockwise-rotation.png")
	SaveToTime.Paint = function(self, w, h)
		draw.RoundedBox(6, 0, 0, w, h, COLOR_BG)
		local txt = "Nadać na jakiś czas"
		surface.SetFont(luna.MontBase22)
		local wt, _ = surface.GetTextSize(txt)
		draw.SimpleText(txt, luna.MontBase22, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
		draw.Icon(w / 2 - wt / 2 - 24, h / 2 - 10, 20, 20, icon_clock)
	end

	SaveToTime.DoClick = function(self)
		surface.PlaySound("luna_ui/click1.wav")
		SendProfile(true)
		-- DPanel:Remove()
		-- table.remove(tasks, i)
		local features = {}
		for k, v in pairs(features_buttons) do
			features[k] = v:GetChecked()
		end
	end
	-- netstream.Start("ProfileWhitelist_Change", {
	-- 	target = pl,
	-- 	rating = Rating:GetValue(),
	-- 	team_index = DListTeams:GetLine( DListTeams:GetSelectedLine() ):GetColumnText( 1 ),
	-- 	no_spawn = SpawnCheck:GetChecked(),
	-- 	features = features
	-- })
	-- local Time = vgui.Create("DButton", DPanel)
	-- Time:SetText("")
	-- Time:Dock(TOP)
	-- Time:DockMargin(0,10,0,0)
	-- Time:SetTall(30)
	-- Time.Paint = function(self, w, h)
	-- 	draw.RoundedBox(6, 0, 0, w, h, COLOR_BG)
	-- 	draw.SimpleText("На время", luna.MontBase22, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
	-- end
	-- Time.DoClick = function(self)
	-- 	netstream.Start("ProfileWhitelist_ChangeToTime", {
	-- 		target = pl,
	-- 		rating = Rating:GetValue(),
	-- 		team_index = DListTeams:GetLine( DListTeams:GetSelectedLine() ):GetColumnText( 1 ),
	-- 		no_spawn = SpawnCheck:GetChecked()
	-- 	})
	-- 	DPanel:Remove()
	-- end
	return DPanel
end

local function ViewWhitelistLegion(jobID, characters)
	if not WHITELIST_ADMINS[LocalPlayer():GetUserGroup()] then return end
	local index = FindJobByID(jobID).index
	if WhitelistMenu.Current then WhitelistMenu.Current:Remove() end
	WhitelistMenu.lastID = jobID
	if not istable(characters) then
		local Panel = vgui.Create("Panel")
		Panel.Paint = function(self, w, h) draw.ShadowSimpleText("Brak danych :C", luna.MontBase22, w * .5, h * .5, Color(255, 255, 255, 250), 1, 1) end
		WhitelistMenu.Current = Panel
		WhitelistMenu.Divider:SetRight(Panel)
		return
	end

	local Panel = vgui.Create("Panel")
	local DCollapsible = vgui.Create("DCategoryList", Panel)
	DCollapsible:Dock(FILL)
	DCollapsible.Paint = function(self, w, h) end
	DCollapsible.VBar:SetWide(0)
	local job_with_ratings = {}
	for i, char in SortedPairsByMemberValue(characters, "rating") do
		local rating = char.rating
		if not job_with_ratings[rating] then
			cat = DCollapsible:Add("")
			cat.Header.Paint = function(self, w, h) end
			cat.Paint = function(self, w, h)
				draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 90))
				-- surface.SetDrawColor( 0, 0, 0, 100 )
				-- surface.DrawOutlinedRect( 0, 0, w, 18, 1 )
				draw.ShadowSimpleText(rating, luna.MontBase22, 4, 18 / 2, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end

			job_with_ratings[rating] = vgui.Create("DIconLayout", cat)
			cat:SetContents(job_with_ratings[rating])
			job_with_ratings[rating]:SetSpaceX(5)
			job_with_ratings[rating]:SetSpaceY(5)
			job_with_ratings[rating]:DockMargin(5, 5, 5, 5)
		end
	end

	for i, char in pairs(characters) do
		-- if TOP_RATINGS_WHITELIST[char.rating] then continue end
		local pnl = vgui.Create("Panel")
		pnl:SetSize(160, 260)
		pnl.Paint = function(self, w, h)
			local pcol = team.GetColor(index)
			if pcol then
				draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(pcol, 140))
				-- surface.SetDrawColor( 0, 0, 0, 100 )
				-- surface.DrawOutlinedRect( 0,0, w,h, 1 )
				-- local name = char.character_name
				-- draw.ShadowSimpleText(name, luna.MontBase22, 32+1, h/2+1, Color( 0, 0, 0, 60 ), 0, 1)
				-- draw.ShadowSimpleText(name, luna.MontBase22, 32, h/2, Color( 255, 255, 255, 250 ), 0, 1)
				-- local oldname = char.player
				-- surface.SetFont(luna.MontBase22)
				-- local wt, _ = surface.GetTextSize(" "..rpid)
				-- draw.RoundedBox(0, w-wt, 0, wt, h, Color(pcol.r-12,pcol.g-12,pcol.b-12,255))
				if self:IsHovered() then draw.RoundedBox(6, 0, 0, w, h, Color(230, 230, 230, 4)) end
			end
		end

		local mdl = vgui.Create("DModelPanel", pnl)
		mdl:Dock(FILL)
		mdl:SetCamPos(Vector(185, -20, 50))
		mdl:SetLookAt(Vector(0, 0, 50))
		mdl:SetFOV(10)
		mdl:SetModel(char.model)
		mdl.Entity:SetSequence(mdl.Entity:LookupSequence("pose_standing_02"))
		function mdl:LayoutEntity(Entity)
			self:RunAnimation()
		end

		mdl.DoClick = function()
			surface.PlaySound("luna_ui/click1.wav")
			WhitelistMenu.SelectedChar = char
			mdl:SetModel(char.model)
			if WhitelistMenu.Model.Edit then WhitelistMenu.Model.Edit:Remove() end
			WhitelistMenu.Model.Edit = vgui.Create("DButton", WhitelistMenu.Model)
			WhitelistMenu.Model.Edit:Dock(BOTTOM)
			WhitelistMenu.Model.Edit:SetText("")
			WhitelistMenu.Model.Edit:SetTall(40)
			WhitelistMenu.Model.Edit.Paint = function(self, w, h)
				draw.RoundedBox(6, 0, 0, w, h, COLOR_BG)
				draw.ShadowSimpleText("ZMIENIĆ", luna.MontBase30, w / 2, h / 2, COLOR_WHITE, 1, 1)
			end

			WhitelistMenu.Model.Edit.DoClick = function()
				if WhitelistMenu.Whitelist then WhitelistMenu.Whitelist:Remove() end
				WhitelistMenu.Whitelist = OpenCharWhitelist(char)
				surface.PlaySound("luna_ui/click1.wav")
			end
		end

local active_feature

-- Ensure char.features exists and is a table
if char.features and istable(char.features) then
    for f, b in pairs(char.features) do
        -- Ensure FEATURES_TO_NORMAL[f] exists and has a name
        if b and FEATURES_TO_NORMAL[f] and FEATURES_TO_NORMAL[f].name then
            active_feature = FEATURES_TO_NORMAL[f].name
            break
        end
    end
else
    print("Error: char.features is nil or not a table")
end


		local click = true
		mdl._Paint = mdl.Paint
		local anim
		mdl.Paint = function(self, w, h)
			self._Paint(self, w, h)
			draw.ShadowSimpleText(char.character_name, luna.MontBase24, w / 2, h - 5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
			if active_feature then draw.ShadowSimpleText(active_feature, luna.MontBase22, w / 2, h - 25, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM) end
			draw.ShadowSimpleText(char.rating, luna.MontBaseSmall, 5, 5, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.ShadowSimpleText(char.rpid, luna.MontBaseSmall, w - 5, 5, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
			if self:IsHovered() then
				if click then
					anim = table.Random({"wos_fn_bestmates", "wos_fn_boneless", "wos_fn_breakdown", "wos_fn_dancemoves", "wos_fn_discofever", "wos_fn_eagle", "wos_fn_electroshuffle", "wos_fn_flippin_incredible", "wos_fn_flipping_sexy", "wos_fn_floss", "wos_fn_fresh", "wos_fn_gentlemandab", "wos_fn_groovejam", "wos_fn_handsignals", "wos_fn_hype", "wos_fn_infinidab", "wos_fn_intensity", "wos_fn_jubilation", "wos_fn_laughitup", "wos_fn_livinglarge", "wos_fn_orangejustice", "wos_fn_poplock", "wos_fn_rambunctious", "wos_fn_reanimated", "wos_fn_starpower", "wos_fn_swipeit", "wos_fn_takethel", "wos_fn_trueheart", "wos_fn_twist", "wos_fn_wiggle", "wos_fn_youreawesome", "wos_fn_zany"})
					click = false
				end

				self.Entity:SetSequence(self.Entity:LookupSequence(anim))
				draw.RoundedBox(6, 0, 0, w, h, Color(230, 230, 230, 4))
			else
				click = true
				self.Entity:SetSequence(self.Entity:LookupSequence("pose_standing_02"))
			end
		end

		job_with_ratings[char.rating]:Add(pnl)
	end

	-- local List = vgui.Create( "DIconLayout", top )
	-- List:SetTall(50)
	-- List:Dock( BOTTOM )
	-- List:DockMargin( 4, 4, 4, 4 )
	-- List:SetSpaceY( 5 )
	-- List:SetSpaceX( 5 )
	-- local i = 0
	-- for _, char in pairs(characters) do
	-- 	if not TOP_RATINGS_WHITELIST[char.rating] then continue end
	-- 	if i > 3 then continue end
	-- 	i = i + 1
	-- 	local pnl = List:Add( "DPanel" )
	-- 	pnl:SetSize(191,50)
	-- 	pnl.Paint = function( self, w, h )
	-- 		local pcol = team.GetColor(index)
	-- 		if pcol then
	-- 			draw.RoundedBox(6,0,0,w,h,Color(pcol.r, pcol.g, pcol.b, 200))
	-- 			surface.SetDrawColor( 0, 0, 0, 100 )
	-- 			surface.DrawOutlinedRect( 0,0,w,h, 1 )
	-- 			local rpid = char.rpid
	-- 			rpid = rpid and " "..rpid.."" or ""
	-- 			local rating = char.rating or ""
	-- 			rating = rating or ""
	-- 			local name = char.character_name
	-- 			draw.ShadowSimpleText(name, luna.MontBase22, 52+1, 14+1, Color( 0, 0, 0, 60 ), 0, 1)
	-- 			draw.ShadowSimpleText(name, luna.MontBase22, 52, 14, Color( 255, 255, 255, 250 ), 0, 1)
	-- 			local oldname = char.player
	-- 			surface.SetFont(luna.MontBase22)
	-- 			local wt, _ = surface.GetTextSize(" "..rpid)
	-- 			draw.RoundedBox(0, w-wt, 0, wt, h, Color(pcol.r-12,pcol.g-12,pcol.b-12,255))
	-- 			if rating then
	-- 				draw.ShadowSimpleText(rpid, luna.MontBase22, w - 4 +1, h/2+1, Color( 0, 0, 0, 60 ), 2, 1)
	-- 				draw.ShadowSimpleText(rpid, luna.MontBase22, w - 4 , h/2, Color( 255, 255, 255, 255 ), 2, 1)
	-- 				draw.ShadowSimpleText(rating, luna.MontBase22, 54+1, 30+1, Color( 0, 0, 0, 60 ), 0, 1)
	-- 				draw.ShadowSimpleText(rating, luna.MontBase22, 54, 30, Color( 190, 190, 190, 255 ), 0, 1)
	-- 			end
	-- 			if self:IsHovered() then
	-- 				draw.RoundedBox(6,0,0,w,h,Color(230, 230, 230, 4))
	-- 			end
	-- 		end
	-- 	end
	-- 	local mdl = vgui.Create("ModelImage", pnl)
	-- 	mdl:SetSize( 50, 50 )
	-- 	mdl:SetPos( 0, 0 )
	-- 	mdl:SetModel( char.model )
	-- end
	-- local Desc = vgui.Create( "DTextEntry", top )
	-- Desc:SetTall( 100 )
	-- Desc:SetMultiline( true )
	-- Desc:Dock( BOTTOM )
	-- Desc:SetPaintBorderEnabled( true )
	-- Desc:SetFont("font_base_18")
	-- if not LocalPlayer():CanUseWhitelist() then
	-- 	Desc:SetDisabled(true)
	-- end
	-- Desc.Paint = function( self, w, h )
	-- 	draw.RoundedBox(6,0,0,w,h,Color(0, 0, 0, 100))
	-- 	self:DrawTextEntryText(Color(255,255,255,240), Color(0,165,255,255), Color(255,255,255,240))
	-- end
	-- local Scroll = vgui.Create( "DScrollPanel", Panel )
	-- Scroll:Dock( FILL )
	-- Scroll.VBar:SetWide(0)
	-- local layout = vgui.Create("DListLayout", Scroll)
	-- layout:Dock( FILL )
	-- local job = re.jobs[index]
	-- for i, char in pairs(characters) do
	-- 	if TOP_RATINGS_WHITELIST[char.rating] then continue end
	-- 	local pnl = vgui.Create( "Panel", WhitelistMenu )
	-- 	pnl:SetTall(30)
	-- 	pnl.Paint = function( self, w, h )
	-- 		local pcol = team.GetColor(index)
	-- 		h = 28
	-- 		if pcol then
	-- 			draw.RoundedBox(6,0,0,w,h,Color(pcol.r, pcol.g, pcol.b, 200))
	-- 			surface.SetDrawColor( 0, 0, 0, 100 )
	-- 			surface.DrawOutlinedRect( 0,0,w,h, 1 )
	-- 			local rpid = char.rpid
	-- 			rpid = rpid and " "..rpid.."" or ""
	-- 			local rating = char.rating or ""
	-- 			rating = rating or ""
	-- 			local name = char.character_name
	-- 			draw.ShadowSimpleText(name, luna.MontBase22, 32+1, h/2+1, Color( 0, 0, 0, 60 ), 0, 1)
	-- 			draw.ShadowSimpleText(name, luna.MontBase22, 32, h/2, Color( 255, 255, 255, 250 ), 0, 1)
	-- 			local oldname = char.player
	-- 			surface.SetFont(luna.MontBase22)
	-- 			local wt, _ = surface.GetTextSize(" "..rpid)
	-- 			draw.RoundedBox(0, w-wt, 0, wt, h, Color(pcol.r-12,pcol.g-12,pcol.b-12,255))
	-- 			if rating then
	-- 				draw.ShadowSimpleText(rating.." "..rpid, luna.MontBase22, w - 4 +1, h/2+1, Color( 0, 0, 0, 60 ), 2, 1)
	-- 				draw.ShadowSimpleText(rating.." "..rpid, luna.MontBase22, w - 4 , h/2, Color( 255, 255, 255, 255 ), 2, 1)
	-- 			end
	-- 			if self:IsHovered() then
	-- 				draw.RoundedBox(6,0,0,w,h,Color(230, 230, 230, 4))
	-- 			end
	-- 		end
	-- 	end
	-- 	local mdl = vgui.Create("ModelImage", pnl)
	-- 	mdl:SetSize( 28, 28 )
	-- 	mdl:SetPos( 0, 0 )
	-- 	mdl:SetModel( char.model )
	-- 	layout:Add( pnl )
	-- end
	WhitelistMenu.Current = Panel
	WhitelistMenu.Divider:SetRight(Panel)
end

netstream.Hook("ViewWhitelistLegion", ViewWhitelistLegion)
local function OpenWhitelist()
	if not WHITELIST_ADMINS[LocalPlayer():GetUserGroup()] then return end
	if WhitelistMenu.Current then WhitelistMenu.Current:Remove() end
	local Panel = vgui.Create("Panel")
	local DCollapsible = vgui.Create("DCategoryList", Panel)
	DCollapsible:Dock(FILL)
	DCollapsible.Paint = function(self, w, h) end
	DCollapsible.VBar:SetWide(0)
	local cats_with_pls = {}
	for i, pl in pairs(player.GetAll()) do
		local team_index = pl:Team()
		if team_index == TEAM_CONNECTING or team_index == TEAM_UNASSIGNED then continue end
		if not cats_with_pls[team_index] and isnumber(team_index) then
			cat = DCollapsible:Add("")
			cat.Header.Paint = function(self, w, h) end
			cat.Paint = function(self, w, h)
				if not team_index or not istable(re.jobs[team_index]) then return end
				draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 90))
				-- surface.SetDrawColor( 0, 0, 0, 100 )
				-- surface.DrawOutlinedRect( 0, 0, w, 18, 1 )
				draw.ShadowSimpleText(re.jobs[team_index].Name, luna.MontBase22, 4, 18 / 2, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end

			cats_with_pls[team_index] = vgui.Create("DIconLayout", cat)
			cat:SetContents(cats_with_pls[team_index])
			cats_with_pls[team_index]:SetSpaceX(5)
			cats_with_pls[team_index]:SetSpaceY(5)
			cats_with_pls[team_index]:DockMargin(5, 5, 5, 5)
		end
	end

	for i, pl in pairs(player.GetAll()) do
		local team_index = pl:Team()
		if not team_index or not re.jobs[team_index] or not re.jobs[team_index].jobID then continue end
		if team_index == TEAM_CONNECTING or team_index == TEAM_UNASSIGNED then continue end

		local char = {
			player_id = pl:GetNWInt("player_id"),
			char_id = pl:GetNetVar("character"),
			character_name = pl:GetNWString("rpname"),
			steam_id = pl:SteamID(),
			rating = pl:GetNWString("rating"),
			model = pl:GetModel(),
			features = pl:GetNetVar("features"),
			team_index = team_index,
			team_id = re.jobs[team_index].jobID,
			rpid = pl:GetRPID()
		}

		-- if TOP_RATINGS_WHITELIST[char.rating] then continue end
		local pnl = vgui.Create("Panel")
		pnl:SetSize(160, 260)
		pnl.Paint = function(self, w, h)
			local pcol = team.GetColor(team_index)
			if pcol then
				draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(pcol, 140))
				-- surface.SetDrawColor( 0, 0, 0, 100 )
				-- surface.DrawOutlinedRect( 0,0, w,h, 1 )
				-- local name = char.character_name
				-- draw.ShadowSimpleText(name, luna.MontBase22, 32+1, h/2+1, Color( 0, 0, 0, 60 ), 0, 1)
				-- draw.ShadowSimpleText(name, luna.MontBase22, 32, h/2, Color( 255, 255, 255, 250 ), 0, 1)
				-- local oldname = char.player
				-- surface.SetFont(luna.MontBase22)
				-- local wt, _ = surface.GetTextSize(" "..rpid)
				-- draw.RoundedBox(0, w-wt, 0, wt, h, Color(pcol.r-12,pcol.g-12,pcol.b-12,255))
				if self:IsHovered() then draw.RoundedBox(6, 0, 0, w, h, Color(230, 230, 230, 4)) end
			end
		end

		local mdl = vgui.Create("DModelPanel", pnl)
		mdl:Dock(FILL)
		mdl:SetCamPos(Vector(185, -20, 50))
		mdl:SetLookAt(Vector(0, 0, 50))
		mdl:SetFOV(10)
		mdl:SetModel(pl:GetModel())
		mdl.Entity:SetSequence(mdl.Entity:LookupSequence("pose_standing_02"))
		function mdl:LayoutEntity(Entity)
			self:RunAnimation()
		end

		mdl.DoClick = function()
			if WhitelistMenu.Whitelist then
				WhitelistMenu.Whitelist:Remove()
				surface.PlaySound("luna_ui/click1.wav")
			end

			WhitelistMenu.Whitelist = OpenCharWhitelist(char)
		end

        local active_feature
        if char and char.features then  -- Ensure `char` and `char.features` exist
            for f, b in pairs(char.features) do
                if b then
                    active_feature = FEATURES_TO_NORMAL[f].name
                    break
                end
            end
        else
            print("Error: `char` or `char.features` is nil!")
        end


		local click = true
		mdl._Paint = mdl.Paint
		local anim
		mdl.Paint = function(self, w, h)
			self._Paint(self, w, h)
			draw.ShadowSimpleText(char.character_name, luna.MontBase30, w / 2, h - 5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
			if active_feature then draw.ShadowSimpleText(active_feature, luna.MontBase22, w / 2, h - 30, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM) end
			draw.ShadowSimpleText(char.rating, luna.MontBaseSmall, 5, 5, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.ShadowSimpleText(char.rpid, luna.MontBaseSmall, w - 5, 5, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
			if self:IsHovered() then
				if click then
					anim = table.Random({"wos_fn_bestmates", "wos_fn_boneless", "wos_fn_breakdown", "wos_fn_dancemoves", "wos_fn_discofever", "wos_fn_eagle", "wos_fn_electroshuffle", "wos_fn_flippin_incredible", "wos_fn_flipping_sexy", "wos_fn_floss", "wos_fn_fresh", "wos_fn_gentlemandab", "wos_fn_groovejam", "wos_fn_handsignals", "wos_fn_hype", "wos_fn_infinidab", "wos_fn_intensity", "wos_fn_jubilation", "wos_fn_laughitup", "wos_fn_livinglarge", "wos_fn_orangejustice", "wos_fn_poplock", "wos_fn_rambunctious", "wos_fn_reanimated", "wos_fn_starpower", "wos_fn_swipeit", "wos_fn_takethel", "wos_fn_trueheart", "wos_fn_twist", "wos_fn_wiggle", "wos_fn_youreawesome", "wos_fn_zany"})
					click = false
				end

				self.Entity:SetSequence(self.Entity:LookupSequence(anim))
				draw.RoundedBox(6, 0, 0, w, h, Color(230, 230, 230, 4))
			else
				click = true
				self.Entity:SetSequence(self.Entity:LookupSequence("pose_standing_02"))
			end
		end

		cats_with_pls[pl:Team()]:Add(pnl)
	end

	-- local List = vgui.Create( "DIconLayout", top )
	-- List:SetTall(50)
	-- List:Dock( BOTTOM )
	-- List:DockMargin( 4, 4, 4, 4 )
	-- List:SetSpaceY( 5 )
	-- List:SetSpaceX( 5 )
	-- local i = 0
	-- for _, char in pairs(characters) do
	-- 	if not TOP_RATINGS_WHITELIST[char.rating] then continue end
	-- 	if i > 3 then continue end
	-- 	i = i + 1
	-- 	local pnl = List:Add( "DPanel" )
	-- 	pnl:SetSize(191,50)
	-- 	pnl.Paint = function( self, w, h )
	-- 		local pcol = team.GetColor(index)
	-- 		if pcol then
	-- 			draw.RoundedBox(6,0,0,w,h,Color(pcol.r, pcol.g, pcol.b, 200))
	-- 			surface.SetDrawColor( 0, 0, 0, 100 )
	-- 			surface.DrawOutlinedRect( 0,0,w,h, 1 )
	-- 			local rpid = char.rpid
	-- 			rpid = rpid and " "..rpid.."" or ""
	-- 			local rating = char.rating or ""
	-- 			rating = rating or ""
	-- 			local name = char.character_name
	-- 			draw.ShadowSimpleText(name, luna.MontBase22, 52+1, 14+1, Color( 0, 0, 0, 60 ), 0, 1)
	-- 			draw.ShadowSimpleText(name, luna.MontBase22, 52, 14, Color( 255, 255, 255, 250 ), 0, 1)
	-- 			local oldname = char.player
	-- 			surface.SetFont(luna.MontBase22)
	-- 			local wt, _ = surface.GetTextSize(" "..rpid)
	-- 			draw.RoundedBox(0, w-wt, 0, wt, h, Color(pcol.r-12,pcol.g-12,pcol.b-12,255))
	-- 			if rating then
	-- 				draw.ShadowSimpleText(rpid, luna.MontBase22, w - 4 +1, h/2+1, Color( 0, 0, 0, 60 ), 2, 1)
	-- 				draw.ShadowSimpleText(rpid, luna.MontBase22, w - 4 , h/2, Color( 255, 255, 255, 255 ), 2, 1)
	-- 				draw.ShadowSimpleText(rating, luna.MontBase22, 54+1, 30+1, Color( 0, 0, 0, 60 ), 0, 1)
	-- 				draw.ShadowSimpleText(rating, luna.MontBase22, 54, 30, Color( 190, 190, 190, 255 ), 0, 1)
	-- 			end
	-- 			if self:IsHovered() then
	-- 				draw.RoundedBox(6,0,0,w,h,Color(230, 230, 230, 4))
	-- 			end
	-- 		end
	-- 	end
	-- 	local mdl = vgui.Create("ModelImage", pnl)
	-- 	mdl:SetSize( 50, 50 )
	-- 	mdl:SetPos( 0, 0 )
	-- 	mdl:SetModel( char.model )
	-- end
	-- local Desc = vgui.Create( "DTextEntry", top )
	-- Desc:SetTall( 100 )
	-- Desc:SetMultiline( true )
	-- Desc:Dock( BOTTOM )
	-- Desc:SetPaintBorderEnabled( true )
	-- Desc:SetFont("font_base_18")
	-- if not LocalPlayer():CanUseWhitelist() then
	-- 	Desc:SetDisabled(true)
	-- end
	-- Desc.Paint = function( self, w, h )
	-- 	draw.RoundedBox(6,0,0,w,h,Color(0, 0, 0, 100))
	-- 	self:DrawTextEntryText(Color(255,255,255,240), Color(0,165,255,255), Color(255,255,255,240))
	-- end
	-- local Scroll = vgui.Create( "DScrollPanel", Panel )
	-- Scroll:Dock( FILL )
	-- Scroll.VBar:SetWide(0)
	-- local layout = vgui.Create("DListLayout", Scroll)
	-- layout:Dock( FILL )
	-- local job = re.jobs[index]
	-- for i, char in pairs(characters) do
	-- 	if TOP_RATINGS_WHITELIST[char.rating] then continue end
	-- 	local pnl = vgui.Create( "Panel", WhitelistMenu )
	-- 	pnl:SetTall(30)
	-- 	pnl.Paint = function( self, w, h )
	-- 		local pcol = team.GetColor(index)
	-- 		h = 28
	-- 		if pcol then
	-- 			draw.RoundedBox(6,0,0,w,h,Color(pcol.r, pcol.g, pcol.b, 200))
	-- 			surface.SetDrawColor( 0, 0, 0, 100 )
	-- 			surface.DrawOutlinedRect( 0,0,w,h, 1 )
	-- 			local rpid = char.rpid
	-- 			rpid = rpid and " "..rpid.."" or ""
	-- 			local rating = char.rating or ""
	-- 			rating = rating or ""
	-- 			local name = char.character_name
	-- 			draw.ShadowSimpleText(name, luna.MontBase22, 32+1, h/2+1, Color( 0, 0, 0, 60 ), 0, 1)
	-- 			draw.ShadowSimpleText(name, luna.MontBase22, 32, h/2, Color( 255, 255, 255, 250 ), 0, 1)
	-- 			local oldname = char.player
	-- 			surface.SetFont(luna.MontBase22)
	-- 			local wt, _ = surface.GetTextSize(" "..rpid)
	-- 			draw.RoundedBox(0, w-wt, 0, wt, h, Color(pcol.r-12,pcol.g-12,pcol.b-12,255))
	-- 			if rating then
	-- 				draw.ShadowSimpleText(rating.." "..rpid, luna.MontBase22, w - 4 +1, h/2+1, Color( 0, 0, 0, 60 ), 2, 1)
	-- 				draw.ShadowSimpleText(rating.." "..rpid, luna.MontBase22, w - 4 , h/2, Color( 255, 255, 255, 255 ), 2, 1)
	-- 			end
	-- 			if self:IsHovered() then
	-- 				draw.RoundedBox(6,0,0,w,h,Color(230, 230, 230, 4))
	-- 			end
	-- 		end
	-- 	end
	-- 	local mdl = vgui.Create("ModelImage", pnl)
	-- 	mdl:SetSize( 28, 28 )
	-- 	mdl:SetPos( 0, 0 )
	-- 	mdl:SetModel( char.model )
	-- 	layout:Add( pnl )
	-- end
	WhitelistMenu.Current = Panel
	WhitelistMenu.Divider:SetRight(Panel)
end

local function OpenNextInfo(jdata)
	if not WHITELIST_ADMINS[LocalPlayer():GetUserGroup()] then return end
	local Left = vgui.Create("Panel", WhitelistMenu)
	Left.Paint = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100)) end
	WhitelistMenu.Model:SetParent(Left)
	WhitelistMenu.Model:Dock(FILL)
	WhitelistMenu.Model:SetLookAt(Vector(20, 0, 35))
	WhitelistMenu.Model._Paint = WhitelistMenu.Model.Paint
	WhitelistMenu.Model.Paint = function(self, w, h)
		self._Paint(self, w, h)
		draw.ShadowSimpleText(jdata.Name, luna.MontBase54, w / 2, 10, jdata.Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		draw.ShadowSimpleText("W legionie " .. (WhitelistMenu.CharacterCounts[jdata.jobID] or 0) .. " postaci", luna.MontBase24, w / 2, 70, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		if WhitelistMenu.SelectedChar then
			h = h - 35
			local char = WhitelistMenu.SelectedChar
			draw.ShadowSimpleText("Nazwa postaci: " .. char.character_name .. " " .. char.rpid, luna.MontBase30, 10, h - 70, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
			draw.ShadowSimpleText("Ranga: " .. char.rating, luna.MontBase30, 10, h - 40, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
			local feats = {}
			for f, b in pairs(char.features) do
				if b then table.insert(feats, FEATURES_TO_NORMAL[f].name) end
			end

			draw.ShadowSimpleText("Specjalizacje: " .. string.Implode(", ", feats), luna.MontBase30, 10, h - 10, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
		end
	end

	local Down = vgui.Create("DButton", Left)
	Down:SetSize(24, 24)
	Down:SetPos(0, 0)
	Down:SetText('')
	Down.Paint = function(self, w, h)
		draw.RoundedBox(6, 0, 0, w, h, COLOR_BG)
		draw.ShadowSimpleText("<", luna.MontBase30, w / 2, h / 2, COLOR_WHITE, 1, 1)
	end

	local oldLeft = WhitelistMenu.Divider:GetLeft()
	oldLeft:SetVisible(false)
	Down.DoClick = function(self)
		surface.PlaySound("luna_ui/click1.wav")
		oldLeft:SetVisible(true)
		WhitelistMenu.Divider:GetLeft():Remove()
		WhitelistMenu.Divider:SetLeft(oldLeft)
		WhitelistMenu.Model:Remove()
		netstream.Start("ViewInfoLegion", WhitelistMenu.lastID)
		self:Remove()
	end

	local Right = vgui.Create("Panel", WhitelistMenu)
	Right.Paint = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100)) end
	netstream.Start("ViewWhitelistLegion", jdata.jobID)
	WhitelistMenu.Divider:GetRight():Remove()
	WhitelistMenu.Current = Right
	WhitelistMenu.Divider:SetLeft(Left)
	WhitelistMenu.Divider:SetRight(Right)
end

local function ViewInfoLegion(jobID, data)
	local jdata = FindJobByID(jobID)
	if WhitelistMenu.Current then WhitelistMenu.Current:Remove() end
	-- local job = re.jobs[index]
	WhitelistMenu.lastID = jobID
	local Panel = vgui.Create("Panel", WhitelistMenu)
	Panel.Paint = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100)) end
	-- local Model = vgui.Create("DModelPanel", Panel)
	-- Model:Dock( FILL )
	-- Model:SetCamPos(Vector( 160, -20, 50 ))
	-- Model:SetLookAt(Vector( 0, 0, 45 ))
	-- Model:SetFOV(10)
	Panel.Right = vgui.Create("Panel", Panel)
	Panel.Right:Dock(RIGHT)
	Panel.Right.Paint = function(self, w, h) self:SetWide(self:GetParent():GetWide() / 2) end
	Panel.Right.Header = vgui.Create("DLabel", Panel.Right)
	Panel.Right.Header:Dock(TOP)
	Panel.Right.Header:SetFont(luna.MontBase54)
	Panel.Right.Header:SetTextColor(jdata.Color)
	Panel.Right.Header:SetText(jdata.Name)
	Panel.Right.Header:SetTall(60)
	Panel.Right.Header:DockMargin(0, 200, 0, 0)
	Panel.Right.Desc = vgui.Create("DTextEntry", Panel.Right)
	Panel.Right.Desc:Dock(FILL)
	Panel.Right.Desc:SetFont(luna.MontBase24)
	Panel.Right.Desc:SetTextColor(COLOR_WHITE)
	Panel.Right.Desc:SetText(data.description)
	Panel.Right.Desc:DockMargin(0, 10, 50, 5)
	Panel.Right.Desc:SetMultiline(true)
	Panel.Right.Bottom = vgui.Create("Panel", Panel.Right)
	Panel.Right.Bottom:Dock(BOTTOM)
	Panel.Right.Bottom:SetText("")
	Panel.Right.Bottom:SetTall(40)
	Panel.Right.Bottom:DockMargin(0, 0, 50, 300)
	Panel.Right.Next = vgui.Create("DButton", Panel.Right.Bottom)
	Panel.Right.Next:Dock(FILL)
	Panel.Right.Next:SetText("")
	Panel.Right.Next:SetTall(40)
	Panel.Right.Next:DockMargin(0, 0, 10, 0)
	-- Panel.Right.Next:SetWide(400)
	Panel.Right.Label = vgui.Create("DLabel", Panel.Right.Bottom)
	Panel.Right.Label:Dock(RIGHT)
	Panel.Right.Label:SetText(data.player)
	Panel.Right.Label:SetWide(100)
	Panel.Right.Label:DockMargin(10, 0, 0, 0)
	Panel.Right.Label:SetFont(luna.MontBase24)
	Panel.Right.LastAvatar = vgui.Create("AvatarImage", Panel.Right.Bottom)
	Panel.Right.LastAvatar:Dock(RIGHT)
	Panel.Right.LastAvatar:SetText("")
	Panel.Right.LastAvatar:SetSize(40, 40)
	Panel.Right.LastAvatar:SetSteamID(data.community_id)
	Panel.Right.Next.Paint = function(self, w, h)
		draw.RoundedBox(6, 0, 0, w, h, COLOR_BG)
		draw.ShadowSimpleText("Więcej informacji", luna.MontBase30, w / 2, h / 2, COLOR_WHITE, 1, 1)
	end

	local description = data.description
	if LocalPlayer():CanUseWhitelist() then
		-- Panel.Right.Desc:SetDisabled(false)
		Panel.Right.Desc.Save = vgui.Create("DButton", Panel.Right.Desc)
		Panel.Right.Desc.Save:SetPos(200, 10)
		Panel.Right.Desc.Save:SetWide(120)
		Panel.Right.Desc.Save:SetText("")
		Panel.Right.Desc.Save:SetTall(26)
		Panel.Right.Desc.Save.Paint = function(self, w, h)
			draw.RoundedBox(6, 0, 0, w, h, COLOR_HOVER)
			draw.ShadowSimpleText("Zapisz", luna.MontBase24, w / 2, h / 2, COLOR_WHITE, 1, 1)
		end

		Panel.Right.Desc.Save.DoClick = function()
			surface.PlaySound("luna_ui/click1.wav")
			description = Panel.Right.Desc:GetValue()
			netstream.Start("LegionDescription_Change", {
				team_id = jobID,
				description = description
			})

			Panel.Right.LastAvatar:SetPlayer(LocalPlayer())
			Panel.Right.Label:SetText(LocalPlayer():OldName())
		end
	end

	Panel.Right.Desc.Paint = function(self, w, h)
		draw.RoundedBox(6, 0, 0, w, h, Color(0, 0, 0, 100))
		self:DrawTextEntryText(Color(255, 255, 255, 240), Color(0, 165, 255, 255), Color(255, 255, 255, 240))
		if Panel.Right.Desc.Save then
			if Panel.Right.Desc:GetValue() ~= description then
				Panel.Right.Desc.Save:SetPos(Panel.Right.Desc:GetWide() - Panel.Right.Desc.Save:GetWide() - 10, 10)
				Panel.Right.Desc.Save:Show()
			else
				Panel.Right.Desc.Save:Hide()
			end
		end
	end

	WhitelistMenu.Model = vgui.Create("DModelPanel", Panel)
	WhitelistMenu.Model:Dock(FILL)
	WhitelistMenu.Model:SetCamPos(Vector(265, -20, 50))
	WhitelistMenu.Model:SetLookAt(Vector(20, 0, 45))
	WhitelistMenu.Model:SetFOV(10)
	-- WhitelistMenu.Model:SetModel(istable(jdata.WorldModel) and table.Random(jdata.WorldModel) or jdata.WorldModel)
	WhitelistMenu.Model:SetModel(jdata.WorldModel[1])
	WhitelistMenu.Model.Entity:SetSequence(WhitelistMenu.Model.Entity:LookupSequence(table.Random({"pose_standing_01", "pose_standing_02", "pose_standing_03", "pose_standing_04"})))
	function WhitelistMenu.Model:LayoutEntity(Entity)
		self:RunAnimation()
	end

	Panel.Right.Next.DoClick = function()
		surface.PlaySound("luna_ui/click1.wav")
		OpenNextInfo(jdata)
	end

	-- Model:SetRotation(false)
	-- local top = vgui.Create( "DPanel", Panel )
	-- top:Dock( TOP )
	-- top:SetTall(200)
	-- top.Paint = function( self, w, h )
	-- 	draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))
	-- end
	WhitelistMenu.Current = Panel
	WhitelistMenu.Divider:SetRight(Panel)
end

netstream.Hook("ViewInfoLegion", ViewInfoLegion)
netstream.Hook("OpenWhitelistMenu", function(counts)
	if not WHITELIST_ADMINS[LocalPlayer():GetUserGroup()] then return end
	local status = 0 -- 0 - info, 1 - whitelist
	if IsValid(WhitelistMenu) then WhitelistMenu:Remove() end
	WhitelistMenu = vgui.Create("Panel")
	WhitelistMenu:SetSize(ScrW(), ScrH())
	WhitelistMenu:Center()
	-- WhitelistMenu:SetDraggable(false)
	-- WhitelistMenu:SetTitle("")
	WhitelistMenu.CharacterCounts = counts
	WhitelistMenu:SetAlpha(0)
	WhitelistMenu:AlphaTo(255, .4)
	-- WhitelistMenu:ShowCloseButton(false)
	local Close = vgui.Create("DButton", WhitelistMenu)
	Close:SetText("")
	Close:SetSize(32, 32)
	Close:SetPos(WhitelistMenu:GetWide() - Close:GetWide() - 4, 4)
	Close:SetZPos(32767)
	Close.Paint = function(self, w, h)
		draw.RoundedBox(6, 0, 0, w, h, Color(191, 67, 57))
		draw.SimpleText("X", luna.MontBase22, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
	end

	Close.DoClick = function(self)
		surface.PlaySound("luna_ui/click1.wav")
		WhitelistMenu:Remove()
		surface.PlaySound("luna_ui/pop.wav")
	end

	WhitelistMenu.startTime = SysTime()
	surface.PlaySound("luna_ui/blip1.wav")
	netstream.Start("ViewInfoLegion", re.jobs[TEAM_CADET].jobID)
	-- WhitelistMenu:ShowCloseButton(false)
	WhitelistMenu.Paint = function(self, w, h)
		-- local x, y = self:GetPos()
		-- draw.DrawBlur( x, y, self:GetWide(), self:GetTall(), 2 )
		-- Derma_DrawBackgroundBlur(self, self.startTime)
		local x, y = self:GetPos()
		draw.DrawBlur(x, y, self:GetWide(), self:GetTall(), 6)
		draw.RoundedBox(0, 0, 0, w, h, COLOR_BG)
		surface.SetDrawColor(255, 255, 255, 170)
		surface.SetMaterial(mat_bg)
		surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
	end

	WhitelistMenu:MakePopup()
	WhitelistMenu.Divider = vgui.Create("DHorizontalDivider", WhitelistMenu)
	WhitelistMenu.Divider:Dock(FILL)
	WhitelistMenu.Divider:SetDividerWidth(4)
	WhitelistMenu.Divider:SetLeftMin(420)
	WhitelistMenu.Divider:SetRightMin(700)
	WhitelistMenu.Divider:SetLeftWidth(420)
	local Left = vgui.Create("Panel")
	-- Left:SetWide( 500 )
	Left.Paint = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, ColorAlpha(COLOR_BG, 90)) end
	WhitelistMenu.Divider:SetLeft(Left)
	Left.Top = vgui.Create("Panel", Left)
	Left.Top:Dock(TOP)
	Left.Top:SetTall(160)
	Left.Top.Info = vgui.Create("DButton", Left.Top)
	Left.Top.Info:SetSize(190, 40)
	Left.Top.Info:SetText("")
	Left.Top.Info.Paint = function(self, w, h)
		draw.RoundedBox(6, 0, 0, w, h, COLOR_BG)
		draw.ShadowSimpleText("INFORMACJA", luna.MontBase30, w / 2, h / 2, COLOR_WHITE, 1, 1)
	end

	Left.Top.Info.DoClick = function()
		surface.PlaySound("luna_ui/click1.wav")
		status = 0
		netstream.Start("ViewInfoLegion", WhitelistMenu.lastID)
	end

	Left.Top.Whitelist = vgui.Create("DButton", Left.Top)
	Left.Top.Whitelist:SetSize(190, 40)
	Left.Top.Whitelist:SetText("")
	Left.Top.Whitelist.Paint = function(self, w, h)
		draw.RoundedBox(6, 0, 0, w, h, COLOR_BG)
		draw.ShadowSimpleText("WHITELIST", luna.MontBase30, w / 2, h / 2, COLOR_WHITE, 1, 1)
		if self:GetDisabled() then
			draw.RoundedBox(6, 0, 0, w, h, COLOR_BG)
			draw.Icon(w / 2 - 12, h / 2 - 12, 24, 24, mat_lock, COLOR_WHITE)
		end
	end

	Left.Top.Whitelist.DoClick = function()
		surface.PlaySound("luna_ui/click1.wav")
		-- netstream.Start("ViewWhitelistLegion", WhitelistMenu.lastID)
		if LocalPlayer():CanUseWhitelist() then OpenWhitelist() end
	end

	-- if not LocalPlayer():CanUseWhitelist() then
	-- 	Left.Top.Whitelist:SetDisabled(true)
	-- end
	Left.Top.Paint = function(self, w, h)
		draw.Icon(10, -90, 450 * .9, 300 * .9, mat_rcbeta, color_white)
		Left.Top.Info:SetPos(Left:GetWide() / 2 - 200, 100)
		Left.Top.Whitelist:SetPos(Left:GetWide() / 2, 100)
	end

	ViewMain = function()
		local DCollapsible = vgui.Create("DCategoryList", Left)
		DCollapsible:Dock(FILL)
		DCollapsible.Paint = function(self, w, h) end
		DCollapsible.VBar:SetWide(0)
		local job_with_cats = {}
		for i, jdata in SortedPairsByMemberValue(re.jobs, "Type") do
			local TYPE = jdata.Type
			if not job_with_cats[TYPE] then
				job_with_cats[TYPE] = {
					jobs = {}
				}

				local cat = DCollapsible:Add("")
				job_with_cats[TYPE].panel = cat
				cat.Header.Paint = function(self, w, h) end
				-- cat.Header:SetFont( luna.MontBaseSmall )
				-- cat:SetTall(20)
				cat.Paint = function(self, w, h)
					-- draw.RoundedBox(4, 0, 0, w, 18, Color(0,0,0,90))
					-- surface.SetDrawColor( 0, 0, 0, 100 )
					-- surface.DrawOutlinedRect( 0, 0, w, 18, 1 )
					draw.ShadowSimpleText(NORMAL_TYPES[TYPE], luna.MontBase22, 4, 18 / 2, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
			end

			table.insert(job_with_cats[TYPE].jobs, jdata)
		end

		-- PrintTable(job_with_cats)
		for i, cat in SortedPairs(job_with_cats, false) do
			local List = vgui.Create("DListLayout", cat.panel)
			-- List:SetWide(cat.panel:GetWide())
			-- List:SetSize()
			-- List:SetPos(0,20)
			List:Dock(TOP)
			-- List:SetWide(500 - 10)
			-- List:SetSpaceY( 5 )
			-- List:SetSpaceX( 5 )
			for i, jdata in pairs(cat.jobs) do
				local icon = vgui.Create("DButton")
				icon:SetTall(60)
				-- icon:Dock( TOP )
				icon:DockMargin(0, 4, 0, 0)
				icon:SetText("")
				-- icon:SetModel( istable(jdata.WorldModel) and table.Random(jdata.WorldModel) or jdata.WorldModel )
				-- icon:SetFOV(36)
				-- icon:SetCamPos( Vector(40,0,60) )
				-- icon:SetLookAt( Vector(0,0,60) )
				-- icon:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80))
				-- icon:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255))
				-- icon._Paint = icon.Paint
				icon.Paint = function(self, w, h)
					-- draw.RoundedBox(6,0,0,w,h,COLOR_BG)
					draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(jdata.Color, self:IsHovered() and 150 or 100))
					-- if icon._Paint then icon._Paint( self, w, h ) end
					draw.ShadowSimpleText(team.GetName(jdata.index), luna.MontBase30, 65, 20, COLOR_WHITE, 0, 1)
					draw.ShadowSimpleText("Postacie: " .. (WhitelistMenu.CharacterCounts[jdata.jobID] or 0), luna.MontBase24, 65, 40, COLOR_WHITE, 0, 1)
				end

				icon.DoClick = function()
					--surface.PlaySound("luna_ui/click1.wav")
					if not jdata then return end
					netstream.Start("ViewInfoLegion", jdata.jobID)
					surface.PlaySound("luna_ui/click3.wav")
				end

				local mdl = vgui.Create("ModelImage", icon)
				mdl:SetSize(icon:GetTall(), icon:GetTall())
				mdl:SetPos(0, 0)
				mdl:SetModel(istable(jdata.WorldModel) and table.Random(jdata.WorldModel) or jdata.WorldModel)
				-- function icon:LayoutEntity( Entity )
				--     -- for k, v in pairs(self.Entity:GetSequenceList()) do
				--     --     print(v)
				--     -- end
				--     -- if self:IsHovered() then
				--     --     self.Entity:SetSequence( "gesture_salute_original" )
				--     -- else
				--     --     self.Entity:SetSequence( "walk_all" )
				--     -- end
				--     return
				-- end
				List:Add(icon)
			end
		end
		-- Left.Current = DCollapsible
		return WhitelistMenu.Current
	end

	ViewMain()
end)
-- local panel = WhitelistMenu:Add("DPanel")
-- panel:SetWide(200)
-- panel:Dock(LEFT)
-- -- panel:ShowCloseButton(false)
-- panel.Paint = function( self, w, h )
-- 	local x, y = self:GetPos()
-- 	draw.DrawBlur( x, y, self:GetWide(), self:GetTall(), 2 )
--     draw.RoundedBox(0,0,0,w,h,Color(46, 65, 84, 250))
-- end
-- local layout = panel:Add("DListLayout")
-- layout:Dock( FILL )
-- --Draw a background so we can see what it"s doing
-- layout:SetPaintBackground(true)
-- layout:SetBackgroundColor(Color(0, 100, 100))
-- layout:MakeDroppable( "unique_name" ) -- Allows us to rearrange children
-- for i = 1, 8 do
--     -- layout:Add( Label( " Label " .. i ) )
--     local leg = WhitelistMenu:Add("DButton")
--     leg:SetText("")
--     -- leg.Paint = function( self, w, h )
--     --     local x, y = self:GetPos()
--     --     draw.DrawBlur( x, y, self:GetWide(), self:GetTall(), 2 )
--     --     draw.RoundedBox(0,0,0,w,h,Color(46, 65, 84, 250))
--     -- end
--     layout:Add(leg)
-- end