local PANEL = {}

function PANEL:Init()
    self:Dock(FILL)
    -- self:DockMargin( 0, 0, scale(10), 0 )

    self.VBar:SetWide( scale(10) )
    local bar = self.VBar
    bar:SetHideButtons(true)
    bar.Paint = nil

    bar.Paint = function(this, w, h)
        draw.NewRect( 0, 0, w, h, Achievements.colors.back )
    end
    
    bar.btnGrip.Paint = function(this, w, h)
        draw.NewRect( 0, 0, w, h, Achievements.colors.gray2 )
    end
end

vgui.Register( 'achievements.scroll', PANEL, 'DScrollPanel' )