--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

hook.Add("HUDPaint", "RSGen:HealthBar", function()
    local ply = LocalPlayer()
    local gen = ply:GetEyeTrace().Entity
    if (!ply:IsValid() or !gen:IsValid() or gen:GetClass() != "laser_rayshield_gen" or !gen:GetNWBool("health_bar") or ply:GetPos():Distance(gen:GetPos()) > 800) then return nil end

    local maxhealth = gen:GetNWInt("max_health")
    local health = gen:GetNWInt("health")

    local position = gen:LocalToWorld(gen:OBBCenter()):ToScreen()
    local maxwidth = 120
    local curwidth = 120 * health / maxhealth
    local height = 10

    draw.RoundedBox(8, position.x - (maxwidth / 2), position.y - (height / 2) * 8.2, maxwidth, 20, Color(0, 0, 0, 150))
    draw.RoundedBox(8, position.x - (maxwidth / 2), position.y - (height / 2) * 8.2, curwidth, 20, Color(255, 255, 255, 225))
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
