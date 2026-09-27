--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Tryb ogłuszający"
att.AbbrevName = "Ogłuszające naboje (5 sekund)"
att.SortOrder = -2
att.Icon = Material("")
att.Description = "Ogłuszające naboje."

att.Desc_Pros = {
    "Powoduje ogłuszenie trwające 5 sekund!"
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}

att.Slot = {"sw_ammo"}

att.SortOrder = -9001
att.AutoStats = true

att.Override_AmmoPerShot = 5
att.Override_Num_Priority = 9001
att.Override_Tracer = "effect_sw_laser_blue_stun"

att.Hook_BulletHit = function(wep, data)
	GMSERV:AddStatus(data.tr.Entity, data.att, "stun", 5, 5, true) --Entity,Owner,Status Effect Type (Yes, you can add the others),Duration, Damage, ParticleEffect
end

att.Hook_GetShootSound = function(wep, sound)
    return false
end

att.Hook_AddShootSound = function(wep, data)
    wep:MyEmitSound("w/stun_sound.wav", data.volume, data.pitch, 1, CHAN_WEAPON - 1)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
