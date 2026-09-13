--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include "shared.lua"

DEFINE_BASECLASS( "mp_service_browser" )

function SERVICE:OnBrowserReady( browser )
	BaseClass.OnBrowserReady( self, browser )

	local html = self:GetHTML()
	html = self.WrapHTML( html )

	self.Browser:SetHTML( html )
end

function SERVICE:GetHTML()
	return "<h1>SERVICE.GetHTML not yet implemented</h1>"
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
