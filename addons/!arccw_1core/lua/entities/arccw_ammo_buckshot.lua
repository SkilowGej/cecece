--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

ENT.Base                      = "arccw_ammo"

ENT.PrintName                 = "Shotgun Ammo"
ENT.Category                  = "ArcCW - Ammo"

ENT.Spawnable                 = true
ENT.Model                     = "models/items/arccw/shotgun_ammo.mdl"

ENT.AmmoType = "buckshot"
ENT.AmmoCount = 20
if engine.ActiveGamemode() == "terrortown" then
    ENT.AmmoCount = 12
end

ENT.DetonationDamage = 80
ENT.DetonationRadius = 128
ENT.DetonationSound = "weapons/shotgun/shotgun_fire6.wav"

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
