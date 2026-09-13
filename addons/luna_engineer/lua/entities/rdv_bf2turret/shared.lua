--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ENT.Type = "anim"
ENT.Base = "base_anim"
 
ENT.PrintName = "Wieżyczka"
ENT.Author= "Joe, Redcoder, Nicolas"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "SUP • Wyposażenie"
ENT.AutomaticFrameAdvance = true -- Must be set on client
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.RotationSpeed = 50

ENT.RemoveOnDeath = true

ENT.SelfDestruct = {
	Time = 60,
	Enabled = false,
}

ENT.EnemyNPCs = {
	["npc_antlionguard"] = true,
	["npc_combine_s"] = true,
	["npc_helicopter"] = true,
	["npc_manhack"] = true,
	["antlion"] = true,
	["npc_drg_zombie"] = true,
	["npc_drg_headcrab"] = true,
	["npc_summe_aqua"] = true,
	["npc_summe_b1"] = true,
	["npc_summe_b1_heavy"] = true,
	["npc_summe_b1_officer"] = true,
	["npc_summe_b1_sniper"] = true,
	["npc_summe_b2"] = true,
	["npc_summe_b2_jetpack"] = true,
	["npc_summe_bx"] = true,
	["npc_summe_crab"] = true,
	["npc_summe_droideka"] = true,
	["npc_summe_magnaguard"] = true,
	["hc_nb_b1"] = true,
	["hc_nb_b1dw"] = true,
	["hc_nb_b1dist"] = true,
	["hc_nb_b2"] = true,
	["hc_nb_b3"] = true,
	["npc_cutterdroid"] = true,
	["npc_vj_igkiller"] = true,
	["npc_vj_jetpackdroid"] = true,
	["npc_vj_commandodroid"] = true,
	["npc_vj_homing"] = true,
	["npc_vj_droideka"] = true,
	["npc_vj_adsd"] = true,
	["npc_vj_adsd_upgraded"] = true,
	["npc_vj_soldier1"] = true,
	["npc_vj_soldier2"] = true,
	["npc_vj_soldier3"] = true,
	["npc_vj_soldier4"] = true,
	["npc_vj_soldier5"] = true,
	["npc_vj_vulture"] = true,
	["npc_vj_tridroid"] = true,
	["npc_drg_acklay"] = true,
	["npc_drg_colicoid"] = true,
	["npc_drg_jurgoran"] = true,
	["npc_drg_massassi"] = true,
	["npc_drg_makrin"] = true,
	["npc_drg_klorslug"] = true,
	["npc_drg_klorslugyoungling"] = true,
	["npc_drg_krykna_spider"] = true,
	["npc_drg_nexu"] = true,
	["npc_drg_baneback_spider"] = true,
	["npc_drg_reek"] = true,
	["npc_drg_shyrack"] = true,
	["npc_drg_vardosian_acklay"] = true,
	["npc_drg_wampa"] = true,
	["sb_everfall_b1"] = true,
	["sb_everfall_b1_desert"] = true,
	["sb_everfall_b1_forest"] = true,
	["sb_everfall_b1_security"] = true,
	["sb_everfall_b1_snow"] = true,
	["sb_everfall_b1_tanker"] = true,
	["sb_everfall_b1_commander"] = true,
	["sb_everfall_b1_jet"] = true,
	["sb_everfall_b1_marine"] = true,
	["sb_everfall_b1_marine_e5"] = true,
	["sb_everfall_b1_sniper"] = true,
	["sb_everfall_bx"] = true,
	["sb_everfall_bx_sniper"] = true,
	["sb_everfall_droideka"] = true,
	["sb_everfall_dwarfspiderdroid"] = true,
	["sb_everfall_oom"] = true,
	["sb_everfall_oom_ranger"] = true,
	["sb_everfall_oom_security"] = true,
	["sb_everfall_sbd"] = true,
	["sb_everfall_sbd_av"] = true,
	["sb_everfall_sbd_ranger"] = true,
	["sb_everfall_sbd_turret"] = true,
	["sb_everfall_b1s"] = true,
	["sb_everfall_b1_training"] = true,
	["sb_everfall_bx_training"] = true,
	["sb_everfall_b1_marine_training"] = true,
	["sb_everfall_sbd_reinforced"] = true,
	["sb_everfall_sbd_reinforced_no_move"] = true,
	["sb_everfall_tridroid"] = true,
	["sb_everfall_tridroid_no_move"] = true,
	["sb_everfall_b1_no_move"] = true,
	["sb_everfall_b1_desert_no_move"] = true,
	["sb_everfall_b1_forest_no_move"] = true,
	["sb_everfall_b1_security_no_move"] = true,
	["sb_everfall_b1_snow_no_move"] = true,
	["sb_everfall_b1_tanker_no_move"] = true,
	["sb_everfall_b1_commander_no_move"] = true,
	["sb_everfall_b1_jet_no_move"] = true,
	["sb_everfall_b1_marine_no_move"] = true,
	["sb_everfall_b1_marine_e5_no_move"] = true,
	["sb_everfall_b1_sniper_no_move"] = true,
	["sb_everfall_bx_no_move"] = true,
	["sb_everfall_bx_sniper_no_move"] = true,
	["sb_everfall_droideka_no_move"] = true,
	["sb_everfall_dwarfspiderdroid_no_move"] = true,
	["sb_everfall_oom_no_move"] = true,
	["sb_everfall_oom_ranger_no_move"] = true,
	["sb_everfall_oom_security_no_move"] = true,
	["sb_everfall_sbd_no_move"] = true,
	["sb_everfall_sbd_av_no_move"] = true,
	["sb_everfall_sbd_ranger_no_move"] = true,
	["sb_everfall_sbd_turret_no_move"] = true,
	["npc_summe_b1"] = true,
	["npc_summe_b1_heavy"] = true,
	["npc_summe_aqua"] = true,
	["npc_summe_b1_sniper"] = true,
	["npc_summe_b2"] = true,
	["npc_summe_b2_jetpack"] = true,
	["npc_summe_bx"] = true,
}

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 1, "Deviant_TurretOwner")
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
