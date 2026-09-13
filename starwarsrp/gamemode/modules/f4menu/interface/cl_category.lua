local cfg = GameMenu.cfg

local PANEL = {}

function PANEL:Init()
    self:Dock(TOP)
    self.Header:SetTall( scale(50) )
    self.Paint = nil
    self:SetLabel ''

    self.Header.Paint = function( s, w, h )
        draw.SimpleText( self.title or '', 'gm.6', 0, h*.5, cfg.colors.white, 0, 1 )
    end
end

function PANEL:Paint() end

vgui.Register( 'gm.category', PANEL, 'DCollapsibleCategory' )
