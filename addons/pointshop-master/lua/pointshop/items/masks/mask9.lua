--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ITEM.Name = 'Шапка Горит'
ITEM.Price = 650000
ITEM.Material = 'luna_menus/scoreboard/donate/mask9.png'

function ITEM:OnBuy(ply)
    ply:SetAvatarMask(self.Material)
end

function ITEM:OnEquip(ply)
    ply:SetAvatarMask(self.Material)
end

function ITEM:OnHolster(ply)
    ply:SetAvatarMask('')
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
