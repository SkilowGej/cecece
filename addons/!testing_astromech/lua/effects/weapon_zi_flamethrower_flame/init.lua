--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

//Main function
function EFFECT:Init(data)


//Default performance settings
local DrawFlame = 1
local DrawSmoke = 1


//Muzzle and desired position vectors
local StartPos = self:GetTracerShootPos(self.Position, data:GetEntity(), data:GetAttachment())
local HitPos = data:GetOrigin()

//Check if the weapon is still there
if data:GetEntity():IsValid() && StartPos && HitPos then


	//Draw burst of flame
	if DrawFlame == 1 then

	//Create particle emmiter
	local FlameEmitter = ParticleEmitter(StartPos)

		//Amount of particles to create
		for i=0, 2 do

			//Safeguard
			if !FlameEmitter then return end

			local FlameParticle = FlameEmitter:Add("effects/flamethrower_fire_1", StartPos)
	

			if (FlameParticle) then

				FlameParticle:SetVelocity(((HitPos-StartPos):GetNormal()*math.random(1720,1820))+(VectorRand()*math.random(142,172)))

				FlameParticle:SetLifeTime(0)
				FlameParticle:SetDieTime(0.18)

				FlameParticle:SetStartAlpha(math.random(92,132))
				FlameParticle:SetEndAlpha(0)

				FlameParticle:SetStartSize(math.random(4,6))
				FlameParticle:SetEndSize(32)

				FlameParticle:SetRoll(math.Rand(-360, 360))
				FlameParticle:SetRollDelta(math.Rand(-7.2, 7.2))

				FlameParticle:SetAirResistance(math.random(128, 256))

				FlameParticle:SetCollide(true)

				FlameParticle:SetGravity(Vector(0, 0, 64))

			end
		end

	//We're done with this emmiter
	FlameEmitter:Finish()

	//Finished with flame
	end


	//Draw stream of smoke
	if DrawSmoke == 1 then

	//Create particle emmiter
	local SmokeEmitter = ParticleEmitter(StartPos)

		//Amount of particles to create
		for i=0, 2 do

			//Safeguard
			if !SmokeEmitter then return end

			SmokeParticle = SmokeEmitter:Add( "particle/smokesprites_000" .. math.random(1,8) .. "", StartPos )

			if (SmokeParticle) then

				SmokeParticle:SetVelocity( ((HitPos - StartPos):GetNormal() * math.random(1720,1820)) + (VectorRand() * math.random(152,182)) )

				SmokeParticle:SetLifeTime(0)
				SmokeParticle:SetDieTime( math.Rand(0.30, 0.34) )

				SmokeParticle:SetStartAlpha(math.random(52,92))
				SmokeParticle:SetEndAlpha(0)

				SmokeParticle:SetStartSize(math.random(0,2))
				SmokeParticle:SetEndSize(math.random(34,36))

				SmokeParticle:SetRoll(math.Rand(-360, 360))
				SmokeParticle:SetRollDelta(math.Rand(-5.2, 5.2))

				SmokeParticle:SetAirResistance(math.random(132, 262))

				SmokeParticle:SetCollide(true)

				SmokeParticle:SetGravity( Vector(0, 0, -92) )

				SmokeParticle:SetLighting(1)

			end
		end

	//We're done with this emmiter
	SmokeEmitter:Finish()

	//Finished with smoke
	end


end
end

//Kill effect
function EFFECT:Think()
return false
end

//Unused
function EFFECT:Render()
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
