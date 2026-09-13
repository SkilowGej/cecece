--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ENT.Type = "anim"

ENT.PrintName		= "Missel"
ENT.Category 		= "Arta"

ENT.Spawnable 	= false
ENT.AdminOnly 	= false

function ENT:SetupDataTables()
    self:NetworkVar( "Float", 0, "X" )
    self:NetworkVar( "Float", 1, "Y" )
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
