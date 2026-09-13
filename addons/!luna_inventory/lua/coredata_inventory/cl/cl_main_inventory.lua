--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

-- когда нибудь я изменю это и мне будет не стыдно, но явно не на этой неделе
local scrw, scrh = ScrW(), ScrH()
local sw, sh = ScrW(), ScrH()
local LOOK_AT, CAMPOS, ANGLE_DEFAULT = Vector(5, 0, 55), Vector(150, 35, 55), Angle(0, 0, 0)
local math_Round = math.Round
local draw_RoundedBox = draw.RoundedBox
local draw_DrawText = draw.DrawText
local surface_font = surface.SetFont
local draw_SimpleText = draw.SimpleText
local net_Start = net.Start
local net_WriteString = net.WriteString
local net_WriteInt = net.WriteInt
local net_WriteUInt = net.WriteUInt
local net_SendToServer = net.SendToServer
local cmd = concommand.Add
local dragndrop_GetDroppable = dragndrop.GetDroppable
local surface_SetMaterial = surface.SetMaterial
local surface_SetDrawColor = surface.SetDrawColor
local surface_DrawTexturedRect = surface.DrawTexturedRect
local direct_light, ambient_light = Color(220, 190, 100), Color(10, 15, 50)
local Material = Material
local DisableClipping = DisableClipping
local RunConsoleCommand = RunConsoleCommand
local Color = Color
local FrameTime = FrameTime
local surface_DrawTexturedRectRotated = surface.DrawTexturedRectRotated
-- local cache_w = {}
local cache_h = {}
local base_h = ScrH() / 1080
local function RotatedBox(pnl, w, h, ang, col2)
    local m = Matrix()
    local x, y = pnl:LocalToScreen(w / 2, h / 2)
    local center = Vector(x, y, 0)
    m:Translate(center)
    m:Rotate(Angle(0, ang, 0))
    m:Translate(-center)
    render.PushFilterMag(TEXFILTER.ANISOTROPIC)
    render.PushFilterMin(TEXFILTER.ANISOTROPIC)
    cam.PushModelMatrix(m)
    draw.RoundedBox(16, 0, 0, w, h, col2)
    cam.PopModelMatrix()
    render.PopFilterMag()
    render.PopFilterMin()
end

local draw_Icon = draw_Icon or function(x, y, h, h, Mat, tblColor)
    surface_SetMaterial(Mat)
    surface_SetDrawColor(tblColor or Color(255, 255, 255, 255))
    surface_DrawTexturedRect(x, y, h, h)
end

local function h(px)
    if cache_h[px] then
        return cache_h[px]
    else
        local result = math_Round(px * base_h)
        cache_h[px] = result
        return result
    end
end

hook.Add('OnScreenSizeChanged', 'sizescreen', function() scrw, scrh = ScrW() / 1920, ScrH() / 1080 end)
local function doaction(act, x, y, acw)
    if not act or not x or not y or not acw then return end
    net_Start('inventory_action')
    net_WriteString(act)
    net_WriteInt(x, 6)
    net_WriteInt(y, 6)
    net_WriteString(acw)
    net_SendToServer()
end

local ui = ui or {
    cols = {
        empty = Color(21, 22, 30, 255 * .45),
        filled = Color(30, 32, 45, 255 * .75),
        whitehover = Color(150, 150, 150, 150),
        white = Color(255, 255, 255),
        text = Color(167, 167, 167),
        emptyhover = Color(75, 75, 75),
        kgtext = Color(45, 120, 255),
        but = Color(26, 26, 26, 255 * .85),
        slothover = Color(53, 54, 60, 255 * .65),
        filledhover = Color(128, 128, 130, 255),
        invred = Color(255, 45, 45),
    },
    weps = {
        dc15s = Material('luna_menus/inventory/dc-15s.png', 'mips noclamp smooth'),
        sb2 = Material('luna_icons/entities/rw_sw_dp23.png', 'mips noclamp smooth'),
        dc17m = Material('luna_icons/entities/tfa_swch_dc17m_br.png', 'mips noclamp smooth'),
        dc17dual = Material('luna_icons/entities/rw_sw_dual_dc17.png', 'mips noclamp smooth'),
        dc15x = Material('luna_icons/entities/rw_sw_dc15x.png', 'mips noclamp smooth'),
        rps6 = Material('luna_icons/entities/rw_sw_rps6.png', 'mips noclamp smooth'),
        nt242 = Material('luna_icons/entities/rw_sw_nt242.png', 'mips noclamp smooth'),
        valken = Material('luna_icons/entities/rw_sw_valkenx38a.png', 'mips noclamp smooth'),
        iqa11 = Material('luna_icons/entities/rw_sw_iqa11.png', 'mips noclamp smooth'),
        cr2 = Material('luna_icons/entities/rw_sw_cr2.png', 'mips noclamp smooth'),
        westarm5 = Material('luna_icons/entities/rw_sw_westarm5.png', 'mips noclamp smooth'),
        bomb = Material('luna_icons/entities/rw_sw_nade_impact.png', 'mips noclamp smooth'),
        mine = Material('luna_icons/entities/rw_sw_nade_thermal.png', 'mips noclamp smooth'),
        dc17ml = Material('luna_icons/entities/tfa_swch_dc17m_at.png', 'mips noclamp smooth'),
        de10 = Material('luna_menus/inventory/de10.png', 'mips noclamp smooth'),
        dc15a = Material('luna_menus/inventory/dc-15a.png', 'mips noclamp smooth'),
        dc17 = Material('luna_menus/inventory/dc-17.png', 'mips noclamp smooth'),
        detonator = Material('luna_menus/inventory/detonator.png', 'mips noclamp smooth'),
        medpack = Material('luna_menus/inventory/med-pack.png', 'mips noclamp smooth'),
        helmet19 = Material('luna_menus/hud/classes/19.png', 'mips noclamp smooth'),
        z6 = Material('luna_menus/inventory/z6.png', 'mips noclamp smooth'),
        saber = Material('luna_menus/inventory/saber.png', 'mips noclamp smooth'),
        fists = Material('luna_menus/inventory/fists.png', 'mips noclamp smooth'),
        splies = Material('luna_icons/spanner.png', 'mips noclamp smooth'),
        knife = Material('luna_icons/bowie-knife.png', 'mips noclamp smooth'),
        btrs = Material('luna_icons/entities/rw_sw_tusken_cycler.png', 'mips noclamp smooth'),
        bactagrenade = Material('luna_icons/entities/rw_sw_nade_bacta.png', 'mips noclamp smooth'),
        medic = Material('luna_icons/med-pack.png', 'mips noclamp smooth'),
        bandage = Material('luna_icons/bandage-roll.png', 'mips noclamp smooth'),
        defib = Material('luna_icons/entities/power.png', 'mips noclamp smooth'),
        fixator = Material('luna_icons/tinker.png', 'mips noclamp smooth'),
        handcuffs = Material('luna_icons/handcuffs.png', 'mips noclamp smooth'),
        fusion = Material('luna_icons/screwdriver.png', 'mips noclamp smooth'),
        grenade1 = Material('luna_icons/stun-grenade.png', 'mips noclamp smooth'),
        grenade2 = Material('luna_icons/flash-grenade.png', 'mips noclamp smooth'),
        grenade3 = Material('luna_icons/grenade.png', 'mips noclamp smooth'),
        armor = Material('luna_icons/overdrive.png', 'mips noclamp smooth'),
        tablet = Material('luna_icons/smartphone.png', 'mips noclamp smooth'),
        camo = Material('luna_icons/spy.png', 'mips noclamp smooth'),
        squad = Material('luna_icons/reactor.png', 'mips noclamp smooth'),
        binos = Material('luna_icons/binoculars.png', 'mips noclamp smooth'),
        shield = Material('luna_icons/riot-shield.png', 'mips noclamp smooth'),
        hooks = Material('luna_icons/grapple.png', 'mips noclamp smooth'),
    },
    mats = {
        empty = Material('luna_menus/inventory/empty.png', 'mips noclamp smooth'),
        background = Material('luna_ui_base/fon.png', 'mips noclamp smooth'),
        logo = Material('luna_sup_brand/sup_logo_var1.png', 'mips noclamp smooth'),
        logo2 = Material('luna_sup_brand/luna-core.png', 'mips noclamp smooth'),
        close = Material('luna_ui_base/off.png', 'mips noclamp smooth'),
        settings = Material('luna_ui_base/settings.png', 'mips noclamp smooth'),
        circle = Material('luna_ui_base/circle-element2.png', 'mips noclamp smooth'),
        glow = Material('sprites/light_glow02_add', 'mips noclamp smooth'),
    },
    inv = {},
    weight = 0,
}

function sup_inv.GetItems()
    return ui.inv
end

local selec = {
    {
        x = 600,
        y = 850,
        sx = 110,
        sy = 110,
        type = 'ammo',
        p = function(me, ww, hh)
            DisableClipping(true)
            draw_DrawText('twoja\namunicja', 'sup_inv.desc', ww * .5, hh * .99 + h(25), ui.cols.text, 1, 1)
            draw_RoundedBox(6, ww * 1.5 - h(115), -h(75), h(250), h(4), ColorAlpha(ui.cols.text, 255 * .5))
            DisableClipping(true)
        end
    },
    {
        x = 600,
        y = 525,
        sx = 110,
        sy = 110,
        type = 'heavy',
        p = function(me, ww, hh)
            DisableClipping(true)
            draw_DrawText('ciężka\broń', 'sup_inv.desc', ww * .5, hh * .99 + h(25), ui.cols.text, 1, 1)
            DisableClipping(true)
        end
    },
    {
        x = 850,
        y = 525,
        sx = 110,
        sy = 110,
        type = 'var',
        p = function(me, ww, hh)
            DisableClipping(true)
            draw_DrawText('różna\nbroń', 'sup_inv.desc', ww * .5, hh * .99 + h(25), ui.cols.text, 1, 1)
            DisableClipping(true)
        end
    },
    {
        x = 600,
        y = 300,
        sx = 110,
        sy = 110,
        type = 'main',
        p = function(me, ww, hh)
            DisableClipping(true)
            draw_DrawText('główna\nbroń', 'sup_inv.desc', ww * .5, hh * .99 + h(25), ui.cols.text, 1, 1)
            DisableClipping(true)
        end
    },
    {
        x = 850,
        y = 850,
        sx = 110,
        sy = 110,
        type = 'consum',
        p = function(me, ww, hh)
            DisableClipping(true)
            draw_DrawText('zużywane\nzapasy', 'sup_inv.desc', ww * .5, hh * .99 + h(25), ui.cols.text, 1, 1)
            DisableClipping(true)
        end
    },
    {
        x = 850,
        y = 300,
        sx = 110,
        sy = 110,
        type = 'secondary',
        p = function(me, ww, hh)
            DisableClipping(true)
            draw_DrawText('drugorzędna\nbroń', 'sup_inv.desc', ww * .5, hh * .99 + h(25), ui.cols.text, 1, 1)
            DisableClipping(true)
        end
    },
    {
        x = 1700,
        y = 850,
        sx = 110,
        sy = 110,
        type = 'trashbin',
        nodraw = true,
        p = function(me, ww, hh)
            DisableClipping(true)
            draw_DrawText('usunąć\nprzedmiot', 'sup_inv.desc', ww * .5, hh * .99 + h(25), ui.cols.text, 1, 1)
            DisableClipping(false)
            draw_Icon(0, 0, ww, hh, ui.mats.empty)
        end
    },
}

local function move(oldx, oldy, newx, newy, class)
    net_Start('inventory_move')
    net_WriteString(class)
    net_WriteUInt(oldx, 6)
    net_WriteUInt(oldy, 6)
    net_WriteUInt(newx, 6)
    net_WriteUInt(newy, 6)
    net_SendToServer()
end

local function doreceive(self, panels, drop)
    if drop and self.type == 'trashbin' then doaction('equip', panels[1].XX, panels[1].YY, self.type) end
    if drop and panels[1].weptype == self.type then
        surface.PlaySound('sound/luna_ui/click3.wav')
        for _, v in pairs(panels) do
            doaction('equip', v.XX, v.YY, self.type)
        end
    end
end

local function domove(self, pnls, drop)
    if drop and pnls[1].type then
        net_Start('inventory_action2')
        net_WriteString('unequip')
        net_WriteString(pnls[1].type)
        net_SendToServer()
        return
    end

    if not self.XX then return end
    if not pnls[1].XX then return end
    if drop and self.XX and pnls[1].XX then
        local pn = pnls[1]
        local pxx, pyy = pn.XX, pn.YY
        local sx, sy = self.XX, self.YY
        move(pxx, pyy, sx, sy, pn.ITEM.class)
    end
end

local setDrawColor = surface.SetDrawColor
local drawOutlinedRect = surface.DrawOutlinedRect
local function DrawOutlinedBox(x, y, h, h, thickness, col)
    setDrawColor(col.r, col.g, col.b, col.a)
    for i = 0, thickness - 1 do
        drawOutlinedRect(x + i, y + i, h - i * 2, h - i * 2)
    end
end

local ipairs = ipairs
local setTexture = surface.SetTexture
local drawPoly = surface.DrawPoly
local drawRect = surface.DrawRect
local roundedBoxCache = {}
local whiteTexture = surface.GetTextureID('vgui/white')
local function DrawOutlinedRoundedBox(borderSize, x, y, h, h, col, thickness)
    thickness = thickness or 1
    setDrawColor(col.r, col.g, col.b, col.a)
    if borderSize <= 0 then
        DrawOutlinedBox(x, y, h, h, thickness, col)
        return
    end

    local fullRight = x + h
    local fullBottom = y + h
    local left, right = x + borderSize, fullRight - borderSize
    local top, bottom = y + borderSize, fullBottom - borderSize
    local halfBorder = borderSize * .6
    local width, height = h - borderSize * 2, h - borderSize * 2
    drawRect(x, top, thickness, height) --Left
    drawRect(x + h - thickness, top, thickness, height) --Right
    drawRect(left, y, width, thickness) --Top
    drawRect(left, y + h - thickness, width, thickness) --Bottom
    local cacheName = borderSize .. x .. y .. h .. h .. thickness
    local cache = roundedBoxCache[cacheName]
    if not cache then
        cache = {
            {
                --Top Right
                {
                    x = right, --Outer
                    y = y
                },
                {
                    x = right + halfBorder,
                    y = top - halfBorder
                },
                {
                    x = fullRight,
                    y = top
                },
                {
                    x = fullRight - thickness, --Inner
                    y = top
                },
                {
                    x = right + halfBorder - thickness,
                    y = top - halfBorder + thickness
                },
                {
                    x = right,
                    y = y + thickness
                }
            },
            {
                --Bottom Right
                {
                    x = fullRight, --Outer
                    y = bottom
                },
                {
                    x = right + halfBorder,
                    y = bottom + halfBorder
                },
                {
                    x = right,
                    y = fullBottom
                },
                {
                    x = right, --Inner
                    y = fullBottom - thickness
                },
                {
                    x = right + halfBorder - thickness,
                    y = bottom + halfBorder - thickness
                },
                {
                    x = fullRight - thickness,
                    y = bottom
                }
            },
            {
                --Bottom Left
                {
                    x = left, --Outer
                    y = fullBottom
                },
                {
                    x = left - halfBorder,
                    y = bottom + halfBorder
                },
                {
                    x = x,
                    y = bottom
                },
                {
                    x = x + thickness, --Inner
                    y = bottom
                },
                {
                    x = left - halfBorder + thickness,
                    y = bottom + halfBorder - thickness
                },
                {
                    x = left,
                    y = fullBottom - thickness
                },
            },
            {
                --Top Left
                {
                    x = x, --Outer
                    y = top
                },
                {
                    x = left - halfBorder,
                    y = top - halfBorder
                },
                {
                    x = left,
                    y = y
                },
                {
                    x = left, --Inner
                    y = y + thickness
                },
                {
                    x = left - halfBorder + thickness,
                    y = top - halfBorder + thickness
                },
                {
                    x = x + thickness,
                    y = top
                }
            }
        }

        roundedBoxCache[cacheName] = cache
    end

    setTexture(whiteTexture)
    for k, v in ipairs(cache) do
        drawPoly(v)
    end
end

local curlerp = 0
local panels = {}
local refresh = function()
    if IsValid(ui.fr) then
        if IsValid(ui.kglbl) then
            ui.kglbl:Remove()
            ui.kgdesc:Remove()
        end

        for _, v in ipairs(ui.fr:GetChildren()) do
            if v.type ~= nil then v:Remove() end
        end

        local fr = ui.fr
        local kglabel = fr:Add('DLabel')
        kglabel:SetText('Twój ekwipunek')
        kglabel:SetFont('sup_inv.maininv')
        kglabel:SetPos(h(30), h(125))
        kglabel:SetMouseInputEnabled(false)
        kglabel:SizeToContents()
        kglabel.color = color_white
        function kglabel:Paint(_, hh)
            local ft = FrameTime()
            self.color = ui.weight > sup_inv.MAXWEIGHT and LerpColor(6 * ft, self.color, ui.cols.invred) or LerpColor(6 * ft, self.color, color_white)
            self:SetTextColor(self.color)
            DisableClipping(true)
            surface_font('sup_inv.kg_desc')
            curlerp = Lerp(ft * 4, curlerp, ui.weight)
            local tw, th = draw_SimpleText('Obciążenie: ', 'sup_inv.kg_desc', self:GetX() - h(30), hh + h(7), ui.cols.kgtext)
            draw_SimpleText(math_Round(curlerp) .. '/' .. sup_inv.MAXWEIGHT, 'sup_inv.kg_small', tw, th + h(22), ui.cols.white)
            DisableClipping(false)
        end

        local kgdesc = fr:Add('DLabel')
        kgdesc:SetText([[W przypadku przekroczenia limitu obciążenia ekwipunku osobistego Twoja
postać otrzyma zmniejszenie prędkości poruszania się!

Rozmieszczaj rzeczy osobiste, amunicję i broń w sposób racjonalny.]])
        kgdesc:SetFont('sup_inv.desc')
        kgdesc:SetPos(h(30), h(170))
        kgdesc:SetMouseInputEnabled(false)
        kgdesc:SetColor(Color(255, 255, 255))
        kgdesc:SetWrap(true)
        kgdesc:SetSize(h(500), h(150))
        ui.kglbl = kglabel
        ui.kgdesc = kgdesc
    end

    for _, v in pairs(selec) do
        local fr = ui.fr
        local sel = fr:Add('DPanel')
        sel.OnMousePressed = v.func or nil
        sel:SetPos(h(v.x + 50), h(v.y))
        sel:SetSize(h(v.sx), h(v.sy))
        sel:SetCursor('hand')
        sel.color = ui.cols.empty
        sel.nodraw = v.nodraw or false
        sel:Receiver('sup_inv', doreceive)
        function sel:Paint(ww, hh)
            v.p(me, ww, hh)
            local ft = FrameTime()
            local drop = dragndrop_GetDroppable()
            self.color = self:IsHovered() and LerpColor(10 * ft, self.color, ui.cols.slothover) or LerpColor(10 * ft, self.color, ui.cols.empty)
            if drop and v.type ~= 'trashbin' then self.color = drop[1].weptype ~= v.type and LerpColor(3 * ft, self.color, Color(225, 73, 73, 194)) or LerpColor(3 * ft, self.color, Color(17, 128, 232, 195)) end
            RotatedBox(self, ww, hh, 45, self.color)
            if not self.nodraw then draw_SimpleText('+', 'sup_inv.maininv', ww * .5, hh * .5, color_white, 1, 1) end
        end

        sel.type = v.type or nil
        if ui.equip and ui.equip[sel.type] then
            sel.OnMousePressed = nil
            local drag = sel:Add('DPanel')
            drag:SetSize(h(111), h(111))
            drag:Droppable('sup_inv')
            drag:SetCursor('hand')
            function drag:Paint(ww, hh)
                if not ui.equip[sel.type] then
                    sel:Remove()
                    drag:Remove()
                end

                local ft = FrameTime()
                sel.color = self:IsHovered() and LerpColor(10 * ft, sel.color, ui.cols.slothover) or LerpColor(10 * ft, sel.color, ui.cols.empty)
                draw_Icon(0, 0, ww, hh, ui.weps[ui.equip[sel.type].icon] or ui.mats.empty)
                sel.nodraw = true
            end

            drag.type = sel.type
        end
    end

    ui.addpnl:Clear()
    panels = {}
    local addpnl = ui.addpnl
    local cols = LocalPlayer():GetNW2Int('supinv.maxslots', 5)
    local rows = LocalPlayer():GetNW2Int('supinv.maxslots', 5)
    local spacing = 1
    local totalSpacingX = (cols + 1) * spacing
    local totalSpacingY = (rows + 1) * spacing
    local slotWidth = (addpnl:GetWide() - totalSpacingX) / cols
    local slotHeight = (addpnl:GetTall() - totalSpacingY) / rows
    for y = 1, rows do
        for x = 1, cols do
            slot = addpnl:Add('DPanel')
            slot.XX = x
            slot.YY = y
            slot:SetSize(slotWidth, slotHeight)
            slot:SetPos((x - 1) * (slotWidth + spacing) + spacing, (y - 1) * (slotHeight + spacing) + spacing)
            function slot:Paint(ww, hh)
                draw.RoundedBox(8, 0, 0, ww, hh, Color(15, 15, 15, 182))
            end

            slot:Receiver('sup_inv', domove)
            panels[y * cols + x] = slot
        end
    end

    for y = 1, rows do
        for x = 1, cols do
            local item = ui.inv[y] and ui.inv[y][x] or nil
            if item then
                local item2 = item
                if not item.class then continue end
                item = sup_inv.NewItem(item.class)
                if not item then continue end
                local maincolor = Color(15, 15, 15, 100)
                local itemPanel = addpnl:Add('DPanel')
                itemPanel:SetCursor('hand')
                itemPanel.weptype = item.weptype
                itemPanel.XX = x
                itemPanel.YY = y
                itemPanel.ITEM = item
                itemPanel:Droppable('sup_inv')
                itemPanel:SetZPos(32767)
                itemPanel:SetSize(slotWidth, slotHeight)
                itemPanel:SetPos((x - 1) * (slotWidth + spacing) + spacing, (y - 1) * (slotHeight + spacing) + spacing)
                itemPanel.color = ui.cols.empty
                itemPanel.maincolor = maincolor
                local icon = itemPanel:Add('DImage')
                icon:SetMaterial(ui.weps[item:GetIcon()] or ui.mats.empty)
                icon:SetSize(itemPanel:GetWide(), itemPanel:GetTall())
                icon:SetZPos(-999)
                icon:SetMouseInputEnabled(false)
                icon.m = icon.Paint
                icon.color = ui.cols.filled
                function icon:Paint(ww, hh)
                    local ft = FrameTime()
                    self.color = itemPanel:IsHovered() and LerpColor(10 * ft, self.color, ui.cols.filledhover) or LerpColor(10 * ft, self.color, ui.cols.filled)
                    draw_RoundedBox(12, 0, 0, ww, hh, self.color)
                    DrawOutlinedRoundedBox(10, 0, 0, ww, hh, Color(255, 255, 255, 150), 1)
                    icon.m(self, ww, hh)
                end

                function itemPanel:Paint(ww, hh)
                    draw.RoundedBox(0, 0, 0, ww, hh, Color(15, 15, 15, 100))
                end

                itemPanel.OnStartDragging = function(me)
                    draggable = me
                    me:SetVisible(false)
                end

                itemPanel.OnStopDragging = function(me)
                    draggable = nil
                    me:SetVisible(true)
                end

                local kg = itemPanel:Add('DLabel')
                kg:SetText(Format('%d%s', item2.kg * (item2.amount or 1), 'kg'))
                kg:SetFont('sup_inv.name')
                kg:Dock(FILL)
                kg:SetContentAlignment(7)
                kg:SetMouseInputEnabled(false)
                kg:DockMargin(h(10), 0, 0, 0)
                if item2.amount then
                    local am = itemPanel:Add('DLabel')
                    am:SetText(item2.amount)
                    am:SetFont('sup_inv.name')
                    am:Dock(FILL)
                    am:SetContentAlignment(1)
                    am:DockMargin(h(10), 0, 0, 10)
                    am:SetMouseInputEnabled(false)
                    am:SetColor(Color(255, 255, 255))
                end

                local name = itemPanel:Add('DLabel')
                name:SetText(item:GetName())
                name:SetFont('sup_inv.name')
                name:Dock(FILL)
                name:SetContentAlignment(1)
                name:SetMouseInputEnabled(false)
                name:DockMargin(h(10), 0, 0, 0)
                panels[y * cols + x] = itemPanel
            end
        end
    end
end

local function adminmenu()
    if IsValid(ui.admingive) then return end
    local pnl = vgui.Create('DFrame')
    pnl:SetSize(h(1200), h(800))
    pnl:SetAlpha(0)
    pnl:AlphaTo(255, .3)
    pnl:Center()
    pnl:SetSizable(true)
    pnl:SetTitle('')
    pnl:ShowCloseButton(false)
    pnl:MakePopup()
    ui.admingive = pnl
    local close = pnl:Add('DButton')
    close:SetText('✕')
    close:SetTextColor(Color(215, 215, 215, 230))
    close:SetSize(h(50), h(30))
    close:SetPos(h(260), 0)
    close:SetFont('sup_inv.selectorr')
    close.color = Color(215, 215, 215, 230)
    pnl.closeb = close
    local title = pnl:Add('DLabel')
    title:SetPos(h(15), h(5))
    title:SetText('ADMIN MENU')
    title:SetFont('sup_inv.selectorr')
    title:SizeToContents()
    function close:Paint()
        local ft = FrameTime()
        self.color = self:IsHovered() and LerpColor(ft * 6, self.color, Color(229, 8, 8, 230)) or LerpColor(ft * 6, self.color, Color(215, 215, 215, 230))
        self:SetTextColor(self.color)
    end

    function close:DoClick()
        pnl:AlphaTo(0, .3, 0, function() pnl:Remove() end)
    end

    function pnl:Paint(ww, hh)
        draw_RoundedBox(0, 0, 0, ww, hh, Color(15, 15, 15, 230))
    end

    local searchBar = pnl:Add('DTextEntry')
    searchBar:SetPos(h(15), h(40))
    searchBar:SetSize(h(270), h(30))
    searchBar:SetPlaceholderText('Поиск...')
    searchBar:SetFont('sup_inv.kg_small')
    searchBar:SetUpdateOnType(true)
    searchBar.Paint = function(self, w, h)
        draw_RoundedBox(4, 0, 0, w, h, Color(20, 20, 20, 255))
        self:DrawTextEntryText(Color(200, 200, 200, 255), Color(120, 120, 215, 255), Color(200, 200, 200, 255))
        if self:GetPlaceholderText() and self:GetText() == '' then draw_SimpleText(self:GetPlaceholderText(), self:GetFont(), 5, h / 2, Color(150, 150, 150, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) end
    end

    pnl.se = searchBar
    function pnl:PerformLayout()
        self.closeb:SetPos(self:GetWide() - h(45))
        local swidth = self:GetWide() - h(60)
        self.se:SetWide(swidth)
        self.se:SetPos((self:GetWide() - swidth) / 2, self.se:GetY())
    end

    local dock = pnl:Add('DScrollPanel')
    dock:Dock(FILL)
    dock:DockMargin(0, h(65), 0, 0)
    dock.VBar:SetWide(8)
    dock.VBar:SetHideButtons(true)
    local iconv = dock:Add('DIconLayout')
    iconv:Dock(FILL)
    iconv:SetSpaceX(5)
    iconv:SetSpaceY(5)
    local function AnimateEntry(entry)
        entry:SetAlpha(0)
        entry:AlphaTo(255, 0.2, 0)
    end

    local function PopulateItems(filter)
        iconv:Clear()
        for _, i in pairs(sup_items) do
            if string.Trim(filter) == '' or string.find(string.lower(i.nicename), string.lower(filter)) then
                local back = iconv:Add('DButton')
                back:SetText('')
                back:SetSize(h(112), h(112))
                back:SetTooltip(Format('Nazwa: %s\nKlasa: %s\nTyp: %s\nIkona: %s', i.nicename, i.class, i.type, i.icon))
                back.color = Color(15, 15, 15, 230)
                function back:DoClick()
                    RunConsoleCommand('sup_additem', i.class)
                    notification.AddLegacy(Format('W twoim ekwipunku został dodany przedmiot: %s (%s)', i.nicename, i.class), NOTIFY_GENERIC, 5)
                end

                function back:Paint(ww, hh)
                    local ft = FrameTime()
                    self.color = self:IsHovered() and LerpColor(6 * ft, self.color, Color(144, 144, 144, 230)) or LerpColor(6 * ft, self.color, Color(15, 15, 15, 230))
                    draw_RoundedBox(0, 0, 0, ww, hh, self.color)
                    draw_SimpleText(i.nicename, 'sup_inv.name', ww * .5, hh * .85, Color(216, 216, 216, 230), TEXT_ALIGN_CENTER)
                end

                local mat
                if ui.weps[i.icon] and ui.weps[i.icon] ~= '' then
                    mat = ui.weps[i.icon]
                else
                    mat = ui.mats.empty
                end

                local icon = back:Add('DImage')
                icon:SetMaterial(mat)
                icon:SetSize(h(64), h(64))
                icon:Center()
                AnimateEntry(back)
            end
        end
    end

    function pnl:OnKeyCodeReleased(k)
        if k == KEY_ESCAPE then
            pnl:AlphaTo(0, .3, 0, function() pnl:Remove() end)
            if esc then esc.openMenu() end
            gui.HideGameUI()
        end
    end

    PopulateItems('')
    searchBar.OnValueChange = function(_, value) PopulateItems(value) end
end

local menu = function()
    if IsValid(ui.fr) then return end
    op = true
    local p = LocalPlayer()
    local fr = vgui.Create('DFrame')
    fr:SetSize(sw, sh)
    fr:SetAlpha(0)
    fr:AlphaTo(255, .3)
    fr:Center()
    fr:SetTitle('')
    fr:MakePopup()
    fr:SetDraggable(false)
    fr:ShowCloseButton(false)
    function fr:Paint(ww, hh)
        surface.SetMaterial(ui.mats.background)
        surface.SetDrawColor(255, 255, 255, 255 * .90)
        surface.DrawTexturedRect(0, 0, ww, hh)
    end

    local pnl = fr:Add('Panel')
    pnl:SetSize(h(580), h(590))
    pnl:SetPos(h(30), h(295))
    ui.addpnl = pnl
    ui.fr = fr
    local mdl = fr:Add('DModelPanel')
    mdl:SetSize(h(700), h(1080))
    mdl:SetPos(h(900), h(0))
    mdl:SetLookAt(LOOK_AT)
    mdl:SetCamPos(CAMPOS)
    mdl:SetFOV(15)
    mdl:SetModel(p:GetModel() or 'models/sup/vrpm/eng/eng.mdl')
    mdl:SetAmbientLight(ambient_light)
    mdl:SetDirectionalLight(BOX_TOP, direct_light)
    mdl.Angles = ANGLE_DEFAULT
    mdl:SetCursor('arrow')
    function mdl:DragMousePress()
        self.PressX, self.PressY = gui.MousePos()
        self.Pressed = true
    end

    function mdl:DragMouseRelease()
        self.Pressed = false
    end

    function mdl:LayoutEntity(ent)
        if self.Pressed then
            local mx, _ = gui.MousePos()
            self.Angles = self.Angles - Angle(0, (self.PressX or mx) - mx, 0)
            self.PressX, self.PressY = gui.MousePos()
        end

        ent:SetAngles(self.Angles)
    end

    mdl.o = mdl.Paint
    function mdl:Paint(ww, hh)
        surface_SetMaterial(ui.mats.circle)
        surface_SetDrawColor(255, 255, 255)
        surface_DrawTexturedRectRotated(ww * .5 + h(25), h(450), h(550), h(550), CurTime() * 7 % 360)
        surface_SetMaterial(ui.mats.glow)
        surface_SetDrawColor(team.GetColor(p:Team()))
        surface_DrawTexturedRectRotated(ww * .5 + h(25), h(450), h(1200), h(1200), CurTime() * 7 % 360)
        self.o(self, ww, hh)
    end

    local logo = fr:Add('DImage')
    logo:SetSize(h(300), h(65))
    logo:SetPos(h(30), h(30))
    function logo:Paint(_, hh)
        draw_Icon(0, 0, hh, hh, ui.mats.logo, Color(255, 255, 255))
        draw_SimpleText('Piwnica Granie', 'sup_inv.2', hh + h(20), hh * .5, Color(255, 255, 255), 0, 1)
    end

    local logo2 = fr:Add('DImage')
    logo2:SetSize(h(430), h(65))
    logo2:SetPos(h(350), h(30))
    function logo2:Paint(_, hh)
        draw_Icon(0, 0, hh, hh, ui.mats.logo2, Color(255, 255, 255))
        draw_SimpleText('Luna-core • ' .. GAMEMODE.Version, 'sup_inv.2', hh + h(20), hh * .5, Color(255, 255, 255), 0, 1)
    end

    local close = fr:Add('DButton')
    close:SetSize(h(40), h(40))
    close:SetText('')
    close:SetPos(ScrW() * .96, h(40))
    close.color = ui.cols.white
    function close:Paint(ww, hh)
        local ft = FrameTime()
        self.color = LerpColor(7.5 * ft, self.color, ui.cols.white)
        if self:IsHovered() then self.color = LerpColor(7.5 * ft, self.color, ui.cols.whitehover) end
        draw_Icon(0, 0, ww, hh, ui.mats.close, self.color)
    end

    function close:DoClick()
        fr:AlphaTo(0, .3, 0, function() fr:Remove() end)
    end

    local settings = fr:Add('DButton')
    settings:SetSize(h(40), h(40))
    settings:SetText('')
    settings:SetPos(h(1770), h(40))
    settings.color = ui.cols.white
    function settings:Paint(ww, hh)
        local ft = FrameTime()
        self.color = LerpColor(7.5 * ft, self.color, ui.cols.white)
        if self:IsHovered() then self.color = LerpColor(7.5 * ft, self.color, ui.cols.whitehover) end
        draw_Icon(0, 0, ww, hh, ui.mats.settings, self.color)
    end

    function settings:DoClick()
        gui.ActivateGameUI()
        RunConsoleCommand('gamemenucommand', 'openoptionsdialog')
        fr:AlphaTo(0, .3, 0, function() fr:Remove() end)
    end

    function fr:OnKeyCodeReleased(k)
        if k == KEY_ESCAPE then
            fr:AlphaTo(0, .3, 0, function() fr:Remove() end)
            if esc then esc.openMenu() end
            gui.HideGameUI()
        end
    end

    if p:GetUserGroup() == 'founder' or p:IsSuperAdmin() then
        local admingive = fr:Add('DButton')
        admingive:SetPos(h(30), h(100))
        admingive:SetSize(h(180), h(30))
        admingive:SetText('Wydawanie broni')
        admingive:SetTextColor(Color(200, 200, 200, 201))
        admingive:SetFont('sup_inv.kg_small')
        admingive.color = Color(0, 120, 215, 135)
        function admingive:Paint(ww, hh)
            self:MoveToFront()
            local ft = FrameTime()
            self.color = self:IsHovered() and LerpColor(ft * 6, self.color, Color(120, 120, 215, 135)) or LerpColor(ft * 6, self.color, Color(0, 120, 215, 135))
            draw_RoundedBox(12, 0, 0, ww, hh, self.color)
        end

        function admingive:DoClick()
            fr:AlphaTo(0, .3, 0, function() fr:Remove() end)
            adminmenu()
        end
    end

    timer.Simple(.1, function() refresh() end)
end

hook.Add('StartChat', 'sup_inv.NoMenuInChat', function() op = true end)
hook.Add('FinishChat', 'sup_inv.FinishChat', function() op = false end)
function GetMedicine()
    local ret = {}
    local c = LocalPlayer():GetNW2Int('supinv.maxslots', 0)
    if ui and ui.inv then
        for y = 1, c do
            for x = 1, c do
                if ui.inv[y] and ui.inv[y][x] and ui.inv[y][x].type == 'medicine' then
                    ret[#ret + 1] = {
                        item = ui.inv[y][x],
                        x = x,
                        y = y
                    }
                end
            end
        end
        return ret
    end
    return {}
end

hook.Add('PlayerButtonDown', 'sup_inv.KeyBind', function() if input.IsKeyDown(19) then menu() end end)
net.Receive('inventory_update', function()
    ui.inv = net.ReadTable()
    ui.weight = net.ReadInt(10)
    ui.equip = net.ReadTable()
    if IsValid(ui.fr) then refresh() end
end)

cmd('sup_additem', function(_, _, args)
    net_Start('inventory_add_item')
    net_WriteString(args[1])
    net_SendToServer()
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
