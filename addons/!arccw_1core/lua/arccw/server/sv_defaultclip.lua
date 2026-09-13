--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if CLIENT then return end

hook.Add("OnEntityCreated", "ArcCW_DefaultClip", function(ent)
    if !ent.ArcCW then return end

    if ArcCW.ConVars["mult_startunloaded"]:GetBool() then
        ent.Primary.DefaultClip = 0
    elseif ent.ForceDefaultClip then
        ent.Primary.DefaultClip = ent.ForceDefaultClip
    elseif ent.Primary.DefaultClip <= 0 then
        ent.Primary.DefaultClip = ent.Primary.ClipSize
    end
end)

hook.Add("PlayerCanPickupWeapon", "ArcCW_EquipmentSingleton", function(ply, wep)
    if wep.ArcCW and wep.Throwing and wep.Singleton and ply:HasWeapon(wep:GetClass()) then return false end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
