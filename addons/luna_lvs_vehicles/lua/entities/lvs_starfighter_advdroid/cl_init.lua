--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

function ENT:OnSpawn()
	self:RegisterTrail( Vector(-151,152,48), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-151,-152,48), 0, 20, 2, 1000, 150 )
end

function ENT:OnFrame()
end

ENT.EngineGlow = Material( "sprites/light_glow02_add" )
ENT.EngineFXColor = Color( 230, 30, 0, 255)
ENT.EngineFxPos = {
			Vector(-172,-89,53),
			Vector(-175,-84,53),
			Vector(-178,-78,53),
			Vector(-180,-73,53),
			Vector(-181,-68,53),
			Vector(-183,-64,53),
			Vector(-185,-58,53),
			Vector(-187,-52,53),
			Vector(-190,-47,53),
			
			Vector(-191,-41,53),
			Vector(-192,-35,53),
			Vector(-193,-29,53),
			Vector(-194,-23,53),
			Vector(-195,-17,53),
			Vector(-196,-11,53),
			Vector(-197,-5,53),
			
			Vector(-197,0,53),
			
			Vector(-197,5,53),
			Vector(-196,11,53),
			Vector(-195,17,53),
			Vector(-194,23,53),
			Vector(-193,29,53),
			Vector(-192,35,53),
			Vector(-191,41,53),
			
			Vector(-190,47,53),
			Vector(-187,52,53),
			Vector(-185,58,53),
			Vector(-183,64,53),
			Vector(-181,68,53),
			Vector(-180,73,53),
			Vector(-178,78,53),
			Vector(-175,84,53),
			Vector(-172,89,53),
			
			-- Bottom
			
			Vector(-190,-47,44),
			Vector(-187,-52,44),
			Vector(-185,-58,44),
			Vector(-183,-64,44),
			Vector(-181,-68,44),
			Vector(-180,-73,44),
			Vector(-178,-78,44),
			Vector(-175,-84,44),
			Vector(-172,-89,44),
			
			Vector(-191,-41,44),
			Vector(-192,-35,44),
			Vector(-193,-29,44),
			Vector(-194,-23,44),
			Vector(-195,-17,44),
			Vector(-196,-11,44),
			Vector(-197,-5,44),
			
			Vector(-197,0,44),
	
			Vector(-197,5,44),
			Vector(-196,11,44),
			Vector(-195,17,44),
			Vector(-194,23,44),
			Vector(-193,29,44),
			Vector(-192,35,44),
			Vector(-191,41,44),
			
			Vector(-190,47,44),
			Vector(-187,52,44),
			Vector(-185,58,44),
			Vector(-183,64,44),
			Vector(-181,68,44),
			Vector(-180,73,44),
			Vector(-178,78,44),
			Vector(-175,84,44),
			Vector(-172,89,44),
}

function ENT:PostDraw()
	if not self:GetEngineActive() then return end
	
	-- Far Bottom
	
	cam.Start3D2D( self:LocalToWorld( Vector(-181,-65,45) ), self:LocalToWorldAngles( Angle(0,291.5,120) ), 1 )
		draw.NoTexture()
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRectRotated( 0, 0, 45, 6 , 0 )
	cam.End3D2D()
	
	cam.Start3D2D( self:LocalToWorld( Vector(-181,65,45) ), self:LocalToWorldAngles( Angle(0,68.5,-120) ), 1 )
		draw.NoTexture()
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRectRotated( 0, 0, 45, 6 , 0 )
	cam.End3D2D()
	
	-- Near Bottom 
	
	cam.Start3D2D( self:LocalToWorld( Vector(-192,-22,45) ), self:LocalToWorldAngles( Angle(0,276.5,120) ), 1 )
		draw.NoTexture()
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRectRotated( 0, 0, 45, 6 , 0 )
	cam.End3D2D()
	
	cam.Start3D2D( self:LocalToWorld( Vector(-192,22,45) ), self:LocalToWorldAngles( Angle(0,83.5,-120) ), 1 )
		draw.NoTexture()
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRectRotated( 0, 0, 45, 6 , 0 )
	cam.End3D2D()
	
	-- Far Top
	
	cam.Start3D2D( self:LocalToWorld( Vector(-181,-65,53) ), self:LocalToWorldAngles( Angle(0,291.5,60) ), 1 )
		draw.NoTexture()
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRectRotated( 0, 0, 45, 6 , 0 )
	cam.End3D2D()
	
	cam.Start3D2D( self:LocalToWorld( Vector(-181,65,53) ), self:LocalToWorldAngles( Angle(0,68.5,-60) ), 1 )
		draw.NoTexture()
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRectRotated( 0, 0, 45, 6 , 0 )
	cam.End3D2D()
	
	-- Near Top
	
	cam.Start3D2D( self:LocalToWorld( Vector(-192,-22,53) ), self:LocalToWorldAngles( Angle(0,276.5,60) ), 1 )
		draw.NoTexture()
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRectRotated( 0, 0, 45, 6 , 0 )
	cam.End3D2D()
	
	cam.Start3D2D( self:LocalToWorld( Vector(-192,22,53) ), self:LocalToWorldAngles( Angle(0,83.5,-60) ), 1 )
		draw.NoTexture()
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRectRotated( 0, 0, 45, 6 , 0 )
	cam.End3D2D()
end

function ENT:PostDrawTranslucent()
	if not self:GetEngineActive() then return end

	local Size = 30 + self:GetThrottle() * 15 + self:GetBoost() * 0.4

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
