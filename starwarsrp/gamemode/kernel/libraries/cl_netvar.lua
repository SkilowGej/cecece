local ENTITY = FindMetaTable("Entity")
local EntIndex = ENTITY.EntIndex

luna.netvar = luna.netvar or {}
luna.netvar.data = luna.netvar.data or {}
luna.netvar.global = luna.netvar.global or {}

local global = luna.netvar.global
local data = luna.netvar.data

function luna.netvar.GetGlobal(key, fallback)
    local value = global[key]

    if value ~= nil then
        return value
    end

    return fallback
end

function ENTITY:GetNetVar(key, fallback)
    local storage = data[EntIndex(self)]

    if storage and storage[key] ~= nil then
        return storage[key]
    end

    return fallback
end

function GetLocalVar(key, default)
    return LocalPlayer():GetNetVar(key, default)
end

do
    local ReadString = net.ReadString
    local ReadType = net.ReadType
    local ReadUInt = net.ReadUInt
    local Run = hook.Run

    TYPE_PON_STRING = 0x67

    net.Receive("netvar:SetGlobal", function()
        local key = ReadString()
        local value = ReadType()

        global[key] = value
    end)

    net.Receive("netvar:Set", function()
        local entIndex = ReadUInt(16)
        local key = ReadString()
        local typeID = net.ReadUInt( 8 )
        local value

        if (typeID == TYPE_PON_STRING) then
            value = pon.decode( net.ReadString() )
        else
            local reader = net.ReadVars[typeID]
            assert(reader, "net.ReadType: Couldn't read type (" .. typeID .. ", netvar: " .. key .. ")")
            value = reader()
        end

        if data[entIndex] == nil then
            data[entIndex] = {}
        end

        local old = data[entIndex][key]

        data[entIndex][key] = value

        Run("NetvarUpdate", entIndex, key, value, old)
    end)

    net.Receive("netvar:Remove", function()
        local entIndex = ReadUInt(16)

        data[entIndex] = nil
    end)
end