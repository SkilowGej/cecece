--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

EFFECT.Material = "effects/drc_sw/flash1"
EFFECT.Colour	= Color(0, 150, 255)
EFFECT.Time		= 0.07
EFFECT.Speed	= 5
EFFECT.Size		= 0.25
EFFECT.ScaleFP	= 1
EFFECT.ScaleTP	= 1

EFFECT.DoSmoke 			= true
EFFECT.SmokeMaterial	= "effects/drc_sw/plasma3"
EFFECT.SmokeChance		= 1
EFFECT.SmokeScale 		= 0.5
EFFECT.SmokeLighting 	= false
EFFECT.SmokeColour		= Color(0, 100, 150, 255)

function EFFECT:Init( data )
	if data:GetEntity() == LocalPlayer():GetViewModel() then
		self.WeaponEnt = LocalPlayer():GetActiveWeapon()
		self.TargetEnt = LocalPlayer():GetViewModel()
		self.Scale = self.ScaleFP
	else
		self.WeaponEnt = data:GetEntity()
		self.TargetEnt = data:GetEntity()
		self.Scale = self.ScaleTP
	end
	self.StartPos = data:GetStart()
	self.StartAng = data:GetAngles()
	self.EndPos = data:GetOrigin()
	self.OwnerVel = data:GetEntity():GetOwner():GetVelocity()
	self.EffectColour = self.WeaponEnt.EffectTint
	
	local emitter = ParticleEmitter( self.StartPos )
	local emitterSmoke = ParticleEmitter( self.StartPos )
	
	if math.Rand(0,1) < self.SmokeChance then
		for i = 1,20 do
			local particle = emitterSmoke:Add( self.SmokeMaterial, self.StartPos + Vector( math.random(0,0),math.random(0,0),math.random(0,0) ) ) 
			if (particle) then
				particle.CreateTime = RealTime()
				particle.Speed = self.Speed
				particle.Num = i
				particle:SetVelocity(Vector(self.StartAng:Forward() * 0.25 * i * self.Speed) + self.OwnerVel)
				particle:SetLifeTime(0) 
				particle:SetDieTime(self.Time*0.5 * i) 
				particle:SetStartAlpha(50*i)
				particle:SetEndAlpha(0)
				particle:SetStartSize(math.Rand(0, 1)*i*self.Size*self.Scale*self.SmokeScale)
				particle:SetEndSize(math.Rand(2, 20)*self.Size*self.Scale*self.SmokeScale)
				particle:SetAngles( Angle(21.424716258016,3.5762036133102,5.6347174018494) )
				particle:SetRoll(math.Rand(0, 180))
				particle:SetColor(self.SmokeColour.r, self.SmokeColour.g, self.SmokeColour.b)
				particle:SetGravity(Vector(0,0,(0.02*i)*i))
				particle:SetAirResistance(240)  
				particle:SetCollide(true)
				particle:SetBounce(0.1419790559388)
				particle:SetLighting(self.SmokeLighting)
			end
		end
	end
	
	emitter:Finish()
	emitterSmoke:Finish()
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
