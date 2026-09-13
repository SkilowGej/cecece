local un_models = {"models/sup/vrpm/trp/trp.mdl", "models/sup/vrpm/1/trp/trp.mdl", "models/sup/vrpm/1/sgt/sgt.mdl", "models/sup/vrpm/1/ofc/ofc.mdl", "models/sup/vrpm/trp/trp.mdl", "models/sup/vrpm/eng/eng.mdl", "models/sup/vrpm/med/med.mdl", "models/sup/vrpm/para/para.mdl", "models/sup/vrpm/pil/pil.mdl", "models/sup/vrpm/arf/arf.mdl", "models/sup/vrpm/support/support.mdl", "models/sup/vrpm/1/hvy/hvy.mdl", "models/sup/vrpm/1/desant/desant.mdl", "models/sup/vrpm/1/support/support.mdl", "models/sup/vrpm/1/eng/eng.mdl", "models/sup/vrpm/1/driver/driver.mdl"}
local l501_models = {"models/sup/vrpm/501/trp/trp.mdl", "models/sup/vrpm/501/sgt/sgt.mdl", "models/sup/vrpm/501/ofc/ofc.mdl", "models/sup/vrpm/501/support/support.mdl", "models/sup/vrpm/501/recon/recon.mdl", "models/sup/vrpm/501/hvy/hvy.mdl", "models/sup/vrpm/501/eng/eng.mdl", "models/sup/vrpm/501/driver/driver.mdl", "models/sup/vrpm/501/desant/desant.mdl", "models/sup/vrpm/501/arf/arf.mdl"}
local p88th_models = {"models/reizer_models/clones/88th_p2/88th_trp/88th_trp.mdl","models/reizer_models/clones/88th_p2/88th_aa_trp/88th_aa_trp.mdl", "models/reizer_models/clones/88th_p2/88th_pilots/88th_pilot_01a.mdl", "models/reizer_models/clones/88th_p2/88th_pilots/88th_pilot_01b.mdl", "models/reizer_models/clones/88th_p2/88th_guards_cpt/88th_guards_cpt.mdl ", "models/reizer_models/clones/88th_p2/88th_guards_trp/88th_guards_trp.mdl", "models/reizer_models/clones/88th_p2/88th_dakk/88th_dakk.mdl", "models/reizer_models/clones/88th_p2/88th_para_trp/88th_para_trp.mdl","models/reizer_models/clones/88th_p2/88th_jet_cpt/88th_jet_cpt.mdl", "models/reizer_models/clones/88th_p2/88th_medic/88th_medic.mdl","models/reizer_models/clones/88th_p2/88th_guards_trp/88th_guards_trp.mdl", "models/reizer_models/clones/88th_p2/88th_heavy/88th_heavy.mdl","models/reizer_models/clones/88th_p2/88th_heavy/88th_heavy.mdl", "models/reizer_models/clones/88th_p2/88th_eod_custom_01/88th_eod_custom_01.mdl","models/reizer_models/clones/88th_p2/88th_eod_cmd/88th_eod_cmd.mdl","models/reizer_models/clones/88th_p2/88th_eod_trp/88th_eod_trp.mdl", "models/reizer_models/clones/88th_p2/88th_arf/88th_arf.mdl","models/reizer_models/clones/88th_p2/88th_arf/88th_arf_camo3.mdl","models/reizer_models/clones/88th_p2/88th_arf/88th_arf_camo2.mdl","models/reizer_models/clones/88th_p2/88th_arf/88th_arf_camo1.mdl", "models/reizer_models/clones/88th_p2/88th_specops/88th_specops1.mdl","models/reizer_models/clones/88th_p2/88th_specops/88th_specops2.mdl","models/reizer_models/clones/88th_p2/88th_specops/88th_specops3.mdl", "models/reizer_models/clones/88th_p2/88th_arc_specops1/88th_arc_specops1.mdl","models/reizer_models/clones/88th_p2/88th_arc_arf/88th_arc_arf.mdl","models/reizer_models/clones/88th_p2/88th_arc_barc/88th_arc_barc.mdl","models/reizer_models/clones/88th_p2/88th_arc_freedom/88th_arc_freedom.mdl","models/reizer_models/clones/88th_p2/88th_arc/88th_arc.mdl", "models/reizer_models/clones/88th_p2/88th_cpt2/88th_cpt2.mdl","models/reizer_models/clones/88th_p2/88th_reizer/88th_reizer.mdl","models/reizer_models/clones/88th_p2/88th_cpt/88th_cpt.mdl","models/reizer_models/clones/88th_p2/88th_cmd/88th_cmd.mdl","models/reizer_models/clones/88th_p2/88th_custom_01/88th_c_01.mdl"}
local l212_models = {"models/212th_trp/pm_212th_trp.mdl", "models/212th_arc/pm_212th_arc.mdl", "models/212th_co/pm_212th_co.mdl", "models/212th_gunner/pm_212th_gunner.mdl", "models/212th_cody/pm_212th_cody.mdl", "models/212th_medic/pm_212th_medic.mdl", "models/212th_nco/pm_212th_nco.mdl", "models/212th_pilot/pm_212th_pilot.mdl", "models/212th_xo/pm_212th_xo.mdl", "models/finch212_pltoff/pm_212_pltoff.mdl", "models/finch212_eod/pm_212_eod.mdl", "models/finch212_eodl/pm_212_eodl.mdl"}
local l104_models = {"models/sup/vrpm/104/trp/trp.mdl", "models/sup/vrpm/104/support/support.mdl", "models/sup/vrpm/104/sgt/sgt.mdl", "models/sup/vrpm/104/recon/recon.mdl", "models/sup/vrpm/104/ofc/ofc.mdl", "models/sup/vrpm/104/hvy/hvy.mdl", "models/sup/vrpm/104/hvy/hvy.mdl", "models/sup/vrpm/104/eng/eng.mdl", "models/sup/vrpm/104/driver/driver.mdl", "models/sup/vrpm/104/desant/desant.mdl", "models/sup/vrpm/104/dcmd/dcmd.mdl", "models/sup/vrpm/104/cmd/cmd.mdl", "models/sup/vrpm/104/arf/arf.mdl"}
local l327_models = {"models/327th_trp/pm_327th_trp.mdl", "models/327th_officer/pm_327th_officer.mdl", "models/327th_medic/pm_327th_medic.mdl", "models/327th_ktrooper/pm_327th_ktrooper.mdl", "models/327th_deviss/pm_327th_deviss.mdl", "models/327th_comms_k/pm_327th_commsk.mdl", "models/327th_comms_k/pm_327th_commsk.mdl", "models/327th_comms/pm_327th_comms.mdl", "models/327th_bly/pm_327th_bly.mdl", "models/327th_bly/pm_327th_bly.mdl", "models/327th_arf/pm_327th_arf.mdl", "models/327th_arc/pm_327th_arc.mdl", "models/327th_nco/pm_327th_nco.mdl", "models/327th_evo/pm_327th_evo.mdl"}
local lcg_models = {"models/cg_trp/pm_cg_trp.mdl", "models/cg_arc/pm_cg_arc.mdl", "models/cg_medic/pm_cg_medic.mdl", "models/cg_nco/pm_cg_nco.mdl", "models/cg_pilot/pm_cg_pilot.mdl", "models/cg_riot/pm_cg_riot.mdl", "models/cg_co/pm_cg_co.mdl", "models/cg_xo/pm_cg_xo.mdl"}
local l91_models = {"models/sup/vrpm/trp/trp.mdl", "models/sup/vrpm/support/support.mdl", "models/sup/vrpm/scout/scout.mdl", "models/sup/vrpm/ofc/ofc.mdl", "models/sup/vrpm/med/med.mdl", "models/sup/vrpm/para/para.mdl", "models/sup/vrpm/eng/eng.mdl", "models/sup/vrpm/arf/arf.mdl", "models/sup/vrpm/pil/pil.mdl", "models/navy/gnavycrewman.mdl"}
local l15_models = {"models/sup/vrpm/trp/trp15th.mdl", "models/sup/vrpm/ofc/ofc15th.mdl", "models/sup/vrpm/sgt/sgt15th.mdl"}
local l8_models = {"models/sup/vrpm/8/trp/trp.mdl", "models/sup/vrpm/8/sgt/sgt.mdl", "models/sup/vrpm/8/ofc/ofc.mdl", "models/sup/vrpm/8/hound/hound.mdl", "models/sup/vrpm/8/arf/arf.mdl", "models/sup/vrpm/8/cmd/cmd.mdl", "models/sup/vrpm/8/driver/driver.mdl", "models/sup/vrpm/8/hvy/hvy.mdl", "models/sup/vrpm/8/recon/recon.mdl", "models/sup/vrpm/8/support/support.mdl", "models/sup/vrpm/8/eng/eng.mdl", "models/sup/vrpm/8/thire/thire.mdl", "models/navy/gnavyofficer.mdl"}
local arf_models = {"models/sup/vrpm/trp/trp.mdl", "models/sup/vrpm/support/support.mdl", "models/sup/vrpm/scout/scout.mdl", "models/sup/vrpm/ofc/ofc.mdl", "models/sup/vrpm/med/med.mdl", "models/sup/vrpm/assault/assault.mdl", "models/sup/vrpm/para/para.mdl", "models/sup/vrpm/eng/eng.mdl", "models/sup/vrpm/arf/arf.mdl", "models/sup/vrpm/pil/pil.mdl", "models/navy/gnavycrewman.mdl", "models/sup/vrpm/arf/cmd/cmd.mdl", "models/sup/vrpm/arf/dcmd/dcmd.mdl", "models/sup/vrpm/arf/ofc/ofc.mdl", "models/sup/vrpm/arf/pvt/pvt.mdl", "models/sup/vrpm/arf/sgt/sgt.mdl", "models/sup/vrpm/arf/arf.mdl"}
local arf2_models = {"models/sup/vrpm/trp/trp.mdl", "models/sup/vrpm/support/support.mdl", "models/sup/vrpm/scout/scout.mdl", "models/sup/vrpm/ofc/ofc.mdl", "models/sup/vrpm/med/med.mdl", "models/sup/vrpm/assault/assault.mdl", "models/sup/vrpm/para/para.mdl", "models/sup/vrpm/eng/eng.mdl", "models/sup/vrpm/arf/arf.mdl", "models/sup/vrpm/pil/pil.mdl", "models/navy/gnavycrewman.mdl"}
local admin_models = {"models/player/valley/lgn/pit_droid/pit_droid.mdl"}
local rookies_models = {"models/sup/vrpm/trp/trp.mdl"}
local rc_models = {"models/aussiwozzi/cgi/commando/rc_boss.mdl", "models/aussiwozzi/cgi/commando/rc_fixer.mdl", "models/aussiwozzi/cgi/commando/rc_scorch.mdl", "models/aussiwozzi/cgi/commando/rc_sev.mdl", "models/aussiwozzi/cgi/commando/rc_aquila_batnor.mdl", "models/aussiwozzi/cgi/commando/rc_aquila_cabur.mdl", "models/aussiwozzi/cgi/commando/rc_aquila_cyarika.mdl", "models/aussiwozzi/cgi/commando/rc_aquila_monarch.mdl", "models/aussiwozzi/cgi/commando/rc_aquila_monarch.mdl", "models/aussiwozzi/cgi/commando/rc_corr.mdl", "models/aussiwozzi/cgi/commando/rc_darman.mdl", "models/aussiwozzi/cgi/commando/rc_fi.mdl", "models/aussiwozzi/cgi/commando/rc_dikut.mdl", "models/aussiwozzi/cgi/commando/rc_fisher.mdl", "models/aussiwozzi/cgi/commando/rc_foxtrot_demo.mdl", "models/aussiwozzi/cgi/commando/rc_foxtrot_sniper.mdl", "models/aussiwozzi/cgi/commando/rc_foxtrot_tech.mdl", "models/aussiwozzi/cgi/commando/rc_gregor.mdl", "models/aussiwozzi/cgi/commando/rc_hope_demo.mdl", "models/aussiwozzi/cgi/commando/rc_hope_leader.mdl", "models/aussiwozzi/cgi/commando/rc_hope_sniper.mdl", "models/aussiwozzi/cgi/commando/rc_hope_tech.mdl", "models/aussiwozzi/cgi/commando/rc_ion_climber.mdl", "models/aussiwozzi/cgi/commando/rc_ion_ras.mdl", "models/aussiwozzi/cgi/commando/rc_ion_sniper.mdl", "models/aussiwozzi/cgi/commando/rc_ion_trace.mdl", "models/aussiwozzi/cgi/commando/rc_niner.mdl", "models/aussiwozzi/cgi/commando/rc_plain.mdl", "models/aussiwozzi/cgi/commando/rc_sarge.mdl", "models/aussiwozzi/cgi/commando/rc_tyto.mdl", "models/aussiwozzi/cgi/commando/rc_yayax_cov.mdl", "models/aussiwozzi/cgi/commando/rc_yayax_dev.mdl", "models/aussiwozzi/cgi/commando/rc_yayax_jind.mdl", "models/aussiwozzi/cgi/commando/rc_yayax_yover.mdl", "models/aussiwozzi/cgi/commando/rc_zag.mdl", "models/aussiwozzi/cgi/commando/rc_plain.mdl", "models/aussiwozzi/cgi/commando/rc_snow.mdl", "models/aussiwozzi/cgi/commando/rc_forest.mdl", "models/aussiwozzi/cgi/commando/rc_desert.mdl"}
local arc_models = {"models/sup/vrpm/arc/arc.mdl", "models/sup/vrpm/arc/cmd/cmd.mdl", "models/sup/vrpm/arc/cpt/cpt.mdl", "models/sup/vrpm/arc/lt/lt.mdl", "models/sup/vrpm/arc/sgt/sgt.mdl", "models/sup/vrpm/arc/neblitz/neblitz.mdl", "models/t_tcw_gar_alpha_wa/t_tcw_gar_alpha_wa.mdl", "models/t_tcw_gar_alpha_wa_cmd/t_tcw_gar_alpha_wa_cmd.mdl", "models/t_tcw_gar_alpha_wa_cpt/t_tcw_gar_alpha_wa_cpt.mdl", "models/t_tcw_gar_alpha_wa_lt/t_tcw_gar_alpha_wa_lt.mdl", "models/sup/vrpm/arc/bazar/bazar.mdl", "models/sup/vrpm/arc/falke/falke.mdl"}
local arcpripis_models = {"models/sup/vrpm/8/arc/arc.mdl", "models/sup/vrpm/1/arc/arc.mdl", "models/sup/vrpm/49/arc/arc.mdl", "models/sup/vrpm/501/arc/arc.mdl", "models/sup/vrpm/327/arc/arc.mdl", "models/sup/vrpm/212/arc/arc.mdl", "models/sup/vrpm/104/arc/arc.mdl", "models/sup/vrpm/arc/arc.mdl", "models/sup/vrpm/kyramud/bastard/bastard.mdl", "models/sup/vrpm/kyramud/pangolin/pangolin.mdl", "models/sup/vrpm/kyramud/snake/snake.mdl", "models/sup/vrpm/kyramud/tusk/tusk.mdl", "models/sup/vrpm/kyramud/wouly/wouly.mdl", "models/sup/vrpm/zero/bellingham/bellingham.mdl", "models/sup/vrpm/zero/diddy/diddy.mdl", "models/sup/vrpm/zero/espada/espada.mdl", "models/sup/vrpm/zero/graham/graham.mdl", "models/sup/vrpm/zero/hawkok/hawkok.mdl", "models/sup/vrpm/zero/xorja/xorja.mdl", "models/sup/vrpm/212/cody/cody.mdl"}
local astro_models = {"models/ace/sw/r2.mdl", "models/ace/sw/r4.mdl", "models/ace/sw/r5.mdl", "models/player/valley/lgn/protocal_droid/protocal_droid.mdl", "models/player/valley/lgn/death_star/death_star.mdl", "models/player/valley/lgn/shop_keeper/shop_keeper.mdl"}
local jedi1_models = {"models/jazzmcfly/jka/younglings/jka_young_shak.mdl", "models/jazzmcfly/jka/younglings/jka_young_male.mdl", "models/jazzmcfly/jka/younglings/jka_young_female.mdl", "models/jazzmcfly/jka/younglings/jka_young_anikan.mdl"}
local jedi_models = {"models/player/jesusstar/jdun/jdun.mdl", "models/epangelmatikes/templeguard/temple_guard_opt.mdl", "models/player/swtor/arsenic/topher/male_scion_v2.mdl", "models/fisher/jedi/junko/junko.mdl", "models/player/swtor/arsenic/frost/ivosok.mdl", "models/player/imagundi/eyla_jedi_master/eyla_jedi_master.mdl", "models/nullia_by_konfetka/nullia.mdl", "models/fisher/jedi/oga/oga.mdl", "models/fisher/jedi/nimrod/nimrod.mdl", "models/evie/jedi/ahri_evie.mdl", "models/players/malacore/swtor_master_orgus_din.mdl", "models/player/swtor/arsenic/wildocity/wildocity.mdl", "models/player/swtor/arsenic/talosstormcrown/talosstormcrown.mdl", "models/player/swtor/arsenic/slaeus/slaeus.mdl", "models/player/swtor/arsenic/scion/scion.mdl", "models/player/swtor/arsenic/rote/araceliags.mdl", "models/player/swtor/arsenic/revanitechampion/femalerevanitechampion.mdl", "models/player/swtor/arsenic/pavel/gonmu.mdl", "models/player/swtor/arsenic/onderonguardian/onderonguardian.mdl", "models/player/swtor/arsenic/nemesis/nemesistest.mdl", "models/player/swtor/arsenic/miles/miles_01.mdl", "models/player/swtor/arsenic/lucas/zengal.mdl", "models/player/swtor/arsenic/lag/ichigo.mdl", "models/player/swtor/arsenic/kreia/kreia.mdl", "models/player/swtor/arsenic/kopavi/kopavi.mdl", "models/player/swtor/arsenic/jokal/jokal.mdl", "models/player/swtor/arsenic/jaffa/jaffa.mdl", "models/player/swtor/arsenic/hyperion/qyvana.mdl", "models/player/swtor/arsenic/gaz/asharazavros.mdl", "models/player/swtor/arsenic/gadol/jedigado.mdl", "models/player/swtor/arsenic/fearless/caladium.mdl", "models/player/swtor/arsenic/exiled/exiled.mdl", "models/player/swtor/arsenic/drakzor/croc2.mdl", "models/player/swtor/arsenic/drakzor/croc.mdl", "models/player/swtor/arsenic/crazy/thuln.mdl", "models/player/swtor/arsenic/coyote/ezekiel.mdl", "models/player/swtor/arsenic/bones/bones01.mdl", "models/player/swtor/arsenic/beluga/beluga.mdl", "models/player/swtor/arsenic/ashteel/ashteel.mdl", "models/player/swtor/arsenic/ashley/ashley.mdl", "models/player/kyle/slater.mdl", "models/player/jedi/zabrak.mdl", "models/player/jedi/umbaran.mdl", "models/player/jedi/twilek2.mdl", "models/player/jedi/twilek.mdl", "models/player/jedi/trandoshan.mdl", "models/player/jedi/togruta.mdl", "models/player/jedi/rodian.mdl", "models/player/jedi/quarren.mdl", "models/player/jedi/pantoran.mdl", "models/player/jedi/nautolan.mdl", "models/player/jedi/human.mdl", "models/player/jedi/gungan.mdl", "models/player/jedi/gotal.mdl", "models/player/jedi/bith.mdl", "models/player/grady/starwars/zabrak_padawan.mdl", "models/player/grady/starwars/zabrak_master.mdl", "models/player/grady/starwars/rodian_padawan.mdl", "models/player/grady/starwars/rodian_master.mdl", "models/player/grady/starwars/mon_cala_padawan.mdl", "models/player/grady/starwars/mon_cala_master.mdl", "models/player/grady/starwars/keldor_padawan.mdl", "models/player/grady/starwars/keldor_master.mdl", "models/player/grady/starwars/duros_padawan.mdl", "models/player/grady/starwars/duros_master.mdl", "models/player/gary/fbn/starwars/jedi/buckala.mdl", "models/player/atlas/starwars/atlas.mdl", "models/player/aikaya/yorkt/yorkt.mdl", "models/morganicism/swtor/morganis/morganis.mdl", "models/jazzmcfly/jka/jtg/jtg.mdl", "models/jajoff/sw/toxin_robes.mdl", "models/jajoff/sw/toxin_1.mdl", "models/jajoff/sw/eternalscout.mdl", "models/jajoff/sw/andur.mdl", "models/gonzo/pgninspectors/jediinspector/jediinspector.mdl", "models/gonzo/jedikoreanchicken/jedikoreanchicken.mdl", "models/gonzo/jedihoodmask/jedihoodmask.mdl", "models/gonzo/greyjediguard/greyjediguard.mdl", "models/gonzo/battlelordsskins/white/whitebattlelord3.mdl", "models/gonzo/battlelordsskins/white/whitebattlelord2.mdl", "models/gonzo/battlelordsskins/red/redbattlelord3.mdl", "models/gonzo/battlelordsskins/red/redbattlelord2.mdl", "models/gonzo/battlelordsskins/red/redbattlelord1.mdl", "models/gonzo/battlelordsskins/purple/purplebattlelord3.mdl", "models/gonzo/battlelordsskins/purple/purplebattlelord2.mdl", "models/gonzo/battlelordsskins/purple/purplebattlelord1.mdl", "models/gonzo/battlelordsskins/green/greenbattlelord3.mdl", "models/gonzo/battlelordsskins/green/greenbattlelord2.mdl", "models/gonzo/battlelordsskins/green/greenbattlelord1.mdl", "models/gonzo/battlelordsskins/blue/bluebattlelord3.mdl", "models/gonzo/battlelordsskins/blue/bluebattlelord2.mdl", "models/gonzo/battlelordsskins/red/redbattlelord1.mdl", "models/gonzo/battlelordsskins/purple/purplebattlelord3.mdl", "models/gonzo/battlelordsskins/purple/purplebattlelord2.mdl", "models/gonzo/battlelordsskins/purple/purplebattlelord1.mdl", "models/gonzo/battlelordsskins/green/greenbattlelord3.mdl", "models/gonzo/battlelordsskins/green/greenbattlelord2.mdl", "models/gonzo/battlelordsskins/green/greenbattlelord1.mdl", "models/gonzo/battlelordsskins/blue/bluebattlelord3.mdl", "models/gonzo/battlelordsskins/blue/bluebattlelord2.mdl", "models/gonzo/battlelordsskins/blue/bluebattlelord1.mdl", "models/exodus/green/custommodels/iratus.mdl", "models/cultist_kun/sw/coleman.mdl", "models/aikaya/swtor/female/naiela.mdl", "models/aikaya/swtor/female/leina.mdl", "models/aikaya/master/shoka.mdl", "models/fire/masterfox/masterfox.mdl", "models/jedigrey/jedigrey.mdl"}
local jedi_story = {"models/hannerz/cin_drallig.mdl", "models/huyang/huyang.mdl", "models/player/jedi/jo_casta_nu.mdl", "models/player/jedi/tiplee.mdl", "models/player/jedi/tiplar.mdl", "models/player/etain_pm/etain.mdl", "models/player/budds/jaro_tapal/jaro_tapal.mdl", "models/tfa/comm/pm_sw_anakin_skywalker.mdl", "models/tfa/comm/gg/pm_sw_luminara.mdl", "models/tfa/comm/gg/pm_sw_mundi.mdl", "models/player/generalkenobi/cgikenobi.mdl", "models/tfa/comm/gg/pm_sw_shaakti.mdl", "models/mace/mace.mdl", "models/player/plokoon/plokoon.mdl", "models/tfa/comm/gg/pm_sw_ahsoka_v1.mdl", "models/tfa/comm/gg/pm_sw_adigallia.mdl", "models/tfa/comm/gg/pm_sw_aayala.mdl", "models/tfa/comm/gg/pm_sw_barriss.mdl", "models/tfa/comm/gg/pm_sw_eeth_koth.mdl", "models/tfa/comm/gg/pm_sw_fisto.mdl", "models/tfa/comm/gg/pm_sw_imagundi.mdl", "models/tfa/comm/gg/pm_sw_luminara.mdl", "models/tfa/comm/gg/pm_sw_quinlanvos.mdl", "models/tfa/comm/gg/pm_sw_ahsoka_v2.mdl"}
local yoda_model = {"models/tfa/comm/gg/pm_sw_yoda.mdl"}
local jedi2_models = {"models/player/swtor/arsenic/zeus/zeus.mdl", "models/player/swtor/arsenic/topher/male_scion_v4.mdl", "models/evie/jedi/ahri_evie.mdl", "models/gonzo/battlelordsskins/white/whitebattlelord1.mdl"}
local jedi3_models = {"models/jajoff/sps/sw/sutherlands1.mdl", "models/player/swtor/arsenic/nook/nook.mdl", "models/models/burd/arcann.mdl"}
local jedi4_models = {"models/gonzo/jedihoodmask/jedihoodmask.mdl"}
local l49_models = {"models/sup/vrpm/49/trp/trp.mdl", "models/sup/vrpm/49/sgt/sgt.mdl", "models/sup/vrpm/49/ofc/ofc.mdl"}
local larf_models = {"models/sup/vrpm/arf/pvt/pvt.mdl", "models/sup/vrpm/arf/sgt/sgt.mdl", "models/sup/vrpm/arf/cmd/cmd.mdl", "models/sup/vrpm/arf/dcmd/dcmd.mdl", "models/sup/vrpm/arf/ofc/ofc.mdl", "models/sup/vrpm/arf/xanter/xanter.mdl"}
local larf2_models = {"models/sup/vrpm/8/arf/arf.mdl", "models/sup/vrpm/501/arf/arf.mdl", "models/sup/vrpm/327/arf/arf.mdl", "models/sup/vrpm/212/arf/arf.mdl", "models/sup/vrpm/104/arf/arf.mdl", "models/sup/vrpm/arf/arf.mdl", "models/sup/vrpm/1/arf/arf.mdl"}
local senator_models = {"models/galactic/pantoranciv/pantoranciv.mdl", "models/player/lgn/jar jar/jar_jar.mdl", "models/church/swtor/theronshan/cpt_theron_shan.mdl", "models/player/valley/lgn/bail_organa/bail_organa.mdl", "models/valley/lgn/cgi pack/padme/padme.mdl", "models/valley/lgn/cgi pack/naboo_ballroom/naboo_ballroom.mdl", "models/valley/lgn/cgi pack/mina_bonteri/mina_bonteri.mdl", "models/valley/lgn/cgi pack/lux_bonteri/lux_bonteri.mdl"}
local police_models = {"models/valley/lgn/cgi pack/onderon_guard/onderon_guard.mdl", "models/valley/lgn/cgi pack/mandalorian_secret_service/mandalorian_secret_service.mdl", "models/valley/lgn/cgi pack/blacksun_soldier/blacksun_soldier.mdl", "models/valley/lgn/cgi pack/battledroid/battledroid.mdl", "models/church/swtor/imperialdroid/cpt_imperialdroid.mdl"}
local wookie_models = {"models/grand/wookie.mdl", "models/grand/wookie_kwehs.mdl", "models/grand/wookie_wild.mdl"}
local citizen_models = {"models/valley/lgn/cgi pack/coruscant_underworld/coruscant_underworld.mdl","models/player/slave/twilek_slave_male.mdl", "models/player/slave/twilek_slave_female_dancer.mdl", "models/player/machine/twilek/twilek6.mdl", "models/player/machine/twilek/twilek5.mdl", "models/player/machine/twilek/twilek4.mdl", "models/player/machine/twilek/twilek3.mdl", "models/player/machine/twilek/twilek2.mdl", "models/player/machine/twilek/twilek1.mdl", "models/galactic/pantoranciv/pantoranciv.mdl", "models/eng_gen/pm_coruscant_eng_gen.mdl", "models/eng_fixer/pm_coruscant_eng_fixer.mdl", "models/eng_bio/pm_coruscant_eng_bio.mdl", "models/church/swtor/selonian/cpt_selonian.mdl"}
local mercenary_models = {"models/tobester/mando/bokatan_mando_pm.mdl", "models/tobester/mando/f_custom_mando_pm.mdl", "models/tobester/mando/f_dw_mando_pm.mdl", "models/tobester/mando/f_maul_mando_pm.mdl", "models/tobester/mando/garsaxon_mando_pm.mdl", "models/tobester/mando/m_custom_mando_pm.mdl", "models/tobester/mando/m_dw_mando_pm.mdl", "models/tobester/mando/m_maul_mando_pm.mdl", "models/tobester/mando/previzsla_mando_pm.mdl", "models/trando_bossk/pm_trando_bossk.mdl", "models/grealms/characters/cadbane/cadbane.mdl", "models/player/lgn/seripas suit/seripas suit.mdl", "models/player/lgn/boba phett p2/boba phett p2.mdl", "models/player/sample/jax/jax/jax.mdl", "models/player/sample/jax/jax/jax2.mdl", "models/player/valley/bobafettyoungsuit.mdl", "models/player/valley/pao.mdl", "models/valley/lgn/cgi pack/dengar/dengar.mdl", "models/valley/lgn/cgi pack/rako_hardeen/rako_hardeen.mdl", "models/galactic/brownbh/brownbh.mdl", "models/tobester/mando/bokatan_mando_pm.mdl", "models/tobester/mando/f_custom_mando_pm.mdl", "models/tobester/mando/f_dw_mando_pm.mdl", "models/tobester/mando/f_maul_mando_pm.mdl", "models/tobester/mando/garsaxon_mando_pm.mdl", "models/tobester/mando/m_custom_mando_pm.mdl", "models/tobester/mando/m_dw_mando_pm.mdl", "models/tobester/mando/previzsla_mando_pm.mdl", "models/tobester/mando/m_maul_mando_pm.mdl"}
local massif_model = {"models/mrpounder1/player/massif_armored.mdl"}
local l187_models = {"models/sup/vrpm/187/trp/trp.mdl", "models/sup/vrpm/187/sgt/sgt.mdl", "models/sup/vrpm/187/ofc/ofc.mdl"}
local lorecmd_models = {"models/navy/gnavykrennic.mdl", "models/navy/gnavyarmand.mdl", "models/navy/gnavytarkin.mdl", "models/navy/gnavydao.mdl", "models/navy/gnavykilian.mdl", "models/navy/gnavyarmand.mdl"}
local slk_models = {"models/sup/vrpm/1/trp/trp.mdl", "models/sup/vrpm/1/support/support.mdl", "models/sup/vrpm/1/sgt/sgt.mdl", "models/sup/vrpm/1/ofc/ofc.mdl", "models/sup/vrpm/1/hvy/hvy.mdl", "models/sup/vrpm/1/eng/eng.mdl", "models/sup/vrpm/1/driver/driver.mdl", "models/sup/vrpm/1/desant/desant.mdl", "models/sup/vrpm/1/arf/arf.mdl"}
local pilots_models = {"models/sup/vrpm/7/cplt/cplt.mdl", "models/sup/vrpm/7/hplt/hplt.mdl", "models/sup/vrpm/7/plt/plt.mdl", "models/sup/vrpm/7/rplt/rplt.mdl", "models/sup/vrpm/7/splt/splt.mdl"}

TEAM_CADET = re.util.addjob("Kadet", {
	Color = Color(73, 90, 138, 255),
	WorldModel = rookies_models,
	weapons = {"weapon_hands"},
	weaponcrate = {"vibrokinfe_base", "rust_syringe"},
	jobID = "cadet",
	max = 99,
	maxHealth = 100,
	maxArmor = 100,
	skins = {},
	Type = TYPE_ROOKIE,
	control = CONTROL_REPUBLIC,
})
TEAM_PILOTS = re.util.addjob("7. Eskadra", {
	Color = Color(73, 90, 138, 255),
	WorldModel = pilots_models,
	weapons = {"weapon_hands"},
	weaponcrate = {"vibrokinfe_base", "rust_syringe", "jet_exec", "masita_dual_dc17s", "masita_dc17s_red"},
	jobID = "pilots",
	max = 99,
	maxHealth = 150,
	maxArmor = 150,
	skins = {},
	Type = TYPE_CLONE,
	control = CONTROL_REPUBLIC,
})

TEAM_PLUT88 = re.util.addjob("Pluton 88th", {
	Color = Color(73, 90, 138, 255),
	WorldModel = p88th_models,
	weapons = {"weapon_hands"},
	weaponcrate = {"vibrokinfe_base", "masita_dc15s"},
	jobID = "88th",
	max = 99,
	maxHealth = 150,
	maxArmor = 150,
	skins = {},
	Type = TYPE_CLONE,
	control = CONTROL_REPUBLIC,
	radio = 88.2,
	flashlight = true,
})

TEAM_PILOTS = re.util.addjob("501st Raven Squad", {
	Color = Color(73, 90, 138, 255),
	WorldModel = l49_models,
	weapons = {"weapon_hands"},
	weaponcrate = {"vibrokinfe_base", "jet_exec", "masita_dual_dc17s", "masita_nt242", "masita_dc19"},
	jobID = "91",
	max = 99,
	maxHealth = 250,
	maxArmor = 250,
	skins = {},
	Type = TYPE_CLONE,
	control = CONTROL_REPUBLIC,
})

TEAM_SLK = re.util.addjob("1st Division", {
	Color = Color(100, 107, 128),
	WorldModel = slk_models,
	weapons = {"weapon_hands"},
	weaponcrate = {"vibrokinfe_base", "masita_dc17ext", "masita_dc15a_heavy"},
	jobID = "slk",
	max = 99,
	maxHealth = 250,
	maxArmor = 250,
	skins = {},
	Type = TYPE_CLONE,
	control = CONTROL_REPUBLIC,
})

TEAM_MASIF = re.util.addjob("Massif", {
	Color = Color(73, 90, 138, 255),
	WorldModel = massif_model,
	weapons = {"weapon_hands", "weapon_drakamassif"},
	weaponcrate = {"vibrokinfe_base"},
	jobID = "masif",
	max = 99,
	maxHealth = 600,
	maxArmor = 50,
	skins = {},
	Type = TYPE_ROOKIE,
	control = CONTROL_REPUBLIC,
	radio = 50.1,
	PlayerLoadout = function(ply)
		ply:SetRunSpeed(310)
	end,
})

TEAM_187 = re.util.addjob("187th Legion", {
	Color = Color(73, 90, 138, 255),
	WorldModel = l187_models,
	weapons = {"weapon_hands"},
	weaponcrate = {"vibrokinfe_base", "masita_dc15s", "masita_dc17", "masita_repshield", "masita_sb2"},
	jobID = "187",
	max = 99,
	maxHealth = 150,
	maxArmor = 150,
	skins = {},
	Type = TYPE_CLONE,
	control = CONTROL_REPUBLIC,
    radio = 18.7,
})

TEAM_UN = re.util.addjob("Standard Clone Legion", {
	Color = Color(60, 118, 165),
	WorldModel = un_models, -- ????????? ??????.
	description = [[]],
	weapons = {"weapon_hands"},
	weaponcrate = {"vibrokinfe_base", "masita_dc15s", "masita_dc17"},
	jobID = "un",
	maxHealth = 200,
	maxArmor = 150,
	max = 99,
	Type = TYPE_CLONE,
	flashlight = true,
	control = CONTROL_REPUBLIC,
    radio = 1,
})

TEAM_212 = re.util.addjob("212th Battalion", {
	Color = Color(168, 74, 30),
	WorldModel = l212_models, -- ????????? ??????.
	description = [[]],
	weapons = {"weapon_hands"},
	weaponcrate = {"vibrokinfe_base", "masita_dc15s", "masita_dc17"},
	jobID = "212",
	maxHealth = 200,
	maxArmor = 150,
	max = 99,
	Type = TYPE_CLONE,
	flashlight = true,
	control = CONTROL_REPUBLIC,
    radio = 21.2,
})

TEAM_501 = re.util.addjob("501. Legion", {
	Color = Color(34, 94, 184),
	WorldModel = l501_models, -- ????????? ??????.
	description = [[]],
	weapons = {"weapon_hands"},
	weaponcrate = {"vibrokinfe_base", "masita_dc15a", "masita_dc17"},
	jobID = "501",
	maxHealth = 280,
	maxArmor = 280,
	max = 99,
	Type = TYPE_CLONE,
	flashlight = true,
	control = CONTROL_REPUBLIC,
    radio = 50.1,
})

TEAM_104 = re.util.addjob("104. Battalion", {
	Color = Color(65, 65, 65),
	WorldModel = l104_models, -- ????????? ??????.
	description = [[]],
	weapons = {"weapon_hands"},
	weaponcrate = {"vibrokinfe_base", "masita_dc15s", "masita_dc17", "fort_datapad", "weapon_lvsrepair", "defuser_bomb", "turret_placer", "masita_dp23"},
	jobID = "104",
	maxHealth = 175,
	maxArmor = 200,
	max = 99,
	Type = TYPE_CLONE,
	flashlight = true,
	control = CONTROL_REPUBLIC,
    radio = 10.4,
})

TEAM_327 = re.util.addjob("327. Battalion", {
	Color = Color(129, 89, 16),
	WorldModel = l327_models, -- ????????? ??????.
	description = [[]],
	weapons = {"weapon_hands"},
	weaponcrate = {"vibrokinfe_base", "masita_dc15s", "masita_dual_dc17"},
	jobID = "327",
	maxHealth = 175,
	maxArmor = 200,
	max = 99,
	Type = TYPE_CLONE,
	flashlight = true,
	control = CONTROL_REPUBLIC,
    radio = 32.7,
})

TEAM_CG = re.util.addjob("Gwardia Coruscant", {
	Color = Color(201, 33, 29),
	WorldModel = lcg_models, -- ????????? ??????.
	description = [[]],
	weapons = {"weapon_hands"},
	weaponcrate = {"vibrokinfe_base", "masita_dc15s", "masita_dual_dc17"},
	jobID = "CG",
	maxHealth = 175,
	maxArmor = 200,
	max = 99,
	Type = TYPE_CLONE,
	flashlight = true,
	control = CONTROL_REPUBLIC,
    radio = 42.6,
})

TEAM_15 = re.util.addjob("15. Battalion", {
	Color = Color(76, 121, 26),
	WorldModel = l15_models, -- ????????? ??????.
	description = [[]],
	weapons = {"weapon_hands"},
	weaponcrate = {"vibrokinfe_base", "masita_dc15s", "masita_dc17", "weapon_bactainjector", "weapon_bactanade", "weapon_defibrillator", "masita_sb2", "weapon_med_bandage", "rust_syringe"},
	jobID = "15",
	maxHealth = 175,
	maxArmor = 250,
	max = 99,
	Type = TYPE_CLONE,
	flashlight = true,
	control = CONTROL_REPUBLIC,
    radio = 15,
})

TEAM_8 = re.util.addjob("8. Guard Department", {
	Color = Color(146, 53, 53),
	WorldModel = l8_models, -- ????????? ??????.
	description = [[]],
	weapons = {"weapon_hands"},
	weaponcrate = {"vibrokinfe_base", "masita_dc15s", "masita_dc17", "arrest_baton", "unarrest_baton", "handcuffs", "masita_cgshield", "masita_dual_dc17ext", "masita_dc15s"},
	jobID = "8",
	maxHealth = 150,
	maxArmor = 175,
	max = 99,
	Type = TYPE_CLONE,
	flashlight = true,
	control = CONTROL_REPUBLIC,
    radio = 8,
})

TEAM_ARF = re.util.addjob("75. Department", {
	Color = Color(28, 73, 41),
	WorldModel = larf_models, -- ????????? ??????.
	description = [[]],
	weapons = {"weapon_hands"},
	weaponcrate = {"vibrokinfe_base", "masita_dc17", "masita_iqa11", "handcuffs", "arccw_btrs_41", "waypoint_designator", "weapon_rope_knife", "masita_dc15s"},
	jobID = "arf",
	maxHealth = 300,
	maxArmor = 250,
	max = 99,
	Type = TYPE_CLONE,
	flashlight = true,
	control = CONTROL_REPUBLIC,
    radio = 75,
        })

TEAM_ARF2 = re.util.addjob("ARF", {
	Color = Color(128, 128, 128),
	WorldModel = larf2_models, -- ????????? ??????.
	description = [[]],
	weapons = {"weapon_hands"},
	weaponcrate = {"vibrokinfe_base", "masita_dc17", "masita_iqa11", "handcuffs", "arccw_btrs_41", "waypoint_designator", "weapon_rope_knife"},
	jobID = "arf2",
	maxHealth = 300,
	maxArmor = 250,
	max = 99,
	Type = TYPE_CLONE,
	flashlight = true,
	control = CONTROL_REPUBLIC,
    radio = 25,
})

TEAM_ARC = re.util.addjob("24. Oddzial", {
	Color = Color(0, 80, 146),
	WorldModel = arc_models, -- ????????? ??????.
	description = [[]],
	weapons = {"weapon_hands"},
	weaponcrate = {"masita_westarm5", "masita_iqa11", "masita_dual_dc17s", "hook", "jet_exec", "weapon_squadshield_arm", "defuser_bomb", "handcuffs"},
	jobID = "arc",
	maxHealth = 400,
	maxArmor = 350,
	max = 99,
	Type = TYPE_CLONE,
	flashlight = true,
	control = CONTROL_REPUBLIC,
    radio = 24,
})


TEAM_COMMANDO = re.util.addjob("3. Oddzial", {
	Color = Color(129, 35, 35),
	WorldModel = rc_models,
	description = [[]],
	weapons = {"weapon_hands", "commando_knife"},
	weaponcrate = {"masita_dc15sa", "arccw_kraken_dc17m", "masita_dc17m_launcher", "m9k_suicide_bomb", "handcuffs", "weapon_defibrillator", "m9k_proxy_mine", "hook", "defuser_bomb", "armorkit"},
	jobID = "commando",
	maxHealth = 550,
	maxArmor = 375,
	max = 99,
	Type = TYPE_CLONE,
	flashlight = true,
	control = CONTROL_REPUBLIC,
    radio = 3,
})

-- TEAM_ARC = re.util.addjob("3-? ??????????? ????????", {
-- 	Color = Color(129, 35, 35),
-- 	WorldModel = arc_models,
-- 	description = [[]],
-- 	weapons = {"weapon_hands"},
-- 	weaponcrate = {"luna_weapons_westarm5", "masita_dc17_dual", "vibrokinfe_base", "hook", "weapon_shield_activator"},
-- 	jobID = "arc",
-- 	maxHealth = 650,
-- 	maxArmor = 650,
-- 	max = 99,
-- 	Type = TYPE_CLONE,
-- 	flashlight = true,
-- 	control = CONTROL_REPUBLIC,
-- })

TEAM_ASTROMECH = re.util.addjob("Droid", {
	Color = Color(42, 99, 145, 255),
	WorldModel = astro_models, -- ????????? ??????.
	description = [[]],
	weapons = {"weapon_hands", "r2d2", "flamethrower_t3m4", "shockarm_t3m4", "jet_exec", "fort_datapad", "weapon_lvsrepair"},
	weaponcrate = {""},
	jobID = "astromech",
	maxHealth = 600,
	maxArmor = 700,
	max = 99,
	Type = TYPE_RPDROID,
	flashlight = true,
	control = CONTROL_REPUBLIC,
})

TEAM_MERCENARY = re.util.addjob("Mercenary", {
	Color = Color(42, 99, 145, 255),
	WorldModel = mercenary_models, -- ????????? ??????.
	description = [[]],
	weapons = {"arccw_rskf_revolver"},
	weaponcrate = {"arccw_blaster_lrb11", "arccw_rskf_revolver", "arccw_dual_e5", "weapon_bactainjector", "rust_syringe"},
	jobID = "mercenary",
	maxHealth = 400,
	maxArmor = 400,
	max = 99,
	Type = TYPE_MERCENARY,
	flashlight = true,
	control = CONTROL_REPUBLIC,
})

-- TEAM_MANDALORIAN = re.util.addjob("??????????", {
-- 	Color = Color(54, 115, 49, 255),
-- 	WorldModel = {"models/tobester/mando/bokatan_mando_pm.mdl", "models/tobester/mando/f_custom_mando_pm.mdl", "models/tobester/mando/f_dw_mando_pm.mdl", "models/tobester/mando/f_maul_mando_pm.mdl", "models/tobester/mando/garsaxon_mando_pm.mdl", "models/tobester/mando/m_custom_mando_pm.mdl", "models/tobester/mando/m_dw_mando_pm.mdl", "models/tobester/mando/m_maul_mando_pm.mdl", "models/tobester/mando/previzsla_mando_pm.mdl",},
-- 	description = [[]],
-- 	weapons = {"weapon_hands"},
-- 	weaponcrate = {"arccw_rskf_revolver", "arccw_blaster_lrb11"},
-- 	jobID = "manda",
-- 	maxHealth = 400,
-- 	maxArmor = 250,
-- 	max = 99,
-- 	Type = TYPE_MERCENARY,
-- 	customCategory = "????????",
-- 	flashlight = true,
-- })

TEAM_SENATOR = re.util.addjob("Senator", {
	Color = Color(42, 99, 145, 255),
	WorldModel = senator_models, -- ????????? ??????.
	description = [[]],
	weapons = {"weapon_hands"},
	weaponcrate = {""},
	jobID = "senator",
	maxHealth = 200,
	maxArmor = 200,
	max = 99,
	Type = TYPE_CITIZEN,
	flashlight = true,
	control = CONTROL_REPUBLIC,
})

TEAM_LORECOMMANDER = re.util.addjob("Sector Command", {
	Color = Color(146, 40, 212, 255),
	WorldModel = lorecmd_models,
	description = [[]],
	weapons = {"weapon_hands", "weapon_physgun", "gmod_tool"},
	weaponcrate = {"vibrokinfe_base", "masita_dc15s", "masita_dc17"},
	jobID = "lorecommander",
	maxHealth = 10000,
	maxArmor = 10000,
	max = 99,
	Type = TYPE_FLEET,
	control = CONTROL_REPUBLIC,
	flashlight = true,
	notarget = true,
})

TEAM_OVERWATCH = re.util.addjob("Administrator", {
	Color = Color(143, 30, 53, 255),
	WorldModel = admin_models,
	description = [[]],
	weapons = {"weapon_hands", "weapon_physgun", "gmod_tool"},
	jobID = "admin",
	maxHealth = 9999,
	maxArmor = 9999,
	max = 99,
	Type = TYPE_ADMIN,
	flashlight = true,
	notarget = true,
	PlayerLoadout = function(ply)
		ply:SetModelScale(.5)
	end,
})

TEAM_JEDI = re.util.addjob("Storyline Jedi", {
	Color = Color(59, 77, 125, 255),
	WorldModel = jedi_story,
	description = [[]],
	weapons = {"weapon_hands"},
	jobID = "jedi",
	maxHealth = 1300,
	maxArmor = 1300,
	max = 99,
	Type = TYPE_JEDI,
	flashlight = true,
	customCategory = "Jedi Order",
	control = CONTROL_REPUBLIC,

})

TEAM_JEDI1 = re.util.addjob("Youngling", {
	Color = Color(59, 77, 125, 255),
	WorldModel = jedi1_models,
	description = [[]],
	weapons = {"weapon_hands"},
	jobID = "jedi1",
	maxHealth = 300,
	maxArmor = 350,
	max = 99,
	Type = TYPE_JEDI,
	flashlight = true,
	customCategory = "Jedi Order",
	control = CONTROL_REPUBLIC,
	PlayerLoadout = function(ply)
		ply:SetModelScale(.8)
	end,
})

TEAM_JEDI2 = re.util.addjob("Jedi Order", {
	Color = Color(59, 77, 125, 255),
	WorldModel = jedi_models,
	description = [[]],
	weapons = {"weapon_hands"},
	jobID = "jedi2",
	maxHealth = 1000,
	maxArmor = 700,
	max = 99,
	Type = TYPE_JEDI,
	flashlight = true,
	customCategory = "Jedi Order",
	control = CONTROL_REPUBLIC,

})

TEAM_JEDI3 = re.util.addjob("Master", {
	Color = Color(59, 77, 125, 255),
	WorldModel = jedi2_models,
	description = [[]],
	weapons = {"weapon_hands"},
	jobID = "jedi3",
	maxHealth = 1300,
	maxArmor = 1300,
	max = 99,
	Type = TYPE_JEDI,
	flashlight = true,
	customCategory = "Jedi Order",
	control = CONTROL_REPUBLIC,

})

TEAM_JEDI4 = re.util.addjob("Magister", {
	Color = Color(59, 77, 125, 255),
	WorldModel = jedi3_models,
	description = [[]],
	weapons = {"weapon_hands"},
	jobID = "jedi4",
	maxHealth = 1500,
	maxArmor = 1500,
	max = 99,
	Type = TYPE_JEDI,
	flashlight = true,
	customCategory = "Jedi Order",
	control = CONTROL_REPUBLIC,

})

TEAM_JEDI5 = re.util.addjob("Grand Master", {
	Color = Color(59, 77, 125, 255),
	WorldModel = jedi4_models,
	description = [[]],
	weapons = {"weapon_hands"},
	jobID = "jedi5",
	maxHealth = 2000,
	maxArmor = 2000,
	max = 99,
	Type = TYPE_JEDI,
	flashlight = true,
	customCategory = "Jedi Order",
	control = CONTROL_REPUBLIC,

})

TEAM_JEDIMED = re.util.addjob("Jedi - Healer", {
	Color = Color(59, 77, 125, 255),
	WorldModel = jedi_models,
	description = [[]],
	weapons = {"weapon_hands", "cc_buff_ressurection", "cc_buff_speed"},
	jobID = "jedimed",
	maxHealth = 1000,
	maxArmor = 700,
	max = 99,
	Type = TYPE_JEDI,
	flashlight = true,
	customCategory = "Jedi Order",
	control = CONTROL_REPUBLIC,
})

TEAM_JEDI7 = re.util.addjob("Yoda", {
	Color = Color(59, 77, 125, 255),
	WorldModel = yoda_model,
	description = [[]],
	weapons = {"weapon_hands"},
	jobID = "jedi7",
	maxHealth = 2000,
	maxArmor = 2000,
	max = 99,
	Type = TYPE_JEDI,
	flashlight = true,
	customCategory = "Jedi Order",
	control = CONTROL_REPUBLIC,
	PlayerLoadout = function(ply)
		ply:SetModelScale(.5)
	end,
})

TEAM_ARCspec = re.util.addjob("ARC", {
	Color = Color(0, 80, 146),
	WorldModel = arcpripis_models, -- ????????? ??????.
	description = [[]],
	weapons = {"weapon_hands"},
	weaponcrate = {"masita_westarm5", "masita_iqa11", "masita_dual_dc17s", "hook", "jet_exec", "weapon_squadshield_arm", "defuser_bomb", "handcuffs"},
	jobID = "arcspec",
	maxHealth = 400,
	maxArmor = 350,
	max = 99,
	Type = TYPE_CLONE,
	flashlight = true,
	control = CONTROL_REPUBLIC,
})

TEAM_CITIZEN = re.util.addjob("Event � Citizen", {
	Color = Color(43, 92, 54, 255),
	WorldModel = citizen_models,
	description = [[]],
	weapons = {"weapon_hands"},
	jobID = "citizen",
	max = 99,
	admin = 0,
	maxHealth = 200,
	maxArmor = 0,
	Type = TYPE_CITIZEN,
})

TEAM_POLICE = re.util.addjob("Event � Police", {
	Color = Color(47, 115, 79, 255),
	WorldModel = police_models,
	description = [[]],
	weapons = {"weapon_hands", "luna_weapons_stw48"},
	jobID = "police",
	max = 99,
	maxHealth = 300,
	maxArmor = 350,
	Type = TYPE_CITIZEN,
})

TEAM_CIS1 = re.util.addjob("CIS � Droid B1", {
	Color = Color(41, 55, 94, 255),
	WorldModel = {"models/jajoff/sps/cgidroid/jlm/droidb1.mdl",},
	description = [[]],
	weapons = {"weapon_hands", "arccw_e5"},
	jobID = "cis1",
	max = 99,
	notarget = true,
	maxHealth = 350,
	maxArmor = 250,
	flashlight = true,
	Type = TYPE_DROID,
	customCategory = "Separatists",
	control = CONTROL_CIS,
    radio = 96,
})

TEAM_CIS2 = re.util.addjob("CIS � Droid B1 Grappler", {
	Color = Color(41, 55, 94, 255),
	WorldModel = {"models/jajoff/sps/cgidroid/jlm/droidb1_grappler.mdl"},
	description = [[]],
	weapons = {"weapon_hands", "arccw_sg6", "weapon_bactainjector", "weapon_defibrillator"},
	jobID = "cis2",
	max = 99,
	notarget = true,
	maxHealth = 300,
	maxArmor = 250,
	flashlight = true,
	Type = TYPE_DROID,
	customCategory = "Separatists",
	control = CONTROL_CIS,
    radio = 96,
})

TEAM_CISTYAZ = re.util.addjob("CIS � Droid B1 Heavy", {
	Color = Color(41, 55, 94, 255),
	WorldModel = {"models/jajoff/sps/cgidroid/jlm/droidb1.mdl"},
	description = [[]],
	weapons = {"weapon_hands", "arccw_e5c"},
	jobID = "cistyaz",
	max = 99,
	notarget = true,
	maxHealth = 475,
	maxArmor = 350,
	flashlight = true,
	Type = TYPE_DROID,
	customCategory = "Separatists",
	control = CONTROL_CIS,
    radio = 96,
})

TEAM_CIS3 = re.util.addjob("CIS � Droid BX", {
	Color = Color(41, 55, 94, 255),
	WorldModel = {"models/jajoff/sps/cgidroid/jlm/droidbx.mdl",},
	description = [[]],
	weapons = {"weapon_hands", "arccw_e5"},
	jobID = "cis3",
	max = 99,
	notarget = true,
	maxHealth = 600,
	maxArmor = 450,
	flashlight = true,
	Type = TYPE_DROID,
	customCategory = "Separatists",
	control = CONTROL_CIS,
    radio = 96,
})

TEAM_CIS4 = re.util.addjob("CIS � Droid BXs", {
	Color = Color(41, 55, 94, 255),
	WorldModel = {"models/jajoff/sps/cgidroid/jlm/droidstalker.mdl",},
	description = [[]],
	weapons = {"weapon_hands", "arccw_z4", "arccw_e5c"},
	jobID = "cis4",
	max = 99,
	notarget = true,
	maxHealth = 650,
	maxArmor = 400,
	flashlight = true,
	Type = TYPE_DROID,
	customCategory = "Separatists",
	control = CONTROL_CIS,
    radio = 96,
})

TEAM_CIS5 = re.util.addjob("CIS � Droid B2", {
	Color = Color(41, 55, 94, 255),
	WorldModel = {"models/jajoff/sps/cgidroid/jlm/sbdroid.mdl",},
	description = [[]],
	weapons = {"weapon_hands", "arccw_b2_blaster"},
	jobID = "cis5",
	max = 99,
	notarget = true,
	maxHealth = 1500,
	maxArmor = 1000,
	flashlight = true,
	Type = TYPE_DROID,
	customCategory = "Separatists",
	control = CONTROL_CIS,
	PlayerLoadout = function(ply)
		ply:SetModelScale(1.3)
	end,
    radio = 96,
})

TEAM_CIS7 = re.util.addjob("CIS � Droid B2e", {
	Color = Color(41, 55, 94, 255),
	WorldModel = {"models/jajoff/sps/cgidroid/jlm/sbdroid_grapple.mdl",},
	description = [[]],
	weapons = {"weapon_hands", "arccw_sg6", "arccw_e5s", "arccw_b2_blaster"},
	jobID = "cis7",
	max = 99,
	notarget = true,
	maxHealth = 1500,
	maxArmor = 800,
	flashlight = true,
	Type = TYPE_DROID,
	customCategory = "Separatists",
	control = CONTROL_CIS,
    radio = 96,
})

TEAM_CIS8 = re.util.addjob("CIS � Commander", {
	Color = Color(41, 55, 94, 255),
	WorldModel = {"models/super_tactical_kalani/pm_droid_tactical_kalani.mdl"},
	description = [[]],
	weapons = {"weapon_hands", "arccw_e5"},
	jobID = "cis8",
	max = 99,
	notarget = true,
	maxHealth = 1300,
	maxArmor = 500,
	Type = TYPE_DROID,
	customCategory = "Separatists",
	flashlight = true,
	control = CONTROL_CIS,
	PlayerSpawn = function(ply) end,
    radio = 96,
})

TEAM_CIS9 = re.util.addjob("CIS � Geonosians", {
	Color = Color(41, 55, 94, 255),
	WorldModel = {"models/galactic/geonosian1/geonosian1.mdl", "models/player/valley/lgn/geonosian/geonosian.mdl"},
	description = [[]],
	weapons = {"weapon_hands", "arccw_e5"},
	jobID = "cis9",
	max = 99,
	notarget = true,
	maxHealth = 400,
	maxArmor = 300,
	Type = TYPE_DROID,
	customCategory = "Separatists",
	flashlight = true,
	control = CONTROL_CIS,
	PlayerSpawn = function(ply) end,
    radio = 96,
})

TEAM_CIS10 = re.util.addjob("CIS � Zygerrians", {
	Color = Color(41, 55, 94, 255),
	WorldModel = {"models/player/zygerrian/zygerrian_cpt.mdl", "models/player/zygerrian/zygerrian_pitboss.mdl", "models/player/zygerrian/zygerrian_slave_lord.mdl", "models/player/zygerrian/zygerrian_soldier.mdl"},
	description = [[]],
	weapons = {"weapon_hands", "arccw_e5"},
	jobID = "cis10",
	max = 99,
	notarget = true,
	maxHealth = 350,
	maxArmor = 200,
	Type = TYPE_DROID,
	customCategory = "Separatists",
	flashlight = true,
	control = CONTROL_CIS,
	PlayerSpawn = function(ply) end,
    radio = 96,
})

TEAM_CIS11 = re.util.addjob("CIS � Trandoshans", {
	Color = Color(41, 55, 94, 255),
	WorldModel = {"models/clutch/pm_trandoshan_clutch.mdl", "models/tracker/pm_trandoshan_tracker.mdl", "models/trapper/pm_trandoshan_trapper.mdl", "models/dar/pm_trandoshan_dar.mdl", "models/hunter/pm_trandoshan_hunter.mdl", "models/lotaren/pm_trandoshan_lotaren.mdl", "models/garnac/pm_trandoshan_garnac.mdl", "models/sniper/pm_trandoshan_sniper.mdl", "models/sochek/pm_trandoshan_sochek.mdl"},
	description = [[]],
	weapons = {"weapon_hands", "arccw_e5"},
	jobID = "cis11",
	max = 99,
	notarget = true,
	maxHealth = 350,
	maxArmor = 200,
	Type = TYPE_DROID,
	customCategory = "Separatists",
	flashlight = true,
	control = CONTROL_CIS,
	PlayerSpawn = function(ply) end,
    radio = 96,
})

TEAM_CIS12 = re.util.addjob("CIS � Vikuaians", {
	Color = Color(41, 55, 94, 255),
	WorldModel = {"models/player/ohanak_gang/pm_pirate_craggy.mdl", "models/player/ohanak_gang/pm_pirate_grunt.mdl", "models/player/ohanak_gang/pm_pirate_gwarm.mdl", "models/player/ohanak_gang/pm_pirate_jiro.mdl", "models/player/ohanak_gang/pm_pirate_marauder.mdl", "models/player/ohanak_gang/pm_pirate_soldier.mdl", "models/player/ohanak_gang/pm_pirate_turk.mdl"},
	description = [[]],
	weapons = {"weapon_hands", "arccw_e5"},
	jobID = "cis12",
	max = 99,
	notarget = true,
	maxHealth = 350,
	maxArmor = 200,
	Type = TYPE_DROID,
	customCategory = "Separatists",
	flashlight = true,
	control = CONTROL_CIS,
	PlayerSpawn = function(ply) end,
    radio = 96,
})

TEAM_CIS13 = re.util.addjob("CIS � Leaders", {
	Color = Color(41, 55, 94, 255),
	WorldModel = {"models/tfa/comm/gg/pm_sw_grievous.mdl", "models/tfa/comm/gg/pm_sw_grievous_nocloak.mdl", "models/tfa/comm/gg/pm_sw_dooku.mdl", "models/maul.mdl", "models/savage.mdl", "models/jellik/asajj/asajj.mdl", "models/player/garith/golden/durge.mdl", "models/grealms/characters/darkjedi/darkjedi.mdl", "models/church/swtor/kage/cpt_kage.mdl", "models/church/ventress_season4.mdl"},
	description = [[]],
	weapons = {"weapon_hands", "arccw_e5"},
	jobID = "cis13",
	max = 99,
	notarget = true,
	maxHealth = 3000,
	maxArmor = 1500,
	Type = TYPE_DROID,
	customCategory = "Separatists",
	flashlight = true,
	control = CONTROL_CIS,
	PlayerSpawn = function(ply) end,
    radio = 96,
})

DEFAULT_TEAM = TEAM_CADET

-- KEK, MUGU - PIDARAS
if SERVER then
	re.jobs_by_id = {}

	for k, v in pairs(re.jobs) do
		re.jobs_by_id[v.jobID] = v
	end
end