--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Sonic Projectile"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/weapons/star_wars_battlefront/thermaldetonator_thrown.mdl"
ENT.FuseTime = 3
ENT.ArmTime = 0

AddCSLuaFile()

function ENT:Initialize()
    if SERVER then
        self:SetModel( self.Model )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetCollisionGroup( COLLISION_GROUP_PROJECTILE )
        self:DrawShadow( true )

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
	phys:SetMass(3)
            phys:SetBuoyancyRatio(0)
            phys:EnableGravity( false )
        end

        self.kt = CurTime() + self.FuseTime
        self.motorsound = CreateSound( self, "weapons/star_wars_battlefront/cw/wpn_spderwalker_laser_lp.wav")
    end

    self.at = CurTime() + self.ArmTime
    self.Armed = false
end

function ENT:OnRemove()
    if SERVER then
        self.motorsound:Stop()
    end
end


function ENT:PhysicsCollide(data, physobj)
    if self.at <= CurTime() then
        self:Detonate()
    elseif self.at > CurTime() then
        -- local effectdata = EffectData()
            -- effectdata:SetOrigin( self:GetPos() )
        -- util.Effect( "RPGShotDown", effectdata)
        -- util.Effect( "StunstickImpact", effectdata)
        -- self:Remove()
    end
end

function ENT:Arm()
    if SERVER then
        self.motorsound:Play()
    end
end

function ENT:Think()

    if CurTime() >= self.at and !self.Armed then
        self:Arm()
        self.Armed = true
    end

    if SERVER then

        if self.Armed then
            local phys = self:GetPhysicsObject()
            phys:ApplyForceCenter( self:GetAngles():Forward() * 500 )
        end

        if CurTime() >= self.kt then
            self:Detonate()
        end
    end

    if CLIENT then
        if self.Armed then
		-- ParticleEffectAttach( "astw2_swbf_muzzle_rep_sniper", PATTACH_POINT_FOLLOW, self, 0 )
		local emitter = ParticleEmitter(self:GetPos())

            if !self:IsValid() or self:WaterLevel() > 2 then return end
		if self:IsValid() then
		local smoke = emitter:Add("effects/swbf/flare4", self:GetPos())
        smoke:SetGravity( Vector(math.Rand(-5, 5), math.Rand(-5, 5), math.Rand(-20, -25)) )
        smoke:SetVelocity( self:GetAngles():Forward() * 100 )
        smoke:SetDieTime( math.Rand(0.2,0.3) )
        smoke:SetStartAlpha( 40 )
        smoke:SetEndAlpha( 0 )
        smoke:SetStartSize( 10 )
        smoke:SetEndSize( 80 )
        smoke:SetRoll( math.Rand(-180, 180) )
        smoke:SetRollDelta( math.Rand(-0.2,0.2) )
        smoke:SetColor( math.random(125,150), 255, math.random(45,75) )
        smoke:SetAirResistance( 50 )
        smoke:SetPos( self:GetPos() )
        smoke:SetLighting( false )
        emitter:Finish()
		return 1 
        end
    end
end
end

function ENT:Detonate()
    if SERVER then
        if !self:IsValid() then return end
        local effectdata = EffectData()
            effectdata:SetOrigin( self:GetPos() )

        if self:WaterLevel() >= 1 then
            util.Effect( "WaterSurfaceExplosion", effectdata )
        else
            ParticleEffect( "astw2_swbf_explosion_cis_launcher", self:GetPos(), self:GetAngles() )
					sound.Play( "weapons/star_wars_battlefront/cw/wpn_cis_sonicblaster_fire.wav",  self:GetPos(), 55, 100 )

        end

        local attacker = self

        if self.Owner:IsValid() then
            attacker = self.Owner
        end

        	 -- util.BlastDamage(self, self.Owner, self:GetPos(), 65, 100)
	 local ent = self.Owner
	if !IsValid(ent) then ent = self end
	 local t = DamageInfo()
			t:SetDamage(55)
			t:SetDamageType(DMG_SHOCK)
			t:SetAttacker(ent)
			t:SetInflictor(self)
	util.BlastDamageInfo(t, self:GetPos(), 128)
	  -- local targets = ents.FindInSphere(self:GetPos(), 256)
        -- for _, k in pairs(targets) do
            -- if k:IsPlayer() or k:IsNPC() or scripted_ents.IsBasedOn( k:GetClass(), "base_nextbot" ) then
                -- local regen = FrameTime() * 900
                -- k:SetHealth( math.Clamp( k:Health() - regen, 0, k:GetMaxHealth()+k:GetMaxHealth() ) )
				-- if(SERVER) then
				-- k:Ignite( 10 )
				-- end
			-- if !k:IsPlayer() or !k:IsNPC() then
				-- end
            -- end
        -- end
        self:Remove()

    end
end

function ENT:Draw()
    if CLIENT then
        -- self:DrawModel()

        if self.Armed then
            cam.Start3D() -- Start the 3D function so we can draw onto the screen.
                render.SetMaterial( Material("effects/swbf/flare0") ) -- Tell render what material we want, in this case the flash from the gravgun
                render.DrawSprite( self:GetPos(), math.random(32, 64), math.random(32, 64), Color(175, 255, 100,25) ) -- Draw the sprite in the middle of the map, at 16x16 in it's original colour with full alpha.
            -- ParticleEffectAttach( "astw2_swbf_muzzle_imp_sniper", PATTACH_POINT_FOLLOW, self, 0 )
			cam.End3D()
        end
    end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
