--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Experimental Scope"
att.Icon = Material("entities/acwatt_optic_micro.png")
att.Description = "test scope for swrp"

att.SortOrder = 2

att.Desc_Pros = {
    "autostat.holosight",
    "autostat.zoom",
}
att.Desc_Cons = {
}
att.AutoStats = false
att.Slot = "swoptic_module"

att.Model = "models/weapons/arccw/atts/dc17c_sight.mdl"
att.HideModel = false
att.ModelScale = Vector(1, 1, 1)
att.ModelOffset = Vector(0, 0, 0)
att.OffsetAng = Angle(0, 90, 0)
att.AdditionalSights = {
    {
        Pos = Vector(0, 8.5, -1.73),
        Ang = Angle(0, 0, 0),
        Magnification = 1,
    }
}

att.Holosight = true
att.HolosightReticle = Material("#sw/visor/sw_ret_redux_blue.png", "smooth")
att.HolosightNoFlare = false
att.HolosightSize = 6
att.HolosightBone = "holosight"
att.HolosightPiece = "models/weapons/arccw/atts/dc17c_hsp.mdl"

att.HolosightMagnification = 2
att.HolosightBlackbox = true
att.HolosightNoHSP = false

att.Mult_SightTime = 1.08
att.Mult_SightedSpeedMult = 0.94

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
