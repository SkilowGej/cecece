--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

DEFINE_BASECLASS( "mp_service_browser" )

SERVICE.Name 	= "Webpage"
SERVICE.Id 		= "www"
SERVICE.Base 	= "res"
SERVICE.Abstract = true -- This service must be handled as a special case.

if CLIENT then

	function SERVICE:OnBrowserReady( browser )
		BaseClass.OnBrowserReady( self, browser )
		browser:OpenURL( self.url )
	end

	function SERVICE:IsMouseInputEnabled()
		return IsValid( self.Browser )
	end

else

	function SERVICE:Match( url )
		return false
	end

end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
