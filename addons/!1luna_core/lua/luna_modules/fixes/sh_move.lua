--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

-- https://github.com/Facepunch/garrysmod-issues/issues/2447

local telequeue = {}
local setpos = FindMetaTable("Entity").SetPos
local PLAYER = FindMetaTable("Player")

function PLAYER:SetPos(pos)
	telequeue[self] = pos
end

hook.Add("FinishMove", "SetPos.FinishMove", function(pl)
	if telequeue[pl] then
		setpos(pl, telequeue[pl])
		telequeue[pl] = nil
		return true
	end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
