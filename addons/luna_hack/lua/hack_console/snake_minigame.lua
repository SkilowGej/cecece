--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

HackConsole.Minigames = HackConsole.Minigames or {}

local SNAKE_DIR_UP     = 0
local SNAKE_DIR_BOTTOM = 1
local SNAKE_DIR_LEFT   = 2
local SNAKE_DIR_RIGHT  = 3

local SNAKE_MAP_BACKGROUND = 0
local SNAKE_MAP_ROAD       = 1
local SNAKE_MAP_END        = 2

local SNAKE_VISUAL_START   = 0 -- 40x67
local SNAKE_VISUAL_END     = 1 -- 40x67
local SNAKE_VISUAL_CHIP    = 2 -- 94x93 ???

local SNAKE_STATE_GAME = 0
local SNAKE_STATE_FAIL = 1

local function SnakeFrame(panel, ent)
    local frame = panel:Add("DPanel")
    frame:SetSize(700, 700)
    frame:Center()

    local config = HackConsole.MinigamesSettings.Snake

    local map = config.Maps[math.random(1, #config.Maps)]

    if config.Debug then
        map = config.Maps[config.GetMap]
    end

    local vignette = Material("luna_menus/hud/overlay.png", "noclamp smooth")

    local dir = map.Start[3]

    local snake_size = 14
    local snake_x = map.Start[1] - snake_size / 2
    local snake_y = map.Start[2] - snake_size / 2

    local visual_start = Material("luna_menus/hack/start.png", "smooth")
    local visual_end = Material("luna_menus/hack/end.png", "smooth")
    local visual_chip = Material("luna_menus/hack/chip.png", "smooth")

    local state = SNAKE_STATE_GAME

    local trail_color = Color(112, 106, 100)

    local trails = {}
    local current_trail = {
        Pos = Vector(snake_x + snake_size / 2, snake_y + snake_size / 2, dir),
        Size = Vector(0, 0, 0)
    }

    local offset = 37

    local function CheckInRange(xc, yc, x1, y1, x2, y2)
        return 
            x1 > xc and xc > x2 and
            y1 > yc and yc > y2
    end

    local function CheckInObject(v)
        local minx = v.Pos.X
        local miny = v.Pos.Y

        local maxx = v.Pos.X + v.Size.X
        local maxy = v.Pos.Y + v.Size.Y

        local point_count = 0

        -- Left Up Point
        if CheckInRange(snake_x             , snake_y             , maxx, maxy, minx, miny) then point_count = point_count + 1 end
        
        -- Right Up Point
        if CheckInRange(snake_x + snake_size, snake_y             , maxx, maxy, minx, miny) then point_count = point_count + 1 end

        -- Left Down Point
        if CheckInRange(snake_x             , snake_y + snake_size, maxx, maxy, minx, miny) then point_count = point_count + 1 end
        
        -- Right Down Point
        if CheckInRange(snake_x + snake_size, snake_y + snake_size, maxx, maxy, minx, miny) then point_count = point_count + 1 end

        return point_count
    end

    local function CheckInRoadObject(v)
        return CheckInObject(v) == 4
    end

    local function CheckInEndObject(v)
        return CheckInObject(v) > 0
    end

    local function CheckInRoad()
        for k, v in pairs(map.Objects) do
            if v.Type ~= SNAKE_MAP_ROAD then continue end

            if CheckInRoadObject(v) then
                return true
            end
        end
        
        return false
    end

    local function CheckInEnd()
        for k, v in pairs(map.Objects) do
            if v.Type ~= SNAKE_MAP_END then continue end

            if CheckInEndObject(v) then
                return true
            end
        end

        return false
    end

    local function CheckCollisions()
        if config.Debug then return end

        local inEnd = CheckInEnd()

        if inEnd then
            surface.PlaySound("sup_sound/hack.wav")
            ent:SendSuccess()
            return
        end

        local inRoad = CheckInRoad()
    
        if not inRoad then
            ent:SendFail()
            return
        end
    end

    local function DirectionUpdate(old_dir)
        local trail_dir = current_trail.Pos[3]

        local w_size = current_trail.Size[1]
        local h_size = current_trail.Size[2]

        if trail_dir == SNAKE_DIR_UP then
            current_trail.Size[2] = current_trail.Size[2] - snake_size / 2
        elseif trail_dir == SNAKE_DIR_BOTTOM then
            current_trail.Size[2] = current_trail.Size[2] + snake_size / 2
        elseif trail_dir == SNAKE_DIR_LEFT then
            current_trail.Size[1] = current_trail.Size[1] - snake_size / 2
        elseif trail_dir == SNAKE_DIR_RIGHT then
            current_trail.Size[1] = current_trail.Size[1] + snake_size / 2
        end
        
        table.insert(trails, current_trail)
        
        current_trail = {
            Pos = Vector(current_trail.Pos[1] + w_size, current_trail.Pos[2] + h_size, dir),
            Size = Vector(0, 0, 0)
        }
    end

    local function DrawTrail(trail)

        local trail_dir = trail.Pos[3]

        surface.SetDrawColor(trail_color)

        if trail_dir == SNAKE_DIR_UP then
            local w = trail.Size[1] + snake_size
            local x = trail.Pos[1] - snake_size / 2

            local h = trail.Size[2]
            local y = trail.Pos[2]

            surface.DrawRect(offset + x, offset + y + h, w, -h)
            
        elseif trail_dir == SNAKE_DIR_BOTTOM then
            local w = trail.Size[1] + snake_size
            local x = trail.Pos[1] - snake_size / 2

            local h = trail.Size[2]
            local y = trail.Pos[2]

            surface.DrawRect(offset + x, offset + y, w, h)
        elseif trail_dir == SNAKE_DIR_LEFT then
            local w = trail.Size[1]
            local x = trail.Pos[1]

            local h = trail.Size[2] + snake_size
            local y = trail.Pos[2] - snake_size / 2

            surface.DrawRect(offset + x + w, offset + y, -w, h)
        elseif trail_dir == SNAKE_DIR_RIGHT then
            local w = trail.Size[1]
            local x = trail.Pos[1]

            local h = trail.Size[2] + snake_size
            local y = trail.Pos[2] - snake_size / 2

            surface.DrawRect(offset + x, offset + y, w, h)
        end
    end

    --[[
        local SNAKE_MAP_BACKGROUND = 0
        local SNAKE_MAP_ROAD       = 1
        local SNAKE_MAP_END        = 2
        
        local SNAKE_VISUAL_START   = 0 -- 40x67
        local SNAKE_VISUAL_END     = 1 -- 40x67
        local SNAKE_VISUAL_CHIP    = 2 -- 94x93 ???
    ]]

    local function DrawVisual(v)
        surface.SetDrawColor(255, 255, 255)

        local o = offset

        if v.Type == SNAKE_VISUAL_START then
            surface.SetMaterial(visual_start)

            local w = 40*1.6
            local h = 67*1.6

            surface.DrawTexturedRect(o + v.Pos.X - w/2, o + v.Pos.Y - h/2, w, h)
        elseif v.Type == SNAKE_VISUAL_END then
            surface.SetMaterial(visual_end)
            
            local w = 40*1.6
            local h = 67*1.6

            surface.DrawTexturedRect(o + v.Pos.X - w/2, o + v.Pos.Y - h/2, w, h)
        elseif v.Type == SNAKE_VISUAL_CHIP then
            surface.SetMaterial(visual_chip)

            local w = 74
            local h = 73
            
            surface.DrawTexturedRect(o + v.Pos.X - w/2, o + v.Pos.Y - h/2, w, h)
        end
    end

    local function DrawObject(v)
        surface.SetDrawColor(255, 0, 255)

        if v.Type == SNAKE_MAP_BACKGROUND then
            surface.SetDrawColor(74,161,77)
        elseif v.Type == SNAKE_MAP_ROAD then
            surface.SetDrawColor(57,53,50)
        elseif v.Type == SNAKE_MAP_END then
            surface.SetDrawColor(255, 0, 0)
        end

        surface.DrawRect(offset + v.Pos.X, offset + v.Pos.Y, v.Size.X, v.Size.Y)
    end

    local function DrawMap()
        for k, v in pairs(map.Objects) do
            if v.NoDraw then continue end

            DrawObject(v)
        end


        for k, v in pairs(trails) do
            DrawTrail(v)
        end

        DrawTrail(current_trail)

        surface.SetDrawColor(12, 123, 189)
        surface.DrawRect(offset + snake_x, offset + snake_y, 14, 14)

        for k, v in pairs(map.Visual) do
            if v.NoDraw then continue end

            DrawVisual(v)
        end
    end

    local SnakeThink

    function frame:Paint(w, h)
        SnakeThink()

        surface.SetDrawColor(58, 54, 50)
        surface.DrawRect(0, 0, w, h)
    
        surface.SetDrawColor(74,161,77)
        surface.DrawRect(offset, offset, 626, 626)

        DrawMap()

        surface.SetMaterial(vignette)
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawTexturedRect(offset, offset, 626, 626)

        local inRoad, inEnd = CheckInRoad(), CheckInEnd()

        if config.Debug then
            local fields = {
                "InRoad: " .. tostring(inRoad),
                "InEnd: " .. tostring(inEnd),
                "X: " .. tostring(math.Round(snake_x)),
                "Y: " .. tostring(math.Round(snake_y))
            }
            
            draw.SimpleText(table.concat(fields, " | "), nil, 20, 20, color_white)

            local mx, my = gui.MouseX(), gui.MouseY()

            mx, my = self:ScreenToLocal(mx, my)

            mx, my = mx - 36, my - 36

            draw.SimpleText("Mouse X: " .. mx, nil, 20, 636, color_white)
            draw.SimpleText("Mouse Y: " .. my, nil, 20, 656, color_white)
        end
    end

    local prev_time = CurTime()
    local delta_time = 0

    function SnakeThink()
        delta_time = CurTime() - prev_time
        prev_time = CurTime()
        
        if state ~= SNAKE_STATE_GAME then return end

        local snake_vx = 0
        local snake_vy = 0

        if dir == SNAKE_DIR_UP then
            snake_vy = -config.SnakeSpeed
        elseif dir == SNAKE_DIR_BOTTOM then
            snake_vy = config.SnakeSpeed
        elseif dir == SNAKE_DIR_LEFT then
            snake_vx = -config.SnakeSpeed
        elseif dir == SNAKE_DIR_RIGHT then
            snake_vx = config.SnakeSpeed
        end

        snake_vx = snake_vx * delta_time
        snake_vy = snake_vy * delta_time

        snake_vx = snake_vx
        snake_vy = snake_vy

        snake_x = snake_x + snake_vx
        snake_y = snake_y + snake_vy

        CheckCollisions()

        local snake_trail_w = current_trail.Size[1]
        local snake_trail_h = current_trail.Size[2]

        current_trail.Size[1] = snake_trail_w + snake_vx
        current_trail.Size[2] = snake_trail_h + snake_vy
        -- current_trail.End = Vector(snake_x, snake_y, dir)
    end

    function frame:OnKeyCodePressed(butt)
        local old_dir = dir

        SnakeThink()
        if butt == KEY_W or butt == KEY_UP then
            dir = dir ~= SNAKE_DIR_BOTTOM and SNAKE_DIR_UP or dir
        elseif butt == KEY_S or butt == KEY_DOWN then
            dir = dir ~= SNAKE_DIR_UP and SNAKE_DIR_BOTTOM or dir
        elseif butt == KEY_A or butt == KEY_LEFT then
            dir = dir ~= SNAKE_DIR_RIGHT and SNAKE_DIR_LEFT or dir
        elseif butt == KEY_D or butt == KEY_RIGHT then
            dir = dir ~= SNAKE_DIR_LEFT and SNAKE_DIR_RIGHT or dir
        end

        if dir ~= old_dir then
            DirectionUpdate(old_dir)
        end
    end

    return frame
end

local function DrawTextCenter(text, x, y)
    local w, h = surface.GetTextSize(text)

    surface.SetTextPos(x - w / 2, y - h / 2)
    surface.DrawText(text)
end

-- surface.CreateFont("font_mont_black_50", {
--     font = "Montserrat Bold",
--     size = 50,
--     weight = 400,
--     antialias = true,
--     extended = true
-- })

function HackConsole.Minigames.SnakeStart(ent)
    if IsValid(HackConsole.Minigames.Minigame) then return end

    local alert = Material("renaissance/random/alert.png")

    local frame = vgui.Create("DPanel")
    frame:SetSize(ScrW(), ScrH())
    frame:SetPos(0, 0)
    frame:MakePopup()

    function frame:Paint(w, h)
        local start_time = ent:GetStartTime()
        local hack_time = ent:GetHackTime()

        surface.SetDrawColor(5, 5, 5, 240)
        surface.DrawRect(0, 0, w, h)

        surface.SetFont("font_mont_black_50")
        surface.SetTextColor(255, 255, 255)

        local time = math.Round(hack_time - (CurTime() - start_time))
        DrawTextCenter("Zostało trochę czasu: " .. time.. " s.", w/2, 130)

        -- surface.SetDrawColor(255, 255, 255)
        -- surface.SetMaterial(alert)
        -- surface.DrawTexturedRect(ScrW() / 2 - 350, 100, 64, 64)
        -- surface.DrawTexturedRect(ScrW() / 2 + 350 - 64, 100, 64, 64)
    end

    local snake = SnakeFrame(frame, ent)

    function frame:OnKeyCodePressed(butt)
        snake:OnKeyCodePressed(butt)
    end

    local cross = Material("luna_ui_base/close.png", "smooth")

    local close = vgui.Create("DButton", frame)
    close:SetSize(80, 80)
    close:SetPos(ScrW()-25-80, 25)
    close:SetText("")

    function close:Paint(w, h)
        local color = Color(235,54,61)
        
        if self:IsHovered() then
            color = Color(235/2,54/2,61/2)
        end

        --draw.RoundedBox(12, 0, 0, w, h, color)

        if self:IsHovered() then
            surface.SetDrawColor(200, 200, 200)
        else
            surface.SetDrawColor(255, 255, 255)
        end

        surface.SetMaterial(cross)
        surface.DrawTexturedRect(20, 20, 40, 40)
    end

    function close:DoClick()
        frame:Remove()
    end

    function frame:OnRemove()
        if self.Finished then return end

        ent:SendFail()
        RunConsoleCommand("stopsound")
        --self.Entity:SetSkin(3)
    end

    surface.PlaySound("luna_sound_effects/hacking/intromusic3.mp3")

    HackConsole.Minigames.Minigame = frame
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
