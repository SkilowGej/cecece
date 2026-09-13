--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

HackConsole.Minigames = HackConsole.Minigames or {}

-- surface.CreateFont("hack_console_reaction_minigame", {
--     font = "Mont Bold",
--     size = 60,
--     weight = 400,
--     antialias = true,
--     extended = true
-- })

local function DrawTextCenter(text, x, y)
    local w, h = surface.GetTextSize(text)

    surface.SetTextPos(x - w / 2, y - h / 2)
    surface.DrawText(text)
end

function HackConsole.Minigames.ReactionStart(ent)
    if IsValid(HackConsole.Minigames.Minigame) then return end

    local skull = Material("luna_icons/compact-disc.png", "smooth")

    local frame = vgui.Create("DPanel")
    frame:SetSize(ScrW(), ScrH())
    frame:SetPos(0, 0)
    frame:MakePopup()

    function frame:Paint(w, h)
        local start_time = ent:GetStartTime()
        local hack_time = ent:GetHackTime()


        surface.SetDrawColor(5, 5, 5, 240)
        surface.DrawRect(0, 0, w, h)

        surface.SetMaterial(skull)
        surface.SetDrawColor(255, 255, 255, 40)
        surface.DrawTexturedRectRotated(w/2, h/2, 512, 512, (CurTime() * 36) % 360)



        surface.SetTextColor(255, 255, 255)
        surface.SetFont("font_mont_black_50")
        
        local time = math.Round(hack_time - (CurTime() - start_time))
        DrawTextCenter("Zostało czasu: " .. time.. " s.", w/2, 60)
    end

    local config = HackConsole.MinigamesSettings.Reaction

    local size = config.ButtonSize

    local clrs = config.Colors

    local key_mat = Material(config.ButtonMaterial, "smooth")

    local buttons_num = 0

    local function SpawnButton(i)
        local key = vgui.Create( "DButton", frame )
        key:SetSize( size, size )
        key:SetPos( math.random(size, ScrW()-size), math.random(size, ScrH()-size) )
        key:SetText("")

        key.Color = clrs[math.random(1,#clrs)]

        buttons_num = buttons_num + 1

        function key:Paint(w, h)
            surface.SetMaterial(key_mat)
            surface.SetDrawColor(self.Color)
            local old = DisableClipping(true)
            surface.DrawTexturedRectRotated(size/2, size/2, size, size, (CurTime() * 96) % 360)
            DisableClipping(old)
        end

        function key:DoClick()
            surface.PlaySound("sup_sound/digitalaccept.wav")
            key:AlphaTo(0, 0.1, 0)
            timer.Simple(0.1, function()
                key:Remove()
            end)
        end

        function key:OnRemove()
            buttons_num = buttons_num - 1

            if buttons_num == 0 then
                if not IsValid(frame) then return end
                RunConsoleCommand("stopsound")
                ent:SendSuccess()

                timer.Simple(0.1, function()
                    surface.PlaySound("sup_sound/hack.wav")
                end)
            end
        end

        timer.Simple((config.SpawnInterval * 3) * (i or 1), function()
            if not IsValid(key) then return end

            key:Remove()
        end)
    end

    for i = 1, 3 do
        SpawnButton(i)
    end

    timer.Create("ReactionMinigame_SpawnButton", config.SpawnInterval, 0, SpawnButton)

    function frame:OnRemove()
        timer.Remove("ReactionMinigame_SpawnButton")

        if self.Finished then return end

        ent:SendFail()
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

	surface.PlaySound("luna_sound_effects/hacking/intromusic5.mp3")

    HackConsole.Minigames.Minigame = frame
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
