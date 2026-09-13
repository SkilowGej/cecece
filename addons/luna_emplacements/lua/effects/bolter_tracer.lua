--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

sound.Add( {
	name = "wk_bolter_impact",
	channel = CHAN_STATIC,
	volume = 1,
	level = 80,
	pitch = 120,
	sound = { "wk_explosives/bolter_impact_1.wav", "wk_explosives/bolter_impact_2.wav", "wk_explosives/bolter_impact_3.wav", "wk_explosives/bolter_impact_4.wav" }
} )

sound.Add( {
	name = "wk_bolter_impact_gore",
	channel = CHAN_STATIC,
	volume = 1,
	level = 80,
	pitch = 120,
	sound = { "wk_explosives/bolter_impact_gore_1.wav", "wk_explosives/bolter_impact_gore_2.wav" }
} )


local tracer = Material("effects/wk/spark_sharp")
local tracer2 = Material("effects/wk/spark_flame")

EFFECT.Col1 = Color(255, 200, 150, 200)
EFFECT.Col2 = Color(255, 0, 0, 100)
EFFECT.LerpedCol = Color( 0, 0, 0, 0)
EFFECT.Speed = 8192
EFFECT.TracerLength = 128
EFFECT.TracerWidth = 24
EFFECT.Mat2 = Material( "sprites/light_glow02_add" )

--[[---------------------------------------------------------
Init( data table )
-----------------------------------------------------------]]
function EFFECT:Init(data)
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()

	self.StartPos = (self.WeaponEnt.GetTracerOrigin and self.WeaponEnt:GetTracerOrigin() and self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)) or  data:GetStart()
	self.EndPos = data:GetOrigin()

	self.Normal = (self.EndPos - self.StartPos):GetNormalized()
	self.Length = (self.EndPos - self.StartPos):Length()
	self.Direction = (self.EndPos - self.StartPos):GetNormal()

	self.CurPos = self.StartPos
	self.Life = 0
	self.MaxLife = self.Length / self.Speed

	ParticleEffect( "WKWeapons.Bolter.MuzzleFlash", self.StartPos, self.Direction:Angle() )
	
	self:SetRenderBoundsWS(self.StartPos, self.EndPos)
end

--[[---------------------------------------------------------
THINK
-----------------------------------------------------------]]
function EFFECT:Think()
	self.Life = self.Life + FrameTime() * (1 / self.MaxLife)

	if self.Life > 1 then

		local tr = util.TraceLine( {
			start = self.StartPos + self.Normal * 150,
			endpos = self.EndPos + self.Normal * 50,
			mask = MASK_ALL,
			filter = self,
		} )

		local v = tr.Entity

		if (v:IsNPC() or (v:IsNextBot() or v.IV04NextBot)) or v:IsPlayer() then
			--print( " target is npc ")
			ParticleEffect( "wk_impact_bolter_gore", tr.HitPos, Angle(0,0,0) )
			self:EmitSound( "wk_bolter_impact_gore" )
		else
			ParticleEffect( "wk_impact_bolter_mini_generic", self.EndPos - self.Normal * 10, Angle(0,0,0) )
			self:EmitSound( "wk_bolter_impact" )
		end
		
		return false
	end

	return true
end

--[[---------------------------------------------------------
Draw the effect
-----------------------------------------------------------]]

function EFFECT:Render()
	--print( self.Life )
	self.LerpedCol.r = Lerp(self.Life, self.Col1.r, self.Col2.r)
	self.LerpedCol.g = Lerp(self.Life, self.Col1.g, self.Col2.g)
	self.LerpedCol.b = Lerp(self.Life, self.Col1.b, self.Col2.b)
	self.LerpedCol.a = Lerp(self.Life, self.Col1.a, self.Col2.a)

	local endbeampos = Lerp(self.Life, self.StartPos, self.EndPos)
	local startbeampos = Lerp(self.Life + self.TracerLength / self.Length, self.StartPos, self.EndPos)
	
	local endbeampos2 = Lerp(self.Life + ( self.TracerLength / ( self.Length ) ), self.StartPos, self.EndPos)
	local startbeampos2 = Lerp(self.Life, self.StartPos, self.EndPos) 

	render.SetMaterial( tracer )
    render.DrawBeam( startbeampos, endbeampos, self.TracerWidth, 0, 1, self.LerpedCol )
	render.SetMaterial( tracer2 )
	render.DrawBeam( startbeampos2, endbeampos2, self.TracerWidth / 4, 0, 1, self.Col1 )
	render.SetMaterial( self.Mat2 )
	render.DrawSprite( startbeampos + self.Normal * -10 , 50 , 50 , self.Col1 )
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
