--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

function ENT:OnSpawn()
	self:RegisterTrail( Vector(-106.845,87,340.898), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-106.845,-87,340.898), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-66.219,87,81.297), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-66.219	,-94.209,81.297), 0, 20, 2, 1000, 150 )
end

function ENT:OnFrame()
end

local mat = Material( "sprites/light_glow02_add" )
function ENT:Draw()
	self:DrawModel()
	

	
	if self:GetEngineActive() then

		local Size = 80
		render.SetMaterial( mat )
		render.DrawSprite( self:LocalToWorld( Vector(-68,0,250) ), Size, Size, Color( 0, 255, 157, 255) )	
		render.DrawSprite( self:LocalToWorld( Vector(-45,0,205) ), Size, Size, Color( 0, 255, 157, 255) )	
		render.DrawSprite( self:LocalToWorld( Vector(-22,0,160) ), Size, Size, Color( 0, 255, 157, 255) )		

	end
	
	if self:GetEngineActive() then

		local Size = 40
		render.SetMaterial( mat )
		render.DrawSprite( self:LocalToWorld( Vector(-20,200,53) ), Size, Size, Color( 0, 255, 157, 255) )
		render.DrawSprite( self:LocalToWorld( Vector(-20,-200,53) ), Size, Size, Color( 0, 255, 157, 255) )

		render.DrawSprite( self:LocalToWorld( Vector(70,20,207) ), Size, Size, Color( 0, 255, 157, 255) )
		render.DrawSprite( self:LocalToWorld( Vector(70,-20,207) ), Size, Size, Color( 0, 255, 157, 255) )
		
		render.DrawSprite( self:LocalToWorld( Vector(70,38,248) ), Size, Size, Color( 0, 255, 157, 255) )
		render.DrawSprite( self:LocalToWorld( Vector(70,-38,248) ), Size, Size, Color( 0, 255, 157, 255) )
		
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
