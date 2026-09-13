--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Mistrz wszystkich dziedzin"
att.Icon = Material("interfaz/iconos/kraken/jedi guns dirty fighting/3726085931_3536543931.png")
att.Description = "Strzelaj tylko jedną ręką. Zwiększa to mobilność broni, ale celny strzał staje się w najlepszym razie trudny, a w najgorszym – praktycznie niemożliwy. Ponieważ celność jest już na granicy możliwości, osoby stosujące ten styl preferują strzelanie podczas sprintu z pełną prędkością."
att.Desc_Pros = {
    "+6% Coolness"
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}
att.Slot = "perk"

att.AutoStats = true

att.Override_ShootWhileSprint = true
att.Mult_HipDispersion = 0.75

att.Mult_Recoil = 1.5
att.Mult_RecoilSide = 2
att.Mult_SightTime = 1.5
att.Mult_Sway = 2
--att.Mult_MoveDispersion = 2
att.Mult_MoveSpeed = .95

att.LHIK = true
att.LHIKHide = true
att.Override_HoldtypeActive = "pistol"
att.Override_HoltypeActive_Priority = 999
att.Override_HoldtypeSights = "pistol"
att.Override_HoltypeSights_Priority = 999
att.Override_HoldtypeHolstered = "normal"

att.Hook_Compatible = function(wep, data)
    if wep:GetIsManualAction() and wep:GetBuff("HoldtypeActive") ~= "pistol" and wep:GetBuff("HoldtypeActive") ~= "revolver" then return false end
end

att.NotForNPCs = true

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
