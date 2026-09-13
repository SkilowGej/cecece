include('shared.lua')

local icon_size = 150
local mat_wep1 = Material('luna_icons/battle-gear.png', 'smooth noclamp')

function ENT:Draw()
	self:DrawModel()
	--self:SetSequence(self:LookupSequence("d1_t01_BreakRoom_WatchClock_Sit"))

	if self:GetPos():Distance(LocalPlayer():GetPos()) < 300 then
		local Ang = LocalPlayer():GetAngles()

		Ang:RotateAroundAxis( Ang:Forward(), 90)
		Ang:RotateAroundAxis( Ang:Right(), 90)

		cam.Start3D2D(self:GetPos()+self:GetUp()*65, Ang, 0.05)
			render.PushFilterMin(TEXFILTER.ANISOTROPIC)
				draw.RoundedBox(0, icon_size*-.6,icon_size*-.5-80,icon_size,icon_size,Color(0, 0, 0, 150))
				draw.DrawOutlinedRect(icon_size*-.6,icon_size*-.5-80,icon_size,icon_size,Color(255, 255, 255, 150))
				draw.Icon(icon_size*-.6,icon_size*-.5-80,icon_size,icon_size,mat_wep1,color_white)
				draw.ShadowSimpleText( 'Szafa z pancerzem', luna.NPC1, -3, 0, Color(17, 148, 240), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
				draw.ShadowSimpleText( 'Szafa z pancerzem', luna.NPC1Neon, -3, 0, Color(17, 148, 240), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
				draw.ShadowSimpleText( 'tutaj możesz zmienić swoją klasę rezerwacji', luna.NPC2, -3, 70, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
                --draw.ShadowSimpleText( self:GetUses() .. '/30', luna.NPC2, -3, 110, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
			render.PopFilterMin()
		cam.End3D2D()
	end
end




local Menu

local alpha_lerp, alpha = 0, 0
-- local mat_point = Material('icon16/connect.png')
local mat_bg = Material( "luna_ui_base/bg4.png", "smooth noclamp" )
netstream.Hook("Cupboard_OpenMenu", function(data)
    if IsValid(Menu) then
        Menu:Remove()
    end

    local alpha_lerp, alpha = 0, 0
    local select_team = 1

    alpha = 160

    Menu = vgui.Create( "DFrame" )
    Menu:SetSize(ScrW(),ScrH())
    Menu:Center()
    Menu:ShowCloseButton(false)
    Menu:MakePopup()
    Menu:SetTitle('')
    Menu.Paint = function( self, w, h )
        alpha_lerp = Lerp(FrameTime()*6,alpha_lerp or 0,alpha or 0) or 0

        local x, y = self:GetPos()
        draw.DrawBlur( x, y, self:GetWide(), self:GetTall(), alpha_lerp/100 )

        surface.SetMaterial(mat_bg)
        surface.DrawTexturedRect( x * -1, y * -1, ScrW(), ScrH() )
        --draw.RoundedBox(0,0,0,w,h,Color(52, 73, 94, alpha_lerp))
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

    local scrollpanel = vgui.Create('DScrollPanel',Menu)
    scrollpanel:SetSize(440,600)
    scrollpanel:SetPos(Menu:GetWide()*.5 - scrollpanel:GetWide()*.5, Menu:GetTall()*.5 - scrollpanel:GetTall()*.5)
    scrollpanel.Paint = function( self, w, h ) end

    local models = vgui.Create( "DListLayout", scrollpanel )
    models:Dock( FILL )

    for key, data in pairs(FEATURE_ARMORMODELS) do
        if data.check(LocalPlayer()) == true then
            local nextmodel = vgui.Create("DButton")
            nextmodel:SetSize(400, 20)
            nextmodel:SetText('')
            nextmodel.Paint = function( self, w, h )
                local col = self:IsHovered() and Color(255,255,255,30) or Color(255,255,255,20)
                draw.RoundedBox(0,0,0,w,h,col)
                -- draw.Icon(2,2,h-4,h-4,mat_point,color_white)
                draw.SimpleText('Załóż "'..data.name..'"', luna.MontBase18, 4, h/2, Color( 255, 255, 255, 255 ), 0, 1)
            end

            nextmodel.DoClick = function( self )
                netstream.Start('Cupboard_TakeModel', { name = key })
                Menu:Remove()
            end

            models:Add( nextmodel )
        end
    end

    local nextmodel = vgui.Create("DButton")
    nextmodel:SetSize(400, 20)
    nextmodel:SetText('')
    nextmodel.Paint = function( self, w, h )
        local col = self:IsHovered() and Color(255,255,255,30) or Color(255,255,255,20)
        draw.RoundedBox(0,0,0,w,h,col)
        -- draw.Icon(2,2,h-4,h-4,mat_point,color_white)
        draw.SimpleText('Zdejmij pancerz', luna.MontBase18, 4, h/2, Color( 255, 255, 255, 255 ), 0, 1)
    end

    nextmodel.DoClick = function( self )
        -- netstream.Start('NPCPortal_MakeProtals', { name = name, ent_index = ent_index })
        netstream.Start('Cupboard_TakeOffModel', nil)
        Menu:Remove()
    end

    models:Add( nextmodel )
end)

