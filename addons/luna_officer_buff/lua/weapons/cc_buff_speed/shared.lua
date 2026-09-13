--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()
SWEP.Base = "cc_buff_base"
SWEP.PrintName = "Przyspieszenie"
SWEP.Category = "SUP • Aury"
SWEP.Author	= "KTKycT"
SWEP.Instructions = "PPM: Daje otaczającym jednostkom 25% do prędkości biegu na minutę."
SWEP.Spawnable = true

--Base buff params
SWEP.Buff_Radius = 200
SWEP.Buff_Coldown = 30
SWEP.Buff_Timer = 10
SWEP.Buff_Color = Color(30, 186, 24)
SWEP.Buff_Sound = function()
    return "summe/officer_boost/will" .. math.random(1,3) .. ".mp3"
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
