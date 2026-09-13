--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

SERVICE.Name	= "SHOUTcast"
SERVICE.Id		= "shc"
SERVICE.Base	= "af"

-- DEFINE_BASECLASS( "mp_service_af" )

local StationUrlPattern = "yp.shoutcast.com/sbin/tunein%-station%.pls%?id=%d+"

function SERVICE:Match( url )
	return url:match( StationUrlPattern )
end

function SERVICE:IsTimed()
	return false
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
