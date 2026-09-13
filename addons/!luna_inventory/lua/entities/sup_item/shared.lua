--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ENT.Type = 'anim'
ENT.Base = 'base_gmodentity'
ENT.PrintName = 'Dropped item'
ENT.Author = 'arlekin4'
ENT.Spawnable = false
-- function ENT:SetupDataTables()
--     self:NetworkVar('Int', 0, 'amount')
--     self:NetworkVar('String', 0, 'WeaponClass')
-- end
function ENT:Draw()
    self:DrawModel()
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
