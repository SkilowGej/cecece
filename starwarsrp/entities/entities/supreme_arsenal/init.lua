AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')
include('shared.lua')
util.AddNetworkString('Arenal.Networking-ammo')
function ENT:Initialize()
    self:SetModel('models/props_furniture/scifi_armory_weaponrack.mdl')
    self:DrawShadow(false)
    self:SetSolid(SOLID_BBOX)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
end

local function GetAmmoType(class)
    return weapons.GetStored(class).Primary.Ammo or weapons.Get(class).Primary.Ammo or 'pistol'
end

local function GetName(class)
    return weapons.GetStored(class).PrintName
end

local function GetPlayerWeapons(ply)
    if not IsValid(ply) then return {} end
    local job = re.jobs[ply:Team()]
    local jobWeapons = job and job.weaponcrate or {}
    local features = ply:GetNetVar('features') or {}
    local specialtyWeapons = {}
    for featureKey, hasFeature in pairs(features) do
        if hasFeature and FEATURES_TO_NORMAL[featureKey] then
            for _, weapon in ipairs(FEATURES_TO_NORMAL[featureKey].weapons or {}) do
                table.insert(specialtyWeapons, weapon)
            end
        end
    end

    local craftWeapons = ply:GetCharData('craft_weapons') or {}
    local allWeapons = {}
    for _, weapon in ipairs(jobWeapons) do
        allWeapons[weapon] = true
    end

    for _, weapon in ipairs(specialtyWeapons) do
        allWeapons[weapon] = true
    end

    for _, weapon in ipairs(craftWeapons) do
        allWeapons[weapon] = true
    end

    local result = table.GetKeys(allWeapons)
    return result
end

function ENT:Use(ply)
    if not (IsValid(ply) or ply:IsPlayer() or (ply.NextArsenalUse or 0) > CurTime()) then return end
    ply.NextArsenalUse = CurTime() + .95
    if ply:GetPos():DistToSqr(self:GetPos()) > Arsenal.Dist then return end
    local weapons = GetPlayerWeapons(ply)
    net.Start('Arenal.Networking-OpenMenu', true)
    net.WriteEntity(self)
    net.WriteUInt(#weapons, 8)
    for _, weapon in ipairs(weapons) do
        net.WriteString(weapon)
    end

    net.Send(ply)
end

scripted_ents.Register(ENT, 'supreme_arsenal')
util.AddNetworkString('Arenal.Networking-OpenMenu')
util.AddNetworkString('Arenal.Networking-Action')
hook.Add('PlayerDisconnected', 'Arenal.Hooks-ClearTables', function(ply)
    if not (IsValid(ply) or ply:IsPlayer() or ply.NextArsenalUse) then return end
    ply.NextArsenalUse = nil
end)

net.Receive('Arenal.Networking-ammo', function(_, ply)
    local class = net.ReadString()
    local inv = ply:GetInventory()
    if not inv then
        re.util.Notify('yellow', ply, 'Błąd: Nie udało się pobrać ekwipunku.')
        return
    end
    local ammo = GetAmmoType(class)
    if not ammo then
        re.util.Notify('yellow', ply, 'Błąd: Nie udało się pobrać typu amunicji.')
        return
    end
    local item = sup_inv.NewItem(string.upper(ammo), 1)
    if not item then
        re.util.Notify('yellow', ply, 'Błąd: Nie udało się stworzyć przedmiotu dla amunicji.')
        return
    end
    local base = sup_inv.GetBaseClass(string.upper(ammo))
    if not sup_inv.ValidItem(string.upper(ammo)) then
        re.util.Notify('yellow', ply, Format('[???] Ups, wygląda na to, że nie ma tego przedmiotu. Skontaktuj się z twórcą (!Skilow - dc) %s', ammo))
        return
    end
    local amountToAdd = (base and base.togive) or 1
    inv:Add(item, 1):AddAmount(amountToAdd)
    re.util.Notify('yellow', ply, Format('Wziąłeś naboje do %s!', GetName(class)))
    ply:SyncInventory()
end)


net.Receive('Arenal.Networking-Action', function(_, ply)
    if not IsValid(ply) then return end
    local ent = net.ReadEntity()
    if ent:GetClass() ~= 'supreme_arsenal' or ply:GetPos():DistToSqr(ent:GetPos()) > Arsenal.Dist then return end
    local action = net.ReadString()
    local availableWeapons = GetPlayerWeapons(ply)
    local inv = ply:GetInventory()
    if action == 'takeall' then
        for _, v in pairs(availableWeapons) do
            if sup_inv.BLOCKED[v] then
                ply:Give(v)
                continue
            end

            if inv:Contains(v) then continue end
            -- if ply:HasWeapon(v) then continue end
            -- ply:Give(v)
            --  if vaf(v) then ply:Give(v) continue end
            --if string.find(v, 'arrest') then ply:Give(v) continue end
            --if inv:Contains(v) then continue end
            --if not sup_inv.ValidItem(v) then continue end
            local i = sup_inv.NewItem(v, 1)
            if not i then continue end
            inv:Add(i)
        end

        re.util.Notify('yellow', ply, 'Zabrałeś całą broń z arsenału!')
    elseif action == 'returnall' then
        for _, v in pairs(availableWeapons) do
            if sup_inv.BLOCKED[v] then
                ply:StripWeapon(v)
                continue
            end

            local x, y = inv:Contains(v)
            if not x or not y then continue end
            local item = inv:GetItem(x, y)
            -- local baseclass = sup_inv.GetBaseClass(v)
            -- if not sup_inv.ValidItem(item) then continue end
            if inv:GetEquipped(item.weptype) then inv:UnEquip(item.weptype, true) end
            if inv:Contains(v) then timer.Simple(.2, function() inv:RemoveItem(x, y) end) end
        end

        re.util.Notify('yellow', ply, 'Zwróciłeś całą broń do arsenału!')
        ply:SelectWeapon('weapon_hands')
    elseif action == 'take' then
        local wep = net.ReadString()
        if table.HasValue(availableWeapons, wep) then
            if not ply:HasWeapon(wep) and sup_inv.BLOCKED[wep] then
                ply:Give(wep)
                return
            end

            local i = sup_inv.NewItem(wep, 1)
            if not inv:Contains(wep) and i and sup_inv.ValidItem(wep) then
                inv:Add(i)
                re.util.Notify('yellow', ply, 'Zabrałeś ' .. GetName(wep) .. ' z arsenału!')
            end
            --  if vaf(wep) then ply:Give(wep) return end
            --  if string.find(wep, 'arrest') then ply:Give(wep) return end inv:Add(sup_inv.NewItem(wep))
        end
    elseif action == 'return' then
        local wep = net.ReadString()
        if table.HasValue(availableWeapons, wep) then
            if sup_inv.BLOCKED[v] then
                ply:StripWeapon(wep)
                return
            end

            ply:StripWeapon(wep)
            local x, y = inv:Contains(wep)
            if not x or not y then return end
            local item = inv:GetItem(x, y)
            if inv:GetEquipped(item.weptype) then inv:UnEquip(item.weptype, true) end
            if inv:Contains(wep) then timer.Simple(.2, function() inv:RemoveItem(x, y) end) end
            re.util.Notify('yellow', ply, 'Zwróciłeś ' .. wep .. ' do arsenału!')
        end
    end
end)