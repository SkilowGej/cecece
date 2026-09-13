--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

TOOL.Category		= "Third Party Tools"
TOOL.Name			= "Textscreen"
TOOL.Command		= nil
TOOL.ConfigName		= ""

local textBox = {}
local lineLabels = {}
local labels = {}
local sliders = {}
for i = 1, 5 do
	TOOL.ClientConVar[ "text"..i ] = ""
	TOOL.ClientConVar[ "size"..i ] = 20
	TOOL.ClientConVar[ "r"..i ] = 255
	TOOL.ClientConVar[ "g"..i ] = 255
	TOOL.ClientConVar[ "b"..i ] = 255
	TOOL.ClientConVar[ "a"..i ] = 255
end

cleanup.Register("textscreens")

if (CLIENT) then
	language.Add("Tool.textscreen.name", "Textscreen")
	language.Add("Tool.textscreen.desc", "Tworzy wielowierszowe napisy o różnych rozmiarach i kolorach")

	language.Add("Tool.textscreen.0", "LPM – stwórz napis. PPM – zaktualizuj istniejący z nowymi ustawieniami")
	language.Add("Tool_textscreen_0", "LPM – stwórz napis. PPM – zaktualizuj istniejący z nowymi ustawieniami")

	language.Add("Undone.textscreens", "Cofnij napis")
	language.Add("Undone_textscreens", "Cofnij napis")
	language.Add("Cleanup.textscreens", "Napisy")
	language.Add("Cleanup_textscreens", "Napisy")
	language.Add("Cleaned.textscreens", "Wszystkie napisy usunięte")
	language.Add("Cleaned_textscreens", "Wszystkie napisy usunięte")

	language.Add("SBoxLimit.textscreens", "Osiągnąłeś limit napisów!")
	language.Add("SBoxLimit_textscreens", "Osiągnąłeś limit napisów!")
end

function TOOL:LeftClick(tr)
	if (tr.Entity:GetClass() == "player") then return false end
	if (CLIENT) then return true end

	local ply = self:GetOwner()

	if not (self:GetWeapon():CheckLimit("textscreens")) then return false end

	local textScreen = ents.Create("sammyservers_textscreen") -- решил сохранить все копирайты
	textScreen:SetPos(tr.HitPos)
	local angle = tr.HitNormal:Angle()
	angle:RotateAroundAxis(tr.HitNormal:Angle():Right(), -90)
	angle:RotateAroundAxis(tr.HitNormal:Angle():Forward(), 90)
	textScreen:SetAngles(angle)
	textScreen:Spawn()
	textScreen:Activate()
	for i = 1, 5 do
		textScreen:SetLine(
			i, -- Line
			self:GetClientInfo("text"..i), -- text
			Color( -- Color
				tonumber(self:GetClientInfo("r"..i)), 
				tonumber(self:GetClientInfo("g"..i)), 
				tonumber(self:GetClientInfo("b"..i)), 
				tonumber(self:GetClientInfo("a"..i))
			),
			tonumber(self:GetClientInfo("size"..i))
		)
	end

	undo.Create("textscreens")
	undo.AddEntity(textScreen)
	undo.SetPlayer(ply)
	undo.Finish()

	ply:AddCount("textscreens", textScreen)
	ply:AddCleanup("textscreens", textScreen)

	return true
end

function TOOL:RightClick(tr)
	if (tr.Entity:GetClass() == "player") then return false end
	if (CLIENT) then return true end

	local TraceEnt = tr.Entity

	if (IsValid(TraceEnt) and TraceEnt:GetClass() == "sammyservers_textscreen") then
		for i = 1, 5 do
			TraceEnt:SetLine(
				i, -- Line
				tostring(self:GetClientInfo("text"..i)), -- text
				Color( -- Color
					tonumber(self:GetClientInfo("r"..i)), 
					tonumber(self:GetClientInfo("g"..i)), 
					tonumber(self:GetClientInfo("b"..i)), 
					tonumber(self:GetClientInfo("a"..i))
				),
				tonumber(self:GetClientInfo("size"..i))
			)
		end
		TraceEnt:Broadcast()
		return true
	end
end

function TOOL.BuildCPanel(CPanel)
	CPanel:AddControl("Header", {Text = "#Tool.textscreen.name", Description = "#Tool.textscreen.desc"})
	--CPanel:AddControl("Label", {Text = "Przetłumaczył _AMD_ specjalnie dla projektu TRIGON.IM!"})
	resetall = vgui.Create("DButton", resetbuttons)
	resetall:SetSize(100, 25)
	resetall:SetText("Resetuj")
	resetall.DoClick = function()
		local menu = DermaMenu()
		menu:AddOption("Resetuj kolory", function()
			for i = 1, 5 do
				RunConsoleCommand("textscreen_r"..i, 255)
				RunConsoleCommand("textscreen_g"..i, 255)
				RunConsoleCommand("textscreen_b"..i, 255)
				RunConsoleCommand("textscreen_a"..i, 255)
			end
		end)
		menu:AddOption("Resetuj rozmiary", function()
			for i = 1, 5 do
				RunConsoleCommand("textscreen_size"..i, 20)
				sliders[i]:SetValue(20)
			end
		end)
		menu:AddOption("Resetuj teksty", function()
			for i = 1, 5 do
				RunConsoleCommand("textscreen_text"..i, "")
				textBox[i]:SetValue("")
			end
		end)
		menu:AddOption("Pełny reset", function()
			for i = 1, 5 do
				RunConsoleCommand("textscreen_r"..i, 255)
				RunConsoleCommand("textscreen_g"..i, 255)
				RunConsoleCommand("textscreen_b"..i, 255)
				RunConsoleCommand("textscreen_a"..i, 255)
				RunConsoleCommand("textscreen_size"..i, 20)
				sliders[i]:SetValue(20)
				RunConsoleCommand("textscreen_text"..i, "")
				textBox[i]:SetValue("")
			end
		end)
		menu:Open()
	end
	CPanel:AddItem(resetall)
	resetline = vgui.Create("DButton")
	resetline:SetSize(100, 25)
	resetline:SetText("Wyczyść wiersz")
	resetline.DoClick = function()
		local menu = DermaMenu()
		for i = 1, 5 do
			menu:AddOption("Wyczyść linię "..i, function()
				RunConsoleCommand("textscreen_r"..i, 255)
				RunConsoleCommand("textscreen_g"..i, 255)
				RunConsoleCommand("textscreen_b"..i, 255)
				RunConsoleCommand("textscreen_a"..i, 255)
				RunConsoleCommand("textscreen_size"..i, 20)
				sliders[i]:SetValue(20)
				RunConsoleCommand("textscreen_text"..i, "")
				textBox[i]:SetValue("")
			end)
		end
		menu:AddOption("Wyczyść wszystkie linie", function()
			for i = 1, 5 do
				RunConsoleCommand("textscreen_r"..i, 255)
				RunConsoleCommand("textscreen_g"..i, 255)
				RunConsoleCommand("textscreen_b"..i, 255)
				RunConsoleCommand("textscreen_a"..i, 255)
				RunConsoleCommand("textscreen_size"..i, 20)
				sliders[i]:SetValue(20)
				RunConsoleCommand("textscreen_text"..i, "")
				textBox[i]:SetValue("")
			end
		end)
		menu:Open()
	end
	CPanel:AddItem(resetline)

	for i = 1, 5 do
		lineLabels[i] = CPanel:AddControl("Label", {
			Text = "Napis "..i,
			Description = "Napis "..i
		})
		lineLabels[i]:SetFont("Default")
		CPanel:AddControl("Color", {
			Label = "Kolor "..i.." napisu",
			Red = "textscreen_r"..i,
			Green = "textscreen_g"..i,
			Blue = "textscreen_b"..i,
			Alpha = "textscreen_a"..i,
			ShowHSV = 1,
			ShowRGB = 1,
			Multiplier = 255
		})
		sliders[i] = vgui.Create("DNumSlider")
		sliders[i]:SetText("Rozmiar czcionki")
		sliders[i]:SetMinMax(20, 100)
		sliders[i]:SetDecimals(0)
		sliders[i]:SetValue(20)
		sliders[i]:SetConVar("textscreen_size"..i)
		sliders[i].OnValueChanged = function(panel, value)
			labels[i]:SetFont("CV"..math.Round(value))
		end
		CPanel:AddItem(sliders[i])
		textBox[i] = vgui.Create("DTextEntry")
		textBox[i]:SetUpdateOnType(true)
		textBox[i]:SetEnterAllowed(true)
		textBox[i]:SetConVar("textscreen_text"..i)
		textBox[i]:SetValue(GetConVarString("textscreen_text"..i))
		textBox[i].OnTextChanged = function()
			labels[i]:SetText(textBox[i]:GetValue())
		end
		CPanel:AddItem(textBox[i])
		labels[i] = CPanel:AddControl("Label", {
			Text = "Wiersz "..i,
			Description = "Wiersz "..i
		})
		labels[i]:SetFont("Default")
		labels[i].Think = function()
			labels[i]:SetColor(Color(GetConVarNumber("textscreen_r"..i), GetConVarNumber("textscreen_g"..i), GetConVarNumber("textscreen_b"..i), GetConVarNumber("textscreen_a"..i)))
		end
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
