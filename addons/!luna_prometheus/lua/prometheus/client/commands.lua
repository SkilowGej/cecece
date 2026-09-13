--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--[[
    INFORMATION SOURCES:
    (Those are the most useful lol)
    - https://steamcommunity.com/sharedfiles/filedetails/?id=2864788404
    - https://steamcommunity.com/sharedfiles/filedetails/?id=1906053957
    - https://gist.github.com/mastercoms/44be52f6c070de1a7c2e8a0430e0b257
    - https://forum.csmania.ru/viewtopic.php?t=1007
    - https://steamcommunity.com/sharedfiles/filedetails/?id=1789347135
    - https://steamcommunity.com/sharedfiles/filedetails/?id=2033799294 (good)
    - https://docs.mastercomfig.com/9.9.1/fr/tf2/misconceptions/#bad-cvars
    - https://docs.mastercomfig.com/9.9.1/fr/tf2/cvarlist_win/
    - https://steamcommunity.com/sharedfiles/filedetails/?id=2830445105 -- GAME SETTINGS COMMANDS
    - ...

    Useful commands:
    +showbudget
    cache_print

    Kek commands:
    "r_eyesize"
    r_eyesize -.5
    r_eyeshift_y 5
]]

local COMMANDS = {}

COMMANDS['spawnicon_queue'] = 1 -- enables experimental spawnicon loading queue, which prevents the game from freezing when opening large spawnlists.
COMMANDS['studio_queue_mode'] = 1
-- COMMANDS['sgm_ignore_warnings'] = 1

--[[------------------------------
Ropes
--------------------------------]]
COMMANDS['rope_collide'] = 0
COMMANDS['rope_smooth'] = 0
COMMANDS['rope_shake'] = 0
COMMANDS['rope_wind_dist'] = 0
COMMANDS['rope_averagelight'] = 0
COMMANDS['rope_subdiv'] = 1
COMMANDS['rope_rendersolid'] = 1
COMMANDS['r_ropetranslucent'] = 1

--[[------------------------------
Shadows
--------------------------------]]
COMMANDS['r_shadowrendertotexture'] = 0 -- 1 - bad shadows on walls
COMMANDS['r_shadowmaxrendered'] = 8
COMMANDS['r_flashlightdepthres'] = 256 -- affects flashlight shadow quality (1024 is default)
-- 0 is shit, 1 is medium, 2+ is high
COMMANDS['r_worldlights'] = 1 -- good map lightning (significantly improves quality)

--[[------------------------------
Render
--------------------------------]]
COMMANDS['r_lod'] = -1
COMMANDS['stopsound'] = 0
-- controls model detail, -2 being the highest and 2 being the lowest
COMMANDS['r_rootlod'] = prometheus.cfg.modelLevelDetails -- 1 - breaks cars
COMMANDS['r_decals'] = 400
COMMANDS['mp_decals'] = 400
-- 0 - disables a lot of map decals
COMMANDS['r_renderoverlayfragment'] = 1 // # Rendering of multiple Texturelayers on(1)/off(0)
COMMANDS['r_drawmodeldecals'] = 1 -- draw decals on props and etc.
COMMANDS['r_maxmodeldecal'] = 8 -- decals amount (models)
COMMANDS['r_fastzreject'] = -1 -- hardware decide
-- COMMANDS['mat_forcemanagedtextureintohardware'] = 0
COMMANDS['cl_particle_batch_mode'] = 2 -- https://www.teamfortress.tv/42867/mastercomfig-fps-customization-config/?page=7
COMMANDS['r_maxdlights'] = 8 -- dynamic lights (LIGHTS tool)
COMMANDS['cl_ejectbrass'] = 0 -- disable ammo shells
COMMANDS['r_drawflecks'] = 0 -- particles when you shoot wall and etc. (can also impact face mimics???)
COMMANDS['r_decal_cullsize'] = 1 -- Decals under this size in pixels are culled
COMMANDS['r_eyemove'] = 0
COMMANDS['r_teeth'] = 1
COMMANDS['r_eyes'] = 1
COMMANDS['r_waterforceexpensive'] = 0
COMMANDS['r_waterforcereflectentities'] = 0
-- "r_shadowrendertotexture"
--[[------------------------------
Materials
--------------------------------]]
COMMANDS['mat_specular'] = 0 -- отключает полноэкранные отражения (cubemap; phong'а достаточно), немного повышает FPS и освобождает текстурные блоки видеоадаптера.
COMMANDS['mat_disable_bloom'] = 1 -- bloom,effect from light objects (glow)
COMMANDS['mat_bufferprimitives'] = 1
COMMANDS['mat_fastspecular'] = 1
-- COMMANDS['mat_filtertextures'] = 1 -- filter textures (huge impact on quality)
-- COMMANDS['mat_filterlightmaps'] = 1 -- filter lightmaps (huge impact on quality)

--[[------------------------------
Multicore
--------------------------------]]
COMMANDS['gmod_mcore_test'] = 1
COMMANDS['threadpool_affinity'] = 1
COMMANDS['mat_queue_mode'] = 2 -- -1 = let hardware decide, 2 - multicore
COMMANDS['cl_updaterate'] = 16
COMMANDS['cl_cmdrate'] = 16

COMMANDS['cl_threaded_client_leaf_system'] = 1
COMMANDS['cl_threaded_bone_setup'] = 1 -- might possibly cause crashes, but is used everywhere

COMMANDS['props_break_max_pieces'] = 0
COMMANDS['cl_phys_props_enable'] = 0
COMMANDS['cl_phys_props_max'] = 1
COMMANDS['cl_phys_props_respawnrate'] = 1

COMMANDS['cl_forcepreload'] = 1
COMMANDS['r_queued_ropes'] = 1
COMMANDS['r_threaded_client_shadow_manager'] = 1
COMMANDS['r_threaded_renderables'] = 1
COMMANDS['r_threaded_particles'] = 1

-- mat_max_worldmesh_vertices --https://steamcommunity.com/app/730/discussions/0/1642052612845843306/

--[[------------------------------
Memory
--------------------------------]]
COMMANDS['datacachesize'] = 256
COMMANDS['mem_max_heapsize'] = 1024
COMMANDS['mem_min_heapsize'] = 96

--[[------------------------------
Networking, Lag Compensation and Interpolation
I suppose most of the settings got handled by server Network configuration
--------------------------------]]
COMMANDS['cl_lagcompensation'] = 1
COMMANDS['cl_pred_optimize'] = 2
COMMANDS['cl_smooth'] = 1
COMMANDS['cl_smoothtime'] = 0.1
COMMANDS['cl_interp'] = 0.5 -- 250ms lerp
COMMANDS['cl_wpn_sway_interp'] = 0
COMMANDS['rate'] = 120000

--[[------------------------------
Sound
--------------------------------]]
COMMANDS['dsp_slow_cpu'] = 1
COMMANDS['snd_noextraupdate'] = 1
COMMANDS['snd_mix_async'] = 1

--[[------------------------------
Miscellaneous
--------------------------------]]
COMMANDS['cl_timeout'] = 180
COMMANDS['cl_showhelp'] = 0
COMMANDS['flex_smooth'] = 0 -- Smooth face animations
COMMANDS['in_usekeyboardsampletime'] = 0
COMMANDS['m_rawinput'] = 1
COMMANDS['r_norefresh'] = 1 // # Do not store a useless and unused frame time variable
COMMANDS['r_pixelfog'] = 1
COMMANDS['r_glint_procedural'] = 1 -- # (0)Use the default eye glinting method. (1) Use CPU eye glinting, for fast CPUs and slow GPUs
COMMANDS['muzzleflash_light'] = 0
COMMANDS['blink_duration'] = 0.1 -- blinking (let's keep it here)
-- toggle gibs
COMMANDS['violence_agibs'] = 0
COMMANDS['violence_hgibs'] = 0
-- toggle blood
-- COMMANDS['violence_ablood'] = 1 -- let player decide
-- COMMANDS['violence_hblood'] = 1 -- let player decide
COMMANDS['cl_show_splashes'] = 0 -- water splashes when u shoot and interact with water
-- ragdolls
COMMANDS['ragdoll_sleepaftertime'] = 3 -- 0 is just bad
COMMANDS['g_ragdoll_fadespeed'] = 5
COMMANDS['g_ragdoll_lvfadespeed'] = 5
COMMANDS['cl_ragdoll_collide'] = 0

--[[------------------------------
DO NOT TOUCH STUFF BELOW
--------------------------------]]

local Execute = RunConsoleCommand
local tostring = tostring

for command, value in pairs(COMMANDS) do
    Execute(command, tostring(value))
end

Execute('vprof_off') -- is it safe???

COMMANDS = nil

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
