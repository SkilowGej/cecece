--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

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

EFFECT.DecalMat = Material( util.DecalMaterial( "Scorch" ) )

function EFFECT:Init( data )
	local Pos = data:GetOrigin()

	self.DieTime = CurTime() + 1

	self:Explosion( Pos, 2 )

	local ply = LocalPlayer():GetViewEntity()
	if IsValid( ply ) then
		local delay = (Pos - ply:GetPos()):Length() / 13503.9
		timer.Simple( delay, function()
			sound.Play( "lvs/vehicles/clone_attack_drone/shot_3.wav", Pos, 511 )
		end )
	else
		sound.Play( "lvs/vehicles/clone_attack_drone/shot_3.wav", Pos, 511 )
	end
	
	for i = 1, 20 do
		timer.Simple(math.Rand(0,0.01) * i, function()
			if IsValid( self ) then
				local p = Pos + VectorRand() * 10 * i
				
				self:Explosion( p, math.Rand(0.5,0.8) )
			end
		end)
	end

	local traceSky = util.TraceLine( {
		start = Pos,
		endpos = Pos + Vector(0,0,50000),
		mask = MASK_SOLID_BRUSHONLY,
	} )

	local traceWater = util.TraceLine( {
		start = traceSky.HitPos,
		endpos = Pos - Vector(0,0,100),
		mask = MASK_WATER,
	} )

	if traceWater.Hit then
		local effectdata = EffectData()
		effectdata:SetOrigin( traceWater.HitPos )
		effectdata:SetScale( 100 )
		effectdata:SetFlags( 2 )
		util.Effect( "WaterSplash", effectdata, true, true )
	else
		local trace = util.TraceLine( {
			start = Pos + Vector(0,0,100),
			endpos = Pos - Vector(0,0,100),
			mask = MASK_SOLID_BRUSHONLY,
		} )

		if trace.Hit and not trace.HitNonWorld then
			for i = 1, 10 do
				local StartPos = trace.HitPos + Vector(math.random(-25,25) * i,math.random(-25,25) * i,0)
				local decalTrace = util.TraceLine( {
					start = StartPos + Vector(0,0,100),
					endpos = StartPos - Vector(0,0,100),
					mask = MASK_SOLID_BRUSHONLY,
				} )

				util.DecalEx( self.DecalMat, trace.Entity, decalTrace.HitPos + decalTrace.HitNormal, decalTrace.HitNormal, Color(255,255,255,255), math.Rand(2,3), math.Rand(2,3) )
			end
		end
	end
end

function EFFECT:Explosion( pos , scale )
	local emitter = ParticleEmitter( pos, false )
	
	if not IsValid( emitter ) then return end

	for i = 0,10 do
		local particle = emitter:Add( Materials[ math.random(1, #Materials ) ], pos )

		if particle then
			particle:SetVelocity( VectorRand() * 1500 * scale )
			particle:SetDieTime( math.Rand(2,3) * scale )
			particle:SetAirResistance( math.Rand(200,600) ) 
			particle:SetStartAlpha( 255 )
			particle:SetStartSize( math.Rand(200,250) * scale )
			particle:SetEndSize( math.Rand(575,600) * scale )
			particle:SetRoll( math.Rand(-1,1) )
			particle:SetColor( 245,245,245 )
			particle:SetGravity( Vector( 0, 0, 100 ) )
			particle:SetCollide( false )
		end
	end

	emitter:Finish()

	local dlight = DynamicLight( math.random(0,9999) )
	if dlight then
		dlight.pos = pos
		dlight.r = 255
		dlight.g = 180
		dlight.b = 100
		dlight.brightness = 8
		dlight.Decay = 2000
		dlight.Size = 300
		dlight.DieTime = CurTime() + 1
	end
end

function EFFECT:Think()
	if CurTime() < self.DieTime then return true end

	return false
end

function EFFECT:Render()
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
