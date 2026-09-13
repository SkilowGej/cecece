--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

function ENT:Initialize()
end

function ENT:OnFrame()
	self:AnimCabin()
end



function ENT:AnimCabin()
	local Fire = self:GetBTLFire()
	if Fire ~= self.OldFireBTL then
		self.OldFireBTL = Fire
		
		if Fire then			
			local effectdata = EffectData()
			effectdata:SetEntity( self )
			util.Effect( "tx_130_projector", effectdata )
		end
	end
	
	local bOn = self:GetActive()
	
	local TVal = bOn and 0 or 1
	
	local Speed = FrameTime() * 4
	
	self.SMcOpen = self.SMcOpen and self.SMcOpen + math.Clamp(TVal - self.SMcOpen,-Speed,Speed) or 0
	
	self:ManipulateBoneAngles( 20, Angle(0,0,self.SMcOpen * -95) ) 
	
end

function ENT:CalcEngineSound( RPM, Pitch, Doppler )
	if self.ENG then
		self.ENG:ChangePitch(  math.Clamp( 60 + Pitch * 30 + Doppler,0,255) )
		self.ENG:ChangeVolume( math.Clamp( Pitch, 0.5,1) )
	end

	if self.ENG_HI then
		self.ENG_HI:ChangePitch(  math.Clamp( 60 + Pitch * 30 + Doppler,0,255) )
		self.ENG_HI:ChangeVolume( math.Clamp( Pitch, 0.5,1) )
	end

	if self.DIST then
		self.DIST:ChangePitch(  math.Clamp(math.Clamp(  Pitch * 100, 50,255) + Doppler * 1.25,0,255) )
		self.DIST:ChangeVolume( math.Clamp( -1.5 + Pitch * 6, 0.5,1) )
	end
	--[[if self.ENG then
		self.ENG:ChangePitch(  math.Clamp(math.Clamp(  60 + Pitch * 50, 80,255) + Doppler,0,255) )
		self.ENG:ChangeVolume( math.Clamp( -1 + Pitch * 6, 0.5,1) )
	end
	
	if self.DIST then
		self.DIST:ChangePitch(  math.Clamp(math.Clamp(  50 + Pitch * 60, 50,255) + Doppler,0,255) )
		self.DIST:ChangeVolume( math.Clamp( -1 + Pitch * 6, 0,1) )
	end]]
end

function ENT:OnRemove()
	self:SoundStop()
end

function ENT:SoundStop()
	if self.DIST then
		self.DIST:Stop()
	end
	
	if self.ENG then
		self.ENG:Stop()
	end
end



function ENT:LVSCalcView( ply, pos, angles, fov, pod )
	local view = {}
	view.origin = pos
	view.fov = fov
	view.drawviewer = true
	view.angles = ply:EyeAngles()
	local gunners = self:GetGunnerSeat()
	local gunner = gunners:GetDriver()
	local Driver = self:GetDriver()
	if pod:GetThirdPersonMode() then
		if ply == self:GetDriver() then
			local Pod = ply:GetVehicle()
			
				local radius = 400
				radius = radius + radius * Pod:GetCameraDistance()
				
				local StartPos = self:LocalToWorld( Vector(0,0,50) ) + view.angles:Up() * 100
				local EndPos = StartPos - view.angles:Forward() * radius
				
				local WallOffset = 4
		
				local tr = util.TraceHull( {
					start = StartPos,
					endpos = EndPos,
					filter = function( e )
						local c = e:GetClass()
						local collide = not c:StartWith( "prop_physics" ) and not c:StartWith( "prop_dynamic" ) and not c:StartWith( "prop_ragdoll" ) and not e:IsVehicle() and not c:StartWith( "gmod_" ) and not c:StartWith( "player" ) and not e.LFS
						
						return collide
					end,
					mins = Vector( -WallOffset, -WallOffset, -WallOffset ),
					maxs = Vector( WallOffset, WallOffset, WallOffset ),
				} )
				
				view.drawviewer = true
				view.origin = tr.HitPos
				
				if tr.Hit and not tr.StartSolid then
					view.origin = view.origin + tr.HitNormal * WallOffset
				end
			return view
		else
			local Pod = ply:GetVehicle()
			
			local radius = 400
			radius = radius + radius * Pod:GetCameraDistance()
			
			local StartPos = self:LocalToWorld( Vector(0,0,50) ) + view.angles:Up() * 100
			local EndPos = StartPos - view.angles:Forward() * radius
			
			local WallOffset = 4
	
			local tr = util.TraceHull( {
				start = StartPos,
				endpos = EndPos,
				filter = function( e )
					local c = e:GetClass()
					local collide = not c:StartWith( "prop_physics" ) and not c:StartWith( "prop_dynamic" ) and not c:StartWith( "prop_ragdoll" ) and not e:IsVehicle() and not c:StartWith( "gmod_" ) and not c:StartWith( "player" ) and not e.LFS
					
					return collide
				end,
				mins = Vector( -WallOffset, -WallOffset, -WallOffset ),
				maxs = Vector( WallOffset, WallOffset, WallOffset ),
			} )
			
			view.drawviewer = true
			view.origin = tr.HitPos
			
			if tr.Hit and not tr.StartSolid then
				view.origin = view.origin + tr.HitNormal * WallOffset
			end
			return view
		end
	end
	if not pod:GetThirdPersonMode() then

		view.drawviewer = false

		local gunners = self:GetGunnerSeat()
		
		local Driver = self:GetDriver()
		local Gunner = gunners:GetDriver()

		if ply == Driver then
			view.origin = self:LocalToWorld( Vector(-65,25,55) )
		elseif ply == Gunner then
			view.origin = self:LocalToWorld( Vector(-100,0,95) )
		else
			view.origin = self:LocalToWorld( Vector(-65,-25,55) )
		end
		
	return view
	end

	return view
end

function ENT:RemoveLight()
	if IsValid( self.projector ) then
		self.projector:Remove()
		self.projector = nil
	end
end

function ENT:OnRemove()
	self:SoundStop()
	
	self:RemoveLight()
end


local spotlight = Material( "effects/lfs_base/spotlight_projectorbeam" )
local glow_spotlight = Material( "sprites/light_glow02_add" )

function ENT:Draw()
	self:DrawModel()

	if self:GetBodygroup( 9 ) ~= 1 then 
		self:RemoveLight()

		return
	end

	if not IsValid( self.projector ) then
		local thelamp = ProjectedTexture()
		thelamp:SetBrightness( 20 ) 
		thelamp:SetTexture( "effects/flashlight/soft" )
		thelamp:SetColor( Color(255,255,255) ) 
		thelamp:SetEnableShadows( false ) 
		thelamp:SetFarZ( 2500 ) 
		thelamp:SetNearZ( 75 ) 
		thelamp:SetFOV( 80 )
		self.projector = thelamp
	end

	local StartPos = self:LocalToWorld( Vector(60,0,10.5) )
	local Dir = self:GetForward()

	render.SetMaterial( glow_spotlight )
	render.DrawSprite( StartPos + Dir * -10 , 220, 120, Color( 255, 255, 255, 255) )


	render.SetMaterial( spotlight )
	render.DrawBeam(  StartPos - Dir * 10,  StartPos + Dir * 800, 250, 0, 0.99, Color( 255, 255, 255, 10) ) 
	
	if IsValid( self.projector ) then
		self.projector:SetPos( StartPos )
		self.projector:SetAngles( Dir:Angle() )
		self.projector:Update()
	end
end



--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
