--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

util.AddNetworkString('inventory_update')
util.AddNetworkString('inventory_move')
util.AddNetworkString('inventory_action')
util.AddNetworkString('inventory_action2')
util.AddNetworkString('inventory_equip')
util.AddNetworkString('inventory_add_item')
local plymeta = FindMetaTable('Player')
local Inventory = {}
local sup_inv_cache = {}
Inventory.__index = Inventory
plymeta.pn = {}
function Inventory:New(ply, slots)
    local steamID = ply:SteamID64()
    local charID = ply.ActiveCharacterID
    if not IsValid(ply) then return end
    if not charID then charID = ply:GetNetVar('character') end
    if not charID then return end
    if not ply:CharacterByID(charID) then return end
    if not slots then slots = 5 end
    local invv = {
        cont = {},
        slots = slots,
        equip = {
            main = false,
            secondary = false,
            heavy = false,
            var = false,
            ammo = false
        },
        owner = ply,
        weight = 0,
        ownerid = ply:SteamID(),
    }

    for row = 1, slots do
        invv.cont[row] = {}
        for col = 1, slots do
            invv.cont[row][col] = false
        end
    end

    ply:SetNW2Int('supinv.maxslots', slots)
    local v = setmetatable(invv, Inventory)
    sup_inv_cache[steamID] = sup_inv_cache[steamID] or {}
    sup_inv_cache[steamID][charID] = v
    return v
end

function plymeta:ClearInventory(id)
    local steamID = self:SteamID64()
    local charID = self.ActiveCharacterID
    if id then
        sup_inv_cache[steamID] = nil
    else
        sup_inv_cache[steamID][charID] = nil
    end

    --[[ if sup_inv_cache[steamID] and sup_inv_cache[steamID][charID] then
        sup_inv_cache[steamID][charID] = nil
    end --]]
    self:InitInventory()
    self:SyncInventory()
end

hook.Add('PlayerDisconnected', 'inv.clearinventorylfl', function(ply) sup_inv_cache[ply:SteamID()] = nil end)
function Inventory:CheckOwner()
    if not IsValid(self.owner) then
        local steamID = self.ownerid
        sup_inv_cache[steamID] = nil
        return false
    end
    return true
end

local function availableslot(inv, x, y)
    local cont = inv:GetContainer()
    return not cont[y][x]
end

function Inventory:GetContainer()
    return self.cont
end

function Inventory:GetItem(x, y)
    return self.cont[y][x]
end

function Inventory:GetSlots()
    return self.slots
end

function Inventory:Owner()
    return self.owner
end

function Inventory:RemoveItem(x, y)
    if not self:CheckOwner() then return end
    local item = self:GetItem(x, y)
    if isbool(item) then return false end
    self:AddWeight(-(item:GetWeight() * (item:IsWeapon() and 1 or item.amount or 1)))
    self.cont[y][x] = false
    self:Owner():SyncInventory()
    return true
end

function Inventory:Contains(class)
    if not self:CheckOwner() then return end
    for y, row in ipairs(self.cont) do
        for x, slot in ipairs(row) do
            if not isbool(slot) and slot.class == class then return x, y end
        end
    end

    for _, item in pairs(self.equip) do
        if isbool(item) then continue end
        if item.class == class then return true end
    end
    return nil
end

function Inventory:GetByType(type, class)
    if not self:CheckOwner() then return end
    for y, row in ipairs(self.cont) do
        for x, slot in ipairs(row) do
            if not isbool(slot) and slot.weptype == type and slot.class == class then return x, y end
        end
    end
    return nil
end

function Inventory:GetWeight()
    return self.weight
end

function Inventory:AddWeight(val)
    self.weight = math.Clamp(self.weight + val, 0, 600)
end

function Inventory:Equip(slot, item)
    if not self:CheckOwner() then return end
    self.equip[slot] = item
    self:Owner():SyncInventory()
    if item:IsWeapon() then
        timer.Simple(.4, function()
            local w = self:Owner():GetWeapon(item:GetClass())
            if not IsValid(w) then return end
            w:SetClip1(item:GetClip() or 1)
            self:Owner():SelectWeapon(item:GetClass())
        end)
    end
    return true
end

function Inventory:GetEquipped(type)
    if not self:CheckOwner() then return end
    if not type then return end
    if not self.equip[type] then return end
    return self.equip[type]
end

function Inventory:UnEquip(slot, withrem)
    if not self:CheckOwner() then return end
    local ply = self:Owner()
    local eq = self:GetEquipped(slot)
    if withrem then
        self.equip[slot] = nil
        ply:StripWeapon(eq:GetClass())
        ply:SyncInventory()
        return
    end

    if type(eq) ~= 'table' then
        ErrorNoHalt('luna_inv/lua/sup_inv_core/sv/sv_inventory_main:Inventory:UnEquip Method: Expected slot to be a table, got', type(eq), '\n')
        return false
    end

    if eq and eq:IsWeapon() then
        if IsValid(ply:GetWeapon(eq:GetClass())) then self:Add(self.equip[slot]):SetClip(ply:GetWeapon(eq:GetClass()):Clip1()) end
        if ply:HasWeapon(eq:GetClass()) then ply:StripWeapon(eq:GetClass()) end
    elseif eq and eq:IsAmmo() then
        local amount = eq.amount
        local prevamount = ply:GetAmmoCount(eq:GetClass())
        self:AddWeight(self.equip[slot]:GetWeight() * prevamount)
        self:Add(self.equip[slot], prevamount):AddAmount(prevamount)
        ply:RemoveAmmo(prevamount - amount == 0 and amount or prevamount, eq:GetClass())
    end

    self.equip[slot] = nil
    ply:SyncInventory()
    return true
end

function Inventory:CheckPattern(pattern)
    if not self:CheckOwner() then return end
    local rows = #self.cont or 1
    local cols = #self.cont[1] or 1
    local pat_rows = #pattern
    local pat_cols = #pattern[1]
    for y = 1, rows - pat_rows + 1 do
        for x = 1, cols - pat_cols + 1 do
            local match = true
            for py = 1, pat_rows do
                for px = 1, pat_cols do
                    if pattern[py][px] and not self.cont[y + py - 1][x + px - 1] then
                        match = false
                    elseif not pattern[py][px] and self.cont[y + py - 1][x + px - 1] then
                        match = false
                    end
                end
            end

            if match then return true end
        end
    end
    return false
end

function Inventory:HasPattern(name)
    if not self:CheckOwner() then return end
    local pattern = patterns[name]
    if not pattern then return false end
    return self:CheckPattern(pattern)
end

function Inventory:Add(item, amount)
    if not self:CheckOwner() then return end
    local cont = self:GetContainer()
    if not item then return end
    amount = amount or 0
    for y = 1, #cont do
        for x = 1, #cont[y] do
            local slot = cont[y][x]
            if slot and slot:IsAmmo() and slot.class == item.class and item:IsAmmo() then
                slot.amount = (slot.amount or 1) + amount
                slot.hiddenamount = (slot.hiddenamount or 1) + amount
                self:AddWeight(slot:GetWeight() * (slot.amount or 1))
                self:Owner():SyncInventory()
                return slot
            end

            if not slot then
                cont[y][x] = item
                if item.amount and item:IsAmmo() then
                    self:AddWeight(item:GetWeight() * (item.amount or 1))
                elseif item:IsWeapon() then
                    self:AddWeight(item:GetWeight() * 1)
                end

                self:Owner():SyncInventory()
                return item
            end
        end
    end
    return false
end

local function domove(ply, oldX, oldY, newX, newY)
    local inv = ply:GetInventory()
    local item = inv:GetItem(oldX, oldY)
    if not item then
        ply:SyncInventory()
        return
    end

    if not availableslot(inv, newX, newY) then
        ply:SyncInventory()
        return
    end

    local cont = inv:GetContainer()
    cont[oldY][oldX] = false
    cont[newY][newX] = item
    ply:SyncInventory()
end

local function removeFunctions(t)
    for k, v in pairs(t) do
        if type(v) == 'table' then
            removeFunctions(v)
        elseif type(v) == 'function' then
            t[k] = nil
        end
    end
end

function plymeta:SyncInventory()
    local inventory = self:GetInventory()
    local cont = table.Copy(inventory.cont)
    local equip = table.Copy(inventory.equip)
    removeFunctions(cont)
    removeFunctions(equip)
    net.Start('inventory_update')
    net.WriteTable(cont)
    net.WriteInt(inventory:GetWeight(), 10)
    net.WriteTable(equip)
    net.Send(self)
end

function plymeta:GetInventory()
    local steamID = self:SteamID64()
    local charID = self.ActiveCharacterID
    if not self:Alive() then return end
    if not IsValid(self) then return end
    if not charID then charID = self:GetNetVar('character') end
    if not charID then return end
    if not self:CharacterByID(charID) then return end
    if charID and sup_inv_cache[steamID] and sup_inv_cache[steamID][charID] then return sup_inv_cache[steamID][charID] end
    if self:HasInventory() then return sup_inv_cache[steamID] and sup_inv_cache[steamID][charID] end
    return self:InitInventory()
end

function plymeta:HasInventory()
    local steamID = self:SteamID64()
    local charID = self.ActiveCharacterID
    return sup_inv_cache[steamID] and sup_inv_cache[steamID][charID] ~= nil
end

function plymeta:InitInventory(slots)
    return Inventory:New(self, slots)
end

net.Receive('inventory_move', function(_, ply)
    local itemid = net.ReadString()
    local oldX = net.ReadUInt(6)
    local oldY = net.ReadUInt(6)
    local newX = net.ReadUInt(6)
    local newY = net.ReadUInt(6)
    domove(ply, oldX, oldY, newX, newY)
end)

hook.Add('PlayerUse', 'supreme.pickup', function(ply, ent)
    if ply:KeyDown(IN_WALK) and sup_inv.ValidItem(ent:GetClass()) then
        ply:GetInventory():Add(sup_inv.Contains(ent:GetClass()))
        ent:Remove()
    end
end)

hook.Add('PlayerCanPickupWeapon', 'supreme.nopickup', function(ply, wep) return ply.pn[wep] end)
hook.Add('PlayerSpawn', 'inv.resetslots', function(ply)
    timer.Simple(.4, function()
        local inv = ply:GetInventory()
        if not inv then return end
        for slott, _ in pairs(inv.equip) do
            if isbool(slott) then continue end
            if isbool(inv.equip[slott]) then continue end
            if not slott then continue end
            local it = inv.equip[slott]
            if it:IsAmmo() then
                -- PrintTable(it)
                ply:GiveAmmo(it.hiddenamount, string.upper(it.class))
                continue
            end

            ply:Give(it.class)
        end

        ply:SyncInventory()
    end)
end)

net.Receive('inventory_action2', function(_, ply)
    local ac = net.ReadString()
    local typo = net.ReadString()
    local inv = ply:GetInventory()
    if ac == 'unequip' then inv:UnEquip(typo) end
end)

net.Receive('inventory_action', function(_, ply)
    local ac = net.ReadString()
    local x = net.ReadInt(6)
    local y = net.ReadInt(6)
    local typ = net.ReadString()
    local inv = ply:GetInventory()
    local item = inv:GetItem(x, y)
    if typ == 'trashbin' then
        inv:RemoveItem(x, y)
        return
    end

    if ac == 'use' and typ == 'medicine' then
        item:Use(ply, x, y, net.ReadString(), net.ReadPlayer())
        return
    end

    if ac == 'use' and item:IsWeapon() then ac = 'equip' end
    if ac == 'drop' and hook.Run('sup_inv.OnItemDropped', ply, x, y) then
        inv:RemoveItem(x, y)
        local ent = ents.Create(item:GetClass())
        ent:SetModel(item:GetModel())
        ent:SetPos(ply:GetBonePosition(ply:LookupBone('ValveBiped.Bip01_R_Hand')))
        ent:Activate()
        if item:IsWeapon() then ply.pn[ent] = true end
        ent:Spawn()
        ent:SetVelocity(ply:GetVelocity() * 150 + ply:GetAimVector() * 75)
        ply:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_GIVE)
        timer.Simple(1.2, function() if IsValid(ply) and item:IsWeapon() then ply.pn[ent] = nil end end)
    end

    if ac == 'use' then item:Use(ply, x, y) end
    if ac == 'equip' and not isbool(item) and not inv:GetEquipped(item:GetType()) then
        local slot = item:GetType()
        if item:Use(ply, x, y) then inv:Equip(slot, item) end
    end
end)

hook.Add('sup_inv.OnItemAdded', 'sup_inv.AddWeight', function(o, inv, item) inv:AddWeight(item:GetWeight() * item:GetAmount() or 1) end)
hook.Add('sup_inv.OnItemDropped', 'sup_inv.PerformDrop', function(ply, x, y) return true end)
net.Receive('inventory_equip', function(_, ply)
    local ac = net.ReadString()
    local _string = net.ReadString()
    local inv = ply:GetInventory()
    local x, y = inv:GetByType(ac, _string)
    local item = inv:GetItem(x, y)
    if not inv:GetEquipped(item:GetType()) and item:Use(ply, x, y) then inv:Equip(slot, item) end
end)

net.Receive('inventory_add_item', function(_, ply)
    local v = net.ReadString()
    local item = sup_inv.GetByClass(v) or sup_inv.GetByName(v)
    if not item then return end
    local inv = ply:GetInventory()
    inv:Add(sup_inv.NewItem(item.class), item.type == 'ammo' and item.giveamount)
end)

hook.Add('PostLoadCharacter', 'inventory.reinit', function(ply) ply:SyncInventory() end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
