--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

-- SHARED
local cfg = prometheus.cfg

cfg.playerAnimationCalculateDistance = 2048

cfg.lerp = 250

cfg.slowThinkRate = 12 -- 12 ticks
cfg.slowThinkIgnore = {
    -- ['prometheus.SlowThinkProcessor'] = true
}

cfg.deleteMapEntities = {
    'lua_run',
    'env_fire',
	'spotlight_end',
	'beam',
	--'func_tracktrain',
	--'point_template'
}

cfg.netrateWhitelist = {
    ['textscreens_download'] = true, -- Textscreens
    ['simfphys_mousesteer'] = true, -- Simfphys
    ['simfphys_request_ppdata'] = true, -- Simfphys
    ['sh_acc_request'] = true, -- SH Accessories
    ['sts:RequestTextData'] = true, -- Simple Text Screens
    ['TFA_Attachment_Request'] = true, -- TFA
    ['TFA_Attachment_RequestAll'] = true, -- TFA
    ['lvsDisableInput'] = true -- LVS
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
