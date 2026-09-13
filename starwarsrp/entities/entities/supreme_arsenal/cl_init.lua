include('shared.lua')
ENT.RenderGroup = RENDERGROUP_OPAQUE
local icon_size = 150
local base_h = ScrH() / 1080
local math_Round = math.Round
local cache_h = {}
local function qh(px)
    if cache_h[px] then
        return cache_h[px]
    else
        local result = math_Round(px * base_h)
        cache_h[px] = result
        return result
    end
end

local mat_wep1 = Material('luna_icons/pistol-gun.png', 'smooth noclamp')
local selected_wep = Material('luna_ui_base/etc/halt.png', 'smooth noclamp')
function ENT:Draw()
    self:DrawModel()
    --self:SetSequence(self:LookupSequence('d1_t01_BreakRoom_WatchClock_Sit'))
    if self:GetPos():Distance(LocalPlayer():GetPos()) < 300 then
        local Ang = LocalPlayer():GetAngles()
        Ang:RotateAroundAxis(Ang:Forward(), 90)
        Ang:RotateAroundAxis(Ang:Right(), 90)
        cam.Start3D2D(self:GetPos() + self:GetUp() * 105, Ang, 0.05)
        render.PushFilterMin(TEXFILTER.ANISOTROPIC)
        draw.RoundedBox(0, icon_size * -.6, icon_size * -.5 - 80, icon_size, icon_size, Color(0, 0, 0, 150))
        draw.DrawOutlinedRect(icon_size * -.6, icon_size * -.5 - 80, icon_size, icon_size, Color(255, 255, 255, 150))
        draw.Icon(icon_size * -.6, icon_size * -.5 - 80, icon_size, icon_size, mat_wep1, color_white)
        draw.ShadowSimpleText('Wydawanie broni', luna.NPC1, -3, 0, Color(17, 148, 240), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
        draw.ShadowSimpleText('Wydawanie broni', luna.NPC1Neon, -3, 0, Color(17, 148, 240), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
        draw.ShadowSimpleText('tutaj możesz otrzymać broń', luna.NPC2, -3, 70, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
        --draw.ShadowSimpleText( self:GetUses() .. '/30', luna.NPC2, -3, 110, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
        render.PopFilterMin()
        cam.End3D2D()
    end
end

local PANEL = {}
function PANEL:Init()
    self.LineSize = 1
    self.Hover = 0
end

function PANEL:PaintOver(w, h)
    if self:IsHovered() then
        self.Hover = Lerp(engine.TickInterval(), self.Hover, 125)
        local col = ColorAlpha(Color(0, 165, 255), self.Hover)
        draw.RoundedBox(0, 0, 0, w, self.LineSize, col)
        draw.RoundedBox(0, 0, h - self.LineSize, w, self.LineSize, col)
        draw.RoundedBox(0, 0, 0, self.LineSize, h, col)
        draw.RoundedBox(0, w - self.LineSize, 0, self.LineSize, h, col)
    end
end

vgui.Register('ArsenalButton', PANEL, 'DButton')
local function OpenMenushka(ent, availableWeapons)
    local gray = Color(22, 23, 28, 150)
    local gray2 = Color(22, 23, 28, 150)
    local white = Color(255, 255, 255)
    local ply = LocalPlayer()
    local function DrawBox(x, y, w, h, col)
        local col = col or white
        return draw.RoundedBox(4, x, y, w, h, col)
    end

    local function width(x)
        return math.Round(ScrW() / 1920 * x)
    end

    local function height(y)
        return math.Round(ScrH() / 1080 * y)
    end

    local emptyfunc = function() end
    local function requestammo(class)
        net.Start('Arenal.Networking-ammo')
        net.WriteString(class)
        net.SendToServer()
    end

    local function SendAction(action, wep)
        if wep then
            print('Sending weapon ' .. wep)
            net.Start('Arenal.Networking-Action')
            net.WriteEntity(ent)
            net.WriteString(action)
            net.WriteString(wep)
            net.SendToServer()
        else
            print('Sending without weapon')
            net.Start('Arenal.Networking-Action')
            net.WriteEntity(ent)
            net.WriteString(action)
            net.SendToServer()
        end
    end

    Arsenal.Selected = nil
    if IsValid(ArsenalFrame) then ArsenalFrame:Remove() end
    ArsenalFrame = vgui.Create('EditablePanel')
    ArsenalFrame:SetSize(width(840), height(600))
    ArsenalFrame:MakePopup()
    ArsenalFrame:Center()
    ArsenalFrame.Paint = emptyfunc
    ArsenalPanel = vgui.Create('Panel', ArsenalFrame)
    ArsenalPanel:Dock(FILL)
    ArsenalPanel.Paint = function(self, w, h)
        DrawBox(0, 0, w, 60, gray)
        DrawBox(0, 0, w, h, gray2)
        surface.SetFont(luna.MontBaseHud)
        local nW, nH = surface.GetTextSize('Arsenal wojskowy')
        draw.SimpleText('Arsenal wojskowy', luna.MontBaseHud, (w - nW) / 2, height(15), white)
    end

    local ArsenalTakeAll = vgui.Create('ArsenalButton', ArsenalPanel)
    ArsenalTakeAll:SetPos(width(120), height(460))
    ArsenalTakeAll:SetSize(qh(140), qh(50))
    ArsenalTakeAll:SetText('')
    ArsenalTakeAll.DoClick = function(self, w, h) SendAction('takeall') end
    ArsenalTakeAll.Paint = function(self, w, h)
        DrawBox(0, 0, w, h, gray)
        surface.SetFont(luna.MontBaseHud)
        local nW, nH = surface.GetTextSize('Weź wszystko')
        draw.SimpleText('Weź wszystko', luna.MontBaseHud, (w - nW) / 2, height(10), white)
    end

    local ArsenalReturnAll = vgui.Create('ArsenalButton', ArsenalPanel)
    ArsenalReturnAll:SetPos(width(120), height(520))
    ArsenalReturnAll:SetSize(qh(140), qh(50))
    ArsenalReturnAll:SetText('')
    ArsenalReturnAll.DoClick = function(self, w, h) SendAction('returnall') end
    ArsenalReturnAll.Paint = function(self, w, h)
        DrawBox(0, 0, w, h, gray)
        surface.SetFont(luna.MontBaseHud)
        local nW, nH = surface.GetTextSize('Zwróć wszystko')
        draw.SimpleText('Zwróć wszystko', luna.MontBaseHud, (w - nW) / 2, height(10), white)
    end

    local ArsenalClose = vgui.Create('DButton', ArsenalFrame)
    ArsenalClose:SetPos(width(800), height(15))
    ArsenalClose:SetSize(qh(32), qh(32))
    ArsenalClose:SetText('')
    ArsenalClose.Paint = function(self, w, h)
        local col = white
        if self:IsHovered() then col = Color(0, 165, 255) end
        draw.SimpleText('X', luna.MontBaseHud, 0, 5, col)
    end

    ArsenalClose.DoClick = function() if IsValid(ArsenalFrame) then ArsenalFrame:Remove() end end
    ArsenalPanelLeft = vgui.Create('Panel', ArsenalFrame)
    ArsenalPanelLeft:SetSize(width(420), height(395))
    ArsenalPanelLeft:SetPos(0, height(60))
    local ArsenalScroll = vgui.Create('DScrollPanel', ArsenalPanelLeft)
    ArsenalScroll:Dock(FILL)
    ArsenalScroll:DockMargin(width(5), 0, width(5), height(50))
    ArsenalScroll:DockPadding(0, 0, -3, 0)
    ArsenalScroll.Paint = nil
    ArsenalScroll.VBar:SetWide(width(4))
    local bar = ArsenalScroll.VBar
    bar:SetHideButtons(true)
    bar.Paint = function(self, w, h) DrawBox(0, 0, w, h, Color(40, 40, 40)) end
    bar.btnGrip.Paint = function(this, w, h) DrawBox(0, 0, w, h, Color(255, 255, 255, 50)) end
    ArsenalPanelRight = vgui.Create('Panel', ArsenalFrame)
    ArsenalPanelRight:SetSize(width(420), height(538))
    ArsenalPanelRight:SetPos(width(420), height(60))
    ArsenalPanelRight.Paint = function(self, w, h)
        if Arsenal.Selected then
            local wepdata = weapons.Get(Arsenal.Selected)
            if wepdata then
                local name = wepdata.PrintName or 'Nazwa niedostępna'
                local colors = {
                    ['Niezwykłe'] = Color(125, 213, 235)
                }

                surface.SetFont(luna.MontBaseHud)
                local nW, nH = surface.GetTextSize(name)
                draw.SimpleText(name, luna.MontBaseHud, (w - nW) / 2, 5, color_white)
                local rarity = wepdata.rarity or 'Zwykłe'
                local desc = wepdata.desc or 'Opis niedostępny'
                if rarity then
                    local nW, nH = surface.GetTextSize(rarity)
                    draw.SimpleText(rarity, luna.MontBaseHud, (w - nW) / 2, qh(30), colors[wepdata.rarity] or color_white)
                end

                if desc then
                    surface.SetFont(luna.MontBaseHud)
                    desc = util.textWrap(desc, luna.MontBaseHud, w - 20)
                    local nW, nH = surface.GetTextSize(desc)
                    draw.DrawText(desc, luna.MontBase18, (w - nW) / 2, qh(210), color_white)
                end
            end
        end
    end

    local ArsenalTake = vgui.Create('ArsenalButton', ArsenalPanelRight)
    ArsenalTake:SetPos(qh(130), qh(400))
    ArsenalTake:SetSize(qh(140), qh(50))
    ArsenalTake:SetVisible(false)
    ArsenalTake:SetText('')
    ArsenalTake.DoClick = function(self, w, h)
        if not Arsenal.Selected then return end
        SendAction('take', Arsenal.Selected)
    end

    ArsenalTake.Paint = function(self, w, h)
        DrawBox(0, 0, w, h, gray)
        surface.SetFont(luna.MontBaseHud)
        local nW, nH = surface.GetTextSize('Zwróć wszystko')
        draw.SimpleText('Weź', luna.MontBaseHud, (w - nW) / 0.5, height(11), white)
    end

    local ArsenalReturn = vgui.Create('ArsenalButton', ArsenalPanelRight)
    ArsenalReturn:SetPos(qh(130), qh(460))
    ArsenalReturn:SetSize(qh(140), qh(50))
    ArsenalReturn:SetVisible(false)
    ArsenalReturn:SetText('')
    ArsenalReturn.DoClick = function(self, w, h)
        if not Arsenal.Selected then return end
        SendAction('return', Arsenal.Selected)
    end

    ArsenalReturn.Paint = function(self, w, h)
        DrawBox(0, 0, w, h, gray)
        surface.SetFont(luna.MontBaseHud)
        local nW, nH = surface.GetTextSize('Zwróć wszystko')
        draw.SimpleText('Zwróć', luna.MontBaseHud, (w - nW) / 0.7, height(11), white)
    end

    local ArsenalNaebal = vgui.Create('ArsenalButton', ArsenalPanelRight)
    ArsenalNaebal:SetPos(qh(130), qh(340))
    ArsenalNaebal:SetSize(qh(140), qh(50))
    ArsenalNaebal:SetVisible(false)
    ArsenalNaebal:SetText('')
    ArsenalNaebal.DoClick = function(self, w, h)
        if not Arsenal.Selected then return end
        requestammo(Arsenal.Selected)
    end

    ArsenalNaebal.Paint = function(self, w, h)
        DrawBox(0, 0, w, h, gray)
        surface.SetFont(luna.MontBaseHud)
        local nW, nH = surface.GetTextSize('Zwróć wszystko')
        draw.SimpleText('Amunicja', luna.MontBaseHud, (w - nW) / .7, height(11), white)
    end

    local ArsenalWeapon = vgui.Create('ModelImage', ArsenalPanelRight)
    ArsenalWeapon:SetSize(qh(128), qh(128))
    ArsenalWeapon:SetPos(qh(120), qh(60))
    ArsenalWeapon:SetVisible(false)
    local function ArsenalUpdate()
        if Arsenal.Selected then
            local wepdata = weapons.Get(Arsenal.Selected)
            if wepdata and wepdata.WorldModel then
                ArsenalWeapon:SetVisible(true)
                ArsenalWeapon:SetModel(wepdata.WorldModel)
                ArsenalTake:SetVisible(true)
                ArsenalReturn:SetVisible(true)
                ArsenalNaebal:SetVisible(true)
                if IsValid(ArsenalWeapon.Entity) then
                    local mn, mx = ArsenalWeapon.Entity:GetRenderBounds()
                    local sizex = 0
                    local sizey = 0
                    local sizez = 0
                    sizex = math.max(sizex, math.abs(mn.x) + math.abs(mx.x))
                    sizey = math.max(sizey, math.abs(mn.y) + math.abs(mx.y))
                    sizez = math.max(sizez, math.abs(mn.z) + math.abs(mx.z))
                    local sizemid = (mn + mx) * 0.5
                    ArsenalWeapon:SetLookAng(Angle(0, 0, 0))
                    ArsenalWeapon:SetCamPos(sizemid + Vector(-sizex * 1.5, 0, 0))
                    ArsenalWeapon:SetLookAt(sizemid)
                    function ArsenalWeapon:LayoutEntity(ent)
                        if self.bAnimated then self:RunAnimation() end
                    end
                end
            else
                ArsenalWeapon:SetVisible(false)
                ArsenalTake:SetVisible(false)
                ArsenalReturn:SetVisible(false)
            end
        end
    end

    local job = re.jobs[ply:Team()]
    local weps = job.weaponcrate or {}
    for _, v in ipairs(availableWeapons) do
        if v == 'weapon_hands' then continue end
        local button = vgui.Create('ArsenalButton', ArsenalScroll)
        button:Dock(TOP)
        button:DockMargin(0, width(5), 0, 0)
        button:SetTall(height(50))
        button:SetText('')
        button.Paint = function(self, w, h)
            DrawBox(0, 0, w, h, gray)
            local weaponData = weapons.Get(v)
            local name = weaponData and weaponData.PrintName or v
            draw.SimpleText(name, luna.MontBaseHud, width(15), height(13), white)
            if LocalPlayer():HasWeapon(v) then
                surface.SetDrawColor(white)
                surface.SetMaterial(selected_wep)
                surface.DrawTexturedRect(width(360), height(5), qh(32), qh(32))
            end
        end

        button.DoClick = function()
            Arsenal.Selected = v
            ArsenalUpdate()
        end
    end
end

net.Receive('Arenal.Networking-OpenMenu', function(len, ply)
    local ent = net.ReadEntity()
    local weaponCount = net.ReadUInt(8)
    local availableWeapons = {}
    for i = 1, weaponCount do
        table.insert(availableWeapons, net.ReadString())
    end

    -- Let it be, just in case
    if not IsValid(ent) then
        print('[Arsenal] Received invalid entity')
        return
    end

    if #availableWeapons == 0 then
        print('[Arsenal] No available weapons received')
    else
        print('[Arsenal] Received ' .. #availableWeapons .. ' weapons')
    end

    OpenMenushka(ent, availableWeapons)
end)