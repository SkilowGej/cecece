local cfg = GameMenu.cfg
local colw, colb = cfg.colors.white, cfg.colors.blue

local PANEL = {}

function PANEL:Init()
    self.desc = self:Add('DLabel')
    self.desc:SetSize(scale(900), scale(230))
    self.desc:SetY(scale(160))
    self.desc:SetFont('gm.1')
    self.desc:SetTextColor(cfg.colors.gray)
    self.desc:SetWrap(true)
    self.desc:SetContentAlignment(7)

    self.pnlTeam = self:Add( 'Panel' )
    self.pnlTeam:SetSize( scale(800), scale(400) )
    self.pnlTeam:SetY( self.desc:GetTall() + scale(200) )

    self.scroll = self.pnlTeam:Add( 'achievements.scroll' )

    self:UpdateLegionInfo()
end

function PANEL:UpdateLegionInfo()
    local p = LocalPlayer()
    local job = p:Team()
    local legion = nil

    for _, v in ipairs(GameMenu.legions) do
        for _, cat in ipairs(v.categories) do
            if cat.jobs[job] then
                legion = v
                break
            end
        end
        if legion then
            break
        end
    end

    if legion then
        self.desc:SetText(legion.desc)
        self.legionName = legion.name
        self:CreateCategories(legion.categories)
    else
        self.desc:SetText('Brak informacji o oddziale.')
        self.legionName = 'BEZ ODDZIAŁU'
    end
end

-- function PANEL:UpdateLegionInfo()
--     local p = LocalPlayer()
--     local job = p:Team()
--     local legion = nil

--     for _, v in ipairs(GameMenu.legions) do
--         if v.jobs[job] then
--             legion = v
--             break
--         end
--     end

--     if legion then
--         self.desc:SetText( legion.desc )
--         self.legionName = legion.name
--     else
--         self.desc:SetText( 'Нет информации о легионе.' )
--         self.legionName = 'БЕЗ ЛЕГИОНА'
--     end
-- end

function PANEL:CreateCategories(categories)
    for _, cat in ipairs(categories) do
        local members = {}
        for _, ply in ipairs(player.GetAll()) do
            if istable(cat.ranks) then
                if cat.ranks[ply:GetNWString("rating")] and cat.jobs[ply:Team()] then
                    table.insert(members, ply)
                end
            elseif cat.jobs[ply:Team()] then
                table.insert(members, ply)
            end
        end

        if #members > 0 then
            self.category = self.scroll:Add('gm.category')
            self.category.title = cat.title

            self.grid = vgui.Create( 'DIconLayout', self.category )
            self.grid:Dock(TOP)
            self.grid:DockMargin(0, scale(10), 0, 0)
            self.grid:SetSpaceY(scale(10))
            self.grid:SetSpaceX(scale(10))

            for _, member in ipairs(members) do
                local item = self.grid:Add('Panel')
                item:SetSize(scale(350), scale(80))

                item.Paint = function(s, w, h)
                    draw.NewRect( 0, 0, w, h, cfg.colors.black )

                    draw.SimpleText( self.legionName, 'gm.1', scale(10), h*.5 - scale(10), color_white, 0, 1 )
                    local myTeam = member:Team()
                    local myjob = FindJob( myTeam )
                    local jobName = myjob and myjob.Name or 'Brak'
                    draw.SimpleText( member:Nick().. ' • '.. jobName, 'gm.1', scale(10), h*.5 + scale(10), color_white, 0, 1 )

                    draw.RoundedBox( 8, w - scale(30), h*.5 - scale(10) * .5, scale(10), scale(10), cfg.colors.green )
                end
            end
        end
    end
end

function PANEL:Paint(w, h)
    draw.SimpleText(self.legionName .. ':', 'gm.4', 0, 0, colw, 0, 3)

    local p = LocalPlayer()
    local j = markup.Parse('<colour=' .. colw.r .. ',' .. colw.g .. ',' .. colw.b .. ',' .. colw.a .. '><font=gm.5>Postać «</colour></font><colour=' .. colb.r .. ',' .. colb.g .. ',' .. colb.b .. ',' .. colb.a .. '><font=gm.5>' .. p:Name() .. '</colour></font><colour=' .. colw.r .. ',' .. colw.g .. ',' .. colw.b .. ',' .. colw.a .. '><font=gm.5>»</colour></font>')
    j:Draw(0, scale(110), 0, 3)
end

vgui.Register('gm.tab.division', PANEL, 'EditablePanel')