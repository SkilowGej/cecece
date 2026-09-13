--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

function EFFECT:Init(data)
	self.Pos = data:GetOrigin()

	local dynlight = DynamicLight(0)
	dynlight.Pos = self.Pos
	dynlight.Size = 100
	dynlight.Decay = 320
	dynlight.R = 255
	dynlight.G = 111
	dynlight.B = 111
	dynlight.Brightness = 0.3
	dynlight.DieTime = CurTime()+.3
	
	ParticleEffect( "tfa_apex_lstar_explode_core", data:GetOrigin(), data:GetAngles(), self )
	
	self.Time = 0
	self.Size = 0
end

function EFFECT:Think()
	self.Time = self.Time + FrameTime()
	self.Size = 20

	return self.Time < .3
end

function EFFECT:Render()
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
