--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

-- Define SWEP settings
SWEP.PrintName = "Pole Siłowe"
SWEP.Author = "Wedge"
SWEP.Purpose = "To absorb damage."
SWEP.Instructions = "Left-click to attack."

SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Category = "SUP • Wyposażenie"-- Change this to your desired weapon category

SWEP.Primary.Ammo = ""
SWEP.Secondary.Ammo = ""
SWEP.Weight = 5

SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_arms.mdl"
SWEP.WorldModel = ""

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 0.2

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Delay = 0.1

SWEP.Slot = 0
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

function SWEP:Initialize()
end

function SWEP:PrimaryAttack()
    if SERVER then
        self.Owner:ConCommand("deploy_force_shield")
    end
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
end

function SWEP:SecondaryAttack()
    if SERVER then
        self.Owner:ConCommand("deploy_force_shield")
    end
    self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
