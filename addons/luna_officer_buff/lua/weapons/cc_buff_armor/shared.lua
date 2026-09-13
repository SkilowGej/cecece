--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()
SWEP.Base = "cc_buff_base"
SWEP.PrintName = "Aura Tarczy"
SWEP.Category = "SUP • Aury"
SWEP.Author	= "KTKycT"
SWEP.Instructions = "PPM: Wzmocnić pancerz najbliższych jednostek o 150 jednostek."
SWEP.Spawnable = true

--Base buff params
SWEP.Buff_Radius = 200
SWEP.Buff_Coldown = 30
SWEP.Buff_Timer = 10
SWEP.Buff_Color = Color(66, 135, 245)
SWEP.Buff_Sound = function()
    return "luna_sound_effects/aura/phrases/fightasone.wav"
end
--/aura_start_0" .. math.random(1,5) .. ".mp3

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
