--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "DC15a Range Finder"
att.Icon = Material("entities/acwatt_go_ammo_blanks.png", "mips smooth")
att.Description = "Low Cost, High Quality scopes, for your conveinence."

att.SortOrder = 3

att.Desc_Pros = {
    "autostat.holosight",
    "autostat.zoom",
}
att.Desc_Neutrals = {"uc.bus"}

att.AutoStats = true
att.Slot = {"dc15a_range_finder"}

att.Model = "models/atts/dc15a_range_finder_scope1.mdl"
att.ModelOffset = Vector(6.5, 2, 0.7)
att.ModelScale = Vector(1, 1, 1)
att.OffsetAng = Angle(0, 0, 0)

att.AdditionalSights = {
    {
        ---internal scope---
                    --x,y,z--
        Pos = Vector(-1.39, 1.2, -1.55),
        Ang = Angle(0, 0, -30),
        Magnification = 1.1,
        ZoomLevels = 4,
        ViewModelFOV = 38,
        IgnoreExtra = true,
        CrosshairInSights = false,
        HolosightBone = "holosight",
        HolosightData = {
            Holosight = true,
            HolosightReticle = Material("scope/star_ret.png", "smooth"),
            HolosightNoFlare = true,
            HolosightSize = 12,
            HolosightPiece = "models/atts/dc15a_rangefinder_hsp.mdl",
            HolosightBlackbox = true,
            HolosightMagnification =  5,
            Colorable = false,
        },
    },
    {
        ---ironsights---
        Pos = Vector(-0.02, 8, -2.29),
        Ang = Angle(0, 0, 0),
        Magnification = 1,
        IgnoreExtra = true,
        HolosightData = {
            Holosight = false,
            HolosightReticle = Material("scope/star_ret.png", "smooth"),
            HolosightSize = 2,
            Colorable = true,
        },
    },
}

att.Colorable = true
att.HolosightPiece = "models/atts/dc15a_rangefinder_hsp.mdl"

att.Mult_SightedSpeedMult = 0.75
att.Mult_SightTime = 1.1

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
