--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Match Trigger"

att.Icon = Material("entities/att/arccw_uc_matchgradetrigger.png", "mips smooth")
att.Description = "Hair trigger for competition shooting allows crisp trigger pulls, improving first shot performance."
att.Desc_Pros = {
    "uc.match.1",
    "uc.match.2",
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}
att.Slot = {"uc_fg","uc_fg_singleshot"}
att.SortOrder = 2
att.AutoStats = true

att.Hook_Compatible = function(wep)
    if wep:GetIsManualAction() then
        return false
    end
end

att.Override_ShotRecoilTable = {[1] = 0.75}
att.Mult_TriggerDelayTime = 0.5

--[[]
att.M_Hook_Mult_AccuracyMOA = function(wep, data)
    if wep:GetBurstCount() == 0 then
        data.mult = data.mult * 0.5
    end
end
]]

att.AttachSound = "arccw_uc/common/gunsmith/internal_modification.ogg"

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
