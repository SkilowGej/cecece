--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ITEM.Name = 'Венок'
ITEM.Price = 1200000
ITEM.Material = 'luna_menus/scoreboard/donate/square15.png'

function ITEM:OnBuy(ply)
    ply:SetAvatarFrame(self.Material)
end

function ITEM:OnEquip(ply)
    ply:SetAvatarFrame(self.Material)
end

function ITEM:OnHolster(ply)
    ply:SetAvatarFrame('')
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
