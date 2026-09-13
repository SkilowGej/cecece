local PLAYER = FindMetaTable("Player")
local ENTITY = FindMetaTable("Entity")

luna.netvar = luna.netvar or {}
luna.netvar.data = luna.netvar.data or {}
luna.netvar.global = luna.netvar.global or {}

util.AddNetworkString("netvar:SetGlobal")
util.AddNetworkString("netvar:Set")
util.AddNetworkString("netvar:Remove")

local netvar = luna.netvar

local function syncAll(ply)
    for key, value in pairs(netvar.global or {}) do
        net.Start("netvar:SetGlobal")
        net.WriteString(key)
        net.WriteType(value)
        net.Send(ply)    
    end

    for key, value in pairs(netvar.data[ply] or {}) do
        net.Start("netvar:Set")
            net.WriteString(key)
            net.WriteType(value)
        net.Send(ply)
    end

    for ent, data in pairs(netvar.data) do
        if IsValid(ent) then
            for key, value in pairs(data) do
                net.Start("netvar:Set")
                    net.WriteString(key)
                    net.WriteType(value)
                net.Send(ply)
            end
        end
    end
end

function netvar.setGlobal(key, value)
    netvar.global[key] = value

    net.Start("netvar:SetGlobal")
	net.WriteString(key)
	net.WriteType(value)
    net.Broadcast()
end

function netvar.getGlobal(key, fallback)
    local value = netvar.global[key]

    if value != nil then
        return value
    end

    return fallback
end

function netvar.getReadyPlayers()
    local result = {}

    for _, ply in ipairs(player.GetAll()) do
        if ply.networkReady then
            table.insert(result, ply)
        end
    end

    return result
end

function ENTITY:GetNetVar(key, fallback)
    if key == "character" then
        PrintTable(netvar.data[self])
    end
    local publicStorage = netvar.data[self]
    local privateStorage = netvar.data[self]

    if self:IsPlayer() and privateStorage and privateStorage[key] != nil then
        return privateStorage[key]
    end

    if publicStorage and publicStorage[key] != nil then
        return publicStorage[key]
    end

    return fallback
end

function ENTITY:SetNetVar(key, value)
    netvar.data[self] = netvar.data[self] or {}
    netvar.data[self][key] = value

    net.Start("netvar:Set")
	    net.WriteUInt(self:EntIndex(), 16)
	    net.WriteString(key)
	net.WriteType(netvar.data[self] and netvar.data[self][key])

	net.Broadcast()
end

function PLAYER:SetLocalVar(key, value)
    netvar.data[self] = netvar.data[self] or {}
    netvar.data[self][key] = value

    net.Start("netvar:Set")
        net.WriteString(key)
        net.WriteType(value)
    net.Send(self)
end

function ENTITY:RemoveNetVar()
    netvar.data[self] = nil

    net.Start("netvar:Remove")
        net.WriteUInt(self:EntIndex(), 16)
    net.Broadcast()
end

do
    local function get_hook_name(ply)
        return ("luna.netvar.Check_" .. ply:SteamID64())
    end

    hook.Add("PlayerInitialSpawn", "luna.netvar.GetNetworkReady", function(ply)
        hook.Add("SetupMove", get_hook_name(ply), function(ply2, mvd, cmd)
            if ply == ply2 and not cmd:IsForced() then
                hook.Run("PlayerNetworkReady", ply2)
                hook.Remove("SetupMove", get_hook_name(ply2))
                ply2.networkReady = true
            end
        end)
    end)
end

hook.Add("PlayerNetworkReady", "luna.netvar.Sync", function(ply)
    syncAll(ply)
end)

hook.Add("EntityRemoved", "luna.netvar.Clear", function(ent)
    ent:RemoveNetVar()
end)