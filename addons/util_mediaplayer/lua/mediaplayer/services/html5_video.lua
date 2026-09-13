--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

SERVICE.Name	= "HTML5 Video"
SERVICE.Id		= "h5v"
SERVICE.Base	= "res"

SERVICE.FileExtensions = {
	'webm',
	-- 'mp4',	-- not yet supported by Awesomium
	-- 'ogg'	-- already registered as audio, need a work-around :(
}

DEFINE_BASECLASS( "mp_service_base" )

if CLIENT then
	
	local MimeTypes = {
		webm = "video/webm",
		mp4 = "video/mp4",
		ogg = "video/ogg"
	}

	local EmbedHTML = [[
<video id="player" autoplay loop style="
		width: 100%%;
		height: 100%%;">
	<source src="%s" type="%s">
</video>
]]

	local JS_Volume = [[(function () {
	var elem = document.getElementById('player');
	if (elem) {
		elem.volume = %s;
	}
}());]]

	function SERVICE:GetHTML()
		local url = self.url

		local path = self.urlinfo.path
		local ext = path:match("[^/]+%.(%S+)$")

		local mime = MimeTypes[ext]

		return EmbedHTML:format(url, mime)
	end

	function SERVICE:Volume( volume )
		local origVolume = volume

		volume = BaseClass.Volume( self, volume )

		if origVolume and ValidPanel( self.Browser ) then
			self.Browser:RunJavascript(JS_Volume:format(volume))
		end
	end

end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
