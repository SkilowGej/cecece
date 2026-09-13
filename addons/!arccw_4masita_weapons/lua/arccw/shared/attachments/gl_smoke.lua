--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Grenade Launcher (Smoke)"
att.Icon = Material("interfaz/armas/sw_smokegrenade.png")
att.Description = "Grenade Launcher module. Replaces a charged tibanna cartridge with a grenade launcher one."
att.Desc_Pros = {
    "pro.ubgl",
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
    "info.toggleubgl"
}
att.AutoStats = true
att.Slot = "ubgl_module"

att.SortOrder = 1738

att.MountPositionOverride = 0

att.UBGL = true
att.UBGL_BaseAnims = false
att.UBGL_PrintName = "Grenade Launcher (Smoke)"
att.UBGL_Automatic = false
att.UBGL_MuzzleEffect = "swrp_muzzleflash_blue"
att.UBGL_ClipSize = 1
att.UBGL_Ammo = "Grenade"
att.UBGL_RPM = 1200
att.UBGL_Recoil = 2
att.UBGL_Capacity = 1

att.AddSuffix = "Grenadier"

att.Hook_ShouldNotSight = function(wep)
    return wep:GetInUBGL()
end

local function Ammo(wep)
    return wep.Owner:GetAmmoCount("Grenade")
end

att.UBGL_Fire = function(wep, ubgl)
    if wep:Clip2() <= 0 then return end

    wep:PlayAnimation("Reload", 1, true, nil, nil, nil, true)

    wep:FireRocket("tfa_battlefront_ent_nade_smoke", 1000)

    if wep.MW2_M203isGP25 then
        wep:EmitSound("armas3/gl_fire_1.wav", 100)
    else
        wep:EmitSound("armas3/gl_fire_4.wav", 100)
    end

    wep:SetClip2(wep:Clip2() - 1)

    wep:DoEffects()
end

att.UBGL_Reload = function(wep, ubgl)
    if wep:Clip2() >= 1 then return end

    if Ammo(wep) <= 0 then return end

    wep:PlayAnimation("reload", 1, true, nil, nil, nil, true)
    wep:SetReloading(CurTime() + wep:GetAnimKeyTime("reload"))

    local reserve = Ammo(wep)

    reserve = reserve + wep:Clip2()

    local clip = 1

    local load = math.Clamp(clip, 0, reserve)

    wep.Owner:SetAmmo(reserve - load, "Grenade")

    wep:SetClip2(load)
end

att.Mult_SightTime = 1.25
-- att.Mult_SpeedMult = 0.8
att.Mult_SightedSpeedMult = 0.85

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
