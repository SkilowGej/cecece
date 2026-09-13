--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Overload"

att.Icon = Material("entities/att/arccw_uc_tp_overload.png", "smooth mips")
att.Description = "With a little grease and some physical force, most magazines can be made to accept an extra round."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}
att.Slot = "uc_tp"

att.AutoStats = true
att.SortOrder = 8

att.Add_ClipSize = 1

att.Hook_Compatible = function(wep)
    if wep.RejectMagSizeChange or wep:GetCapacity() == 1 then return false end
end

att.NotForNPCs = true

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
