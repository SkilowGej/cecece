--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ITEM.Name = 'DC-15a Heavy'
ITEM.Price = 300000
ITEM.Model = 'models/gaminglight/vibroknives/w_vibroknife.mdl'
ITEM.WeaponClass = 'masita_dc15a_heavy'
ITEM.Material = 'luna_icons/entities/rw_sw_dc15le_o.png'
-- ITEM.SingleUse = false

function ITEM:OnBuy(ply)
	ply:Give(self.WeaponClass)
	ply:SelectWeapon(self.WeaponClass)
end

function ITEM:OnHolster(ply)
	ply:StripWeapon(self.WeaponClass)
end

function ITEM:OnEquip(ply)
	ply:Give(self.WeaponClass)
	ply:SelectWeapon(self.WeaponClass)
end

function ITEM:OnSell(ply)
	ply:StripWeapon(self.WeaponClass)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
