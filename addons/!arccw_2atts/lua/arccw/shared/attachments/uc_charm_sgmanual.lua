--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Slugger"

att.SortOrder = 1
att.Icon = Material("entities/att/arccw_uc_ammo_shotgun_generic.png", "mips smooth")
att.Description = "Forces weapons to only use manual-action modes. Not the most competitively viable, but it surely shows you can still kick ass without all those fancy-shmancy automatic modes."
att.Desc_Pros = {
}
att.Desc_Cons = {
    "uc.manualonly",
}
att.Slot = "charm"
att.AutoStats = true

att.ActivateElements = {"uc_manualonly"}
att.GivesFlags = {"needsmanual"}
att.Hook_Compatible = function(wep)
    if (!wep.ManualAction and !wep.UC_CanManualAction) or !wep:GetIsShotgun() then return false end
end

att.Ignore = true

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
