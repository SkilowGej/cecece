GM = GM or GAMEMODE
GAMEMODE = GM or GAMEMODE

-- Set up basic gamemode values.
GM.Name 		= 'StarWarsRP' -- Gamemode name.
GM.Author 		= 'Piwnica Granie' -- Author name.
GM.Email 		= '_' -- Author email.
GM.Website 		= '' -- Website.
GM.Version      = '1.6.7'

DeriveGamemode('sandbox')

function GM:Initialize()
end

-- Metatables.
PLAYER = FindMetaTable 'Player'
ENTITY = FindMetaTable 'Vector'
VECTOR = FindMetaTable 'Vector'
WEAPON = FindMetaTable 'Weapon'
ANGLE  = FindMetaTable 'Angle'
VECTOR = FindMetaTable 'Vector'

_R = {
    Player = PLAYER,
    Weapon = WEAPON,
    Entity = ENTITY,
    Vector = VECTOR,
    Angle = ANGLE,
}

-- Mopple compability (temp)
pMeta = _R.Player
eMeta = _R.Entity
vMeta = _R.Vector

-- Define a global shared table to store gamemode information.
re = {
	config = config or {
		data = {}
	},
	items = {
		data = {}
	},
	jobs = {},
	util = util or {},
	cmd = cmd or {
		data = {}
	},
	skills = skills or { store = {}, hooks = {} },
	ui = (re and re.ui) and re.ui or {},
	combat = (re and re.combat) and re.combat or {},
	inv = (re and re.inv) and re.inv or {
		PLAYERMETA = {}
	},
	map = (re and re.map) and re.map or {},
}

COLOR_WHITE = Color(255, 255, 255, 255)
COLOR_HOVER = Color(71, 121, 252, 255)
COLOR_SECONDARY = Color(255, 182, 18, 255)
COLOR_BLACK = Color(0, 0, 0, 255)
COLOR_BG = Color(0, 0, 0, 190)


--re.util.CurentMap = game.GetMap()

for _, folder in pairs({
    'kernel/libraries/thirdparty',
    'kernel/libraries',
	'configs',
	'kernel',
	'kernel/hooks'
}) do
    luna.loader.LoadFolder(folder)
end

for _, folder in pairs({
    'kernel/base',
	'modules'
}) do
    luna.loader.LoadFolder(folder, true)
end

local msg = { 
	'\n\n',
	[[ --------------------------------------------------------------------------]],
	[[|░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░|]],
	[[|░██╗░░░░░██╗░░░██╗███╗░░██╗░█████╗░░░░░░░░█████╗░░█████╗░██████╗░███████╗░|]],
	[[|░██║░░░░░██║░░░██║████╗░██║██╔══██╗░░░░░░██╔══██╗██╔══██╗██╔══██╗██╔════╝░|]],
	[[|░██║░░░░░██║░░░██║██╔██╗██║███████║█████╗██║░░╚═╝██║░░██║██████╔╝█████╗░░░|]],
	[[|░██║░░░░░██║░░░██║██║╚████║██╔══██║╚════╝██║░░██╗██║░░██║██╔══██╗██╔══╝░░░|]],
	[[|░███████╗╚██████╔╝██║░╚███║██║░░██║░░░░░░╚█████╔╝╚█████╔╝██║░░██║███████╗░|]],
	[[|░╚══════╝░╚═════╝░╚═╝░░╚══╝╚═╝░░╚═╝░░░░░░░╚════╝░░╚════╝░╚═╝░░╚═╝╚══════╝░|]],
	[[|░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░|]],
	[[ --------------------------------------------------------------------------]],
	[[|   MuguFugu • pack • PapaSoco • DuLL_FoX • -Spac3 • arlekin4 • Sincopa    |]],
	[[ --------------------------------------------------------------------------]],
	'\n\n',
}

local colors = {
	Color(255, 255, 255),
	Color(71, 121, 252, 255),
	Color(255, 0, 0)
}

for k, v in ipairs(msg) do
    local color = colors[1]
	
	/*
    if k <= 4 then
        color = colors[1]
    elseif k <= 8 then
        color = colors[2]
    else
        color = colors[3]
    end
    */

	if k <= 10 then
        color = colors[2]
	else
		color = colors[1]
	end

    MsgC(color, v .. '\n')
end

--         #      Царю Небесный, Утешителю, Душе истины, Иже везде сый и вся исполняяй,
--      #######   Сокровище благих и жизни Подателю, прииди и вселися в ны,
--         #      и очисти ны от всякия скверны, и спаси, Блаже, души наша.
--        ##      Святый Боже, Святый Крепкий, Святый Безсмертный, помилуй нас.
--         ##     (Читается трижды, с крестным знамением и поясным поклоном).
--         # # 