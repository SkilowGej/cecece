--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if SERVER then return end

hook.Add("PreDrawHalos", "lscs_halos", function()
    if not IsValid(LocalPlayer()) then return end
    local rebuke = {}
    for k, v in ipairs(player.GetAll()) do
        if not IsValid(v) then continue end
        if v:GetNWFloat("lscs_rebuke", 0) < CurTime() then continue end
        table.insert(rebuke, v)
    end
    halo.Add(rebuke, Color(160,200,0))
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
