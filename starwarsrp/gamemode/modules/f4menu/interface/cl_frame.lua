local cfg = GameMenu.cfg
local scrw, scrh = ScrW(), ScrH()

local PANEL = {}

function PANEL:Init()
    self:SetSize( scrw, scrh )
    self:MakePopup()
    self:SetAlpha( 0 )
    self:AlphaTo( 255, 0.4 )

    self.logo = self:Add( 'gm.logo' )
    self.logo2 = self:Add( 'gm.logo2' )
    self.close = self:Add( 'gm.close' )
    self.links = self:Add( 'gm.links' )
    self.char = self:Add( 'gm.char' )

    self.notifications = {}
    self.notificationHeight =  scale(40)
    self.notificationSpacing = scale(5)
    self.marginBottom = scale(150)
    self.marginLeft = scale(30)
    self.animationDuration = 0.3
    self.maxNotifications = 5

    self.angle = 0
    self.rotationSpeed = 0.01

    self.modelPanel = self:Add( 'gm.modelpanel' )
end

function PANEL:SafetyRemove()
    if IsValid( self ) then
        self:AlphaTo( 0, 0.3, 0, function()
            self:Remove()
        end )
    end
end

function PANEL:OnKeyCodeReleased( key )
    if key == KEY_ESCAPE then
        if esc then
            esc.openMenu()
        end
        self:SafetyRemove()
        gui.HideGameUI()
    elseif key == KEY_F4 then
        self:SafetyRemove()
    end
end

function PANEL:Notify(text, duration)
    text = text or 'example'
    duration = duration or 5

    surface.SetFont( 'gm.1' )
    local notificationWidth = surface.GetTextSize(text) + scale(20)

    local notification = vgui.Create("Panel", self)
    notification:SetSize(notificationWidth, self.notificationHeight)
    notification:SetPos(-notificationWidth, scrh - self.notificationHeight - self.marginBottom )
    notification.Text = text
    notification.StartTime = SysTime()
    notification.EndTime = SysTime() + duration

    notification.Paint = function( s, w, h)
        draw.RoundedBox( scale(4), 0, 0, w, h, cfg.colors.notify )
        draw.SimpleText( s.Text, "gm.1", scale(10), h * .5, color_white, 0, 1 )
    end

    table.insert(self.notifications, 1, notification)

    if #self.notifications > self.maxNotifications then
        self.notifications[#self.notifications]:Remove()
        table.remove(self.notifications)
    end

    self:UpdateNotificationPositions()
end

function PANEL:UpdateNotificationPositions()
    local scrw, scrh = ScrW(), ScrH()
    for i, notif in ipairs(self.notifications) do
        local targetY = scrh - (i * (self.notificationHeight + self.notificationSpacing)) - self.marginBottom
        notif:MoveTo(self.marginLeft, targetY, self.animationDuration, 0, -1)
    end
end

function PANEL:Think()
    local currentTime = SysTime()
    for i = #self.notifications, 1, -1 do
        local notif = self.notifications[i]
        if currentTime > notif.EndTime then
            notif:MoveTo(-notif:GetWide(), notif.y, self.animationDuration, 0, -1, function()
                notif:Remove()
            end)
            table.remove(self.notifications, i)
            self:UpdateNotificationPositions()
        end
    end
end

function PANEL:Paint( w, h )
    draw.Image( 0, 0, w, h, cfg.mats.back, cfg.colors.white )
    draw.Image( w - scale(700), h - scale(700), scale(700), scale(700), cfg.mats.gr, cfg.colors.gr )
    draw.SimpleText( 'Serwer gry od SUP • zespół programistów. STAR WARS™ jest własnością firmy LucasFilm Ltd.', 'gm.1', w*.5, h - scale(40), cfg.colors.white, 1, 4 )

    self.angle = (self.angle + self.rotationSpeed) % 360
    surface.SetMaterial( cfg.mats.big_circle )
    surface.SetDrawColor( cfg.colors.white )

    local centerX, centerY = w *.5, h *.5
    surface.DrawTexturedRectRotated( w - scale(250), h - scale(300), scale(1280), scale(1280), self.angle )
end

vgui.Register( 'gm.frame', PANEL, 'EditablePanel' )