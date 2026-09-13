--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local ang

EFFECT.ParticleName = "weapon_melee_blur"

function EFFECT:Init(data)
    self.WeaponEnt = data:GetEntity()
    if not IsValid(self.WeaponEnt) then return end
    self.Attachment = data:GetAttachment() or 1
    self.Position = self:GetTracerShootPos(data:GetOrigin(), self.WeaponEnt, self.Attachment)

    if IsValid(self.WeaponEnt.Owner) then
        if self.WeaponEnt.Owner == LocalPlayer() then
            if not self.WeaponEnt:IsFirstPerson() then
                ang = self.WeaponEnt.Owner:EyeAngles()
                ang:Normalize()
                --ang.p = math.max(math.min(ang.p,55),-55)
                self.Forward = ang:Forward()
            else
                self.WeaponEnt = self.WeaponEnt.Owner:GetViewModel()
            end
            --ang.p = math.max(math.min(ang.p,55),-55)
        else
            ang = self.WeaponEnt.Owner:EyeAngles()
            ang:Normalize()
            self.Forward = ang:Forward()
        end
    end

    self.Forward = self.Forward or data:GetNormal()
    self.Angle = self.Forward:Angle()

    self.Right = self.Angle:Right()
    self.vOffset = self.Position
    dir = self.Forward

    ParticleEffectAttach( self.ParticleName, PATTACH_POINT_FOLLOW, self.WeaponEnt, self.Attachment)
end

function EFFECT:Think()
    return false
end

function EFFECT:Render()
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
