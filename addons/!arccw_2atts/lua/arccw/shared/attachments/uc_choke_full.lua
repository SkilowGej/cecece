--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Full Choke"

att.Icon = nil -- Material("entities/att/acwatt_lowpolysaiga12extmag.png", "smooth mips")
att.Description = "A very tight choke for shotguns, noticably tightening spread. However, it tends to offset aiming."
att.Desc_Pros = {
}
att.Desc_Cons = {
    "uc.disp.100"
}
att.Desc_Neutrals = {
}
att.Slot = {"choke","muzzle"}
att.AutoStats = true

att.Hook_Compatible = function(wep)
    if !wep:GetIsShotgun() then
        return false
    end
end

att.Mult_Recoil = 1.25
att.Mult_RecoilSide = 1.5
att.Mult_AccuracyMOA = .7
att.Add_HipDispersion = 100
att.Add_SightsDispersion = 100

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
