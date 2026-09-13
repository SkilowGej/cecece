--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")
util.PrecacheModel("models/heart/turbolaser_bolt.mdl")
util.PrecacheModel("models/heart/turbolaser_glow.mdl")

function ENT:Initialize()
    self.model = ClientsideModel("models/heart/turbolaser_bolt.mdl")
    self.model:SetModelScale(self:GetScale(), 0)

    self.glow = ClientsideModel("models/heart/turbolaser_glow.mdl")
    self.glow:SetModelScale(self:GetScale(), 0)
    self.glow:SetColor(Color(self:GetColR(), self:GetColG(), self:GetColB()))
end

function ENT:Draw()
    -- А тут пустенько :(
end

function ENT:Think()
    if not IsValid(self) or not IsValid(self.model) or not IsValid(self.glow) then
        self:OnRemove()
        return
    end

    self.model:SetPos(self:GetPos())
    self.model:SetAngles(self:GetAngles())

    self.glow:SetPos(self:GetPos())
    self.glow:SetAngles(self:GetAngles())
end

function ENT:OnRemove()
    if IsValid(self.model) then
        self.model:Remove()
    end
    if IsValid(self.glow) then
        self.glow:Remove()
    end
end

language.Add("heart_turbolaser", "Turbolaser")

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
