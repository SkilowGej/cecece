--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ITEM.Name = 'Отдых полезен'
ITEM.Price = 210000
ITEM.Material = 'luna_menus/scoreboard/banners/banner29.png'
ITEM.isBanner = true

function ITEM:OnBuy(ply)
    ply:AddBanner(self.Material)
    ply:SetCurrentBanner(self.Material)
end

function ITEM:OnEquip(ply)
    if ply:HasBanner(self.Material) then
        ply:SetCurrentBanner(self.Material)
    end
end

function ITEM:OnHolster(ply)
    ply:SetCurrentBanner('')
end

function ITEM:OnSell(ply)
    local banners = ply:GetBanners()
    banners[self.Material] = nil
    ply:SetBanners(banners)
    
    if ply:GetCurrentBanner() == self.Material then
        ply:SetCurrentBanner('')
    end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
