local PANEL = {}

local color_gray = Color(150, 150, 150)

function PANEL:Init()
    local parent = self:GetParent()
    self.header = ''
    self.headerTextSizeX, self.headerTextSizeY = 0

    self.footer = self:Add('Panel')
    self.footer:SetSize(self:GetWide(), scale(150))
    self.footer:SetPos(0, self:GetTall() - self.footer:GetTall())
    self.footer.Paint = function(s, w, h)
        draw.DrawText("UWAGA!", 'gm.6', scale(10), scale(15), Color(200, 0, 0, 255))
    end
    
    self.btn = self.footer:Add('DButton')
    self.btn:SetSize(scale(150), scale(30))
    self.btn:SetPos(self.footer:GetWide() - self.btn:GetWide() - scale(10), scale(15))
    self.btn:SetText('')

    self.warning = self.footer:Add('RichText')
    self.warning:SetSize(self:GetWide(), scale(100))
    self.warning:SetPos(0, self.footer:GetTall() - self.warning:GetTall())
    self.warning:SetWrap(true)

    function self.warning:PerformLayout()

        if ( self:GetFont() != luna.MontBase22 ) then self:SetFontInternal( luna.MontBase22 ) end
        self:SetFGColor( color_gray )
        
    end

    self.desc = self:Add('RichText')
    self.desc:SetSize(self:GetWide(), scale(200))
    self.desc:SetPos(0, scale(40))
    self.desc:SetWrap(true)

    function self.desc:PerformLayout()

        if ( self:GetFont() != luna.MontBase22 ) then self:SetFontInternal( luna.MontBase22 ) end
        self:SetFGColor( color_gray )
        
    end

    self.body = self:Add('Panel')
    self.body:SetSize(self:GetWide(), self:GetTall() - self.footer:GetTall() - self.desc:GetTall() - scale(40))
    self.body:SetPos(0, self:GetTall() - self.body:GetTall() - self.footer:GetTall())

    surface.SetFont(luna.MontBase24)
    local x_size, y_size = surface.GetTextSize('Zastosuj')

    local col_hov = Color(0,128,255)
    local but_round = 8
    self.btn.Paint = function(s, w, h)
        col_hov = s:IsHovered() and LerpColor(FrameTime()*6, col_hov, Color(0,66,131)) or LerpColor(FrameTime()*6, col_hov, Color(0,128,255))
        but_round = s:IsHovered() and Lerp(FrameTime()*4, but_round, 0) or Lerp(FrameTime()*4, but_round, 8)

        draw.RoundedBox(but_round, 0, 0, w, h, col_hov )

        draw.DrawText('Zastosuj', luna.MontBase24, w*.5 - x_size*.5, scale(5), color_white, TEXT_ALIGN_LEFT)
    end
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(0, 0, 0, 100)
    surface.DrawRect(0, 0, w, h)

    draw.DrawText(self.header, 'gm.6', self.headerTextSizeX * .1, scale(15), color_white, TEXT_ALIGN_LEFT)
end

function PANEL:PerformLayout(w, h)
    self.footer:SetSize(w, scale(150))
    self.footer:SetPos(0, h - self.footer:GetTall())

    self.btn:SetPos(self.footer:GetWide() - self.btn:GetWide() - scale(10), scale(15))

    self.warning:SetSize(w, scale(100))
    self.warning:SetPos(0, self.footer:GetTall() - self.warning:GetTall())

    self.desc:SetSize(w, scale(150))
    self.desc:SetPos(0, scale(60))

    self.body:SetSize(self:GetWide(), self:GetTall() - self.footer:GetTall() - self.desc:GetTall() - scale(40))
    self.body:SetPos(0, self:GetTall() - self.body:GetTall() - self.footer:GetTall())
end

function PANEL:SetHeader(header)
    self.header = header
    self.headerTextSizeX, self.headerTextSizeY = surface.GetTextSize(self.header)
end

function PANEL:SetDesc(text)
    self.desc:AppendText(text)
end

function PANEL:SetWarning(text)
    self.warning:AppendText(text)
end

function PANEL:AddBody(panel)
    return self.body:Add(panel or 'panel')
end

vgui.Register('gm.config.panel', PANEL, 'EditablePanel')