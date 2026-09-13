--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Rifled Barrel"

att.Icon = Material("entities/att/arccw_uc_precisionrifling.png", "mips smooth")
att.Description = "Specially made lightweight barrel designed for slug rounds. Improves precision and time to aim noticably."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
    "uc.reqslug"
}
att.Slot = {"uc_fg","uc_fg_singleshot"}
att.AutoStats = true

att.Hook_Compatible = function(wep)
    if !wep:GetIsShotgun() then -- or wep:GetBuff("Num") > 1
        return false
    end
end

att.Mult_AccuracyMOA = 0.5
att.Mult_SightTime = 0.75
att.Mult_HipDispersion = 1.25

att.RequireFlags = {"uc_slug"}
att.GivesFlags = {"uc_fg_sg_rifled"}
att.ExcludeFlags = {"uc_choke_rifled"}

att.AttachSound = "arccw_uc/common/gunsmith/internal_modification.ogg"

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
