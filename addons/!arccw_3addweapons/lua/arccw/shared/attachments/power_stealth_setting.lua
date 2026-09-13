--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Настройка стелса"
att.Icon = Material("entities/acwatt_go_ammo_blanks.png", "mips smooth")
att.Description = "Настройка «Скрытность» заставляет трасера становиться невидимыми!"
att.Desc_Pros = {
}
att.Desc_Cons = {
}

att.AutoStats = true
att.Slot = "stealth_setting"

att.Override_Tracer = "lrb_11_tracer"
att.Override_MuzzleEffect = false
att.Reload = 1
att.Mult_DamageMin = 0.76
att.Mult_Recoil = 0.9
att.Mult_SightTime = 1
att.Mult_RPM = 1.15
att.NotForNPCs = true
att.Mult_Damage = 0.85
att.Mult_MuzzleVelocity = 0.8

att.Hook_GetShootSound = function(wep, sound)
    return false
end

att.Hook_AddShootSound = function(wep, data)
    wep:MyEmitSound("lrb11/firing/blasters_shared_corebass_silenced_close_var_04.mp3", data.volume, data.pitch, 1, CHAN_WEAPON - 1)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
