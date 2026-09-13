--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local luna_core = getMaterial("luna_sup_brand/luna-core")
local sup_logo_var1 = getMaterial("luna_sup_brand/sup_logo_var1")
local ping_xorosho = getMaterial("icon16/flag_green")
local ping_norm = getMaterial("icon16/flag_orange")
local ping_ploho = getMaterial("icon16/flag_red")
local discord_icon = getMaterial("luna_menus/esc/discord")
local steam_icon = getMaterial("luna_menus/esc/steam")
local tg_icon = getMaterial("luna_menus/esc/tg")
local vk_icon = getMaterial("luna_menus/esc/vk")
local settings_icon = getMaterial("luna_menus/esc/settings")
local play_icon = getMaterial("luna_menus/esc/play")
local republic_icon = getMaterial("luna_ui_base/elements/republic")
local micoff = getMaterial("luna_menus/scoreboard/util/micoff")
local micon = getMaterial("luna_menus/scoreboard/util/micon")
local pin = getMaterial("luna_menus/scoreboard/util/pin")
local ping3 = getMaterial("luna_menus/scoreboard/util/ping_1")
local ping2 = getMaterial("luna_menus/scoreboard/util/ping_2")
local ping1 = getMaterial("luna_menus/scoreboard/util/ping_3")
local voice_off = getMaterial("luna_menus/scoreboard/util/voice_off")
local voice_on = getMaterial("luna_menus/scoreboard/util/voice_on")
local newlogosup1 = getMaterial("luna_sup_brand/main_logo_swrp")
local newlogosup2 = getMaterial("luna_sup_brand/logoryloth2")

AdminIcons = {}
AdminIcons["founder"] = "groups/group_ceo"
AdminIcons["developer"] = "groups/group_developer"
AdminIcons["admin"] = "groups/group_admin"
AdminIcons["manager"] = "groups/group_manager"
AdminIcons["vip"] = "groups/group_vip"
AdminIcons["user"] = "groups/group_user"

local function convert_rank_to_img(ply)
    if AdminIcons[ply:GetUserGroup()] then
		return getMaterial("luna_menus/scoreboard/" .. AdminIcons[ply:GetUserGroup()])
	end
    return getMaterial("luna_menus/scoreboard/" .. AdminIcons["user"])
end

local function ClassGetIcon(ply)
    local icon = class_icon
    local logic = ply:GetNetVar('features') or {}
    for feature, status in pairs(logic) do
        if status and FEATURES_TO_NORMAL[feature] and FEATURES_TO_NORMAL[feature].icon then
            icon = Material(FEATURES_TO_NORMAL[feature].icon, "smooth noclamp")
            break
        end
    end
    return icon
end


ConfigurationTranslation = {
	cancel = "Anuluj",
	copy_nick = "Skopiuj nick",
	copy_steamid = "Skopiuj SteamID",
	open_steam_profile = "Otwórz profil",
	goto = "Teleportuj się",
	returne = "Return",
	spectate = "Obserwuj",
	bring = "Teleportuj",
}

local Scoreboard
local adminmenu

local function closeSB()
	if not IsValid(Scoreboard) then return end
	gui.EnableScreenClicker(false)
	Scoreboard:Stop()
	Scoreboard:AlphaTo(0, .1, 0, function() Scoreboard:Hide() end)
	if IsValid(adminmenu) then adminmenu:Remove() end
end

local function createOptions(panel, text, func)
	local option = panel:AddOption(text, func)
	option:SetFont(luna.MontBase18)
	option:SetTextColor(color_white)
	option.Paint = function(self, w, h)
		if text == "Skopiuj nick" then
            draw.RoundedBoxEx(15, 0, 0, w, h, self:IsHovered() and Color(64, 64, 64, 200) or Color(86, 86, 86, 200), true, true, false, false)
		elseif text == "Anuluj" then
            draw.RoundedBoxEx(15, 0, 0, w, h, self:IsHovered() and Color(64, 64, 64, 200) or Color(86, 86, 86, 200), false, false, true, true)
		else
            draw.RoundedBoxEx(0, 0, 0, w, h, self:IsHovered() and Color(64, 64, 64, 200) or Color(86, 86, 86, 200), false, false, false, false)
		end
	end
	return option
end

local color_banner = Color( 255, 255, 255, 100 )

local cachedMaterials = {}
local function getCachedMaterial(path, smooth)
    if not cachedMaterials[path] then
        cachedMaterials[path] = Material(path, not smooth and 'smooth mips' or '' )
    end
    return cachedMaterials[path]
end

local function ToggleScoreboard()
	surface.PlaySound('luna_ui/blip1.wav')
	if Scoreboard and IsValid(Scoreboard) then
		gui.EnableScreenClicker(false)
		Scoreboard:AlphaTo(0, .1, 0, function()
			Scoreboard:Remove()
		end)
	end
	Scoreboard = vgui.Create("DPanel")
	Scoreboard:SetSize(ResponsiveX(1920), ResponsiveY(1080))
	Scoreboard:Center()
	Scoreboard:MakePopup()
	Scoreboard:SetAlpha(0)
	Scoreboard:AlphaTo(255, .1, 0)

    function Scoreboard:OnKeyCodePressed(key)
		surface.PlaySound('luna_ui/blip1.wav')
        if key == KEY_TAB then
            closeSB()
        end
    end

	local allPlayers = player.GetAll()
	local currentMap = game.GetMap()
	local parsed = markup.Parse("<font=luna.MontBase24Markup><colour=145, 145, 145,255>Gracze online: <colour=19, 116, 227,255>" .. #allPlayers .. "</colour> • Mapa: <colour=19, 116, 227,255>" .. currentMap .. "</colour></colour></font>")

	Scoreboard.Paint = function(self, w, h)
		surface.SetDrawColor(Color(16, 16, 16, 230))
		surface.DrawRect(0, 0, w, h)
		
		--[[surface.SetDrawColor(color_white)
		surface.SetMaterial(sup_logo_var1)
		surface.DrawTexturedRect(ResponsiveX(100 - (80 / 2)), ResponsiveY(65 - (80 / 2)), ResponsiveX(80), ResponsiveY(80))
		
		surface.SetDrawColor(color_white)
		surface.SetMaterial(luna_core)
		surface.DrawTexturedRect(ResponsiveX(405 - (80 / 2)), ResponsiveY(65 - (80 / 2)), ResponsiveX(80), ResponsiveY(80))
		
		draw.SimpleText("SUP • Community", "SUP.Mont.Light.24", ResponsiveX(160), ResponsiveY(65), Color(202, 202, 202), 0, 1)
		draw.SimpleText("Luna-core • рге-alpha 0.0.2", "SUP.Mont.Light.24", ResponsiveX(460), ResponsiveY(65), Color(202, 202, 202), 0, 1)]]

		surface.SetDrawColor(color_white)
		surface.SetMaterial(newlogosup1)
		surface.DrawTexturedRect(ResponsiveX(1920 * .5 - (533 / 2)), ResponsiveY(65 - (359 / 2)), ResponsiveX(533), ResponsiveY(359))

		-- local allPlayers = player.GetAll()
		-- local currentMap = game.GetMap()
		-- draw.SimpleText("Онлайн сервера: ", luna.MontBase24, ResponsiveX(1440), ResponsiveY(1030), Color(145, 145, 145), 0, 1)
		-- draw.SimpleText(#allPlayers, luna.MontBase24, ResponsiveX(1603), ResponsiveY(1030), Color(19, 116, 227), 0, 1)
		-- draw.SimpleText("• Карта: ", luna.MontBase24, ResponsiveX(1620), ResponsiveY(1030), Color(145, 145, 145), 0, 1)
		-- draw.SimpleText(currentMap, luna.MontBase24, ResponsiveX(1695), ResponsiveY(1030), Color(19, 116, 227), 0, 1)

		parsed:Draw(ResponsiveX(1863), ResponsiveY(1030), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
	end

	local steambtn = vgui.Create("DButton", Scoreboard)
	steambtn:SetSize(ResponsiveX(50), ResponsiveY(50))
	steambtn:SetPos(ResponsiveX(70), ResponsiveY(1080 - 30 - (50)))
	steambtn:SetText("")

	steambtn.Paint = function(self, w, h)
		draw.RoundedBox(25, 0, 0, w, h, self:IsHovered() and Color(75, 75, 75) or Color(46, 46, 46))
		
		surface.SetDrawColor(Color(186, 186, 186))
		surface.SetMaterial(steam_icon)
		surface.DrawTexturedRect(ResponsiveX(50 * .5 - (30 / 2)), ResponsiveY(50 * .5 - (30 / 2)), ResponsiveX(30), ResponsiveY(30))
	end

	steambtn.DoClick = function()
		surface.PlaySound('luna_ui/click2.wav')
		gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=3604236668")
	end

	local discordbtn = vgui.Create("DButton", Scoreboard)
	discordbtn:SetSize(ResponsiveX(50), ResponsiveY(50))
	discordbtn:SetPos(ResponsiveX(70 + 70), ResponsiveY(1080 - 30 - (50)))
	discordbtn:SetText("")

	discordbtn.Paint = function(self, w, h)
		draw.RoundedBox(25, 0, 0, w, h, self:IsHovered() and Color(75, 75, 75) or Color(46, 46, 46))
		
		surface.SetDrawColor(Color(186, 186, 186))
		surface.SetMaterial(discord_icon)
		surface.DrawTexturedRect(ResponsiveX(50 * .5 - (30 / 2)), ResponsiveY(50 * .5 - (30 / 2)), ResponsiveX(30), ResponsiveY(30))
	end

	discordbtn.DoClick = function()
		surface.PlaySound('luna_ui/click2.wav')
		gui.OpenURL("https://discord.gg/NavP36Sxcm")
	end

	local settingsbtn = vgui.Create("DButton", Scoreboard)
	settingsbtn:SetSize(ResponsiveX(50), ResponsiveY(50))
	settingsbtn:SetPos(ResponsiveX(1920 - 100 - (50)), ResponsiveY(30))
	settingsbtn:SetText("")

	settingsbtn.Paint = function(self, w, h)
		surface.SetDrawColor(self:IsHovered() and Color(100, 100, 100) or Color(186, 186, 186))
		surface.SetMaterial(settings_icon)
		surface.DrawTexturedRect(ResponsiveX(50 * .5 - (30 / 2)), ResponsiveY(50 * .5 - (30 / 2)), ResponsiveX(30), ResponsiveY(30))
	end

	settingsbtn.DoClick = function()
		closeSB()
		RunConsoleCommand("showconsole")
		RunConsoleCommand("gamemenucommand", "openoptionsdialog")
	end

	local closebtn = vgui.Create("DButton", Scoreboard)
	closebtn:SetSize(ResponsiveX(50), ResponsiveY(50))
	closebtn:SetPos(ResponsiveX(1920 - 50 - (50)), ResponsiveY(30))
	closebtn:SetText("")

	closebtn.Paint = function(self, w, h)
		surface.SetDrawColor(self:IsHovered() and Color(100, 100, 100) or Color(186, 186, 186))
		surface.SetMaterial(play_icon)
		surface.DrawTexturedRect(ResponsiveX(50 * .5 - (30 / 2)), ResponsiveY(50 * .5 - (30 / 2)), ResponsiveX(30), ResponsiveY(30))
	end

	closebtn.DoClick = function()
		closeSB()
	end
	
	local ScrollMain = vgui.Create("DScrollPanel", Scoreboard)
	ScrollMain:SetSize(ResponsiveX(1820), ResponsiveY(830))
	ScrollMain:SetPos(ResponsiveX(55), ResponsiveY(140))

	ScrollMain.Paint = function(_, w, h)
		draw.RoundedBox(0, 5, 0, w, h, Color(255, 255, 255, 0))
	end

	local vbar = ScrollMain:GetVBar()
	vbar:SetWide(3)
	vbar:SetHideButtons(true)
	vbar.Paint = function(self, w, h)
		surface.SetDrawColor(Color(22, 23, 28, 150))
	end

	vbar.btnGrip.Paint = function(self, w, h)
		surface.SetDrawColor(Color(87, 87, 87, 225))
	end

	local players = player.GetAll()
	local categories = {}
	local openedInfoPanel = nil
	local playerPanels = {}
	local categoryLabels = {}

	for _, v in pairs(players) do
        if not IsValid(v) then continue end
		local category = team.GetName(v:Team()) or "Ładowane na serwer"
		categories[category] = categories[category] or {}
		table.insert(categories[category], v)
	end

	local ypos = ResponsiveY(2)

	local function createPlayerPanel(v, ypos)
		if not IsValid(v) then return end
		local playerPanel = vgui.Create("DButton", ScrollMain)
		local name = v:Name() or "Nieznany"
		local ping = tostring(v:Ping()) or "Nieznany"
		local frData, maskData, bannerData, desc = v:GetAvatarFrame(), v:GetAvatarMask(), v:GetCurrentBanner(), v:GetScoreboardDescription()
		local deaths = IsValid(v) and v:Deaths() or 0
		local frags = IsValid(v) and v:Frags() or 0

		playerPanel:SetSize(ResponsiveX(1800), ResponsiveY(53))
		playerPanel:SetPos(ResponsiveX(10), ypos)
		playerPanel:SetText("")

		local geticon = ClassGetIcon( v )
		local bannerSize = ResponsiveX(560)
		playerPanel.Paint = function(self, w, h)
			surface.SetDrawColor(self:IsHovered() and Color(46, 46, 46, 225) or Color(22, 23, 28, 150))
			surface.DrawRect(0, 0, w, h)
			
			if bannerData and bannerData ~= '' then
				draw.Image( w - bannerSize, 0, bannerSize, h, getCachedMaterial(bannerData, true), color_banner )
			end

			draw.SimpleText( desc, 'banners.desc', w*.5, h*.5, color_white, 1, 1 )

			local rankicon = convert_rank_to_img(v)

			surface.SetDrawColor(color_white)
			surface.SetMaterial(rankicon)
			surface.DrawTexturedRect(ResponsiveX(60), ResponsiveY(53 * .5 - (18 / 2)), ResponsiveX(18), ResponsiveY(18))

			if geticon then
				draw.Image( ResponsiveX(83), ResponsiveY(53 * .5 - (22 / 2)), ResponsiveX(22), ResponsiveY(22), geticon, color_white )
			end

			draw.SimpleTextOutlined(name, luna.MontBase24, geticon and ResponsiveX(110) or ResponsiveX(85), ResponsiveY(27), Color(255, 255, 255, 200), 0, 1, 0, color_black)
			draw.SimpleTextOutlined(ping, luna.MontBase24, ResponsiveX(1788), ResponsiveY(27), Color(255, 255, 255, 200), 2, 1, 0, color_black)

			local pingMaterial = nil
			if tonumber(ping) > 300 then
				pingMaterial = ping1
			elseif tonumber(ping) > 200 then
				pingMaterial = ping2
			else
				pingMaterial = ping3
			end
			
			surface.SetDrawColor(color_white)
			surface.SetMaterial(pingMaterial)
			surface.DrawTexturedRect(ResponsiveX(1800 - 50 - (16 / 2)), ResponsiveY(53 * .5 - (16 / 2)), ResponsiveX(16), ResponsiveY(16))

			draw.SimpleText('D: '.. deaths, 'banners.desc', w - ResponsiveX(80), h*.5, color_white, 2, 1 )
			draw.SimpleText('K: '.. frags, 'banners.desc', w - ResponsiveX(120), h*.5, color_white, 2, 1 )

		end

		local Avatar = vgui.Create("AvatarImage", playerPanel)
		Avatar:SetSize(ResponsiveX(37), ResponsiveY(37))
		Avatar:SetPos(ResponsiveX(17), ResponsiveY(10))
		Avatar:SetPlayer(v, ResponsiveX(37))

		Avatar.PaintOver = function( pnl, w, h )
			if frData and frData ~= '' then
				draw.Image(0, 0, w, h, getCachedMaterial(frData), color_white)
			end
			if maskData and maskData ~= '' then
				draw.Image(0, 0, w, h, getCachedMaterial(maskData), color_white)
			end
		end

		playerPanel.DoRightClick = function(self)
			surface.PlaySound('luna_ui/click1.wav')
			if not IsValid(v) then return end
			adminmenu = vgui.Create("UPMenu", ScrollMain)
			local mouseX, mouseY = gui.MousePos()
			adminmenu:SetPos(mouseX - 40, mouseY - 140)
			createOptions(adminmenu, ConfigurationTranslation.copy_nick, function()
				SetClipboardText(v:Nick())
				LocalPlayer():ChatPrint("Skopiowałeś pseudonim gracza " .. v:Nick())
			end)

			createOptions(adminmenu, ConfigurationTranslation.copy_steamid, function()
				SetClipboardText(v:SteamID())
				LocalPlayer():ChatPrint("Skopiowałeś SteamID gracza " .. v:Nick())
			end)

			createOptions(adminmenu, ConfigurationTranslation.open_steam_profile, function()
				v:ShowProfile()
				LocalPlayer():ChatPrint("Otworzyłeś profil gracza " .. v:Nick())
			end)

			if IsStaff(LocalPlayer()) then
				createOptions(adminmenu, ConfigurationTranslation.goto, function()
					RunConsoleCommand("say", "!goto " .. v:SteamID())
					LocalPlayer():ChatPrint("Teleportowałeś się do " .. v:Nick())
				end)

				createOptions(adminmenu, ConfigurationTranslation.bring, function()
					RunConsoleCommand("say", "!bring " .. v:SteamID())
					LocalPlayer():ChatPrint("Teleportowałeś do siebie " .. v:Nick())
				end)

				createOptions(adminmenu, ConfigurationTranslation.returne, function()
					RunConsoleCommand("say", "!return " .. v:SteamID())
					LocalPlayer():ChatPrint("Teleportowałeś z powrotem " .. v:Nick())
				end)

				createOptions(adminmenu, ConfigurationTranslation.spectate, function()
					RunConsoleCommand("say", "!spectate " .. v:SteamID())
					LocalPlayer():ChatPrint("Obserwujesz " .. v:Nick())
				end)
			end

			createOptions(adminmenu, ConfigurationTranslation.cancel, function()
				adminmenu:Remove()
			end)
		end

		playerPanel.DoClick = function()
			surface.PlaySound('luna_ui/click3.wav')
			if not IsValid(v) then return end
		
			if IsValid(openedInfoPanel) then
				local yPos = openedInfoPanel:GetY()
				openedInfoPanel:Remove()
				openedInfoPanel = nil
		
				for i, panel in ipairs(playerPanels) do
					if panel:GetY() > yPos then
						panel:SetPos(panel:GetX(), panel:GetY() - ResponsiveY(53))
					end
				end
		
				for i, label in ipairs(categoryLabels) do
					if label:GetY() > yPos then
						label:SetPos(label:GetX(), label:GetY() - ResponsiveY(53))
					end
				end
		
				if yPos == playerPanel:GetY() + ResponsiveY(53) then
					return
				end
			end
		
			openedInfoPanel = vgui.Create("DPanel", ScrollMain)
			openedInfoPanel:SetSize(ResponsiveX(1800), ResponsiveY(53))
			openedInfoPanel:SetPos(playerPanel:GetX(), playerPanel:GetY() + ResponsiveY(53))
		
			local features = v:GetNetVar("features") or {}
			local features_string = "Отсутствует"
		
			for i, b in pairs(features or {}) do
				if b then
					features_string = FEATURES_TO_NORMAL[i].name
				end
			end
		
			local name = "Imię: " .. v:Name() .. ' (' .. v:OldName() .. ')' .. ' •'
			local feature = "Specjalizacja: " .. features_string .. ' •'
			local rank = "Ranga: " .. (v:GetNWString("rating") or "Nieznany") .. ' •'
			local money = "Finanse: " .. (v:GetMoney() and formatMoney(v:GetMoney()) or "Niedostępne") .. ' •'
			local steamid = v:SteamID() .. ' •'
			local usergroup = v:GetUserGroup() or "Nieznany"
		
			openedInfoPanel.Paint = function(self, w, h)
				surface.SetDrawColor(self:IsHovered() and Color(46, 46, 46, 225) or Color(22, 23, 28, 150))
				surface.DrawRect(0, 0, w, h)
				surface.SetDrawColor(Color(186, 186, 186))
				surface.DrawRect(ResponsiveX(27), ResponsiveY(53 * .53), ResponsiveX(30), ResponsiveY(2))
				surface.SetDrawColor(Color(186, 186, 186))
				surface.DrawRect(ResponsiveX(27), ResponsiveY(53 * .3 - (30 / 2)), ResponsiveX(2), ResponsiveY(30))
				
				surface.SetFont(luna.MontBase24)
				
				draw.SimpleText(feature, luna.MontBase24, ResponsiveX(70), ResponsiveY(27), Color(186, 186, 186), 0, 1)
		
				local nW, nH = surface.GetTextSize(feature)
				local x = ResponsiveX(70) + nW + 5
		
				draw.SimpleText(name, luna.MontBase24, x, ResponsiveY(27), Color(186, 186, 186), 0, 1)
				nW, nH = surface.GetTextSize(name)
				
				x = x + nW + 5
				draw.SimpleText(rank, luna.MontBase24, x, ResponsiveY(27), Color(186, 186, 186), 0, 1)
				nW, nH = surface.GetTextSize(rank)
				
				x = x + nW + 5
				draw.SimpleText(money, luna.MontBase24, x, ResponsiveY(27), Color(186, 186, 186), 0, 1)
				nW, nH = surface.GetTextSize(money)
				
				x = x + nW + 5
				draw.SimpleText(steamid, luna.MontBase24, x, ResponsiveY(27), Color(186, 186, 186), 0, 1)
				nW, nH = surface.GetTextSize(steamid)
				
				x = x + nW + 5
				draw.SimpleText(usergroup, luna.MontBase24, x, ResponsiveY(27), Color(186, 186, 186), 0, 1)
			end
		
			for i, panel in ipairs(playerPanels) do
				if panel:GetY() > playerPanel:GetY() then
					panel:SetPos(panel:GetX(), panel:GetY() + ResponsiveY(53))
				end
			end
		
			for i, label in ipairs(categoryLabels) do
				if label:GetY() > playerPanel:GetY() then
					label:SetPos(label:GetX(), label:GetY() + ResponsiveY(53))
				end
			end
		end
		
		table.insert(playerPanels, playerPanel)
	end

	for category, players in pairs(categories) do
        local categoryColor = (players[1] and players[1].Team and not players[1]:IsBot() and re.jobs[players[1]:Team()] and re.jobs[players[1]:Team()].Color) or color_white
		
		local categoryLabel = vgui.Create("DLabel", ScrollMain)
		categoryLabel:SetFont(luna.MontBase30)
		categoryLabel:SetSize(ResponsiveX(1800), ResponsiveY(33))
		categoryLabel:SetPos(ResponsiveX(10), ypos)

		categoryLabel:SetText("")
		categoryLabel.Paint = function(self, w, h)
			surface.SetDrawColor(Color(22, 23, 28, 150))
			surface.DrawRect(0, 0, w, h)

			draw.SimpleText(category .. " • Gracze:", luna.MontBase30, 17, h * .5, categoryColor, 0, 1)
			local categoryWidth = surface.GetTextSize(category .. " • Gracze:")
			surface.SetFont(luna.MontBase30)
			draw.SimpleText(#players, luna.MontBase30, 22 + categoryWidth, h * .5, color_white, 0, 1)
			local rectWidth = surface.GetTextSize(category .. " • Gracze:" .. #players)
			surface.SetFont(luna.MontBase30)

			surface.SetDrawColor(Color(102, 102, 102, 225))
			surface.DrawRect(15, h * .9, 10 + rectWidth, 2)
		end
		
    	table.insert(categoryLabels, categoryLabel)
		
		ypos = ypos + ResponsiveY(33)

		for _, player in pairs(players) do
			createPlayerPanel(player, ypos)
			ypos = ypos + ResponsiveY(55) - 2
		end
		
		ypos = ypos + ResponsiveY(20)
	end
end

local function overrideHooks()
	hook.Add("ScoreboardShow", "FAdmin_scoreboard", function()
		ToggleScoreboard()
		return Scoreboard
	end)

	hook.Add("ScoreboardHide", "FAdmin_scoreboard", function() end)
end

hook.Add("DarkRPFinishedLoading", "SUP::Reload", overrideHooks)
overrideHooks()

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
