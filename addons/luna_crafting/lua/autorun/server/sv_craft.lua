--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if CLIENT then return end
--[[
Уважаемый чувачёк или чувиха который сюда глазками смотрит,
Этот аддон разработан специально для проекта Renaissance лично Котэ#4440.
Да это мой дискордик :3
Пиздеть у них не надо, лучши напиши мне и мы договоримся об оплате твоих мечтаний.
Надеюсь ты усёк, я же и сервера ломать могу, понимаешь))?
]]
--------------CONFIG----------------------
--SCRAP
--Минимальное количество скрапа в 1 штуке
kotecraftsysminscrap = 1
--Максимальное количество скрапа в 1 штуке
kotecraftsysmaxscrap = 3
--Максимальное количество на карте
kotecraftsysmaxmapscrap = 16
--SCRAP
--MAP
kotecraftsysbasemap = "rp_arcanatura_sup_v2"
--MAP
--CRAFT
--Множитель возврата за повторку
kotecraftsysrepeatreturn = 0.5
--Множитель возврата за ничего
kotecraftsysnonereturn = 0.15
--CRAFT
--------------CONFIG----------------------
--SQL
---ПОКДЛЮЧЕНИЕ К БАЗЕ ДАННЫХ------------------------------------------------------
require("mysqloo")
koteserverdatabse = mysqloo.connect(database.ip, database.username, database.password, database.tbl, database.port)
koteserverdatabse:connect()
---ПОКДЛЮЧЕНИЕ К БАЗЕ ДАННЫХ------------------------------------------------------
local kotesqlconnect = koteserverdatabse:query("CREATE TABLE `kote_craftsystem_users` (`steamid64` varchar(40) COLLATE utf8mb4_general_ci NOT NULL, `scrap` int NOT NULL DEFAULT '0') ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;")
kotesqlconnect:start()
--SQL
hook.Add("PlayerAuthed", "kotecraftsyssetupdatabase", function(ply, steamid, uniqueid)
	local kotesqlconnect = koteserverdatabse:query("SELECT * FROM `kote_craftsystem_users` WHERE `steamid64` = '" .. ply:SteamID64() .. "'")
	function kotesqlconnect:onSuccess(data)
		if data[1] == nil then
			local kotesqlconnect = koteserverdatabse:query("INSERT INTO `kote_craftsystem_users`(`steamid64`, `scrap`) VALUES ('" .. ply:SteamID64() .. "',0)")
			kotesqlconnect:start()
			ply:SetNW2Int("kotecraftsys_scrap", 0)
		else
			ply:SetNW2Int("kotecraftsys_scrap", data[1]["scrap"])
		end
	end

	kotesqlconnect:start()
end)

function kotecraftsysgivescarp(ply, scrap)
	ply:SetNW2Int("kotecraftsys_scrap", ply:GetNW2Int("kotecraftsys_scrap", 0) + math.ceil(scrap))
	local kotesqlconnect = koteserverdatabse:query("UPDATE `kote_craftsystem_users` SET `scrap`= kote_craftsystem_users.scrap + " .. math.ceil(scrap) .. " WHERE `steamid64` = '" .. ply:SteamID64() .. "'")
	kotesqlconnect:start()
end

function kotecraftsysremovescarp(ply, scrap)
	ply:SetNW2Int("kotecraftsys_scrap", ply:GetNW2Int("kotecraftsys_scrap", 0) - math.ceil(scrap))
	local kotesqlconnect = koteserverdatabse:query("UPDATE `kote_craftsystem_users` SET `scrap`= kote_craftsystem_users.scrap - " .. math.ceil(scrap) .. " WHERE `steamid64` = '" .. ply:SteamID64() .. "'")
	kotesqlconnect:start()
end

-- util.AddNetworkString("kotecraftsys_scrapgive")
-- net.Receive("kotecraftsys_scrapgive", function()
-- local plys = net.ReadEntity()
-- local plyr = net.ReadEntity()
-- local scraps = net.ReadInt(32)
-- if scraps > plys:GetNW2Int("kotecraftsys_scrap", 0) then return end
-- kotecraftsysremovescarp(plys, scraps)
-- kotecraftsysgivescarp(plyr, scraps)
-- end)
local function kotesystemspawnscrap()
	local koteallscrappointsmassive = {}
	local kotecraftsysscrapcount = 0
	for isp, ksp in ipairs(ents.GetAll()) do
		---ПЕРВЫЙ ФОР
		if ksp:GetClass() == "kote_scrap_point" and ksp:GetNW2Int("kotecraftsys_spawnedscarp", 0) == 0 then table.insert(koteallscrappointsmassive, ksp) end
		if ksp:GetClass() == "kote_scrap" then kotecraftsysscrapcount = kotecraftsysscrapcount + 1 end
		---ПЕРВЫЙ ФОР
	end

	local createscrap = kotecraftsysmaxmapscrap - kotecraftsysscrapcount
	if createscrap <= 0 then return end
	for i = 0, createscrap do
		local kotespawnpoint = table.Random(koteallscrappointsmassive)
		if IsValid(kotespawnpoint) == false then return end
		if kotespawnpoint:GetNW2Int("kotecraftsys_spawnedscarp", 0) == 0 then
			local ent = ents.Create("kote_scrap")
			ent:SetPos(kotespawnpoint:GetPos() - Vector(0, 0, 10))
			ent:SetOwner(kotespawnpoint)
			kotespawnpoint:DeleteOnRemove(ent)
			kotespawnpoint:SetNW2Int("kotecraftsys_spawnedscarp", 1)
			ent:Spawn()
		end
	end
end

timer.Create("kotecraftsysscrapspawncontroller", 320, 0, function() kotesystemspawnscrap() end)
-------------------------------------------------------SCRAPSTATION-------------------------------------------------------
util.AddNetworkString("kotecraftsystem_opencraftmenu")
util.AddNetworkString("kotecraftsystem_opencraftfinalmenu")
local function giveitemininventory(ply, itemclass)
	ply:Give(itemclass, true, true)
	-- if sup_inv.GetBaseClass(itemclass) then ply:GetInventory():Add(sup_inv.NewItem(itemclass)) end
	ply:UpdateCharData("craft_weapons", function(pData)
		pData["craft_weapons"] = pData["craft_weapons"] or {}
		table.insert(pData["craft_weapons"], itemclass)
		return pData["craft_weapons"]
	end)
end

--Сюда поместить функцию помещения выигранного предмета в инвентарь
local function checkitemininventory(ply, itemclass)
	local craft_weapons = ply:GetCharData("craft_weapons")
	if not craft_weapons then return false end
	--Сюда поместить проверку наличия оружия в инвентаре (функция должна вернуть true если предмет есть)
	return table.HasValue(craft_weapons, itemclass)
end

util.AddNetworkString("kotecraftsystem_wanttocraft")
net.Receive("kotecraftsystem_wanttocraft", function()
	local ply = net.ReadEntity()
	local rarity = net.ReadString()
	local cost = 0
	local weapon = {}
	if rarity == "COMMON" then
		cost = kotecraftsystemcommoncraftcost
		weapon = table.Random(kotecraftsyscommonweapons)
	elseif rarity == "RARE" then
		cost = kotecraftsystemrarecraftcost
		weapon = table.Random(kotecraftsysrareweapons)
	elseif rarity == "LEGENDARY" then
		cost = kotecraftsystemlegendarycraftcost
		weapon = table.Random(kotecraftsyslegendaryweapons)
	else
		return
	end

	if ply:GetNW2Int("kotecraftsys_scrap") > cost then
		kotecraftsysremovescarp(ply, cost)
		if weapon["weaponclass"] == "null" then
			kotecraftsysgivescarp(ply, cost * kotecraftsysnonereturn)
			net.Start("kotecraftsystem_opencraftfinalmenu")
			net.WriteTable(weapon)
			net.WriteString(rarity)
			net.WriteBool(false)
			net.Send(ply)
		end

		if weapon["weaponclass"] == "null" then return end
		if checkitemininventory(ply, weapon["weaponclass"]) then
			kotecraftsysgivescarp(ply, cost * kotecraftsysrepeatreturn)
			net.Start("kotecraftsystem_opencraftfinalmenu")
			net.WriteTable(weapon)
			net.WriteString(rarity)
			net.WriteBool(true)
			net.Send(ply)
		else
			giveitemininventory(ply, weapon["weaponclass"])
			net.Start("kotecraftsystem_opencraftfinalmenu")
			net.WriteTable(weapon)
			net.WriteString(rarity)
			net.WriteBool(false)
			net.Send(ply)
		end
	end
end)
-------------------------------------------------------SCRAPSTATION-------------------------------------------------------

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
