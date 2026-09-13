--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"

ENT.Category		= "[SWRP] Emplacements"
ENT.PrintName 		= "Clone Wars E-Web"
ENT.Author			= "JohnyReaper & Macieg"
ENT.Spawnable		= true
ENT.AdminSpawnable	= false

ENT.TurretFloatHeight=0
ENT.TurretModelOffset=Vector(0,-50,50)
ENT.TurretTurnMax=0.7

ENT.LastShot=0
ENT.ShotInterval=0.15

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:SetupDataTables()
	self:NetworkVar("Entity",0,"Shooter")
	self:NetworkVar("Entity",1,"ShootPos")
	self:NetworkVar("Entity",2,"TurretBase")
	self:NetworkVar( "Int", 0, "TAmmo" )
end

-- function ENT:SetShooter(plr)
-- 	self.Shooter=plr
-- 	self:SetDTEntity(0,plr)
-- end

function ENT:GetShooter(plr)
	if SERVER then
		return self:GetShooter()
	elseif CLIENT then
		return self:GetShooter()
	end
end


function ENT:Use(plr)
	
	if not self:ShooterStillValid() then
		self:SetShooter(plr)
		self:StartShooting()
		self.ShooterLast=plr
		
		
	else
		if plr==self:GetShooter() then
			self:SetShooter(nil)
			self:FinishShooting()
			
		end
	end
end


function ENT:ShooterStillValid()
	local shooter=nil
	if SERVER then
		shooter=self:GetShooter()
	elseif CLIENT then
		shooter=self:GetShooter()
	end
--self.shootPos:GetPos():DistToSqr(shooter:GetPos()) >= 20000 )
	return IsValid(shooter) and shooter:Alive() and (self:GetPos():DistToSqr(shooter:GetPos()) <= 7000)-- ((self:GetPos()+self.TurretModelOffset):DistToSqr(shooter:GetShootPos())<=600)
end

function ENT:GetCrosshairFilterEnts()
	return {self, self.turretBase, self.shootPos}
end

function ENT:LVSFireBullet( data )
	data.Entity = self
	data.Velocity = data.Velocity + self:GetVelocity():Length()
	-- data.Filter = self:GetCrosshairFilterEnts()
	data.SrcEntity = self:WorldToLocal( data.Src )

	LVS:FireBullet( data )
end

function ENT:DoShot()
	
	
	if self.LastShot+self.ShotInterval<CurTime() then

		if (SERVER) then

			if (self:GetTAmmo() > 0) then

				-- if SERVER then
					
					local effectPosAng=self:GetAttachment(self.MuzzleAttachment)

					-- local BonePos, BoneAng = self:GetBonePosition(1)
					-- if BonePos == self:GetPos() then
					-- 	BonePos, BoneAng = self:GetBoneMatrix(1):GetTranslation()
					-- end

					local vPoint = effectPosAng.Pos
					-- local effectdata = EffectData()
					-- effectdata:SetStart( vPoint )
					-- effectdata:SetOrigin( vPoint )
					-- effectdata:SetAngles(effectPosAng.Ang)
					-- effectdata:SetEntity(self)
					-- effectdata:SetScale( 1 )
					-- util.Effect( "MuzzleEffect", effectdata )

					local effectdata = EffectData()
					-- effectdata:SetStart( vPoint )
					effectdata:SetStart( Vector(50,50,255) )
					effectdata:SetOrigin( vPoint )
					effectdata:SetNormal( self.shootPos:GetAngles():Forward()*100 )
					effectdata:SetAngles(effectPosAng.Ang)
					effectdata:SetEntity( self )
					effectdata:SetScale( 100 )
					util.Effect( "lvs_muzzle_colorable", effectdata )
					
				--elseif SERVER then
					self:EmitSound(self.ShotSound,50,100)
					
					
				-- end
				
				if IsValid(self.shootPos) and SERVER then

					local dir = (self:GetDesiredShootPos() - self.shootPos:GetPos()):GetNormalized()
					
					-- if (LVS) then

					-- 	local bullet = {}
					-- 	bullet.Src 	= self.shootPos:GetPos() + self.shootPos:GetAngles():Forward()*10
					-- 	bullet.Dir 	= self.shootPos:GetAngles():Forward()*1
					-- 	bullet.Spread 	= Vector( 0.02,  0.02, 0 )
					-- 	bullet.Tracer = 1
					-- 	bullet.TracerName = "lvs_laser_blue_short"
					-- 	bullet.Force	= 2
					-- 	bullet.HullSize 	= 30
					-- 	bullet.Damage	= 50
					-- 	bullet.SplashDamage = 200
					-- 	bullet.SplashDamageRadius = 200
					-- 	bullet.Velocity = 8000
					-- 	bullet.Attacker 	= self.Shooter
					-- 	bullet.Callback = function(att, tr, dmginfo)
					-- 		local effectdata = EffectData()
					-- 			effectdata:SetStart( Vector(50,50,255) ) 
					-- 			effectdata:SetOrigin( tr.HitPos )
					-- 		util.Effect( "lvs_laser_explosion", effectdata )
					-- 	end
					-- 	self:LVSFireBullet( bullet )


					-- else

						self.shootPos:FireBullets({
							Num=1,
							Src=self.shootPos:GetPos()+self.shootPos:GetAngles():Forward()*40,
							Dir=self.shootPos:GetAngles():Forward()*1,
							Spread=Vector(0.02,0.02,0),
							-- Tracer=1,
							-- TracerName = "lvs_laser_blue_short",
							HullSize 	= 30,
							Force=2,
							Damage=50,
							Attacker=self.Shooter,
							Callback=function(attacker,trace,dmginfo) 
								--if CLIENT then
										
									local effectdata = EffectData()
										effectdata:SetStart( Vector(50,50,255) ) 
										effectdata:SetOrigin( trace.HitPos )
									util.Effect( "lvs_laser_explosion", effectdata )

									local tracerEffect=EffectData()
									tracerEffect:SetStart(self.shootPos:GetPos())
									tracerEffect:SetOrigin(trace.HitPos)
									-- tracerEffect:SetScale(6000)
									util.Effect("blue_tracer_fx",tracerEffect)
								--end
								
							end
						})
					-- end

					self:TakeAmmo()

					self:GetPhysicsObject():ApplyForceCenter( self:GetRight()*-500 )
					
					
				end
			else
				self:EmitSound(self.EmptySound,50,100)
			end
		end

		self.LastShot=CurTime()
	end
	
end



function ENT:Think()
    if not IsValid(self.turretBase) and SERVER then
        SafeRemoveEntity(self)
    else
        if IsValid(self) then
            if SERVER then
                self.BasePos = self.turretBase:GetPos()
                self.OffsetPos = self.turretBase:GetAngles():Up() * 1

                if self.MagazineCollider then
                    self.MagazineCollider:SetPos(self.turretBase:GetPos() + self.turretBase:GetUp() * 5 + self.turretBase:GetForward() * 10 + self.turretBase:GetRight() * -80)
                    self.MagazineCollider:SetAngles(self.turretBase:GetAngles() + Angle(0, 90, 0))
                end
            end
            
            if self:ShooterStillValid() then
                if SERVER then
                    local offsetAng = (self:GetAttachment(self.MuzzleAttachment).Pos - self:GetDesiredShootPos()):GetNormal()
                    local offsetDot = self.turretBase:GetAngles():Right():DotProduct(offsetAng)
                    local HookupPos = self:GetAttachment(self.HookupAttachment).Pos
                    
                    local offsetAngNew = offsetAng:Angle()
                    offsetAngNew:RotateAroundAxis(offsetAngNew:Up(), -90)
                    
                    self.OffsetAng = offsetAngNew
                    local Vertical = math.Clamp(self.OffsetAng.z, -31, 30)
                    self:ManipulateBoneAngles(1, Angle(0, Vertical, 0))
                end
                
                self.Firing = self:GetShooter():KeyDown(IN_ATTACK)
                
            else
                self.Firing = false
                if SERVER then
                    self:SetShooter(nil)
                    self:FinishShooting()
                end
            end
            
            if self.Firing then
                self:DoShot()
            end
            self:NextThink(CurTime())
            return true
        end
    end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
