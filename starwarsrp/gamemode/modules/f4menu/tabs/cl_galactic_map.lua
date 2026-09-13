local PANEL = {}

local color_grey = Color(150, 150, 150, 105)
local planets = GALACTIC_MAP

function PANEL:Init()
    self.map = self:Add('DHorizontalScroller')
    self.map:SetOverlap(-5)
    self.map:Dock(FILL)

    self.configPlanets = self:Add('gm.config.panel')
    self.configPlanets:SetSize(scale(450), scale(800))
    self.configPlanets:SetHeader('USTAWIENIE PLANET')
    self.configPlanets:SetWarning('Zachowaj spójność tekstu, unikaj błędów gramatycznych i staraj się przedstawić wszystkie informacje w sposób zwięzły, ale przystępny, korzystając z dostępnych funkcji!')
    self.configPlanets:SetDesc(' Konfiguracja informacji o planecie, jej status. Zadania i postępy w podboju. \n\n Jeśli wypełniłeś już wszystkie dane, możesz wskazać zadania, które zostały już wykonane.')

    local choosePlanet = self.configPlanets:AddBody('DButton')
    choosePlanet:SetSize(self.configPlanets:GetWide() - scale(20), scale(40))
    choosePlanet:SetPos(self.configPlanets:GetWide()*.5 - choosePlanet:GetWide()*.5, scale(20))
    choosePlanet:SetText('')
    local curPlanet = 0

    choosePlanet.Paint = function(s, w, h)
        surface.SetDrawColor(0, 0, 0, 100)
        surface.DrawRect(0, 0, w, h)

        draw.DrawText(curPlanet > 0 and planets[curPlanet].name or 'WYBIERZ PLANETĘ', luna.MontBase22, 10, scale(10), color_grey, TEXT_ALIGN_LEFT)
    end

    choosePlanet.DoClick = function(s)
        if IsValid(scroll) and scroll:IsValid() then
            scroll:Remove()
        end

        scroll = vgui.Create('DScrollPanel')
        scroll:SetSize(scale(200), scale(300))
        scroll:SetPos(input.GetCursorPos())
        scroll:SetDrawOnTop(true)
        scroll:MakePopup()


        scroll.Paint = function(s, w, h)
            surface.SetDrawColor(0, 0, 0, 100)
            surface.DrawRect(0, 0, w, h)
        end

        scroll.Think = function()
            if !(IsValid(choosePlanet) and choosePlanet:IsValid()) then
                scroll:Remove()
            end
        end

        for index, planet in ipairs(planets) do
            local but = scroll:Add('DButton')
            but:SetTall(scale(30))
            but:Dock(TOP)
            but:DockMargin(0, 3, 0, 0)
            but:SetText('')
            but.Paint = function(s, w, h)
                draw.DrawText(planet.name, luna.MontBase18, 0, 0, color_grey, TEXT_ALIGN_LEFT)
            end
            
            but.DoClick = function(s)
                if IsValid(scroll) then scroll:Remove() end
                curPlanet = index
            end
        end
        
    end

    local TextEntry = self.configPlanets:AddBody('DTextEntry')
    TextEntry:SetSize(self.configPlanets:GetWide() - scale(20), scale(150))
    TextEntry:SetPos(self.configPlanets:GetWide()*.5 - TextEntry:GetWide()*.5, scale(80))
    TextEntry:SetFont(luna.MontBase24)
    TextEntry:SetPlaceholderText('OPIS')
    TextEntry:SetPlaceholderColor(color_grey)
    
    TextEntry.Paint = function(s, w, h)
        surface.SetDrawColor(0, 0, 0, 100)
        surface.DrawRect(0, 0, w, h)

        s:DrawTextEntryText(Color(255,255,255,240), Color(0,165,255,255), Color(255,255,255,240))
    end

    local WarTask = WarTask or {}
    local WarInfo = WarInfo or {}
    for i = 1, 5 do
        WarTask[i] = self.configPlanets:AddBody('DTextEntry')
        WarTask[i]:SetSize(self.configPlanets:GetWide() - scale(20), scale(40))
        WarTask[i]:SetPos(self.configPlanets:GetWide()*.5 - WarTask[i]:GetWide()*.5, scale(190 + (i*45)))
        WarTask[i]:SetFont(luna.MontBase24)
        WarTask[i]:SetPlaceholderColor(color_grey)
        
        WarTask[i].Paint = function(s, w, h)
            surface.SetDrawColor(0, 0, 0, 100)
            surface.DrawRect(0, 0, w, h)

            if s:GetValue() == '' then
                draw.DrawText(i..' ZADANIE WOJSKOWE', luna.MontBase24, 5, 5, color_grey, TEXT_ALIGN_LEFT)
            end
    
            s:DrawTextEntryText(Color(255,255,255,240), Color(0,165,255,255), Color(255,255,255,240))
        end

    end

    local PlanetPrice = self.configPlanets:AddBody('DTextEntry')
    PlanetPrice:SetSize(self.configPlanets:GetWide() - scale(20), scale(40))
    PlanetPrice:SetPos(self.configPlanets:GetWide()*.5 - PlanetPrice:GetWide()*.5, scale(460))
    PlanetPrice:SetFont(luna.MontBase24)
    PlanetPrice.Paint = function(s, w, h)
        surface.SetDrawColor(0, 0, 0, 100)
        surface.DrawRect(0, 0, w, h)

        if s:GetValue() == '' then
            draw.DrawText('WARTOŚĆ PLANETY', luna.MontBase24, 5, 5, color_grey, TEXT_ALIGN_LEFT)
        end

        s:DrawTextEntryText(Color(255,255,255,240), Color(0,165,255,255), Color(255,255,255,240))
    end

    self.configPlanets.btn.DoClick = function(s)
        for i=1, 5 do
            WarInfo[i] = WarTask[i]:GetValue()
        end
        net.Start('GalacticMap:GetInfoConfig')
        net.WriteInt(curPlanet, 10)
        net.WriteTable(WarInfo)
        net.WriteString(TextEntry:GetValue())
        net.WriteString(PlanetPrice:GetValue())
        net.SendToServer()
    end

    self.map:AddPanel(self.configPlanets)

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    self.orderFrom = self:Add('gm.config.panel')
    self.orderFrom:SetSize(scale(450), scale(500))
    self.orderFrom:SetHeader('ROZKAZ SZTABU')
    self.orderFrom:SetWarning('Nie zmieniaj rozkazu bez powodu! Spowoduje to dla Ciebie opłakane konsekwencje.')
    self.orderFrom:SetDesc(' Globalne zadanie przekazane przez sztab generalny Wielkiej Armii Republiki.')

    local orderFromTextEntry = self.orderFrom:AddBody('DTextEntry')
    orderFromTextEntry:SetSize(self.orderFrom:GetWide() - scale(20), scale(150))
    orderFromTextEntry:SetPos(self.orderFrom:GetWide()*.5 - orderFromTextEntry:GetWide()*.5, scale(40))
    orderFromTextEntry:SetFont(luna.MontBase24)
    orderFromTextEntry:SetPlaceholderText('OPIS')
    orderFromTextEntry:SetPlaceholderColor(color_grey)
    
    orderFromTextEntry.Paint = function(s, w, h)
        surface.SetDrawColor(0, 0, 0, 100)
        surface.DrawRect(0, 0, w, h)

        if s:GetValue() == '' then
            draw.DrawText('ROZKAZ', luna.MontBase24, 5, 5, color_grey, TEXT_ALIGN_LEFT)
        end

        s:DrawTextEntryText(Color(255,255,255,240), Color(0,165,255,255), Color(255,255,255,240))
    end

    local headerOrderFromTextEntry = self.orderFrom:AddBody('DTextEntry')
    headerOrderFromTextEntry:SetSize(self.orderFrom:GetWide() - scale(20), scale(40))
    headerOrderFromTextEntry:SetPos(self.orderFrom:GetWide()*.5 - headerOrderFromTextEntry:GetWide()*.5, scale(210))
    headerOrderFromTextEntry:SetFont(luna.MontBase24)
    headerOrderFromTextEntry:SetPlaceholderText('OPIS')
    headerOrderFromTextEntry:SetPlaceholderColor(color_grey)
    
    headerOrderFromTextEntry.Paint = function(s, w, h)
        surface.SetDrawColor(0, 0, 0, 100)
        surface.DrawRect(0, 0, w, h)

        if s:GetValue() == '' then
            draw.DrawText('TYTUŁ ROZKAZU', luna.MontBase24, 5, 5, color_grey, TEXT_ALIGN_LEFT)
        end

        s:DrawTextEntryText(Color(255,255,255,240), Color(0,165,255,255), Color(255,255,255,240))
    end

    self.orderFrom.btn.DoClick = function(s)
        net.Start('GalacticMap:GetInfoConfigOrderFrom')
        net.WriteString(orderFromTextEntry:GetValue())
        net.WriteString(headerOrderFromTextEntry:GetValue())
        net.SendToServer()
    end

    self.map:AddPanel(self.orderFrom)

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    self.warCompany = self:Add('gm.config.panel')
    self.warCompany:SetSize(scale(450), scale(500))
    self.warCompany:SetHeader('KAMPANIA WOJENNA')
    self.warCompany:SetWarning('Lokalne zadanie wydane przez dowództwo 13. Armii Sektorowej')
    self.warCompany:SetDesc(' Nie zmieniaj rozkazu bez powodu! Spowoduje to dla Ciebie opłakane konsekwencje.')

    local warCompanyTextEntry = self.warCompany:AddBody('DTextEntry')
    warCompanyTextEntry:SetSize(self.warCompany:GetWide() - scale(20), scale(150))
    warCompanyTextEntry:SetPos(self.warCompany:GetWide()*.5 - warCompanyTextEntry:GetWide()*.5, scale(40))
    warCompanyTextEntry:SetFont(luna.MontBase24)
    warCompanyTextEntry:SetPlaceholderText('OPIS')
    warCompanyTextEntry:SetPlaceholderColor(color_grey)
    
    warCompanyTextEntry.Paint = function(s, w, h)
        surface.SetDrawColor(0, 0, 0, 100)
        surface.DrawRect(0, 0, w, h)

        if s:GetValue() == '' then
            draw.DrawText('ROZKAZ', luna.MontBase24, 5, 5, color_grey, TEXT_ALIGN_LEFT)
        end

        s:DrawTextEntryText(Color(255,255,255,240), Color(0,165,255,255), Color(255,255,255,240))
    end

    local headerWarCompanyTextEntry = self.warCompany:AddBody('DTextEntry')
    headerWarCompanyTextEntry:SetSize(self.warCompany:GetWide() - scale(20), scale(40))
    headerWarCompanyTextEntry:SetPos(self.warCompany:GetWide()*.5 - headerWarCompanyTextEntry:GetWide()*.5, scale(210))
    headerWarCompanyTextEntry:SetFont(luna.MontBase24)
    headerWarCompanyTextEntry:SetPlaceholderText('OPIS')
    headerWarCompanyTextEntry:SetPlaceholderColor(color_grey)
    
    headerWarCompanyTextEntry.Paint = function(s, w, h)
        surface.SetDrawColor(0, 0, 0, 100)
        surface.DrawRect(0, 0, w, h)

        if s:GetValue() == '' then
            draw.DrawText('TYTUŁ ROZKAZU', luna.MontBase24, 5, 5, color_grey, TEXT_ALIGN_LEFT)
        end

        s:DrawTextEntryText(Color(255,255,255,240), Color(0,165,255,255), Color(255,255,255,240))
    end

    self.warCompany.btn.DoClick = function(s)
        net.Start('GalacticMap:GetInfoConfigWarCompany')
        net.WriteString(warCompanyTextEntry:GetValue())
        net.WriteString(headerWarCompanyTextEntry:GetValue())
        net.SendToServer()
    end

    self.map:AddPanel(self.warCompany)
end

function PANEL:Paint(w, h)
end

vgui.Register( 'gm.tab.galacticmap', PANEL, 'EditablePanel' )