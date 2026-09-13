local cfg = GameMenu.cfg

local PANEL = {}

function PANEL:Init()
    local parent = self:GetParent()

    self:SetSize( scale(300), scale(40) )
    self:SetPos( parent:GetWide() - self:GetWide() - scale(150), scale(40) )

    self.char = self:Add( 'DButton' )
    self.char:SetSize( self:GetTall(), self:GetTall() )
    self.char:SetX( self:GetWide() - self.char:GetWide() )
    self.char:SetText''
    self.char.color = cfg.colors.white

    self.char.Paint = function( s, w, h )
		s.color = LerpColor( 7.5 * FrameTime(), s.color, cfg.colors.white )

		if s:IsHovered() then
			s.color = LerpColor( 7.5 * FrameTime(), s.color, cfg.colors.white_hover )

            
		end

        draw.Image( 0, 0, w, h, cfg.mats.user, s.color )
        return true
    end

    self.char.DoClick = function() parent:SafetyRemove() timer.Simple(0.1, function() LocalPlayer():ConCommand("say /char") end) end
end

vgui.Register( 'gm.char', PANEL, 'EditablePanel' )