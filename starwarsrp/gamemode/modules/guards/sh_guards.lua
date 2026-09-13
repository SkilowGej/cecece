function pMeta:IsArrested()
	return self:GetNWBool("Arrested") or self:GetNetVar("Arrested")
end

if CLIENT then

	netstream.Hook("DrawArestMenu", function(eTrace)
		Derma_NumberRequest("Aresztować \"" .. eTrace:Name() .. "\"", "Czas", 180, function(time)
			netstream.Start("ArrestPlayer", {
				pTarget = eTrace,
				time = time
			})
		end, function() end, "Aresztuj", "Anuluj")
	end)

	function Derma_NumberRequest(strTitle, strText, intDefault, fnEnter, fnCancel, strButtonText, strButtonCancelText)
		local Window = vgui.Create("DFrame")
		Window:SetTitle(strTitle or "Message Title (First Parameter)")
		Window:SetDraggable(false)
		Window:ShowCloseButton(false)
		Window:SetBackgroundBlur(true)
		Window:SetDrawOnTop(true)

		Window.Paint = function(self, w, h)
			draw.RoundedBox(6, 0, 0, w, h, Color(255, 255, 255, 5))
		end

		local InnerPanel = vgui.Create("DPanel", Window)
		InnerPanel:SetPaintBackground(false)
		-- local Text = vgui.Create( "DLabel", InnerPanel )
		-- Text:SetText( strText or "Message Text (Second Parameter)" )
		-- Text:SizeToContents()
		-- Text:SetContentAlignment( 5 )
		-- Text:SetTextColor( color_white )
		local DermaNumSlider = vgui.Create("DNumSlider", InnerPanel)
		-- TextEntry:SetText( strDefaultText or "" )
		-- TextEntry.OnEnter = function() Window:Close() fnEnter( TextEntry:GetValue() ) end
		DermaNumSlider:SetPos(50, 50)
		DermaNumSlider:SetSize(300, 100)
		DermaNumSlider:SetText(strText)
		DermaNumSlider:SetMin(0)
		DermaNumSlider:SetMax(1800)
		DermaNumSlider:SetDecimals(0)
		DermaNumSlider:SetValue(intDefault)

		-- DermaNumSlider.Paint = function( self, w, h )
		-- 	draw.RoundedBox(6,0,0,w,h,Color(0,0,0,90))
		-- 	surface.SetDrawColor(Color(255,255,255,90))
		-- 	surface.DrawOutlinedRect( 0, 0, w, h )
		-- 	surface.DrawLine(w*.5,0,w*.5,w)
		-- end
		DermaNumSlider.PerformLayout = function()
			DermaNumSlider:GetTextArea():SetWide(0)
			-- DermaNumSlider.Label:SetWide(0)
			-- DermaNumSlider.Slider:SetPos(0,0)
			DermaNumSlider.Slider.Knob:SetSize(18, 18)

			-- DermaNumSlider.Slider.Paint = function( self, w, h ) end
			DermaNumSlider.Slider.Knob.Paint = function(self, w, h)
				local pos_x = DermaNumSlider:GetValue() == DermaNumSlider:GetMax() and -1 or (DermaNumSlider:GetValue() == DermaNumSlider:GetMin() and 1 or 0)
				draw.RoundedBox(10, pos_x, 0, w, h, Color(0, 0, 0, 180))
			end
		end

		local ButtonPanel = vgui.Create("DPanel", Window)
		ButtonPanel:SetTall(30)
		ButtonPanel:SetPaintBackground(false)
		local Button = vgui.Create("DButton", ButtonPanel)
		Button:SetText("")
		Button:SizeToContents()
		Button:SetTall(20)
		Button:SetWide(100)
		Button:SetPos(5, 5)

		Button.DoClick = function()
			Window:Close()
			fnEnter(DermaNumSlider:GetValue())
		end

		local ButtonCancel = vgui.Create("DButton", ButtonPanel)
		ButtonCancel:SetText("")
		ButtonCancel:SizeToContents()
		ButtonCancel:SetTall(20)
		ButtonCancel:SetWide(Button:GetWide() + 20)
		ButtonCancel:SetPos(5, 5)

		ButtonCancel.DoClick = function()
			Window:Close()

			if fnCancel then
				fnCancel(DermaNumSlider:GetValue())
			end
		end

		ButtonCancel:MoveRightOf(Button, 5)
		ButtonPanel:SetWide(Button:GetWide() + 5 + ButtonCancel:GetWide() + 10)

		ButtonCancel.Paint = function(self, w, h)
			draw.RoundedBox(6, 0, 0, w, h, Color(0, 0, 0, 150))
			surface.SetDrawColor(0, 0, 0, 100)
			surface.DrawOutlinedRect(0, 0, w, h, 1)
			draw.SimpleText(strButtonCancelText or "Cancel", luna.MontBaseSmall, w * .5, h * .5, Color(255, 255, 255, 255), 1, 1)
		end

		Button.Paint = function(self, w, h)
			draw.RoundedBox(6, 0, 0, w, h, Color(0, 0, 0, 150))
			surface.SetDrawColor(0, 0, 0, 100)
			surface.DrawOutlinedRect(0, 0, w, h, 1)
			draw.SimpleText(strButtonText or "OK", luna.MontBaseSmall, w * .5, h * .5, Color(255, 255, 255, 255), 1, 1)
		end

		-- local w, h = Text:GetSize()
		-- w = math.max( w, 400 )
		Window:SetSize(300, 100)
		Window:Center()
		InnerPanel:StretchToParent(5, 25, 5, 5)
		-- Text:StretchToParent( 5, 5, 5, 35 )
		DermaNumSlider:StretchToParent(5, nil, 5, nil)
		DermaNumSlider:AlignBottom(5)
		-- DermaNumSlider:RequestFocus()
		-- DermaNumSlider:SelectAllText( true )
		ButtonPanel:CenterHorizontal()
		ButtonPanel:AlignBottom(8)
		Window:MakePopup()
		Window:DoModal()

		return Window
	end
end