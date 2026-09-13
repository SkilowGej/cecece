--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "DLT-19x Magnifying Optic"
att.Icon = Material("entities/dlt19x_icon.png")
att.Description = "High-magnification sniper rifle scope for long range combat."

att.SortOrder = 9

att.Desc_Pros = {
    "autostat.holosight",
    "autostat.zoom",
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "optic"

att.Model = "models/weapons/arccw/DLT19X_scope.mdl"
att.ModelOffset = Vector(0, 0, -0.1)
att.AdditionalSights = {
    {
        Pos = Vector(0, 14, -1.6),
        Ang = Angle(0, 0, 0),
        Magnification = 1.5,
        ScrollFunc = ArcCW.SCROLL_ZOOM,
        ZoomLevels = 10,
        ZoomSound = "weapons/arccw/fiveseven/fiveseven_slideback.wav",
        IgnoreExtra = true
    }
}

att.ScopeGlint = false

att.Holosight = true
att.HolosightReticle = Material("scope/star_ret.png", "smooth")
att.HolosightNoFlare = true
att.HolosightSize = 8.5
att.HolosightBone = "holosight"
att.HolosightPiece = "models/weapons/arccw/DLT19X_scope_HSP.mdl"
att.Colorable = false

att.HolosightMagnification = 0
att.HolosightBlackbox = true

att.HolosightConstDist = 64

att.HolosightMagnificationMin = 2
att.HolosightMagnificationMax = 3
att.HoloSightColorable = false

att.Mult_SightTime = 1.35
att.Mult_SightedSpeedMult = 0.8
att.Mult_SpeedMult = 0.9

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
