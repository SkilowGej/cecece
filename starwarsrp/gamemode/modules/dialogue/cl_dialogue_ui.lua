--[[
	MPanel
]]
local PANEL = {}
AccessorFunc(PANEL, "DrawBackground", "DrawBackground")

function PANEL:Init()
	self:SetDrawBackground(true)
end

function PANEL:Paint()
	if self:GetDrawBackground() then
		-- draw.DrawOutlinedRoundedRect(self:GetWide(), self:GetTall(), Color(0, 0, 0, 255))
		draw.DrawRect(1, 1, self:GetWide() - 2, self:GetTall() - 2, Color(0, 0, 0, 200))
	end
end

derma.DefineControl("MPanel", "", PANEL, "EditablePanel")

--[[
	MLabel
]]

local PANEL = {}

AccessorFunc(PANEL, "Text", "Text")
AccessorFunc(PANEL, "Font", "Font")
AccessorFunc(PANEL, "Color", "Color")
AccessorFunc(PANEL, "Uppercase", "Uppercase")
AccessorFunc(PANEL, "Align", "TextAlign")

function PANEL:Init()
	self:SetColor(COLOR_WHITE)
	self:SetFont(luna.MontBase18)
	self:SetUppercase(false)
	self:SetColor(COLOR_WHITE)
	self:SetTextAlign(TEXT_ALIGN_LEFT)
end

function PANEL:SetText(text)
	if self:GetUppercase() then
		text = string.upper(text)
	end
	self:SetSize(surface.GetTextWidth(text, self:GetFont()))
	self.Text = text
end

function PANEL:Paint(w, h)
	surface.DrawShadowTexts(self:GetText() or "", self:GetFont(), self:GetTextAlign() == TEXT_ALIGN_CENTER and w/2 or 0, 0, self:GetColor(), COLOR_BLACK, self:GetTextAlign())
end
derma.DefineControl( "MLabel", "", PANEL)

--[[
	MGradient
]]

local PANEL = {}

function PANEL:Init()
	self.multiplayer = 0
	self:SetSize(ScrW(), ScrH())
	-- RunConsoleCommand("pp_bokeh", 1)
end

function PANEL:Paint(w, h)
	draw.DrawBlur(0, 0, w, h, 6)
end

derma.DefineControl("MGradient", "", PANEL, "EditablePanel")
--[[
	MDialogue
]]
local PANEL = {}

function PANEL:CreateBlur()
	if self.BarPanel and self.BarPanel:IsValid() then
		self.BarPanel:FadeOut(FADE_DELAY)
	end

	gui.EnableScreenClicker(true)
end

function PANEL:GetBlur()
	return self.Blur and self.Blur:IsValid()
end

function PANEL:RemoveBlur()
	RemoveLastItem()

	self.Blur:FadeOut(FADE_DELAY, true, function()
		gui.EnableScreenClicker(false)
	end)

	if self.BarPanel and self.BarPanel:IsValid() then
		self.BarPanel:FadeIn(FADE_DELAY)
	end
end

function PANEL:OnRemove()
	-- self:RemoveBlur()
	hook.Remove("PlayerBindPress", "re.dialogue.PlayerBindPress")
end

function PANEL:Init()
	-- self:SetTitle "Dialogue Box"
	self:DockPadding(1, 30, 1, 1)
	self:SetAlpha(0)
	self:SetWide(1000)
	self:SetPos(ScrW() / 2 - self:GetWide() / 2, ScrH())
	-- self:SetBackgroundColor(Color(0,0,0,255))
	self:SetDrawBackground(false)
	-- self.close:Remove()
	self:MakePopup()

	self.speech = vgui.Create("MLabel", self)
	self.speech:Dock(TOP)
	self.speech:SetFont(luna.MontBase30)
	self.speech:DockMargin(0,0,0,30)

	self.container = pnl
	local scroll = vgui.Create("DScrollPanel", self)
	scroll:Dock(FILL)
	scroll.VBar:SetWide(0)
	self.buttons = scroll

	hook.Add("PlayerBindPress", "re.dialogue.PlayerBindPress", function()
		self:Remove()
	end)
end

function PANEL:SetTitle(title)
	self.title = title
end

function PANEL:GetTitle()
	return self.title
end

function PANEL:SetDialogue(diaid)
	self.dialogue = re.dialogue.data[diaid] or nil
	if not self.dialogue then return end
	self:SetTitle(self.npc:GetJobName())
	self:DisplayTree(1)
	local pnl = vgui.Create("MPanel", self)
	pnl:Dock(LEFT)
	pnl:DockPadding(0, 0, 0, 0)
	local title = self:GetTitle()
	surface.SetFont(luna.MontBase45)
	local wt, _ = surface.GetTextSize(title)

	pnl.Paint = function(_, w, h)
		surface.DrawShadowText(title, luna.MontBase45, 0, 0, COLOR_HOVER, COLOR_BLACK, TEXT_ALIGN_LEFT)
	end

	pnl:SetWide(wt + 20)
	-- local color = self.dialogue.color
	-- if color then
	-- 	local h, s, v = ColorToHSV(color)
	-- 	local coloffset = HSVToColor(h, math.max(0, s - .4), v)
	-- 	self.container:SetBackgroundColor(coloffset)
	-- 	self.m_bgHeaderColor = color
	-- end

	return self
end

function PANEL:DisplayTree(treeid)
	if not self.dialogue or not self.dialogue.tree then return end
	local tree = self.dialogue.tree[treeid]
	if not tree then return end

	self.buttons:AlphaTo(0, .2, 0, function()
		self.buttons:GetCanvas():Clear()
		self.buttons:AlphaTo(255, .2, 0)
		self.treeid = treeid

		local text = string.format(tree.speech or "{Missing Speech}", LocalPlayer():Name())
		self.speech:SetText(util.textWrap(text, self.speech:GetFont(), self:GetWide()))

		if tree.sound then
			if IsValid(self.npc) then
				self.npc:EmitSound(tree.sound, SNDLVL_IDLE, 100, 1, CHAN_VOICE)
			else
				surface.PlaySound(tree.sound)
			end
		end

		local options = tree.options or {}
		-- local showing = 0

		for i = 1, #options do
			local option = options[i]
			if option.CanShow and not option.CanShow() then continue end
			-- re.ui.Create("srp_button", function(btn)
			local btn = vgui.Create("MDialogueButton")
			btn:Dock(TOP)
			btn.id = i
			btn.option = option
			btn.controller = self
			btn:SetDesc(option.text)

			-- btn:LeftClick(self.ProcessRequest)
			btn.DoClick = function()
				self:ProcessRequest(btn)
			end

			btn:SetParent(self.buttons:GetCanvas())
			-- btn:SetContentAlignment(4)
			-- btn:DockPadding(10,5,5,5)
			-- btn:SetBackgroundColor(col.black)
			-- btn:SetHoverColor(col.col_grey)
		end
	end)

	self:SetTall(400)
	self:MoveTo(ScrW() / 2 - self:GetWide() / 2, ScrH() / 2 - self:GetTall() / 2, .5, 0, .5)
	self:AlphaTo(255, 1, 0)

	return self
end

-- function PANEL:Remove()
function PANEL:ProcessRequest(btn)
	local base = btn.controller
	local dialogue = base.dialogue
	local treeid = base.treeid
	if not dialogue or not treeid then return end
	local option = btn.option
	local close = option.close
	local click = option.OnClick
	local nxt = option.moveto
	local btn_id, npc = btn.id, base.npc

	if click then
		local fnxt = click(dialogue, LocalPlayer(), self.npc, treeid, option)
		nxt = nxt or fnxt
		timer.Simple(close and .4 or 0, function()
			re.dialogue.SendOnClick(dialogue.id, treeid, btn_id, npc)
		end)
	end

	if close then
		base:GetParent():AlphaTo(0, .4, _, function()
			base:GetParent():Remove()
		end)

		base:MoveTo(ScrW() / 2 - self:GetWide() / 2, ScrH(), .5, 0, .5)
	elseif nxt then
		base:DisplayTree(nxt)
	end
end

function PANEL:Paint(w, h)
end

vgui.Register("MDialogue", PANEL, "MPanel")

--[[
	MDialogueButton
]]
local PANEL = {}
AccessorFunc(PANEL, "Desc", "Desc")
AccessorFunc(PANEL, "Font", "Font")
AccessorFunc(PANEL, "Color", "Color")
AccessorFunc(PANEL, "OldColor", "OldColor")
AccessorFunc(PANEL, "Uppercase", "Uppercase")
AccessorFunc(PANEL, "Disabled", "Disabled")

function PANEL:Init()
	self:SetFont(luna.MontBase30)
	self:SetUppercase(true)
	self:SetCursor("hand")
	self:SetColor(Color(0, 0, 0, 0))
	self:SetText('')
end

function PANEL:SetDesc(text, nosize)
	if self:GetUppercase() then
		text = string.upper(util.textWrap(text, self:GetFont(), 600))
	end

	if not nosize then
		self:SetSize(surface.GetTextSize(text, self:GetFont()))
	end

	self.Desc = text
end

function PANEL:GetDesc(text)
	return self.Desc
end

function PANEL:SetColor(color)
	self:SetOldColor(self:GetColor() or color)
	self.Color = color
end

function PANEL:OnCursorEntered()
	self:SetColor(Color(0, 0, 0, 200))
end

function PANEL:OnCursorExited()
	self:SetColor(Color(0, 0, 0, 0))
end

local blur = Material("pp/blurscreen")

function PANEL:Paint(w, h)
	self:SetOldColor(LerpColor(0.1, self:GetOldColor(), self:GetColor()))
	local X, Y = 0, 0
	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)

	for i = 1, 5 do
		blur:SetFloat("$blur", (i / 3) * 5)
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		render.SetScissorRect(0, 0, 0 + w, 0 + h, true)
		surface.DrawTexturedRect(X * -1, Y * -1, ScrW(), ScrH())
		render.SetScissorRect(0, 0, 0, 0, false)
	end

	surface.SetFont(self:GetFont())
	local wt, _ = surface.GetTextSize(self:GetDesc())
	draw.RoundedBox(0, 0, 0, wt + 8, h, self:GetOldColor())
	surface.DrawShadowTexts(self:GetDesc(), self:GetFont(), 4, 4, COLOR_WHITE, COLOR_BLACK, TEXT_ALIGN_LEFT)
end

derma.DefineControl("MDialogueButton", "", PANEL, "DButton")