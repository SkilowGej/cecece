--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

DEFINE_BASECLASS( "mp_service_base" )

SERVICE.Name 	= "SoundCloud"
SERVICE.Id 		= "sc"
SERVICE.Base 	= "af"

SERVICE.PrefetchMetadata = false

function SERVICE:New( url )
	local obj = BaseClass.New(self, url)

	-- TODO: grab id from /tracks/:id, etc.
	obj._data = obj.urlinfo.path or '0'

	return obj
end

function SERVICE:Match( url )
	return string.match( url, "soundcloud.com" )
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
