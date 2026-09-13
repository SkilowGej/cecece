--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Ghosts Tracker (RDS)"
att.Icon = Material("entities/arccw_tracker.png", "mips smooth")
att.Description = "Advanced targeting sight highlights and tracks enemies."

att.SortOrder = 1

att.Desc_Pros = {
    "autostat.holosight",
	"+ Thermal vision"
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "optic"

att.Model = "models/weapons/arccw/scifi/optic_tracker.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(-0.018321, 10, -1.33),
        Ang = Angle(0, 0, 0),
        Magnification = 1.1,
        Thermal = true,
		ThermalScopeColor = Color(255, 165, 0),
        ThermalHighlightColor = Color(255, 165, 0),
        ThermalScopeSimple = false,
        ThermalNoCC = true,
    }
}

att.Holosight = true
att.HolosightReticle = Material("hud/holosight/arccw_tracker.png", "mips smooth")
att.HolosightNoFlare = true
att.HolosightSize = 5.5
att.HolosightBone = "holosight"
att.HolosightPiece = "models/weapons/arccw/scifi/optic_tracker_hsp.mdl"

att.HolosightMagnification = 1.1
att.HolosightBlackbox = false

att.HolosightConstDist = 42

att.Mult_SightTime = 1.4

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
