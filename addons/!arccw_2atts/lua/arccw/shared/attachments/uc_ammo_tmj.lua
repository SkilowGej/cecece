--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "\"TMJ\" Total Metal Jacket Rounds"
att.AbbrevName = "\"TMJ\" Total Metal Jacket"

att.SortOrder = 2
att.Icon = Material("entities/att/arccw_uc_ammo_generic.png", "mips smooth")
att.Description = "Bullet entirely encased in a thin jacket of metal over a core of different metal to protect it from abrasion or corrosion.\nProtecting the base of a lead-core bullet from burning powder gas may prevent molten lead from being released as a fine spray in turbulent gas leaving the muzzle of a firearm."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}
att.Slot = "uc_ammo"

att.AutoStats = true

att.Mult_DamageMin = 1.2

att.Mult_Damage = 0.9
--att.Mult_RangeMin = 0.75

att.Hook_Compatible = function(wep)
    if wep:GetIsShotgun() then
        return false
    end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
