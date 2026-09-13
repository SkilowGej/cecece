netstream.Hook("EventRoom_ChangeLevel", function( pl, texts, changelevel )
	if not pl:IsAdmin() then return end

	local time_end = 30 + (1.5 * #texts)
	netstream.Start(player.GetAll(), "EventRoom_ChangeLevel", texts, time_end)

	changelevel = changelevel == nil and true or false 

	timer.Simple(time_end + 1, function()
		if changelevel then
			RunConsoleCommand("changelevel", game.GetMap())
		else
			netstream.Start(player.GetAll(), "EventRoom_ChangeLevel", false)
		end
	end)
end)
netstream.Hook("EventRoom_PlayMusic", function(pl, tracks)
	if not pl:IsAdmin() then return end
	netstream.Start(player.GetAll(), "EventRoom_PlayMusic", tracks)
end)