local overlay
local deathCam
local fadeAlpha = 0
local transitionDuration = 3
local isDeathTransition = false
local deathTransitionStartTime = 0
local isDeathCameraActive = false
local victim = nil
local originalCalcView = GM.CalcView
local deathloh = Material("luna_menus/deathscreen/bleedout-background.png", "smooth noclamp")
local topo1 = Material("luna_menus/deathscreen/topography.png", "smooth noclamp")
local topo2 = Material("luna_menus/deathscreen/topography_bg.png", "smooth noclamp")
local color_black = Color(0, 0, 0, 255)

local function RemoveDeathScreen()
    if IsValid(overlay) then
        overlay:Remove()
        overlay = nil
    end

    timer.Remove("RespawnTimer")
    timer.Remove("UpdateRespawnButton")
    RemoveDeathCamera()
end

local function CreateTopography(parent)
    local screenW, screenH = ScrW(), ScrH()
    local topographySize = math.min(screenW * 0.5, screenH * 0.74)
    local topography = vgui.Create("DPanel", parent)
    topography:SetSize(topographySize, topographySize)
    topography:SetPos(screenW * 0.135, screenH * 0.15)
    topography:SetDrawBackground(false)

    topography.Paint = function(self, w, h)
        surface.SetMaterial(topo1)
        surface.SetDrawColor(255, 255, 225, 255)
        surface.DrawTexturedRect(10, 10, w * 0.98, h * 0.98)
        surface.SetMaterial(topo2)
        surface.SetDrawColor(255, 255, 225, 255)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    return topography
end

local function CreateATTEPanels(topography)
    local atte_table = ents.FindByClass("lvs_walker_atte")

    local mapBounds = {
        minX = math.huge,
        maxX = -math.huge,
        minY = math.huge,
        maxY = -math.huge
    }

    for _, v in ipairs(atte_table) do
        local pos = v:GetPos()
        mapBounds.minX = math.min(mapBounds.minX, pos.x)
        mapBounds.maxX = math.max(mapBounds.maxX, pos.x)
        mapBounds.minY = math.min(mapBounds.minY, pos.y)
        mapBounds.maxY = math.max(mapBounds.maxY, pos.y)
    end

    for _, v in ipairs(atte_table) do
        local id = string.match(tostring(v), "%d+")
        local atte_panel = vgui.Create("DPanel", topography)
        atte_panel:SetSize(101, 58)
        local normalizedX = (v:GetPos().x - mapBounds.minX) / (mapBounds.maxX - mapBounds.minX)
        local normalizedY = (v:GetPos().y - mapBounds.minY) / (mapBounds.maxY - mapBounds.minY)
        atte_panel:SetPos(normalizedX * (topography:GetWide() - atte_panel:GetWide()), normalizedY * (topography:GetTall() - atte_panel:GetTall()))
        atte_panel:SetDrawBackground(false)

        atte_panel.Paint = function(self, w, h)
            surface.SetMaterial(Material("luna_ui_base/elements/luna-ui_circle.png"))
            surface.SetDrawColor(7, 110, 203, 255)
            surface.DrawTexturedRect(32, 0, 38, 38)
            surface.SetMaterial(Material("luna_ui_base/elements/republic.png"))
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawTexturedRect(37, 5, 28, 28)
            draw.SimpleText("AT-TE #" .. id, "text", w / 2, 42, Color(255, 255, 255), TEXT_ALIGN_CENTER)
        end
    end
end

local function CreateInfoPanel(parent, x, y, w, h, title, content)
    local panel = vgui.Create("DPanel", parent)
    panel:SetSize(w, h)
    panel:SetPos(x, y)
    panel:SetDrawBackground(false)

    panel.Paint = function(self, w, h)
        --draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 180))
        --draw.RoundedBox(8, 2, 2, w - 4, h - 4, Color(30, 30, 30, 200))
        draw.SimpleText(title, "header", 20, 15, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
        surface.SetDrawColor(255, 255, 255, 100)
        surface.DrawLine(20, 48, w - 20, 48)
        content(self, w, h)
    end

    return panel
end

local function CreateButton(parent, x, y, w, h, text, color, onClick)
    local button = vgui.Create("DButton", parent)
    button:SetSize(w, h)
    button:SetPos(x, y)
    button:SetText("")

    button.Paint = function(self, w, h)
        local btnColor = self:IsEnabled() and (self:IsHovered() and color[2] or color[1]) or color[3]
        draw.RoundedBox(8, 0, 0, w, h, btnColor)
        draw.SimpleText(text, "text_medium", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    button.DoClick = onClick

    return button
end

hook.Add('CalcView', 'DeathScreenFirstPerson', function(ply, pos, ang, fov, nearz, farz)
    ply = LocalPlayer()

    if isDeathCameraActive and IsValid(ply) and not ply:Alive() then
        local ragdoll = ply:GetNWEntity("Ragdoll")

        if not IsValid(ragdoll) then
            isDeathCameraActive = false
            return {
                origin = ply:GetPos() + Vector(0, 0, 64),
                angles = ply:EyeAngles(),
                fov = fov,
                znear = nearz,
                zfar = farz,
                drawviewer = false
            }
        end

        local eyeAttachment = ragdoll:LookupAttachment("eyes")

        if eyeAttachment == 0 then
            return {
                origin = ragdoll:GetPos() + Vector(0, 0, 10),
                angles = ragdoll:GetAngles(),
                fov = fov,
                znear = nearz,
                zfar = farz,
                drawviewer = false
            }
        end

        local eyePos, eyeAng = ragdoll:GetAttachment(eyeAttachment).Pos, ragdoll:GetAttachment(eyeAttachment).Ang
        local forwardOffset = eyeAng:Forward() * 5

        return {
            origin = eyePos + forwardOffset,
            angles = eyeAng,
            fov = fov,
            znear = nearz,
            zfar = farz,
            drawviewer = false
        }
    end


    return view
end)

local function CreateDeathCamera(ply)
    isDeathCameraActive = true
    victim = ply
end

function RemoveDeathCamera()
    if IsValid(victim) and victim.UnLock then
        victim:UnLock()
    end

    isDeathCameraActive = false
    victim = nil
end

local function DeathFadeEffect()
    local currentTime = CurTime()
    local elapsedTime = currentTime - deathTransitionStartTime
    fadeAlpha = math.min(elapsedTime / transitionDuration * 255, 255)
    surface.SetDrawColor(0, 0, 0, fadeAlpha)
    surface.DrawRect(0, 0, ScrW(), ScrH())

    if fadeAlpha >= 255 then
        hook.Remove("HUDPaint", "DeathFadeEffect")
        isDeathTransition = false
    end
end

function GetMedicsCount()
    local count = 0

    for _, ply in ipairs(player.GetAll()) do
        local features = ply:GetNetVar("features") or {}

        if features["medic"] then
            count = count + 1
        end
    end

    return count
end

local function GetSpecializationIcon(player)
    local features = player:GetNetVar("features") or {}

    for feature, status in pairs(features) do
        if status and FEATURES_TO_NORMAL[feature] and FEATURES_TO_NORMAL[feature].icon then return FEATURES_TO_NORMAL[feature].icon end
    end
    -- Default icon if not found, this is probably the admin icon

    return "luna_menus/hud/classes/17.png"
end

local function CreateDeathScreen(victim, dmginfo, respawnTime)
    if IsValid(overlay) then
        overlay:Remove()
    end

    local screenW, screenH = ScrW(), ScrH()
    overlay = vgui.Create("DPanel")
    overlay:SetSize(screenW, screenH)
    overlay:SetDrawBackground(false)
    -- overlay:SetMaterial(deathloh)
    -- overlay:SetDrawColor(color_black)
    -- overlay:DrawTexturedRect(0, 0, scrw, scrh)
    overlay:MakePopup()

    overlay.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(20, 20, 22, 200))
    end

    -- Create topography
    local topography = CreateTopography(overlay)
    CreateATTEPanels(topography)
    local panelWidth = screenW * 0.3
    local panelHeight = screenH * 0.15
    local panelSpacing = screenH * 0.02
    local startX = topography:GetX() + topography:GetWide() + screenW * 0.02
    local startY = topography:GetY()

    -- Create panel with death information
    CreateInfoPanel(overlay, startX, startY, panelWidth, panelHeight, "ZOSTAŁEŚ ZABITY", function(self, w, h)
        surface.SetMaterial(Material("luna_menus/deathscreen/death_screen.png"))
        surface.SetDrawColor(255, 255, 225, 50)
        surface.DrawTexturedRect(w - 142, 50, 100, 100)
        local attacker = dmginfo[1] and dmginfo[1].attacker or "World"
        local phrase = string.format("<font=header><colour=255,43,43>%s</colour>", attacker)
        markup.Parse(phrase, 400):Draw(20, 60, TEXT_ALIGN_LEFT)
    end)

    -- Create panel with damage information
    CreateInfoPanel(overlay, startX, startY + panelHeight + panelSpacing, panelWidth, panelHeight, "ANALIZA OBRAŻEŃ", function(self, w, h)
        surface.SetMaterial(Material("luna_menus/deathscreen/multiple-targets.png"))
        surface.SetDrawColor(255, 255, 225, 50)
        surface.DrawTexturedRect(w - 142, 50, 100, 100)
        local yOffset = 60
        local maxEntries = 3

        if #dmginfo > 0 then
            table.sort(dmginfo, function(a, b)
                return a.damage > b.damage
            end)

            for i, v in ipairs(dmginfo) do
                if i > maxEntries then break end
                local phrase = string.format("<font=text><colour=255,255,255>%s</colour> <colour=255,43,43>нанёс</colour> <colour=255,255,255>%d</colour> <colour=255,43,43>damage</colour>", v.attacker, v.damage)
                markup.Parse(phrase, w - 40):Draw(20, yOffset, TEXT_ALIGN_LEFT)
                yOffset = yOffset + 24
            end

            if #dmginfo > maxEntries then
                local remainingEntries = #dmginfo - maxEntries
                local message = string.format("I jeszcze kilka źródeł...", remainingEntries)
                draw.SimpleText(message, "text", 20, yOffset + 5, Color(255, 255, 255, 180), TEXT_ALIGN_LEFT)
            end
        else
            draw.SimpleText("Brak informacji o obrażeniach", "text", 20, yOffset, Color(255, 255, 255, 180), TEXT_ALIGN_LEFT)
        end
    end)

    CreateInfoPanel(overlay, startX, startY + (panelHeight + panelSpacing) * 2, panelWidth, panelHeight, "TWÓJ ODDZIAŁ", function(self, w, h)
        local squad

        if victim.GetSquad then
            squad = victim:GetSquad()
        end

        if squad then
            local members = squad:GetMembers()
            local yOffset = 60
            local squadName = squad:GetTitle()
            draw.SimpleText(squadName, "header", w - 20, 15, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT)

            for i, member in ipairs(members) do
                if i > 3 then break end
                local specializationIcon = GetSpecializationIcon(member)
                surface.SetMaterial(Material(specializationIcon))
                surface.SetDrawColor(255, 255, 225, 255)
                surface.DrawTexturedRect(20, yOffset + 5, 18, 18)
                local health = member:Health()
                local maxHealth = member:GetMaxHealth()
                local healthPercentage = health / maxHealth
                draw.SimpleText(member:Nick(), "text", 44, yOffset + 6, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
                local barWidth = 280
                local barHeight = 12
                draw.RoundedBox(6, w - barWidth - 20, yOffset + 8, barWidth, barHeight, Color(40, 40, 40, 180))
                local filledWidth = math.max(barWidth * healthPercentage, 10)
                draw.RoundedBox(6, w - barWidth - 20, yOffset + 8, filledWidth, barHeight, Color(146, 195, 124, 255))
                local healthText = string.format("%d/%d", health, maxHealth)
                draw.SimpleText(healthText, "text_small", w - 30, yOffset + 9, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT)
                yOffset = yOffset + 30
            end
        else
            draw.SimpleText("Nie jesteś w oddziale", "text_medium", 20, 70, Color(255, 255, 255))
        end
    end)

    local revive_info = CreateInfoPanel(overlay, startX, startY + (panelHeight + panelSpacing) * 3, panelWidth, panelHeight * 1.5, "CZAS DO ODRODZENIA", function(self, w, h)
        draw.SimpleText(respawnTime .. " SEKUND", "header_large", 20, 65, Color(7, 110, 203))
        local medicsCount = GetMedicsCount()
        draw.SimpleText("Lekarze w walce:", "text_medium", 20, 125, Color(255, 255, 255))
        draw.SimpleText(medicsCount .. " lekarzy", "text_medium", 170, 125, Color(7, 110, 203))
    end)

    local buttonWidth = panelWidth * 0.45
    local buttonHeight = panelHeight * 0.3
    local buttonY = revive_info:GetTall() - buttonHeight - panelHeight * 0.1

    local call_medic = CreateButton(revive_info, panelWidth * 0.05, buttonY, buttonWidth, buttonHeight, "WEZWJ LEKARZA", {Color(255, 43, 43, 255), Color(255, 43, 43, 255), Color(255, 43, 43, 100)}, function(self)
        netstream.Start('CreateMedicHelpPoint')
        self:SetDisabled(true)
    end)

    local respawn_button = CreateButton(revive_info, panelWidth - buttonWidth - panelWidth * 0.04, buttonY, buttonWidth, buttonHeight, "ODRÓDŹ SIĘ", {Color(7, 110, 203, 255), Color(7, 130, 223, 255), Color(7, 110, 203, 100)}, function()
        if IsValid(overlay) then
            overlay:Remove()
            timer.Remove("RespawnTimer")
            timer.Remove("UpdateRespawnButton")
            net.Start("PlayerRespawnRequest")
            net.SendToServer()
        end
    end)

    timer.Create("RespawnTimer", 1, 0, function()
        if IsValid(revive_info) then
            if respawnTime > 0 then
                respawnTime = respawnTime - 1
            end

            revive_info:InvalidateLayout(true)
        end
    end)

    timer.Create("UpdateRespawnButton", 0.1, 0, function()
        if IsValid(respawn_button) then
            respawn_button:SetEnabled(respawnTime <= 0)
        end
    end)
end

hook.Add("PlayerSpawn", "HandlePlayerSpawn", function(ply)
    if ply == LocalPlayer() then
        RemoveDeathScreen()
        RemoveDeathCamera()
    end
end)

hook.Add("Think", "CheckPlayerAliveStatus", function()
    local ply = LocalPlayer()

    if IsValid(ply) and ply:Alive() and IsValid(overlay) then
        RemoveDeathScreen()
    end
end)

hook.Add("PlayerBindPress", "BlockInputDuringDeathTransition", function(ply, bind, pressed)
    if isDeathTransition then return true end
end)

hook.Add("DoPlayerDeath", "HandlePlayerDeath", function(ply, attacker, dmginfo)
    if ply == LocalPlayer() then
        CreateDeathCamera(ply)
    end
end)

net.Receive("DTMenu", function()
    local victim, dmginfo, respawnTime = net.ReadEntity(), net.ReadTable(), net.ReadInt(32)
    fadeAlpha = 0
    isDeathTransition = true
    deathTransitionStartTime = CurTime()
    hook.Add("HUDPaint", "DeathFadeEffect", DeathFadeEffect)
    CreateDeathCamera(victim)

    timer.Simple(transitionDuration, function()
        if not IsValid(victim) or victim:Alive() then return end
        CreateDeathScreen(victim, dmginfo, respawnTime)
    end)
end)

concommand.Add("closedt", function()
    if overlay and IsValid(overlay) then
        overlay:Remove()
        timer.Remove("RespawnTimer")
        timer.Remove("UpdateRespawnButton")
    end
end)