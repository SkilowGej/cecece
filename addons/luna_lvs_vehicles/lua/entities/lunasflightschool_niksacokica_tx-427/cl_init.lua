--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")
include( "sh_turret.lua" )
--include( "cl_prediction.lua" )
--include( "cl_hud.lua" )


function ENT:OnSpawn()
	local mins, maxs = self:GetRenderBounds()
	self:SetRenderBounds( mins, maxs, Vector( 80, 0, 0 ) )
end

function ENT:DamageFX()
	self.nextDFX = self.nextDFX or 0

	if self.nextDFX < CurTime() then
		self.nextDFX = CurTime() + 0.05

		local HP = self:GetHP()
		local MaxHP = self:GetMaxHP()

		if HP > MaxHP * 0.5 then return end

		local effectdata = EffectData()
			effectdata:SetOrigin( self:LocalToWorld( Vector(11,0,46) ) )
			effectdata:SetEntity( self )
		util.Effect( "lvs_engine_blacksmoke", effectdata )

		if HP <= MaxHP * 0.25 then
			local effectdata = EffectData()
				effectdata:SetOrigin( self:LocalToWorld( Vector(11,40,46) ) )
				effectdata:SetNormal( self:GetUp() )
				effectdata:SetMagnitude( math.Rand(0.5,1.5) )
				effectdata:SetEntity( self )
			util.Effect( "lvs_exhaust_fire", effectdata )

			local effectdata = EffectData()
				effectdata:SetOrigin( self:LocalToWorld( Vector(11,-40,46) ) )
				effectdata:SetNormal( self:GetUp() )
				effectdata:SetMagnitude( math.Rand(0.5,1.5) )
				effectdata:SetEntity( self )
			util.Effect( "lvs_exhaust_fire", effectdata )
		end
	end
end

function ENT:OnFrame()
	--self:PredictPoseParamaters()
	self:DamageFX()
	self:EngineEffects()
end


function ENT:CalcViewOverride( ply, pos, angles, fov, pod )
	if ply == self:GetDriver() then
		if not pod:GetThirdPersonMode() then
			return pos + self:GetForward() * 100 - self:GetUp() * 20, angles + Angle(5,0,0), fov
		else
			return pos + self:GetForward() * -100 - self:GetUp() * -100, angles + Angle(5,0,0), fov
		end
	end
	local GunnerPod = self:GetGunnerSeat()
	if pod == GunnerPod and pod:GetThirdPersonMode() then
		return GunnerPod:LocalToWorld( Vector(0,0,30) ), angles + Angle(5,0,0), fov
	end

	local CoSeatPod = self:GetCoSeat()
	if pod == CoSeatPod then
		if pod:GetThirdPersonMode() then
			return CoSeatPod:LocalToWorld( Vector(0,0,100) ), angles + Angle(5,0,0), fov
		else
			return pos, angles, fov
		end
	end

	local originPos = pos
	local mn = self:OBBMins()
	local mx = self:OBBMaxs()
	local radius = ( mn - mx ):Length()
	local radius = radius + radius * pod:GetCameraDistance()

	local TargetOrigin = originPos + ( angles:Forward() * -radius ) + angles:Up() * (40 + radius * pod:GetCameraHeight())
	local WallOffset = 4

	local tr = util.TraceHull( {
		start = originPos,
		endpos = TargetOrigin,
		filter = function( e )
			local c = e:GetClass()
			local collide = not c:StartWith( "prop_physics" ) and not c:StartWith( "prop_dynamic" ) and not c:StartWith( "prop_ragdoll" ) and not e:IsVehicle() and not c:StartWith( "gmod_" ) and not c:StartWith( "lvs_" ) and not c:StartWith( "player" ) and not e.LVS

			return collide
		end,
		mins = Vector( -WallOffset, -WallOffset, -WallOffset ),
		maxs = Vector( WallOffset, WallOffset, WallOffset ),
	} )

	originPos = tr.HitPos
	if tr.Hit and  not tr.StartSolid then
		originPos = originPos + tr.HitNormal * WallOffset
	end

	return originPos, angles, fov
end

local COLOR_RED = Color(255,0,0,255)
local COLOR_WHITE = Color(255,255,255,255)

function ENT:LVSPreHudPaint( X, Y, ply )
	if self:GetIsCarried() then return false end

	if ply == self:GetDriver() then
		local Col = self:WeaponsInRange() and COLOR_WHITE or COLOR_RED

		local Pos2D = self:GetEyeTrace().HitPos:ToScreen() 

		self:PaintCrosshairCenter( Pos2D, Col )
		self:PaintCrosshairOuter( Pos2D, Col )
		self:LVSPaintHitMarker( Pos2D )
	end

	return true
end

function ENT:RemoveLight()
	if IsValid( self.projector ) then
		self.projector:Remove()
		self.projector = nil
	end
end

function ENT:OnRemoved()
	self:RemoveLight()
end

ENT.SignalSprite = Material( "sprites/light_glow02_add" )
ENT.Red = Color( 255, 0, 0, 255)

function ENT:PostDrawTranslucent()
	if not self:GetEngineActive() then return end

end

function ENT:EngineEffects()
	if not self:GetEngineActive() then return end

	local T = CurTime()

	if (self.nextEFX or 0) > T then return end

	self.nextEFX = T + 0.01
	
		local emitter = ParticleEmitter( self:GetPos(), false )
		local Pos = {
			Vector(-130,72,20),
			Vector(-130,85,20),

			Vector(-130,-72,20),
			Vector(-130,-85,20),
			}

		if emitter then
			for _, v in pairs( Pos ) do
				local Sub = Mirror and 1 or -1
				local vOffset = self:LocalToWorld( v )
				local vNormal = -self:GetForward()

				vOffset = vOffset + vNormal * 4

				local particle = emitter:Add( "sprites/heatwave", vOffset )
				if not particle then return end

				particle:SetVelocity( vNormal * math.Rand(1000,1000) + self:GetVelocity() )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( .02 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand(15,15) )
				particle:SetEndSize( math.Rand(0,0) )
				particle:SetRoll( math.Rand(-1,1) * 100 )
				
				particle:SetColor( 255, 255, 255 )
			
				Mirror = true
			end
			
			emitter:Finish()
		end
	
end

ENT.LightMaterial = Material( "effects/lvs/laat_spotlight" )
ENT.GlowMaterial = Material( "sprites/light_glow02_add" )

function ENT:PreDrawTranslucent()
	if self:GetSpotlightToggle() == false then 
		self:RemoveLight()
		return false
	end

	if not IsValid( self.projector ) then
		local thelamp = ProjectedTexture()
		thelamp:SetBrightness( 10 ) 
		thelamp:SetTexture( "effects/flashlight/soft" )
		thelamp:SetColor( Color(255,255,255) ) 
		thelamp:SetEnableShadows( true ) 
		thelamp:SetFarZ( 2500 ) 
		thelamp:SetNearZ( 20 ) 
		thelamp:SetFOV( 90 )
		self.projector = thelamp
	end

	local Start1 = self:LocalToWorld( Vector(114,49,58.5) )
	local Start2 = self:LocalToWorld( Vector(114,-49,58.5) )

	local Dir1 = self:LocalToWorldAngles( Angle(0,5,0) ):Forward()
	local Dir2 = self:LocalToWorldAngles( Angle(0,-5,0) ):Forward()

	render.SetMaterial( self.GlowMaterial )
	render.DrawSprite( Start1, 49, 40, Color( 100, 100, 100, 255) )
	render.DrawSprite( Start2, 49, 40, Color( 100, 100, 100, 255) )

	render.SetMaterial( self.LightMaterial )
	render.DrawBeam( Start1,  Start1 + Dir1 * 400, 150, 0, 0.99, Color( 100, 100, 100, 100) ) 
	render.DrawBeam( Start2,  Start2 + Dir2 * 400, 150, 0, 0.99, Color( 100, 100, 100, 100) ) 

	if IsValid( self.projector ) then
		self.projector:SetPos( self:LocalToWorld( Vector(120,0,58.5) ) )
		self.projector:SetAngles( self:LocalToWorldAngles( Angle(10,0,0) ) )
		self.projector:Update()
	end

	return false
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
