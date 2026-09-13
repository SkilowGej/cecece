--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

hook.Add("EntityTakeDamage", "PlayerScreenShakeOnDamage", function(target, dmginfo)
    if IsValid(target) and target:IsPlayer() then
        local shakeAmplitude = 4
        local shakeFrequency = 40
        local shakeDuration = 0.4

        util.ScreenShake(target:GetPos(), shakeAmplitude, shakeFrequency, shakeDuration, 500)
    end
end)


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
