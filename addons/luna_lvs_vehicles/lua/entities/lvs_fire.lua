--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "LVS Fire"
ENT.Author = "Tic"
ENT.Information = "Custom Fire Entity"
ENT.Category = "[LVS]"

ENT.Spawnable = false
ENT.AdminOnly = false

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/props_junk/wood_crate001a.mdl")
        self:SetNoDraw(true)
        self:SetSolid(SOLID_NONE)

        self.StartTime = CurTime()

        -- Spawn a fire particle effect
        ParticleEffectAttach("fire_large_01", PATTACH_ABSORIGIN_FOLLOW, self, 0)

        -- Play fire sound (adjust path and settings as needed)
        self:EmitSound("ambient/fire/fire_med_loop1.wav")

        -- Damage entities within a radius every second
        local damageRadius = 100
        local damageAmount = 100

        local function FireDamage()
            if not IsValid(self) then return end  -- Check if the entity is still valid

            local attacker = game.GetWorld()
            for _, ent in pairs(ents.FindInSphere(self:GetPos(), damageRadius)) do
                if IsValid(ent) and (ent:IsPlayer() or ent:IsNPC() or ent:IsVehicle()) then
                    local dmginfo = DamageInfo()
                    dmginfo:SetDamage(damageAmount)
                    dmginfo:SetAttacker(attacker) -- Ensure a valid attacker
                    dmginfo:SetInflictor(self)
                    dmginfo:SetDamageType(DMG_BURN)
                    ent:TakeDamageInfo(dmginfo)
                end
            end
        end

        -- Timer to periodically apply damage
        self.damageTimer = timer.Create("lvs_fire_damage_" .. self:EntIndex(), 1, 0, FireDamage)

        -- Remove self and effects after x seconds
        timer.Simple(20, function()
            if IsValid(self) then
                self:StopSound("ambient/fire/fire_med_loop1.wav")
                self:Remove()

                -- Cleanup timer
                if IsValid(self.damageTimer) then
                    self.damageTimer:Remove()
                end
            end
        end)
    end

    function ENT:OnRemove()
        self:StopSound("ambient/fire/fire_med_loop1.wav")

        -- Cleanup timer if not already cleaned up
        if IsValid(self.damageTimer) then
            self.damageTimer:Remove()
        end
    end
end

if CLIENT then
    function ENT:Draw()
        -- Do not draw the model
    end
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
