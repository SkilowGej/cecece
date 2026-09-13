--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Obrazek"
ENT.Category = "SUP • Różne"
ENT.Author = "Pack"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
    self:NetworkVar( "String", 0, "URL" )
    self:NetworkVar( "Int", 0, "Opacity" )
    self:NetworkVar( "Vector", 0, "DecalColor" )
    self:NetworkVar( "Vector", 1, "Scale" )
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
