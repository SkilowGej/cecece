--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

function ENT:OnSpawn()
end

ENT.EngineColor = Color( 129, 228, 218, 255)
ENT.EngineGlow = Material("sprites/light_glow02_add")
ENT.EnginePos = {
		Vector(-215,-122.3,8.38),
		Vector(-215,122.3,8.38),
		Vector(-25.93,0,225.85),
	}

function ENT:OnFrame()
	self:EngineEffects()
	self:AnimWings()
end

function ENT:OnWingsChanged()
	if not self:GetWingsDown() then
		self.EnginePos = {
			Vector(-215,-122.3,8.38),
			Vector(-215,122.3,8.38),
		}
		local function EngineTimer()
			self.EnginePos = {
			Vector(-140,0,-207.25),
			Vector(-215.42,-122.3,8.38),
			Vector(-215.42,122.3,8.38),
			}
		end
		timer.Simple(0.5, EngineTimer)
		
	else
		self.EnginePos = {
			Vector(-215,-122.3,8.38),
			Vector(-215,122.3,8.38),
		}
		local function EngineTimer()
			self.EnginePos = {
			Vector(-25.93,0,225.85),
			Vector(-215.42,-122.3,8.38),
			Vector(-215.42,122.3,8.38),
			}
		end
		timer.Simple(0.5, EngineTimer)
	end
end

function ENT:EngineEffects()
	if not self:GetEngineActive() then return end

	local T = CurTime()

	if (self.nextEFX or 0) > T then return end

	self.nextEFX = T + 0.01

	local THR = self:GetThrottle()

	local emitter = self:GetParticleEmitter( self:GetPos() )

	if not IsValid( emitter ) then return end

	for _, pos in pairs( self.EnginePos ) do
		local vOffset = self:LocalToWorld( pos )
		local vNormal = -self:GetForward()

		vOffset = vOffset + vNormal * 5

		local particle = emitter:Add( "effects/muzzleflash2", vOffset )

		if not particle then continue end

		particle:SetVelocity( vNormal * (math.Rand(500,1000) + self:GetBoost() * 10) + self:GetVelocity() )
		particle:SetLifeTime( 0 )
		particle:SetDieTime( 0.1 )
		particle:SetStartAlpha( 255 )
		particle:SetEndAlpha( 0 )
		particle:SetStartSize( math.Rand(25,35) )
		particle:SetEndSize( math.Rand(0,10) )
		particle:SetRoll( math.Rand(-1,1) * 100 )
		particle:SetColor( 129, 228, 218 )
	end
end

function ENT:PostDrawTranslucent()
	if not self:GetEngineActive() then return end

	local Size = 80 + self:GetThrottle() * 120 + self:GetBoost() * 2

	render.SetMaterial( self.EngineGlow )

	for _, pos in pairs( self.EnginePos ) do
		render.DrawSprite(  self:LocalToWorld( pos ), Size, Size, self.EngineColor )
	end

end

function ENT:AnimCockpit()
end

function ENT:OnStartBoost()
	self:EmitSound( "ARC170_BOOST", 70 )
end

function ENT:OnStopBoost()
	self:EmitSound( "ARC170_BRAKE", 70 )
end

function ENT:AnimWings()

	self._sm_wing = self._sm_wing or 1
	
	local RFT = RealFrameTime() * 10
	
	local target_wing = self:GetWingsDown() and 0 or 1

	local Rate = RFT * 0.2

	self._sm_wing = self._sm_wing + math.Clamp(target_wing - self._sm_wing,-Rate,Rate)

	local DoneMoving = self._sm_wing == 1 or self._sm_wing == 0

	local Ang = (1 - self._sm_wing) * 180

	local A5 = Ang
	local A6 = Ang
    local A7 = -Ang

	self:ManipulateBoneAngles( 2, Angle(0,0,A5*0.7) )
	self:ManipulateBoneAngles( 1, Angle(0,0,A7*0.7) )
	self:ManipulateBoneAngles( 3, Angle(0,A6,0) )

	self:InvalidateBoneCache()
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
