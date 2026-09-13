-- Refactored by DuLL_FoX, old code is below
-- ичо ты тут рефакторнул? я думал ща отредачить а терь разбираться надо...
local scrw, scrh = ScrW(), ScrH()
local sw, sh = scrw / 1920, scrh / 1080
local round = math.Round
local basey = scrh - round(45 * sh)
local baseX = scrw - round(500 * sw)

local COLORS = {
    blue = Color(7, 110, 203),
    gray = Color(174, 174, 174),
    green = Color(66, 192, 62),
    red = Color(255, 43, 43),
    white = color_white,
    shadow = Color(0, 0, 0, 190),
    hint = Color(255, 255, 255, 50)
}

local MATERIALS = {
    walkiehear = Material('luna_menus/hud/walkie-talkie2.png'),
    walkievoice = Material('luna_menus/hud/wave.png')
}

local function w(px) return round(px * sw) end
local function h(px) return round(px * sh) end

local function ColorApproach(current, target, amount)
    return Color(
        math.Approach(current.r, target.r, amount),
        math.Approach(current.g, target.g, amount),
        math.Approach(current.b, target.b, amount),
        math.Approach(current.a, target.a, amount)
    )
end

local function drawShadowText(text, font, x, y, color, xalign, yalign, dist)
    dist = dist or 1
    draw.SimpleText(text, font, x + dist, y + dist, COLORS.shadow, xalign, yalign)
    draw.SimpleText(text, font, x, y, color, xalign, yalign)
end

local function drawShadowTextWithOffset(text, font, x, y, color)
    surface.SetFont(font)
    local textWidth = surface.GetTextSize(text)
    drawShadowText(text, font, x, y, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    return textWidth
end

surface.CreateFont('walkietalkie', {
    font = 'Mont Bold',
    size = ScreenScale(7),
    weight = 400,
    antialias = true,
    extended = true
})

local radio_s, micro_s = false, false
local lastToggleTime = 0
local hearcol_current, voicecol_current

local function handleInput()
    if CurTime() - lastToggleTime < 0.2 then return end
    
    if input.IsKeyDown(KEY_LSHIFT) then
        if input.IsKeyDown(KEY_M) then
            netstream.Start('WalkieTalkie.SpeakerToggle')
            radio_s = not radio_s
            lastToggleTime = CurTime()
        elseif input.IsKeyDown(KEY_T) then
            netstream.Start('WalkieTalkie.MicroToggle')
            micro_s = not micro_s
            lastToggleTime = CurTime()
        end
    end
end

local function paintWalkieTalkieHUD()
    if Menu and Menu:IsVisible() then return end

    local ft = FrameTime()
    local ply = LocalPlayer()
    local phrase_m = ply:GetNetVar('micro') == 1 and 'WŁ' or ply:GetNetVar('micro') == 2 and 'WŁ' or 'WYŁ'
    local phrase_s = ply:GetNetVar('speaker') and 'WŁ' or 'WYŁ'

    local voicecol_target = phrase_m ~= 'WYŁ' and COLORS.green or COLORS.red
    local hearcol_target = phrase_s ~= 'WYŁ' and COLORS.green or COLORS.red
    
    hearcol_current = ColorApproach(hearcol_current or hearcol_target, hearcol_target, ft * 255)
    voicecol_current = ColorApproach(voicecol_current or voicecol_target, voicecol_target, ft * 255)

    local offsetx = baseX
    local newof = ply:GetNetVar('micro') == 2 and 35 or ply:GetNetVar('micro') == 1 and -16 or 0

    local function drawElement(text, color)
        offsetx = offsetx + drawShadowTextWithOffset(text, 'walkietalkie', offsetx - newof, basey - h(15), color)
    end

    drawElement('Częstotliwość: ', color_white)
    drawElement(tostring(ply:GetNetVar('radio') or '0'), COLORS.blue)
    drawElement(' • Krótkofalówka: ', color_white)
    drawElement(phrase_s, COLORS.blue)
    drawElement(' • Mikrofon: ', color_white)
    drawElement(phrase_m, COLORS.blue)

    draw.SimpleText('Krótkofalówka SHIFT+M | Mikrofon SHIFT+T', 'walkietalkie', offsetx, basey - h(-6), Color(255, 255, 255, 50), 2, 3)
    
    draw.RoundedBox(6, scrw - w(65), basey - h(45) / 3, w(2), h(45), COLORS.gray)
    surface.SetDrawColor(voicecol_current)
    surface.SetMaterial(MATERIALS.walkievoice)
    surface.DrawTexturedRect(scrw - w(55), basey - h(50) / 3, w(24), h(24))
    surface.SetDrawColor(hearcol_current)
    surface.SetMaterial(MATERIALS.walkiehear)
    surface.DrawTexturedRect(scrw - w(55), basey - h(-17) / 3, w(24), h(24))
end

hook.Add('Think', 'WalkieTalkie_Think', handleInput)
hook.Add('HUDPaint', 'WalkieTalkie_HUDPaint', paintWalkieTalkieHUD)

hook.Add('PlayerStartVoice', 'RadioSound_PlayerStartVoice', function(ply)
    if ply:GetNetVar('micro') == 1 then
        ply:EmitSound('luna_sound_effects/radio/radio_static_republic_start_01_0' .. math.random(1, 7) .. '.mp3', 60, 100, 1, CHAN_AUTO)
    end
end)

hook.Add('PlayerEndVoice', 'RadioSound_PlayerEndVoice', function(ply)
    if ply:GetNetVar('micro') == 1 then
        ply:EmitSound('luna_sound_effects/radio/radio_static_republic_stop_01_0' .. math.random(1, 5) .. '.mp3', 60, 100, 1, CHAN_AUTO)
    end
end)

hook.Add('OnScreenSizeChanged', 'Walkie.size', function(_, _, nw, nh)
    scrw, scrh = nw, nh
    sw, sh = scrw / 1920, scrh / 1080
    basey = scrh - round(45 * sh)
    baseX = scrw - round(400 * sw)
end)

-- Old code:
-- local time = CurTime()
-- local radio_s = radio_s or false
-- local micro_s = micro_s or false
-- local scrw, scrh = ScrW(), ScrH()
-- local sw, sh = scrw / 1920, scrh / 1080
-- local round = math.Round
-- local walkiehear = Material("luna_menus/hud/walkie-talkie2.png")
-- local walkievoice = Material("luna_menus/hud/wave.png")
-- local c = {
--     blue = Color(7, 110, 203),
--     gray = Color(174, 174, 174)
-- }
-- local function w(px)
--     return round(px * sw)
-- end

-- local function h(px)
--     return round(px * sh)
-- end
-- local basey = ScrH() - h(45)
-- local baseX = ScrW() - w(400)
-- local function ColorApproach(current, target, amount)
--     local newColor =
--         Color(
--         math.Approach(current.r, target.r, amount),
--         math.Approach(current.g, target.g, amount),
--         math.Approach(current.b, target.b, amount),
--         math.Approach(current.a, target.a, amount)
--     )
--     return newColor
-- end

-- local function drawShadowSimpleText(text, font, x, y, color, xalign, yalign, dist, shadowcolor)
--     dist = dist or 1
--     draw.SimpleText(text, font, x + dist, y + dist, shadowcolor or Color(0, 0, 0, 190), xalign, yalign)
--     draw.SimpleText(text, font, x, y, color, xalign, yalign)
-- end

-- local function drawShadowTextWithOffset(text, font, x, y, color)
--     surface.SetFont(font)
--     local textWidth = surface.GetTextSize(text)
--     drawShadowSimpleText(text, font, x, y, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 190))
--     return textWidth
-- end

-- surface.CreateFont(
--     "walkietalkie",
--     {
--         size = ScreenScale(7),
--         weight = 400,
--         antialias = true,
--         additive = false,
--         extended = true,
--         blursize = 0,
--         font = "Mont Bold"
--     }
-- )

-- hook.Add("Think", "WalkieTalkie_Think",
--     function()
--         local radio = LocalPlayer():GetNetVar("radio")
--         if not radio then
--             return
--         end
--         if time > CurTime() then
--             return
--         end
--         if input.IsKeyDown(KEY_LSHIFT) and input.IsKeyDown(KEY_M) then
--             netstream.Start("WalkieTalkie.SpeakerToggle")
--             radio_s = not radio_s
--             time = CurTime() + 0.2
--         end

--         if input.IsKeyDown(KEY_LSHIFT) and input.IsKeyDown(KEY_T) then
--             netstream.Start("WalkieTalkie.MicroToggle")
--             micro_s = not micro_s
--             time = CurTime() + 0.2
--         end
--     end
-- )

-- local function icon(x, y, w, h, Mat, tblColor)
--     surface.SetMaterial(Mat)
--     surface.SetDrawColor(tblColor or Color(255, 255, 255, 255))
--     surface.DrawTexturedRect(x, y, w, h)
-- end

-- hook.Add("HUDPaint", "WalkieTalkie_HUDPaint",
--     function()
--         if Menu and Menu:IsVisible() then
--             return
--         end
--         local ft = FrameTime()
--         local phrase_m = "ВЫКЛ"
--         local phrase_s = LocalPlayer():GetNetVar("speaker") and "ВКЛ" or "ВЫКЛ"
--         local micro = LocalPlayer():GetNetVar("micro")
--         if micro == 1 then
--             phrase_m = "ВКЛ"
--         elseif micro == 2 then
--             phrase_m = "ВЕЩАНИЕ"
--         end

--         local voicecol_target = phrase_m ~= "ВЫКЛ" and Color(66, 192, 62) or Color(255, 43, 43)
--         local hearcol_target = phrase_s ~= "ВЫКЛ" and Color(66, 192, 62) or Color(255, 43, 43)
--         local hearcol_current = ColorApproach(hearcol_current or hearcol_target, hearcol_target, ft * 255)
--         local voicecol_current = ColorApproach(voicecol_current or voicecol_target, voicecol_target, ft * 255)
--         local newof = micro == 2 and 35 or micro == 1 and -16 or 0 -- АХАХ ИЗВИНИТЕ Я ЦЕЛЫЙ ДЕНЬ РАБОТАЮ МОЗГ УЖЕ ПРОСТО КИПИТ SURFACE.GETTEXTSIZE НЕ ПОМНЮ КАК
--         local offsetx = baseX
--         offsetx =
--             offsetx + drawShadowTextWithOffset("Частота: ", "walkietalkie", offsetx - newof, basey - h(15), color_white)
--         offsetx =
--             offsetx +
--             drawShadowTextWithOffset(
--                 tostring(LocalPlayer():GetNetVar("radio") or "0"),
--                 "walkietalkie",
--                 offsetx - newof,
--                 basey - h(15),
--                 c.blue
--             )
--         offsetx =
--             offsetx +
--             drawShadowTextWithOffset(" • Рация: ", "walkietalkie", offsetx - newof, basey - h(15), color_white)
--         offsetx = offsetx + drawShadowTextWithOffset(phrase_s, "walkietalkie", offsetx - newof, basey - h(15), c.blue)
--         offsetx =
--             offsetx +
--             drawShadowTextWithOffset(" • Микро: ", "walkietalkie", offsetx - newof, basey - h(15), color_white)
--         offsetx = offsetx + drawShadowTextWithOffset(phrase_m, "walkietalkie", offsetx - newof, basey - h(15), c.blue)
--         draw.SimpleText(
--             "Рация SHIFT+M | Микрофон SHIFT+T",
--             "walkietalkie",
--             offsetx,
--             basey - h(-6),
--             Color(255, 255, 255, 50),
--             2,
--             3
--         )
--         draw.RoundedBox(6, scrw - w(65), basey - h(45) / 3, w(2), h(45), c.gray)
--         icon(scrw - w(55), basey - h(50) / 3, w(24), h(24), walkievoice, voicecol_current)
--         icon(scrw - w(55), basey - h(-17) / 3, w(24), h(24), walkiehear, hearcol_current)
--     end
-- )

-- hook.Add("PlayerStartVoice", "RadioSound_PlayerStartVoice",
--     function(ply)
--         local micro = ply:GetNetVar("micro")
--         if micro == 1 then
--             ply:EmitSound(
--                 "luna_sound_effects/radio/radio_static_republic_start_01_0" .. math.random(1, 8) .. ".mp3",
--                 60,
--                 100,
--                 1,
--                 CHAN_AUTO
--             )
--         end
--     end
-- )

-- hook.Add("PlayerEndVoice", "RadioSound_PlayerEndVoice", 
--     function(ply)
--         local micro = ply:GetNetVar("micro")
--         if micro == 1 then
--             ply:EmitSound("luna_sound_effects/radio/radio_static_republic_stop_01_0" .. math.random(1, 5) .. ".mp3", 60, 100, 1, CHAN_AUTO)
--         end
--     end
-- )

-- hook.Add("OnScreenSizeChanged", "Walkie.size",
--     function(_, _, nw, nh)
--         scrw, scrh, sw, sh = nw, nh, ScrW() / 1920, ScrH() / 1080
--     end
-- )
