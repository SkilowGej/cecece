--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if SERVER then return end

--[[
Уважаемый чувачёк или чувиха который сюда глазками смотрит,
Этот аддон разработан специально для проекта Renaissance лично Котэ#4440.
Да это мой дискордик :3
Пиздеть у них не надо, лучши напиши мне и мы договоримся об оплате твоих мечтаний.
Надеюсь ты усёк, я же и сервера ломать могу, понимаешь))?
]]
--Тут крч шрифты свои настроете, ага ? By Котэ#4440
-- surface.CreateFont("font_base_rotate", {
-- 	font = "Mont Bold",
-- 	extended = true,
-- 	size = 40,
-- 	weight = 500,
-- 	blursize = 0,
-- 	scanlines = 0,
-- 	antialias = true,
-- 	underline = false,
-- 	italic = false,
-- 	strikeout = false,
-- 	symbol = false,
-- 	rotary = false,
-- 	shadow = false,
-- 	additive = false,
-- 	outline = false,
-- })

-- surface.CreateFont("font_base_title", {
-- 	font = "Mont Bold",
-- 	extended = true,
-- 	size = 40,
-- 	weight = 500,
-- 	blursize = 0,
-- 	scanlines = 0,
-- 	antialias = true,
-- 	underline = false,
-- 	italic = false,
-- 	strikeout = false,
-- 	symbol = false,
-- 	rotary = false,
-- 	shadow = false,
-- 	additive = false,
-- 	outline = false,
-- })

-- surface.CreateFont("font_base_title1", {
-- 	font = "Mont Bold",
-- 	extended = true,
-- 	size = 40,
-- })

-- surface.CreateFont("font_base_title2", {
-- 	font = "Mont Bold",
-- 	extended = true,
-- 	size = 40,
-- })

-- surface.CreateFont("", {
-- 	font = "Mont Bold",
-- 	extended = true,
-- 	size = 40,
-- })

-- surface.CreateFont("font_big_black", {
-- 	font = "Mont Black",
-- 	extended = true,
-- 	size = 50,
-- })

surface.CreateFont("kotemenuultrabigfont", {
	font = "Mont Black",
	extended = true,
	size = 500,
})

-------------CONFING-----------
--ШРИФТЫ
kotecraftsysspawnpoint3d2dfont = "font_base_rotate"
--Команда передачи материала
kotecraftsysscrapgcommand = "/gscrap"
-------------CONFING-----------
local kotecraftsystemmodel = "models/alyx_postures.mdl"
local kotecraftsystemcountdown = 0
local lockcraft = false
local kotecraftsys_modelweaponname = "none"
local kotecraftsys_modeleaponnamecolor = Color(255, 255, 255, 255)
local koteplyhasscraptext = ""

--КОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКО
-- hook.Add("OnPlayerChat", "kotecraftsystemgivescraphandler", function(ply, strText, bTeam, bDead)
-- 	if ply ~= LocalPlayer() then return end
-- 	local lowertext = string.lower(strText)

-- 	--GIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMD
-- 	if string.StartWith(lowertext, kotecraftsysscrapgcommand) then
-- 		local kotecommandarray = string.Split(lowertext, " ")
-- 		local scrapvalue = tonumber(kotecommandarray[2], 10)

-- 		if isnumber(scrapvalue) then
-- 			local tr = util.GetPlayerTrace(LocalPlayer())
-- 			local trace = util.TraceLine(tr)

-- 			if trace.Entity:IsPlayer() then
-- 				if scrapvalue > LocalPlayer():GetNW2Int("kotecraftsys_scrap", 0) then
-- 					chat.AddText(Color(255, 255, 255, 255), "Вы не сможете передать больше материала чем у вас есть! ", "(" .. LocalPlayer():GetNW2Int("kotecraftsys_scrap", 0) .. ")")
-- 				else
-- 					chat.AddText(Color(255, 255, 255, 255), "Вы передали скрап (" .. scrapvalue .. ") игроку " .. trace.Entity:Name() .. "!")
-- 					net.Start("kotecraftsys_scrapgive")
-- 					net.WriteEntity(LocalPlayer())
-- 					net.WriteEntity(trace.Entity)
-- 					net.WriteInt(scrapvalue, 32)
-- 					net.SendToServer()
-- 				end
-- 			else
-- 				chat.AddText(Color(255, 255, 255, 255), "Вы должны смотреть на игрока для передачи материала!")
-- 			end
-- 		else
-- 			chat.AddText(Color(255, 255, 255, 255), "Вы не ввели число материала для передачи /gscrap (10)!")
-- 		end

-- 		return true
-- 	end
-- end)

--GIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMDGIVESCARPCMD
--КОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКОМАНДЫКО
-------------------------------------------------------SCRAPSTATION-------------------------------------------------------
net.Receive("kotecraftsystem_opencraftmenu", function()
	lockcraft = false
	surface.PlaySound("sup_sound/on.ogg")
	koteplyhasscraptext = "W tej chwili masz: " .. LocalPlayer():GetNW2Int("kotecraftsys_scrap", 0) .. " materiału"
	----------------------------------ОТКРЫТИЕПАНЕЛИ------------------------------------
	local kotecraftstationpanel = vgui.Create("DFrame")
	kotecraftstationpanel:SetPos(0, 0)
	kotecraftstationpanel:SetSize(ScrW(), ScrH())
	kotecraftstationpanel:SetTitle("")
	kotecraftstationpanel:SetVisible(true)
	kotecraftstationpanel:SetDraggable(false)
	kotecraftstationpanel:ShowCloseButton(false)
	kotecraftstationpanel:MakePopup()
	kotecraftstationpanel:SetAlpha(0)
	kotecraftstationpanel:AlphaTo(255, 0.5)

	kotecraftstationpanel.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)
		--BACKGROUND-----------
		--draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(64, 71, 79, 150))
		draw.RoundedBox(0, w * 0.1, h * 0.1, w * 0.8, h * 0.8, Color(22, 23, 28, 150))
		-- surface.SetMaterial(Material("celestia/vignette.png"))
		-- surface.SetDrawColor(255, 255, 255, 255)
		-- surface.DrawTexturedRect(0, 0, w, h)
		draw.ShadowSimpleText(koteplyhasscraptext, "font_base_title", w / 2, h * 0.95, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		--BACKGROUND-----------
		--HEADER-----------
		draw.RoundedBox(0, w * 0.1, h * 0.1, w * 0.8, h * 0.1, Color(22, 23, 28, 150))
		surface.SetMaterial(Material("luna_icons/tinker.png"))
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(w * 0.11, h * 0.11, h * 0.08, h * 0.08)
		draw.ShadowSimpleText("СТАНЦИЯ ПЕРЕРАБОТКИ МАТЕРИАЛА", "font_big_black", w * 0.17, h * 0.15, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		--HEADER-----------
		--MODELWEAPON--
		draw.RoundedBox(0, w * 0.51, h * 0.25, h * 0.6, h * 0.6, Color(0, 0, 0, 200))
		surface.DrawLine(w * 0.51 + h * 0.1, h * 0.25, w * 0.51 + h * 0.1, h * 0.85)
		surface.DrawLine(w * 0.51 + h * 0.2, h * 0.25, w * 0.51 + h * 0.2, h * 0.85)
		surface.DrawLine(w * 0.51 + h * 0.3, h * 0.25, w * 0.51 + h * 0.3, h * 0.85)
		surface.DrawLine(w * 0.51 + h * 0.4, h * 0.25, w * 0.51 + h * 0.4, h * 0.85)
		surface.DrawLine(w * 0.51 + h * 0.5, h * 0.25, w * 0.51 + h * 0.5, h * 0.85)
		surface.DrawLine(w * 0.51, h * 0.35, w * 0.51 + h * 0.6, h * 0.35)
		surface.DrawLine(w * 0.51, h * 0.45, w * 0.51 + h * 0.6, h * 0.45)
		surface.DrawLine(w * 0.51, h * 0.55, w * 0.51 + h * 0.6, h * 0.55)
		surface.DrawLine(w * 0.51, h * 0.65, w * 0.51 + h * 0.6, h * 0.65)
		surface.DrawLine(w * 0.51, h * 0.75, w * 0.51 + h * 0.6, h * 0.75)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawOutlinedRect(w * 0.51, h * 0.25, h * 0.6, h * 0.6, 1)

		if kotecraftsystemcommonbutton:IsDown() or kotecraftsystemrarebutton:IsDown() or kotecraftsystemlegbutton:IsDown() then
			draw.ShadowSimpleText(6 - math.ceil(kotecraftsystemcountdown), "kotemenuultrabigfont", w * 0.51 + h * 0.3, h * 0.25 + h * 0.3, Color(255, 181, 18, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			if kotecraftsysweaponmodelpanel:GetModel() ~= kotecraftsystemmodel then
				draw.ShadowSimpleText(kotecraftsys_modelweaponname, "font_base_title", w * 0.51 + h * 0.3, h * 0.25 + h * 0.55, kotecraftsys_modeleaponnamecolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end

		--MODELWEAPON--
		--COMMONCOST
		draw.ShadowSimpleText(kotecraftsystemcommoncraftcost, "font_base_title", w * 0.48, h * 0.325, Color(255, 255, 255, kotecraftsystemcommonbutton:GetAlpha()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		--COMMONCOST
		--UNCOMMONCOST
		draw.ShadowSimpleText(kotecraftsystemrarecraftcost, "font_base_title", w * 0.48, h * 0.550, Color(255, 255, 255, kotecraftsystemrarebutton:GetAlpha()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		--UNCOMMONCOST
		--LEGCOST
		draw.ShadowSimpleText(kotecraftsystemlegendarycraftcost, "font_base_title", w * 0.48, h * 0.775, Color(255, 255, 255, kotecraftsystemlegbutton:GetAlpha()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	--LEGCOST
	--EXITBUTTONEXITBUTTONEXITBUTTONEXITBUTTONEXITBUTTONEXITBUTTONEXITBUTTONEXITBUTTONEXITBUTTONEXITBUTTON
	local alphabutton = 200
	kotecraftsystemcommonbutton = vgui.Create("DButton", kotecraftstationpanel)
	kotecraftsystemcommonbutton:SetPos(ScrW() * 0.86, ScrH() * 0.125)
	kotecraftsystemcommonbutton:SetSize(ScrH() * 0.05, ScrH() * 0.05)
	kotecraftsystemcommonbutton:SetText("")
	kotecraftsystemcommonbutton:SetAlpha(255)

	kotecraftsystemcommonbutton.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(alphabutton, 49, 28, 255))
		draw.ShadowSimpleText("X", "font_base_title", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	kotecraftsystemcommonbutton.OnCursorEntered = function()
		surface.PlaySound("luna_ui/click2.wav")
		alphabutton = 255
	end

	kotecraftsystemcommonbutton.OnCursorExited = function()
		alphabutton = 200
	end

	kotecraftsystemcommonbutton.DoClick = function()
		kotecraftstationpanel:Remove()
		surface.PlaySound("luna_ui/pop.wav")
	end

	--EXITBUTTONEXITBUTTONEXITBUTTONEXITBUTTONEXITBUTTONEXITBUTTONEXITBUTTONEXITBUTTONEXITBUTTONEXITBUTTON
	--COMMONBUTTONCOMMONBUTTONCOMMONBUTTONCOMMONBUTTONCOMMONBUTTONCOMMONBUTTONCOMMONBUTTON
	local activebuttonslidersize = 0
	local lasttime = 0
	local alphabutton = 180
	local prevtime1 = 0
	local prevtimemodel = 0
	kotecraftsystemcommonbutton = vgui.Create("DButton", kotecraftstationpanel)
	kotecraftsystemcommonbutton:SetPos(ScrW() * 0.15, ScrH() * 0.25)
	kotecraftsystemcommonbutton:SetSize(ScrW() * 0.3, ScrH() * 0.15)
	kotecraftsystemcommonbutton:SetText("")
	kotecraftsystemcommonbutton:SetAlpha(0)

	kotecraftsystemcommonbutton.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, alphabutton))
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
		draw.RoundedBox(0, 0, 0, activebuttonslidersize * w / 5, h, Color(255, 255, 255, 20))
		draw.ShadowSimpleText("ZWYKŁE UZBROJENIE", "font_base_title", w / 2, h / 2, Color(9, 219, 82, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.ShadowSimpleText("ZWYKŁE UZBROJENIE", "font_base_title", w / 2, h / 2, Color(9, 219, 82, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		----BUTTONDOWNFUNC
		if kotecraftsystemcommonbutton:IsDown() then
			if lockcraft then return end

			--BUTTONISDOWN
			if lasttime == 0 then
				lasttime = CurTime()
			end

			activebuttonslidersize = CurTime() - lasttime
			kotecraftsystemcountdown = activebuttonslidersize

			if (6 - math.ceil(activebuttonslidersize)) == 0 then
				kotecraftsystem_wanttocraft("COMMON", kotecraftsystemcommoncraftcost)
			end

			if prevtime1 < CurTime() then
				prevtime1 = CurTime() + 1
				surface.PlaySound("luna_ui/click3.wav")
			end

			if prevtimemodel < CurTime() then
				prevtimemodel = CurTime() + 0.2
				local koteweaponselect = table.Random(kotecraftsyscommonweapons)
				kotecraftsysweaponmodelpanel:SetModel(koteweaponselect['weaponmodel'])
				kotecraftsys_modelweaponname = koteweaponselect['weaponname']
				kotecraftsys_modeleaponnamecolor = Color(9, 219, 82, 255)
				surface.PlaySound("luna_ui/click3.wav")
			end
			--BUTTONISDOWN
		else
			--ELSEBUTTONISDOWN
			activebuttonslidersize = 0
			--ELSEBUTTONISDOWN
		end
	end

	----BUTTONDOWNFUNC
	kotecraftsystemcommonbutton.OnCursorEntered = function()
		lasttime = 0
		surface.PlaySound("luna_ui/click2.wav")
		alphabutton = 230
		kotecraftsysweaponmodelpanel:SetModel(kotecraftsystemmodel)
	end

	kotecraftsystemcommonbutton.OnCursorExited = function()
		lasttime = 0
		alphabutton = 180
		kotecraftsysweaponmodelpanel:SetModel(kotecraftsystemmodel)
	end

	kotecraftsystemcommonbutton.DoClick = function()
		lasttime = 0
		lockcraft = false
		kotecraftsysweaponmodelpanel:SetModel(kotecraftsystemmodel)
	end

	--COMMONBUTTONCOMMONBUTTONCOMMONBUTTONCOMMONBUTTONCOMMONBUTTONCOMMONBUTTONCOMMONBUTTON
	timer.Create("kotecraftsystemcommonbuttonsetup", 0.25, 1, function()
		if IsValid(kotecraftsystemcommonbutton) then
			kotecraftsystemcommonbutton:AlphaTo(255, 0.5)
		end
	end)

	--RAREBUTTONRAREBUTTONRAREBUTTONRAREBUTTONRAREBUTTONRAREBUTTONRAREBUTTONRAREBUTTONRAREBUTTON
	local activebuttonslidersize = 0
	local lasttime = 0
	local alphabutton = 180
	local prevtime1 = 0
	local prevtimemodel = 0
	kotecraftsystemrarebutton = vgui.Create("DButton", kotecraftstationpanel)
	kotecraftsystemrarebutton:SetPos(ScrW() * 0.15, ScrH() * 0.475)
	kotecraftsystemrarebutton:SetSize(ScrW() * 0.3, ScrH() * 0.15)
	kotecraftsystemrarebutton:SetText("")
	kotecraftsystemrarebutton:SetAlpha(0)

	kotecraftsystemrarebutton.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, alphabutton))
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
		draw.RoundedBox(0, 0, 0, activebuttonslidersize * w / 5, h, Color(255, 255, 255, 20))
		draw.ShadowSimpleText("RZADKIE UZBROJENIE", "font_base_title", w / 2, h / 2, Color(140, 82, 171, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.ShadowSimpleText("RZADKIE UZBROJENIE", "font_base_title", w / 2, h / 2, Color(140, 82, 171, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		if kotecraftsystemrarebutton:IsDown() then
			if lockcraft then return end

			--BUTTONISDOWN
			if lasttime == 0 then
				lasttime = CurTime()
			end

			activebuttonslidersize = CurTime() - lasttime
			kotecraftsystemcountdown = activebuttonslidersize

			if (6 - math.ceil(activebuttonslidersize)) == 0 then
				kotecraftsystem_wanttocraft("RARE", kotecraftsystemrarecraftcost)
			end

			if prevtime1 < CurTime() then
				prevtime1 = CurTime() + 1
				surface.PlaySound("luna_ui/click3.wav")
			end

			if prevtimemodel < CurTime() then
				prevtimemodel = CurTime() + 0.2
				local koteweaponselect = table.Random(kotecraftsysrareweapons)
				kotecraftsysweaponmodelpanel:SetModel(koteweaponselect['weaponmodel'])
				kotecraftsys_modelweaponname = koteweaponselect['weaponname']
				kotecraftsys_modeleaponnamecolor = Color(140, 82, 171, 255)
				surface.PlaySound("luna_ui/click3.wav")
			end
			--BUTTONISDOWN
		else
			activebuttonslidersize = 0
		end
	end

	kotecraftsystemrarebutton.OnCursorEntered = function()
		lasttime = 0
		surface.PlaySound("luna_ui/click2.wav")
		alphabutton = 230
		kotecraftsysweaponmodelpanel:SetModel(kotecraftsystemmodel)
	end

	kotecraftsystemrarebutton.OnCursorExited = function()
		lasttime = 0
		alphabutton = 180
		kotecraftsysweaponmodelpanel:SetModel(kotecraftsystemmodel)
	end

	kotecraftsystemrarebutton.DoClick = function()
		lasttime = 0
		lockcraft = false
		kotecraftsysweaponmodelpanel:SetModel(kotecraftsystemmodel)
	end

	--RAREBUTTONRAREBUTTONRAREBUTTONRAREBUTTONRAREBUTTONRAREBUTTONRAREBUTTONRAREBUTTONRAREBUTTON
	timer.Create("kotecraftsystemcommonbuttonsetup2", 0.5, 1, function()
		if IsValid(kotecraftsystemrarebutton) then
			kotecraftsystemrarebutton:AlphaTo(255, 0.5)
		end
	end)

	--LEGENDARYBUTTONLEGENDARYBUTTONLEGENDARYBUTTONLEGENDARYBUTTONLEGENDARYBUTTONLEGENDARYBUTTONLEGENDARYBUTTON
	local activebuttonslidersize = 0
	local lasttime = 0
	local alphabutton = 180
	local prevtime1 = 0
	kotecraftsystemlegbutton = vgui.Create("DButton", kotecraftstationpanel)
	kotecraftsystemlegbutton:SetPos(ScrW() * 0.15, ScrH() * 0.7)
	kotecraftsystemlegbutton:SetSize(ScrW() * 0.3, ScrH() * 0.15)
	kotecraftsystemlegbutton:SetText("")
	kotecraftsystemlegbutton:SetAlpha(0)

	kotecraftsystemlegbutton.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, alphabutton))
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
		draw.RoundedBox(0, 0, 0, activebuttonslidersize * w / 5, h, Color(255, 255, 255, 20))
		draw.ShadowSimpleText("LEGENDARNE UZBROJENIE", "font_base_title", w / 2, h / 2, Color(199, 146, 22, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.ShadowSimpleText("LEGENDARNE UZBROJENIE", "font_base_title", w / 2, h / 2, Color(199, 146, 22, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		if kotecraftsystemlegbutton:IsDown() then
			if lockcraft then return end

			--BUTTONISDOWN
			if lasttime == 0 then
				lasttime = CurTime()
			end

			activebuttonslidersize = CurTime() - lasttime
			kotecraftsystemcountdown = activebuttonslidersize

			if (6 - math.ceil(activebuttonslidersize)) == 0 then
				kotecraftsystem_wanttocraft("LEGENDARY", kotecraftsystemlegendarycraftcost)
			end

			if prevtime1 < CurTime() then
				prevtime1 = CurTime() + 1
				surface.PlaySound("luna_ui/click3.wav")
			end

			if prevtimemodel < CurTime() then
				prevtimemodel = CurTime() + 0.2
				local koteweaponselect = table.Random(kotecraftsyslegendaryweapons)
				kotecraftsysweaponmodelpanel:SetModel(koteweaponselect['weaponmodel'])
				kotecraftsys_modelweaponname = koteweaponselect['weaponname']
				kotecraftsys_modeleaponnamecolor = Color(199, 146, 22, 255)
				surface.PlaySound("luna_ui/click3.wav")
			end
			--BUTTONISDOWN
		else
			activebuttonslidersize = 0
		end
	end

	kotecraftsystemlegbutton.OnCursorEntered = function()
		lasttime = 0
		surface.PlaySound("luna_ui/click2.wav")
		alphabutton = 230
		kotecraftsysweaponmodelpanel:SetModel(kotecraftsystemmodel)
	end

	kotecraftsystemlegbutton.OnCursorExited = function()
		lasttime = 0
		alphabutton = 180
		kotecraftsysweaponmodelpanel:SetModel(kotecraftsystemmodel)
	end

	kotecraftsystemlegbutton.DoClick = function()
		lockcraft = false
		lasttime = 0
		kotecraftsysweaponmodelpanel:SetModel(kotecraftsystemmodel)
	end

	--LEGENDARYBUTTONLEGENDARYBUTTONLEGENDARYBUTTONLEGENDARYBUTTONLEGENDARYBUTTONLEGENDARYBUTTONLEGENDARYBUTTON
	timer.Create("kotecraftsystemcommonbuttonsetup3", 0.75, 1, function()
		if IsValid(kotecraftsystemlegbutton) then
			kotecraftsystemlegbutton:AlphaTo(255, 0.5)
		end
	end)

	--CRAFTWEAPONMODELCRAFTWEAPONMODELCRAFTWEAPONMODELCRAFTWEAPONMODELCRAFTWEAPONMODELCRAFTWEAPONMODEL
	kotecraftsysweaponmodelpanel = vgui.Create('DModelPanel', kotecraftstationpanel)
	kotecraftsysweaponmodelpanel:SetSize(ScrH() * 0.6, ScrH() * 0.6)
	kotecraftsysweaponmodelpanel:SetPos(ScrW() * 0.51, ScrH() * 0.25)
	kotecraftsysweaponmodelpanel:SetModel(kotecraftsystemmodel)
	kotecraftsysweaponmodelpanel:GetEntity():SetSkin(0)
	kotecraftsysweaponmodelpanel:GetEntity():SetBodyGroups(0)
	kotecraftsysweaponmodelpanel:SetMouseInputEnabled(false)
	kotecraftsysweaponmodelpanel:SetAlpha(255)

	function kotecraftsysweaponmodelpanel:LayoutEntity(Entity)
		kotecraftsysweaponmodelpanel:SetLookAt(Entity:GetPos())
		kotecraftsysweaponmodelpanel:SetFOV(35)
		kotecraftsysweaponmodelpanel:SetCamPos(Vector(0, -100, 0))
	end
end)

--CRAFTWEAPONMODELCRAFTWEAPONMODELCRAFTWEAPONMODELCRAFTWEAPONMODELCRAFTWEAPONMODELCRAFTWEAPONMODEL
----------------------------------ОТКРЫТИЕПАНЕЛИ------------------------------------
function kotecraftsystem_wanttocraft(rarity, cost)
	if lockcraft then return end
	lockcraft = true

	if cost > LocalPlayer():GetNW2Int("kotecraftsys_scrap", 0) then
		surface.PlaySound("luna_ui/buttonhover1.mp3")
		koteplyhasscraptext = "Nie masz wystarczającej ilości materiału do stworzenia broni"

		timer.Create("kotecraftsysclnotify", 2, 1, function()
			koteplyhasscraptext = "W tym momencie masz: " .. LocalPlayer():GetNW2Int("kotecraftsys_scrap", 0) .. " jednostek materiału"
		end)
	end

	if cost > LocalPlayer():GetNW2Int("kotecraftsys_scrap", 0) then return end
	surface.PlaySound("luna_ui/success1.wav")
	kotecraftsysweaponmodelpanel:SetModel(kotecraftsystemmodel)
	---ЗАПРОС НА СЕРВЕР ПО КРАФТУ
	net.Start("kotecraftsystem_wanttocraft")
	net.WriteEntity(LocalPlayer())
	net.WriteString(rarity)
	net.SendToServer()
	---ЗАПРОС НА СЕРВЕР ПО КРАФТУ
end

net.Receive("kotecraftsystem_opencraftfinalmenu", function()
	local weapon = net.ReadTable()
	local rarity = net.ReadString()
	local hasweapon = net.ReadBool()
	koteplyhasscraptext = "W tym momencie masz: " .. LocalPlayer():GetNW2Int("kotecraftsys_scrap", 0) .. " jednostek materiału"
	local vincolor = Color(255, 255, 255, 255)
	local raritytext = ""

	if rarity == "COMMON" then
		raritytext = "Zwykłe"
		vincolor = Color(9, 219, 82, 255)
	elseif rarity == "RARE" then
		raritytext = "Rzadkie"
		vincolor = Color(140, 82, 171, 255)
	elseif rarity == "LEGENDARY" then
		raritytext = "Legendarne"
		vincolor = Color(199, 146, 22, 255)
	end

	local kotecraftstationpanelfinal = vgui.Create("DFrame")
	kotecraftstationpanelfinal:SetPos(0, 0)
	kotecraftstationpanelfinal:SetSize(ScrW(), ScrH())
	kotecraftstationpanelfinal:SetTitle("")
	kotecraftstationpanelfinal:SetVisible(true)
	kotecraftstationpanelfinal:SetDraggable(false)
	kotecraftstationpanelfinal:ShowCloseButton(false)
	kotecraftstationpanelfinal:MakePopup()
	kotecraftstationpanelfinal:SetAlpha(0)
	kotecraftstationpanelfinal:AlphaTo(255, 0.5)

	kotecraftstationpanelfinal.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)
		draw.RoundedBox(0, 0, 0, w, h, Color(22, 23, 28, 150))
		draw.RoundedBox(0, w / 2 - 25 - 50 * 5 - 10 * 5, h / 2 - 150, 50, 200, vincolor)
		draw.RoundedBox(0, w / 2 - 25 - 50 * 4 - 10 * 4, h / 2 - 150, 50, 220, vincolor)
		draw.RoundedBox(0, w / 2 - 25 - 50 * 3 - 10 * 3, h / 2 - 150, 50, 240, vincolor)
		draw.RoundedBox(0, w / 2 - 25 - 50 * 2 - 10 * 2, h / 2 - 150, 50, 260, vincolor)
		draw.RoundedBox(0, w / 2 - 25 - 50 - 10, h / 2 - 150, 50, 280, vincolor)
		draw.RoundedBox(0, w / 2 - 25, h / 2 - 150, 50, 300, vincolor)
		draw.RoundedBox(0, w / 2 - 25 + 50 + 10, h / 2 - 150, 50, 280, vincolor)
		draw.RoundedBox(0, w / 2 - 25 + 50 * 2 + 10 * 2, h / 2 - 150, 50, 260, vincolor)
		draw.RoundedBox(0, w / 2 - 25 + 50 * 3 + 10 * 3, h / 2 - 150, 50, 240, vincolor)
		draw.RoundedBox(0, w / 2 - 25 + 50 * 4 + 10 * 4, h / 2 - 150, 50, 220, vincolor)
		draw.RoundedBox(0, w / 2 - 25 + 50 * 5 + 10 * 5, h / 2 - 150, 50, 200, vincolor)
		draw.ShadowSimpleText(raritytext, "font_big_black", w / 2, h / 2 - 180, vincolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.ShadowSimpleText(weapon['weaponname'], "font_big_black", w / 2, h / 2 + 180, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		if weapon['weaponclass'] == "null" then
			draw.ShadowSimpleText("Nie martw się, zwrócimy Ci 15% materiału...", "font_big_black", w / 2, h / 2 + 230, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		if hasweapon then
			draw.ShadowSimpleText("Masz już to uzbrojenie, więc zwrócimy Ci 50% materiału...", "font_big_black", w / 2, h / 2 + 230, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end

	--CRAFTWEAPONMODELCRAFTWEAPONMODELCRAFTWEAPONMODELCRAFTWEAPONMODELCRAFTWEAPONMODELCRAFTWEAPONMODEL
	local kotecraftsysweaponmodelpanelfinal = vgui.Create('DModelPanel', kotecraftstationpanelfinal)
	kotecraftsysweaponmodelpanelfinal:SetSize(500, 300)
	kotecraftsysweaponmodelpanelfinal:SetPos(ScrW() / 2 - 250, ScrH() / 2 - 150)
	kotecraftsysweaponmodelpanelfinal:SetModel(weapon["weaponmodel"])
	kotecraftsysweaponmodelpanelfinal:GetEntity():SetSkin(0)
	kotecraftsysweaponmodelpanelfinal:GetEntity():SetBodyGroups(0)
	kotecraftsysweaponmodelpanelfinal:SetMouseInputEnabled(false)
	kotecraftsysweaponmodelpanelfinal:SetAlpha(255)
	kotecraftsysweaponmodelpanelfinal:SetAmbientLight(vincolor)

	function kotecraftsysweaponmodelpanelfinal:LayoutEntity(Entity)
		kotecraftsysweaponmodelpanelfinal:SetLookAt(Entity:GetPos())
		kotecraftsysweaponmodelpanelfinal:SetFOV(35)
		kotecraftsysweaponmodelpanelfinal:SetCamPos(Vector(0, -100, 0))
	end

	--CRAFTWEAPONMODELCRAFTWEAPONMODELCRAFTWEAPONMODELCRAFTWEAPONMODELCRAFTWEAPONMODELCRAFTWEAPONMODEL
	--ACCEPTBUTTONACCEPTBUTTONACCEPTBUTTONACCEPTBUTTONACCEPTBUTTONACCEPTBUTTONACCEPTBUTTONACCEPTBUTTONACCEPTBUTTON
	alphabutton = 200
	kotecraftsystemacceptbutton = vgui.Create("DButton", kotecraftstationpanelfinal)
	kotecraftsystemacceptbutton:SetPos(ScrW() / 2 - 200, ScrH() / 2 + 280)
	kotecraftsystemacceptbutton:SetSize(400, 50)
	kotecraftsystemacceptbutton:SetText("")
	kotecraftsystemacceptbutton:SetAlpha(0)

	kotecraftsystemacceptbutton.Paint = function(self, w, h)
		draw.RoundedBox(80, 0, 0, w, h, Color(alphabutton, 49, 28, 255))
		draw.ShadowSimpleText("PRZYJMIJ", "font_base_title", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	kotecraftsystemacceptbutton.OnCursorEntered = function()
		surface.PlaySound("luna_ui/click2.wav")
		alphabutton = 255
	end

	kotecraftsystemacceptbutton.OnCursorExited = function()
		alphabutton = 200
	end

	kotecraftsystemacceptbutton.DoClick = function()
		surface.PlaySound("luna_ui/click1.wav")
		kotecraftstationpanelfinal:Remove()
		lockcraft = false
	end

	--ACCEPTBUTTONACCEPTBUTTONACCEPTBUTTONACCEPTBUTTONACCEPTBUTTONACCEPTBUTTONACCEPTBUTTONACCEPTBUTTONACCEPTBUTTON
	timer.Create("kotecraftsys_acceptbuttontimer", 1, 1, function()
		if IsValid(kotecraftsystemacceptbutton) then
			kotecraftsystemacceptbutton:AlphaTo(255, 0.5)
		end
	end)
end)
-------------------------------------------------------SCRAPSTATION-------------------------------------------------------

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
