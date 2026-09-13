--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

function EFFECT:Init( data )
	local Pos = data:GetOrigin()
	local Ang = data:GetAngles()
	
	self:Explosion( Pos, Ang )
end

function EFFECT:Explosion( pos, ang )
	ParticleEffect( "wh_laserhit_medium", pos, ang )
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
