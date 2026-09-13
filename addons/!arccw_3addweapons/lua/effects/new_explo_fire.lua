--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

EFFECT.FlashLarge = {
	"effects/drc_sw/expl_fire0_bwa",
	"effects/drc_sw/expl_fire1_bw",
	"effects/drc_sw/expl_fire2_bw",
	"effects/drc_sw/expl_fire3_bw",
}
EFFECT.LargeFlashes = 12
EFFECT.LargeFlashLifeTimeMin = 0.3
EFFECT.LargeFlashLifeTimeMax = 0.6

EFFECT.Dots = {
	"effects/drc_sw/flash1",
	"effects/drc_sw/flash3",
}
EFFECT.DotsAmount = 10

EFFECT.Streaks = {
	"effects/drc_sw/flash1",
	"effects/drc_sw/flash3",
}
EFFECT.StreakCount = 38

EFFECT.Smoke = {
	"effects/drc_sw/dirt1",
	"effects/drc_sw/dust0",
	"effects/drc_sw/dust1",
}
EFFECT.SmokePuffs 		= 100
EFFECT.SmokeLighting 	= true
EFFECT.SmokeColour 		= Color(0, 0, 0, 255)
EFFECT.SmokeScale		= 1

function EFFECT:Init( data )
	local Pos = data:GetOrigin()
	
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.DataNormal = data:GetNormal()
	
	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
	self.EndPos = data:GetOrigin()
	self.Entity:SetRenderBoundsWS(self.StartPos, self.EndPos)
	
	self.LargeFlashLifeTime = math.Rand(self.LargeFlashLifeTimeMin, self.LargeFlashLifeTimeMax)
	
	local sub = self.EndPos - self.StartPos
	self.Normal = sub:GetNormal()
	
	local emitter = ParticleEmitter(Pos)
	for i = 1,self.LargeFlashes do
		local variance = math.Rand(0, 1)
		local sele = self.FlashLarge[math.Round(math.Rand(1, #self.FlashLarge))]
		local particle = emitter:Add(sele, Pos + Vector( math.random(0,0),math.random(0,0),math.random(0,0) ) ) 
		if particle == nil then particle = emitter:Add(sele, Pos + Vector(   math.random(0,0),math.random(0,0),math.random(0,0) ) ) end
		if (particle) then
		--	particle:SetVelocity(Vector(math.random(-12,12),math.random(-12,12),math.random(-12,12)))
			particle:SetLifeTime(0) 
			particle:SetDieTime(self.LargeFlashLifeTime) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(120 * variance)
			particle:SetEndSize(0)
			particle:SetAngles(Angle(21.4 * variance, 3.5 * variance, 5.6 * variance))
			particle:SetAngleVelocity(Angle(5 * variance))
			particle:SetRoll(math.Rand( 0, 360 ) * variance)
			particle:SetColor(math.random(200,220),math.random(90,100),math.random(47,83),math.random(180,255))
			particle:SetGravity( Vector(0,0,0) ) 
			particle:SetAirResistance(-68.167394537726 )  
			particle:SetCollide(true)
			particle:SetBounce(0.1419790559388)
		end
	end
	
	local emitter2 = ParticleEmitter(Pos)
	for i = 1,self.DotsAmount do
		local sele = self.Dots[math.Round(math.Rand(1, #self.Dots))]
		local particle2 = emitter2:Add(sele, Pos + Vector( math.random(-6,6),math.random(-6,6),math.random(0,0))) 
		if particle2 == nil then particle2 = emitter2:Add(sele, Pos + Vector(   math.random(-6,6),math.random(-6,6),math.random(0,0) ) ) end
		if (particle2) then
			particle2:SetVelocity((-self.Normal+VectorRand() * 45):GetNormal() * math.Rand(95, 295));
			particle2:SetLifeTime(math.Rand(0.05, 0.5)) 
			particle2:SetDieTime(math.Rand(2,7)) 
			particle2:SetStartAlpha(255)
			particle2:SetEndAlpha(0)
			particle2:SetStartSize(2) 
			particle2:SetEndSize(0)
			particle2:SetAngleVelocity( Angle(4.2934407040912,14.149586106307,0.18606363772742) ) 
			particle2:SetRoll(math.Rand( 0, 360 ))
			particle2:SetColor(math.random(200,220),math.random(90,100),math.random(47,83),math.random(180,255))
			particle2:SetGravity( Vector(0,0,-400) ) 
			particle2:SetAirResistance(0)  
			particle2:SetCollide(true)
			particle2:SetBounce(0)
		end
	end
	
	local emitter3 = ParticleEmitter(Pos)
	for i = 1,self.SmokePuffs do
		local sele = self.Smoke[math.Round(math.Rand(1, #self.Smoke))]
		local particle3 = emitter3:Add(sele, Pos + Vector( math.random(-6,6),math.random(-6,6),math.random(0,0))) 
		if particle3 == nil then particle3 = emitter3:Add(sele, Pos + Vector(   math.random(-6,6),math.random(-6,6),math.random(0,0) ) ) end
		if (particle3) then
			particle3:SetVelocity(Vector(math.random(-10,10),math.random(-10,10),math.Rand(-10,10)):GetNormal() * math.random(300, 500	))
			particle3:SetLifeTime(math.Rand(0.05, 0.5)) 
			particle3:SetDieTime(math.Rand(0.3,0.6)) 
			particle3:SetStartAlpha(255)
			particle3:SetEndAlpha(0)
			particle3:SetLighting(self.SmokeLighting)
			particle3:SetStartSize(math.Rand(7,12)) 
			particle3:SetEndSize(math.Rand(37,65))
			particle3:SetAngleVelocity( Angle(4.2934407040912,14.149586106307,0.18606363772742) ) 
			particle3:SetRoll(math.Rand( 0, 360 ))
			particle3:SetColor(self.SmokeColour.r, self.SmokeColour.g, self.SmokeColour.b, self.SmokeColour.a)
			particle3:SetGravity( Vector(0,0,0) ) 
			particle3:SetAirResistance(0.01)  
			particle3:SetCollide(true)
			particle3:SetBounce(0)
		end
	end
	
	local emitter5 = ParticleEmitter (Pos)
	for i = 1,self.StreakCount do
		local sele = self.Streaks[math.Round(math.Rand(1, #self.Streaks))]
		local particle5 = emitter5:Add(sele, Pos + Vector( math.random(0,0),math.random(0,0),math.random(0,0) ) ) 
		if particle5 == nil then particle5 = emitter5:Add(sele, Pos + Vector(   math.random(0,0),math.random(0,0),math.random(0,0) ) ) end
		if (particle5) then
			particle5:SetVelocity((-self.Normal+VectorRand() * math.Rand(15,45)):GetNormal() * math.Rand(305, 965));
			particle5:SetLifeTime(0) 
			particle5:SetDieTime(0.2) 
			particle5:SetStartAlpha(255)
			particle5:SetEndAlpha(0)
			particle5:SetStartSize(5) 
			particle5:SetEndSize(0)
			particle5:SetStartLength(100)
			particle5:SetEndLength(0)
			particle5:SetAngles( Angle(21.424716258016,3.5762036133102,5.6347174018494) )
			particle5:SetAngleVelocity( Angle(0) ) 
			particle5:SetRoll(0)
			particle5:SetColor(math.random(200,220),math.random(90,100),math.random(47,83),math.random(180,255))
			particle5:SetGravity( Vector(0,0,0) ) 
			particle5:SetAirResistance( 0.5 )  
			particle5:SetCollide(true)
			particle5:SetBounce(0.1419790559388)
		end
	end

	emitter:Finish()
	emitter2:Finish()
	emitter3:Finish()
	emitter5:Finish()	
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
