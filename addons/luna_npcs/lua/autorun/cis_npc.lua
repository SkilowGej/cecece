--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local NPC = {
	Name = "Klon-Żołnierz (Pokojowy)",
	Class = "npc_citizen",
	Category = "SUP • Republika",
	Health = "250",
	Model = "models/hazo/npc/ct_trp/npc_ct_trp_f.mdl",
	KeyValues = { citizentype = CT_UNIQUE }
}
list.Set( "NPC", "npc_clone", NPC )

local NPC =
{
	Name = "Aqua Droid Friendly",
	Class = "npc_citizen",
	KeyValues =
	{
		citizentype = 4
	},
	Model = "models/player/valley/npc/aquadroidnpc.mdl",
	Health = "200",
	Category = "SUP • Separatyści"
}

list.Set( "NPC", "npc_valley_aquadf", NPC )

local Category = "SUP • Separatyści"

local NPC =
{
	Name = "Aqua Droid Enemy",
	Class = "npc_combine_s",
	Model = "models/player/valley/npc/aquadroidnpc.mdl",
	Health = "200",
	Category = "SUP • Separatyści"
}

list.Set( "NPC", "npc_valley_aquade", NPC )


local NPC = {
	Name = "Дроид B1",
	Class = "npc_combine_s",
	Category = "SUP • Separatyści",
	Health = "250",
	Model = "models/tfa/comm/gg/npc_comb_sw_droid_b1.mdl",
}
list.Set( "NPC", "npc_droid_cis_b1_h", NPC )

local NPC = {
	Name = "Дроид B1 Джеонозис (Мирный)",
	Class = "npc_citizen",
	Category = "SUP • Separatyści",
	Health = "250",
	Model = "models/tfa/comm/gg/npc_cit_sw_droid_tactical.mdl",
	KeyValues = { citizentype = CT_UNIQUE }
}
list.Set( "NPC", "npc_droid_cis_b1_geo_f", NPC )


local NPC = {
	Name = "Дроид B1 Джеонозис",
	Class = "npc_combine_s",
	Category = "SUP • Separatyści",
	Health = "250",
	Model = "models/tfa/comm/gg/npc_reb_sw_g_droid_b1.mdl",
}
list.Set( "NPC", "npc_droid_cis_b1_geo_h", NPC )

local NPC = {
	Name = "Дроид B1 OOM (Мирный)",
	Class = "npc_citizen",
	Category = "SUP • Separatyści",
	Health = "250",
	Model = "models/npc/cguard_riot/cguard_riot.mdl",
	KeyValues = { citizentype = CT_UNIQUE }
}
list.Set( "NPC", "npc_droid_cis_b1_geo_co_f", NPC )


local NPC = {
	Name = "Дроид B1 OOM",
	Class = "npc_combine_s",
	Category = "SUP • Separatyści",
	Health = "250",
	Model = "models/tfa/comm/gg/npc_comb_sw_droid_commando.mdl",
}
list.Set( "NPC", "npc_droid_cis_b1_geo_co_h", NPC )

local NPC = {
	Name = "Клон",
	Class = "npc_citizen",
	Category = "SUP • Separatyści",
	Health = "250",
	Model = "models/npc/cguard_riot/cguard_riot.mdl",
	KeyValues = { citizentype = CT_UNIQUE }
}
list.Set( "NPC", "npc_droid_b2_pvt_f", NPC )


local NPC = {
	Name = "Дроид B2",
	Class = "npc_combine_s",
	Category = "SUP • Separatyści",
	Health = "250",
	Model = "models/npc_b2_xo/npc_droid_b2_xo_h.mdl",
}
list.Set( "NPC", "npc_droid_b2_pvt_h", NPC )

local NPC = {
	Name = "Каттер",
	Class = "npc_manhack",
	Category = "SUP • Separatyści",
	Model = "models/aussiwozzi/cutter_droid.mdl",
	Health = "200",
        KeyValues = { SquadName = "cutter", } 
}

list.Set( "NPC", "npc_cutterdroid", NPC )

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
