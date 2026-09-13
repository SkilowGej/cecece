local PANEL = {}

function PANEL:Init()
    self:Dock(TOP)
    self:SetTall( scale(100) )
    self:DockMargin( scale(10), 0, scale(10), scale(10) )
end

local romanNumerals = { 'I', 'II', 'III', 'IV', 'V' }
local function toRomanNumeral(trackedValue, maxValue)
    local fraction = trackedValue / maxValue

    local index = math.ceil(fraction * 5)
    index = math.max(1, math.min(index, 5))

    return romanNumerals[index]
end

local colb, colg = Achievements.colors.blue, Achievements.colors.gray
function PANEL:Paint( w, h )
    if not self.data then return end
    
    local p = LocalPlayer()

    draw.NewRect( 0, 0, w, h, Achievements.colors.back )

    local size = ( h - scale(10) )
    draw.Image( scale(10), h*.5 - size *.5, size, size, Achievements.mats.bg1, self.data.color  )
    draw.Image( scale(10), h*.5 - size *.5, size, size, Achievements.mats.bg2, Achievements.colors.white  )
    draw.Image( scale(10), h*.5 - size *.5, size, size, Achievements.mats.bg3, Achievements.colors.white2 )
    draw.Image( scale(23), h*.5 - scale(64) *.5, scale(64), scale(64), self.data.image, Achievements.colors.white )
    
    local have, need = p:GetMetadata( 'Achievements:'.. self.data.check[1], 0 ), self.data.check[2]

    draw.SimpleText( self.data.name.. ' • '.. toRomanNumeral(have, need), 'achiev1', size + scale(20), scale(15), Achievements.colors.white, 0, 3 )

    local description = markup.Parse( '<colour='.. colg.r ..','.. colg.g ..','.. colg.b ..','.. colg.a ..'><font=achiev2>'.. self.data.description ..' (</font><font=achiev2><colour='.. colb.r ..','.. colb.g ..','.. colb.b ..','.. colb.a ..'>'.. need ..'</font></colour><font=achiev2><colour='.. colg.r ..','.. colg.g ..','.. colg.b ..','.. colg.a ..'>)</font></colour>' )
    description:Draw( size + scale(20), scale(45), 0, 3 )

    local task_complete = p:GetMetadata( 'Achievements:Task', false )

    draw.NewRect( size + scale(20), scale(75), w*.5, scale(15), task_complete and Achievements.colors.gray2 or Achievements.colors.back )
    draw.NewRect( size + scale(20), scale(75), (w*.5)*(have/need), scale(15), Achievements.colors.gray2 )

    draw.SimpleText( task_complete and 'WYKONANE' or have ..' / ' .. need, 'achiev2', size + w*.5 + scale(30), scale(72), task_complete and Achievements.colors.green or Achievements.colors.gray, 0, 3 )

    if task_complete then
        draw.Image( 0, h*.5 - h *.5, h + scale(10), h, Achievements.mats.completed1, ColorAlpha( self.data.color, 100 )  )
        draw.Image( scale(10), h*.5 - size *.5, size, size, Achievements.mats.completed3, Achievements.colors.white  )
    end

    draw.Image( w - scale(155), h*.5 - scale(128) *.5 + scale(10), scale(128), scale(128), self.data.reward.image, Achievements.colors.white )
    if self.data.reward.isWeapon then
        draw.SimpleText( self.data.reward.name, 'achiev3', w - scale(90), scale(10), Achievements.colors.blue, 1, 3 )
    else
        draw.SimpleText( '- '.. self.data.reward.name, 'achiev3', w - scale(90), scale(10), Achievements.colors.red, 1, 3 )
    end
end

vgui.Register( 'achievements.item', PANEL, 'EditablePanel' )