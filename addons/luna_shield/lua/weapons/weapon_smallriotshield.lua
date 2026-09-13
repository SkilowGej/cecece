--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

if (CLIENT) then
	SWEP.PrintName = "Tarcza klonów"
	SWEP.Slot = 1
	SWEP.SlotPos = 2
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
    SWEP.Icon = "vgui/ttt/icon_nades" -- most generic icon I guess
end

SWEP.Category = "SUP • Ekwipunek"
SWEP.Author = "Black Tea"
SWEP.Instructions = "Right Click to Bash Entity"
SWEP.Purpose = "Right Click to Bash Entity"

SWEP.Spawnable = true

SWEP.Base = "shield_base"

SWEP.ViewModel = Model("models/weapons/c_arms_animations.mdl")
SWEP.WorldModel = Model("models/bshields/dshield.mdl")

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
