local re = re or {}
re.help_points = re.help_points or {}

local function DrawTextShadowed(text, font, x, y, color, shadowColor)
    draw.SimpleText(text, font, x + 1, y + 1, shadowColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText(text, font, x, y, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local function DrawHelpPoint2D(data, scr, dist_alpha)
    local title_font = luna.MontBase18
    local text_font = luna.MontBase24
    local colors = {
        shadow = Color(0, 0, 0, dist_alpha),
        text = Color(255, 255, 255, dist_alpha)
    }
    DrawTextShadowed(data.title, title_font, scr.x, scr.y, colors.text, colors.shadow)
    DrawTextShadowed(data.text, text_font, scr.x, scr.y - 20, colors.text, colors.shadow)
    local arc_params = {
        y = scr.y - 45,
        x = scr.x
    }
    local pointType = HELPPOINTS_TYPES[data.type]
    if pointType then
        draw.NoTexture()
        local arcColor = ColorAlpha(pointType.color, dist_alpha)
        draw.Arc(Vector(arc_params.x, arc_params.y, 0), 0, 360, 14, 32, 14, arcColor)
       
        draw.Arc(Vector(arc_params.x, arc_params.y, 0), 0, 360, 16, 32, 2, colors.text)
        surface.SetDrawColor(colors.text)
        surface.SetMaterial(pointType.icon)
        surface.DrawTexturedRect(scr.x - 10, scr.y - 55, 20, 20)
    end
end

local function DrawHelpPoint3D(data, dist_alpha)
    local angle = (LocalPlayer():GetPos() - data.pos):Angle()
    angle:RotateAroundAxis(angle:Up(), 90)
    angle:RotateAroundAxis(angle:Forward(), 90)
    cam.Start3D2D(data.pos, angle, 0.1)
    local arc_params = { x = 0, y = 0 }
   
    local pointType = HELPPOINTS_TYPES[data.type]
    if pointType then
        draw.NoTexture()
        local arcColor = ColorAlpha(pointType.color, dist_alpha)
        draw.Arc(Vector(arc_params.x, arc_params.y, 0), 0, 360, 140, 320, 140, arcColor)
       
        local whiteColor = Color(255, 255, 255, dist_alpha)
        draw.Arc(Vector(arc_params.x, arc_params.y, 0), 0, 360, 160, 320, 20, whiteColor)
        surface.SetDrawColor(whiteColor)
        surface.SetMaterial(pointType.icon)
        surface.DrawTexturedRectRotated(0, 0, 200, 200, CurTime() * 50)
    end
    cam.End3D2D()
end

hook.Add("HUDPaint", "DrawHelpPoints", function()
    local player_pos = LocalPlayer():GetPos()
    for _, data in pairs(re.help_points) do
        local dist = player_pos:Distance(data.pos)
        local scr = data.pos:ToScreen()
        local dist_alpha = math.Clamp(255 - (dist / 10), 0, 255)
        DrawHelpPoint2D(data, scr, dist_alpha)
    end
end)

hook.Add("PostDrawOpaqueRenderables", "DrawHelpPoints3D", function()
    local player_pos = LocalPlayer():GetPos()
    for _, data in pairs(re.help_points) do
        local dist = player_pos:Distance(data.pos)
        local dist_alpha = math.Clamp(255 - (dist / 10), 0, 255)
        DrawHelpPoint3D(data, dist_alpha)
    end
end)

netstream.Hook("CC_HelpPoint_SendPointToPlayer", function(data)
    local dist = LocalPlayer():GetPos():Distance(data.pos)
    local i = table.insert(re.help_points, data)
    timer.Simple(data.time or 15, function()
        table.remove(re.help_points, i)
    end)
    local pointType = HELPPOINTS_TYPES[data.type]
    if pointType and pointType.sound ~= "" then
        surface.PlaySound(pointType.sound)
    end
end)