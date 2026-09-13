--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if SAM_LOADED then return end

local sam = sam
local config = sam.config

sam.permissions.add("manage_config", nil, "superadmin")

local updates = {}
function config.hook(keys, func)
	for i = #keys, 1, -1 do
		keys[keys[i]] = true
		keys[i] = nil
	end

	local id = table.insert(updates, {
		keys = keys,
		func = func
	})

	if config.loaded then
		func()
	end

	return id
end

function config.get_updated(key, default)
	local setting = {}
	config.hook({key}, function()
		setting.value = config.get(key, default)
	end)
	return setting
end

function config.remove_hook(key)
	updates[key] = nil
end

hook.Add("SAM.LoadedConfig", "RunHooks", function()
	for k, v in pairs(updates) do
		v.func()
	end
end)

hook.Add("SAM.UpdatedConfig", "RunHooks", function(key, value, old)
	for k, v in pairs(updates) do
		if v.keys[key] then
			v.func(value, old)
		end
	end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
