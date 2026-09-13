include("shared.lua")
local Menu

local icon_size = 200
local mat_wep11 = Material('sup_ui/vgui/gicons/rating-3.png', 'smooth noclamp')

function ENT:Draw()
    self:DrawModel()

    local w, h = 5570, 2350

    if self:GetPos():Distance(LocalPlayer():GetPos()) < 1000 then
        cam.Start3D2D(self:GetPos()+self:GetForward()*2+self:GetUp()*60+self:GetRight()*140, self:GetAngles()-Angle(0,-90,-90), 0.05)
            draw.RoundedBox(0,0,0,w,h,Color(0, 0, 0, 50))

            local width = (w - 80) / #GUM_ROOMS
            for i, name in pairs(GUM_ROOMS) do
                local x = (i-1)*(width+20)+20
                draw.RoundedBox(0,(i-1)*(width+20)+20,40,width,h-60,Color(0, 0, 0, 50))

                local gum = GUM_ROOMS[i]

                if gum then
                    draw.SimpleText(GUM_ROOMS[i], luna.MontBaseLarge, x + width/2, 200, Color( 255, 255, 255, 255 ), 1, 1)
    
                    gum = GetGlobalTable('gums')[i]
    
                    if gum then
                        draw.SimpleText(gum.ply:Name(), luna.MontBaseLarge, x + width/2, 300, team.GetColor(gum.ply:Team()), 1, 1)
                        draw.SimpleText('(' .. team.GetName(gum.ply:Team()) .. ')', luna.MontBaseLarge, x + width/2, 370, team.GetColor(gum.ply:Team()), 1, 1)
    
                        local txts = string.Split(gum.text, '\n')
                        for i, str in pairs(txts) do
                            draw.SimpleText(str, luna.MontBaseLarge, x + width/2, 470 + (i*80), Color( 255, 255, 255, 255 ), 1, 1)
                        end
                    else
                        draw.SimpleText('Nie zajęte', luna.MontBaseLarge, x + width/2, 300, Color( 65, 255, 65, 255 ), 1, 1)
                    end
                end
            end
        cam.End3D2D()
    end
end