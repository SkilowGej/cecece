--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Condition Overload"

att.Icon = Material("interfaz/armas/sw_powercell2.png")
att.Description = "Za pomocą niewielkiej ilości smaru i ładunku kompresyjnego większość magazynków można zmusić do przyjęcia dodatkowego naboju."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}
att.Slot = "perk"

att.AutoStats = true
att.Add_ClipSize = 20

att.Hook_Compatible = function(wep)
    if wep.RejectMagSizeChange or wep:GetCapacity() == 1 then return false end
end

att.NotForNPCs = true

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
