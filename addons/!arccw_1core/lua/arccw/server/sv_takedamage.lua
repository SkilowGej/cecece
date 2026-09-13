--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if CLIENT then return end

hook.Add("EntityTakeDamage", "ArcCW_DoAttDMG", function(ent, dmg)
    if !ent:IsPlayer() then return end

    local wpn = ent:GetActiveWeapon()

    if !wpn.ArcCW then return end

    for i, k in pairs(wpn.Attachments) do
        if !k.Installed then continue end
        local atttbl = ArcCW.AttachmentTable[k.Installed]

        if atttbl.Hook_PlayerTakeDamage then
            atttbl.Hook_PlayerTakeDamage(wpn, {slot = i, atthp = k.HP, dmg = dmg})
        end
    end

    wpn:SendAttHP()
end)

hook.Add("DoPlayerDeath","ArcCW_GrenadeDrop",function(ply)
    local wep = ply:GetActiveWeapon()
    if !(wep.ArcCW and wep.Throwing) then return end

    if wep:GetGrenadePrimed() then
        wep:GrenadeDrop()
    end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
