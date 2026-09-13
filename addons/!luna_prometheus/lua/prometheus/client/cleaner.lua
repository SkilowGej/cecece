--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

-- timer.Create('prometheus.ClearDecals', 60, 0, function()
--     RunConsoleCommand('r_cleardecals')
--     prometheus.Print('Cleaned decals.')
-- end)

hook.Add('CreateClientsideRagdoll', 'prometheus.RemoveRagdoll', function(ent, ragdoll)
    local time = cvars.Number('ragdoll_sleepaftertime', 0)
    timer.Create('RemoveRagdoll_' .. ent:EntIndex(), time, 1, function()
        if (IsValid(ragdoll)) then
            ragdoll:SetSaveValue('m_bFadingOut', true)
        end
    end)
end)

timer.Create('RunCacheClean', 240, 0, function()
	jit.off()
	jit.on()
	jit.flush()	
end)

-- [[ https://github.com/technoatomictangerine/snippets/blob/main/simplegc.lua ]] --
local gc = collectgarbage
local SysTime = SysTime
local limit, die = 1 / 300, 0, 0
local create, yield, resume =
	coroutine.create, coroutine.yield, coroutine.resume
local timerCreate = timer.Create
local running = false

local function _gc()
	while gc('step', 1) do
		if SysTime() > die then
			yield()
		end
	end
end

timerCreate('CollectGarbage', 60, 0, function()
	if running then return end
	running = true
	local co = create(_gc)
	local Start = SysTime()
	timerCreate('CollectGarbage.Process', 0, 0, function()
		die = SysTime() + limit
		if co == nil or not resume(co) then
			timer.Remove('CollectGarbage.Process')
			running = false
		end
	end)
end)

gc'stop'

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
