local right_side_wide = 180
local names = {
	first = {"Liam", "Noah", "Mason", "Ethan", "Logan", "Lucas", "Jackson", "Aiden", "Oliver", "Jacob", "Elijah", "Alexander", "James", "Benjamin", "Jack", "Luke", "William", "Michael", "Owen", "Daniel", "Carter", "Gabriel", "Henry", "Matthew", "Wyatt", "Caleb", "Jayden", "Nathan", "Ryan", "Isaac", "Emma", "Olivia", "Ava", "Sophia", "Isabella", "Mia", "Charlotte", "Amelia", "Emily", "Madison", "Harper", "Abigail", "Avery", "Lily", "Ella", "Chloe", "Evelyn", "Sofia", "Aria", "Ellie", "Aubrey", "Scarlett", "Zoey", "Hannah", "Audrey", "Grace", "Addison", "Zoe", "Elizabeth", "Nora", "Abramson", "Adamson", "Adderiy", "Addington", "Adrian", "Albertson", "Aldridge", "Allford", "Alsopp", "Anderson", "Andrews", "Archibald", "Arnold", "Arthurs", "Atcheson", "Attwood", "Audley", "Austin", "Ayrton", "Babcock", "Backer", "Baldwin", "Bargeman", "Barnes", "Barrington", "Bawerman", "Becker", "Benson", "Berrington", "Birch", "Bishop", "Black", "Blare", "Blomfield", "Boolman", "Bootman", "Bosworth", "Bradberry", "Bradshaw", "Brickman", "Brooks", "Brown", "Bush", "Calhoun", "Campbell", "Carey", "Carrington", "Carroll", "Carter", "Chandter", "Chapman", "Charlson", "Chesterton", "Clapton", "Clifford", "Coleman", "Conors", "Cook", "Cramer", "Creighton", "Croftoon", "Crossman", "Daniels", "Davidson", "Day", "Dean", "Derrick", "Dickinson", "Dodson", "Donaldson", "Donovan", "Douglas", "Dowman", "Dutton", "Duncan", "Dunce", "Durham", "Dyson", "Eddington", "Edwards", "Ellington", "Elmers", "Enderson", "Erickson", "Evans", "Faber", "Fane", "Farmer", "Farrell", "Ferguson", "Finch", "Fisher", "Fitzgerald", "Flannagan", "Flatcher", "Fleming", "Ford", "Forman", "Forster", "Foster", "Francis", "Fraser", "Freeman", "Fulton", "Galbraith", "Gardner", "Garrison", "Gate", "Gerald", "Gibbs", "Gilbert", "Gill", "Gilmore", "Gilmore", "Gimson", "Goldman", "Goodman", "Gustman", "Haig", "Hailey", "Hamphrey", "Hancock", "Hardman", "Harrison", "Hawkins", "Higgins", "Hodges", "Hoggarth", "Holiday", "Holmes", "Howard", "Jacobson", "James", "Jeff", "Jenkin", "Jerome", "Johnson", "Jones", "Keat", "Kelly", "Kendal", "Kennedy", "Kennett", "Kingsman", "Kirk", "Laird", "Lamberts", "Larkins", "Lawman", "Leapman", "Leman", "Lewin", "Little", "Livingston", "Longman", "MacAdam", "MacAlister", "MacDonald", "Macduff", "Macey", "Mackenzie", "Mansfield", "Marlow", "Marshman", "Mason", "Mathews", "Mercer", "Michaelson", "Miers", "Miller", "Miln", "Milton", "Molligan", "Morrison", "Murphy", "Nash", "Nathan", "Neal", "Nelson", "Nevill", "Nicholson", "Nyman", "Oakman", "Ogden", "Oldman", "Oldridge", "Oliver", "Osborne", "Oswald", "Otis", "Owen", "Page", "Palmer", "Parkinson", "Parson", "Pass", "Paterson", "Peacock", "Pearcy", "Peterson", "Philips", "Porter", "Quincy", "Raleigh", "Ralphs", "Ramacey", "Reynolds", "Richards", "Roberts", "Roger", "Russel", "Ryder", "Salisburry", "Salomon", "Samuels", "Saunder", "Shackley", "Sheldon", "Sherlock", "Shorter", "Simon", "Simpson", "Smith", "Stanley", "Stephen", "Stevenson", "Sykes", "Taft", "Taylor", "Thomson", "Thorndike", "Thornton", "Timmons", "Tracey", "Turner", "Vance", "Vaughan", "Wainwright", "Walkman", "Wallace", "Waller", "Walter", "Ward", "Warren", "Watson", "Wayne", "Webster", "Wesley", "White", "WifKinson", "Winter", "Wood", "Youmans", "Young",},
}

-- local mysound = CreateSound( "sup_sound/music/class/background.mp3" )
function textWrap(text, font, pxWidth)
	local total = 0
	surface.SetFont(font)
	local spaceSize = surface.GetTextSize(" ")
	text = text:gsub("(%s?[%S]+)", function(word)
		local char = string.sub(word, 1, 1)
		if char == "\n" or char == "\t" then total = 0 end
		local wordlen = surface.GetTextSize(word)
		total = total + wordlen
		-- Wrap around when the max width is reached
		if wordlen >= pxWidth then -- Split the word if the word is too big
			local splitWord, splitPoint = charWrap(word, pxWidth - (total - wordlen))
			total = splitPoint
			return splitWord
		elseif total < pxWidth then
			return word
		end

		-- Split before the word
		if char == " " then
			total = wordlen - spaceSize
			return "\n" .. string.sub(word, 2)
		end

		total = wordlen
		return "\n" .. word
	end)
	return text
end

function LerpColor2(from, to, duration)
	return Color(Lerp(duration, from.r, to.r), Lerp(duration, from.g, to.g), Lerp(duration, from.b, to.b), Lerp(duration, from.a, to.a))
end

--local wallpaper = Material("renaissance/bg/bgmain2.png", "noclamp smooth")
local wallpaper = Material("renaissance/logo/fon.png", "noclamp smooth")
local charwall = Material("celestia/cwrp/charwall.png", "noclamp smooth")
local replogo = Material("celestia/cwrp/rep1.png", "smooth noclamp")
local logo = Material("renaissance/logo/neeeewava.png", "smooth noclamp")
local mat_rcbeta = Material("renaissance/logo/newzagolovok2.png", "smooth noclamp")
local jedi = Material("renaissance/random/character_orb.png", "smooth noclamp")
local background = Material("luna_ui_base/fon.png")
local mat_circle = Material("luna_ui_base/circle-element1.png")
local mat_corner = Material("luna_ui_base/luna-ui_gradient-corner_2k.png", 'noclamp smooth')
local halfWidth = 42
local CreationMenu = CreationMenu or nil
local CurActivePanel = CurActivePanel or nil
local CreatePanel = CreatePanel or nil
local bgalpha = 0
local CurProf
local initcharMenu
local function OpenCharacterMenu(data)
	local characters = data.characters
	local err = data.err
	if IsValid(CreationMenu) then CreationMenu:Remove() end
	local list_models = {}
	-- mysound:Play()
	CreationMenu = vgui.Create("DFrame")
	CreationMenu:SetPos(0, 0)
	CreationMenu:SetSize(ScrW(), ScrH())
	CreationMenu:SetDraggable(false)
	CreationMenu:SetTitle("")
	CreationMenu:ShowCloseButton(false)
	CreationMenu.Paint = function(self, w, h)
		bgalpha = Lerp(FrameTime() * 6, bgalpha or 0, 255)
		surface.SetMaterial(background)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
		if err then
			surface.SetFont(luna.MontBase22)
			local wt, _ = surface.GetTextSize(err)
			draw.RoundedBox(6, 10, 10, wt + 6, 26, Color(0, 0, 0, 100))
			draw.SimpleText(err, luna.MontBase22, 12, 12, Color(255, 255, 255, 255))
		end
	end

	-- dhtml = CreationMenu:Add("DHTML")
	-- dhtml:SetSize(CreationMenu:GetWide(), CreationMenu:GetTall())
	-- dhtml:SetPos(CreationMenu:GetWide()*.2, CreationMenu:GetTall()*.5)
	-- dhtml:SetHTML([[
	-- 	<img src="https://c.tenor.com/B52SOib3A64AAAAC/tenor.gif"/>
	-- 	<img src="https://media.discordapp.net/attachments/835608565241741324/899410205673136148/GIF_19.02.2021_15-19-48.gif?ex=66b92e87&is=66b7dd07&hm=3cae36131a416e45ca670633e5d62db70ced8e713f2fd13da64151cb759cfd67&"/>
	-- ]])
	CreationMenu.SafetyRemove = function(self) if IsValid(self) then self:AlphaTo(0, 0.3, 0, function() self:Remove() end) end end
	timer.Simple(5, function() err = nil end)
	CreationMenu:MakePopup()
	local function drop()
		for _, value in pairs(F4_CREATECHAR) do
			for _, v in pairs(value.lerps) do
				v = 0
			end
		end

		CurProf = TEAM_CADET
	end

	local MenuListButton = CreationMenu:Add("DScrollPanel")
	MenuListButton:Dock(LEFT)
	MenuListButton:SetWide(300)
	MenuListButton:DockMargin(20, CreationMenu:GetTall() * .4 - MenuListButton:GetTall() * .4, 52, 0)
	local DPanel = vgui.Create("DPanel", CreationMenu)
	DPanel:SetSize(CreationMenu:GetWide() - MenuListButton:GetWide(), math.Round(900 * math.min(ScrW(), ScrH()) / 1080))
	DPanel:SetPos(CreationMenu:GetWide() * .5 - DPanel:GetWide() * .5 + MenuListButton:GetWide() * .5, CreationMenu:GetTall() - DPanel:GetTall())
	DPanel.Paint = function(s, w, h) end
	local ChoosePanel = vgui.Create("DPanel", DPanel)
	ChoosePanel:SetSize(CreationMenu:GetWide() - MenuListButton:GetWide(), math.Round(800 * math.min(ScrW(), ScrH()) / 1080))
	ChoosePanel:SetPos(DPanel:GetWide() * .5 - ChoosePanel:GetWide() * .5, DPanel:GetTall() * .5 - ChoosePanel:GetTall() * .5)
	ChoosePanel:SetAlpha(0)
	ChoosePanel:AlphaTo(255, .3)
	ChoosePanel.Paint = function(s, w, h) end
	local HeaderChoose = ChoosePanel:Add("DLabel")
	HeaderChoose:SetSize(ChoosePanel:GetWide(), 150)
	HeaderChoose:SetPos(0, 0)
	HeaderChoose:SetText('')
	HeaderChoose.Paint = function(s, w, h) draw.DrawText("WYBIERZ POSTAĆ:", "gm.4", 0, 0, color_white, 0) end
	local Model
	local DScrollChar = vgui.Create("DHorizontalScroller", ChoosePanel)
	DScrollChar:SetSize(ChoosePanel:GetWide(), ChoosePanel:GetTall() - 150)
	DScrollChar:SetPos(0, 150)
	local List = vgui.Create("DIconLayout", DScrollChar)
	List:Dock(FILL)
	List:SetSpaceY(5)
	List:SetSpaceX(5)
	local max_characters = LocalPlayer() and isfunction(LocalPlayer().GetUserGroup) and GROUPS_RELATION[LocalPlayer():GetUserGroup()] or 1
	local horizont = Material("luna_ui_base/luna-ui_gradient-horizont_bigger.png")
	characters = characters or {}
	for k, char in pairs(characters) do
		local CharPanel = vgui.Create("DPanel")
		CharPanel:SetSize(400, ChoosePanel:GetTall())
		CharPanel.Paint = function(self, w, h) end
		List:Add(CharPanel)
		local SelectChar = vgui.Create("DButton", CharPanel)
		SelectChar:SetSize(400, 250)
		SelectChar:SetText("")
		local lerpColor = Color(122, 122, 122)
		SelectChar.Paint = function(self, w, h)
			lerpColor = self:IsHovered() and LerpColor2(lerpColor, Color(53, 53, 241), FrameTime() * 3) or LerpColor2(lerpColor, Color(122, 122, 122), FrameTime() * 3)
			--surface.PlaySound("venty/buttonhover4.mp3")
			surface.SetDrawColor(lerpColor)
			surface.DrawOutlinedRect(0, 0, w, h, ScreenScale(2))
			surface.SetMaterial(horizont)
			surface.DrawTexturedRect(0, 0, w, h)
			if re.jobs[char.team_index].Type == TYPE_JEDI then
				controlData = {
					icon = jedi,
					color = Color(84, 144, 181, 255)
				}
			end
		end

		SelectChar.DoClick = function(self)
			surface.PlaySound("luna_sound_effects/rankup/level_up_01.mp3")
			netstream.Start("SpawnPlayerCharacter", {
				char_id = char.char_id
			})

			CreationMenu.ChatSelected = true
			DPanel:Remove()
			if Model then Model:Remove() end
			CreationMenu:AlphaTo(0, .5, 0, function()
				CreationMenu:Remove()
				drop()
			end)

			RunConsoleCommand("stopsound")
			-- end
		end

		function SelectChar:DoRightClick()
			local menu = DermaMenu()
			menu:AddOption("Usuń postać", function()
				surface.PlaySound("luna_sound_effects/character_menu/launchdeny.mp3")
				netstream.Start("RemovePlayerCharacter", {
					char_id = char.char_id
				})

				CreationMenu:Remove()
			end)

			menu:Open()
		end

		local SelectCharName = CharPanel:Add('DLabel')
		SelectCharName:SetSize(CharPanel:GetWide(), 80)
		SelectCharName:SetPos(0, SelectChar:GetTall())
		SelectCharName:SetFont(luna.MontBase)
		SelectCharName:SetTextColor(color_white)
		SelectCharName:SetText(char.character_name)
		local fovLerp = 40
		local colorModelLerp = Color(53, 53, 241)
		local model = ChoosePanel:Add("DModelPanel")
		model:SetSize(400, 280)
		local k_index = k - 1
		model:SetPos(k == 1 and 0 or 400 * k_index, 120)
		model:SetModel(char.model)
		model:SetMouseInputEnabled(false)
		model:SetFOV(50)
		model:SetCamPos(Vector(25, 35, 64))
		model:SetLookAt(Vector(0, -7, 64))
		model:SetDirectionalLight(4, colorModelLerp)
		model:GetEntity():SetSequence(model:GetEntity():LookupSequence('menu_combine'))
		model.LayoutEntity = function(this, entity)
			this:DrawModel()
			this:RunAnimation()
			entity:SetAngles(Angle(0, 45, 0))
		end

		model.Think = function(s)
			fovLerp = SelectChar:IsHovered() and Lerp(FrameTime() * 2, fovLerp, 35) or Lerp(FrameTime() * 2, fovLerp, 50)
			colorModelLerp = SelectChar:IsHovered() and LerpColor2(colorModelLerp, Color(53, 53, 241), FrameTime() * 2) or LerpColor2(colorModelLerp, color_white, FrameTime() * 2)
			model:SetDirectionalLight(2, colorModelLerp)
			model:SetFOV(fovLerp)
		end
	end

	local function OpenNewCharacterMenu(characters)
		CreatePanel = vgui.Create("DPanel", DPanel)
		CreatePanel:SetSize(CreationMenu:GetWide() - MenuListButton:GetWide(), math.Round(900 * math.min(ScrW(), ScrH()) / 1080))
		CreatePanel:SetPos(DPanel:GetWide() * .5 - CreatePanel:GetWide() * .5, DPanel:GetTall() * .5 - CreatePanel:GetTall() * .5)
		CreatePanel:SetAlpha(0)
		CreatePanel:AlphaTo(255, .3)
		CreatePanel.Paint = function(s, w, h) end
		local BackModel = CreatePanel:Add('DPanel')
		BackModel:SetSize(CreatePanel:GetWide(), CreatePanel:GetTall())
		BackModel:SetPos(CreatePanel:GetWide() - BackModel:GetWide(), 0)
		local circle_size, corner_padding = ScrH(), 250
		BackModel.Paint = function(s, w, h)
			surface.SetMaterial(mat_circle)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRectRotated(w - 250, h - 250, h, h, RealTime() * 5)
		end

		local Model = vgui.Create("DModelPanel", BackModel)
		Model:SetSize(BackModel:GetWide() * .5, CreatePanel:GetTall())
		Model:SetPos(BackModel:GetWide() - Model:GetWide(), 0)
		Model:SetCamPos(Vector(185, 100, 64))
		Model:SetLookAt(Vector(10, 0, 64))
		Model:SetFOV(10)
		Model:SetModel("models/sup/vrpm/trp/trp.mdl")
		function Model:LayoutEntity(Entity)
			self:RunAnimation()
		end

		local LeftPanel = vgui.Create("DPanel", CreatePanel)
		LeftPanel:SetSize(CreatePanel:GetWide() * .6, CreatePanel:GetTall())
		LeftPanel:SetPos(0, 0)
		LeftPanel.Paint = function(self, w, h) end
		
		local HeaderCharCreate = LeftPanel:Add('DPanel')
		HeaderCharCreate:SetSize(LeftPanel:GetWide(), 250)
		HeaderCharCreate:SetPos(0, 0)
		
		local HorizontalChooseProf = HeaderCharCreate:Add('DHorizontalScroller')
		HorizontalChooseProf:SetSize(HeaderCharCreate:GetWide(), 100)
		HorizontalChooseProf:SetPos(0, HeaderCharCreate:GetTall() - HorizontalChooseProf:GetTall())
		HorizontalChooseProf.Paint = function(s, w, h) end
		
		HeaderCharCreate.Paint = function(s, w, h)
			surface.SetFont(luna.MontBase54)
			
			local sizeX, sizeY = 0, 0
			local controlTeamName = ""
			local jobName = ""
			
			if re.jobs and re.jobs[CurProf] then
				local job = re.jobs[CurProf]
				if job.control and CONTROLPOINT_TEAMS and CONTROLPOINT_TEAMS[job.control] then
					controlTeamName = CONTROLPOINT_TEAMS[job.control].name or ""
				end
				jobName = team.GetName(CurProf) or ""
				
				local displayText = controlTeamName .. (controlTeamName ~= "" and jobName ~= "" and " • " or "") .. jobName
				sizeX, sizeY = surface.GetTextSize(displayText)
				
				if job.control and CONTROLPOINT_TEAMS and CONTROLPOINT_TEAMS[job.control] and CONTROLPOINT_TEAMS[job.control].icon then
					surface.SetDrawColor(color_white)
					surface.SetMaterial(CONTROLPOINT_TEAMS[job.control].icon)
					surface.DrawTexturedRect(0, 0, 128, 128)
				end
				
				surface.SetFont(luna.MontBase54)
				surface.SetTextPos(w * .85 - sizeX, h * .4 - HorizontalChooseProf:GetTall() * .4 - sizeY * .5)
				surface.SetTextColor(color_white)
				surface.DrawText(displayText)
			end
		end

		local function CreateStyledProfessionScroller(parent)
			local ScrollerPanel = parent:Add('DPanel')
			ScrollerPanel:SetSize(parent:GetWide(), 100)
			ScrollerPanel:SetPos(0, parent:GetTall() - ScrollerPanel:GetTall())
			ScrollerPanel.Paint = function(s, w, h)
				draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 90))
			end
		
			local HorizontalChooseProf = ScrollerPanel:Add('DPanel')
			HorizontalChooseProf:SetSize(ScrollerPanel:GetWide() - 80, ScrollerPanel:GetTall())
			HorizontalChooseProf:SetPos(40, 0)
			HorizontalChooseProf.Paint = function(s, w, h) end
		
			local buttonWidth = HorizontalChooseProf:GetWide() * 0.3
			local buttonSpacing = 10
			local scrollOffset = 0
			local buttons = {}
		
			local availableProfs = WHITELIST_GROUP_TEAMS[LocalPlayer():GetUserGroup()] or {[TEAM_CADET] = true}
			
			if table.IsEmpty(availableProfs) then
				availableProfs = {[TEAM_CADET] = true}
			end
		
			for prof, _ in pairs(availableProfs) do
				local profButton = vgui.Create('DButton')
				profButton:SetSize(buttonWidth, HorizontalChooseProf:GetTall() - 20)
				profButton:SetText('')
				table.insert(buttons, profButton)
		
				surface.SetFont(luna.MontBase30)
				local sizeX, sizeY = surface.GetTextSize(team.GetName(prof))
		
				profButton.Paint = function(s, w, h)
					local bgColor = s:IsHovered() and Color(53, 53, 241, 200) or Color(0, 0, 0, 150)
					local textColor = s:IsHovered() and Color(255, 255, 255) or Color(200, 200, 200)
					
					draw.RoundedBox(8, 0, 0, w, h, bgColor)
					draw.SimpleText(team.GetName(prof), luna.MontBase30, w * 0.5, h * 0.5, textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
		
				profButton.DoClick = function(s) CurProf = prof end
			end
		
			local function UpdateButtonPositions()
				local x = -scrollOffset
				for _, btn in ipairs(buttons) do
					btn:SetParent(HorizontalChooseProf)
					btn:SetPos(x, 10)
					x = x + buttonWidth + buttonSpacing
				end
			end
		
			UpdateButtonPositions()
		
			local function CreateScrollButton(parent, x, y, dir)
				local btn = parent:Add("DButton")
				btn:SetSize(30, 100)
				btn:SetPos(x, y)
				btn:SetText("")
				
				btn.Paint = function(s, w, h)
					local bgColor = s:IsHovered() and Color(53, 53, 241, 200) or Color(0, 0, 0, 150)
					draw.RoundedBox(8, 0, 0, w, h, bgColor)
					
					surface.SetDrawColor(255, 255, 255)
					draw.NoTexture()
					local symbolSize = 20
					local symbolX, symbolY = w/2, h/2
					if dir == "left" then
						draw.SimpleText("◀", "DermaLarge", symbolX, symbolY, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					else
						draw.SimpleText("▶", "DermaLarge", symbolX, symbolY, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
				end
				
				btn.DoClick = function()
					local scrollAmount = dir == "left" and -buttonWidth or buttonWidth
					scrollOffset = math.Clamp(scrollOffset + scrollAmount, 0, math.max(0, #buttons * (buttonWidth + buttonSpacing) - HorizontalChooseProf:GetWide()))
					UpdateButtonPositions()
				end
			end
		
			CreateScrollButton(ScrollerPanel, 0, 0, "left")
			CreateScrollButton(ScrollerPanel, ScrollerPanel:GetWide() - 30, 0, "right")
			
			return ScrollerPanel
		end
		
		local ProfessionScroller = CreateStyledProfessionScroller(HeaderCharCreate)

		local MainCharCreate = LeftPanel:Add('DPanel')
		MainCharCreate:SetSize(LeftPanel:GetWide(), LeftPanel:GetTall() - HeaderCharCreate:GetTall())
		MainCharCreate:SetPos(0, LeftPanel:GetTall() - MainCharCreate:GetTall())
		MainCharCreate.Paint = function(s, w, h) end
		local WeaponLabel = MainCharCreate:Add('DPanel')
		WeaponLabel:Dock(FILL)
		WeaponLabel:DockMargin(0, 20, 0, 300)
		WeaponLabel.Paint = function(s, w, h) end
		local PrimarySecondaryLabel = WeaponLabel:Add('DPanel')
		PrimarySecondaryLabel:Dock(TOP)
		PrimarySecondaryLabel:SetTall(330 * .5)
		PrimarySecondaryLabel.Paint = function(s, w, h) end
		local colorGray = Color(200, 200, 200)
		local function paintWeaponLabel(s, w, h, weapon_cat, tableWpn)
			surface.SetDrawColor(0, 0, 0, 90)
			surface.DrawRect(0, 0, w, h)
			local weaponName
			local weaponDmg
			local weaponRecoil
			local weaponDelay
			local weaponMat
			local class
		
			if tableWpn then
				for _, weapon in pairs(tableWpn) do
					if F4_CREATECHAR[weapon_cat].weapons[weapon] then
						class = weapons.Get(weapon)
						weaponName = class.PrintName
						weaponMat = F4_CREATECHAR[weapon_cat].weapons[weapon]
						weaponDmg = class.Damage or 1
						weaponRecoil = class.Recoil
						weaponDelay = class.Delay
						break
					end
				end
			end
		
			if weaponDmg then 
				F4_CREATECHAR[weapon_cat].lerps.dmg = Lerp(FrameTime() * 3, F4_CREATECHAR[weapon_cat].lerps.dmg, weaponDmg and (weaponDmg + 20) / 200 or 0) 
			end
			F4_CREATECHAR[weapon_cat].lerps.recoil = Lerp(FrameTime() * 3, F4_CREATECHAR[weapon_cat].lerps.recoil, weaponRecoil and (weaponRecoil * 300) / 200 or 0)
			F4_CREATECHAR[weapon_cat].lerps.rpm = Lerp(FrameTime() * 3, F4_CREATECHAR[weapon_cat].lerps.rpm, weaponDelay and (weaponDelay * 800) / 200 or 0)
			draw.DrawText(F4_CREATECHAR[weapon_cat].name, luna.MontBase30, 10, 10, color_white, TEXT_ALIGN_LEFT)
			draw.DrawText(weaponName or '', luna.MontBase24, 10, 40, color_white, TEXT_ALIGN_LEFT)
			if weaponMat then
				surface.SetDrawColor(color_white)
				surface.SetMaterial(weaponMat)
				surface.DrawTexturedRect(10, 50, 128, 128)
			end
		
			surface.SetDrawColor(0, 0, 0, 90)
			surface.DrawRect(w - 210, h * .5 - 100 * .5, 200, 100)
			surface.SetDrawColor(100, 100, 100)
			surface.DrawRect(w - 210, h / 4 - 100 / 4 + 20, 200 * F4_CREATECHAR[weapon_cat].lerps.dmg, 20)
			draw.DrawText('Obrażenia', luna.MontBase18, w - 210, h / 4 - 100 / 4 + 20, colorGray, TEXT_ALIGN_LEFT)
			surface.SetDrawColor(100, 100, 100)
			surface.DrawRect(w - 210, h / 4 - 100 / 4 + 50, 200 * F4_CREATECHAR[weapon_cat].lerps.recoil, 20)
			draw.DrawText('Powrót', luna.MontBase18, w - 210, h / 4 - 100 / 4 + 50, colorGray, TEXT_ALIGN_LEFT)
			surface.SetDrawColor(100, 100, 100)
			surface.DrawRect(w - 210, h / 4 - 100 / 4 + 80, 200 * F4_CREATECHAR[weapon_cat].lerps.rpm, 20)
			draw.DrawText('Szybkostrzelność', luna.MontBase18, w - 210, h / 4 - 100 / 4 + 80, colorGray, TEXT_ALIGN_LEFT)
		end

		local primaryLabel = PrimarySecondaryLabel:Add('DPanel')
		primaryLabel:Dock(LEFT)
		primaryLabel:SetWide(LeftPanel:GetWide() * .49)
		primaryLabel.Paint = function(s, w, h) if CurProf then paintWeaponLabel(s, w, h, 'primary', re.jobs[CurProf].weaponcrate) end end
		local secondaryLabel = PrimarySecondaryLabel:Add('DPanel')
		secondaryLabel:Dock(RIGHT)
		secondaryLabel:SetWide(LeftPanel:GetWide() * .5)
		secondaryLabel.Paint = function(s, w, h) if CurProf then paintWeaponLabel(s, w, h, 'secondary', re.jobs[CurProf].weaponcrate) end end
		local BottomWeaponLabel = WeaponLabel:Add('DPanel')
		BottomWeaponLabel:Dock(BOTTOM)
		BottomWeaponLabel:SetTall(320 * .5)
		BottomWeaponLabel:DockMargin(0, 10, 0, 0)
		BottomWeaponLabel.Paint = function(s, w, h) end
		local ExclusiveLabel = BottomWeaponLabel:Add('DPanel')
		ExclusiveLabel:Dock(LEFT)
		ExclusiveLabel:SetWide(LeftPanel:GetWide() * .49)
		ExclusiveLabel.Paint = function(s, w, h) if CurProf then paintWeaponLabel(s, w, h, 'exclusive', re.jobs[CurProf].weaponcrate) end end
		local veryExclusiveLabel = BottomWeaponLabel:Add('DPanel')
		veryExclusiveLabel:Dock(RIGHT)
		veryExclusiveLabel:SetWide(LeftPanel:GetWide() * .5)
		veryExclusiveLabel.Paint = function(s, w, h) if CurProf then paintWeaponLabel(s, w, h, 'veryexclusive', re.jobs[CurProf].weaponcrate) end end
		local FooterCharCreate = LeftPanel:Add('DPanel')
		FooterCharCreate:Dock(BOTTOM)
		FooterCharCreate:SetTall(200)
		FooterCharCreate:DockMargin(0, 0, 0, 100)
		FooterCharCreate.Paint = function(s, w, h) end
		local footerCharHealth = FooterCharCreate:Add('DPanel')
		footerCharHealth:SetSize(LeftPanel:GetWide() * .50, 70)
		footerCharHealth:SetPos(LeftPanel:GetWide() - footerCharHealth:GetWide(), 20)
		footerCharHealth.Paint = function(s, w, h)
			local health = CurProf and markup.Parse('<font=' .. luna.MontBase30 .. '><colour = 200, 200, 200>Zdrowie: </colour><colour = 53, 53, 241>' .. re.jobs[CurProf].maxHealth .. '</colour></font>')
			health:Draw(0, h * .5, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end

		local footerCharArmor = FooterCharCreate:Add('DPanel')
		footerCharArmor:SetSize(LeftPanel:GetWide() * .50, 70)
		footerCharArmor:SetPos(LeftPanel:GetWide() - footerCharArmor:GetWide(), 110)
		footerCharArmor.Paint = function(s, w, h)
			local armor = CurProf and markup.Parse('<font=' .. luna.MontBase30 .. '><colour = 200, 200, 200>Pancerz: </colour><colour = 53, 53, 241>' .. re.jobs[CurProf].maxArmor .. '</colour></font>')
			armor:Draw(0, h * .5, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end

		local nameCharCreate = FooterCharCreate:Add('DTextEntry')
		nameCharCreate:Dock(TOP)
		nameCharCreate:SetTall(70)
		nameCharCreate:DockMargin(0, 20, LeftPanel:GetWide() * .51, 0)
		nameCharCreate:SetFont(luna.MontBase24)
		nameCharCreate:SetAllowNonAsciiCharacters(false)
		surface.SetFont(luna.MontBase24)
		local sizeX, sizeY = surface.GetTextSize('Nazwa Postaci')
		function nameCharCreate:OnChange()
			local text = self:GetValue()
			local newText = string.gsub(text, "%d", "")
			if newText ~= text then
				self:SetText(newText)
				self:SetCaretPos(#newText)
			end
		end

		nameCharCreate.Paint = function(s, w, h)
			surface.SetDrawColor(0, 0, 0, 90)
			surface.DrawRect(0, 0, w, h)
			if s:GetText() == '' then draw.DrawText('Nazwa Postaci...', luna.MontBase24, w * .5 - sizeX * .5, h * .5 - sizeY * .5, Color(150, 150, 150, 150), 0) end
			s:DrawTextEntryText(Color(255, 255, 255, 240), Color(0, 165, 255, 255), Color(255, 255, 255, 240))
		end

		local buttonCreateChar = FooterCharCreate:Add('DButton')
		buttonCreateChar:Dock(TOP)
		buttonCreateChar:SetTall(70)
		buttonCreateChar:DockMargin(0, 20, LeftPanel:GetWide() * .51, 0)
		buttonCreateChar:SetText('')
		surface.SetFont(luna.MontBase30)
		local sizeX, sizeY = surface.GetTextSize('Stwórz Postać')
		local lerpColorOut = Color(0, 0, 0, 90)
		local lerpColorText = color_white
		buttonCreateChar.Paint = function(s, w, h)
			lerpColorOut = s:IsHovered() and LerpColor2(lerpColorOut, Color(53, 53, 241), FrameTime() * 3) or LerpColor2(lerpColorOut, Color(0, 0, 0, 0), FrameTime() * 3)
			lerpColorText = s:IsHovered() and LerpColor2(lerpColorText, Color(53, 53, 241), FrameTime() * 3) or LerpColor2(lerpColorText, color_white, FrameTime() * 3)
			surface.SetDrawColor(0, 0, 0, 90)
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(lerpColorOut)
			surface.DrawOutlinedRect(0, 0, w, h, ScreenScale(1))
			surface.SetFont(luna.MontBase30)
			surface.SetTextPos(w * .5 - sizeX * .5, h * .5 - sizeY * .5)
			surface.SetTextColor(lerpColorText)
			surface.DrawText('Stwórz Postać')
		end

		buttonCreateChar.DoClick = function(self)
			netstream.Start("NewPlayerCharacter", {
				name = nameCharCreate:GetText(),
				start_team = CurProf
			})

			surface.PlaySound("luna_sound_effects/rankup/level_up_02.mp3")
			CreatePanel:Remove()
			if bgsound then bgsound:Stop() end
			drop()
		end
	end

	local MenuListButtons = {
		{
			name = "Główne Menu",
			callback = function(chars)
				initcharMenu({
					characters = chars
				})
			end,
		},
		{
			name = "Wybór postaci",
			callback = function(chars)
				if IsValid(ChoosePanel) then return end
				if IsValid(CreatePanel) then
					CreatePanel:AlphaTo(0, .5, 0, function()
						OpenCharacterMenu({
							characters = chars
						})

						CreatePanel:Remove()
						drop()
					end)
				end
			end,
		},
		{
			name = "Tworzenie postaci",
			callback = function(chars)
				if IsValid(CreatePanel) then return end
				if IsValid(ChoosePanel) then
					ChoosePanel:AlphaTo(0, .5, 0, function()
						ChoosePanel:Remove()
						OpenNewCharacterMenu(chars)
						drop()
					end)
				end
			end,
		}
	}

	for k, button in ipairs(MenuListButtons) do
		local textLerpButton = color_white
		local circleLerpButton = color_white
		local posLerpButton = 0
		MenuListButtons[k] = MenuListButton:Add('DButton')
		MenuListButtons[k]:Dock(TOP)
		MenuListButtons[k]:DockMargin(0, 20, 0, 0)
		MenuListButtons[k]:SetText('')
		MenuListButtons[k]:SetContentAlignment(5)
		MenuListButtons[k].DoClick = function(s) button.callback(characters) end
		MenuListButtons[k].Paint = function(s, w, h)
			textLerpButton = s:IsHovered() and LerpColor2(textLerpButton, Color(115, 115, 218), FrameTime() * 4) or LerpColor2(textLerpButton, color_white, FrameTime() * 4)
			circleLerpButton = s:IsHovered() and LerpColor2(circleLerpButton, Color(115, 115, 218), FrameTime() * 10) or LerpColor2(circleLerpButton, Color(255, 255, 255, 0), FrameTime() * 10)
			posLerpButton = s:IsHovered() and Lerp(FrameTime() * 10, posLerpButton, 5) or Lerp(FrameTime() * 10, posLerpButton, 0)
			surface.SetTextColor(textLerpButton)
			surface.SetTextPos(posLerpButton, -3)
			surface.SetFont(luna.MontBase24)
			surface.DrawText(s:IsHovered() and '  ' .. button.name or button.name)
			surface.SetTextColor(circleLerpButton)
			surface.SetTextPos(0, -3)
			surface.SetFont(luna.MontBase24)
			surface.DrawText'•  '
			return true
		end
	end

	local bottomLabel = CreationMenu:Add("DLabel")
	surface.SetFont(luna.LunaMontNoticeFont)
	local xSize, ySize = surface.GetTextSize('Serwer gry od SUP • zespół programistów. STAR WARS™ jest własnością firmy LucasFilm Ltd.')
	bottomLabel:SetSize(xSize, ySize)
	bottomLabel:SetPos(CreationMenu:GetWide() * 0.5 - bottomLabel:GetWide() * 0.5, CreationMenu:GetTall() - ScreenScale(30))
	bottomLabel:SetText('')
	bottomLabel.Paint = function(s, w, h)
		draw.Text({
			text = "Serwer gry od SUP • zespół programistów. STAR WARS™ jest własnością firmy LucasFilm Ltd.",
			font = luna.LunaMontNoticeFont,
			pos = {0, 0}
		})
	end

	CreationMenu.logo = CreationMenu:Add('gm.logo')
	CreationMenu.logo2 = CreationMenu:Add('gm.logo2')
	if LocalPlayer():GetNetVar("character") then CreationMenu.close = CreationMenu:Add('gm.close') end
	CreationMenu.links = CreationMenu:Add('gm.links')
end

local background = Material("luna_ui_base/start-menu_bg_v2.png")
local first_venator = Material("luna_ui_base/2.png")
local second_venator = Material("luna_ui_base/3.png")
local vignette = Material("luna_ui_base/luna-ui_vignette.png")
local sup_logo = Material("luna_sup_brand/sup_logo_var4.png")
local luna_logo = Material("luna_sup_brand/luna-core.png")
initcharMenu = function(characters)
	local halfWidth = 42
	local Menu = vgui.Create("DFrame")
	Menu:SetPos(0, 0)
	Menu:SetSize(ScrW(), ScrH())
	Menu:SetDraggable(false)
	Menu:SetTitle("")
	Menu:ShowCloseButton(false)
	Menu.Paint = function(self, w, h)
		local x, y = self:GetPos()
		draw.DrawBlur(x, y, self:GetWide(), self:GetTall(), 2)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(background)
		surface.DrawTexturedRect(0, 0, w, h)
		render.PushFilterMag(TEXFILTER.ANISOTROPIC)
		render.PushFilterMin(TEXFILTER.ANISOTROPIC)
		local mx, my = gui.MousePos()
		lerp_1mx = Lerp(FrameTime() * 1.6, lerp_1mx or 0, mx / 15)
		lerp_1my = Lerp(FrameTime() * 1.6, lerp_1my or 0, my / 15)
		lerp_2mx = Lerp(FrameTime() * 2, lerp_2mx or 0, mx / 50)
		lerp_2my = Lerp(FrameTime() * 2, lerp_2my or 0, my / 50)
		local m1, m2 = Matrix(), Matrix()
		m1:Translate(Vector(lerp_1mx, lerp_1my, 0))
		m2:Translate(Vector(lerp_2mx, lerp_2my, 0))
		cam.PushModelMatrix(m1, true)
		surface.SetMaterial(first_venator)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
		cam.PopModelMatrix()
		cam.PushModelMatrix(m2, true)
		surface.SetMaterial(second_venator)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
		cam.PopModelMatrix()
		render.PopFilterMag()
		render.PopFilterMin()
		surface.SetMaterial(vignette)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	Menu:MakePopup()
	local halfPadding = 20
	-- draw schema logo material instead of text if available
	local logoImage = Menu:Add("DImage")
	logoImage:SetMaterial(sup_logo)
	logoImage:SetSize(halfWidth, halfWidth * sup_logo:Height() / sup_logo:Width())
	logoImage:SetPos(halfWidth - logoImage:GetWide() * 0.5, halfPadding)
	local titleLabel = Menu:Add("DLabel")
	surface.SetFont(luna.LunaMontMenuMiniFont)
	local xSize, _ = surface.GetTextSize('SUP • Community')
	titleLabel:SetWide(xSize)
	titleLabel:SetText('')
	titleLabel:SetPos(halfWidth + logoImage:GetWide() * 0.5 + 10, halfPadding + logoImage:GetWide() * 0.5 - math.max(ScreenScale(4), 18) / 2)
	titleLabel.Paint = function(s, w, h)
		draw.Text({
			text = 'SUP • Community',
			font = luna.LunaMontMenuMiniFont,
			pos = {0, 0}
		})
	end

	-- newHeight = newHeight + titleLabel:GetTall()
	local logoImage_Luna = Menu:Add("DImage")
	logoImage_Luna:SetMaterial(luna_logo)
	logoImage_Luna:SetSize(halfWidth, halfWidth * luna_logo:Height() / luna_logo:Width())
	logoImage_Luna:SetPos(halfWidth + logoImage:GetWide() + titleLabel:GetWide(), halfPadding)
	local subtitleLabel = Menu:Add("DLabel")
	surface.SetFont(luna.LunaMontMenuMiniFont)
	local xSize, _ = surface.GetTextSize('Luna-core • ' .. GAMEMODE.Version)
	subtitleLabel:SetWide(xSize)
	subtitleLabel:SetText('')
	subtitleLabel:SetPos(halfWidth + logoImage:GetWide() + logoImage_Luna:GetWide() + titleLabel:GetWide() + 10, halfPadding + logoImage:GetWide() * 0.5 - math.max(ScreenScale(4), 18) / 2)
	subtitleLabel.Paint = function(s, w, h)
		draw.Text({
			text = 'Luna-core • ' .. GAMEMODE.Version,
			font = luna.LunaMontMenuMiniFont,
			pos = {0, 0}
		})
	end

	local loadButton = Menu:Add("DButton")
	surface.SetFont(luna.LunaMontNoticeFont)
	local xSize, ySize = surface.GetTextSize('Aby wejść do gry, naciśnij klawisz SPACE.')
	loadButton:SetSize(xSize + 100, ySize + 10)
	loadButton:SetPos(Menu:GetWide() * .5 - loadButton:GetWide() * .5, Menu:GetTall() - ScreenScale(60) - loadButton:GetTall())
	loadButton:SetText('')
	local lerpBox = Color(0, 0, 0, 0)
	loadButton.Paint = function(s, w, h)
		--lerpBox = s:IsHovered() and LerpColor2(lerpBox, Color(0, 0, 0, 150), FrameTime() * 4) or LerpColor2(lerpBox, Color(0, 0, 0, 0), FrameTime() * 4)
		surface.SetDrawColor(lerpBox)
		surface.DrawRect(0, 0, w, h)
		draw.Text({
			text = 'Aby wejść do gry, naciśnij klawisz SPACE.',
			font = luna.LunaMontNoticeFont,
			pos = {w * .5 - xSize * .5, 0}
		})
	end

	local bottomLabel = Menu:Add("DLabel")
	surface.SetFont(luna.LunaMontNoticeFont)
	local xSize, ySize = surface.GetTextSize('Serwer gry od SUP • zespół programistów. STAR WARS™ jest własnością firmy LucasFilm Ltd.')
	bottomLabel:SetSize(xSize, ySize + 3)
	bottomLabel:SetPos(Menu:GetWide() * 0.5 - bottomLabel:GetWide() * 0.5, Menu:GetTall() - ScreenScale(30))
	bottomLabel:SetText('')
	bottomLabel.Paint = function(s, w, h)
		draw.Text({
			text = "Serwer gry od SUP • zespół programistów. STAR WARS™ jest własnością firmy LucasFilm Ltd.",
			font = luna.LunaMontNoticeFont,
			pos = {0, 0}
		})
	end

	loadButton.DoClick = function(self)
		if IsValid(Menu) then
			OpenCharacterMenu(characters)
			surface.PlaySound("luna_ui/click1.wav")
			Menu:Remove()
		end
	end

	loadButton.Think = function(self)
		if IsValid(Menu) and input.IsKeyDown(KEY_SPACE) then
			OpenCharacterMenu(characters)
			surface.PlaySound("luna_ui/click1.wav")
			Menu:Remove()
		end
	end

	surface.PlaySound("luna_ui/music/ambient.mp3")
end

netstream.Hook("OpenInitCharacterMenu", function(characters) initcharMenu(characters) end)
netstream.Hook("OpenCharacterMenu", function(characters)
	surface.PlaySound("luna_ui/music/ambient.mp3")
	OpenCharacterMenu(characters)
end)