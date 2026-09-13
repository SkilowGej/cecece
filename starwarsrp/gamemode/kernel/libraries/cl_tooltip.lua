local itemWidth = ScrW() * .15
local PADDING = 12
local PADDING_HALF = PADDING * 0.5

local blur = Material("pp/blurscreen")

-- Draws a blurred material over the screen, to blur things.
function markup.drawBlur(panel, amount, passes)
	-- Intensity of the blur.
	amount = amount or 5

	if (useCheapBlur) then
		surface.SetDrawColor(50, 50, 50, amount * 20)
		surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
	else
		surface.SetMaterial(blur)
		surface.SetDrawColor(255, 255, 255)

		local x, y = panel:LocalToScreen(0, 0)

		for i = -(passes or 0.2), 1, 0.2 do
			-- Do things to the blur material to make it blurry.
			blur:SetFloat("$blur", i * amount)
			blur:Recompute()

			-- Draw the blur material over the screen.
			render.UpdateScreenEffectTexture()
			surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
		end
	end
end

hook.Add("TooltipInitialize", "reItemTooltip", function(self, panel)
	self.markupObject = markup.parse(self:GetText(), panel.reTooltipWide or 200)
	self:SetText("")
	self:SetWide(self.markupObject:getWidth() + PADDING)
	self:SetHeight(self.markupObject:getHeight() + PADDING)
	self:SetAlpha(0)
	self:AlphaTo(255, 0.2, 0)
	self.isItemTooltip = true
end)

hook.Add("TooltipPaint", "reItemTooltip", function(self, w, h)
	if self.isItemTooltip then
		markup.drawBlur(self, 2, 2)
		-- surface.SetDrawColor(0, 0, 0, 200)
		-- surface.DrawRect(0, 0, w, h)

		draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 200))

		if self.markupObject then
			self.markupObject:draw(PADDING_HALF, PADDING_HALF + 2)
		end

		return true
	end
end)

hook.Add("TooltipLayout", "reItemTooltip", function(self)
	if self.isItemTooltip then return true end
end)

local tooltip_delay = 0.01
local PANEL = {}

function PANEL:Init()
	self:SetDrawOnTop(true)
	self.DeleteContentsOnClose = false
	self:SetText("")
end

function PANEL:UpdateColours(skin)
	return self:SetTextStyleColor(color_black)
end

function PANEL:SetContents(panel, bDelete)
	panel:SetParent(self)
	self.Contents = panel
	self.DeleteContentsOnClose = bDelete or false
	self.Contents:SizeToContents()
	self:InvalidateLayout(true)
	self.Contents:SetVisible(false)
end

function PANEL:PerformLayout()
	local override = hook.Run("TooltipLayout", self)

	if not override then
		if self.Contents then
			self:SetWide(self.Contents:GetWide() + 8)
			self:SetTall(self.Contents:GetTall() + 8)
			self.Contents:SetPos(4, 4)
		else
			local w, h = self:GetContentSize()
			self:SetSize(w + 8, h + 6)
			self:SetContentAlignment(5)
		end
	end
end

function PANEL:PositionTooltip()
	if not IsValid(self.TargetPanel) then
		self:Remove()

		return
	end

	self:PerformLayout()
	local x, y = input.GetCursorPos()
	local w, h = self:GetSize()
	local lx, ly = self.TargetPanel:LocalToScreen(0, 0)

	if self.TargetPanel.reTooltipNotFix then
		y = y - 20
		y = math.min(y, y - h)
	else
		y = y - 50
		y = math.min(y, ly - h * 1.1)
	end

	if y < 2 then
		y = 2
	end

	-- Fixes being able to be drawn off screen
	self:SetPos(math.Clamp(x - w * 0.5, 0, ScrW() - self:GetWide()), math.Clamp(y, 0, ScrH() - self:GetTall()))
end

function PANEL:Paint(w, h)
	self:PositionTooltip()
	local override = hook.Run("TooltipPaint", self, w, h)

	if not override then
		derma.SkinHook("Paint", "Tooltip", self, w, h)
	end
end

function PANEL:OpenForPanel(panel)
	self.TargetPanel = panel
	self:PositionTooltip()
	hook.Run("TooltipInitialize", self, panel)

	if tooltip_delay > 0 then
		self:SetVisible(false)

		timer.Simple(tooltip_delay, function()
			if not IsValid(self) then return end
			if not IsValid(panel) then return end
			self:PositionTooltip()
			self:SetVisible(true)
		end)
	end
end

function PANEL:Close()
	if not self.DeleteContentsOnClose and self.Contents then
		self.Contents:SetVisible(false)
		self.Contents:SetParent(nil)
	end

	self:Remove()
end

derma.DefineControl("DTooltip", "", PANEL, "DLabel")