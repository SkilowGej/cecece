--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ITEM.Name = 'Описание Таблицы Игроков'
ITEM.Price = 500000
ITEM.Description = 'Описание Игрока'
ITEM.Material = 'luna_ui_base/etc/talk.png'

function ITEM:OnBuy(ply)
    ply:SetScoreboardDescription(self.Description)
end

function ITEM:OnEquip(ply)
    ply:SetScoreboardDescription(self.Description)
end

function ITEM:OnHolster(ply)
    ply:SetScoreboardDescription('')
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
