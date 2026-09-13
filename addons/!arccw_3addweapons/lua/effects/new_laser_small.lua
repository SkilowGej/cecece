--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

EFFECT.DoTracer				= true
EFFECT.TracerColor			= Color(0, 150, 200)
EFFECT.TracerChanceFP		= 1
EFFECT.TracerChanceTP		= 1
EFFECT.Speed 				= 5000
EFFECT.BaseMat				= "effects/drc_sw/lens_light0"
EFFECT.TailMat				= "effects/drc_sw/beam1"
EFFECT.BaseSize				= 1
EFFECT.TailWidth			= 2
EFFECT.TailLength 			= 100
EFFECT.FirstPersonScale		= 1
EFFECT.FirstPersonSpeed		= 0.5

EFFECT.TracerLight			= true
EFFECT.LightColor			= Color(0, 100, 255)
EFFECT.LightBrightness		= 1
EFFECT.LightSize			= 300

EFFECT.MuzzleEffect		= "drc_sw_muzzle_blue"
EFFECT.ImpactEffect		= nil
EFFECT.ImpactSound		= "vrc.bolt_impact"

EFFECT.Beams = {}
EFFECT.BeamLifeTime = 1

function EFFECT:Init(data)
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()

	if data:GetEntity() == LocalPlayer():GetViewModel() then
		self.WeaponEnt = LocalPlayer():GetActiveWeapon()
		self.BaseSize = self.BaseSize * self.FirstPersonScale
		self.TailWidth = self.TailWidth * self.FirstPersonScale
		self.Speed = self.Speed * self.FirstPersonSpeed
		if self.DoTracer == true && math.Rand(0, 1) > self.TracerChanceFP then self.DoTracer = false end
	else
		if self.DoTracer == true && math.Rand(0, 1) > self.TracerChanceTP then self.DoTracer = false end
	end
	self.StartPos = self.WeaponEnt:GetWeaponAttachment("muzzle").Pos
	self.EndPos = data:GetOrigin()
	self.Entity:SetRenderBoundsWS(self.StartPos, self.EndPos)
	self.TracerColor = self.WeaponEnt.EffectTint
	
	if self.ImpactSound then sound.Play(self.ImpactSound, self.EndPos) end
	
	local subt = self.EndPos - self.StartPos
	self.Normal = subt:GetNormal()
	self.StartTime = 0

	self.LifeTime = (subt:Length() + self.TailLength) / self.Speed
	local weapon = data:GetEntity()

	if (IsValid(weapon) and (not weapon:IsWeapon() or not weapon:IsCarriedByLocalPlayer())) then
		local dist, pos, thyme = util.DistanceToLine(self.StartPos, self.EndPos, EyePos())
	end
	
	if self.ImpactEffect then
		local ImpactData = EffectData()
		ImpactData:SetOrigin(self.EndPos)
		ImpactData:SetStart(self.StartPos)
		ImpactData:SetAttachment(data:GetAttachment())
		ImpactData:SetEntity(data:GetEntity())
		util.Effect(self.ImpactEffect, ImpactData)
	end
	
	if self.MuzzleEffect then
		local MuzzleData = EffectData()
		MuzzleData:SetOrigin(self.StartPos)
		MuzzleData:SetStart(self.EndPos)
		MuzzleData:SetAttachment(data:GetAttachment())
		MuzzleData:SetEntity(data:GetEntity())
		util.Effect(self.MuzzleEffect, MuzzleData)
	end
end

function EFFECT:Think()
	self.LifeTime = self.LifeTime - FrameTime()
	self.StartTime = self.StartTime + FrameTime()

	local endDistance = self.Speed * self.StartTime
	local endPos = self.StartPos + self.Normal * endDistance
	
	if self.TracerLight == true then
	local ParticleLight = DynamicLight(self:EntIndex())
		if (ParticleLight) then
			ParticleLight.pos = endPos
			ParticleLight.r = self.LightColor.r
			ParticleLight.g = self.LightColor.g
			ParticleLight.b = self.LightColor.b
			ParticleLight.brightness = self.LightBrightness
			ParticleLight.Decay = 1000
			ParticleLight.Size = self.LightSize
			ParticleLight.nomodel = 0
			ParticleLight.style = 6
			ParticleLight.DieTime = CurTime() + 3
		end
	else end
	
	self.BeamAlpha = 255 * ( 1 - self.LifeTime )
	
	if !self.Life then self.Life = 0.001 end
	self.Life = self.Life + FrameTime() / self.BeamLifeTime
	self.BeamAlpha = 255 * ( 1 - self.Life )
	return ( self.Life < 1 )
--	return self.LifeTime > 0
end


function EFFECT:Render()
	local endDistance = self.Speed * self.StartTime
	local startDistance = endDistance - self.TailLength
	
	startDistance = math.max(0, startDistance)
	endDistance = math.max(0, endDistance)
	
	local startPos = self.StartPos + self.Normal * startDistance
	local endPos = self.StartPos + self.Normal * endDistance
	
	if self.DoTracer == true && self.LifeTime > 0 then
		render.SetMaterial(Material(self.BaseMat))
		render.DrawSprite(endPos, 8 * self.BaseSize, 8 * self.BaseSize, self.TracerColor)
		render.SetMaterial(Material(self.TailMat))
		render.DrawBeam(startPos, endPos, self.TailWidth, 0, 1, self.TracerColor)
	end
	
	if self.Beams then
		for k,v in pairs(self.Beams) do
			local texcoord = math.Rand( 0, 1 )
			local norm = (self.StartPos - self.EndPos) * self.LifeTime
			v.Length = norm:Length()
			render.SetMaterial(Material(v.Mat))
			for i=1,v.Passes do
				render.DrawBeam( self.StartPos - self.WeaponEnt:GetWeaponAttachment("muzzle").Ang:Up(), 
				self.EndPos, 
				v.Width / 2, texcoord, 
				texcoord + ( ( self.StartPos - self.EndPos ):Length() / 128 ),
				Color(v.Colour.r, v.Colour.g, v.Colour.b, self.BeamAlpha))
			end
		end
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
