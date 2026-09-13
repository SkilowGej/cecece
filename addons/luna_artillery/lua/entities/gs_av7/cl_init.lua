--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

net.Receive("Use-XYAV-7", function()
    local ent = net.ReadEntity()
    if ent and ent.AVUse then
        ent:AVUse()
    end
end)

function ENT:AVUse()
    local main = vgui.Create("EditablePanel")
    main:SetSize(ScrW() * 0.3, ScrH() * 0.2)
    main:Center()
    main:MakePopup()
    main.Paint = function(s,w,h)
        surface.SetDrawColor(10,10,10)
        surface.DrawRect(0,0,w,h)
    end

    local header = vgui.Create("EditablePanel", main)
    header:SetSize(main:GetWide(), main:GetTall() * 0.2)
    header.Paint = function(s,w,h)
        surface.SetDrawColor(255, 255, 255, 25)
        surface.DrawRect(0, 0, w, h)
    end

    local close = vgui.Create("DButton", header)
    close:SetSize(header:GetTall(), header:GetTall())
    close:SetX(header:GetWide() - close:GetWide())
    close:SetText("")
    close.Paint = function(s,w,h)
        draw.SimpleText("X", "Trebuchet24", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    close.DoClick = function()
        main:Remove()
    end

    local step = main:GetWide() * 0.05
    local X = vgui.Create("DTextEntry", main)
    X:SetSize((main:GetWide() / 2) - step, main:GetTall()*0.2)
    X:SetPos(step/2, main:GetTall()/2 - X:GetTall()/2)
    X:SetNumeric(true)
    X:SetValue(self:GetX())

    local Y = vgui.Create("DTextEntry", main)
    Y:SetSize((main:GetWide() / 2) - step, main:GetTall()*0.2)
    Y:SetPos(main:GetWide() - Y:GetWide() - step/2, main:GetTall()/2 - X:GetTall()/2)
    Y:SetNumeric(true)
    Y:SetValue(self:GetY())

    local fire = vgui.Create("DButton", main)
    fire:SetSize(main:GetWide() * 0.2, main:GetTall() * 0.2)
    fire:SetPos(main:GetWide() - fire:GetWide() - step/2, main:GetTall() - fire:GetTall() - step/2)
    fire:SetText("Огонь")
    fire.Color = Color(255,255,255,120)
    fire.Paint = function(s,w,h)
        if s:IsHovered() then
            s.Color.a = 160
        else
            s.Color.a = 120
        end
        surface.SetDrawColor(s.Color)
        surface.DrawRect(0,0,w,h)
    end

    fire.DoClick = function()
        if self:GetDelay() > CurTime() then
            return
        end
        
        net.Start("Fire-XYAV-7")
            net.WriteEntity(self)
        net.SendToServer()
    end

    local changeCoords = vgui.Create("DButton", main)
    changeCoords:SetSize(main:GetWide() * 0.4, main:GetTall() * 0.2)
    changeCoords:SetPos(main:GetWide() - changeCoords:GetWide() - fire:GetWide() - step, main:GetTall() - changeCoords:GetTall() - step/2)
    changeCoords:SetText("Zmień współrzędne")
    changeCoords.Color = Color(255,255,255,120)
    changeCoords.Paint = function(s,w,h)
        if s:IsHovered() then
            s.Color.a = 160
        else
            s.Color.a = 120
        end
        surface.SetDrawColor(s.Color)
        surface.DrawRect(0,0,w,h)
    end

    changeCoords.DoClick = function()
        local x = X:GetValue()
        local y = Y:GetValue()

        if x == "" or x == " " or y == "" or y == " " then
            return
        end

        x = tonumber(x)
        y = tonumber(y)

        if x >= OBBMapMins.x and x <= OBBMapMaxs.x or y >= OBBMapMins.y or y <= OBBMapMaxs.y then
            net.Start("Change-XYAV-7")
                net.WriteEntity(self)
                net.WriteFloat(x)
                net.WriteFloat(y)
            net.SendToServer()
        end
    end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
