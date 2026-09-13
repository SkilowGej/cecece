local PANEL = {}

function PANEL:Init()
    self.scroll = self:Add( 'achievements.scroll' )

    self.test = self:Add('Panel')
    self.test:Dock(TOP)
    self.test:SetTall( scale(24) )
    self.test:DockMargin( 0, 0, scale(10), scale(20) )
    
    self.check = self.test:Add( 'achievement.check' )
    self.check:Dock(RIGHT)
    self.check:SetWide( scale(250) )
    self.check:SetScrollPanel( self.scroll )

    for id, v in ipairs( Achievements.Table ) do
        self.item = self.scroll:Add( 'achievements.item' )
        self.item.id, self.item.data = id, v
    end
end

vgui.Register( 'gm.tab.achiev', PANEL, 'EditablePanel' )