--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Wonyeon Defense Holosight (2.1x)"
att.Icon = Material("entities/arccw_titholo.png", "mips smooth")
att.Description = "The preferred sight for many pilots due to its versatility, although it is slightly worst in close fights due to the higher zoom than the Lawai HCOG."

att.SortOrder = 4

att.Desc_Pros = {
    "autostat.holosight",
    "autostat.zoom",
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}
att.AutoStats = true
att.Slot = "optic"

att.Model = "models/weapons/arccw/optic_titholo.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0, 10, -1.35),
        Ang = Angle(0, 0, 0),
        Magnification = 1,
        IgnoreExtra = true
    },
}

att.Holosight = true
att.HolosightReticle = Material("hud/holosight/tit_holo.png", "mips smooth")
att.HolosightNoFlare = true
att.HolosightSize = 2
att.HolosightBone = "holosight"
att.Colorable = true
att.ModelScale = Vector(1.4, 1.4, 1.4)

att.HolosightMagnification = 1

att.Mult_SightTime = 1.01

att.Colorable = false

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
