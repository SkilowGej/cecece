--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if CLIENT then
	killicon.Add( "wk_heavyweapons_autocannon", "vgui/killicons/wk_emplacements/autocannon", Color( 255, 255, 255, 255 ) )
	killicon.Add( "wk_heavyweapons_bolter", "vgui/killicons/wk_emplacements/bolter", Color( 255, 255, 255, 255 ) )
	killicon.Add( "wk_heavyweapons_lascannon", "vgui/killicons/wk_emplacements/lascannon", Color( 255, 255, 255, 255 ) )
	killicon.Add( "wk_heavyweapons_rocketlauncher", "vgui/killicons/wk_emplacements/rocket", Color( 255, 255, 255, 255 ) )
end

sound.Add({
    name = "WKEmplacements.TripodDeploy",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 80,
	pitch = 100,
	sound = { "wk_structures/emplacement_deploy_1.mp3", "wk_structures/emplacement_deploy_2.mp3" }
})

sound.Add({
    name = "WKEmplacements.TripodUndeploy",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 80,
	pitch = 100,
	sound = { "wk_structures/emplacement_undeploy_1.mp3", "wk_structures/emplacement_undeploy_2.mp3" }
})

sound.Add({
    name = "WKEmplacements.WeaponDeploy",
	channel = CHAN_WEAPON,
	volume = 0.8,
	level = 80,
	pitch = 100,
	sound = { "wk_structures/emplacement_ready.mp3" }
})

sound.Add({
    name = "WKEmplacements.WeaponDryfire",
	channel = CHAN_WEAPON,
	volume = 0.8,
	level = 80,
	pitch = 100,
	sound = { "wk_structures/emplacement_dryfire.mp3" }
})

sound.Add({
    name = "WKEmplacements.WeaponEnter",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 80,
	pitch = 100,
	sound = { "wk_structures/emplacement_enter.mp3" }
})

sound.Add({
    name = "WKEmplacements.WeaponLeave",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 80,
	pitch = 100,
	sound = { "wk_structures/emplacement_leave.mp3" }
})

sound.Add({
    name = "WKEmplacements.BigRocketFire",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 100,
	pitch = 100,
	sound = { "wk_weapons/bigrocket_fire_1.mp3", "wk_weapons/bigrocket_fire_2.mp3", "wk_weapons/bigrocket_fire_3.mp3" }
})

sound.Add({
    name = "WKEmplacements.Autocannon1",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 100,
	pitch = 100,
	sound = { "^wk_weapons/autocannon_1.mp3" }
})

game.AddParticles( "particles/wk_explosives.pcf" )
PrecacheParticleSystem( "wk_explosives_rocket_trail" )



--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
