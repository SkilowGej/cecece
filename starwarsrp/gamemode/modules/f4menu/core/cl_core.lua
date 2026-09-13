local fr
function GameMenu:Show()
    if IsValid(fr) then return end
    fr = vgui.Create('gm.frame')
    local frH = fr:GetTall()
    local sidebar = fr:Add('gm.sidebar')
    sidebar:SetSize(scale(400), scale(300))
    sidebar:SetPos(scale(30), frH * .5 - sidebar:GetTall() * .5)
    local body = fr:Add('Panel')
    body:SetSize(scale(900), frH - scale(200))
    body:SetPos(sidebar:GetWide(), frH * .5 - body:GetTall() * .5)
    sidebar:SetBody(body)
    local c = vgui.Create('gm.tab.char')
    sidebar:CreatePanel('Twoja postać', c)
    local d = vgui.Create('gm.tab.division')
    sidebar:CreatePanel('Twój oddział', d)
    local i = vgui.Create('gm.tab.info')
    sidebar:CreatePanel('Informacje', i)
    local a = vgui.Create('gm.tab.achiev')
    sidebar:CreatePanel('Osiągnięcia', a)
    sidebar:CreatePanel('Mapa Galaktyki', nil, function()
        GMap:Menu()
        fr:SafetyRemove()
    end)

    if LocalPlayer():IsSuperAdmin() then
        local m = vgui.Create('gm.tab.galacticmap')
        sidebar:CreatePanel('Edytor Mapy Galaktyki', m)
    end

    sidebar:SetActive(1)
end

function GetPlayerTrackingData(p)
    return {
        JoinTime = p:GetNWInt("JoinTime"),
        FirstJoinTime = p:GetNWInt("FirstJoinTime"),
        TotalTime = p:GetNWInt("TotalTime"),
        KillCount = p:GetNWInt("KillCount"),
        DeathCount = p:GetNWInt("DeathCount"),
        MoneySpent = p:GetNWInt("MoneySpent"),
        MoneyEarned = p:GetNWInt("MoneyEarned")
    }
end