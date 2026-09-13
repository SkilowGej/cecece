--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

hook.Add("EntityTakeDamage", "HandlePlayerDamage", function(target, dmginfo)
    if target:IsPlayer() and not dmginfo:IsFallDamage() then
        local armor = target:Armor()
        local damage = dmginfo:GetDamage()
        if armor > 0 then
            if damage <= armor then
                target:SetArmor(armor - damage)
                dmginfo:SetDamage(0)
            else
                local remainingDamage = damage - armor
                target:SetArmor(0)
                dmginfo:SetDamage(remainingDamage)
            end
        end
    end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
