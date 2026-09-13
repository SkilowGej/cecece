--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

EFFECT.Mat = Material("effects/laser_tracer")
EFFECT.Speed = 1024 * 15
EFFECT.TracerLength = 5

local Materials = {
	"particle/smokesprites_0001",
	"particle/smokesprites_0002",
	"particle/smokesprites_0003",
	"particle/smokesprites_0004",
	"particle/smokesprites_0005",
	"particle/smokesprites_0006",
	"particle/smokesprites_0007",
	"particle/smokesprites_0008",
	"particle/smokesprites_0009",
	"particle/smokesprites_0010",
	"particle/smokesprites_0011",
	"particle/smokesprites_0012",
	"particle/smokesprites_0013",
	"particle/smokesprites_0014",
	"particle/smokesprites_0015",
	"particle/smokesprites_0016"
}

function EFFECT:Init( data )
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()

	if IsValid(self.WeaponEnt) and self.WeaponEnt.GetMuzzleAttachment then
		self.Attachment = self.WeaponEnt:GetMuzzleAttachment()
	end

	-- Keep the start and end pos - we're going to interpolate between them
    self.StartPos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
    self.EndPos = data:GetOrigin()

	self.Dir = self.EndPos - self.StartPos

	self:SetRenderBoundsWS( self.StartPos, self.EndPos )

    self.StartTime = 0
	self.TracerTime = math.min( 1, self.StartPos:Distance( self.EndPos ) / 7000 ) * 1
	self.Length = 0.33

	-- Die when it reaches its target
	self.DieTime = CurTime() + self.TracerTime

	local Dir = self.Dir:GetNormalized()

	local emitter = ParticleEmitter( self.StartPos, false )

	for i = 0, 5 do
		local particle = emitter:Add( Materials[math.random(1,table.Count( Materials ))], self.StartPos )

		local rCol = 255

		if particle then
			particle:SetVelocity( Dir * math.Rand(100,500) + VectorRand() * math.Rand(0,10) )
			particle:SetDieTime( math.Rand(0.05,0.2) )
			particle:SetAirResistance( math.Rand(50,100) )
			particle:SetStartAlpha( 5 )
			particle:SetStartSize( 2 )
			particle:SetEndSize( math.Rand(5,10) )
			particle:SetRoll( math.Rand(-1,1) )
			particle:SetColor( rCol, rCol, rCol )
			particle:SetGravity( VectorRand() * 200 + Vector(0,0, -500) )
			particle:SetCollide( false )
		end
	end

	emitter:Finish()
end

local hitColor = Vector(255, 140, 0)

function EFFECT:Think()
    self.StartTime = self.StartTime + FrameTime()

	if CurTime() > self.DieTime then
		local effectdata = EffectData()
			effectdata:SetStart( hitColor )
			effectdata:SetOrigin( self.EndPos )
			effectdata:SetNormal( self.Dir:GetNormalized() )
		util.Effect( "laser_hit", effectdata )

		return false
	end

	return true
end

local mainColor = Color(255, 120, 0)
local innerColor = Color(192, 192, 192)

function EFFECT:Render()
	local fDelta = ( self.DieTime - CurTime() ) / self.TracerTime
	fDelta = math.Clamp( fDelta, 0, 1 ) ^ 2

	local sinWave = math.sin( fDelta * math.pi )

	local Pos1 = self.EndPos - self.Dir * ( fDelta - sinWave * self.Length )

	render.SetMaterial( self.Mat )
	render.DrawBeam( Pos1,
		self.EndPos - self.Dir * ( fDelta + sinWave * self.Length ),
        8, 5, 0, mainColor
    )

	render.DrawBeam( Pos1,
		self.EndPos - self.Dir * ( fDelta + sinWave * self.Length ),
        2, 5, 0, innerColor
    )

    if --[[DynamicTracer:GetBool()]] true then
    local spawn = util.CRC(tostring(self:GetPos()))
    local dlight = DynamicLight(self:EntIndex() + spawn)
    local endDistance = self.Speed * self.StartTime
    local endPos = self.StartPos + self.Dir:GetNormalized() * endDistance

    if (dlight) then
        dlight.pos = endPos
        dlight.r = 255
        dlight.g = 165
        dlight.b = 0
        dlight.brightness = 7
        dlight.Decay = 1000
        dlight.Size = 500
        dlight.DieTime = CurTime() + 3
    end
end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
