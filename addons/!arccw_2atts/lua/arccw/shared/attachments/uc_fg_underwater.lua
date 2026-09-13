--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Sealed Bolt"

att.Icon = Material("entities/att/acwatt_uc_sealedbolt.png", "smooth mips")
att.Description = "Watertight modifications that allow the weapon to fire underwater."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}
att.Slot = {"uc_fg", "uc_fg_singleshot"}
att.AutoStats = true
att.SortOrder = 3

att.Override_CanFireUnderwater = true

att.Hook_AddShootSound = function(wep)
    if wep:GetOwner():WaterLevel() >= 3 then
        wep:MyEmitSound("weapons/underwater_explode" .. math.random(3, 4) .. ".wav", 70, math.random(60, 80), 0.5, CHAN_AUTO)
    end
end

att.Hook_PreDoEffects = function(wep)
    if wep:GetOwner():WaterLevel() >= 3 then
        return true
    end
end

att.M_Hook_Mult_ShootPitch = function(wep, data)
    if wep:GetOwner():WaterLevel() >= 3 then
        data.mult = data.mult * 0.6
    end
end

att.AttachSound = "arccw_uc/common/gunsmith/internal_modification.ogg"

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
