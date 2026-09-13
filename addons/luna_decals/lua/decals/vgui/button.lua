--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local PANEL = {}

function PANEL:Init()
    self:SetTextColor( color_white )
    self:SetFont "font_base_18"

    self.hoverCol = Color( 40, 130, 215 )
    self.ease = FrameTime() * 10
end

function PANEL:Paint( w, h )
    self.hoverCol = self:LerpColor( self.hoverCol, self.Hovered and Color( 20, 90, 190 ) or Color( 40, 130, 215 ) )

    draw.RoundedBox( 4, 0, 0, w, h, self.hoverCol )
end

vgui.Register( "Decals.Button", PANEL, "DButton" )


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
