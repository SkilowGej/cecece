include("shared.lua")
local Menu

local icon_size = 150
local mat_wep1 = Material('luna_icons/computing.png', 'smooth noclamp')

function ENT:Draw()
	self:DrawModel()
	--self:SetSequence(self:LookupSequence("d1_t01_BreakRoom_WatchClock_Sit"))

	if self:GetPos():Distance(LocalPlayer():GetPos()) < 300 then
		local Ang = LocalPlayer():GetAngles()

		Ang:RotateAroundAxis( Ang:Forward(), 90)
		Ang:RotateAroundAxis( Ang:Right(), 90)

		cam.Start3D2D(self:GetPos()+self:GetUp()*80, Ang, 0.05)
			render.PushFilterMin(TEXFILTER.ANISOTROPIC)
				draw.RoundedBox(0, icon_size*-.6,icon_size*-.5-80,icon_size,icon_size,Color(22, 23, 28, 150))
				draw.DrawOutlinedRect(icon_size*-.6,icon_size*-.5-80,icon_size,icon_size,Color(255, 255, 255, 150))
				draw.Icon(icon_size*-.6,icon_size*-.5-80,icon_size,icon_size,mat_wep1,color_white)
				draw.ShadowSimpleText( 'Oficer Lupus', luna.NPC1, -3, 0, Color(17, 148, 240), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
				draw.ShadowSimpleText( 'Oficer Lupus', luna.NPC1Neon, -3, 0, Color(17, 148, 240), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
				draw.ShadowSimpleText( 'Tutaj możesz zmienić swój identyfikator IDN.', luna.NPC2, -3, 70, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
                --draw.ShadowSimpleText( self:GetUses() .. '/30', luna.NPC2, -3, 110, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
			render.PopFilterMin()
		cam.End3D2D()
	end
end


re.selected_spawnpoint = re.selected_spawnpoint or false
re.selected_clientmodel = re.selected_clientmodel or false
re.selected_spawnmodel = re.selected_spawnmodel or ''
local alpha_lerp, alpha = 0, 0
local replogo = Material('celestia/cwrp/rep1.png', 'smooth noclamp')

netstream.Hook("RPIDChanger_OpenMenu", function(data)
    surface.PlaySound("sup_sound/on.ogg")
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
        --draw.DrawBlur( x, y, self:GetWide(), self:GetTall(), alpha_lerp/100 )

        draw.RoundedBox(6,w*.5 - 150, h*.5 - 50 - 200,300,340,Color(22, 23, 28, 150))
        -- draw.RoundedBox(0,0,0,w,60,Color(44, 62, 80, 220))
        -- draw.RoundedBox(0,0,h-60,w,60,Color(44, 62, 80, 220))

        -- surface.SetMaterial(replogo)
        -- surface.SetDrawColor( Color(5,5,5,100) )
        -- surface.DrawTexturedRectRotated( 0, h/2, 500, 500, (CurTime() % 360)*10 )

        -- surface.SetMaterial(replogo)
        -- surface.SetDrawColor( Color(5,5,5,100) )
        -- surface.DrawTexturedRectRotated( w, h/2, 500, 500, (CurTime() % -360)*10 )

        draw.RoundedBox(6,w*.5 - 150, h*.5 - 50 - 200,300,100,Color(22, 23, 28, 150))

        draw.ShadowSimpleText('Zmiana twojego IDN kosztuje', luna.MontBase22, w*.5, h*.5 - 220, Color(255, 255, 255, 255), 1)
        draw.ShadowSimpleText('10 000 Kredytów', luna.MontBase22, w*.5, h*.5 - 200, Color(255, 255, 255, 255), 1)
    end


    local Entry = vgui.Create("DTextEntry",Menu)
    Entry:SetSize(200, 30)
    Entry:SetPos(Menu:GetWide()*.5-Entry:GetWide()*.5,Menu:GetTall()*.5-Entry:GetTall()*.5)
    Entry:SetPaintBorderEnabled( true )
    Entry:SetFont(luna.MontBase22)
    Entry:SetAllowNonAsciiCharacters( false )
    Entry:SetText(LocalPlayer():GetRPID())
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
        netstream.Start('PlayerChangeRPID', Entry:GetValue())
    end

    local Close = vgui.Create( "DButton", Menu )
    Close:SetSize( 100, 30 )
    Close:SetText('')
    Close:SetPos( Menu:GetWide()*.5-Save:GetWide() - 2, Menu:GetTall()*.5-Save:GetTall()*.5+50 )
    Close.Paint = function( self, w, h )
        draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 100))
        draw.SimpleText('Zamknij', luna.MontBase22, w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1)
    end

    Close.DoClick = function( self )
        surface.PlaySound("luna_ui/pop.wav")
        Menu:Remove()
    end

end)
