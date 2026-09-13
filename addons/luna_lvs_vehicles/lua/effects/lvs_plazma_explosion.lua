--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


local GlowMat = Material( "trails/plasma" )
local Materials = {
	"trails/physbeam",
	"trails/physbeam",
	"trails/physbeam",
	"trails/physbeam",
	"trails/physbeam",
	"trails/physbeam",
	"trails/physbeam",
	"trails/physbeam",
	"trails/physbeam",
	"trails/physbeam",
	"trails/physbeam",
	"trails/physbeam",
	"trails/physbeam",
	"trails/physbeam",
	"trails/physbeam",
	"trails/physbeam"
}

function EFFECT:Init( data )
	self.Pos = data:GetOrigin()

	self.LifeTime = 0.9
	self.DieTime = CurTime() + self.LifeTime

	local emitter = ParticleEmitter( self.Pos, false )

	if not IsValid( emitter ) then return end

	for i = 0,30 do
		local particle = emitter:Add(  Materials[ math.random(1, #Materials ) ], self.Pos )
		
		if particle then
			particle:SetVelocity( VectorRand(-1,1) * 800 )
			particle:SetDieTime( math.Rand(4,6) )
			particle:SetAirResistance( math.Rand(200,600) ) 
			particle:SetStartAlpha( 100 )
			particle:SetStartSize( math.Rand(50,80) )
			particle:SetEndSize( math.Rand(100,150) )
			particle:SetRoll( math.Rand(-1,1) )
			particle:SetColor( 50,50,50 )
			particle:SetGravity( Vector( 0, 0, 100 ) )
			particle:SetCollide( false )
		end
	end

	for i = 0, 20 do
		local particle = emitter:Add( "sprites/light_glow02_add", self.Pos )
		
		local vel = VectorRand() * 400
		
		if particle then
			particle:SetVelocity( vel )
			particle:SetAngles( vel:Angle() + Angle(0,90,0) )
			particle:SetDieTime( math.Rand(0.4,0.8) )
			particle:SetStartAlpha( 255 )
			particle:SetEndAlpha( 0 )
			particle:SetStartSize( math.Rand(24,48) )
			particle:SetEndSize( 0 )
			particle:SetRoll( math.Rand(-100,100) )
			particle:SetRollDelta( math.Rand(-100,100) )
			particle:SetColor( 0,127,255 )
			particle:SetGravity( Vector(0,0,-600) )

			particle:SetAirResistance( 0 )
			
			particle:SetCollide( true )
			particle:SetBounce( 0.5 )
		end
	end
	
	for i = 0, 40 do
		local particle = emitter:Add( "effects/lvs_base/flamelet"..math.random(1,5), self.Pos )
		
		if particle then
			particle:SetVelocity( VectorRand(-1,1) * 500 )
			particle:SetDieTime( 0.14 )
			particle:SetStartAlpha( 255 )
			particle:SetStartSize( 15 )
			particle:SetEndSize( math.Rand(30,60) )
			particle:SetEndAlpha( 100 )
			particle:SetRoll( math.Rand( -1, 1 ) )
			particle:SetColor( 200,150,150 )
			particle:SetCollide( false )
		end
	end

	emitter:Finish()

	local Pos = self.Pos
	local ply = LocalPlayer():GetViewEntity()
	if IsValid( ply ) then
		local delay = (Pos - ply:GetPos()):Length() / 13503.9
		if delay <= 0.11 then
			sound.Play( "plasma_gun_04.mp3", Pos, 85, 100, 1 - delay * 8 )
		end

		timer.Simple( delay, function()
			sound.Play( "LVS.MISSILE_EXPLOSION", Pos )
		end )
	else
		sound.Play( "LVS.MISSILE_EXPLOSION", Pos )
	end
end

function EFFECT:Think()
	if self.DieTime < CurTime() then return false end

	return true
end

function EFFECT:Render()
	local Scale = (self.DieTime - CurTime()) / self.LifeTime
	render.SetMaterial( GlowMat )
	render.DrawSprite( self.Pos, 400 * Scale, 400 * Scale, Color( 0, 127, 255, 255) )
	render.DrawSprite( self.Pos, 100 * Scale, 100 * Scale, Color( 255, 255, 255, 255) )
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
