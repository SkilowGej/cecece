--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


function EFFECT:Init( data )
	local Pos = data:GetOrigin()
	local Dir = data:GetNormal()
	local Ent = data:GetEntity()
	local Scale = data:GetMagnitude()

	if not IsValid( Ent ) then return end

	local emitter = Ent:GetParticleEmitter( Pos )

	if not IsValid( emitter ) then return end

	local particle = emitter:Add( "effects/lvs_base/fire", Pos )

	if particle then
		particle:SetVelocity( Dir * 70 )
		particle:SetDieTime( 0.2 )
		particle:SetAirResistance( 0 ) 
		particle:SetStartAlpha( 255 )
		particle:SetStartSize( 10 + 18 * Scale )
		particle:SetEndSize( 0 )
		particle:SetRoll( math.Rand(-1,1) * 180 )
		particle:SetColor( 255,255,255 )
		particle:SetGravity( Vector( 0, 0, 100 ) )
		particle:SetCollide( false )
	end
	
	for i = 1, 3 do
		local particle = emitter:Add( "effects/lvs_base/flamelet"..math.random(1,5), Pos )
		
		if particle then
			particle:SetVelocity( Dir * 40 * i )
			particle:SetDieTime( 0.2 )
			particle:SetAirResistance( 0 ) 
			particle:SetStartAlpha( 255 )
			particle:SetStartSize( (5 + 5 * Scale) - i )
			particle:SetEndSize( 0 )
			particle:SetRoll( math.Rand(-1,1) * 180 )
			particle:SetColor( 255,255,255 )
			particle:SetGravity( Vector( 0, 0, 100 ) )
			particle:SetCollide( false )
		end
	end
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
