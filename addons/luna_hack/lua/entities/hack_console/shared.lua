--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.Spawnable = false 
ENT.AdminSpawnable = false

ENT.Category = "Other"

ENT.PrintName = "Hack Console"

function ENT:SetupDataTables()
    self:NetworkVar("String", 0, "ConsoleName")
    self:NetworkVar("Int", 0, "State")
    self:NetworkVar("Int", 1, "Type")
    self:NetworkVar("Int", 2, "AttemptLeft")
    self:NetworkVar("Float", 0, "StartTime")
    self:NetworkVar("Float", 1, "HackTime")
    self:NetworkVar("Float", 2, "CooldownTime")
    self:NetworkVar("Float", 4, "LastHoldTime")
    self:NetworkVar("Bool", 0, "CanRepeat")
    self:NetworkVar("Bool", 1, "WarningHold")
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
