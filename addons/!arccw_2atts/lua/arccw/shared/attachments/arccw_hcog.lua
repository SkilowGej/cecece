--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Прицел HCOG (1.85x)"
att.Icon = Material("entities/arccw_hcog.png", "mips smooth")
att.Description = "Прицел HCOG доступен для большинства основного оружия. Прицел состоит из красного шеврона, окруженного прозрачной рамкой, что обеспечивает пользователю менее затрудненный обзор, чем стандартный железный прицел. Прицел имеет низкий уровень увеличения. "

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

att.Model = "models/weapons/arccw/optic_hcog.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0, 10, -1.35),
        Ang = Angle(0, 0, 0),
        Magnification = 1,
        IgnoreExtra = true
    },
}

att.Holosight = true
att.HolosightReticle = Material("hud/holosight/tit_hcog.png", "mips smooth")
att.HolosightNoFlare = true
att.HolosightSize = 5
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
