--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")



ENT.EngineGlow = Material( "sprites/light_glow02_add" )
ENT.LightGlow = Material( "sprites/light_glow02_add" )
ENT.LightMaterial = Material( "effects/lvs/laat_spotlight" )
ENT.Red = Color( 255, 0, 0, 255)
ENT.SignalSprite = Material( "sprites/light_glow02_add" )
ENT.Spotlight = Material( "effects/lvs/spotlight_projectorbeam" )

function ENT:Initialize()
	self.weelpos = 0
end

function ENT:OnFrame()

	self:AnimDrive()

end

function ENT:AnimDrive()
    if not self:GetEngineActive() then return end
	local driver = self:GetDriver()
	local speed = self:GetThrottle() * 12
	if IsValid(self:GetDriver()) then
		if self:GetAI() == false then
			if driver:KeyDown( 16 ) == true then 
				speed = speed * -1
			end
		end
	end
	self.weelpos = self.weelpos + speed
	if self.weelpos >= 360 then
		self.weelpos = 0
	end
	if self.weelpos <= -360 then
		self.weelpos = 0
	end

    local angl = Angle(self.weelpos, 0, 0)

	if self:GetThrottle() > 0.2 then 
		self:ManipulateBoneAngles(self:LookupBone("wheel_1_R"), angl)
		self:ManipulateBoneAngles(self:LookupBone("wheel_2_R"), angl)
		self:ManipulateBoneAngles(self:LookupBone("wheel_3_R"), angl)
		self:ManipulateBoneAngles(self:LookupBone("wheel_4_R"), angl)
		self:ManipulateBoneAngles(self:LookupBone("wheel_5_R"), angl)
	
		self:ManipulateBoneAngles(self:LookupBone("wheel_1_L"), -angl)
		self:ManipulateBoneAngles(self:LookupBone("wheel_2_L"), -angl)
		self:ManipulateBoneAngles(self:LookupBone("wheel_3_L"), -angl)
		self:ManipulateBoneAngles(self:LookupBone("wheel_4_L"), -angl)
		self:ManipulateBoneAngles(self:LookupBone("wheel_5_L"), -angl)
	end
end

function ENT:RemoveLight()
	if IsValid( self.projector ) then
		self.projector:Remove()
		self.projector = nil
	end

	if IsValid( self.frojector ) then
		self.frojector:Remove()
		self.frojector = nil
	end
end

ENT.LightMaterial = Material( "effects/lvs/laat_spotlight" )
ENT.GlowMaterial = Material( "sprites/light_glow02_add" )

ENT.LightMaterial = Material( "effects/lvs/laat_spotlight" )
ENT.GlowMaterial = Material( "sprites/light_glow02_add" )

function ENT:PreDrawTranslucent()
	if self:GetSpotlightToggle() == false then 
		self:RemoveLight()
		return false
	end

	if not IsValid( self.projector ) then
		local thelamp = ProjectedTexture()
		thelamp:SetBrightness( 35 ) 
		thelamp:SetTexture( "effects/flashlight/soft" )
		thelamp:SetColor( Color(255,255,255) ) 
		thelamp:SetEnableShadows( false ) 
		thelamp:SetFarZ( 10000 ) 
		thelamp:SetNearZ( 1 ) 
		thelamp:SetFOV( 100 )
		self.projector = thelamp
	end


	local Start1 = self:LocalToWorld( Vector(275,-125,150) )
	local Start2 = self:LocalToWorld( Vector(275,125,150) )

	local Dir1 = self:LocalToWorldAngles( Angle(0,5,0) ):Forward()
	local Dir2 = self:LocalToWorldAngles( Angle(0,-5,0) ):Forward()

	render.SetMaterial( self.GlowMaterial )
	render.DrawSprite( Start1, 32, 32, Color( 100, 100, 100, 255) )
	render.DrawSprite( Start2, 32, 32, Color( 100, 100, 100, 255) )

	render.SetMaterial( self.LightMaterial )
	render.DrawBeam( Start1,  Start1 + Dir1 * 400, 150, 0, 0.99, Color( 100, 100, 100, 5) ) 
	render.DrawBeam( Start2,  Start2 + Dir2 * 400, 150, 0, 0.99, Color( 100, 100, 100, 5) ) 

	if IsValid( self.projector ) then
		self.projector:SetPos( self:LocalToWorld( Vector(60,0,10.5) ) )
		self.projector:SetAngles( self:LocalToWorldAngles( Angle(15,0,0) ) )
		self.projector:Update()
	end

	return false
end

local COLOR_RED = Color(255,0,0,255)
local COLOR_WHITE = Color(255,255,255,255)


function ENT:CalcEngineSound( RPM, Pitch, Doppler )
	if self.ENG then
		self.ENG:ChangePitch(  math.Clamp(math.Clamp(  60 + Pitch * 50, 80,255) + Doppler,0,255) )
		self.ENG:ChangeVolume( math.Clamp( -1 + Pitch * 6, 0.5,1) )
	end
	
	if self.DIST then
		self.DIST:ChangePitch(  math.Clamp(math.Clamp(  50 + Pitch * 60, 50,255) + Doppler,0,255) )
		self.DIST:ChangeVolume( math.Clamp( -1 + Pitch * 6, 0,1) )
	end
end

function ENT:OnRemove()
	self:SoundStop()
	self:RemoveLight()
end

function ENT:SoundStop()
	if self.DIST then
		self.DIST:Stop()
	end
	
	if self.ENG then
		self.ENG:Stop()
	end
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
