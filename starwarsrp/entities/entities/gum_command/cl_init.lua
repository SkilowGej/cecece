include("shared.lua")
local Menu

local icon_size = 200
local mat_wep11 = Material('sup_ui/vgui/gicons/rating-3.png', 'smooth noclamp')

function ENT:Draw()
    self:DrawModel()

    local w, h = 1000, 1800

    if self:GetPos():Distance(LocalPlayer():GetPos()) < 1000 then
        cam.Start3D2D(self:GetPos()+self:GetForward()*-25+self:GetUp()*45+self:GetRight()*-1.5, self:GetAngles()-Angle(0,0,-90), 0.05)
            draw.RoundedBox(0,0,0,w,h,Color(52, 73, 94, 250))

            local gum = GUM_ROOMS[self:GetGUM()]

            if gum then
                draw.SimpleText(GUM_ROOMS[self:GetGUM()], luna.MontBase84, w/2, 200, Color( 255, 255, 255, 255 ), 1, 1)

                gum = GetGlobalTable('gums')[self:GetGUM()]

                if gum then
                    draw.SimpleText(gum.ply:Name(), luna.MontBase84, w/2, 300, team.GetColor(gum.ply:Team()), 1, 1)
                    draw.SimpleText('(' .. team.GetName(gum.ply:Team()) .. ')', luna.MontBase84, w/2, 370, team.GetColor(gum.ply:Team()), 1, 1)

                    local txts = string.Split(gum.text, '\n')
                    for i, str in pairs(txts) do
                        draw.SimpleText(str, luna.MontBase84, w/2, 470 + (i*80), Color( 255, 255, 255, 255 ), 1, 1)
                    end
                else
                    draw.SimpleText('Nie zajęte', luna.MontBase84, w/2, 300, Color( 65, 255, 65, 255 ), 1, 1)
                end
            end

            -- local height = (h - 80) / #GUM_ROOMS
            -- for i, name in pairs(GUM_ROOMS) do
            --     draw.RoundedBox(0,20,(i-1)*(height+20)+20,w-40,height,Color(255,255,255,20))
            -- end
        cam.End3D2D()
    end
end


re.selected_spawnpoint = re.selected_spawnpoint or false
re.selected_clientmodel = re.selected_clientmodel or false
re.selected_spawnmodel = re.selected_spawnmodel or ''
local alpha_lerp, alpha = 0, 0
local replogo = Material('sup_ui/replogo.png', 'smooth noclamp')

netstream.Hook("GUMCommand_OpenMenu", function(ent)
    if IsValid(Menu) then
        Menu:Remove()
    end

    local draw_blur = true
    local alpha_lerp, alpha = 0, 0
    local select_team = 1

    alpha = 160

    Menu = vgui.Create( "DFrame" )
    Menu:SetSize(ScrW(),ScrH())
    Menu:Center()
    Menu:MakePopup()
    Menu:SetTitle('')
    Menu:ShowCloseButton(false)
    Menu.Paint = function( self, w, h )
        if not draw_blur then return end
        alpha_lerp = Lerp(FrameTime()*6,alpha_lerp or 0,alpha or 0) or 0

        local x, y = self:GetPos()
        draw.DrawBlur( x, y, self:GetWide(), self:GetTall(), alpha_lerp/100 )

        draw.RoundedBox(0,0,0,w,h,Color(52, 73, 94, alpha_lerp))
    end

    local Close = vgui.Create( "DButton", Menu )
    Close:SetSize( 30, 30 )
    Close:SetText('')
    Close:SetPos( Menu:GetWide()-Close:GetWide()-10, 10 )
    Close.Paint = function( self, w, h )
        draw.RoundedBox(0, 0, 0, w, h, Color(191, 67, 57))
        draw.SimpleText('X', luna.MontBase22, w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1)
    end

    Close.DoClick = function( self )
        Menu:Remove()
    end

    if not ent:GetGUM() or ent:GetGUM() == 0 then
        local scrollpanel = vgui.Create('DScrollPanel',Menu)
        scrollpanel:SetSize(400,600)
        scrollpanel:SetPos(Menu:GetWide()*.5 - scrollpanel:GetWide()*.5, Menu:GetTall()*.5 - scrollpanel:GetTall()*.5)
        scrollpanel.Paint = function( self, w, h ) end

        local buttons = vgui.Create( "DListLayout", scrollpanel )
        buttons:Dock( FILL )

        for i, name in pairs(GUM_ROOMS) do
            local gum = vgui.Create("DButton")
            gum:SetSize(400, 20)

            gum.Paint = function( self, w, h )
                draw.RoundedBox(0,0,0,w,h,Color(255,255,255,20))
                draw.SimpleText(name, luna.MontBase18, 10, h/2, Color( 255, 255, 255, 255 ), 0, 1)
            end

            gum.DoClick = function( self )
                netstream.Start('GUMCommand_SelectGum', { ent = ent, gum = i })

                Menu:Remove()
            end

            buttons:Add( gum )
            gum:DockMargin( 0, 2, 0, 0 )
        end
    else
        local Entry = vgui.Create("DTextEntry",Menu)
        Entry:SetSize(300, 200)
        Entry:SetPos(Menu:GetWide()*.5-Entry:GetWide()*.5,Menu:GetTall()*.5-Entry:GetTall()+20)
        Entry:SetPaintBorderEnabled( true )
        Entry:SetFont(luna.MontBase22)
        -- Entry:SetAllowNonAsciiCharacters( false )
        Entry:SetText('Trening')
        Entry:SetMultiline( true )
        Entry.Paint = function( self, w, h )
            draw.RoundedBox(6,0,0,w,h,Color(0, 0, 0, 100))
            self:DrawTextEntryText(Color(255,255,255,240), Color(0,165,255,255), Color(255,255,255,240))
        end
    
        local Save = vgui.Create( "DButton", Menu )
        Save:SetSize( 100, 30 )
        Save:SetText('')
        Save:SetPos( Menu:GetWide()*.5 + 2, Menu:GetTall()*.5-Save:GetTall()*.5+50 )
        Save.Paint = function( self, w, h )
            draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 100))
            draw.SimpleText('Zapisz', luna.MontBase22, w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1)
        end
    
        Save.DoClick = function( self )
            Menu:Remove()
            netstream.Start('GUMCommand_Activate', { text = Entry:GetValue(), ent = ent } )
        end
    
        local Close = vgui.Create( "DButton", Menu )
        Close:SetSize( 100, 30 )
        Close:SetText('')
        Close:SetPos( Menu:GetWide()*.5-Close:GetWide() - 2, Menu:GetTall()*.5-Close:GetTall()*.5+50 )
        Close.Paint = function( self, w, h )
            draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 100))
            draw.SimpleText('Zamknij', luna.MontBase22, w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1)
        end
    
        Close.DoClick = function( self )
            Menu:Remove()
        end

        if GetGlobalTable('gums')[ent:GetGUM()] and GetGlobalTable('gums')[ent:GetGUM()].ply == LocalPlayer() then
            local Clean = vgui.Create( "DButton", Menu )
            Clean:SetSize( 140, 30 )
            Clean:SetText('')
            Clean:SetPos( Menu:GetWide()*.5-Clean:GetWide()*.5, Menu:GetTall()*.5-Clean:GetTall()*.5+100 )
            Clean.Paint = function( self, w, h )
                draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 100))
                draw.SimpleText('Zwolnij', luna.MontBase22, w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1)
            end
        
            Clean.DoClick = function( self )
                netstream.Start('GUMCommand_Clean', { text = Entry:GetValue(), ent = ent } )
                Menu:Remove()
            end
        end
    end
end)
