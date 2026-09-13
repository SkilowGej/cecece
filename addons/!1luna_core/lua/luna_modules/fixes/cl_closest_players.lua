--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local buffer, lowbuffer = {}, {}
local GetAll = player.GetAll
local VECTOR = FindMetaTable("Vector")
local DistToSqr = VECTOR.DistToSqr
local range = 1500 * 1500
local lowrange = 500 * 500
local EyePos = EyePos
local force = 0

local function PopulateCache(co)
	local k, ent
	local rate = 1 / 9000
	while true do
		k, ent = next(GetAll(), k)
		if k ~= nil and IsValid(ent) then
			local d = DistToSqr(EyePos(), ent:GetPos())
			if d < lowrange then
				lowbuffer[ent] = true
				buffer[ent] = true
			elseif d < range then
				buffer[ent] = true
				lowbuffer[ent] = nil
			else
				buffer[ent] = nil
				lowbuffer[ent] = nil
			end
		end
		co:limit(rate)
	end
end

--task.NewThread('PopulatePlayerCache', 1 / 3, PopulateCache)
_G.HighLevelBuffer = buffer
_G.LowLevelBuffer = lowbuffer

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
