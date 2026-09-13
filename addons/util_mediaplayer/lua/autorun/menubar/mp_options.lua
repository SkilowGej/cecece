--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

hook.Add( "PopulateMenuBar", "MediaPlayerOptions_MenuBar", function( menubar )

	local m = menubar:AddOrGetMenu( "▶  Media Player" )

	m:AddCVar( "Fullscreen", "mediaplayer_fullscreen", "1", "0" )

	m:AddSpacer()

	m:AddOption( "Turn Off All", function()
		for _, mp in ipairs(MediaPlayer.GetAll()) do
			MediaPlayer.RequestListen( mp )
		end

		MediaPlayer.HideSidebar()
	end )

end )


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
