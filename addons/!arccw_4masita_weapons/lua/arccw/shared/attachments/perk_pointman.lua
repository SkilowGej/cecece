--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Pointman"

att.Icon = Material("interfaz/iconos/kraken/jedi juns sharpshooter/3178788454_3701931000.png")
att.Description = "Trening posługiwania się bronią palną i zręczności rąk w celu szybkiego reagowania w sytuacjach przełamania. Treningi w zamkniętej przestrzeni pozwolą Ci skuteczniej posługiwać się bronią długolufową w ciasnych pomieszczeniach. \n\nPointman zawsze jako pierwszy wchodzi do pomieszczenia, jako pierwszy wykrywa i neutralizuje zagrożenie."
att.Desc_Pros = {
    "Reduces barrel length for CQB situations."
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}
att.Slot = "perk"
att.SortOrder = 7

att.AutoStats = true
att.Add_BarrelLength = -10
att.M_Hook_Mult_RPM = function(wep, data)
    if wep:GetCurrentFiremode().Mode == 1 then
        data.mult = data.mult * 1.15
    end
end

att.NotForNPCs = true

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
