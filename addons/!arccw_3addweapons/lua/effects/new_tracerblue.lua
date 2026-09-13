--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

EFFECT.OuterMat				= "effects/drc_sw/plasma3"
EFFECT.InnerMat				= "effects/drc_sw/flash0"
EFFECT.CenterMat			= "effects/drc_sw/flash0"
EFFECT.PuffMat				= "effects/drc_sw/beam1"
EFFECT.BulletMat			= "effects/drc_sw/flash0"
EFFECT.ThirdPersonScale		= 0.5
EFFECT.FirstPersonScale		= 0.4
EFFECT.OuterSize			= 3
EFFECT.InnerSize			= 10
EFFECT.CenterSize			= 3
EFFECT.PuffSize				= 2
EFFECT.BulletSize			= 10
EFFECT.OuterCol				= Color(0, 150, 255, 255)
EFFECT.InnerCol				= Color(0, 150, 255, 255)
EFFECT.CenterCol			= Color(0, 150, 255, 255)
EFFECT.PuffCol				= Color(0, 150, 255, 255)
EFFECT.BulletCol			= Color(0, 150, 255, 255)
EFFECT.OuterLighting		= false
EFFECT.InnerLighting		= false
EFFECT.CenterLighting		= false
EFFECT.PuffLighting			= false
EFFECT.BulletLighting		= false
EFFECT.LifeTimeMul			= 0.25
EFFECT.SpeedMul				= 15
EFFECT.TotalTracerParticles	= 301
-- always add 1 to your intended particle count, as the final one is the bullet particle.

EFFECT.ImpactEffect = "drc_halo_lightrifle_impact"
EFFECT.MuzzleEffect = "drc_sw_muzzle_blue_lens"
EFFECT.ImpactSound 	= "vsw.sniper_impact"

function EFFECT:Init(data)
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	
	self.Size = self.ThirdPersonScale
	self.Speed = self.SpeedMul

	if data:GetEntity() == LocalPlayer():GetViewModel() then
		self.WeaponEnt = LocalPlayer():GetActiveWeapon()
		self.Size = self.FirstPersonScale
		self.Speed = (self.Speed*0.5) / self.Speed
	end
	self.StartPos = self.WeaponEnt:GetWeaponAttachment("muzzle").Pos
	self.EndPos = data:GetOrigin()
	self.Entity:SetRenderBoundsWS(self.StartPos, self.EndPos)
	
	if !IsValid(data:GetEntity()) then return end
	
	local subt = self.EndPos - self.StartPos
	
	self.Normal = subt:GetNormal()
	local muzang = self.Normal:Angle()
	self.StartTime = 0

	local weapon = data:GetEntity()
	local att = self.WeaponEnt:GetWeaponAttachment("muzzle")
	if att == nil then
		att = { Ang = Angle(0, 0, 0), }
	end

	if (IsValid(weapon) and (not weapon:IsWeapon() or not weapon:IsCarriedByLocalPlayer())) then
		local dist, pos, time = util.DistanceToLine(self.StartPos, self.EndPos, EyePos())
	end
	
	local ll = render.GetLightColor( self.StartPos ) * GetSF2LightLevel(0.05)
	local lla = ll.x + ll.y + ll.z / 3
	local mini = 200
	local smoketint = Vector(math.Clamp((200 * ll.x), mini, 200), math.Clamp((200 * ll.y), mini, 200), math.Clamp((200 * ll.z), mini, 200))
	
	local pos = Vector(0, 0, 0)
	
	local TracerSmoke = ParticleEmitter( self.StartPos )
	local blt = self.TotalTracerParticles-1
	local third = (self.TotalTracerParticles-1) / 3
	pos = self.StartPos
	for i = 0,self.TotalTracerParticles do
		local rnglight = math.Rand(0,lla * 500)
		local particle = TracerSmoke:Add( "particle/particle_smokegrenade", pos + Vector( math.random(0,0),math.random(0,0),math.random(0,0))) 
		if particle == nil then particle = TracerSmoke:Add( "particle/particle_smokegrenade", pos + Vector(   math.random(0,0),math.random(0,0),math.random(0,0) ) ) end
		if (particle) then
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetAirResistance( math.Rand(5,10) )  
			particle:SetStartSize(math.Rand(1,3) * self.Size)
			particle:SetEndSize(math.Rand(2, 6) * self.Size)
			particle.DoCustomLighting = false
			if i > blt then -- BE the BULLET.
				particle:SetMaterial(self.BulletMat)
				particle:SetVelocity(self.Normal * 20000 * self.Speed)
				particle:SetStartLength(150)
				particle:SetEndLength(150)
				particle:SetBounce(50)
				particle.TintCol = self.BulletCol
				particle:SetColor(self.BulletCol.r, self.BulletCol.g, self.BulletCol.b)
				particle:SetStartAlpha(self.BulletCol.a)
				particle:SetEndAlpha(self.BulletCol.a)
				particle:SetAirResistance(-1)
				particle:SetDieTime(0.25)
				particle:SetStartSize(3 * self.Size)
				particle:SetEndSize(3 * self.Size)
				particle.DoCustomLighting = self.BulletLighting
			elseif i < blt && i > third*2 then
				particle:SetMaterial(self.OuterMat)
				particle:SetStartSize(math.Rand(1,3) * self.Size * self.OuterSize)
				particle:SetEndSize(math.Rand(2, 6) * self.Size * self.OuterSize)
				particle:SetVelocity(self.Normal * math.Rand(0, 10000) * self.Speed) -- outer
				particle.TintCol = self.OuterCol
				particle:SetColor(self.OuterCol.r, self.OuterCol.g, self.OuterCol.b)
				particle:SetDieTime(math.Rand(2, 3) * self.LifeTimeMul)
				particle.DoCustomLighting = self.OuterLighting
			elseif i < (third*2)+1 && i > third*2 then
				particle:SetMaterial(self.InnerMat)
				particle:SetStartSize(math.Rand(1,3) * self.Size * self.InnerSize)
				particle:SetEndSize(math.Rand(2, 6) * self.Size * self.InnerSize)
				particle:SetVelocity(self.Normal * math.Rand(0, 7500) * self.Speed) -- inner
				particle.TintCol = self.InnerCol
				particle:SetColor(self.InnerCol.r, self.InnerCol.g, self.InnerCol.b)
				particle:SetDieTime(math.Rand(2, 3) * self.LifeTimeMul)
				particle.DoCustomLighting = self.InnerLighting
			else
				particle:SetMaterial(self.CenterMat)
				particle:SetStartSize(math.Rand(1,3) * self.Size * self.CenterSize)
				particle:SetEndSize(math.Rand(0, 1) * self.Size * self.CenterSize)
				particle:SetStartLength(math.Rand(50,200))
				particle:SetEndLength(math.Rand(200,400))
				particle:SetVelocity(self.Normal * math.Rand(0, 5000) * self.SpeedMul) -- center
				particle.TintCol = self.CenterCol
				particle:SetColor(self.CenterCol.r, self.CenterCol.g, self.CenterCol.b)
				particle:SetDieTime(math.Rand(2, 3) * self.LifeTimeMul)
				particle.DoCustomLighting = self.CenterLighting
			end
			if i < third then -- puffs
				particle:SetMaterial(self.PuffMat)
				particle.TintCol = self.PuffCol
				particle:SetColor(self.PuffCol.r, self.PuffCol.g, self.PuffCol.b)
				particle:SetStartSize(math.Rand(2,7) * self.Size * self.PuffSize)
				particle:SetEndSize(math.Rand(5, 12) * self.Size * self.PuffSize)
				particle:SetBounce(0.0001)
				particle.DoCustomLighting = self.PuffLighting
			end
			particle:SetLifeTime(0) 
			particle:SetLighting(false)
			particle:SetAngleVelocity( Angle(math.Rand(1,15)) ) 
			particle:SetRoll(math.Rand( 0, math.Rand(0.1,5) ))
			particle:SetGravity( Vector(0,0,0) ) 
			particle:SetCollide(true)
			
			particle:SetCollideCallback( function( part, hitpos, hitnormal )
				particle:SetDieTime(0)
			end )
			particle:SetNextThink(CurTime())
			particle:SetThinkFunction(function(part)
				if part.DoCustomLighting == true then
					local ll = render.GetLightColor(part:GetPos())
					local lla = ll.x + ll.y + ll.z / 3
					local mini = 1
					local smoketint = Vector(math.Clamp((200 * ll.x), mini, 255), math.Clamp((200 * ll.y), mini, 255), math.Clamp((200 * ll.z), mini, 255))
					local boost = 50
					smoketint.x = smoketint.x + (boost * lla)
					smoketint.y = smoketint.y + (boost * lla)
					smoketint.z = smoketint.z + (boost * lla)
					local col2 = Vector()
					smoketint = 255/smoketint
					col2.x = Lerp(smoketint.x, mini, particle.TintCol.r)
					col2.y = Lerp(smoketint.y, mini, particle.TintCol.g)
					col2.z = Lerp(smoketint.z, mini, particle.TintCol.b)
					part:SetColor(col2.x, col2.y, col2.z)
					part:SetNextThink(CurTime() + math.Rand(0.2, 1))
				end
			end)
		end
	end

	TracerSmoke:Finish()
	
	if self.ImpactSound then sound.Play(self.ImpactSound, self.EndPos) end
	
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

function EFFECT:PhysicsCollide()
	self:Remove()
end

function EFFECT:Think()
end

function EFFECT:Render()
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
