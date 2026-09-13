--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()
SWEP.Base = "cc_buff_base"
SWEP.PrintName = "Ulepszenie zdrowia"
SWEP.Category = "SUP • Aury"
SWEP.Author	= "KTKycT"
SWEP.Instructions = "PPM: Daj regenerację otaczającym jednostkom 10/sek na 10 sekund."
SWEP.Spawnable = true

--Base buff params
SWEP.Buff_Radius = 200
SWEP.Buff_Coldown = 30
SWEP.Buff_Timer = 10
SWEP.Buff_Color = Color(201, 10, 39)
SWEP.Buff_Sound = function()
    return "luna_sound_effects/aura/phrases/wefightwewin.wav"
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
