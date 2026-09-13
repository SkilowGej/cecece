function pMeta:SaveCharData(name, value, is_number)
	local str = isnumber(value) and "%d" or "%s"
	value = isnumber(value) and value or MySQLite.SQLStr(value)
	if is_number and (value < 0 or value >= 1 / 0) then return end
	MySQLite.query(string.format("UPDATE re_characters SET %s = " .. str .. " WHERE char_id = %s;", name, value, MySQLite.SQLStr(self:GetNetVar("character"))))
end

function pMeta:UpdateCharData(key, callback)
	local pData = self:GetNetVar("data") or {}
	pData[key] = callback(pData)
	self:SaveCharData("data", istable(pData) and util.TableToJSON(pData) or pData, false)
	self:SetNetVar("data", pData)
end

netstream.Hook("NewPlayerCharacter", function(pPlayer, data)
	if not IsValid(pPlayer) then return end
	local character_name = string.sub(data.name, 1, 30)
	local rpid = math.random(1, 9) .. math.random(1, 9) .. math.random(1, 9) .. math.random(1, 9)
	local whitelist_teams = WHITELIST_GROUP_TEAMS[pPlayer:GetUserGroup()]
	local start_team = (whitelist_teams and data.start_team and whitelist_teams[data.start_team]) and data.start_team or TEAM_CADET

	MySQLite.query(string.format("SELECT * FROM `re_players` WHERE steam_id = %s;", MySQLite.SQLStr(pPlayer:SteamID())), function(player_data)
		if player_data and istable(player_data) then
			local characters = pPlayer.Characters or {}
			local job = re.jobs[start_team]
			-- local default_rating = table.GetKeys(ALIVE_RATINGS[TYPE_CLONE])[1]
			local default_rating = DEFAULT_RATINGS[TYPE_CLONE]
			local worldmodel = istable(job.WorldModel) and table.Random(job.WorldModel) or job.WorldModel
			local model = (job.FeatureRatings and job.FeatureRatings[default_rating] and job.FeatureRatings[default_rating].model) and job.FeatureRatings[default_rating].model or worldmodel

			local char = {
				player_id = player_data[1].id,
				rpid = rpid,
				team_id = job.jobID,
				character_name = character_name,
				data = {},
			}

			pPlayer:SetNetVar("money", tonumber(player_data[1].money), NETWORK_PROTOCOL_PUBLIC)
			pPlayer:SetNetVar("vehicles", player_data[1].vehicles, NETWORK_PROTOCOL_PUBLIC)
			pPlayer:SetNetVar("model", model, NETWORK_PROTOCOL_PUBLIC)
			pPlayer:SetNetVar("description", player_data[1].description, NETWORK_PROTOCOL_PUBLIC)
			pPlayer:SetNetVar("data", char.data, NETWORK_PROTOCOL_PUBLIC)
			local max_characters = GROUPS_RELATION[pPlayer:GetUserGroup()] or 1

			if #characters <= max_characters then
				MySQLite.query(string.format("INSERT INTO `re_characters`(player_id, rpid, rating, features, team_id, character_name, model, data) VALUES(%s, %s, %s, %s, %s, %s, %s, %s);", char.player_id, MySQLite.SQLStr(char.rpid), MySQLite.SQLStr(default_rating), MySQLite.SQLStr(util.TableToJSON(DEFAULT_FEATURES)), MySQLite.SQLStr(char.team_id), MySQLite.SQLStr(char.character_name), MySQLite.SQLStr(model), MySQLite.SQLStr(util.TableToJSON(char.data))), function(e, char_id)
					pPlayer.Characters = characters or {}
					char.char_id = char_id
					char.rpid = rpid
					char.rating = default_rating
					char.features = DEFAULT_FEATURES
					char.team_index = start_team
					char.model = model
					char.data = {}

					-- table.insert(pPlayer.Characters, char)
					-- GmLogger.PostMessageInDiscord(string.format("Игрок **%s**(``%s``) создал нового персонажа(%s), .", pPlayer:OldName(), pPlayer:SteamID(), char_id, team.GetName(start_team)), "0x4f545c")
					pPlayer:RequestCharacters(function(characters, player_data)
						netstream.Start(pPlayer, "OpenCharacterMenu", {
							characters = characters
						})

						pPlayer.Characters = characters
					end)
				end, function(e) end)
				--print(e)
			end
		else
			MySQLite.query(string.format("INSERT INTO `re_players`(steam_id, community_id, player, money, vehicles) VALUES(%s, %s, %s, %s, %s, %s);", MySQLite.SQLStr(pPlayer:SteamID()), MySQLite.SQLStr(pPlayer:SteamID64()), MySQLite.SQLStr(pPlayer:OldName()), MySQLite.SQLStr(DEFAULT_MONEY), MySQLite.SQLStr(""), MySQLite.SQLStr("{}")), nil, nil)
			pPlayer:SetNetVar("description", "", NETWORK_PROTOCOL_PUBLIC)
			pPlayer:SetNetVar("money", DEFAULT_MONEY, NETWORK_PROTOCOL_PUBLIC)
			pPlayer:SetNetVar("vehicles", {}, NETWORK_PROTOCOL_PUBLIC)
		end
	end)
end)

netstream.Hook("RemovePlayerCharacter", function(pPlayer, data)
	if not IsValid(pPlayer) then return end
	local can_remove = true

	if pPlayer:GetNetVar("character") == data.char_id then
		pPlayer:RequestCharacters(function(characters, player_data)
			netstream.Start(pPlayer, "OpenCharacterMenu", {
				characters = characters,
				err = "Nie możesz usunąć tej postaci, grając nią."
			})
		end)

		return
	end

	local char_id = data.char_id

	-- for k, char in pairs(pPlayer.Characters) do
	-- 	if char.char_id == 1 then
	-- 		if char.team_id == "cadet" then
	-- 			netstream.Start(pPlayer, "OpenCharacterMenu", {
	-- 				characters = pPlayer.Characters,
	-- 				err = "Вы не можете удалить этого персонажа."
	-- 			})

	-- 			can_remove = false
	-- 		end

	-- 		break
	-- 	end
	-- end

	if can_remove ~= false then
		MySQLite.query(string.format("SET FOREIGN_KEY_CHECKS=0; DELETE FROM `re_characters` WHERE char_id = %s; SET FOREIGN_KEY_CHECKS=1;", MySQLite.SQLStr(char_id)), function()
			pPlayer:RequestCharacters(function(characters, player_data)
				netstream.Start(pPlayer, "OpenCharacterMenu", {
					characters = characters
				})

				pPlayer.Characters = characters
			end)
		end)
	end
end)

function pMeta:LoadCharacter(func, char_id)
	local char = self:CharacterByID(char_id)

	if char then
		self:SetNetVar("is_load_char", true, NETWORK_PROTOCOL_PRIVATE)
		self:SetNWString("rpname", char.name)
		-- self:SetCurrentSkillHooks()
		self:StripWeapons()
		self.ActiveCharacterID = char_id
		self:SetTeam(char.team_index)
		self:Spawn()
		self:SetModelScale(1)

		--self:GiveSkills()

		if func then
			func(char)
		end
	else
		self:ConCommand("retry")
	end
	-- self:RequestCharacters(function(characters, player_data)
	--     self.Characters = characters
	--     local char = self:CharacterByID(char_id)
	--     if char then
	--         self:SetNetVar("is_load_char", true, NETWORK_PROTOCOL_PRIVATE)
	--         self:SetNWString( "rpname", char.name )
	--         self:SetTeam(char.team_index)
	--         self:Spawn()
	--         if func then func(char) end
	--     end
	-- end)
end

netstream.Hook("SpawnPlayerCharacter", function(pPlayer, data)
	if not pPlayer:Alive() then return end
	if not IsValid(pPlayer) then return end
	local char_id = data.char_id
	if not char_id then return end
	if not pPlayer:CharacterByID(char_id) then return end
	if pPlayer:GetNetVar("Arrested") then return end

	pPlayer:LoadCharacter(function(char)
		pPlayer:SetNetVar("character", char_id, NETWORK_PROTOCOL_PUBLIC)
		pPlayer:SetNWString("rating", char.rating)
		-- local features = istable(char.features) and char.features or util.TableToJSON(char.features)
		local data = istable(char.data) and util.TableToJSON(char.data) or util.JSONToTable(char.data)
		pPlayer:SetNetVar("features", istable(char.features) and char.features or util.JSONToTable(char.features), NETWORK_PROTOCOL_PUBLIC)
		pPlayer:SetNWString("rpid", char.rpid)
		pPlayer:SetNWString("rpname", char.character_name)
		pPlayer:SetNetVar("model", char.model, NETWORK_PROTOCOL_PUBLIC)
		pPlayer:SetNetVar("data", data, NETWORK_PROTOCOL_PUBLIC)
		pPlayer:Spawn()
		hook.Run("PlayerLoadout", pPlayer)
		hook.Run("PostLoadCharacter", pPlayer, char_id)
	end, char_id)
end)

-- GmLogger.PostMessageInDiscord(string.format("Игрок **%s**(``%s``) выбрал персонажа(``%s``,``%s``).", pPlayer:OldName(), pPlayer:SteamID(), char.character_name, char_id), "0x4f545c")
-- MySQLite.query(string.format("SELECT * FROM `re_player_levelsystem` WHERE steam_id = %s;", MySQLite.SQLStr(pPlayer:SteamID())), function(data)
-- 	local level, experience
-- 	if data and istable(data) then
-- 		level, experience = data[1].level, data[1].experience
-- 	else
-- 		level, experience = 0, 0
-- 		MySQLite.query(string.format("INSERT INTO `re_player_levelsystem`(steam_id, level, experience) VALUES(%s, %s, %s);", MySQLite.SQLStr(pPlayer:SteamID()), MySQLite.SQLStr(level), MySQLite.SQLStr(experience)))
-- 	end
-- 	pPlayer:SetNetVar("level", level, NETWORK_PROTOCOL_PUBLIC)
-- 	pPlayer:SetNetVar("experience", experience, NETWORK_PROTOCOL_PUBLIC)
-- end)
hook.Add("PlayerInitialSpawn", "Characters_PlayerInitialSpawn", function(pPlayer)
	pPlayer:SetNetVar("Arrested", false)

	local function InitPlayer(player_data)
		if not player_data then
			player_data = {
				money = DEFAULT_MONEY,
				description = "",
				vehicles = {},
			}
		end

		pPlayer:SetNetVar("money", tonumber(player_data.money or DEFAULT_MONEY), NETWORK_PROTOCOL_PUBLIC)
		pPlayer:SetNetVar("description", player_data.description or "", NETWORK_PROTOCOL_PUBLIC)
		pPlayer:SetNetVar("vehicles", player_data.vehicles or {}, NETWORK_PROTOCOL_PUBLIC)

		pPlayer:RequestCharacters(function(characters, player_data)
			netstream.Start(pPlayer, "OpenInitCharacterMenu", {
				characters = characters
			})

			pPlayer.Characters = characters
		end)
	end

	MySQLite.query(string.format("SELECT * FROM `re_players` WHERE steam_id = %s;", MySQLite.SQLStr(pPlayer:SteamID())), function(player_data)
		if player_data and istable(player_data) then
			InitPlayer(player_data and player_data[1] or nil)
		else
			MySQLite.query(string.format("INSERT INTO `re_players`(steam_id, community_id, player, money, description, vehicles) VALUES(%s, %s, %s, %s, %s, %s);", MySQLite.SQLStr(pPlayer:SteamID()), MySQLite.SQLStr(pPlayer:SteamID64()), MySQLite.SQLStr(pPlayer:OldName()), MySQLite.SQLStr(DEFAULT_MONEY), MySQLite.SQLStr(''), MySQLite.SQLStr('{}')), function(e, id)
				InitPlayer()
			end, nil)
		end
	end)
end)

netstream.Hook("PlayerChangeDesc", function(pPlayer, new_description)
	if isstring(new_description) and #new_description < 64 then
		pPlayer:SetNetVar("description", new_description, NETWORK_PROTOCOL_PUBLIC)
		MySQLite.query(string.format("UPDATE re_players SET description = %s WHERE steam_id = %s;", MySQLite.SQLStr(new_description), MySQLite.SQLStr(pPlayer:SteamID())))
	end
end)

netstream.Hook("PlayerChangeRPID", function(pPlayer, new_rpid)
	if isstring(new_rpid) and #new_rpid <= 5 then
		-- pMeta:ChangeRPID( new_rpid )
		if not (pPlayer and IsValid(pPlayer)) then return end

		if pPlayer:GetMoney() < 10000 then
			re.util.Notify("red", pPlayer, "Jesteś za biedny.")

			return
		end

		if not tonumber(new_rpid) then
			re.util.Notify("red", pPlayer, "Id nie może składać się z liter.")

			return
		end

		MySQLite.query(string.format("SELECT * FROM re_characters WHERE rpid = %s;", MySQLite.SQLStr(new_rpid)), function(characters)
			if not istable(characters) or #characters == 0 then
				pPlayer:AddMoney(-10000)
				pPlayer:ChangeRPID(new_rpid)
			else
				re.util.Notify("red", pPlayer, "Ten identyfikator jest zajęty.")
			end
		end, function(err)
			print(err)

			return err
		end)
	end
end)