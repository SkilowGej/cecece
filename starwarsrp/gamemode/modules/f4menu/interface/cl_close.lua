local cfg = GameMenu.cfg

local PANEL = {}

function PANEL:Init()
    local parent = self:GetParent()

    self:SetSize( scale(300), scale(40) )
    self:SetPos( parent:GetWide() - self:GetWide() - scale(30), scale(40) )

    self.close = self:Add( 'DButton' )
    self.close:SetSize( self:GetTall(), self:GetTall() )
    self.close:SetX( self:GetWide() - self.close:GetWide() )
    self.close:SetText''
    self.close.color = cfg.colors.white

    self.close.Paint = function( s, w, h )
		s.color = LerpColor( 7.5 * FrameTime(), s.color, cfg.colors.white )
		if s:IsHovered() then
			s.color = LerpColor( 7.5 * FrameTime(), s.color, cfg.colors.white_hover )
		end

        draw.Image( 0, 0, w, h, cfg.mats.close, s.color )
        return true
    end

    self.close.DoClick = function() parent:SafetyRemove() RunConsoleCommand('stopsound') end

    self.settings = self:Add( 'DButton' )
    self.settings:SetSize( self:GetTall(), self:GetTall() )
    self.settings:SetX( self:GetWide() - self.settings:GetWide() - self.close:GetWide() - scale(20) )
    self.settings:SetText''
    self.settings.color = cfg.colors.white

    self.settings.Paint = function( s, w, h )
        s.color = LerpColor( 7.5 * FrameTime(), s.color, cfg.colors.white )
		if s:IsHovered() then
			s.color = LerpColor( 7.5 * FrameTime(), s.color, cfg.colors.white_hover )
		end

        draw.Image( 0, 0, w, h, cfg.mats.sets, s.color )
        return true
    end

    self.settings.DoClick = function() gui.ActivateGameUI() RunConsoleCommand( 'gamemenucommand', 'openoptionsdialog' )
    end
end

vgui.Register( 'gm.close', PANEL, 'EditablePanel' )