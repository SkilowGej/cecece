DEFAULT_VOICE_DISTANCE = 0x57E40 -- 360000 ( 600^2 )
RESPAWN_TIME = 25
CHAT_DISTANCE = 300

-- NOFALLDAMAGE = {
-- 	[TEAM_JEDI] = true,
-- 	[TEAM_OVERWATCH] = true
-- }
GUM_ROOMS = {"Cytadela", "Sala treningowa nr 1", "Tren. Centrum"}

ROLE_MULTIPLIERS = {
	["founder"] = {
		money = 4,
		xp = 4
	},
	["moderator"] = {
		money = 4,
		xp = 4
	},
	["serverstaff"] = {
		money = 2,
		xp = 2
	},
	["admin"] = {
		money = 2,
		xp = 2
	},
	["superadmin"] = {
		money = 4,
		xp = 4
	},
	["standart"] = {
		money = 1.25,
		xp = 1.25
	},
 	["standart+"] = {
		money = 1.5,
		xp = 1.5
	},
 	["aurum"] = {
		money = 2,
		xp = 2
	},
 	["premium"] = {
		money = 2.25,
		xp = 2.25
	},
 	["Supreme"] = {
		money = 3,
		xp = 3
	},
}

GROUP_ICONS = {
	["user"] = {
		material = Material("celestia/fa/128/solid/user.png", "noclamp smooth"),
		col = Color(255, 255, 255, 255),
		chat_prefix = nil,
		symbol = "Gracz"
	},
	["junior"] = {
		material = Material("celestia/fa/128/solid/star-sharp.png", "noclamp smooth"),
		col = Color(139, 139, 139, 255),
		chat_prefix = true,
		symbol = "Subskrypcja Junior"
	},
	["jedimaster"] = {
		material = Material("celestia/fa/128/solid/jedi.png", "noclamp smooth"),
		col = Color(139, 139, 139, 255),
		chat_prefix = true,
		symbol = "Mistrz Jedi"
	},
	["classic"] = {
		material = Material("celestia/fa/128/solid/star-sharp.png", "noclamp smooth"),
		col = Color(136, 66, 211, 255),
		chat_prefix = "Classic",
		symbol = "Subskrypcja Classic"
	},
	["argentum"] = {
		material = Material("celestia/fa/128/solid/star-sharp.png", "noclamp smooth"),
		col = Color(38, 101, 160, 255),
		chat_prefix = "Argentum",
		symbol = "Subskrypcja Argentum"
	},
	["aurum"] = {
		material = Material("celestia/fa/128/solid/star-sharp.png", "noclamp smooth"),
		col = Color(223, 175, 55, 255),
		chat_prefix = "Aurum",
		symbol = "Subskrypcja Aurum"
	},
	["supreme"] = {
		material = Material("celestia/fa/128/solid/star-sharp.png", "noclamp smooth"),
		col = Color(32, 95, 204, 255),
		chat_prefix = true,
		symbol = "Subskrypcja Supreme"
	},
	["commander"] = {
		material = Material("celestia/fa/128/solid/star-shooting.png", "noclamp smooth"),
		col = Color(255, 255, 255, 255),
		chat_prefix = true,
		symbol = "Komandor"
	},
	["jediorder"] = {
		material = Material("celestia/fa/128/solid/sword-laser.png", "noclamp smooth"),
		col = Color(255, 255, 255, 255),
		chat_prefix = true,
		symbol = "Zakon Jedi"
	},
	["moderator"] = {
		material = Material("celestia/fa/128/solid/user-pilot.png", "noclamp smooth"),
		col = Color(255, 255, 255, 255),
		chat_prefix = true,
		symbol = "Moderator"
	},
	["founder"] = {
		material = Material("celestia/fa/128/solid/wrench.png", "noclamp smooth"),
		col = Color(255, 255, 255, 255),
		chat_prefix = true,
		symbol = "Założyciel"
	},
	["serverstaff"] = {
		material = Material("celestia/fa/128/solid/briefcase-blank.png", "noclamp smooth"),
		col = Color(255, 255, 255, 255),
		chat_prefix = true,
		symbol = "Zespół Serwera"
	},
	["admin"] = {
		material = Material("celestia/fa/128/solid/user-pilot.png", "noclamp smooth"),
		col = Color(255, 255, 255, 255),
		chat_prefix = true,
		symbol = "Administrator"
	},
	["superadmin"] = {
		material = Material("celestia/fa/128/solid/user-pilot-tie.png", "noclamp smooth"),
		col = Color(255, 255, 255, 255),
		chat_prefix = true,
		symbol = "Główny Administrator"
	}
}

-- Ранги которые могут использовать режим вещания
WALKIE_TALKIE_GROUP_RATINGS = {
	["LT"] = true,
	-- ["SLT"] = true,
	["HLT"] = true,
	["CPT"] = true,
	["MJR"] = true,
	["LTC"] = true,
	["COL"] = true,
	["CC"] = true,
	["SCC"] = true,
	["MC"] = true,
	["G.ADJ"] = true,
	["Moff"] = true,
	["Admin-Pracowity"] = true,
	["ENS"] = true,
	["LT"] = true,
	["OLT"] = true,
	["LDR"] = true,
	["CDR"] = true,
	["LCP"] = true,
	["CAP"] = true,
	["COM"] = true,
	["RAD"] = true,
	["VAD"] = true,
	["ADM"] = true,
	["GADM"] = true
}

-- Ранги которые могут бронировать залы
GUM_RATING_EDITORS = {
	["Zakon Jedi"] = true,
	["Admin-Pracowity"] = true,
	["PFC"] = true,
	["SPC"] = true,
	["CPL"] = true,
	["MSG"] = true,
	["SGT"] = true,
	["SSG"] = true,
	["SFC"] = true,
	["SGM"] = true,
	["CSM"] = true,
	["JLT"] = true,
	["LT"] = true,
	["1LT"] = true,
	["HLT"] = true,
	["CPT"] = true,
	["MJR"] = true,
	["LTC"] = true,
	["COL"] = true,
	["CC"] = true,
	["SCC"] = true,
	["MC"] = true,
	["DIR"] = true,
	["REC"] = true,
	["CRW"] = true,
	["CRF"] = true,
	["NSP"] = true,
	["MSM"] = true,
	["PO3"] = true,
	["PO2"] = true,
	["PO1"] = true,
	["POM"] = true,
	["ENS"] = true,
	["LT"] = true,
	["OLT"] = true,
	["LDR"] = true,
	["CDR"] = true,
	["LCP"] = true,
	["CAP"] = true,
	["COM"] = true,
	["RAD"] = true,
	["VAD"] = true,
	["ADM"] = true,
	["GADM"] = true
}

GROUP_TOOLS = {"gmod_tool", "weapon_physgun"}

GROUPS_HAS_TOOLS = {
	["founder"] = true,
	["moderator"] = true,
	["serverstaff"] = true
}

-- лусанкии ебал рот
CONTROLPOINT_ICONS = {
	["Ikona #1"] = Material("luna_icons/chess-pawn.png", "smooth noclamp"),
	["Ikona #2"] = Material("luna_icons/chess-rook.png", "smooth noclamp"),
	["Ikona #3"] = Material("luna_icons/chess-queen.png", "smooth noclamp"),
	["Ikona #4"] = Material("luna_icons/chess-knight.png", "smooth noclamp"),
	["Ikona #5"] = Material("luna_icons/chess-king.png", "smooth noclamp"),
	["Ikona #6"] = Material("luna_icons/black-flag.png", "smooth noclamp"),
	["Ikona #7"] = Material("luna_icons/swords-emblem.png", "smooth noclamp"),
}

HELPPOINTS_TYPES = {
	-- ["Внимание"] = {
	-- 	color = Color(51, 153, 255, 0),
	-- 	icon = Material("celestia/cwrp/markers/icn_player.vmt"),
	-- 	sound = "celestia/cwrp/markers/icn_player.vmt"
	-- },
	-- ["Проверить"] = {
	-- 	color = Color(51, 153, 255, 0),
	-- 	icon = Material("celestia/cwrp/markers/icn_player_dead.vmt"),
	-- 	sound = "luna_sound_effects/info/infoobnovleno.mp3"
	-- },
	-- ["Враг"] = {
	-- 	color = Color(51, 153, 255, 0),
	-- 	icon = Material("celestia/cwrp/markers/icon_intel.vmt"),
	-- 	sound = "luna_sound_effects/info/infoobnovleno.mp3"
	-- },
	-- ["Атаковать"] = {
	-- 	color = Color(51, 153, 255, 0),
	-- 	icon = Material("celestia/cwrp/markers/icon_intel_enemy.vmt"),
	-- 	sound = "luna_sound_effects/info/infoobnovleno.mp3"
	-- },
	-- ["Оборонять"] = {
	-- 	color = Color(51, 153, 255, 0),
	-- 	icon = Material("celestia/cwrp/markers/icon_intel_friendly.vmt"),
	-- 	sound = "luna_sound_effects/info/infoobnovleno.mp3"
	-- },
	-- ["Оборонять"] = {
	-- 	color = Color(51, 153, 255, 0),
	-- 	icon = Material("celestia/cwrp/markers/obj_attack.vmt"),
	-- 	sound = "luna_sound_effects/info/infoobnovleno.mp3"
	-- },
	["Ikona Droidów"] = {
		color = Color(214, 45, 32),
		icon = Material("luna_icons/rw_sw_droideka.png"),
		sound = ""
	},
	["Ikona Serca"] = {
		color = Color(214, 45, 32),
		icon = Material("luna_ui_base/etc/resurrect.png"),
		sound = "luna_sound_effects/med_call/call_01.wav"
	}
}

CONTROL_REPUBLIC = 1
CONTROL_CIS = 2
CONTROL_CITIZEN = 3

CONTROLPOINT_TEAMS = {
	[0] = {
		color = Color(191, 191, 191, 255),
		name = "Neutralność",
		body = 2,
		icon = Material("luna_ui_base/elements/icon_stripes.png", "smooth noclamp")
	},
	[CONTROL_REPUBLIC] = {
		color = Color(84, 144, 181, 255),
		name = "Republika",
		body = 0,
		icon = Material("luna_ui_base/elements/republic.png", "smooth noclamp")
	},
	[CONTROL_CIS] = {
		color = Color(255, 37, 37, 255),
		name = "Separatyści",
		body = 1,
		icon = Material("luna_ui_base/elements/cis.png", "smooth noclamp")
	},
	[CONTROL_CITIZEN] = {
		color = Color(255, 165, 0, 255),
		name = "Mieszkańcy",
		body = 2,
		icon = Material("luna_ui_base/elements/luna-ui_circle.png", "smooth noclamp")
	}
}

-- Если time = 0, то анимация будет работать когда игрок не сдвитется.
SUP_ANIMATIONS = {
	-- ["tlc_animation_chest"] = {
	-- 	icon = Material("luna_menus/hud/emotes/title_64.png", "smooth noclamp"),
	-- 	text = "Стойка",
	-- 	time = 10
	-- },
	-- ["tlc_animation_otjim"] = {
	-- 	icon = Material("luna_menus/hud/emotes/title_64.png", "smooth noclamp"),
	-- 	text = "Отжимание",
	-- 	time = 10
	-- },
	-- ["tlc_animation_prised"] = {
	-- 	icon = Material("luna_menus/hud/emotes/title_64.png", "smooth noclamp"),
	-- 	text = "Приседание",
	-- 	time = 10
	-- },
	-- ["tlc_animation_sdatsya"] = {
	-- 	icon = Material("luna_menus/hud/emotes/title_64.png", "smooth noclamp"),
	-- 	text = "Сдаться",
	-- 	time = 10
	-- },
	-- -- ["tlc_animation_hotbizarabotalo"] = { text = "", time = 2 },
	-- ["tlc_animation_stoika"] = {
	-- 	icon = Material("luna_menus/hud/emotes/title_64.png", "smooth noclamp"),
	-- 	text = "Стойка",
	-- 	time = 10
	-- },
	-- -- ["tlc_handandhok"] = { text = "", time = 2 }, -- ["tlc_handofbackhead"] = { text = "", time = 2 }, -- ["tlc_long"] = { text = "", time = 2 },
	-- ["tlc_weak"] = {
	-- 	icon = Material("luna_menus/hud/emotes/title_64.png", "smooth noclamp"),
	-- 	text = "Слабость",
	-- 	time = 2
	-- },
	-- ["tlc_cleenerarms"] = {
	-- 	icon = Material("luna_menus/hud/emotes/title_64.png", "smooth noclamp"),
	-- 	text = "Отряхнуть Руки",
	-- 	time = 2
	-- },
	-- ["tlc_die"] = {
	-- 	icon = Material("luna_menus/hud/emotes/title_64.png", "smooth noclamp"),
	-- 	text = "Перерезать горло",
	-- 	time = 2
	-- },
	-- -- ["tlc_lightly_wounded"] = { text = "", time = 2 },
	-- ["tlc_pafos"] = {
	-- 	icon = Material("luna_menus/hud/emotes/title_64.png", "smooth noclamp"),
	-- 	text = "Пафос",
	-- 	time = 0
	-- },
	-- ["tlc_stop_it_left"] = {
	-- 	icon = Material("luna_menus/hud/emotes/title_64.png", "smooth noclamp"),
	-- 	text = "Остановить",
	-- 	time = 0
	-- },
	-- -- ["pose_ducking01"] = { text = "Присесть 01", time = 5 }, -- ["pose_ducking02"] = { text = "Присесть 02", time = 5 }, -- ["pose_standing01"] = { text = "Стойка 01", time = 5 }, -- ["pose_standing02"] = { text = "Стойка 02", time = 5 }, -- ["pose_standing03"] = { text = "Стойка 03", time = 5 }, -- ["pose_standing04"] = { text = "Стойка 04", time = 5 },
	-- ["wos_genji_dance"] = {
	-- 	icon = Material("luna_menus/hud/emotes/title_64.png", "smooth noclamp"),
	-- 	text = "Танец Гендзи",
	-- 	time = 10
	-- },

	["idle_all_angry"] = {
		icon = Material("luna_menus/hud/emotes/title_64.png", "smooth noclamp"),
		text = "Zła Postawa",
		time = 0
	},
	["cheer"] = {
		icon = Material("luna_menus/hud/emotes/cheer_64.png", "smooth noclamp"),
		taunt = ACT_GMOD_TAUNT_CHEER,
		text = "Radość"
	},
	["laugh"] = {
		icon = Material("luna_menus/hud/emotes/laugh_64.png", "smooth noclamp"),
		taunt = ACT_GMOD_TAUNT_LAUGH,
		text = "Śmiech"
	},
	["muscle"] = {
		icon = Material("luna_menus/hud/emotes/sexy_64.png", "smooth noclamp"),
		taunt = ACT_GMOD_TAUNT_MUSCLE,
		text = "Mięśnie"
	},
	["zombie"] = {
		icon = Material("luna_menus/hud/emotes/zombie_64.png", "smooth noclamp"),
		taunt = ACT_GMOD_GESTURE_RANGE_ZOMBIE,
		text = "Zombie"
	},
	["robot"] = {
		icon = Material("luna_menus/hud/emotes/robot_64.png", "smooth noclamp"),
		taunt = ACT_GMOD_TAUNT_ROBOT,
		text = "Robot"
	},
	["dance"] = {
		icon = Material("luna_menus/hud/emotes/dance_64.png", "smooth noclamp"),
		taunt = ACT_GMOD_TAUNT_DANCE,
		text = "Taniec"
	},
	["agree"] = {
		icon = Material("luna_menus/hud/emotes/agree_64.png", "smooth noclamp"),
		taunt = ACT_GMOD_GESTURE_AGREE,
		text = "Zgoda"
	},
	["becon"] = {
		icon = Material("luna_menus/hud/emotes/becon_64.png", "smooth noclamp"),
		taunt = ACT_GMOD_GESTURE_BECON,
		text = "Zawołać"
	},
	["disagree"] = {
		icon = Material("luna_menus/hud/emotes/disagree_64.png", "smooth noclamp"),
		taunt = ACT_GMOD_GESTURE_DISAGREE,
		text = "Nie zgoda"
	},
	["salute"] = {
		icon = Material("luna_menus/hud/emotes/salute_64.png", "smooth noclamp"),
		taunt = ACT_GMOD_TAUNT_SALUTE,
		text = "Salut"
	},
	["wave"] = {
		icon = Material("luna_menus/hud/emotes/wave_64.png", "smooth noclamp"),
		taunt = ACT_GMOD_GESTURE_WAVE,
		text = "Powitanie"
	},
	["forward"] = {
		icon = Material("luna_menus/hud/emotes/forward_64.png", "smooth noclamp"),
		taunt = ACT_SIGNAL_FORWARD,
		text = "Naprzód"
	},
	["pers"] = {
		icon = Material("luna_menus/hud/emotes/flamingo_64.png", "smooth noclamp"),
		taunt = ACT_GMOD_TAUNT_PERSISTENCE,
		text = "Napędzać"
	},
	["bow"] = {
		icon = Material("luna_menus/hud/emotes/bow_64.png", "smooth noclamp"),
		taunt = ACT_GMOD_GESTURE_BOW,
		text = "Ukłon"
	},
	["group"] = {
		icon = Material("luna_menus/hud/emotes/group_64.png", "smooth noclamp"),
		taunt = ACT_SIGNAL_GROUP,
		text = "Grupa"
	},
	["halt"] = {
		icon = Material("luna_menus/hud/emotes/halt_64.png", "smooth noclamp"),
		taunt = ACT_SIGNAL_HALT,
		text = "Stać"
	},
}

-- ["halt"] = { text = "Остановка" }
HANDCUFFED_DURATION = 0.5
UN_HANDCUFFED_DURATION = 1

F4_CREATECHAR = {
	['primary'] = {
		name = 'Podstawowa Broń',
		lerps = {
			dmg = 0,
			recoil = 0,
			rpm = 0,
		},
		weapons = {
			['masita_dc15s'] = Material('luna_menus/inventory/dc-15s.png'),
		}
	},
	['secondary'] = {
		name = 'Dodatkowa Broń',
		lerps = {
			dmg = 0,
			recoil = 0,
			rpm = 0,
		},
		weapons = {
			['masita_dc17'] = Material('luna_menus/inventory/dc-17.png'),
		}
	},
	['exclusive'] = {
		name = 'Broń Biała',
		lerps = {
			dmg = 0,
			recoil = 0,
			rpm = 0,
		},
		weapons = {
			['vibrokinfe_base'] = Material('luna_menus/inventory/fist.png'),
		}
	},
	['veryexclusive'] = {
		name = 'Specjalna Broń',
		lerps = {
			dmg = 0,
			recoil = 0,
			rpm = 0,
		},
		weapons = {
			['weapon_med_bandage'] = Material('luna_menus/inventory/med-pack.png'),
		}
	}
}

--[[
	Notifications
]]
NOTIFY_TYPES = {
	["yellow"] = Color(221, 174, 100),
	["red"] = Color(183, 81, 52),
	["blue"] = Color(123, 168, 196),
	["green"] = Color(140, 160, 93),
	["purple"] = Color(176, 100, 149),
	["cyan"] = Color(136, 219, 216),
}

NOTIFY_DATE_FORMAT = "%H:%M"

timer.Simple(0, function()
	DEFAULT_PLAYER_STATS = {
		["RunSpeed"] = 225,
		["WalkSpeed"] = 95,
		["JumpPower"] = 180
	}
end)

TYPE_CLONE = 1
TYPE_DROID = 3
TYPE_MERCENARY = 4
TYPE_ROOKIE = 5
TYPE_CITIZEN = 6
TYPE_RPDROID = 7
TYPE_ADMIN = 8
TYPE_JEDI = 9
TYPE_FLEET = 10

-- Ранги которые выдаются при создании нового персонажа по типу.
DEFAULT_RATINGS = {
	[TYPE_CLONE] = "RCT",
	[TYPE_RPDROID] = "Astromech",
	[TYPE_DROID] = "CIS",
	[TYPE_MERCENARY] = "Miejscowy",
	[TYPE_ROOKIE] = "CDT",
	[TYPE_CITIZEN] = "",
	[TYPE_JEDI] = "Zakon Jedi",
	[TYPE_ADMIN] = "Admin-Pracownik",
	[TYPE_FLEET] = "PVT",
}

NORMAL_TYPES = {
	[TYPE_CLONE] = 'Republika',
	[TYPE_RPDROID] = 'Droidy',
	[TYPE_DROID] = 'Separatyści',
	[TYPE_MERCENARY] = 'Miejscowy',
	[TYPE_ROOKIE] = 'Kadet, przekwalifikowanie',
	[TYPE_CITIZEN] = 'Obywatele',
	[TYPE_JEDI] = 'Zakon Jedi',
	[TYPE_ADMIN] = 'Admin-Pracownik',
	[TYPE_FLEET] = 'Flota',
}

-- Ранги по типу: 
ALIVE_RATINGS = {
	[TYPE_CLONE] = {
		[1] = "RCT",
		[2] = "PVT",
		[3] = "PSC",
		[4] = "PFC",
		[5] = "SPC",
		[6] = "CPL",
		[7] = "MSG",
		[8] = "SGT",
		[9] = "SSG",
		[10] = "SFC",
		[11] = "SGM",
		[12] = "CSM",
		[13] = "JLT",
		[14] = "LT",
		[15] = "1LT",
		[16] = "HLT",
		[17] = "CPT",
		[18] = "MJR",
		[19] = "LTC",
		[20] = "COL",
		[21] = "CC",
		[22] = "SCC",
		[23] = "MC",
		[24] = "DIR",

	},
	[TYPE_FLEET] = {
		[1] = "REC",
		[2] = "CRW",
		[3] = "CRF",
		[4] = "NSP",
		[5] = "MSM",
		[6] = "PO3",
		[7] = "PO2",
		[8] = "PO1",
		[9] = "POM",
		[10] = "ENS",
		[11] = "LT",
		[12] = "OLT",
		[13] = "LDR",
		[14] = "CDR",
		[15] = "LCP",
		[16] = "CAP",
		[17] = "COM",
		[18] = "RAD",
		[19] = "VAD",
		[20] = "ADM",
		[21] = "GADM"
	},
	[TYPE_RPDROID] = {
		[1] = "Astromech",
	},
	[TYPE_DROID] = {
		[1] = "CIS",
	},
	[TYPE_JEDI] = {
		[1] = "Zakon Jedi",
	},
	[TYPE_ADMIN] = {
		[1] = "Admin-Pracownik",
	},
	[TYPE_MERCENARY] = {
		[1] = "Miejscowy",
		[2] = "Bywały",
		[3] = "Mądry",
		[4] = "Zaawansowany",
		[5] = "Szanowany",
		[6] = "Profesjonalny",
		[7] = "Szef",
		[8] = "Autorytet",
		[9] = "Han",
	},
	[TYPE_ROOKIE] = {
		[1] = "CDT",
	},
	[TYPE_CITIZEN] = {
		[1] = "",
	},
}

-- HIDE_NICKS_RATINGS = { -- Ранги при которых скрывается rpid (не работает)
-- 	-- ["Cadet"] = true,
-- 	["Переобучение"] = true,
-- }
-- ["PVT"] = true,
-- ["PVT Первого Класса"] = true,
timer.Simple(1, function()
	LEGION_CMDS = {
		[TEAM_OVERWATCH] = {
			["cadet2"] = true, --юзелесс
			
		},
	}

	-- Профессии которыем может выбрать игрок при создании нового персонажа. Cadet обязателен!
	WHITELIST_GROUP_TEAMS = {
		["founder"] = {
			[TEAM_CADET] = true,
			--[TEAM_MANDALORIAN] = true,
			[TEAM_OVERWATCH] = true,
			[TEAM_SENATOR] = true,
			[TEAM_MERCENARY] = true,
			[TEAM_ASTROMECH] = true,
			[TEAM_CIS1] = true,
		},
		["superadmin"] = {
			[TEAM_CADET] = true,
			--[TEAM_MANDALORIAN] = true,
			[TEAM_OVERWATCH] = true,
			[TEAM_SENATOR] = true,
			[TEAM_MERCENARY] = true,
			[TEAM_ASTROMECH] = true,
			[TEAM_CIS1] = true,
		},
		["user"] = {
			[TEAM_CADET] = true,
		},
		["serverstaff"] = {
			[TEAM_CADET] = true,
			--[TEAM_MANDALORIAN] = true,
			[TEAM_OVERWATCH] = true,
			[TEAM_SENATOR] = true,
			[TEAM_MERCENARY] = true,
			[TEAM_ASTROMECH] = true,
			[TEAM_CIS1] = true,
		},
		["highstaff"] = {
			[TEAM_CADET] = true,
			--[TEAM_MANDALORIAN] = true,
			[TEAM_OVERWATCH] = true,
			[TEAM_SENATOR] = true,
			[TEAM_MERCENARY] = true,
			[TEAM_ASTROMECH] = true,
			[TEAM_CIS1] = true,
		},
		["moderator"] = {
			[TEAM_CADET] = true,
			--[TEAM_MANDALORIAN] = true,
			[TEAM_OVERWATCH] = true,
			[TEAM_SENATOR] = true,
			[TEAM_MERCENARY] = true,
			[TEAM_ASTROMECH] = true,
			[TEAM_CIS1] = true,
		},
		["Supreme"] = {
			[TEAM_ARF2] = true,
			[TEAM_ASTROMECH] = true,
			[TEAM_MERCENARY] = true,
            [TEAM_ARCspec] = true,
			[TEAM_CADET] = true,
			[TEAM_COMMANDO] = true,
			[TEAM_CADET] = true,
		},
		["commander"] = {
			[TEAM_ARF2] = true,
			[TEAM_ASTROMECH] = true,
			[TEAM_MERCENARY] = true,
            [TEAM_ARCspec] = true,
			[TEAM_CADET] = true,
			[TEAM_COMMANDO] = true,
			[TEAM_CADET] = true,
                
		},
		["premium"] = {
			[TEAM_ARF2] = true,
			[TEAM_ASTROMECH] = true,
			[TEAM_MERCENARY] = true,
            [TEAM_ARCspec] = true,
			[TEAM_CADET] = true,
		},
		["aurum"] = {
			[TEAM_ARF2] = true,
			[TEAM_ASTROMECH] = true,
			[TEAM_MERCENARY] = true,
			[TEAM_CADET] = true,
		},
		["standart+"] = {
			[TEAM_ARF2] = true,
			[TEAM_ASTROMECH] = true,
			[TEAM_CADET] = true,
		},
		["standart"] = {
			[TEAM_ARF2] = true,
			[TEAM_CADET] = true,
		},
	}

	TEAMS_CANUSE_DEFCONS = {
		[TEAM_OVERWATCH] = true,
		[TEAM_LORECOMMANDER] = true,
		[TEAM_8] = true
	}

	-- Командиры которые могут выставлять кординаты порталов.
	SPAWNPORTALS_COMMANDERS = {
		[TEAM_OVERWATCH] = true,
	}
end)

VEHICLES_SPAWNPOINT = {
	[1] = Vector("4865.538574 -9112.921875 -14911.714844"),
	[2] = Vector("7089.4633789062 -9179.4189453125 -14975.967773438"),
	[3] = Vector("9204.130859375 -9206.2333984375 -14975.967773438"),
	[4] = Vector("6208.142578 -2977.364014 -15146.036133"),
	[5] = Vector("5493.609863 -2979.799561 -15145.547852"),
	[6] = Vector("5708.060059 -1868.606079 -15119.424805")
}

-- Админы которым доступен все профессии.
WHITELIST_ADMINS = {
	["founder"] = true,
	["serverstaff"] = true,
	["highstaff"] = true,
	["jediorder"] = true,
	["jedimaster"] = true,
	["commander"] = true,
	["moderator"] = true,
	["admin"] = true,
	["superadmin"] = true,
}

-- WHITELIST_ADMINS = {
-- 	["coordinator"] = true,
-- 	["admin"] = true,
-- 	["totalcommander"] = true,
-- 	["commander"] = true,
-- 	["deputycommander"] = true,
-- 	["founder"] = true,
-- 	["intelligence_service"] = true,
-- 	["topmanagment"] = true,
-- 	["managment"] = true,
-- }
-- Максимальное количество пресонажей которое может создать игрок.
GROUPS_RELATION = {
	["user"] = 2,
	["standart"] = 2,
	["standart+"] = 2,
	["aurum"] = 3,
    ["commander"] = 3,
	["premium"] = 3,
	["Supreme"] = 4,
	["serverstaff"] = 4,
	["superadmin"] = 4,
	["jediorder"] = 3,
    ["founder"] = 4,
    ["highstaff"] = 3,
}

VEHICLES_FEATURES = {
	["air"] = {
		["lvs_nuclass_attack_shuttle"] = {
			model = "models/swbf3/vehicles/nu_attackship.mdl",
			price = 100,
			gmapPrice = 70,
			name = "Szturmowy prom typu „NU”",
			icon = Material("luna_icons/heavy-fighter.png")
		},
		-- Если price = 0, то техника доступна в любом случае.
		["lvs_space_laat"] = {
			model = "models/fisher/laat/laatspace.mdl",
			price = 0,
			gmapPrice = 30,
			name = "Kanonierka LAAT",
			icon = Material("luna_icons/plane-wing.png")
		},
		-- Если price = 0, то техника доступна в любом случае.
		["lvs_space_laat_arc"] = {
			model = "models/fisher/laat/laatspace.mdl",
			price = 0,
			gmapPrice = 30,
			name = "Kanonierka LAAT (Kosmos)",
			icon = Material("luna_icons/plane-wing.png")
		},
		-- Если price = 0, то техника доступна в любом случае.
		["lvs_starfighter_arc170"] = {
			model = "models/blu/arc170.mdl",
			price = 0,
			gmapPrice = 20,
			name = "Myśliwiec zwiadowczy-170",
			icon = Material("luna_icons/heavy-fighter.png")
		},
		-- Если price = 0, то техника доступна в любом случае. -- ["lunasflightschool_vwing"] = { -- Если price = 0, то техника доступна в любом случае. --     model = "models/blu/vwing.mdl", --     price = 0, --     name = "Истребитель V-Wing", --     icon = Material("luna_ui_base/elements/falcon.png") -- },
		["lvs_starfighter_vwing"] = {
			model = "models/diggerthings/vwing/5.mdl",
			price = 0,
			gmapPrice = 15,
			name = "«V-wing» Alfa-3 - „Nimbus”",
			icon = Material("luna_icons/plane-wing.png")
		},
		["lvs_starfighter_ywing"] = {
			model = "models/ywing/BTL-B_Y-Wing.mdl",
			price = 0,
			gmapPrice = 45,
			name = "Bombowiec BTL «Y-wing»",
			icon = Material("luna_icons/plane-wing.png")
		},
       	["lvs_v19"] = {
			model = "models/diggerthings/v19/4.mdl",
			price = 0,
			gmapPrice = 10,
			name = "Myśliwiec «V-19»",
			icon = Material("luna_icons/plane-wing.png")
		},
        ["lvs_repulsorlift_dropship"] = {
			model = "models/blu/laat_c.mdl",
			price = 0,
			gmapPrice = 35,
			name = "Lekki transportowiec „LAAT/C”",
			icon = Material("luna_icons/plane-wing.png")
		},
	},
	-- Если price = 0, то техника доступна в любом случае. -- Если price = 0, то техника доступна в любом случае.
	["land"] = {
		["lunasflightschool_niksacokica_tx-427"] = {
			model = "models/lfs_vehicles/tx427/tx427.mdl",
			price = 0,
			gmapPrice = 50,
			name = "TX-427 Czołg Eksperymentalnej Klasy",
			icon = Material("luna_icons/tank-tread.png")
		},
		["lvs_fakehover_barc"] = {
			model = "models/barc/barc.mdl",
			price = 0,
			gmapPrice = 5,
			name = "BARC Speeder",
			icon = Material("luna_icons/tank-tread.png")
		},
		["lvs_fakehover_iftx"] = {
			model = "models/blu/iftx.mdl",
			price = 0,
			gmapPrice = 25,
			name = "Platforma Wsparcia Piechoty «IFT-X»",
			icon = Material("luna_icons/tank-tread.png")
		},
		["lvs_walker_atte"] = {
			model = "models/starwarsbattlefrontii/vehicles/at-te.mdl",
			price = 0,
			gmapPrice = 50,
			name = "Wielozadaniowy pojazd kroczący «AT-TE»",
			icon = Material("luna_icons/tank-tread.png")
		},
        ["lvs_walker_atap"] = {
			model = "models/sw/atot_veh/at-ap.mdl",
			price = 0,
			gmapPrice = 35,
			name = "Szturmowy kroczący pojazd «AT-AP»",
			icon = Material("luna_icons/tank-tread.png")
		},
		["tx210ist"] = {
			model = "models/eoj/lfs_vehicles/tx210ist.mdl",
			price = 0,
			gmapPrice = 45,
			name = "TX-210 «Zdobywca»",
			icon = Material("luna_icons/tank-tread.png")
		},
		-- ["lvs_walker_atap"] = {
		-- 	model = "models/sw/atot_veh/at-ap.mdl",
		-- 	price = 0,
		-- 	gmapPrice = 10,
		-- 	name = "Штурмовой Шагоход AT-AP",
		-- 	icon = Material("luna_icons/tank-tread.png")
		-- },
        -- ["lvs_atrt"] = {
		-- 	model = "models/kingpommes/starwars/atrt/main.mdl",
		-- 	price = 0,
		-- 	gmapPrice = 10,
		-- 	name = "Разведывательный шагоход AT-RT",
		-- 	icon = Material("luna_icons/tank-tread.png")
		-- },
        ["turbotank"] = {
			model = "models/vehicles/sky/turbotank/turbotank_s.mdl",
			price = 0,
			gmapPrice = 85,
			name = "Turbotank Juggernout",
			icon = Material("luna_icons/tank-tread.png")
		},
	},
}

SPAWNPORTALS_VECTORS = {
	["Lusankia"] = Vector("-5554.279785 -8061.700195 5695.418457"),
	["Force Plains"] = Vector("-7701.724609 -10130.999023 -1467.141479"),
}

DEFAULT_MONEY = 5000

VEHICLES_TYPES = {
	["air"] = {
		["arc170v2"] = true,
	},
	["land"] = {
		["pommes_atrt"] = true,
	},
}

DEFCON_TYPES = {
	["0"] = {
		text = "D0 - Aktywna faza zbierania się na platformach startowych przed wysłaniem na misję bojową / ratunkową / humanitarną.",
		sound = "luna_sound_effects/defcon/defcon0.wav"
	},
	["1"] = {
		text = "D1 - Ogłoszona natychmiastowa ewakuacja żołnierzy! Wszyscy natychmiast wracają na punkty zrzutu",
		sound = "luna_sound_effects/defcon/defcon1inbase.wav"
	},
	["2"] = {
		text = "D2 - Priorytetowe miejsca obrony podczas ataku: Reaktor, Blok Medyczny i Sztab Dowodzenia",
		sound = "luna_sound_effects/defcon/defcon2.wav"
	},
	["3"] = {
		text = "D3 - Oczekiwanie na atak, przydzielanie żołnierzy do stanowisk bojowych. Wszyscy klony muszą zająć stanowiska i czekać na rozkazy",
		sound = "luna_sound_effects/defcon/defcon3.wav"
	},
	["4"] = {
		text = "D4 - Wszyscy natychmiast przystępują do patrolowania w grupach po 3 żołnierzy",
		sound = "luna_sound_effects/defcon/defcon4.wav"
	},
	["5"] = {
		text = "Alarm bojowy! Przygotować uzbrojenie oraz zająć stanowiska bojowe.",
		sound = "luna_sound_effects/defcon/defcon5.wav"
	},
	["6"] = {
		text = "D6 - Tryb stacjonarny",
		sound = "luna_sound_effects/defcon/defcon6.wav"
	},
	["FIX"] = {
		text = "DFIX - Batalion Inżynierii Technicznej przystępuje do naprawy systemów krytycznych",
		sound = "luna_sound_effects/defcon/defconfix.wav"
	},
	["MED"] = {
		text = "DMED - Wszyscy żołnierze natychmiast zgłaszają się na badanie lekarskie",
		sound = "luna_sound_effects/defcon/defconmed.wav"
	},
	["VIRUS"] = {
		text = "DT - Niebezpieczeństwo zakażenia wirusowego! Ogłoszona kwarantanna! Główne strefy kwarantanny - Sztab Dowodzenia / Izolatka / Blok Medyczny",
		sound = "luna_sound_effects/defcon/defconvirus.wav"
	},
}

function formatMoney(int)
	return string.Comma(int) .. "KR"
end

JAIL_VECTORS = {Vector("11163.666992 -1323.293823 -14900.271484"), Vector("11497.041992 -1323.001953 -14899.993164"), Vector("11845.401367 -1322.698242 -14899.656250"), Vector("11841.412109 -818.804199 -14899.660156"),}

DEFAULT_MAP = 'rp_arcanatura' // DEFAULT MAP 		GUSTMAN LOX

GALACTIC_MAP = {
	[1] = {
		name = 'Amalthanna',
		status = 1,
		desc = {
			info = 'Pustynna planeta ze starożytnymi ruinami, skrywająca tajemnice dawno zaginionej cywilizacji.',
			warinfo = ''
		},
		xPos = 300,
		yPos = 400,
		icon = Material( 'luna_menus/warfare/planets/26.png', 'smooth mips' ),
		team = 2,
		price = 100,
	},
	[2] = {
		name = 'Kastell',
		status = 1,
		desc = {
			info = 'Pustynna planeta, znana ze swoich cennych minerałów',
			warinfo = ''
		},
		xPos = 420,
		yPos = 280,
		icon = Material( 'luna_menus/warfare/planets/17.png', 'smooth mips' ),
		team = 2,
		price = 1000,
	},
	[3] = {
		name = 'Nessavan',
		status = 1,
		desc = {
			info = 'Leśista planeta, znana ze swoich leczniczych roślin i mądrych szamanów',
			warinfo = ''
		},
		xPos = 600,
		yPos = 300,
		icon = Material( 'luna_menus/warfare/planets/29.png', 'smooth mips' ),
		team = 2,
		price = 77,
	},
	[4] = {
		name = 'Amalthanna',
		status = 1,
		desc = {
			info = 'Industrialny świat z rozległymi fabrykami produkującymi droidy CIS',
			warinfo = ''
		},
		xPos = 580,
		yPos = 70,
		icon = Material( 'luna_menus/warfare/planets/12.png', 'smooth mips' ),
		team = 2
	},
	[5] = {
		name = 'Prime Tori',
		status = 1,
		desc = {
			info = 'Stolica planety, centrum galaktycznego handlu i polityki',
			warinfo = ''
		},
		xPos = 750,
		yPos = 90,
		icon = Material( 'luna_menus/warfare/planets/25.png', 'smooth mips' ),
		team = 2
	},
	[6] = {
		name = 'Vestrus',
		status = 1,
		desc = {
			info = 'Lodowy świat z podziemnymi miastami i rzadkimi kryształami',
			warinfo = ''
		},
		xPos = 1480,
		yPos = 470,
		icon = Material( 'luna_menus/warfare/planets/30.png', 'smooth mips' ),
		team = 2
	},
	[7] = {
		name = 'Lola-Sayu',
		status = 1,
		desc = {
			info = 'Planeta-twierdza, chroniona potężnymi tarczami energetycznymi',
			warinfo = ''
		},
		xPos = 940,
		yPos = 30,
		icon = Material( 'luna_menus/warfare/planets/16.png', 'smooth mips' ),
		team = 2
	},
	[8] = {
		name = 'Mehis III',
		status = 1,
		desc = {
			info = 'Świat wiecznej wiosny z kwitnącymi koloniami rolniczymi',
			warinfo = ''
		},
		xPos = 1150,
		yPos = 50,
		icon = Material( 'luna_menus/warfare/planets/14.png', 'smooth mips' ),
		team = 2
	},
	[9] = {
		name = 'Svoldal',
		status = 1,
		desc = {
			info = 'Planeta-archiwum, przechowująca starożytne holokrony i artefakty Jedi',
			warinfo = ''
		},
		xPos = 900,
		yPos = 220,
		icon = Material( 'luna_menus/warfare/planets/27.png', 'smooth mips' ),
		team = 2
	},
	[10] = {
		name = 'Arcanatura',
		status = 2,
		desc = {
			info = 'Świat-twierdza, sztab i centrum logistyczne armii sektorowej',
			warinfo = ''
		},
		xPos = 1250,
		yPos = 800,
		icon = Material( 'luna_menus/warfare/planets/20.png', 'smooth mips' ),
		team = 1
	},
	[11] = {
		name = 'Onderon',
		status = 1,
		desc = {
			info = 'Mnóstwo cennych minerałów, ale z powodu nadmiernej aktywności drapieżników mieszkańcy Onderonu woleli zajmować się handlem.',
			warinfo = ''
		},
		xPos = 1150,
		yPos = 220,
		icon = Material( 'luna_menus/warfare/planets/24.png', 'smooth mips' ),
		team = 2
	},
	[12] = {
		name = 'Alivala',
		status = 1,
		desc = {
			info = 'Świat kanionów i jaskiń, zamieszkany przez zręcznych rzemieślników',
			warinfo = ''
		},
		xPos = 1300,
		yPos = 370,
		icon = Material( 'luna_menus/warfare/planets/21.png', 'smooth mips' ),
		team = 2
	},
	[13] = {
		name = 'Akroros',
		status = 1,
		desc = {
			info = 'Planeta z pływającymi wyspami i rzadkimi latającymi stworzeniami',
			warinfo = ''
		},
		xPos = 1400,
		yPos = 150,
		icon = Material( 'luna_menus/warfare/planets/2.png', 'smooth mips' ),
		team = 2
	},
	[14] = {
		name = 'Mosmari',
		status = 1,
		desc = {
			info = 'Zasuszliwy świat, znany ze swoich niebezpiecznych wyścigów na podach',
			warinfo = ''
		},
		xPos = 1450,
		yPos = 330,
		icon = Material( 'luna_menus/warfare/planets/26.png', 'smooth mips' ),
		team = 2
	},
	[15] = {
		name = 'Ord-Pardron',
		status = 1,
		desc = {
			info = 'Ord-Pardron był bogaty minerałami i rudami naraz z niską grawitacją',
			warinfo = ''
		},
		xPos = 750,
		yPos = 300,
		icon = Material( 'luna_menus/warfare/planets/14.png', 'smooth mips' ),
		team = 2
	},
	[16] = {
		name = 'Anchisi',
		status = 1,
		desc = {
			info = 'Oceaniczny świat z podwodnymi miastami i cennymi zasobami',
			warinfo = ''
		},
		xPos = 330,
		yPos = 610,
		icon = Material( 'luna_menus/warfare/planets/7.png', 'smooth mips' ),
		team = 2
	},
	[17] = {
		name = 'Nexus-Ortai',
		status = 1,
		desc = {
			info = 'Planeta-kuźnia, specjalizująca się w produkcji statków kosmicznych',
			warinfo = ''
		},
		xPos = 570,
		yPos = 630,
		icon = Material( 'luna_menus/warfare/planets/13.png', 'smooth mips' ),
		team = 2
	},
	[18] = {
		name = 'Agrabos',
		status = 1,
		desc = {
			info = 'Świat rolniczy, zaopatrujący w żywność wiele sektorów galaktyki',
			warinfo = ''
		},
		xPos = 740,
		yPos = 500,
		icon = Material( 'luna_menus/warfare/planets/15.png', 'smooth mips' ),
		team = 2
	},
	[19] = {
		name = "Klak'dor VII",
		status = 1,
		desc = {
			info = 'Planeta-krepost z drewnianymi obronnymi sooruzheniyami',
			warinfo = ''
		},
		xPos = 760,
		yPos = 650,
		icon = Material( 'luna_menus/warfare/planets/25.png', 'smooth mips' ),
		team = 2
	},
	[20] = {
		name = 'Turlto',
		status = 1,
		desc = {
			info = 'Świat z unikalną grawitacją, przyciągający naukowców z całej galaktyki',
			warinfo = ''
		},
		xPos = 960,
		yPos = 540,
		icon = Material( 'luna_menus/warfare/planets/23.png', 'smooth mips' ),
		team = 2
	},
	[21] = {
		name = "Klak'dor VII",
		status = 1,
		desc = {
			info = 'Planeta-sanktuarium, miejsce pielgrzymek dla wyznawców Mocy',
			warinfo = ''
		},
		xPos = 770,
		yPos = 820,
		icon = Material( 'luna_menus/warfare/planets/1.png', 'smooth mips' ),
		team = 2
	},
	[22] = {
		name = 'Asturias',
		status = 1,
		desc = {
			info = 'Planeta, otoczona polem meteorytów, nie pozwalająca na utrzymanie floty na orbicie',
			warinfo = ''
		},
		xPos = 1000,
		yPos = 880,
		icon = Material( 'luna_menus/warfare/planets/21.png', 'smooth mips' ),
		team = 2
	},
	[23] = {
		name = '«Yufi-7»',
		status = 2,
		desc = {
			info = 'Centrum medyczne, wspierające rekonwalescencję żołnierzy WAR',
			warinfo = ''
		},
		xPos = 1400,
		yPos = 900,
		icon = Material( 'luna_menus/warfare/planets/8.png', 'smooth mips' ),
		team = 1
	},
	[24] = {
		name = 'Apotiri',
		status = 1,
		desc = {
			info = 'Świat z ogromnymi kanionami, gdzie odbywają się niebezpieczne wyścigi na speederach',
			warinfo = ''
		},
		xPos = 410,
		yPos = 870,
		icon = Material( 'luna_menus/warfare/planets/6.png', 'smooth mips' ),
		team = 2
	},
	[25] = {
		name = 'Elevbati',
		status = 1,
		desc = {
			info = 'Planeta mędrców i filozofów, znana ze swoich starożytnych bibliotek',
			warinfo = ''
		},
		xPos = 550,
		yPos = 810,
		icon = Material( 'luna_menus/warfare/planets/5.png', 'smooth mips' ),
		team = 2
	},
	[26] = {
		name = 'Uranntha',
		status = 1,
		desc = {
			info = 'Górny mir z bogatymi zalezami redkich mineralow i kristalow',
			warinfo = ''
		},
		xPos = 520,
		yPos = 960,
		icon = Material( 'luna_menus/warfare/planets/4.png', 'smooth mips' ),
		team = 2
	},
	[27] = {
		name = 'Vivillini',
		status = 1,
		desc = {
			info = 'Planeta-sad z egzotycznymi roślinami i niebezpiecznymi drapieżnikami',
			warinfo = ''
		},
		xPos = 1100,
		yPos = 520,
		icon = Material( 'luna_menus/warfare/planets/19.png', 'smooth mips' ),
		team = 2
	},
	[28] = {
		name = 'Vrasliada',
		status = 1,
		desc = {
			info = 'Świat dawnych ruin, przyciągający archeologów i poszukiwaczy skarbów',
			warinfo = ''
		},
		xPos = 1250,
		yPos = 560,
		icon = Material( 'luna_menus/warfare/planets/3.png', 'smooth mips' ),
		team = 3
	},
	[29] = {
		name = 'Nyu-Plimpto',
		status = 1,
		desc = {
			info = 'Miejscowa ludność aktywnie wspiera Separatystów.',
			warinfo = ''
		},
		xPos = 1360,
		yPos = 660,
		icon = Material( 'luna_menus/warfare/planets/10.png', 'smooth mips' ),
		team = 1
	},
	[30] = {
		name = 'Kaikelius',
		status = 1,
		desc = {
			info = 'Świat z unikalną strukturą krystaliczną i osobliwymi formami życia',
			warinfo = ''
		},
		xPos = 900,
		yPos = 700,
		icon = Material( 'luna_menus/warfare/planets/11.png', 'smooth mips' ),
		team = 2
	},
	[31] = {
		name = 'Kviilura',
		status = 1,
		desc = {
			info = 'Planeta rolnicza, pozwalająca na szybkie uprawianie plonów',
			warinfo = ''
		},
		xPos = 1030,
		yPos = 300,
		icon = Material( 'luna_menus/warfare/planets/28.png', 'smooth mips' ),
		team = 2
	},
}

DEFAULT_FEATURES = {
	["recon"] = false,
	["marskman"] = false,
	["medic"] = false,
	["hvymed"] = false,
	["desu"] = false,
	["destiaz"] = false,
	["engspec"] = false,
	["engzagrad"] = false,
	["supp"] = false,
	["hvy"] = false,
	["rpsuser"] = false,
	["air_land"] = false,
	["oficc"] = false,
	["admin_class"] = false,
	["astromech_class"] = false,
	["droidcis_class"] = false,
	["merc_class"] = false,
	["commando_class"] = false,
	["senator_class"] = false,
	["wookie_class"] = false,
	["citizen_class"] = false,
	["police_class"] = false,
	["jedi_class"] = false,
	["jedi_class1"] = false,
	["jedi_class2"] = false,
	["jedi_class3"] = false,
	["jedi_class4"] = false,
	["jedi_class5"] = false,
	["jedi_class6"] = false,
	["jedi_medic"] = false,
}

timer.Simple(.1, function()
	FEATURES_TO_NORMAL = {
		-- ["air"] = { name = "Воздушная Техника", weapons = {"repair_tool"} }, -- ["ground"] = { name = "Наземная Техника", weapons = {"repair_tool"} },
		["recon"] = {
			name = "Zwiadowca",
			weapons = {"masita_dc15x", "rdv_camoswep", "hook", "waypoint_designator"},
			desc = "Klon zwiadowcy nosili zbroję z zaawansowanego plastoidu, pod którą zakładali czarny kombinezon. Ich zbroja była pomalowana na ciemnozielone odcienie, a uzbrojeni byli w karabiny blasterowe DC-15A oraz różne karabiny snajperskie. Zwiadowcy wykorzystywali BARC-spidery do celów zwiadowczych.",
			icon = "luna_menus/hud/classes/9.png",
			callback = function(ply, char)
				ply:SetRunSpeed(ply:GetRunSpeed() * 1)
				ply:SetWalkSpeed(ply:GetWalkSpeed() * 1)
				ply:SetMaxSpeed(ply:GetMaxSpeed() * 1)		
			end
		},
		["marskman"] = {
			name = "Strzelec wyborowy",
			weapons = {"masita_valken38x", "hook", "waypoint_designator"},
			desc = "Klon zwiadowcy nosili zbroję z zaawansowanego plastoidu, pod którą zakładali czarny kombinezon. Ich zbroja była pomalowana na ciemnozielone odcienie, a uzbrojeni byli w karabiny blasterowe DC-15A oraz różne karabiny snajperskie. Zwiadowcy wykorzystywali BARC-spidery do celów zwiadowczych.",
			icon = "luna_menus/hud/classes/4.png",
			callback = function(ply, char)
				ply:SetRunSpeed(ply:GetRunSpeed() * 1)
				ply:SetWalkSpeed(ply:GetWalkSpeed() * 1)
				ply:SetMaxSpeed(ply:GetMaxSpeed() * 1)		
			end
		},
		["medic"] = {
			name = "Medyk Polowy",
			weapons = {"weapon_bactainjector", "weapon_defibrillator", "weapon_bactanade", "weapon_med_bandage", "rust_syringe", "weapon_med_scanner", "masita_dp23"},
			desc = "Zwyczajny klon medyk można było rozpoznać po pomarańczowych oznaczeniach na zbroi lub specjalnej emblematce, chociaż nie we wszystkich jednostkach tak było. Klon-Medycy uzupełniali swój arsenał również sprzętem medycznym. Zazwyczaj były to dwa wibroskalpele, jeden laserowy skalpel i dwa przyżegacze z laserowym działaniem. Zazwyczaj mieli przy sobie plecak, w którym znajdowały się różne rodzaje bakty, bandaże i inne przybory medyczne.",
			icon = "luna_menus/hud/classes/6.png",
			callback = function(ply, char)
				ply:SetMaxHealth(ply:GetMaxHealth() + 30)
				ply:SetHealth(ply:GetMaxHealth())

				ply:SetMaxSpeed(ply:GetMaxSpeed() * 1)	
            end
		},
		["hvymed"] = {
			name = "Sanitariusz",
			weapons = {"masita_dc15a_heavy", "weapon_defibrillator", "weapon_bactainjector", "rust_syringe", "weapon_med_bandage"},
			desc = "Klony te były uzbrojone w jedne z najpotężniejszych materiałów wybuchowych i broni dostępnych w arsenale Wielkiej Armii Republiki, w tym granaty, rakiety, ładunki wybuchowe i inne rodzaje ciężkiego uzbrojenia. Ponieważ ich praca często wiązała się z działalnością wywrotową, pancerz został wzmocniony, aby chronić nosiciela.",
			icon = "luna_icons/heart-tower.png",
			callback = function(ply, char)
				ply:SetMaxHealth(ply:GetMaxHealth() + 45)
				ply:SetHealth(ply:GetMaxHealth())

				ply:SetMaxArmor(350)
				ply:SetArmor(350)

				ply:SetRunSpeed(ply:GetRunSpeed() * 1)
				ply:SetWalkSpeed(ply:GetWalkSpeed() * 1)
				ply:SetMaxSpeed(ply:GetMaxSpeed() * 1)		
			end
		},
		["desu"] = {
			name = "Spadochroniarz",
			weapons = {"jet_exec", "masita_dc15s_grenadier"},
			desc = "Specjalizacja bojowa, która zakłada wykonywanie operacji w warunkach szybkiego przemieszczania się na polu walki. Spadochroniarze są wykorzystywani do desantu w tyłach przeciwnika, wykonywania operacji dywersyjnych oraz przejmowania kluczowych obiektów.",
			icon = "luna_menus/hud/classes/12.png",
			callback = function(ply, char)
				ply:SetRunSpeed(ply:GetRunSpeed() * 1)
				ply:SetWalkSpeed(ply:GetWalkSpeed() * 1)
				ply:SetMaxSpeed(ply:GetMaxSpeed() * 1)		
			end
		},
		["destiaz"] = {
			name = "Awangardowy Spadochroniarz",
			weapons = {"jet_exec", "masita_dc15a_heavy"},
			desc = "Specjalizacja bojowa, która zakłada wykonywanie operacji w warunkach szybkiego przemieszczania się na polu walki. Spadochroniarze są wykorzystywani do desantu w tyłach przeciwnika, wykonywania operacji dywersyjnych oraz przejmowania kluczowych obiektów.",
			icon = "luna_menus/hud/classes/11.png",
			callback = function(ply, char)
				ply:SetMaxHealth(ply:GetMaxHealth() + 50)
				ply:SetHealth(ply:GetMaxHealth())

				ply:SetMaxArmor(250)
				ply:SetArmor(250)

				ply:SetRunSpeed(ply:GetRunSpeed() * 1)
				ply:SetWalkSpeed(ply:GetWalkSpeed() * 1)
				ply:SetMaxSpeed(ply:GetMaxSpeed() * 1)		
		    end
		},
		["engspec"] = {
			name = "Inżynier-specjalista",
			weapons = {"masita_cr2", "weapon_lvsrepair", "turret_placer", "arccw_btrs_41", "defuser_bomb"},
			desc = "Klon-inżynierowie, znani również jako bojowi klon-inżynierowie, byli specjalnymi jednostkami wielkiej armii Republiki i członkami bojowego batalionu inżynierów. Zadania inżynierów dotyczyły głównie pracy z różnymi rodzajami sprzętu – od urządzeń po statki kosmiczne. Często inżynierowie pełnili funkcje pilotów, a dysponując materiałami wybuchowymi i akcesoriami medycznymi, prowadzili działania wywrotowe i medyczne.",
			icon = "luna_icons/tinker.png",
			callback = function(ply, char)
				ply:SetRunSpeed(ply:GetRunSpeed() * 1)
				ply:SetWalkSpeed(ply:GetWalkSpeed() * 1)
				ply:SetMaxSpeed(ply:GetMaxSpeed() * 1)		
			end
		},
		["engzagrad"] = {
			name = "Inżynier-Budowa",
			weapons = {"weapon_lvsrepair", "fort_datapad", "weapon_squadshield_arm", "masita_cr2"},
			desc = "Klony te były uzbrojone w jedne z najpotężniejszych materiałów wybuchowych i broni dostępnych w arsenale Wielkiej Armii Republiki, w tym granaty, rakiety, ładunki wybuchowe i inne rodzaje ciężkiego uzbrojenia. Ponieważ ich praca często wiązała się z działalnością wywrotową, pancerz został wzmocniony, aby chronić nosiciela.",
			icon = "luna_menus/hud/classes/3.png",
			callback = function(ply, char)
				ply:SetMaxArmor(300)
				ply:SetArmor(300)
--
				ply:SetRunSpeed(ply:GetRunSpeed() * 1)
				ply:SetWalkSpeed(ply:GetWalkSpeed() * 1)
				ply:SetMaxSpeed(ply:GetMaxSpeed() * 1)		
			end
		},
		["supp"] = {
			name = "Wsparcie",
			weapons = {"masita_repshield", "cc_buff_speed", "deployable_force_shield_augment_wep", "masita_dp23", "masita_dual_dc17", "cc_buff_armor", "cc_buff_heal"},
			desc = "Posiada unikalne umiejętności pozwalające wzmacniać zdolności bojowe sojuszników, a także zapewniać osłonę i wsparcie techniczne na polu bitwy. Klon tej klasy preferuje działanie w zespole, koordynując swoje działania z towarzyszami i tworząc taktyczne przewagi dla swojej strony. Potrafi analizować sytuację, szybko reagować na zmiany w walce i podejmować właściwe decyzje, aby zapewnić zwycięstwo swojej drużynie.",
			icon = "luna_menus/hud/classes/5.png",
			callback = function(ply, char)
				ply:SetMaxArmor(250)
				ply:SetArmor(250)


				ply:SetRunSpeed(ply:GetRunSpeed() * 1)
				ply:SetWalkSpeed(ply:GetWalkSpeed() * 1)
				ply:SetMaxSpeed(ply:GetMaxSpeed() * 1)		
			end
		},
		["zand"] = {
			name = "Żandarmeria",
			weapons = {"handcuffs", "arrest_baton", "unarrest_baton", "masita_dc15s_stun", "masita_dc17_stun"},
			desc = "Posiada unikalne umiejętności pozwalające wzmacniać zdolności bojowe sojuszników, a także zapewniać osłonę i wsparcie techniczne na polu bitwy. Klon tej klasy preferuje działanie w zespole, koordynując swoje działania z towarzyszami i tworząc taktyczne przewagi dla swojej strony. Potrafi analizować sytuację, szybko reagować na zmiany w walce i podejmować właściwe decyzje, aby zapewnić zwycięstwo swojej drużynie.",
			icon = "luna_menus/hud/classes/5.png",
			callback = function(ply, char)
				ply:SetMaxArmor(250)
				ply:SetArmor(250)


				ply:SetRunSpeed(ply:GetRunSpeed() * 1)
				ply:SetWalkSpeed(ply:GetWalkSpeed() * 1)
				ply:SetMaxSpeed(ply:GetMaxSpeed() * 1)		
			end
		},
		["hvy"] = {
			name = "Ciężki wojownik",
			weapons = {"arccw_meeks_z6"},
			desc = "Klony te były uzbrojone w jedne z najpotężniejszych materiałów wybuchowych i broni dostępnych w arsenale Wielkiej Armii Republiki, w tym granaty, rakiety, ładunki wybuchowe i inne rodzaje ciężkiego uzbrojenia. Ponieważ ich praca często wiązała się z działalnością wywrotową, pancerz został wzmocniony, aby chronić nosiciela.",
			icon = "luna_menus/hud/classes/1.png",
			callback = function(ply, char)
				ply:SetMaxHealth(ply:GetMaxHealth() + 100)
				ply:SetHealth(ply:GetMaxHealth())

				ply:SetMaxArmor(450)
				ply:SetArmor(450)
				ply:SetWalkSpeed(ply:GetWalkSpeed() * 1)
				ply:SetRunSpeed(ply:GetRunSpeed() * 1)
				ply:SetMaxSpeed(ply:GetMaxSpeed() * 1)		
			end
		},
		["rpsuser"] = {
			name = "Tandem",
			weapons = {"arccw_sw_rocket_rps6"},
			desc = "Klony te były uzbrojone w jedne z najpotężniejszych materiałów wybuchowych i broni dostępnych w arsenale Wielkiej Armii Republiki, w tym granaty, rakiety, ładunki wybuchowe i inne rodzaje ciężkiego uzbrojenia. Ponieważ ich praca często wiązała się z działalnością wywrotową, pancerz został wzmocniony, aby chronić nosiciela.",
			icon = "luna_menus/hud/classes/7.png",
			callback = function(ply, char)
				ply:SetMaxHealth(ply:GetMaxHealth() + 30)
				ply:SetHealth(ply:GetMaxHealth())

				ply:SetMaxArmor(350)
				ply:SetArmor(350)

				ply:SetRunSpeed(ply:GetRunSpeed() * 1)
				ply:SetWalkSpeed(ply:GetWalkSpeed() * 1)
				ply:SetMaxSpeed(ply:GetMaxSpeed() * 1)		
			end
		},
		["air_land"] = {
			name = "Pilot-Kierowca",
			weapons = {"weapon_hands", "weapon_lvsrepair", "masita_dual_dc17"},
			desc = "Specjalista odpowiedzialny za obsługę różnych pojazdów, czy to lądowych, wodnych czy powietrznych. Jego głównym zadaniem jest dostarczanie wojsk i ładunków na pozycje frontowe oraz zapewnienie sprawnego manewrowania na polu bitwy. Piloci-kierowcy muszą posiadać umiejętności prowadzenia pojazdów w trudnych warunkach, potrafić omijać przeszkody i zapewniać bezpieczeństwo swojego ładunku lub pasażerów.",
			icon = "luna_icons/bomber.png",
		},
		["oficc"] = {
			name = "Oficer",
			weapons = {"cc_buff_speed", "masita_dual_dc17ext", "masita_dp23", "cc_buff_ressurection",  "waypoint_designator"},
			desc = "Posiadasz wyjątkowe umiejętności, koordynując swoje działania z kolegami i tworząc przewagę taktyczną dla swojej drużyny. Potrafisz analizować sytuację, szybko reagować na zmiany w walce i podejmować właściwe decyzje, aby zapewnić zwycięstwo swojej drużynie.",
			icon = "luna_menus/hud/classes/10.png",
        },
		["admin_class"] = {
			name = "Admin-Pracownik",
			weapons = {"weapon_hands"},
			desc = "Jesteś adminem, pracuj, niewolniku systemu.",
			icon = "luna_menus/hud/classes/17.png",
			invisible = true,
			base_job = TEAM_OVERWATCH
		},
		["astromech_class"] = {
			name = "Astrodroid",
			weapons = {"weapon_hands"},
			desc = "Specjalista odpowiedzialny za obsługę i naprawę statków kosmicznych i powietrznych oraz zaawansowanej technologii. Do jego obowiązków należy diagnozowanie usterek, konfiguracja systemów nawigacji i uzbrojenia oraz szybka naprawa uszkodzonych maszyn bezpośrednio na polu bitwy lub w bazie. Astrodroidy odgrywają kluczową rolę w utrzymaniu gotowości bojowej floty i sprzętu, zapewniając ich nieprzerwaną pracę i gotowość do realizacji zadań bojowych.",
			icon = "luna_menus/hud/classes/13.png",
			invisible = true,
			base_job = TEAM_ASTROMECH
		},
		["droidcis_class"] = {
			name = "Droid CIS",
			weapons = {"weapon_hands"},
			desc = "bojowa zautomatyzowana jednostka opracowana przez Konfederację Niezależnych Systemów (CIS). Droidy te są wykorzystywane zarówno w walkach naziemnych, jak i kosmicznych. Mogą wykonywać szeroki zakres zadań: od bezpośredniej walki z przeciwnikiem po działania rozpoznawcze i dywersyjne. Wyposażone w podstawową sztuczną inteligencję, droidy CIS są w stanie samodzielnie podejmować decyzje taktyczne, dostosowując się do zmieniających się warunków walki.",
			icon = "luna_menus/hud/classes/15.png",
			invisible = true,
			base_job = TEAM_CIS1
		},
		["merc_class"] = {
			name = "Najemnik",
			weapons = {"weapon_hands"},
			desc = "Niezależny wojownik, który walczy nie z powodów ideologicznych, lecz dla nagrody. Ci żołnierze cechują się wysokim poziomem wyszkolenia bojowego i często mają doświadczenie w różnych konfliktach. Najemnicy mogą wykonywać zarówno misje indywidualne, jak i działać w grupach, realizując kontrakty dla różnych frakcji lub organizacji.",
			icon = "luna_menus/hud/classes/16.png",
			invisible = true,
			base_job = TEAM_MERCENARY
		},
		["commando_class"] = {
			name = "Klon-Komandos",
			weapons = {"weapon_hands"},
			desc = "Klon-komandos lub republikański komandos – żołnierz-klon Wielkiej Armii Republiki, wyszkolony do prowadzenia operacji specjalnych. W grupach po czterech osób komandosi trenowali według specjalnego, intensywnego programu, aby wykonywać zadania zbyt skomplikowane dla zwykłych żołnierzy. Zazwyczaj zadania te polegały na potajemnym wkroczeniu na teren obiektu, rozpoznaniu, likwidacji konkretnych obiektów i dywersjach.",
			icon = "luna_menus/hud/classes/19.png",
			invisible = true,
			base_job = TEAM_COMMANDO
		},
		["senator_class"] = {
			name = "Senator",
			weapons = {"weapon_hands"},
			desc = "Stanowisko przedstawicieli wielu systemów i planet w Senacie Galaktycznej Republiki. W okresie Wojen Klonów, gdy Republika walczyła przeciwko Konfederacji Niezależnych Systemów, separatystyczni senatorowie zorganizowali własny senat, Kongres separatystów, który prowadził negocjacje dyplomatyczne w imieniu całego państwa.",
			icon = "luna_menus/hud/classes/18.png",
			invisible = true,
			base_job = TEAM_SENATOR
		},
		["wookie_class"] = {
			name = "Wookie",
			weapons = {"weapon_hands"},
			desc = "W dosłownym tłumaczeniu „ludzie drzew” — rozumna rasa owłosionych dwunożnych humanoidów, którzy żyli na planecie Kashyyyk. Jednym z najsłynniejszych przedstawicieli rasy jest Chewbacca, przyjaciel Hana Solo i drugi pilot „Sokoła Millennium”, który odegrał ważną rolę w wojnie domowej i po niej. Wśród Wookiech zdarzały się też Jedi, choć takie przypadki były niezwykle rzadkie.",
			icon = "luna_menus/hud/classes/14.png",
			invisible = true,
			base_job = TEAM_WOOKIE
		},
		["citizen_class"] = {
			name = "Obywatel",
			weapons = {"weapon_hands"},
			desc = "Najliczniejsza i politycznie dominująca grupa rozumnych ras, posiadająca miliony dużych i małych kolonii w całej Galaktyce.",
			icon = "luna_menus/hud/classes/19.png",
			invisible = true,
			base_job = TEAM_CITIZEN
		},
		["police_class"] = {
			name = "Policjant",
			weapons = {"weapon_hands"},
			desc = "Organy ścigania to organizacje, które zapewniały przestrzeganie prawa pod kierownictwem jakiegoś rządu. Większość z nich nazywano policją lub siłami bezpieczeństwa. Organy ścigania na przestrzeni całej historii Galaktyki nosiły różne nazwy i pełniły różne funkcje.",
			icon = "luna_menus/hud/classes/14.png",
			invisible = true,
			base_job = TEAM_POLICE
		},
		["jedi_class"] = {
			name = "Jedi",
			weapons = {"weapon_hands"},
			desc = "Jedi — adept jasnej strony Mocy, służący Zakonowi Jedi i wykorzystujący energię Mocy. Jedi walczyli o pokój i sprawiedliwość w Galaktycznej Republice, zazwyczaj przeciwko swoim zaciekłym wrogom, Sithom i ciemnym Jedi. Podczas wojen, zwłaszcza tych z udziałem lub wywołanych przez Sithów, Jedi otrzymywali stopnie wojskowe i stawali w obronie Republiki jako dowódcy armii i jednostek sił zbrojnych Republiki.",
			icon = "luna_ui_base/elements/jedi.png",
			invisible = true,
			base_job = TEAM_JEDI1
		},
		["jedi_class1"] = {
			name = "Jedi",
			weapons = {"weapon_hands"},
			desc = "Jedi — adept jasnej strony Mocy, służący Zakonowi Jedi i wykorzystujący energię Mocy. Jedi walczyli o pokój i sprawiedliwość w Galaktycznej Republice, zazwyczaj przeciwko swoim zaciekłym wrogom, Sithom i ciemnym Jedi. Podczas wojen, zwłaszcza tych z udziałem lub wywołanych przez Sithów, Jedi otrzymywali stopnie wojskowe i stawali w obronie Republiki jako dowódcy armii i jednostek sił zbrojnych Republiki.",
			icon = "luna_ui_base/elements/jedi.png",
			invisible = true,
			base_job = TEAM_JEDI2
		},
		["jedi_class2"] = {
			name = "Jedi",
			weapons = {"weapon_hands"},
			desc = "Jedi — adept jasnej strony Mocy, służący Zakonowi Jedi i wykorzystujący energię Mocy. Jedi walczyli o pokój i sprawiedliwość w Galaktycznej Republice, zazwyczaj przeciwko swoim zaciekłym wrogom, Sithom i ciemnym Jedi. Podczas wojen, zwłaszcza tych z udziałem lub wywołanych przez Sithów, Jedi otrzymywali stopnie wojskowe i stawali w obronie Republiki jako dowódcy armii i jednostek sił zbrojnych Republiki.",
			icon = "luna_ui_base/elements/jedi.png",
			invisible = true,
			base_job = TEAM_JEDI3
		},
		["jedi_class3"] = {
			name = "Jedi",
			weapons = {"weapon_hands"},
			desc = "Jedi — adept jasnej strony Mocy, służący Zakonowi Jedi i wykorzystujący energię Mocy. Jedi walczyli o pokój i sprawiedliwość w Galaktycznej Republice, zazwyczaj przeciwko swoim zaciekłym wrogom, Sithom i ciemnym Jedi. Podczas wojen, zwłaszcza tych z udziałem lub wywołanych przez Sithów, Jedi otrzymywali stopnie wojskowe i stawali w obronie Republiki jako dowódcy armii i jednostek sił zbrojnych Republiki.",
			icon = "luna_ui_base/elements/jedi.png",
			invisible = true,
			base_job = TEAM_JEDI4
		},
		["jedi_class4"] = {
			name = "Jedi",
			weapons = {"weapon_hands"},
			desc = "Jedi — adept jasnej strony Mocy, służący Zakonowi Jedi i wykorzystujący energię Mocy. Jedi walczyli o pokój i sprawiedliwość w Galaktycznej Republice, zazwyczaj przeciwko swoim zaciekłym wrogom, Sithom i ciemnym Jedi. Podczas wojen, zwłaszcza tych z udziałem lub wywołanych przez Sithów, Jedi otrzymywali stopnie wojskowe i stawali w obronie Republiki jako dowódcy armii i jednostek sił zbrojnych Republiki.",
			icon = "luna_ui_base/elements/jedi.png",
			invisible = true,
			base_job = TEAM_JEDI5
		},
		["jedi_class5"] = {
			name = "Jedi",
			weapons = {"weapon_hands"},
			desc = "Jedi — adept jasnej strony Mocy, służący Zakonowi Jedi i wykorzystujący energię Mocy. Jedi walczyli o pokój i sprawiedliwość w Galaktycznej Republice, zazwyczaj przeciwko swoim zaciekłym wrogom, Sithom i ciemnym Jedi. Podczas wojen, zwłaszcza tych z udziałem lub wywołanych przez Sithów, Jedi otrzymywali stopnie wojskowe i stawali w obronie Republiki jako dowódcy armii i jednostek sił zbrojnych Republiki.",
			icon = "luna_ui_base/elements/jedi.png",
			invisible = true,
			base_job = TEAM_JEDI7
		},
		["jedi_class6"] = {
			name = "Jedi",
			weapons = {"weapon_hands"},
			desc = "Jedi — adept jasnej strony Mocy, służący Zakonowi Jedi i wykorzystujący energię Mocy. Jedi walczyli o pokój i sprawiedliwość w Galaktycznej Republice, zazwyczaj przeciwko swoim zaciekłym wrogom, Sithom i ciemnym Jedi. Podczas wojen, zwłaszcza tych z udziałem lub wywołanych przez Sithów, Jedi otrzymywali stopnie wojskowe i stawali w obronie Republiki jako dowódcy armii i jednostek sił zbrojnych Republiki.",
			icon = "luna_ui_base/elements/jedi.png",
			invisible = true,
			base_job = TEAM_JEDI
		},
		["jedi_medic"] = {
			name = "Jedi",
			weapons = {"weapon_hands"},
			desc = "Jedi – adept jasnej strony Mocy, służący Zakonowi Jedi i wykorzystujący energię Mocy. Jedi walczyli o pokój i sprawiedliwość w Galaktycznej Republice, zazwyczaj przeciwko swoim zaprzysięgłym wrogom, Sithom i mrocznym Jedi. Podczas wojen, zwłaszcza tych z udziałem lub wywołanych przez Sithów, Jedi otrzymywali stopnie wojskowe i stali na straży Republiki jako dowódcy armii i oddziałów sił zbrojnych Republiki.",
			icon = "luna_ui_base/elements/jedi.png",
			invisible = true,
			base_job = TEAM_JEDIMED
		},
		["massif"] = {
			name = "Massiff",
			weapons = {"weapon_hands"},
			desc = "Niektóre rasy i pojedyncze istoty inteligentne oswajały masiffy, aby pełniły służbę patrolową, wartowniczą i ochronną. Ludzie piasków wykorzystywali je do ochrony swoich obozowisk. Podczas Wojen Klonów żołnierze-klony Wielkiej Armii Republiki wykorzystywali te zwierzęta jako strażników, a elitarne klony-zwiadowcy szkolili je jako tropicieli.",
			icon = "luna_icons/pawprint.png",
			invisible = true,
			base_job = TEAM_MASIF,

		},
	}
	--<<<<<<< HEAD
	-- ['reconhui'] = {
	--     name = 'Диверсант',
	--     weapons = {'hook','m9k_suicide_bomb','m9k_m61_frag','m9k_proxy_mine','t3m4_empgrenade','weapon_frag'},
	-- },
	-- ['specialist'] = {
	--     name = 'Специалист',
	--     weapons = {'sup_repsniper','weapon_rpw_binoculars_nvg','sup_repat'},
	-- },
	FEATURE_ARMORMODELS = {
		['snow1'] = {
			model = 'models/nsn/ct_snow/pm_ct_snow.mdl',
			name = 'Snow Armor',
			check = function(pPlayer)
				return table.HasValue({TEAM_UN}, pPlayer:Team())
			end
		},
		['snow1slk'] = {
			model = 'models/nsn/41st_snow/pm_41st_snow.mdl',
			name = 'Snow Armor',
			check = function(pPlayer)
				return table.HasValue({TEAM_SLK}, pPlayer:Team())
			end
		},
		['snow1plt'] = {
			model = 'models/nsn/ct_snow/pm_ct_snow.mdl',
			name = 'Snow Armor',
			check = function(pPlayer)
				return table.HasValue({TEAM_PILOTS}, pPlayer:Team())
			end
		},
		['snow1arf'] = {
			model = 'models/nsn/41st_snow/pm_41st_snow.mdl',
			name = 'Snow Armor',
			check = function(pPlayer)
				return table.HasValue({TEAM_ARF}, pPlayer:Team())
			end
		},
		['snow2'] = {
			model = 'models/nsn/212th_snow/pm_212th_snow.mdl',
			name = 'Snow Armor',
			check = function(pPlayer)
				return table.HasValue({TEAM_212}, pPlayer:Team())
			end
		},
		['snow3'] = {
			model = 'models/nsn/501st_snow/pm_501st_snow.mdl',
			name = 'Snow Armor',
			check = function(pPlayer)
				return table.HasValue({TEAM_501}, pPlayer:Team())
			end
		},
		['snow4'] = {
			model = 'models/nsn/wolffe_snow/pm_wolffe_snow.mdl',
			name = 'Snow Armor',
			check = function(pPlayer)
				return table.HasValue({TEAM_104}, pPlayer:Team())
			end
		},
		['snow5'] = {
			model = 'models/nsn/327th_snow/pm_327th_snow.mdl',
			name = 'Snow Armor',
			check = function(pPlayer)
				return table.HasValue({TEAM_327}, pPlayer:Team())
			end
		},
		['snow6'] = {
			model = 'models/nsn/cg_snow/pm_cg_snow.mdl',
			name = 'Snow Armor',
			check = function(pPlayer)
				return table.HasValue({TEAM_91}, pPlayer:Team())
			end
		},
		['snow7'] = {
			model = 'models/nsn/gree_snow/pm_gree_snow.mdl',
			name = 'Snow Armor',
			check = function(pPlayer)
				return table.HasValue({TEAM_15}, pPlayer:Team())
			end
		},
		['snow8'] = {
			model = 'models/nsn/fox_snow/pm_fox_snow.mdl',
			name = 'Snow Armor',
			check = function(pPlayer)
				return table.HasValue({TEAM_8}, pPlayer:Team())
			end
		},
		['flame1'] = {
			model = 'models/player/lbmodels/cgiclonescuba/cgiclonescuba.mdl',
			name = 'Diver Suit',
			check = function(pPlayer)
				return table.HasValue({TEAM_UN}, pPlayer:Team())
			end
		},
		['flame1slk'] = {
			model = 'models/player/lbmodels/cgiclonescuba/cgiclonescuba.mdl',
			name = 'Diver Suit',
			check = function(pPlayer)
				return table.HasValue({TEAM_SLK}, pPlayer:Team())
			end
		},
		['flame1plt'] = {
			model = 'models/player/lbmodels/cgiclonescuba/cgiclonescuba.mdl',
			name = 'Diver Suit',
			check = function(pPlayer)
				return table.HasValue({TEAM_PILOTS}, pPlayer:Team())
			end
		},
		['flame1arf'] = {
			model = 'models/player/lbmodels/cgiclonescuba/cgiclonescuba.mdl',
			name = 'Diver Suit',
			check = function(pPlayer)
				return table.HasValue({TEAM_ARF}, pPlayer:Team())
			end
		},
		['flame2'] = {
			model = 'models/player/lbmodels/cgiclonescuba/cgiclonescuba.mdl',
			name = 'Diver Suit',
			check = function(pPlayer)
				return table.HasValue({TEAM_212}, pPlayer:Team())
			end
		},
		['flame3'] = {
			model = 'models/player/lbmodels/cgiclonescuba/cgiclonescuba.mdl',
			name = 'Diver Suit',
			check = function(pPlayer)
				return table.HasValue({TEAM_501}, pPlayer:Team())
			end
		},
		['flame4'] = {
			model = 'models/player/lbmodels/cgiclonescuba/cgiclonescuba.mdl',
			name = 'Diver Suit',
			check = function(pPlayer)
				return table.HasValue({TEAM_104}, pPlayer:Team())
			end
		},
		['flame5'] = {
			model = 'models/player/lbmodels/cgiclonescuba/cgiclonescuba.mdl',
			name = 'Diver Suit',
			check = function(pPlayer)
				return table.HasValue({TEAM_327}, pPlayer:Team())
			end
		},
		['flame6'] = {
			model = 'models/player/lbmodels/cgiclonescuba/cgiclonescuba.mdl',
			name = 'Diver Suit',
			check = function(pPlayer)
				return table.HasValue({TEAM_91}, pPlayer:Team())
			end
		},
		['flame7'] = {
			model = 'models/player/lbmodels/cgiclonescuba/cgiclonescuba.mdl',
			name = 'Diver Suit',
			check = function(pPlayer)
				return table.HasValue({TEAM_15}, pPlayer:Team())
			end
		},
		['flame8'] = {
			model = 'models/player/lbmodels/cgiclonescuba/cgiclonescuba.mdl',
			name = 'Diver Suit',
			check = function(pPlayer)
				return table.HasValue({TEAM_8}, pPlayer:Team())
			end
		},
		['out1'] = {
			model = 'models/player/clone cadet/clonecadet.mdl',
			name = 'No Uniform',
			check = function(pPlayer)
				return table.HasValue({TEAM_UN}, pPlayer:Team())
			end
		},
		['out1slk'] = {
			model = 'models/player/clone cadet/clonecadet.mdl',
			name = 'No Uniform',
			check = function(pPlayer)
				return table.HasValue({TEAM_SLK}, pPlayer:Team())
			end
		},
		['out1plt'] = {
			model = 'models/player/clone cadet/clonecadet.mdl',
			name = 'No Uniform',
			check = function(pPlayer)
				return table.HasValue({TEAM_PILOTS}, pPlayer:Team())
			end
		},
		['out1arf'] = {
			model = 'models/player/clone cadet/clonecadet.mdl',
			name = 'No Uniform',
			check = function(pPlayer)
				return table.HasValue({TEAM_ARF}, pPlayer:Team())
			end
		},
		['out2'] = {
			model = 'models/player/clone cadet/clonecadet.mdl',
			name = 'No Uniform',
			check = function(pPlayer)
				return table.HasValue({TEAM_212}, pPlayer:Team())
			end
		},
		['out3'] = {
			model = 'models/player/clone cadet/clonecadet.mdl',
			name = 'No Uniform',
			check = function(pPlayer)
				return table.HasValue({TEAM_501}, pPlayer:Team())
			end
		},
		['out4'] = {
			model = 'models/player/clone cadet/clonecadet.mdl',
			name = 'No Uniform',
			check = function(pPlayer)
				return table.HasValue({TEAM_104}, pPlayer:Team())
			end
		},
		['out5'] = {
			model = 'models/player/clone cadet/clonecadet.mdl',
			name = 'No Uniform',
			check = function(pPlayer)
				return table.HasValue({TEAM_327}, pPlayer:Team())
			end
		},
		['out6'] = {
			model = 'models/player/clone cadet/clonecadet.mdl',
			name = 'No Uniform',
			check = function(pPlayer)
				return table.HasValue({TEAM_91}, pPlayer:Team())
			end
		},
		['out7'] = {
			model = 'models/player/clone cadet/clonecadet.mdl',
			name = 'No Uniform',
			check = function(pPlayer)
				return table.HasValue({TEAM_15}, pPlayer:Team())
			end
		},
		['out8'] = {
			model = 'models/player/clone cadet/clonecadet.mdl',
			name = 'No Uniform',
			check = function(pPlayer)
				return table.HasValue({TEAM_8}, pPlayer:Team())
			end
		},
		['eng'] = {
			model = 'models/navy/gnavyengineer2.mdl',
			name = 'Engineer Suit',
			check = function(pPlayer)
				return table.HasValue({TEAM_104}, pPlayer:Team())
			end
		},
		['engpl'] = {
			model = 'models/navy/gnavyengineer2.mdl',
			name = 'Engineer Suit',
			check = function(pPlayer)
				return table.HasValue({TEAM_PILOTS}, pPlayer:Team())
			end
		},
		['med'] = {
			model = 'models/navy/gnavymedic.mdl',
			name = 'Medic Suit',
			check = function(pPlayer)
				return table.HasValue({TEAM_15}, pPlayer:Team())
			end
		},
	}
end)