local ScreenPos = ScrH() - 300
local Colors = {}
Colors[NOTIFY_GENERIC] = COLOR_HOVER
Colors[NOTIFY_ERROR] = Color(202, 49, 28)
Colors[NOTIFY_UNDO] = Color(7, 110, 203)
Colors[NOTIFY_HINT] = Color(255, 181, 18)
Colors[NOTIFY_CLEANUP] = Color(17, 148, 240)
local LoadingColor = Color(17, 148, 240)
-- local Icons = {}
-- Icons[NOTIFY_GENERIC] = Material("sup_ui/hud/lockdown.vmt")
-- Icons[NOTIFY_ERROR] = Material("sup_ui/hud/lockdown.vmt")
-- Icons[NOTIFY_UNDO] = Material("sup_ui/hud/lockdown.vmt")
-- Icons[NOTIFY_HINT] = Material("sup_ui/hud/lockdown.vmt")
-- Icons[NOTIFY_CLEANUP] = Material("sup_ui/hud/lockdown.vmt")
-- local LoadingIcon = Material("sup_ui/hud/lockdown.vmt")
local Notifications = {}

surface.CreateFont("ModernNotification", {
    font = "Roboto",
    size = 20,
    extended = true,
})

local function DrawNotification(x, y, w, h, text, col, progress, notif)
    local frac = 1
    if notif.start then
        frac = (notif.time - CurTime()) / (notif.time - notif.start)
    end
    draw.RoundedBox(0, x + h, y, w - h, h, Color(0, 0, 0, notif.alpha / 1.8), false, true, false, true)
    draw.RoundedBox(0, x + h, y + h - 3, (w - h) * frac, 3, ColorAlpha(col, notif.alpha))
    draw.SimpleText(text, "ModernNotification", x + 32 + 10, y + h / 2, ColorAlpha(COLOR_WHITE, notif.alpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    surface.SetDrawColor(COLOR_WHITE)

    -- if progress then
    --     surface.DrawTexturedRectRotated(x + 16, y + h / 2, 16, 16, -CurTime() * 360 % 360)
    -- else
    -- end
    -- surface.DrawTexturedRect(x + 8, y + 8, 16, 16)
end

function notification.AddLegacy(text, type, time)
    surface.SetFont("ModernNotification")
    local w = surface.GetTextSize(text) + 20 + 32
    local h = 32
    local x = ScrW() / 2 - w / 2
    local y = ScreenPos + 120

    table.insert(Notifications, 1, {
        x = x,
        y = y,
        w = w,
        h = h,
        text = text,
        col = Colors[type],
        -- icon = Icons[type],
        start = CurTime(),
        time = CurTime() + time,
        alpha = 0,
        progress = false,
    })
end

-- for i = 1, 10 do
--     notification.AddLegacy('wefo0i2398074fh8092379h48g72h3487g918349f-02193j1f23f', NOTIFY_GENERIC, 10)
-- end

function notification.AddProgress(id, text)
    surface.SetFont("ModernNotification")
    local w = surface.GetTextSize(text) + 20 + 32
    local h = 32
    local x = ScrW() / 2 - w / 2
    local y = ScreenPos

    table.insert(Notifications, 1, {
        x = x,
        y = y,
        w = w,
        h = h,
        id = id,
        text = text,
        col = LoadingColor,
        start = CurTime(),
        -- icon = LoadingIcon,
        time = math.huge,
        alpha = 0,
        progress = true,
    })
end

function notification.Kill(id)
    for k, v in ipairs(Notifications) do
        if v.id == id then
            v.time = 0
        end
    end
end

hook.Add("PostRenderVGUI", "DrawNotifications", function()
    for k, v in ipairs(Notifications) do
        DrawNotification(math.floor(v.x), math.floor(v.y), v.w, v.h, v.text, v.col, v.progress, v)
        -- v.x = Lerp(FrameTime() * 10, v.x, v.time > CurTime() and ScrW() / 2 - v.w / 2 or ScrW() + 1)
        v.y = Lerp(FrameTime() * 10, v.y, ScreenPos - (k - 4.5) * (v.h + 5))
        v.alpha = Lerp(FrameTime() * 8, v.alpha, v.time > CurTime() and 255 or 0)
    end

    for k, v in ipairs(Notifications) do
        if v.x >= ScrW() and v.time < CurTime() then
            table.remove(Notifications, k)
        end
    end
end)