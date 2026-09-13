--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ITEM.Name = 'Кобура #2 (Правый)'
ITEM.Price = 65000
ITEM.Model = 'models/galactic/cosmetics/phase1cosmetics/heavy_leg_r.mdl'
ITEM.Bone = true
ITEM.Slot = 7

function ITEM:OnEquip(ply, modifications)
	ply:PS_AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:PS_RemoveClientsideModel(self.ID)

    -- PrintTable(PS.ClientsideModels)

    -- PS.ClientsideModels[ply][self.ID]:SetNoDraw(true)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
    -- model:SetParent(ply)
    -- model:AddEffects(EF_BONEMERGE)

	-- model:SetModelScale(0.8, 0)
	-- pos = pos + (ang:Right() * 5) + (ang:Up() * 6) + (ang:Forward() * 2)

	return model, pos, ang
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
