local cfg = GameMenu.cfg
local colw, colb = cfg.colors.white, cfg.colors.blue
local PANEL = {}
function PANEL:Init()
    local p = LocalPlayer()
    local logic = p:GetNetVar('features') or {}
    for feature, status in pairs(logic) do
        if status then
            jobDesc = FEATURES_TO_NORMAL[feature].desc
            break
        end
    end

    if jobDesc then
        self.desc = self:Add('DLabel')
        self.desc:SetSize(scale(600), scale(200))
        self.desc:SetY(scale(160))
        self.desc:SetFont('gm.1')
        self.desc:SetTextColor(cfg.colors.gray)
        self.desc:SetText(jobDesc)
        self.desc:SetWrap(true)
        self.desc:SetContentAlignment(7)
    end

    self.pnl = self:Add('Panel')
    self.pnl:Dock(FILL)
    self.pnl:DockMargin(0, scale(360), 0, 0)
    self.grid = vgui.Create('DIconLayout', self.pnl)
    self.grid:Dock(FILL)
    self.grid:SetSpaceY(scale(10))
    self.grid:SetSpaceX(scale(10))
    for _, v in ipairs(cfg.stats) do
        self.item = self.grid:Add('Panel')
        self.item:SetSize(scale(400), scale(80))
        self.item.Paint = function(s, w, h)
            draw.NewRect(0, 0, w, h, cfg.colors.black)
            draw.Image(0, 0, h, h, v.image, cfg.colors.white2)
            local j = markup.Parse('<colour=' .. colw.r .. ',' .. colw.g .. ',' .. colw.b .. ',' .. colw.a .. '><font=gm.5>' .. v.name .. ' </colour></font><colour=' .. colb.r .. ',' .. colb.g .. ',' .. colb.b .. ',' .. colb.a .. '><font=gm.5>' .. v.check() .. '</colour></font>')
            j:Draw(w * .5, h * .5, 1, 1)
        end
    end

    self.warn = self.pnl:Add('DLabel')
    self.warn:Dock(BOTTOM)
    self.warn:SetTall(scale(150))
    self.warn:SetFont('gm.1')
    self.warn:SetTextColor(cfg.colors.gray)
    self.warn:SetText([[Wszystkie statystyki opierają się na Twoim doświadczeniu w grze, a nie na pojedynczej
postaci! Zostało to zrobione w celu optymalizacji, dziękujemy
za uwagę.]])
    self.warn:SetWrap(true)
    self.warn:SetContentAlignment(7)
end

function PANEL:Paint(w, h)
    local p = LocalPlayer()
    draw.SimpleText('POSTAĆ:', 'gm.4', 0, 0, colw, 0, 3)
    local myTeam = p:Team()
    local myjob = FindJob(myTeam)
    local jobName = myjob and myjob.Name or 'brak'
    local myname = p:Name()
    local j = markup.Parse('<colour=' .. colw.r .. ',' .. colw.g .. ',' .. colw.b .. ',' .. colw.a .. '><font=gm.5>' .. jobName .. ' «</colour></font><colour=' .. colb.r .. ',' .. colb.g .. ',' .. colb.b .. ',' .. colb.a .. '><font=gm.5>' .. myname .. '</colour></font><colour=' .. colw.r .. ',' .. colw.g .. ',' .. colw.b .. ',' .. colw.a .. '><font=gm.5>»</colour></font>')
    j:Draw(0, scale(110), 0, 3)
end

vgui.Register('gm.tab.char', PANEL, 'EditablePanel')