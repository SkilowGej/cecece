--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Rusznikarz"

att.Icon = Material("interfaz/iconos/kraken/jedi guns dirty fighting/1908223959_3315526753.png")
att.Description = "Specjalne szkolenie i niewielka dodatkowa konserwacja broni pozwolą Ci szybciej reagować po wystrzale, zwiększając szybkostrzelność."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}
att.Slot = "perk"

att.AutoStats = true
att.Mult_CycleTime = .7

att.Hook_Compatible = function(wep)
    if wep:GetBuff_Override("Override_ManualAction", wep.ManualAction) then return end
    for i, v in pairs(wep.Firemodes) do
        if !v then continue end
        if v.Mode and v.Override_ManualAction then
            return
        end
    end
    return false
end

att.NotForNPCs = true

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
