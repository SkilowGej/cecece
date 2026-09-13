--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

JoeFort = JoeFort or {}
/*
JoeFort
JoeFort.structs
*/

-- surface.CreateFont( luna.MontBase24, {
-- 	font = "Montserrat ExtraBold", 
-- 	extended = true,
--     antialias = true,
-- 	size = 30,
-- } )

-- surface.CreateFont( "JoeFort40", {
-- 	font = "Montserrat ExtraBold", 
-- 	extended = true,
--     antialias = true,
-- 	size = 40,
-- } )

-- surface.CreateFont( "JoeFort50", {
-- 	font = "Montserrat ExtraBold", 
-- 	extended = true,
--     antialias = true,
-- 	size = 50,
-- } )

-- surface.CreateFont( "JoeFortclose", {
-- 	font = "Arial", 
-- 	extended = true,
--     antialias = true,
-- 	size = 50,
-- } )

local col1 = Color(255, 255, 255)
local colhover = Color(7, 110, 203)
local col2 = Color(0, 0, 0, 150)
local col4 = Color(255, 0, 0, 255)
local col5 = Color(17, 148, 240)

local frame
function JoeFort:OpenFortMenu(wep)
    if IsValid(frame) then frame:Remove() end
    frame = vgui.Create("DFrame")
    frame:SetSize(500, 700)
    frame:Center()
    frame:ShowCloseButton(false)
    frame:SetTitle("")
    frame:MakePopup()
    frame.Paint = function(s,w,h)
        -- surface.SetDrawColor(col2)
        draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 150))
        --surface.SetDrawColor(col1)
        --surface.DrawOutlinedRect(0, 0, w, h, 3)

        --surface.SetDrawColor(col2)
        --surface.DrawRect(50, 25, 400, 50)
        --surface.SetDrawColor(col1)
        --surface.DrawOutlinedRect(50, 25, 400, 50, 3)
        draw.ShadowSimpleText("Tablet inżynierski", luna.MontBase24, 250, 22.5, col5, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

        -- surface.SetDrawColor(col2)
        --draw.RoundedBox(15, 3, 647, 494, 50, Color(0, 0, 0, 100))
        -- surface.SetDrawColor(col1)
        -- surface.DrawRect(3, 644, 494, 3)
        draw.ShadowSimpleText("Zasoby budowlane: " .. JoeFort.Ressources, luna.MontBase24, 250, 650, col1, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end

    local clsbtn = vgui.Create("DButton", frame)
    clsbtn:SetSize(25, 25)
    clsbtn:SetPos(467,8)
    clsbtn:SetText("")
    clsbtn.DoClick = function()
        frame:Remove()
    end
    clsbtn.Paint = function(s,w,h)
        draw.ShadowSimpleText("X", "DermaLarge", 12.5, 12.5, col4, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local dlist = vgui.Create("DScrollPanel", frame)
    dlist:SetSize(500, 540)
    dlist:GetVBar():SetSize(0,0)
    dlist:SetPos(0,100)
    dlist.Paint = function(s,w,h)
    end

    surface.SetFont(luna.MontBase24)
    for category,data in pairs(JoeFort.structs) do
        local sizex = surface.GetTextSize(category) + 50
        local cat = vgui.Create("DButton", dlist)
        cat:SetSize(sizex , 50)
        cat:Dock(TOP)
        cat:SetText("")
        local dist = (500 - sizex ) * 0.5
        cat:DockMargin(dist, 0, dist, 20)
        cat.Paint = function(s,w,h)
            if s:IsHovered() then
                surface.SetDrawColor(colhover)
            else
                surface.SetDrawColor(col2)
            end
            surface.DrawRect(0, 0, w, h)
            --surface.SetDrawColor(col1)
            --surface.DrawOutlinedRect(0, 0, sizex, h, 3)
            draw.ShadowSimpleText(category, luna.MontBase24, sizex * 0.5, 25, s:IsHovered() and col1 or col1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        cat.DoClick = function()
            if not IsValid(wep) or wep:GetClass() != "fort_datapad" then return end
            surface.PlaySound("buttons/button17.wav")
            wep.selectcat = category 
            wep.selectnum = 1
            wep.selectmdl = JoeFort.structs[category][1].model

            net.Start("JoeFort_updatedata")
            net.WriteEntity(wep)
            net.WriteString(category)
            net.SendToServer()
            frame:Remove()
        end
    end

end


function JoeFort:OpenAdminFortMenu()
    if IsValid(frame) then frame:Remove() end
    frame = vgui.Create("DFrame")
    frame:SetSize(400, 200)
    frame:Center()
    frame:ShowCloseButton(false)
    frame:SetTitle("")
    frame:MakePopup()
    frame.Paint = function(s,w,h)
        surface.SetDrawColor(col2)
        surface.DrawRect(0, 0, w, h, Color(0, 0, 0, 150))
        --surface.SetDrawColor(col1)
        --surface.DrawOutlinedRect(0, 0, w, h, 3)

        draw.ShadowSimpleText("Zasoby: " .. JoeFort.Ressources, luna.MontBase24, 20, 10, col1, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end

    local text = vgui.Create("DTextEntry", frame)
    text:SetSize(100, 40)
    text:SetPos(150,60)
    text:SetFont(luna.MontBase24)
    text:SetNumeric(true)
    text.Paint = function(s,w,h)
        surface.SetDrawColor(col2)
        surface.DrawRect(0, 0, w, h)
        --surface.SetDrawColor(col1)
        --surface.DrawOutlinedRect(0, 0, w, h, 3)
        s:DrawTextEntryText(col1, col2, col2)
    end

    local clsbtn = vgui.Create("DButton", frame)
    clsbtn:SetSize(25, 25)
    clsbtn:SetPos(367,8)
    clsbtn:SetText("")
    clsbtn.DoClick = function()
        frame:Remove()
    end
    clsbtn.Paint = function(s,w,h)
        draw.ShadowSimpleText("X", "DermaLarge", 12.5, 12.5, col4, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local btn = vgui.Create("DButton", frame)
    btn:SetSize(100, 40)
    btn:SetPos(150,120)
    btn:SetText("")
    btn.DoClick = function()
        local val = text:GetValue()
        if not val or val == "" then return end
        val = tonumber(val)
        if val == 0 then return end
        
        net.Start("JoeFort_updateresourcepool")
        net.WriteInt(val, 32)
        net.SendToServer()
        
        frame:Remove()
    end
    btn.Paint = function(s,w,h)
        if s:IsHovered() then
            surface.SetDrawColor(col1)
        else
            surface.SetDrawColor(col2)
        end
        surface.DrawRect(0, 0, w, h)
        --surface.SetDrawColor(col1)
        --surface.DrawOutlinedRect(0, 0, w, h, 3)
        draw.ShadowSimpleText(">", "JoeFort40", w * 0.5, h * 0.5, s:IsHovered() and col2 or col1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    end
end

net.Receive("JoeFort_updateresourcepool", function()
    JoeFort.Ressources = net.ReadInt(32)
end)

net.Receive("JoeFort_UpdateTime", function()
    local ent = net.ReadEntity()
    local int = net.ReadInt(32)
    if not IsValid(ent) then return end
    ent.buildtime = int
end)


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
