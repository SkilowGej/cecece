--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local blade = {}
blade.PrintName = "Kylos Blade (WIP)" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "rubind" -- internal ID. Always lower case.
blade.color_blur = Color(255,0,0)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.9 -- width
blade.widthWiggle = 1.5 -- how much "noise" the blade has idling
blade.material_core_tip = Material( "lscs/effects/lightsaber_tip" ) -- material of the inner cores blade-tip
blade.material_core = Material( "lscs/effects/lightsaber_core" ) -- material of the inner cores blade
blade.material_glow = Material( "lscs/effects/lightsaber_glow" ) -- glow sprite effect
blade.material_trail = Material( "lscs/effects/lightsaber_trail" ) -- what material to use for the trail
blade.dynamic_light = true -- show dynamic light?
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "Azurite" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "cyan" -- internal ID. Always lower case.
blade.color_blur = Color(0,255,255)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core_tip = Material( "lscs/effects/lightsaber_tip" ) -- material of the inner cores blade-tip
blade.material_glow = Material( "lscs/effects/lightsaber_glow" ) -- glow sprite effect
blade.material_trail = Material( "lscs/effects/lightsaber_trail" ) -- what material to use for the trail
blade.dynamic_light = true -- show dynamic light?
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "Diamond" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "lightblue" -- internal ID. Always lower case.
blade.color_blur = Color(0,152,255)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core_tip = Material( "lscs/effects/lightsaber_tip" ) -- material of the inner cores blade-tip
blade.material_glow = Material( "lscs/effects/lightsaber_glow" ) -- glow sprite effect
blade.material_trail = Material( "lscs/effects/lightsaber_trail" ) -- what material to use for the trail
blade.dynamic_light = true -- show dynamic light?
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "Almadine" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "pink" -- internal ID. Always lower case.
blade.color_blur = Color(137,0,202)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core_tip = Material( "lscs/effects/lightsaber_tip" ) -- material of the inner cores blade-tip
blade.material_glow = Material( "lscs/effects/lightsaber_glow" ) -- glow sprite effect
blade.material_trail = Material( "lscs/effects/lightsaber_trail" ) -- what material to use for the trail
blade.dynamic_light = true -- show dynamic light?
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "Firebrand" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "orange" -- internal ID. Always lower case.
blade.color_blur = Color(255,108,0)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core_tip = Material( "lscs/effects/lightsaber_tip" ) -- material of the inner cores blade-tip
blade.material_glow = Material( "lscs/effects/lightsaber_glow" ) -- glow sprite effect
blade.material_trail = Material( "lscs/effects/lightsaber_trail" ) -- what material to use for the trail
blade.dynamic_light = true -- show dynamic light?
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "Gold" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "gold" -- internal ID. Always lower case.
blade.color_blur = Color(255,209,0)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core_tip = Material( "lscs/effects/lightsaber_tip" ) -- material of the inner cores blade-tip
blade.material_glow = Material( "lscs/effects/lightsaber_glow" ) -- glow sprite effect
blade.material_trail = Material( "lscs/effects/lightsaber_trail" ) -- what material to use for the trail
blade.dynamic_light = true -- show dynamic light?
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "Chartreuse" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "chartreuse" -- internal ID. Always lower case.
blade.color_blur = Color(185,255,0)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core_tip = Material( "lscs/effects/lightsaber_tip" ) -- material of the inner cores blade-tip
blade.material_glow = Material( "lscs/effects/lightsaber_glow" ) -- glow sprite effect
blade.material_trail = Material( "lscs/effects/lightsaber_trail" ) -- what material to use for the trail
blade.dynamic_light = true -- show dynamic light?
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "Quartz" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "white" -- internal ID. Always lower case.
blade.color_blur = Color(135,135,135)
blade.color_core = Color(135,135,135)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core_tip = Material( "lscs/effects/lightsaber_tip" ) -- material of the inner cores blade-tip
blade.material_glow = Material( "lscs/effects/lightsaber_glow" ) -- glow sprite effect
blade.material_trail = Material( "lscs/effects/lightsaber_trail" ) -- what material to use for the trail
blade.dynamic_light = true -- show dynamic light?
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "Red Dark Inner" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "redinner" -- internal ID. Always lower case.
blade.color_blur = Color(255,0,0)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core = Material( "lscs/effects/lightsaber_coreblack")
blade.material_trail = Material( "lscs/effects/lightsaber_trailblack" ) -- what material to use for the trail
blade.material_core_tip = Material( "lscs/effects/lightsaber_tipblack" )
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "Blue Dark Inner" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "blueinner" -- internal ID. Always lower case.
blade.color_blur = Color(0,0,255)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core = Material( "lscs/effects/lightsaber_coreblack")
blade.material_trail = Material( "lscs/effects/lightsaber_trailblack" ) -- what material to use for the trail
blade.material_core_tip = Material( "lscs/effects/lightsaber_tipblack" )
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "Green Dark Inner" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "greeninner" -- internal ID. Always lower case.
blade.color_blur = Color(0,255,0)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core = Material( "lscs/effects/lightsaber_coreblack")
blade.material_trail = Material( "lscs/effects/lightsaber_trailblack" ) -- what material to use for the trail
blade.material_core_tip = Material( "lscs/effects/lightsaber_tipblack" )
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "Purple Dark Inner" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "purpleinner" -- internal ID. Always lower case.
blade.color_blur = Color(150,0,255)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core = Material( "lscs/effects/lightsaber_coreblack")
blade.material_trail = Material( "lscs/effects/lightsaber_trailblack" ) -- what material to use for the trail
blade.material_core_tip = Material( "lscs/effects/lightsaber_tipblack" )
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "Yellow Dark Inner" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "yellowinner" -- internal ID. Always lower case.
blade.color_blur = Color(255,255,0)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core = Material( "lscs/effects/lightsaber_coreblack")
blade.material_trail = Material( "lscs/effects/lightsaber_trailblack" ) -- what material to use for the trail
blade.material_core_tip = Material( "lscs/effects/lightsaber_tipblack" )
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "Orange Dark Inner" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "orangeinner" -- internal ID. Always lower case.
blade.color_blur = Color(255,162,0)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core = Material( "lscs/effects/lightsaber_coreblack")
blade.material_trail = Material( "lscs/effects/lightsaber_trailblack" ) -- what material to use for the trail
blade.material_core_tip = Material( "lscs/effects/lightsaber_tipblack" )
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "Cyan Dark Inner" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "cyaninner" -- internal ID. Always lower case.
blade.color_blur = Color(0,255,230)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core = Material( "lscs/effects/lightsaber_coreblack")
blade.material_trail = Material( "lscs/effects/lightsaber_trailblack" ) -- what material to use for the trail
blade.material_core_tip = Material( "lscs/effects/lightsaber_tipblack" )
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "Pink Dark Inner" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "pinkinner" -- internal ID. Always lower case.
blade.color_blur = Color(255,0,247)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core = Material( "lscs/effects/lightsaber_coreblack")
blade.material_trail = Material( "lscs/effects/lightsaber_trailblack" ) -- what material to use for the trail
blade.material_core_tip = Material( "lscs/effects/lightsaber_tipblack" )
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "White Dark Inner" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "whiteinner" -- internal ID. Always lower case.
blade.color_blur = Color(255,255,255)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core = Material( "lscs/effects/lightsaber_coreblack")
blade.material_trail = Material( "lscs/effects/lightsaber_trailblack" ) -- what material to use for the trail
blade.material_core_tip = Material( "lscs/effects/lightsaber_tipblack" )
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "Pike Crystal" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "pike" -- internal ID. Always lower case.
blade.color_blur = Color(255,0,0)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 25 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core_tip = Material( "lscs/effects/lightsaber_tip" ) -- material of the inner cores blade-tip
blade.material_glow = Material( "lscs/effects/lightsaber_glow" ) -- glow sprite effect
blade.material_trail = Material( "lscs/effects/lightsaber_trail" ) -- what material to use for the trail
blade.dynamic_light = true -- show dynamic light?
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

local blade = {}
blade.PrintName = "Sith Crystal" -- nice name in the menu
blade.Author = "RareLogan"
blade.id = "sith" -- internal ID. Always lower case.
blade.color_blur = Color(255,0,0)
blade.color_core = Color(255,255,255)
--blade.mdl = "models/lscs/weapons/nanosword_bladefx.mdl" -- use a model as blade?
--blade.mdl_poseparameter = "blade_retract" -- pose parameter to retract the blade. Should go from 0-1
blade.length = 45 -- blade length
blade.width = 0.6 -- width
blade.widthWiggle = 0.6 -- how much "noise" the blade has idling
blade.material_core_tip = Material( "lscs/effects/lightsaber_tip" ) -- material of the inner cores blade-tip
blade.material_glow = Material( "lscs/effects/lightsaber_glow" ) -- glow sprite effect
blade.material_trail = Material( "lscs/effects/lightsaber_trail" ) -- what material to use for the trail
blade.dynamic_light = true -- show dynamic light?
blade.no_trail = false -- disable trail?
blade.sounds = {
	Attack = "saber_hup", -- called then the combo file calls SWEP:DoAttackSound() or SWEP:DoAttackSound(nil, NUMBER_HAND) where NUMBER_HAND being SWEP.HAND_LEFT or SWEP.HAND_RIGHT or nil for both sabers
	Attack1 = "saber_spin1", -- SWEP:DoAttackSound( 1, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack2 = "saber_spin2", -- SWEP:DoAttackSound( 2, NUMBER_HAND) for NUMBER_HAND see comment above
	Attack3 = "saber_spin3", -- SWEP:DoAttackSound( 3, NUMBER_HAND) for NUMBER_HAND see comment above
	Activate = "saber_turnon",
	Disable = "saber_turnoff",
	Idle =  "lscs/saber/saberhum4.wav",
}
LSCS:RegisterBlade( blade ) -- register it to the system. This will also register a new entity

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
