----require("query")
--query.EnableInfoDetour(true)

--print("Detour enabled")
--hook.Add("A2S_INFO", "reply", function(ip, port, info)
 --   if info.players >= 10 then
	 --     info.players = math.Round(info.players+9)
		 --   if info.players >= game.MaxPlayers() then
			 --     info.players = game.MaxPlayers()
				--end
--    end

		--return info
--end)

--hook.Add("A2S_PLAYER", "reply", function(ip, port, info)
		-- print("A2S_PLAYER from", ip, port)
		-- PrintTable(info)
-- -   return info
--end)

SV_UNSECURE_PLAYER_MARKERS = SV_UNSECURE_PLAYER_MARKERS or {}
if timer.Exists("UNSECURE_PLAYER_MARKERS_TIMER") then
	timer.Remove("UNSECURE_PLAYER_MARKERS_TIMER")
end
timer.Create("UNSECURE_PLAYER_MARKERS_TIMER", 60, 0, function()
	for i, v in ipairs(SV_UNSECURE_PLAYER_MARKERS) do
		if v.TTL <= CurTime() then
			table.remove(SV_UNSECURE_PLAYER_MARKERS, i)
		end
	end
end)
