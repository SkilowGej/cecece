netstream.Hook('ProfileWhitelist_ChangeToTime', function(pPlayer, data)
	local rating = data.rating
	local team_index = data.team_index
	local target = data.target
	local job = re.jobs[team_index]
	local pl = player.GetBySteamID(target.steam_id)
	if pl and pl.ActiveCharacterID == target.char_id then
		if not pPlayer:CanUseWhitelist() then return end
		if not pPlayer:CanGiveTeam(team_index) then return end
		if not ALIVE_RATINGS[job.Type] then return end
		local worldmodel = istable(job.WorldModel) and table.Random(job.WorldModel) or job.WorldModel
		local model = job.FeatureRatings and job.FeatureRatings[rating].model and job.FeatureRatings[rating].model or worldmodel
		pl:StripWeapons()
		pl:SetNetVar('model', model, NETWORK_PROTOCOL_PUBLIC)
		pl:SetMaxHealth(job.maxHealth or 100)
		pl:SetHealth(job.maxHealth or 100)
		pl:SetArmor(job.maxArmor or 255)
		pl:SetNetVar('maxArmor', job.maxArmor or 255, NETWORK_PROTOCOL_PUBLIC)
		pl:SetNetVar('maxHealth', job.maxHealth or 100, NETWORK_PROTOCOL_PUBLIC)
		if data.no_spawn then
			pl:SetTeam(team_index)
			pl:Spawn()
		else
			local pos, ang = pl:GetPos(), pl:EyeAngles()
			pl:SetTeam(team_index)
			pl:Spawn()
			pl:SetPos(pos)
			pl:SetEyeAngles(ang)
		end

		pl:SetNetVar('rating', rating, NETWORK_PROTOCOL_PUBLIC)
		pl:SetNWString('rating', rating)
		-- pl:SetNetVar('features', features, NETWORK_PROTOCOL_PUBLIC)
		-- Prevent Loadout.
		hook.Run('PostPlayerLoadout', pl)
	end
end)

-- local callbacks = {
-- }
netstream.Hook('ProfileWhitelist_Change', function(pPlayer, data)
	local rating = data.rating
	local team_index = data.team_index
	local target = data.target
	local test = pPlayer.nextChangeWhitelist or 0
	if (pPlayer.nextChangeWhitelist or 0) >= CurTime() then return end
	pPlayer.nextChangeWhitelist = CurTime() + .1
	local jdata = re.jobs[team_index]
	local team_id = jdata.jobID
	local features = data.features
	local model = data.model
	local ftn = FEATURES_TO_NORMAL[features]
	if not pPlayer:CanUseWhitelist() then return end
	if not pPlayer:CanGiveTeam(team_index) then return end
	if not ALIVE_RATINGS[jdata.Type] then return end
	local oldChar, newChar
	for _, char in pairs(pPlayer.Characters) do
		if char.char_id == target.char_id then
			oldChar = table.Copy(char)
			char.features = features
			char.rating = rating
			char.team_id = team_id
			char.team_index = team_index
			char.model = model
			newChar = char
			break
		end
	end

	MySQLite.query(string.format('UPDATE re_characters SET rating = %s, team_id = %s, features = %s, model = %s WHERE player_id = %s AND char_id = %s;', MySQLite.SQLStr(rating), MySQLite.SQLStr(team_id), MySQLite.SQLStr(util.TableToJSON(features)), MySQLite.SQLStr(model), MySQLite.SQLStr(target.player_id), MySQLite.SQLStr(target.char_id)), function()
		local pl = player.GetBySteamID(target.steam_id)
		if pl and pl.ActiveCharacterID == target.char_id then
			pl:SetNetVar('model', model, NETWORK_PROTOCOL_PUBLIC)
			pl:StripWeapons()
			pl:SetMaxHealth(jdata.maxHealth or 100)
			pl:SetHealth(jdata.maxHealth or 100)
			pl:SetArmor(jdata.maxArmor or 255)
			pl:SetNetVar('maxArmor', jdata.maxArmor or 255, NETWORK_PROTOCOL_PUBLIC)
			pl:SetNetVar('maxHealth', jdata.maxHealth or 100, NETWORK_PROTOCOL_PUBLIC)
			if data.no_spawn then
				pl:SetTeam(team_index)
				pl:Spawn()
			else
				local pos, ang = pl:GetPos(), pl:EyeAngles()
				pl:SetTeam(team_index)
				pl:Spawn()
				pl:SetPos(pos)
				pl:SetEyeAngles(ang)
			end

			pl:SetNetVar('rating', rating, NETWORK_PROTOCOL_PUBLIC)
			pl:SetNWString('rating', rating)
			pl:SetNetVar('features', features, NETWORK_PROTOCOL_PUBLIC)
			hook.Run('PostChangeCharacter', pl, newChar, oldChar, pPlayer)
			for bab, st in pairs(FEATURES_TO_NORMAL) do
				if st.base_job and st.base_job == pl:Team() then
					-- print(bab, st.base_job)
					pl:SetNetVar('features', {
						[bab] = true
					}, NETWORK_PROTOCOL_PUBLIC)
				end
			end

			local ftn = FEATURES_TO_NORMAL[features]
			hook.Run('PostLoadCharacter', pl, target.char_id, oldChar)
			if ftn and ftn.callback then
				ftn.callback(pl, newChar)
			end
		end
	end)
end)

hook.Add('PlayerSpawn', 're.callbacks.char', function(ply)
	timer.Simple(.5, function()
		local logic = ply:GetNetVar('features') or {}
		local char = ply:CharacterByID(ply.ActiveCharacterID)
		if not char then return end
		for feature, status in pairs(logic) do
			if status then
				local ftn = FEATURES_TO_NORMAL[feature]
				if ftn and ftn.callback then ftn.callback(ply, char) end
				break
			end
		end
	end)
end)

netstream.Hook('LegionDescription_Change', function(pPlayer, data)
	if (pPlayer.nextChangeDescription or 0) >= CurTime() then return end
	pPlayer.nextChangeDescription = CurTime() + .1
	if not pPlayer:CanUseWhitelist() then return end
	MySQLite.query(string.format('UPDATE re_legions SET description = %s WHERE team_id = %s;', MySQLite.SQLStr(data.description), MySQLite.SQLStr(data.team_id)), function() end)
end)

local buffer = {
	characters = {},
	counts = {},
	info = {}
}

function OpenWhitelist(pPlayer)
	if buffer.counts and (buffer.counts.last_query or 0) > CurTime() then
		netstream.Start(pPlayer, 'OpenWhitelistMenu', buffer.counts.data)
		return
	end

	local time = CurTime()
	MySQLite.query('SELECT team_id, COUNT(*) FROM re_characters GROUP BY team_id;', function(data)
		local counts = {}
		for i, d in pairs(data) do
			counts[d.team_id] = d['COUNT(*)']
		end

		netstream.Start(pPlayer, 'OpenWhitelistMenu', counts)
		buffer.counts = {
			data = counts,
			last_query = time + 600
		}
	end, function(err)
		print(err)
		return err
	end)
end

netstream.Hook('ViewInfoLegion', function(pPlayer, jobID)
	if buffer.info and (buffer.info[jobID] and buffer.info[jobID].last_query or 0) > CurTime() then
		netstream.Start(pPlayer, 'ViewInfoLegion', jobID, buffer.info[jobID].data)
		return
	end

	local time = CurTime()
	MySQLite.query(string.format('SELECT legion.*, player.community_id, player.player FROM re_legions AS legion LEFT JOIN re_players AS player ON player.id = legion.last_editor WHERE legion.team_id = %s LIMIT 1;', MySQLite.SQLStr(jobID)), function(info)
		local row = (istable(info) and info[1]) or { description = '', community_id = 0, player = '' }
		row.description = row.description or ''
		row.community_id = row.community_id or 0
		row.player = row.player or ''
		netstream.Start(pPlayer, 'ViewInfoLegion', jobID, row)
		buffer.info[jobID] = {
			data = row,
			last_query = time + 10
		}
	end, function(err)
		print(err)
		return err
	end)
end)

netstream.Hook('ViewWhitelistLegion', function(pPlayer, jobID)
	if buffer.characters and (buffer.characters[jobID] and buffer.characters[jobID].last_query or 0) > CurTime() then
		netstream.Start(pPlayer, 'ViewWhitelistLegion', jobID, buffer.characters[jobID].data)
		return
	end

	local time = CurTime()
	MySQLite.query(string.format('SELECT * FROM re_characters, re_players WHERE team_id = %s AND re_players.id = re_characters.player_id;', MySQLite.SQLStr(jobID)), function(characters)
		characters = characters or {}
		for _, v in pairs(characters) do
			v.features = util.JSONToTable(v.features)
		end

		netstream.Start(pPlayer, 'ViewWhitelistLegion', jobID, characters)
		buffer.characters[jobID] = {
			data = characters,
			last_query = time + 10
		}
	end, function(err)
		print(err)
		return err
	end)
end)
