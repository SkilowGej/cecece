--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("rayshield_generators/config.lua")

function ENT:Initialize()
    self:SetModel("models/props/machine1.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    --self:SetMaterial("rayshield_generators/gold_texture") -- Need content for this material
    self:SetNWEntity("rs", NULL) -- Initialise the linked RS as an empty slot
    self:SetNWBool("remove_welds", false) -- Initialise the remove welds trait to false by default
    self:SetNWBool("take_all_damage", false) -- Initailise the take any damage trait to false by default
    self:SetNWInt("max_health", 500) -- Initialise max health to 500
    self:SetNWInt("health", 500) -- Initialise HP to 500
    self:SetNWBool("health_bar", false)
    self:EmitSound("enc_forcefield_idle")
    self.destroying = false

    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    end
end

function ENT:OnTakeDamage(dmginfo)
    local takedamage = self:GetNWBool("take_all_damage")
    if not rsgenconfig.laserEntities[dmginfo:GetInflictor():GetClass()] and not takedamage then return end -- If we are supposed to take damage from only lasers, check it's a laser

    if (not self.applyingDamage) then -- Avoiding infinite damage loop
        self.applyingDamage = true
        self:SetNWInt("health", self:GetNWInt("health") - dmginfo:GetDamage())
        self.applyingDamage = false
    end

    if self:GetNWInt("health") <= 0 and not self.destroying then
        self.destroying = true
        local explosion = ents.Create("env_explosion") -- All of this just generate an explosion effect (sound included)
        explosion:SetPos(self:GetPos())
        explosion:SetOwner(dmginfo:GetAttacker())
        explosion:Spawn()
        explosion:SetKeyValue("iMagnitude", "450")
        explosion:Fire("Explode", 0, 0)
        explosion:StopSound("enc_forcefield_idle")

        local rs = self:GetNWEntity("rs") -- Retrieve linked RS
        local removewelds = self:GetNWBool("remove_welds") -- Retrieve if we are removing welds
        if rs != NULL then -- If there is one, remove it
            if removewelds then
                local constEntities = constraint.GetAllConstrainedEntities(rs)
                for _, ent in pairs(constEntities) do
                    ent:Remove()
                end
            end

            rs:Remove()
        end

        -- for k, v in ipairs(player.GetAll()) do -- Notify all players that a generator has been destroyed
        --     v:ChatPrint("Generator został zniszczony!")
        -- end

        self:Remove() -- Finally, remove the generator entity
    end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
