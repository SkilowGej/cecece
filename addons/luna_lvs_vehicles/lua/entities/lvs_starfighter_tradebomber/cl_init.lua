--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

function ENT:OnSpawn()
	self:RegisterTrail( Vector(-190.39,109.37,55.05), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-190.38,-108.89,54.67), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(31.55,108.66,2.8), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(29.55,-108.29,2.53), 0, 20, 2, 1000, 150 )
end

function ENT:OnFrame()
end

ENT.EngineGlow = Material( "sprites/light_glow02_add" )
ENT.EngineFXColor = Color( 255, 0, 0)
ENT.EngineFxPos = {
	--left side
	Vector(-73.7,87.81,52.08),
	Vector(-73.07,87.84,47.86),
	Vector(-73.27,82.79,52.54),
	Vector(-73.78,82.62,48.26),
	Vector(-73.42,77.61,52.11),
	Vector(-73.29,77.45,47.92),
	Vector(-73.98,72.4,47.9),
	Vector(-73.33,72.32,52.3),
	Vector(-73.18,67.19,52.16),
	Vector(-73.83,67.14,47.82),
	Vector(-73.05,67.2,43.11),
	Vector(-73.74,61.95,52.34),
	Vector(-73.65,62.23,48.02),
	Vector(-73.98,61.85,43.37),
	Vector(-73.81,56.86,43.28),
	Vector(-73.48,57.05,48.09),
	Vector(-73.49,56.77,51.82),
	Vector(-73.35,51.69,52.07),
	Vector(-73.3,51.52,47.82),
	Vector(-73.65,51.86,43.22),
	Vector(-73.3,46.66,43.34),
	Vector(-73.98,46.48,47.82),
	Vector(-73.22,41.09,47.7),
	Vector(-73.19,41.28,43.09),
	Vector(-73.29,36.12,47.86),
	Vector(-73.98,36.14,52.07),
	Vector(-73.82,36.07,43.08),
	Vector(-73.58,30.9,43.17),
	Vector(-73.43,31.07,47.85),
	Vector(-73.64,31.05,52.28),
	Vector(-73.67,31,39.17),
	Vector(-73.99,25.84,38.85),
	Vector(-73.51,25.78,43.23),
	Vector(-73.84,25.81,47.93),
	Vector(-73.96,25.68,52.02),
	Vector(-73.76,20.7,52.09),
	Vector(-73.21,20.51,47.57),
	Vector(-73.83,20.49,43.04),
	Vector(-73.6,20.81,38.92),
	Vector(-73.61,41.41,51.86),
	Vector(-73.18,46.58,52.2),
	
	-- Right Side
	Vector(-73.7,-87.81,52.08),
	Vector(-73.07,-87.84,47.86),
	Vector(-73.27,-82.79,52.54),
	Vector(-73.78,-82.62,48.26),
	Vector(-73.42,-77.61,52.11),
	Vector(-73.29,-77.45,47.92),
	Vector(-73.98,-72.4,47.9),
	Vector(-73.33,-72.32,52.3),
	Vector(-73.18,-67.19,52.16),
	Vector(-73.83,-67.14,47.82),
	Vector(-73.05,-67.2,43.11),
	Vector(-73.74,-61.95,52.34),
	Vector(-73.65,-62.23,48.02),
	Vector(-73.98,-61.85,43.37),
	Vector(-73.81,-56.86,43.28),
	Vector(-73.48,-57.05,48.09),
	Vector(-73.49,-56.77,51.82),
	Vector(-73.35,-51.69,52.07),
	Vector(-73.3,-51.52,47.82),
	Vector(-73.65,-51.86,43.22),
	Vector(-73.3,-46.66,43.34),
	Vector(-73.22,-41.09,47.7),
	Vector(-73.19,-41.28,43.09),
	Vector(-73.29,-36.12,47.86),
	Vector(-73.98,-36.14,52.07),
	Vector(-73.82,-36.07,43.08),
	Vector(-73.58,-30.9,43.17),
	Vector(-73.43,-31.07,47.85),
	Vector(-73.64,-31.05,52.28),
	Vector(-73.67,-31,39.17),
	Vector(-73.99,-25.84,38.85),
	Vector(-73.51,-25.78,43.23),
	Vector(-73.84,-25.81,47.93),
	Vector(-73.96,-25.68,52.02),
	Vector(-73.76,-20.7,52.09),
	Vector(-73.21,-20.51,47.57),
	Vector(-73.83,-20.49,43.04),
	Vector(-73.6,-20.81,38.92),
	Vector(-73.61,-41.41,51.86),
	Vector(-73.18,-46.58,52.2),
}

function ENT:PostDrawTranslucent()
	if not self:GetEngineActive() then return end

	local Size = 35 + self:GetThrottle() * 15 + self:GetBoost() * 0.4

	render.SetMaterial( self.EngineGlow )

	for _, v in pairs( self.EngineFxPos ) do
		local pos = self:LocalToWorld( v )
		render.DrawSprite( pos, Size, Size, self.EngineFXColor )
	end
end

function ENT:OnStartBoost()
	self:EmitSound( "lvs/vehicles/vulturedroid/boost.wav", 85 )
end

function ENT:OnStopBoost()
	self:EmitSound( "lvs/vehicles/vulturedroid/brake.wav", 85 )
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
