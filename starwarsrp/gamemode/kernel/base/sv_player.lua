function pMeta:SavePlayerData(name, value, is_number)
	local str = isnumber(value) and "%d" or "%s"
	value = isnumber(value) and value or MySQLite.SQLStr(value)
	if is_number and (value < 0 or value >= 1 / 0) then return end
	MySQLite.query(string.format("UPDATE re_players SET %s = " .. str .. " WHERE steam_id = %s;", name, value, MySQLite.SQLStr(self:SteamID())))
end

function pMeta:ChangeRPID(new)
	if not self:GetNetVar("is_load_char") then return end
	local t = self:Team()
	local char_id = self:GetNetVar("character")
	if not char_id then return end
	if t == TEAM_CONNECTING or t == TEAM_SPECTATOR or t == TEAM_UNASSIGNED then return end

	MySQLite.query(string.format("UPDATE re_characters SET rpid = %s WHERE char_id = %s;", MySQLite.SQLStr(new), MySQLite.SQLStr(char_id)), function()
		self:SetNWString("rpid", new)
	end)
end

function pMeta:ChangeNickname(new)
	if not self:GetNetVar("is_load_char") then return end
	local t = self:Team()
	local char_id = self:GetNetVar("character")
	if not char_id then return end
	if t == TEAM_CONNECTING or t == TEAM_SPECTATOR or t == TEAM_UNASSIGNED then return end
	local character_name = string.sub(new, 1, 30)

	MySQLite.query(string.format("UPDATE re_characters SET character_name = %s WHERE char_id = %s;", MySQLite.SQLStr(character_name), MySQLite.SQLStr(char_id)), function()
		self:SetNWString("rpname", character_name)
	end)
end

function pMeta:CharacterByID(char_id)
	for i, char in pairs(self.Characters) do
		if char.char_id == char_id then return char end
	end

	return false
end

function pMeta:SetMoney(intCount)
	self:SavePlayerData("money", intCount, true)
	self:SetNetVar("money", intCount, NETWORK_PROTOCOL_PUBLIC)
end

function pMeta:AddMoney(intCount)
    local userGroup = self:GetUserGroup()
    local multiplier = 1

    if ROLE_MULTIPLIERS[userGroup] then
        multiplier = ROLE_MULTIPLIERS[userGroup].money
    end

    local adjustedCount = math.floor(intCount * multiplier)
    self:SetMoney(self:GetMoney() + adjustedCount)

	hook.Run( 'onMoneyAdded', self, adjustedCount )
end

function pMeta:RequestCharacters(func)
	MySQLite.query(string.format("SELECT * FROM re_players WHERE steam_id = %s;", MySQLite.SQLStr(self:SteamID())), function(player_data)
		if player_data and istable(player_data) then
			self:SetNWInt("player_id", player_data[1].id)
			self.ID = player_data[1].id

			MySQLite.query(string.format("SELECT * FROM re_characters WHERE player_id = %s;", MySQLite.SQLStr(player_data[1].id)), function(characters)
				local characters = characters or {}

				for i, char in pairs(characters) do
					characters[i].team_index = re.jobs_by_id[char.team_id].index
				end

				if func then
					func(characters, player_data[1])
				end

				return characters, player_data[1]
			end, function(err)
				print(err)

				return err
			end)
		else
			return false
		end
	end, function(err)
		print(err)

		return err
	end)
end

hook.Add("PlayerDeath", "HitEffectOnDeath", function(victim, inflictor, attacker)
	if attacker and attacker:IsPlayer() then
		attacker:SendLua("KillMarker()")
	end
end)

hook.Add("OnNPCKilled", "HitEffectOnNPCKilled", function(npc, attacker, inflictor)
	if attacker and attacker:IsPlayer() and isfunction(attacker.SendLua) then
		attacker:SendLua("KillMarker()")
	end
end)

hook.Add("ScaleNPCDamage", "HitEffectNPCDamage", function(npc, hitgroup, dmginfo)
	local attacker = dmginfo:GetAttacker()

	if attacker and attacker:IsPlayer() then
		attacker:SendLua(hitgroup == HITGROUP_HEAD and "CritMarker()" or "HitMarker()")
	end
end)

-- function GM:PlayerSelectSpawn(pPlayer)
-- local tm = pPlayer:Team()
-- if tm == 0 or tm == 1001 then
-- 	pPlayer:SetPos(Vector("-13051.519531 13943.320313 -880.392822"))
-- 	return
-- end
-- if pPlayer:GetNetVar("Arrested") == true then
-- 	pPlayer:SetPos(table.Random(JAIL_VECTORS))
-- 	return
-- end
-- local spawn_categories, spawns = {}, {}
-- for name, data in pairs(SPAWNPOINTS_CATEGORIES) do
-- 	if data.teams[pPlayer:Team()] then
-- 		spawn_categories[name] = data.priority
-- 	end
-- end
-- for _, ent in pairs(ents.FindByClass("spawn_point")) do
-- 	local cat = ent.Category
-- 	if cat == table.GetWinningKey(spawn_categories) then
-- 		table.insert(spawns, ent)
-- 	end
-- end
-- if #spawns == 0 then
-- 	for _, ent in pairs(ents.FindByClass("spawn_point")) do
-- 		local cat = ent.Category
-- 		if cat == "all" then
-- 			table.insert(spawns, ent)
-- 		end
-- 	end
-- end
-- -- PrintTable(spawns)
-- local spawn = #spawns > 0 and table.Random(spawns) or table.Random(ents.FindByClass("info_player_start"))
-- local POS
-- if spawn and spawn.GetPos then
-- 	POS = spawn:GetPos()
-- else
-- 	POS = pPlayer:GetPos()
-- end
-- POS = re.util.findEmptyPos(POS, {pPlayer}, 600, 30, Vector(16, 16, 64))
-- 	return SPAWNS.SpawnPlayer
-- end
function re.inv.CreateWeapon(class, model, pos)
	local weapon = ents.Create("spawned_weapon")
	weapon:SetModel(model)
	weapon.ShareGravgun = true
	weapon:SetPos(pos)
	weapon.ammoadd = weapons.Get(class) and weapons.Get(class).Primary.DefaultClip
	weapon.nodupe = true
	weapon:SetWeaponClass(class)
	weapon:Spawn()

	return weapon
end

pMeta._DropWeapon = pMeta._DropWeapon or pMeta.DropWeapon

function pMeta:DropWeapon(weapon)
	-- local ammo = self:GetAmmoCount(weapon:GetPrimaryAmmoType())
	self:_DropWeapon(weapon) -- Drop it so the model isn't the viewmodel
	-- local ent = ents.Create("spawned_weapon")
	local model = (weapon:GetModel() == "models/weapons/v_physcannon.mdl" and "models/weapons/w_physics.mdl") or weapon:GetModel()
	local ent = re.inv.CreateWeapon(weapon:GetClass(), model, self:GetShootPos() + self:GetAimVector() * 30)
	weapon:Remove()
end