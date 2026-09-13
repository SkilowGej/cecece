local FindMetaTable = FindMetaTable
local util_AddNetworkString = SERVER and util.AddNetworkString
local player_GetBySteamID64 = player.GetBySteamID64
local hook_Add = hook.Add
local hook_Remove = hook.Remove

metadata = metadata || {
	stored = {}
}

local stored, pcache, Sync, encode = metadata.stored, {} do
	local function Get(sid64, key, def)
		local stored = stored[sid64]
		return stored && stored[key] || def
	end

	local PLAYER = FindMetaTable("Player")
	function PLAYER:GetMetadata(key, def)
		return Get(self:SteamID64(), key, def)
	end

	metadata.Get = Get
	local net = net
	if (SERVER) then
		util_AddNetworkString("Metadata::Sync")
		local pairs, table_count = pairs, table.Count
		function Sync(ply, key, recipients)
			local sid64 = ply:SteamID64()
			net.Start("Metadata::Sync")
				net.WriteString(sid64)
				net.WriteBool(key ~= nil)
				if (key) then
					net.WriteString(key)
					net.WriteType(stored[sid64][key])
				else
					net.WriteUInt(table_count(stored[sid64]), 10)
					for k, v in pairs(stored[sid64]) do
						net.WriteString(k)
						net.WriteType(v)
					end
				end
			net[recipients && "Send" || "Broadcast"](recipients)
		end

		local prepared = {
			"UPDATE `metadata` SET `value` = %s, `type` = %s WHERE `sid64` = %s AND `key` = %s",
			"INSERT INTO `metadata` VALUES(%s, %s, %s, %s)"
		}

		local isvalid = IsValid
		local function GetCachedPlayerBySteamID64(sid64)
			local ply = pcache[sid64]
			if (isvalid(ply)) then return ply end
			ply = player_GetBySteamID64(sid64)
			pcache[sid64] = ply
			return ply
		end

		local typeid, format, query, sqlstr = TypeID, Format, sql.Query, SQLStr
		local function Set(sid64, key, value, recipients, nosave)
			local ply = GetCachedPlayerBySteamID64(sid64)
			if (isvalid(ply)) then
				stored[sid64][key] = value
				Sync(ply, key, recipients)
			end

			if (nosave) then return end
			if (value == nil) then
				query("DELETE FROM `metadata` WHERE sid64 = "..sid64.." AND key = "..key)
			else
				key = sqlstr(key)
				local data, type = query("SELECT `sid64` FROM `metadata` WHERE `sid64` = "..sid64.." AND `key` = "..key), typeid(value)
				query(data && format(prepared[1], sqlstr(encode(value, type)), type, sid64, key) || format(prepared[2], sid64, key, sqlstr(encode(value, type)), type))
			end
		end

		function PLAYER:SetMetadata(key, value, recipients, nosave)
			Set(self:SteamID64(), key, value, recipients, nosave)
		end

		function metadata.Wait(ply, cback)
			if (ply.IsFullyMetadataLoaded) then return end
			if (!ply.MetadataWait) then ply.MetadataWait = {} end
			ply.MetadataWait[#ply.MetadataWait + 1] = cback
		end

		PLAYER.SyncMetadata = Sync
		metadata.Set = Set
	else
		net.Receive("Metadata::Sync", function()
			local sid64 = net.ReadString()
			if (!stored[sid64]) then stored[sid64] = {} end

			if (net.ReadBool()) then
				stored[sid64][net.ReadString()] = net.ReadType()
			else
				local stored = stored[sid64]
				for i = 1, net.ReadUInt(10) do
					stored[net.ReadString()] = net.ReadType()
				end
			end
		end)
	end
end

if (CLIENT) then return end
hook_Add("Initialize", "Metadata::Init", function()
	sql.Query[[CREATE TABLE IF NOT EXISTS `metadata`(
	`sid64` CHAR(17) NOT NULL,
	`key` TINYTEXT,
	`value` BIGTEXT,
	`type` TINYINT)]]
	//hook_Remove("Initialize", "Metadata::Init")
end)

local safety_types do
	local vector, angle, color, unpack, split, json, unjson = Vector, Angle, Color, unpack, string.Split, util.TableToJSON, util.JSONToTable
	safety_types = {
		[1] = {e = tostring, d = tobool},
		[3] = {e = tostring, d = tonumber},
		[5] = {e = json, d = unjson},
		[11] = {e = tostring,
			d = function(ang)
				return angle(unpack(split(ang, " ")))
			end
		},
		[10] = {e = tostring,
			d = function(vec)
				return vector(unpack(split(vec, " ")))
			end
		},
		[255] = {e = tostring,
			d = function(rgb)
				return color(unpack(split(rgb, " ")))
			end
		}
	}
end

function encode(value, type)
	local encoder = safety_types[type]
	return encoder && encoder.e(value) || value
end

local function decode(value, type)
	local decoder = safety_types[type]
	return decoder && decoder.d(value) || value
end

local query, pairs, tonumber, players = sql.Query, pairs, tonumber, player.GetAll
hook_Add("PlayerInitialSpawn", "Metadata::Sync", function(ply)
	local sid64 = ply:SteamID64()
	local data, nstored = query("SELECT key, value, type FROM `metadata` WHERE sid64 = "..sid64), {}
	if (!data) then goto skip end

	for k, v in pairs(data) do
		nstored[v.key] = decode(v.value, tonumber(v.type))
	end

	::skip::
	stored[sid64] = nstored
	ply.IsFullyMetadataLoaded = true

	local players = players()
	for i = 1, #players do
		Sync(players[i], nil, ply)
	end
	Sync(ply, nil, players)

	local mdwait = ply.MetadataWait
	if (!mdwait) then return end
	for i = 1, #mdwait do
		mdwait[i](ply)
	end

	ply.MetadataWait = nil
end)

hook_Add("PlayerDisconnected", "Metadata::Clear", function(ply)
	if (ply.IsFullyMetadataLoaded) then
		local sid64 = ply:SteamID64()
		pcache[sid64], stored[sid64] = nil, nil
	end
end)