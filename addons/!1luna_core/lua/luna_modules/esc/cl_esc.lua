--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local function AddIcon(material, x, y, w, h, color)
    surface.SetDrawColor(color)
    surface.SetMaterial(material)
	surface.DrawTexturedRect(x, y, w, h)
end

local function NewClose(pnl)
    pnl:AlphaTo(0, 0.4, 0, function(data, panel)
        if IsValid(pnl) then
            pnl:Remove()
        end
    end)
end

local mats = {
    logo = Material('luna_sup_brand/main_logo_swrp.png');
    -- greetings = Material('sincopa/esc/konkurs.png');
    -- update = Material('sincopa/esc/car.png');
}

local col = {
    white = Color(255, 255, 255,255);
    white_hover = Color(7, 110, 203,255);
    
    btn = Color(22, 23, 28, 150);
    btn_hover = Color(22, 23, 28, 150);

    gray = Color(255,255,255,100);
    gray_hover = Color(255,255,255,100);

    -- out = Color(63, 63, 63);

    -- out2 = Color(47, 47, 47);
    -- out2_hover = Color(47, 47, 47, 150);
}

local box = draw.RoundedBox

local fr
function esc.openMenu()

	if IsValid(fr) and not fr.Closed then
        NewClose(fr)
		fr.Closed = true

		return
	elseif IsValid(fr) and fr.Closed then
		fr:SetVisible(true)
		fr.Closed = false

		return
	end

	fr = vgui.Create('DPanel')
	fr:SetSize(ScrW(), ScrH())
	fr:SetPos(0, 0)
	fr:MakePopup()
	fr:SetKeyboardInputEnabled(false)
    fr:SetAlpha(0)
    fr:AlphaTo(255, 0.4 )

	fr.Paint = function(self)
		Derma_DrawBackgroundBlur(self)

        AddIcon( mats.logo, 60, -50, 536, 356, Color(255,255,255) )
	end

    local frW, frH = fr:GetSize()

    local pnl = fr:Add('Panel')
    pnl:SetSize(frW*.25, frH*.71)
    pnl:SetPos(94, 250)

    for _, v in ipairs( esc.buttons ) do
        local item = pnl:Add('DButton')
        item:Dock(TOP)
        item:SetTall(60)
        item:DockMargin(0, 0, 0, 10)
        item:SetText('')

        item.Paint = function(self, w, h)
            box( 8, 0, 0, w, h, self.Hovered and col.btn_hover or col.btn )
            AddIcon( v.Icon, 24, h*0.5-34*0.5, 34, 34, self.Hovered and col.white_hover or col.white )
            box( 0, 70, h*0.5-34*0.5, 1, 34, col.white )
            draw.SimpleText( v.Name, luna.MontBase24, 90, 5, self.Hovered and col.white_hover or col.white, 0, 3 )
            draw.SimpleText( v.Description, luna.Roboto15, 90, 35, self.Hovered and col.gray_hover or col.gray, 0, 3 )
        end

        item.DoClick = v.DoClick
    end

    local greetings = fr:Add('Panel')
    greetings:SetSize(595, 292)
    greetings:SetPos( frW - greetings:GetWide() - 78, ( frH * 0.5 - greetings:GetTall() * 0.5 ) - 150 )

    greetings.Paint = function(self, w, h)
        --AddIcon( mats.greetings, 0, 0, w, h, col.white )
        box( 8, 0, 0, w, h, col.btn)
    end

    local title = greetings:Add('DLabel')
    title:SetFont(luna.MontBase30)
    title:SetTextColor(col.white)
    title:SetText(esc.cfg.konkurs_title)
    title:SizeToContents()
    title:SetPos(38, 30)

    local desc = greetings:Add('DLabel')
    desc:SetFont(luna.MontBase18)
    desc:SetTextColor(col.gray)
    desc:SetText(esc.cfg.konkurs_desc)
    desc:SetSize(500, 150)
    desc:SetPos(38, 78)
    desc:SetWrap(true)

    local read = greetings:Add('DButton')
    read:SetSize(200, 45)
    read:SetPos( 39, greetings:GetTall() - read:GetTall() - 20 )
    read:SetText('')

    read.Paint = function(self, w, h)
        box( 8, 0, 0, w, h, Color(0,0,0,0) )
        box( 8, 2, 2, w - 4, h - 4, self.Hovered and col.white_hover or col.btn )
        draw.SimpleText( 'Wejdź w link', luna.MontBaseHud, w*0.5, h*0.5, col.white, 1, 1 )
    end

    read.DoClick = function(self, w, h)
        gui.OpenURL(esc.cfg.konkurs_link)
        surface.PlaySound("luna_ui/click3.wav")
    end

    local update = fr:Add('Panel')
    update:SetSize(595, 292)
    update:SetPos( frW - update:GetWide() - 78, ( frH * 0.5 - update:GetTall() * 0.5 ) + 150 )

    update.Paint = function(self, w, h)
        -- AddIcon( mats.update, 0, 0, w, h, col.white )
        box( 8, 0, 0, w, h, col.btn)
    end

    local title2 = update:Add('DLabel')
    title2:SetFont(luna.MontBase30)
    title2:SetTextColor(col.white)
    title2:SetText(esc.cfg.update_title)
    title2:SizeToContents()
    title2:SetPos(38, 30)

    local desc2 = update:Add('DLabel')
    desc2:SetFont(luna.MontBase18)
    desc2:SetTextColor(col.gray)
    desc2:SetText(esc.cfg.update_desc)
    desc2:SetSize(500, 150)
    desc2:SetPos(38, 78)
    desc2:SetWrap(true)

    local read2 = update:Add('DButton')
    read2:SetSize(200, 45)
    read2:SetPos( 39, update:GetTall() - read2:GetTall() - 20 )
    read2:SetText('')

    read2.Paint = function(self, w, h)
        box( 8, 0, 0, w, h, Color(0,0,0,0) )
        box( 8, 2, 2, w - 4, h - 4, self.Hovered and col.white_hover or col.btn )
        draw.SimpleText( 'Wejdź w link', luna.MontBaseHud, w*0.5, h*0.5, col.white, 1, 1 )
    end

    read2.DoClick = function(self, w, h)
        gui.OpenURL(esc.cfg.update_link)
        surface.PlaySound("luna_ui/click3.wav")
    end
end

hook.Add('PreRender', 'esc_prerender', function()
	if input.IsKeyDown(KEY_ESCAPE) and gui.IsGameUIVisible() then
		if ValidPanel(fr) then
			gui.HideGameUI()
			esc.openMenu()
		else
			gui.HideGameUI()
			esc.openMenu()
		end
		return true
	end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
