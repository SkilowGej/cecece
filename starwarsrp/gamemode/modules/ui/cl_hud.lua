if SERVER then
    AddCSLuaFile()
    return
end

luna = luna or {}
luna.hud = {}
local string = string
local ipairs = ipairs
local scrw, scrh = ScrW(), ScrH()
local base_w, base_h
if scrw == 3440 and scrh == 1440 then
    base_w, base_h = scrw / 3440, scrh / 1440
elseif scrw >= 2560 and scrh >= 1440 then
    base_w, base_h = scrw / 2560, scrh / 1440
else
    base_w, base_h = scrw / 1920, scrh / 1080
end

local target_w, target_h = 2560, 1440
local ui_vignette = Material('luna_ui_base/luna-ui_vignette.png', 'smooth noclamp')
local ui_vignette2 = Material('luna_ui_base/luna-ui_vignette.png', 'smooth noclamp')
local rc_overlay = Material('luna_menus/hud/rc_overlay.png', 'smooth noclamp')
local class_icon = Material('luna_ui_base/elements/republic.png', 'smooth noclamp')
local voice_icon = Material('luna_ui_base/etc/speaker.png', 'noclamp smooth')
local mat_burst = Material('luna_icons/broken-bone.png', 'smooth noclamp')
local mat_sandcrawler = Material('luna_icons/chess-rook.png', 'smooth noclamp')
local _bloodLeft = Material('luna_menus/deathscreen/aids_left.png', 'smooth noclamp')
local _bloodRight = Material('luna_menus/deathscreen/aids_right.png', 'smooth noclamp')
local _vignette = Material('luna_menus/deathscreen/bleedout-background.png', 'smooth noclamp')
local drawplayers = {}
local frames = 0
local view_fov = 0
local fadedist = 150
local scale = 0.05
local logohud1 = Material('luna_ui_base/luna-ui_vignette.png', 'smooth noclamp')
local loudtalk = {}
local logohud = Material('luna_sup_brand/main_logo_swrp.png', 'smooth noclamp')
local compass_x = 60
local ui_defcon = Material('luna_menus/hud/alert.png', 'smooth noclamp')
local micro = Material('luna_menus/hud/walkie-talkie.png', 'smoth noclamp')
local chat_icon = Material('luna_ui_base/etc/talk.png', 'smooth noclamp') 
local surface_Setfont = surface.SetFont
local surface_TextSize = surface.GetTextSize
local surface_SetDrawColor = surface.SetDrawColor
local surface_SetMaterial = surface.SetMaterial
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_ShadowText = draw.ShadowSimpleText
local surface_SimpleText = draw.SimpleText
local surface_RoundedBox = draw.RoundedBox
local math_Round = math.Round
local GetGlobalTbl = GetGlobalTable
local cache_w = {}
local cache_h = {}
local function w(px)
    if cache_w[px] then
        return cache_w[px]
    else
        local result = math_Round(px * base_w)
        cache_w[px] = result
        return result
    end
end

local function h(px)
    if cache_h[px] then
        return cache_h[px]
    else
        local result = math_Round(px * base_h)
        cache_h[px] = result
        return result
    end
end

local color_supreme = Color(7, 110, 203)
local color_orange = Color(255, 165, 0, 255)
local color_black = Color(0, 0, 0, 255)
local color_white = Color(255, 255, 255)
local color_white_transparent = Color(255, 255, 255, 80)
local color_white_faded = Color(255, 255, 255, 50)
local colorModify = {
    ['$pp_colour_addr'] = .01,
    ['$pp_colour_addg'] = .02,
    ['$pp_colour_addb'] = .12,
    ['$pp_colour_mulr'] = 0,
    ['$pp_colour_mulg'] = 0.02,
    ['$pp_colour_mulb'] = 0,
    ['$pp_colour_brightness'] = -0.02;
    ['$pp_colour_contrast'] = 1.2;
    ['$pp_colour_colour'] = 0.5;
}

hook.Add('RenderScreenspaceEffects', 'color_modify_example', function()
    local interval = FrameTime() / 10
    for k, v in pairs(colorModify) do
        colorModify[k] = math.Approach(colorModify[k], v, interval)
    end

    DrawColorModify(colorModify)
end)

-- local function luna_hud()
--     surface_SetMaterial(logohud1)
--     surface_SetDrawColor(color_black)
--     surface_DrawTexturedRect(0, 0, scrw, scrh)
-- end
--hook.Add('HUDPaint', 'luna_vignette', luna_hud) -- мне топовые виньетки хеликса крашут
local function ClassGetIcon()
    local icon = class_icon
    local logic = LocalPlayer():GetNetVar('features') or {}
    for feature, status in pairs(logic) do
        if status then
            icon = Material(FEATURES_TO_NORMAL[feature].icon, 'smooth noclamp')
            break
        end
    end
    return icon
end

local function draw_rect(color)
    local x, y = w(65), scrh - h(56)
    for i = 0, 4 do
        local n = 61 * i
        surface_SetDrawColor(color)
        surface.DrawRect(x + n, y, w(56), h(10))
        draw.NoTexture()
    end
end

local function textblock(lines, ystar, font, maxWidth)
    local totalHeight = 0
    local space = h(20)
    for _, line in ipairs(lines) do
        local txtcol = Color(141, 141, 141)
        surface_Setfont(font)
        local txtx = w(20 + 6)
        local wrappedText = draw.textwrap(line, font, maxWidth)
        local wrappedLines = string.Explode('\n', wrappedText)
        for j, wrappedLine in ipairs(wrappedLines) do
            local liney = ystar + totalHeight
            draw.DrawText(wrappedLine, font, txtx, liney, txtcol, 0)
            totalHeight = totalHeight + space
        end
    end
    return ystar + totalHeight
end

hook.Add('RenderScene', 'NameTags', function(_, _, fov)
    frames = FrameNumber()
    view_fov = fov
end)

hook.Add('PostDrawTranslucentRenderables', 'NameTags', function(depth, sky)
    if depth or sky then return end
    local ang = Angle(0, EyeAngles().y - 90, 90)
    local eyepos = EyePos()
    local cfn = frames - 1
    local playersToRemove = {}
    
    for pPlayer, frames in pairs(drawplayers) do
        if not IsValid(pPlayer) or pPlayer.Alive and not pPlayer:Alive() or cfn ~= frames and cfn + 1 ~= frames then
            playersToRemove[#playersToRemove + 1] = pPlayer
            continue
        end
        
        if pPlayer:GetMoveType() == MOVETYPE_NOCLIP then
            continue
        end

        local headPos = pPlayer:GetPos() + Vector(0, 0, pPlayer:OBBMaxs().z)
        local eye = headPos + Vector(0, 0, 1)
        
        if cfn == frames and eyepos:Distance(eye) > fadedist * 100 / view_fov then continue end
        
        cam.Start3D2D(eye, ang, scale)
        
        if pPlayer:IsPlayer() then
            local char = pPlayer.GetCharacter and pPlayer:GetCharacter()
            local rank = pPlayer:GetNWString('rating', 'CDT')
            local rpid = pPlayer:GetNWString('rpid')
            local class_id = char and char:GetClass() or nil
            local class = class_id and luna.class.Get(class_id)
            
            local oy = 0
            if LocalPlayer():GetEyeTrace().Entity == pPlayer then
                surface.SetFont(luna.MontBaseTitle)
                local healthWidth, healthHeight = surface.GetTextSize(math.Round(pPlayer:Health()) .. '%')
                local armorWidth, armorHeight = surface.GetTextSize(math.Round(pPlayer:Armor()) .. '%')
                
                surface_ShadowText(math.Round(pPlayer:Health()) .. '%', luna.MontBaseTitle, -10, oy - 50, Color(214, 45, 32, 250), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
                surface_ShadowText(math.Round(pPlayer:Armor()) .. '%', luna.MontBaseTitle, 10, oy - 50, Color(10, 230, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
                
                local vq = 'Żołnierz'
                local l = pPlayer:GetNetVar('features')
                if l and istable(l) then
                    for feature, status in pairs(l) do
                        if status then
                            vq = FEATURES_TO_NORMAL[feature].name
                            break
                        end
                    end
                end
                
                surface_ShadowText(string.format('%s • %s', vq, rank), luna.MontBaseTitle, 0, oy - 35, Color(130, 130, 130, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
                oy = oy - 40
            end
            
            surface_ShadowText(pPlayer:Nick(), luna.MontBlack50, 0, oy - 45, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
            surface_ShadowText(team.GetName(pPlayer:Team()), luna.NPC1Hit, 0, oy - 100, team.GetColor(pPlayer:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
            
            if pPlayer:IsSpeaking() then 
                draw.Icon(-32, -32 - 200 + oy, 64, 64, voice_icon, color_orange) 
            end

            if pPlayer:GetNWBool('ChatOpen', false) then
                draw.Icon(-32, -32 - 200 + oy, 64, 64, chat_icon, color_orange)
            end
        end
        
        cam.End3D2D()
    end
    
    for _, pPlayer in ipairs(playersToRemove) do
        drawplayers[pPlayer] = nil
    end
end)


hook.Add('UpdateAnimation', 'NameTags', function(pPlayer) if pPlayer ~= LocalPlayer() then drawplayers[pPlayer] = frames end end)
local elements = {
    {
        x = -450,
        letter = '',
        color = COLOR_MINE
    },
    {
        x = -360,
        letter = 'PN',
        color = COLOR_MINE
    },
    {
        x = -315,
        letter = 'PN-WSCH',
        color = COLOR_MINE
    },
    {
        x = -270,
        letter = 'WSCH',
        color = COLOR_MINE
    },
    {
        x = -225,
        letter = 'PD-WSCH',
        color = COLOR_MINE
    },
    {
        x = -180,
        letter = 'PD',
        color = COLOR_SECONDARY
    },
    {
        x = -135,
        letter = 'PD-ZACH',
        color = COLOR_MINE
    },
    {
        x = -90,
        letter = 'ZACH',
        color = COLOR_SECONDARY
    },
    {
        x = -45,
        letter = 'PN-ZACH',
        color = COLOR_MINE
    },
    {
        x = 0,
        letter = 'PN',
        color = COLOR_SECONDARY
    },
    {
        x = 45,
        letter = 'PN-WSCH',
        color = COLOR_MINE
    },
    {
        x = 90,
        letter = 'WSCH',
        color = COLOR_SECONDARY
    },
    {
        x = 135,
        letter = 'PD-WSCH',
        color = COLOR_MINE
    },
    {
        x = 180,
        letter = 'PD',
        color = COLOR_SECONDARY
    },
    {
        x = 225,
        letter = 'PD-ZACH',
        color = COLOR_MINE
    },
    {
        x = 270,
        letter = 'ZACH',
        color = COLOR_SECONDARY
    },
    {
        x = 315,
        letter = 'PN-ZACH',
        color = COLOR_MINE
    },
    {
        x = 360,
        letter = 'PN',
        color = COLOR_MINE
    },
    {
        x = 450,
        letter = 'PN-WSCH',
        color = COLOR_SECONDARY
    },
    {
        x = 15
    },
    {
        x = 30
    },
    {
        x = 60
    },
    {
        x = 75
    },
    {
        x = 105
    },
    {
        x = 120
    },
    {
        x = 150
    },
    {
        x = 165
    },
    {
        x = 195
    },
    {
        x = 210
    },
    {
        x = 240
    },
    {
        x = 255
    },
    {
        x = 285
    },
    {
        x = 300
    },
    {
        x = 330
    },
    {
        x = 345
    },
    {
        x = -15
    },
    {
        x = -30
    },
    {
        x = -60
    },
    {
        x = -75
    },
    {
        x = -105
    },
    {
        x = -120
    },
    {
        x = -150
    },
    {
        x = -165
    },
    {
        x = -195
    },
    {
        x = -210
    },
    {
        x = -240
    },
    {
        x = -255
    },
    {
        x = -285
    },
    {
        x = -300
    },
    {
        x = -330
    },
    {
        x = -345
    },
}
local _max_health
local _max_armor
_max_health = _max_health or 100
_max_armor = _max_armor or 255
timer.Simple(0, function()
    netstream.Hook('PostPlayerLoadout', function()
        _max_health = 100
        _max_armor = 255
    end)
end)

function luna.hud.DrawAll()
    local ply = LocalPlayer()
    local defcon = GetGlobalString('defcon')
    local event = GetGlobalTbl('EventTask')
    do
        -- if _max_health < ply:Health() then _max_health = ply:Health() end
        -- if _max_armor < ply:Armor() then _max_armor = ply:Armor() end
        _max_armor = ply:GetMaxArmor()
        _max_health = ply:GetMaxHealth()
        surface_SetDrawColor(color_white)
        surface_SetMaterial(logohud)
        surface_DrawTexturedRect(scrw - w(350), h(-40), w(300), h(200))
        surface_SetMaterial(ui_vignette)
        surface_SetDrawColor(color_black)
        --surface_SetMaterial(rc_overlay) -- надо сделать спецом для РК отдельный визуал епта
        --surface_SetDrawColor(color_black)
        surface_DrawTexturedRect(0, 0, scrw, scrh)
        surface_SetMaterial(ui_vignette2)
        surface_SetDrawColor(color_black)
        surface_DrawTexturedRect(0, 0, scrw, scrh)
        if defcon then
            local defdata = DEFCON_TYPES[defcon]
            if defdata then
                surface_Setfont(luna.NPC1Hit)
                local defcon_w = select(1, surface_TextSize(defcon))
                surface_Setfont(luna.MontBaseTitle)
                local title_w = select(1, surface_TextSize('DEFCON'))
                local right_edge = scrw - w(10)
                local defcon_x = right_edge - w(100)
                local title_x = defcon_x - defcon_w - w(-95)
                local text_x = right_edge - w(100)
                local base_y = h(35)
                draw.Icon(right_edge - w(84), base_y + h(75), w(82), h(82), ui_defcon, Color(255, 43, 43))
                surface_ShadowText('DEFCON', luna.MontBlack38, title_x - title_w, base_y + h(95), Color(255, 43, 43), 2)
                surface_ShadowText(defcon, luna.MontBlack50, defcon_x, base_y + h(80), Color(255, 43, 43), 2)
                surface_ShadowText(defdata.text, luna.MontBase18, text_x, base_y + h(130), color_white, 2)
            end
        end

        local geticon = ClassGetIcon()
        if geticon then
            surface_SetMaterial(geticon)
            surface_SetDrawColor(color_white)
            surface_DrawTexturedRect(w(18), scrh - h(57), 36, 36)
        end

        if event and event.title ~= nil and show_task:GetBool() then
            local titleY = scrh - h(1045)
            surface.SetFont(luna.MontBaseTitle)
            surface_SimpleText('eventinfo', luna.Aurebesh, w(26), titleY, color_white_transparent, TEXT_ALIGN_LEFT, 0)
            surface_SimpleText('Aby wyłączyć menu zadań, naciśnij klawisz F7.', luna.LunaMontMini, w(25), h(15), color_white_faded, TEXT_ALIGN_LEFT, 0)
            titleY = titleY + h(15)
            local formattedTitle = Format('«%s»', event.title)
            surface_ShadowText(formattedTitle, luna.MontBlack38, w(26), titleY, color_supreme, TEXT_ALIGN_LEFT, 0)
            if event.timer and math_Round(event.timer['end'] - CurTime()) > 0 then
                local timeRemaining = event.timer['end'] - CurTime()
                local ttext = string.FormattedTime(timeRemaining, '%02i:%02i')
                local ttwid = select(1, surface.GetTextSize(formattedTitle))
                local bx = w(35)
                local by = titleY + h(2.5)
                local tx = bx + ttwid + w(65)
                surface_ShadowText(ttext, luna.MontBaseTitle, tx, by, color_supreme, TEXT_ALIGN_LEFT, 0)
            end

            local startY = titleY + h(35)
            local ccoffx = w(10)
            local space = h(20)
            if event.text then
                local desc = string.Explode('\n', event.text, false)
                startY = textblock(desc, startY, luna.MontBase18, w(450))
            end

            startY = startY + h(10)
            surface_RoundedBox(0, w(26), startY, w(150), h(2), Color(255, 255, 255, 150))
            startY = startY + h(10)
            if event.lines then
                for i, line in ipairs(event.lines) do
                    if string.Trim(line) == '' then continue end
                    local ccol = i <= 2 and color_supreme or color_white
                    local txtcol = i <= 2 and Color(255, 255, 255, 100) or Color(212, 212, 212)
                    surface_Setfont(luna.MontBase22)
                    local txtx = w(41)
                    local liney = startY + (i - 1) * space
                    local ccx = txtx - ccoffx
                    local ccy = liney + select(2, surface.GetTextSize(line)) / 2 - h(14.5)
                    surface_SimpleText('•', luna.MontBase22, ccx, ccy, ccol, TEXT_ALIGN_CENTER)
                    surface_SimpleText(line, luna.MontBase22, txtx, liney, txtcol, TEXT_ALIGN_LEFT)
                end
            end

            local current_liney = liney or startY
            for _, pl in ipairs(player.GetAll()) do
                if not loudtalk[pl] then continue end
                local boxY = current_liney + h(40)
                local textY = current_liney + h(60)
                surface_RoundedBox(0, w(26), boxY, w(300), h(65), Color(25, 25, 40, 200))
                surface_SimpleText('Głośnik: ', luna.MontBase22, w(32), textY, color_white, TEXT_ALIGN_LEFT)
                surface_SimpleText(pl:Nick(), luna.MontBase22, w(32), textY + h(20), color_white, TEXT_ALIGN_LEFT)
                surface_SetDrawColor(Color(66, 192, 62))
                surface_SetMaterial(micro)
                surface_DrawTexturedRect(w(255), boxY + h(15), w(32), h(32))
                current_liney = current_liney + h(85)
            end
        end

        local max_health = ply:GetMaxHealth()
        max_health = _max_health < max_health and max_health or _max_health
        local max_armor = ply:GetMaxArmor()
        max_armor = _max_armor < max_armor and max_armor or _max_armor
        local health = ply:Health() / max_health * 100
        local armor = ply:Armor() / max_armor * 100
        lerp_health = Lerp(FrameTime() * 2, lerp_health or 0, health * 3 or 0)
        lerp_armor = Lerp(FrameTime() * 2, lerp_armor or 0, armor or 0)
        health_string = math_Round(lerp_health / 3 / 100 * max_health)
        surface_ShadowText(health_string, luna.MontBlack50, w(20), scrh - h(115), COLOR_WHITE, TEXT_ALIGN_LEFT, 0)
        local wh = surface_TextSize(health_string)
        surface_ShadowText(math_Round(lerp_armor / 100 * max_armor), luna.MontBlack38, 20 + wh + 6, scrh - 100, Color(190, 190, 190), TEXT_ALIGN_LEFT, 0)
        surface_RoundedBox(0, w(65), scrh - h(40), 300, 20, Color(90, 90, 90, 50))
        surface_RoundedBox(0, w(65), scrh - h(40), lerp_health > 300 and 300 or lerp_health, 20, Color(150, 150, 150))

        if LocalPlayer():GetNWBool('legBroke') then
            draw.Icon(20, ScrH() - 165 - 6 + 24, 42, 34, mat_burst, Color(255, 255, 255))
        end

        if LocalPlayer():Team() and re.jobs[LocalPlayer():Team()] then
            local control = re.jobs[LocalPlayer():Team()].control
    
            if (control == CONTROL_REPUBLIC or control == CONTROL_CIS) and show_task:GetBool() then
                for _, ent in pairs(ents.FindByClass('lvs_walker_atte')) do
                    local point = ent:GetPos() + ent:OBBCenter() -- Gets the position of the entity, specifically the center
                    local data2D = point:ToScreen()
                    local dist = math.Round(math.sqrt(LocalPlayer():GetPos():DistToSqr(ent:GetPos())) * 0.01905, 1)
                    if dist > 50 then continue end
                    local x = data2D.x <= 50 and 50 or data2D.x >= ScrW() - 50 and ScrW() - 50 or data2D.x
                    local y = data2D.y <= 50 and 50 or data2D.y >= ScrH() - 50 and ScrH() - 50 or data2D.y
                    -- if ( not data2D.visible ) then continue end
                    local factionData = CONTROLPOINT_TEAMS[control]
    
                    draw.Arc({
                        y = y,
                        x = x
                    }, 0, 360, 30, 6, 8, Color(255, 255, 255, 160))
    
                    draw.Arc({
                        y = y,
                        x = x
                    }, 0, 360, 20, 6, 30, ColorAlpha(factionData.color, 160))
    
                    draw.Icon(x - 16, y - 16, 32, 32, mat_sandcrawler, Color(255, 255, 255, 160))
                    draw.ShadowSimpleText(control == CONTROL_REPUBLIC and 'CHRONIĆ' or 'ZNISZCZYĆ', 'font_base_18', x, y + 28, ColorAlpha(Color(255, 181, 18), 160 + 20), TEXT_ALIGN_CENTER, 0)
                    draw.ShadowSimpleText('AT-TE #' .. ent:EntIndex(), 'font_base_small', x, y + 44, ColorAlpha(COLOR_WHITE, 160 + 20), TEXT_ALIGN_CENTER, 0)
                    draw.ShadowSimpleText(dist .. 'м', 'font_base_small', x, y + 56, ColorAlpha(COLOR_WHITE, 160 + 20), TEXT_ALIGN_CENTER, 0)
                end
            end
        end

        local weapon = ply:GetActiveWeapon()
        if IsValid(weapon) then
            local clip1 = weapon:Clip1()
            local ammo1 = ply:GetAmmoCount(weapon:GetPrimaryAmmoType())
            
            if clip1 > -1 then
                local ammoText = string.format('%d / %d', clip1, ammo1)
                surface.SetFont(luna.MontBlack38)
                local textWidth, textHeight = surface.GetTextSize(ammoText)
                
                local ammoX = scrw - w(30) - textWidth
                local ammoY = scrh - h(80) - textHeight
                
                -- surface.SetDrawColor(0, 0, 0, 150)
                -- surface.DrawRect(ammoX - w(10), ammoY - h(5), textWidth + w(20), textHeight + h(10))
                
                draw.SimpleText(ammoText, luna.MontBlack38, ammoX, ammoY, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            end
        end

        do
            local _isLowHealth = LocalPlayer():Health() / LocalPlayer():GetMaxHealth() < 0.3
    
            if _isLowHealth then
                surface.SetMaterial(_vignette)
                surface.SetDrawColor(155, 0, 0, 255)
                surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
                surface.SetMaterial(_vignette)
                surface.SetDrawColor(155, 0, 0, 100)
                surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
                -- surface.SetMaterial(_bloodLeft)
                -- surface.SetDrawColor(155, 0, 0, 100)
                -- surface.DrawTexturedRect(0, 0, ScrW() * 0.5, ScrH())
                -- surface.SetMaterial(_bloodRight)
                -- surface.SetDrawColor(155, 0, 0, 100)
                -- surface.DrawTexturedRect(ScrW() * 0.5, 0, ScrW() * 0.5, ScrH())
            end
        end
    end

    do
        render.ClearStencil()
        render.SetStencilEnable(true)
        render.SetStencilWriteMask(255)
        render.SetStencilTestMask(255)
        render.SetStencilReferenceValue(25)
        render.SetStencilFailOperation(STENCIL_REPLACE)
        surface_RoundedBox(6, w(65), scrh - h(56), w(300), h(10), color_black)
        render.SetStencilCompareFunction(STENCIL_EQUAL)
        draw.NoTexture()
        draw_rect(Color(90, 90, 90, 50))
        render.SetStencilEnable(false)
        render.ClearStencil()
        render.SetStencilEnable(true)
        render.SetStencilWriteMask(255)
        render.SetStencilTestMask(255)
        render.SetStencilReferenceValue(25)
        render.SetStencilFailOperation(STENCIL_REPLACE)
        surface_RoundedBox(6, w(65), scrh - h(56), lerp_armor * 3, h(10), color_black)
        render.SetStencilCompareFunction(STENCIL_EQUAL)
        draw.NoTexture()
        draw_rect(Color(220, 220, 220))
        render.SetStencilEnable(false)
    end

    if re.wepSelector.alpha <= 0 then
        do
            local offLimit = scrw / 5
            local offset = ply:GetAngles().y
            local high = ply:GetAngles().x
            local getpos = ply:GetPos()
            lerp_pos = LerpVector(1, lerp_pos or Vector(0, 0, 0), getpos or Vector(0, 0, 0))
            local offset_x = offset > 0 and offset - 360 or offset
            surface_SetDrawColor(Color(255, 255, 255, 90))
            surface.DrawRect(scrw / 2, compass_x, 2, 20)
            surface.SetFont(luna.MontBase24)
            local _text = 'X: ' .. tostring(math_Round(lerp_pos.x, 1)) .. ', Y: ' .. tostring(math_Round(lerp_pos.y, 1))
            local __text = '[' .. tostring(math_Round(offset_x * -1, 1)) .. ', ' .. tostring(math_Round(high * 1.124, 1)) .. '] ▼ ' .. tostring(math_Round(lerp_pos.z, 1))
            local x__, y__ = surface.GetTextSize(_text)
            surface_ShadowText(_text, luna.MontBase24, scrw / 2 + w(140) - x__, compass_x - h(28), color_white, TEXT_ALIGN_RIGHT, 0, 1, color_black)
            surface_ShadowText(__text, luna.MontBase24, scrw / 2 + w(40) - x__ + x__ + w(10), compass_x - h(28), color_white, TEXT_ALIGN_LEFT, 0, 1, color_black)
            for _, el in ipairs(elements) do
                local x = (el.x + offset) * 3
                if x < -offLimit then continue end
                if x > offLimit then continue end
                local alpha = (offLimit - math.abs(x) * 0.9) / offLimit * 255
                local draw_x = scrw / 2 + w(x)
                draw_x = math.Approach(draw_x, draw_x, math.Clamp(math.abs((draw_x - draw_x) * 2), 2, 2))
                surface_SetDrawColor(Color(255, 255, 255, alpha))
                local color = el.color and ColorAlpha(el.color, alpha * 6) or ColorAlpha(color_white, alpha)
                if el.letter then
                    surface_ShadowText(el.letter, luna.MontBlack28, draw_x - w(2), compass_x - h(4), color, 1, 0, 1, Color(0, 0, 0, alpha / 2))
                else
                    local x_ = el.x > 0 and el.x or 360 + el.x
                    surface_ShadowText(x_, luna.MontBase24, draw_x, compass_x + 4, ColorAlpha(color, color.a - 30), 1, 0, 1, Color(0, 0, 0, alpha / 2))
                end
            end
        end
    end
    if ply:Team() == TEAM_COMMANDO then
        surface.SetMaterial(rc_overlay)
        surface.SetDrawColor(255, 255, 255, 50)
        surface.DrawTexturedRect(0, 0, scrw, scrh)
    end
end

hook.Add('Think', 'CC_BeyonLife_Sound', function()
	local _isLowHealth = LocalPlayer():Health() / LocalPlayer():GetMaxHealth() < 0.3
	local heartbeat = CreateSound(LocalPlayer(), 'player/heartbeat1.wav')

	local function toggle_heartbeat()
		if heartbeat:IsPlaying() then
			heartbeat:Stop()
		else
			heartbeat:Play()
		end
	end

	if _isLowHealth then
		if not heartbeat:IsPlaying() then
			toggle_heartbeat()
		end
	else
		if heartbeat:IsPlaying() then
			toggle_heartbeat()
		end
	end
end)

hook.Add('HUDPaint', 'luna.hud.paint', luna.hud.DrawAll)
hook.Add('PlayerStartVoice', 'luna.hud.startvoice', function(ply)
    if not IsValid(ply) then return end
    local wep = ply:GetActiveWeapon()
    if IsValid(wep) and wep:GetClass() == 'announce' then loudtalk[ply] = true end
end)

hook.Add('OnScreenSizeChanged', 'luna.hud.adapt', function(_, _, nw, nh) scrw, scrh, sw, sh = nw, nh, nw / 1920, nh / 1080 end)
show_task = CreateClientConVar('show_task', '1')
local time = CurTime()
hook.Add('Think', 'task_think', function()
    if time > CurTime() then return end
    if input.IsKeyDown(KEY_F7) then
        show_task:SetBool(not show_task:GetBool())
        time = CurTime() + 0.3
    end
end)

hook.Add('PlayerEndVoice', 'luna.hud.endvoice', function(ply) if IsValid(ply) and loudtalk[ply] then loudtalk[ply] = nil end end)
local s = {
    ['CHudSecondaryAmmo'] = true,
    ['CHudAmmo'] = true,
    ['CHudBattery'] = true,
    ['CHudHealth'] = true,
}

hook.Add('HUDShouldDraw', '12i312i312', function(n) if s[n] then return false end end)