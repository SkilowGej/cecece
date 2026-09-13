include('shared.lua')

local icon_size = 150
local mat_wep1 = Material('luna_icons/jigsaw-box.png', 'smooth noclamp')

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
				draw.ShadowSimpleText( 'Oficer Gustman', luna.NPC1, -3, 0, Color(17, 148, 240), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
				draw.ShadowSimpleText( 'Oficer Gustman', luna.NPC1Neon, -3, 0, Color(17, 148, 240), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
				draw.ShadowSimpleText( 'Nadzoruje logistykę Armii Sektorowej', luna.NPC2, -3, 70, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
                --draw.ShadowSimpleText( self:GetUses() .. '/30', luna.NPC2, -3, 110, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
			render.PopFilterMin()
		cam.End3D2D()
	end
end

surface.CreateFont( 'tickets.1', {
	font = 'Mont Heavy';
	size = scale(48);
	antialias = true;
	extended = true;
	weight = 350;
} )

surface.CreateFont( 'tickets.2', {
	font = 'Mont Heavy';
	size = scale(36);
	antialias = true;
	extended = true;
	weight = 350;
} )

surface.CreateFont( 'tickets.3', {
	font = 'Mont Bold';
	size = scale(24);
	antialias = true;
	extended = true;
	weight = 350;
} )

surface.CreateFont( 'tickets.4', {
	font = 'Mont Heavy';
	size = scale(24);
	antialias = true;
	extended = true;
	weight = 350;
} )

local col = {
	back = Color(22, 23, 28, 150);
	outline = Color( 200, 200, 200, 100 );
	outline2 = Color( 200, 200, 200, 10 );
	white = Color( 255, 255, 255 );
	close = Color(206, 31, 19, 150);
}

net.Receive( 'Tickets:Sync', function()
	GMap.Vehicles = net.ReadTable()
end )

local btnsTable = {
	'ZAKUP SPRZĘTU';
	'MAGAZYN';
}

local vehicles = VEHICLES_FEATURES

local headerH = scale(80)
local mat_logo = Material( 'luna_icons/jigsaw-box.png', 'smooth mips' )

local fr
net.Receive( 'Tickets:Menu', function()
	if IsValid( fr ) then return end

    local tickets = string.Comma( GetTickets() ).. 'Т'

	fr = vgui.Create( 'EditablePanel' )
	fr:SetSize( scale(1100), scale(700) )
	fr:Center()
	fr:MakePopup()
	fr:SetAlpha(0)
	fr:AlphaTo( 255, 0.3 )

	fr:DockPadding( scale(10), headerH + scale(10), scale(10), scale(10) )
	
	fr.startTime = SysTime()
	fr.selectedClass, fr.price = nil, nil

	fr.OnKeyCodeReleased = function( self, key )
		if key == KEY_ESCAPE then
			if esc then
				esc.openMenu()
			end
			if IsValid(self) then
				self:AlphaTo(0, 0.3, 0, function()
					self:Remove()
				end)
			end
			gui.HideGameUI()
		end
	end

	fr.Paint = function( self, w, h )
		Derma_DrawBackgroundBlur(self, self.startTime)

		draw.NewRect( 0, 0, w, h, col.back )
		draw.NewRect( 0, 0, w, headerH, col.back )
		draw.Image( scale(10), scale(15), scale(48), scale(48), mat_logo, col.white )

		-- draw.SimpleText( 'ЛОГИСТИЧЕСКИЙ ДАТА-ЦЕНТР', 'tickets.1', headerH, scale(15), col.white, 0, 3 )
		draw.markupText({
            text = {
                {text = 'CENTRUM LOGISTYCZNE — ', font = 'tickets.1', color = {r = 255, g = 255, b = 255}},
                {text = tickets, font = 'tickets.1', color = {r = 255, g = 215, b = 0}}
            },
            x = headerH,
            y = scale(15),
            alignX = 0,
            alignY = 3
        })
	end

	local close = fr:Add( 'DButton' )
	close:SetSize( headerH, headerH )
	close:SetX( fr:GetWide() - close:GetWide() )
	close:SetText''

	close.Paint = function( self, w, h )
		draw.NewRect( 0, 0, w, h, col.close )
		draw.SimpleText( '✖', 'tickets.1', w*.5, h*.5, col.white, 1, 1 )

		return true
	end

	close.DoClick = function()
		if IsValid(fr) then
			fr:AlphaTo(0, 0.3, 0, function()
				fr:Remove()
			end)
		end
	end

	local panelLeft = fr:Add( 'Panel' )
	panelLeft:Dock(LEFT)
	panelLeft:SetWide( fr:GetWide() * .5 - scale(12) )

	local panelRight = fr:Add( 'EditablePanel' )
	panelRight:Dock(RIGHT)
	panelRight:SetWide( fr:GetWide() * .5 - scale(12) )

	local btn = panelRight:Add( 'DButton' )
	btn:Dock(BOTTOM)
	btn:SetTall( scale(40) )
	btn:SetText''

	btn.Paint = function( self, w, h )
		draw.NewRect( 0, 0, w, h, col.back )
		draw.SimpleText( 'KUP', 'tickets.3', w*.5, h*.5, col.white, 1, 1 )

		return true
	end

	local count = panelRight:Add( 'gmap.entry' )
	count:Dock(BOTTOM)
	count:SetTall( scale(40) )
	count:SetHolderText( 'ILOŚĆ SZTUK' )
	count:DockMargin( 0, scale(10), 0, scale(5) )
	count:SetNumeric( true )

	btn.DoClick = function()
		local countVeh = count:GetValue()
		if not fr.selectedClass or fr.selectedClass == nil then return end
        if not countVeh or countVeh == '' then return end

		net.Start( 'Tickets:Buy' )
			net.WriteUInt( countVeh, 8 )
			net.WriteString( fr.selectedClass )
			net.WriteUInt( fr.price, 16 )
		net.SendToServer()
	end

	local scroll = panelRight:Add( 'achievements.scroll' )
	scroll:Dock(FILL)
	scroll.pnl = nil

	scroll.Paint = function( self, w, h )
		draw.NewRect( 0, 0, w, h, col.back )

		surface.SetDrawColor( col.outline )
		surface.DrawOutlinedRect( 0, 0, w, h, 2 )
	end

	for i = 1, #btnsTable do
		local name = btnsTable[i]
		
		local item = panelLeft:Add( 'DButton' )
		item:Dock(TOP)
		item:SetTall( scale(100) )
		item:DockMargin( scale(50), scale(50), scale(50), 0 )
		item:SetText''

		item.Paint = function( self, w, h )
			draw.NewRect( 0, 0, w, h, col.back )

			surface.SetDrawColor( col.outline )
			surface.DrawOutlinedRect( 0, 0, w, h, 2 )

			draw.SimpleText( name, 'tickets.2', w*.5, h*.5, col.white, 1, 1 )
			return true
		end

		item.DoClick = function()
			scroll:Clear()

			if i == 1 then
				btn:Show()
				count:Show()

				for feature, data in pairs(VEHICLES_FEATURES) do
					for class, veh in pairs(data) do

						local price = string.Comma( veh.gmapPrice ).. 'T'

						local item = scroll:Add( 'DButton' )
						item:Dock(TOP)
						item:SetTall( scale(40) )
						item:DockMargin( scale(1), 0, scale(1), 0 )
						item:SetText''

						item.Paint = function( self, w, h )
							draw.NewRect( 0, 0, w, h, col.back )

							if scroll.pnl == self then
								draw.NewRect( 0, 0, w, h, col.outline )
							end

							draw.NewRect( 0, h - scale(1), w, scale(1), col.outline2 )

							draw.markupText({
								text = {
									{text = veh.name.. ' — ', font = 'tickets.3', color = {r = 255, g = 255, b = 255}},
									{text = price, font = 'tickets.4', color = {r = 255, g = 215, b = 0}}
								},
								x = scale(10),
								y = h*.5,
								alignX = 0,
								alignY = 1
							})
							return true
						end

						item.DoClick = function( self )
							scroll.pnl = self
							fr.selectedClass, fr.price = class, veh.gmapPrice
						end
					end
				end
			else
				btn:Hide()
				count:Hide()

				for class, count in pairs( GMap.Vehicles ) do
					if count <= 0 then continue end

					local item = scroll:Add( 'Panel' )
					item:Dock(TOP)
					item:SetTall( scale(40) )
					item:DockMargin( scale(1), 0, scale(1), 0 )
					item:SetText''

					item.Paint = function( self, w, h )
						draw.NewRect( 0, 0, w, h, col.back )

						draw.NewRect( 0, h - scale(1), w, scale(1), col.outline2 )

						draw.markupText({
							text = {
								{text = class.. ' — ', font = 'tickets.3', color = {r = 255, g = 255, b = 255}},
								{text = count.. ' szt.', font = 'tickets.4', color = {r = 255, g = 215, b = 0}}
							},
							x = scale(10),
							y = h*.5,
							alignX = 0,
							alignY = 1
						})
					end
				end

			end
		end
		if i == 1 then
			item.DoClick()
		end
	end
end )