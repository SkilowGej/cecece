--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Haywire Grenade (Thrown)"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/weapons/star_wars_battlefront/ThermalDetonator_Thrown.mdl"
ENT.FuseTime = 1.5
ENT.ArmTime = 0
ENT.ImpactFuse = false

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
	    phys:SetMass(10)
            phys:Wake()
            phys:SetBuoyancyRatio(0)
        end

        self.kt = CurTime() + self.FuseTime
        self.at = CurTime() + self.ArmTime
    end
end

function ENT:PhysicsCollide(data, physobj)
    if SERVER then
        if data.Speed > 75 then
            self:EmitSound(Sound("weapons/star_wars_battlefront/common/imp_grenade_stone_0" .. math.random(1,3) .. ".wav"))
        elseif data.Speed > 25 then
            self:EmitSound(Sound("weapons/star_wars_battlefront/common/imp_grenade_dirt_0" .. math.random(1,3) .. ".wav"))
        end
		self:SetAngles(Angle(0,0,0))
        if self.at <= CurTime() and self.ImpactFuse then
            self:Detonate()
		
        end
    end
end

function ENT:Think()
    if SERVER and CurTime() >= self.kt then
        self:Detonate()
    end
end

function ENT:Detonate()
    if SERVER then
        if not self:IsValid() then return end
        local effectdata = EffectData()
            effectdata:SetOrigin( self:GetPos() )

        if self:WaterLevel() >= 1 then
            util.Effect( "WaterSurfaceExplosion", effectdata )
        else
            ParticleEffect( "astw2_swbf_explosion_emp", self:GetPos(), self:GetAngles() )
			sound.Play( "weapons/star_wars_battlefront/common/exp_ord_haywireGrenade.wav",  self:GetPos(), 100, 100 )

        end

        local attacker = self

        if self.Owner:IsValid() then
            attacker = self.Owner
        end

    	 -- util.BlastDamage(self, self.Owner, self:GetPos(), 65, 100)
	 local ent = self.Owner
	if !IsValid(ent) then ent = self end
	 local t = DamageInfo()
			t:SetDamage(185)
			t:SetDamageType(DMG_SHOCK)
			t:SetAttacker(ent)
			t:SetInflictor(self)
	util.BlastDamageInfo(t, self:GetPos(), 400)
	util.Decal( "Scorch", self:GetPos(), self:GetPos() - Vector(0, 0, 32), self )
		util.ScreenShake(self:GetPos(),18000,500,1.2,2048)
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
        self:DrawModel()
		
            cam.Start3D() -- Start the 3D function so we can draw onto the screen.
                render.SetMaterial( Material("effects/swbf/flare0") ) -- Tell render what material we want, in this case the flash from the gravgun
                render.DrawSprite( self:GetPos(), math.random(30, 40), math.random(30, 40), Color(50, 50, 155) ) -- Draw the sprite in the middle of the map, at 16x16 in it's original colour with full alpha.
            cam.End3D()
      
    end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
