--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

-- очень жаль
sup_inv.ItemMeta = {}
sup_inv.ItemMeta.__index = sup_inv.ItemMeta
function RegisterItem(data)
    sup_inv.ItemMeta:Register(data)
end

function sup_inv.ItemMeta:Register(data)
    if data.class == 'none' then data.class = data.nicename end
    -- if sup_items[data.class] then return end
    sup_items[data.class] = data
    MsgC(Color(58, 187, 204), Format('| %s successfully registered in inventory!\n', data.nicename))
end

function sup_inv.GetBaseClass(class)
    return sup_items[class]
end

function sup_inv.ItemMeta:Recreate(class)
    if not sup_items[class] then
        MsgC(Color(255, 0, 0), '[INVENTORY] PRZEDMIOT ^' .. class .. '^ NIE ZAREJESTROWANY, NIE MOŻNA STWORZYĆ.\n')
        return
    end
    return setmetatable(table.Copy(sup_items[class]), sup_inv.ItemMeta)
end

function sup_inv.ItemMeta:AddAmount(amount)
    self.amount = math.max(self.amount + amount, 0)
end

function sup_inv.ItemMeta:SetAmount(amount)
    self.amount = math.max(amount, 0)
end

function sup_inv.ItemMeta:GetAmount()
    return self.amount or 1
end

function sup_inv.ItemMeta:GetType()
    return self.weptype
end

function sup_inv.ItemMeta:GetClass()
    return self.class
end

function sup_inv.ItemMeta:Use(ply, x, y, limb, target)
    if self:IsAmmo() and self.hiddenamount < 1 then
        ply:GetInventory():RemoveItem(x, y)
        return false
    end

    if self:IsMedicine() then
        if self.customuse and self.customuse(ply, limb, target) then
            ply:GetInventory():RemoveItem(x, y)
            timer.Simple(0.1, function() 
                target:GetOrganism():Sync(ply) 
            end)
        end
        return true
    end

    if self:IsWeapon() then
        ply:Give(self:GetClass(), true)
        ply:GetInventory():RemoveItem(x, y)
        return true
    end

    if self:IsConsum() then
        ply:Kick('эта консум)))')
        ply:GetInventory():RemoveItem(x, y)
        return true
    end

    if self:IsAmmo() then
        ply:GiveAmmo(self:GetAmount(), self.class, false, false)
        self.hiddenamount = self.amount
        -- self.hiddenamount = self:GetAmount() ~= 0 and self:GetAmount() or self.hiddenamount or 0
        ply:GetInventory():RemoveItem(x, y)
        self:SetAmount(0)
        -- self:SetAmount(0)
        -- PrintTable(self)
        return true
    end
    return false
end

function sup_inv.ItemMeta:IsWeapon()
    return self.type == 'weapon'
end

function sup_inv.ItemMeta:IsMedicine()
    return self.type == 'medicine'
end

function sup_inv.ItemMeta:IsConsum()
    return self.type == 'consum'
end

function sup_inv.ItemMeta:GetIcon()
    return self.icon
end

function sup_inv.ItemMeta:IsAmmo()
    return self.type == 'ammo'
end

function sup_inv.ItemMeta:GetModel()
    if self.model then return self.model end
    if not self.model and weapons.GetStored(self:GetClass()) then return weapons.GetStored(self:GetClass()).WorldModel end
    return 'models/props_junk/meathook001a.mdl'
end

function sup_inv.ItemMeta:GetName()
    return self.nicename
end

function sup_inv.ItemMeta:SetClip(amount)
    self.clip = amount
end

function sup_inv.ItemMeta:GetClip()
    return self.clip
end

function sup_inv.ItemMeta:GetWeight()
    return self.kg or 1
end

function sup_inv.GetByClass(class)
    return sup_items[class]
end

function sup_inv.NewItem(class)
    return sup_inv.ItemMeta:Recreate(class)
end

function sup_inv.GetByName(name)
    for k, v in pairs(sup_items) do
        if string.find(v.nicename:lower(), name:lower()) then return sup_inv.NewItem(k) end
    end
    return nil
end

function sup_inv.ValidItem(class)
    return sup_inv.GetByClass(class) ~= nil
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
