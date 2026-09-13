--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()
SWEP.PrintName = "CC - BuffBase"
SWEP.Category = "SUP • Aury"
SWEP.Author = "KTKycT"
SWEP.Instructions = "Its just a BUFF base"
SWEP.Spawnable = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Slot = 4
SWEP.SlotPos = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.ViewModel = "models/weapons/c_medkit.mdl"
SWEP.WorldModel = ""
SWEP.HoldType = "normal"

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

SWEP.UseHands = false
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
--Base buff params
SWEP.Buff_Radius = 300
SWEP.Buff_Coldown = 30
SWEP.Buff_Timer = 10
SWEP.Buff_icon = Material("luna_ui_base/etc/interdiction.png", "noclamp smooth")
SWEP.Buff_Color = Color(255, 255, 255, 155)
SWEP.Buff_Sound = nil

if CLIENT then
	function SWEP:ShouldDrawViewModel()
		return false
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
