local cfg = GameMenu.cfg

local PANEL = {}

AccessorFunc(PANEL, 'm_body', 'Body')

function PANEL:Init()
    self.Scroll = self:Add('DScrollPanel')
    self.Scroll:Dock(FILL)
    self.Scroll.VBar:SetWide(0)

	local fr = self.Scroll:GetParent()
	self.Scroll.parent = fr:GetParent()

    self.Sidebar = {}
    self.Panels = {}
end

function PANEL:CreatePanel(name, panelClass, func)
    tbl = tbl or {}

    local btn = self.Scroll:Add('DButton')
    btn:Dock(TOP)
    btn:DockMargin(0, 0, 0, scale(10))

    btn.Name = name
    btn.Tbl = tbl
    btn.PanelClass = panelClass

    btn:SetTall( scale(40) )
    btn:SetText''

    btn.textOffset = 0
    btn.color = cfg.colors.white
    btn.targetColor = cfg.colors.white
    btn.isActive = false

    btn.Paint = function(pnl, w, h)
        local active = self.Active
        if pnl.Id == active then
            pnl.targetColor, pnl.isActive = cfg.colors.blue, true
        elseif pnl:IsHovered() then
            pnl.targetColor = cfg.colors.blue
        else
            pnl.targetColor, pnl.isActive = cfg.colors.white, false
        end
        pnl.color = LerpColor(FrameTime() * 10, pnl.color, pnl.targetColor)

        local targetOffset = (pnl:IsHovered() or pnl.isActive) and scale(15) or 0
        pnl.textOffset = Lerp(FrameTime() * 10, pnl.textOffset, targetOffset)

        local displayText = (pnl:IsHovered() or pnl.isActive) and ("• " .. name) or name

        draw.SimpleText(displayText, 'gm.3', scale(15) + pnl.textOffset, h * 0.5, pnl.color, 0, 1)

		return true
    end

    btn.DoClick = function(pnl)
        if func then
            func()
            return
        end
    
        self:SetActive(pnl.Id) 
    end

    local body = self:GetBody():Add(panelClass or 'Panel')
    body:Dock(FILL)
    body.Data = tbl
    body:SetVisible(false)

    if body.SetData then body:SetData(tbl) end

    local bodyId = table.insert(self.Panels, body)
    self.Panels[bodyId].Id = bodyId
    local id = table.insert(self.Sidebar, btn)
    self.Sidebar[id].Id = id
end

function PANEL:SetActive(id)
    local active = self.Active
    self.Active = id
    if IsValid(self.Sidebar[active]) then
        if IsValid(self.Panels[active]) then self.Panels[active]:SetVisible(false) end
    end

    if IsValid(self.Sidebar[id]) then

		if IsValid(self.Panels[id]) then
            if self.Panels[id].Data.recreateOnSwitch and id ~= active then
                local tempData = self.Panels[id].Data
                local tempId = self.Panels[id].Id
                self.Panels[id]:Remove()
                self.Panels[id] = self:GetBody():Add(self.Sidebar[id].PanelClass or 'DPanel')
                self.Panels[id]:Dock(FILL)
                self.Panels[id].Data = tempData
                self.Panels[id].Id = tempId
            else
                self.Panels[id]:SetVisible(true)
            end

            if self.Panels[id].OnSwitchedTo then self.Panels[id]:OnSwitchedTo(self.Panels[id].Data) end
        end
    end
end

function PANEL:SetActiveByName(name)
    for i, v in ipairs(self.Sidebar) do
        if v.Name == name then
            self:SetActive(i)
            break
        end
    end
end

vgui.Register( 'gm.sidebar', PANEL, 'EditablePanel' )