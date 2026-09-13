--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

do
    local min, max = math.min, math.max
    math.Clamp = function(num, low, high)
        if type(num) ~= "number" or type(low) ~= "number" or type(high) ~= "number" then -- Проверка что нам не подсунули строку или таблицу
            error("math.Clamp expects number arguments", 2)
        end
        return min(max(num, low), high)
    end
end
do
	local floor = math.floor
	math.Round = function(num, idp)
		local mult = 10 ^ (idp or 0)
		return floor(num * mult + 0.5) / mult
	end
end
do
	local random = math.random
	math.Rand = function(low, high)
		return low + (high - low) * random()
	end
	local index, length = 1, 0
	table.Shuffle = function(tbl)
		length = #tbl
		for i = length, 1, -1 do
			index = random(1, length)
			tbl[i], tbl[index] = tbl[index], tbl[i]
		end
		return tbl
	end
	do
		local keys = setmetatable({ }, {
			__mode = "v"
		})
		table.Random = function(tbl, issequential)
			if issequential then
				length = #tbl
				if length == 0 then
					return nil, nil
				end
				if length == 1 then
					index = 1
				else
					index = random(1, length)
				end
			else
				length = 0
				for key in pairs(tbl) do
					length = length + 1
					keys[length] = key
				end
				if length == 0 then
					return nil, nil
				end
				if length == 1 then
					index = keys[1]
				else
					index = keys[random(1, length)]
				end
			end
			return tbl[index], index
		end
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
