local cfg = GameMenu.cfg

local PANEL = {}

function PANEL:Init()
    local parent = self:GetParent()

    self:SetSize( scale(400), scale(50) )
    self:SetPos( scale(30), parent:GetTall() - self:GetTall() - scale(30) )

    for _, v in ipairs( cfg.links ) do
        
        self.link = self:Add( 'DButton' )
        self.link:Dock(LEFT)
        self.link:SetWide( self:GetTall() )
        self.link:DockMargin( 0, 0, scale(20), 0 )
        self.link:SetText''
        self.link.color = cfg.colors.white

        self.link.Paint = function( s, w, h )
            s.color = LerpColor( 7.5 * FrameTime(), s.color, cfg.colors.white )
            if s:IsHovered() then
                s.color = LerpColor( 7.5 * FrameTime(), s.color, cfg.colors.white_hover )
            end

            draw.Image( 0, 0, w, h, cfg.mats.circle, cfg.colors.link )
            draw.Image( w*.5 - scale(30) *.5, h*.5 - scale(30) *.5, scale(30), scale(30), v.image, s.color )
            return true
        end

        self.link.DoClick = function()
            gui.OpenURL( v.link )
        end

    end
end

vgui.Register( 'gm.links', PANEL, 'EditablePanel' )
