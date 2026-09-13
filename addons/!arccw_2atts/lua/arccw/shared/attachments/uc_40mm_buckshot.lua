--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "40mm Buckshot Grenades"
att.AbbrevName = "Buckshot"
att.Icon = Material("entities/att/arccw_uc_40mm_generic.png", "mips smooth")
att.Description = "Officially desginated the 'Multiple Projectile Anti Personnel' ammunition, these grenades are effectively large buckshot rounds containing 20 pellets.\nIntended to be used when the enemy is too close to use explosives."
att.Desc_Pros = {
    "uc.40mm.buckshot"
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}
att.Slot = "uc_40mm"

att.AutoStats = true

att.Override_ShootEntity = false
att.Override_Num = 20

att.Override_Damage = 18 * 20
att.Override_DamageMin = 6 * 20

att.Override_Range = 50
att.Override_RangeMin = 5
att.Override_HullSize = 0.5

att.Override_AccuracyMOA = 50

att.ActivateElements = {"40mm_buckshot"}

att.Hook_SelectReloadAnimation = function(wep, anim)
    return anim .. "_shotgun"
end

att.Hook_GetShootSound = function(wep, fsound)
    if fsound == wep.ShootSound then return ")^/arccw_uc/common/gl_fire_buck.ogg" end
end

att.Hook_GetDistantShootSound = function(wep, distancesound)
    if distancesound == wep.DistantShootSound then
        return ")^/arccw_uc/common/gl_fire_buck_dist.ogg" end
end

if engine.ActiveGamemode() == "urbanstrife" then
    att.PenetrationAmmoType = "buckshot"
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
