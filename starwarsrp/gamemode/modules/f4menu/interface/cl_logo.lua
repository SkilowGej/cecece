local cfg = GameMenu.cfg

local PANEL = {}

function PANEL:Init()
    self:SetSize( scale(300), scale(65) )
    self:SetPos( scale(30), scale(30) )
end

function PANEL:Paint( w, h )
    draw.Image( 0, 0, h, h, cfg.mats.logo, cfg.colors.white )
    draw.SimpleText( 'SUP • Community', 'gm.2', h + scale(20), h*.5, cfg.colors.white, 0, 1 )
end

vgui.Register( 'gm.logo', PANEL, 'EditablePanel' )

local PANEL = {}

function PANEL:Init()
    local parent = self:GetParent()

    self:SetSize( scale(430), scale(65) )
    self:SetPos( parent.logo:GetWide() + scale(50), scale(30) )
end

function PANEL:Paint( w, h )
    draw.Image( 0, 0, h, h, cfg.mats.logo2, cfg.colors.white )
    draw.SimpleText( 'Luna-core • ' .. GAMEMODE.Version, 'gm.2', h + scale(20), h*.5, cfg.colors.white, 0, 1 )
end

vgui.Register( 'gm.logo2', PANEL, 'EditablePanel' )
