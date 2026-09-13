--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


function EFFECT:Init( data )
	self.Pos = data:GetOrigin()
	self.Ang = data:GetAngles()

	self.AttachmentID = ID

	self:Muzzle( self.Pos, self.Ang )
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end


function EFFECT:Muzzle( pos, ang )
	ParticleEffect( "wh_lasermuzzle_medium", pos, ang )
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
