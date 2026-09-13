--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "B2 Rocket"
att.Description = "Test ammo for the B2 Rocket droid"

att.SortOrder = 2

att.Desc_Cons = {
}
att.AutoStats = false
att.Slot = "b2attachments"

att.HideModel = false
att.ModelScale = Vector(0, 0, 0)
att.ModelOffset = Vector(0, 0, 1.25)
att.OffsetAng = Angle(0, -90, 0)

att.Mult_SightTime = 1.08
att.Mult_SightedSpeedMult = 0.94
att.Mult_MuzzleVelocity = 50
att.Override_ChamberSize = -10
att.MagReducer = true
att.Add_ClipSize =  1
att.Override_ShootEntity = "arccw_rocket"

att.Hook_AddShootSound = function(wep, data)
	wep:MyEmitSound("everfall/weapons/rocket_launcher/explosive_rocketlauncher_corebass_close_var_03.mp3", 120, 100, 1, CHAN_WEAPON - 1)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
