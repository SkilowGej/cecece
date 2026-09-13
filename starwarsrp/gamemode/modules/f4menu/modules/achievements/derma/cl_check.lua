

local PANEL = {}

function PANEL:Init()
    -- local fr = self:GetParent()

    -- self:SetSize( scale(250), scale(24) )
    -- self:SetPos( fr:GetWide() - self:GetWide() - scale(15), scale(40) )
    
    self.btn = self:Add( 'DButton' )
    -- self.btn:SetSize( self:GetTall(), self:GetTall() )
    -- self.btn:SetX( self:GetWide() - self.btn:GetWide() )
    self.btn:SetText''

    self.btn.Paint = function( s, w, h )
        draw.NewRect( 0, 0, w, h, Achievements.colors.back )
        surface.SetDrawColor( Achievements.colors.white2 )
        surface.DrawOutlinedRect( 0, 0, w, h )

        if s.clicked then
            draw.RoundedBox( scale(6), w*.5 - scale(10)*.5, h*.5 - scale(10)*.5, scale(10), scale(10), Achievements.colors.red )
        end
        return
    end

    self.btn.DoClick = function( s )
        s.clicked = not s.clicked
        self:FilterAchievements(s.clicked)
    end
end

function PANEL:PerformLayout( w, h )
    self.btn:SetSize( h, h )
    self.btn:SetX( w - self.btn:GetWide() )
end

function PANEL:FilterAchievements(hideCompleted)
    local p = LocalPlayer()
    local scroll = self.scrollPanel

    local child = (istable(scroll:GetChildren()) and #scroll:GetChildren() > 0 and IsValid(scroll:GetChildren()[1])) and scroll:GetChildren()[1] or nil

    if child and istable(child:GetChildren()) then
        for _, item in ipairs(child:GetChildren()) do
            if item.data then
                local metaData = p:GetMetadata( 'Achievements:Task', {} )
                local task_complete = metaData[ item.data.check[1] ]

                if hideCompleted and task_complete then
                    item:SetVisible(false)
                else
                    item:SetVisible(true)
                end
            end
        end
    end

    scroll:InvalidateLayout(true)
end


function PANEL:SetScrollPanel(panel)
    self.scrollPanel = panel
end

function PANEL:Paint( w, h )
    draw.SimpleText( 'ukryj wykonane', 'achiev4', w - self.btn:GetWide() - scale(10), h*.5, Achievements.colors.white, 2, 1 )
end

vgui.Register( 'achievement.check', PANEL, 'EditablePanel' )

