--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Spawned Sign"
ENT.Author = "Mac"
ENT.Spawnable = false
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Text")
	self:NetworkVar("Vector", 0, "TColor")
	self:NetworkVar("Int", 0, "Type")
	self:NetworkVar("Int", 1, "Speed")
	self:NetworkVar("Int", 2, "Wide")
	self:NetworkVar("Int", 3, "On")
	self:NetworkVar("Int", 4, "FX")
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
