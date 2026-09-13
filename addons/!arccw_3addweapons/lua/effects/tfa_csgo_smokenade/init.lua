--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--Thanks Inconceivable/Generic Default
function EFFECT:Init(data)
	self.Entity = data:GetEntity()
	pos = data:GetOrigin()
	self.Emitter = ParticleEmitter(pos)
	for i=1, 100 do
		local particle = self.Emitter:Add( "tfa_csgo/particle/particle_smokegrenade", pos)
		if (particle) then
			particle:SetVelocity( VectorRand():GetNormalized()*math.Rand(150, 400) )
			if i <= 1 then 
				particle:SetDieTime( 25 )
			else
				particle:SetDieTime( math.Rand( 23,28 ) )
			end
			particle:SetStartAlpha( math.Rand( 200, 255 ) )
			particle:SetEndAlpha( 0 )
			particle:SetStartSize( 44 )
			particle:SetEndSize( 144 )
			particle:SetRoll( math.Rand(0, 360) )
			particle:SetRollDelta( math.Rand(-1, 1)/3 )
			particle:SetColor( 65, 65, 65 ) 
			particle:SetAirResistance( 100 ) 
			//particle:SetGravity( Vector(math.Rand(-30, 30),math.Rand(-30, 30), -200 )) 	
			particle:SetCollide( true )
			particle:SetBounce( 1 )
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
