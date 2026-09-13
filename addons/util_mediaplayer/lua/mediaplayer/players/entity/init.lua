--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile "shared.lua"
AddCSLuaFile "sh_meta.lua"
include "shared.lua"

DEFINE_BASECLASS( "mp_base" )

function MEDIAPLAYER:NetWriteUpdate()
	-- Write the entity index since the actual entity may not yet exist on a
	-- client that's not fully connected.
	local entIndex = IsValid(self.Entity) and self.Entity:EntIndex() or 0
	net.WriteUInt(entIndex, 16)
end

function MEDIAPLAYER:NextMedia()

	BaseClass.NextMedia( self )

	if IsValid(self.Entity) then
		local media = self:GetMedia()

		-- Fire outputs on the entity which can be used by mappers to create
		-- effects such as lights turning on/off
		if media then
			self.Entity:Fire( "OnMediaStarted", nil, 0 )
		else
			self.Entity:Fire( "OnQueueEmpty", nil, 0 )
		end
	end

end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
