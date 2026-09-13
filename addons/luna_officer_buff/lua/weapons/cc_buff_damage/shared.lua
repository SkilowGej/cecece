--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()
SWEP.Base = "cc_buff_base"
SWEP.PrintName = "Aura Obrażenia"
SWEP.Category = "SUP • Aury"
SWEP.Author	= "KTKycT"
SWEP.Instructions = "PPM: Daj przyrost obrażeń o 15% na 10 sek."
SWEP.Spawnable = true

--Base buff params
SWEP.Buff_Radius = 200
SWEP.Buff_Coldown = 30
SWEP.Buff_Timer = 10
SWEP.Buff_Color = Color(217, 128, 4)
SWEP.Buff_Sound = function()
    return "luna_sound_effects/aura/start/aura_start_0" .. math.random(1,5) .. ".mp3"
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
