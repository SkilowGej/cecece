--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

surface.CreateFont("hack_console_entity_name", {
    font = "Mont Bold",
    size = 90,
    weight = 400,
    antialias = true,
    extended = true
})

surface.CreateFont("hack_console_entity_subtext", {
    font = "Mont Bold",
    size = 50,
    weight = 400,
    antialias = true,
    extended = true
})

surface.CreateFont("hack_console_entity_progress", {
    font = "Mont Bold",
    size = 30,
    weight = 400,
    antialias = true,
    extended = true
})

function ENT:Initialize()
    -- Initialization logic if any
end

function ENT:SendSuccess()
    net.Start("hack_console_action")
        net.WriteUInt(1, 8)
        net.WriteEntity(self)
    net.SendToServer()
    self.Entity:SetSkin(2)
end

function ENT:SendFail()
    net.Start("hack_console_action")
        net.WriteUInt(2, 8)
        net.WriteEntity(self)
    net.SendToServer()
    self.Entity:SetSkin(3)
end

function ENT:OpenMenu()
    if self.MenuOpened then return end

    self.MenuOpened = true

    local typ = self:GetType()

    if typ == 1 then
        HackConsole.Minigames.SnakeStart(self)
    elseif typ == 2 then
        HackConsole.Minigames.ReactionStart(self)
    end
    self.Entity:SetSkin(1)
end

function ENT:CloseMenu()
    if not self.MenuOpened then return end

    self.MenuOpened = false
    
    HackConsole.Minigames.Stop()
end

-- Your existing code...

net.Receive("hack_console_action", function()
    local typ = net.ReadUInt(8)
    local ent = net.ReadEntity()

    -- Check if ent is valid before trying to call any method
    if not IsValid(ent) then
        print("[Error] Invalid entity or 'OpenMenu' method not found for entity: [NULL Entity]")
        return
    end

    if typ == 1 then
        -- Check if the entity has the OpenMenu method
        if ent.OpenMenu then
            ent:OpenMenu()
        else
            print("[Error] 'OpenMenu' method not found for entity:", ent)
        end
    elseif typ == 2 then
        -- Check if the entity has the CloseMenu method
        if ent.CloseMenu then
            ent:CloseMenu()
        else
            print("[Error] 'CloseMenu' method not found for entity:", ent)
        end
    end
end)

-- Continue with your existing code...


local function DrawText(text, x, y)
    local w, h = surface.GetTextSize(text)

    surface.SetTextPos(x - w / 2, y - h / 2)
    surface.DrawText(text)
end

local progress_bar_background_color = Color(33, 33, 36)
local progress_bar_color = Color(47, 181, 20)

function ENT:DrawGUI()
    surface.SetFont("hack_console_entity_name")
    surface.SetTextColor(255, 255, 255)

    DrawText(self:GetConsoleName(), 0, 0)

    local state = self:GetState()

    surface.SetFont("hack_console_entity_subtext")

    if state == 1 then
        DrawText("Pozostało prób: " .. self:GetAttemptLeft(), 0, 60)
    elseif state == 2 then
        DrawText("Idzie włamanie" .. string.rep(".", (CurTime()*2)%4), 0, 60)

        if self:GetType() == 3 then
            local start_time = self:GetStartTime()
            local hack_time = self:GetHackTime()

            local width = 400
            local height = 40

            local y = 100

            if self:GetWarningHold() then
                local t = ((math.sin(CurTime() * 20) + 1) / 2) * 255
                surface.SetTextColor(255, t, t)
                DrawText("![Przyciśnij E]!", 0, y + 69)
                surface.SetTextColor(255, 255, 255)
            end

            surface.SetDrawColor(progress_bar_background_color)
            surface.DrawRect(-(width/2), y, width, height)
        
            local padding = 6

            local progress = (CurTime() - start_time) / hack_time

            progress = math.Clamp(progress, 0, 1)

            local progress_width = progress * (width-(padding*2))
            local progress_height = height-(padding*2)

            surface.SetDrawColor(progress_bar_color)
            surface.DrawRect(-(width/2) + padding, y + padding, progress_width, progress_height)

            local progress_txt = tostring(math.Round(progress, 2) * 100)
            
            surface.SetFont("hack_console_entity_progress")
            DrawText(progress_txt .. "%", 0, y + 19)
        end
    elseif state == 3 then
        DrawText("Porażka....", 0, 60)

        if self:GetCanRepeat() then
            local failed_time = self:GetCooldownTime()
            local cooldown_time = HackConsole.ConsoleAllFailedCooldown

            local sec = math.Round(cooldown_time - (CurTime() - failed_time))

            DrawText("Będziesz mógł powtórzyć za: ".. sec .." с.", 0, 100)
        end
    elseif state == 4 then
        DrawText("Konsola została pomyślnie zhakowana!", 0, 60)
    elseif state == 5 then
        DrawText("Coś nie wyszło....", 0, 60)
        
        local failed_time = self:GetCooldownTime()
        local cooldown_time = HackConsole.ConsoleFailedCooldown

        local sec = math.Round(cooldown_time - (CurTime() - failed_time))

        DrawText("Będziesz mógł powtórzyć za: ".. sec .." с.", 0, 100)

    elseif state == 404 then
        DrawText("404", 0, 60)
    end
end

function ENT:Draw()
    self:DrawModel()
end

local consoles = {}

timer.Create("DrawTextsHackConsole", 0.5, 0, function()
    local dist = HackConsole.ConsoleTextDistance
    consoles = {}

    for k, v in pairs(ents.FindByClass("hack_console")) do
        if v:GetPos():DistToSqr(LocalPlayer():EyePos()) < dist*dist then
            table.insert(consoles, v)
        end
    end
end)

hook.Add("PostDrawTranslucentRenderables", "DrawTextsHackConsole", function(dd, drawSkybox)
    if drawSkybox then return end

    for k, v in pairs(consoles) do
        if not IsValid(v) then continue end

        local tbl = HackConsole.ConsoleModelsTexts[v:GetModel()]

        if not tbl then continue end

        local pos = v:LocalToWorld(v:OBBCenter() + tbl.pos)
        local ang = v:GetAngles()

        cam.Start3D2D(pos, Angle(0, ang.yaw, 90) + tbl.ang, 0.1)
            v:DrawGUI()
        cam.End3D2D()
    end
end)


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
