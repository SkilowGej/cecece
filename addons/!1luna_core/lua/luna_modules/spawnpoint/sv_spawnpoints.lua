--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

-- Created by: _Dubrovski_ (https://steamcommunity.com/id/dubrovski25)
-- Специально для проекта STAR WARS Renaissance

util.AddNetworkString("SpawnPoints:CreateSpawn")
util.AddNetworkString("SpawnPoints:UpdateSpawn")
util.AddNetworkString("SpawnPoints:DeleteSpawn")
util.AddNetworkString("SpawnPoints:RemoveAllSpawns")
util.AddNetworkString("SpawnPoints:GotoSpawn")
util.AddNetworkString("SpawnPoints:RefreshClientSpawns")

SPAWNS = {}
SPAWNS.SPAWNPOINTS = {}

--------------------= Работа с базой данных =--------------------

local function InitSpawnDatabase()
	sql.Query( [[CREATE TABLE IF NOT EXISTS spawnpoints(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, map VARCHAR(45) NOT NULL, prio INTEGER NOT NULL,
		x INTEGER NOT NULL,	y INTEGER NOT NULL,	z INTEGER NOT NULL)]])
	sql.Query( [[CREATE TABLE IF NOT EXISTS spawnpoints_teams(id INTEGER NOT NULL REFERENCES spawnpoints(id) ON DELETE CASCADE,	map VARCHAR(45) NOT NULL, jobID VARCHAR(255) NOT NULL,
		PRIMARY KEY(id, map, jobID)	)]])

	SPAWNS.SPAWNPOINTS = {}

	-- TODO: Сделать кэширование для каждой профессии заранее, вместо того, чтобы кэшировать при первом спавне

end
hook.Add("Initialize", "Spawns:InitDB", InitSpawnDatabase)

function SPAWNS.CreateSpawn(pos, prio, teams)
	local map = string.lower(game.GetMap())
	prio = math.Clamp(tonumber(prio) or 0, 0, 100)

	sql.Query([[INSERT INTO spawnpoints(map, prio, x, y, z) VALUES(]] .. sql.SQLStr(map) .. [[, ]] .. prio .. [[, ]] .. pos[1] .. [[, ]] .. pos[2] .. [[, ]] .. pos[3] .. [[);]])

	local id = sql.QueryValue([[SELECT MAX(id) FROM spawnpoints WHERE map = ]] .. sql.SQLStr(map))
	if isbool(id) then return false end
	print("Created spawn with id ", id, " map: ", map, " priority: ", prio, " pos: ", pos)

	if istable(teams) and #teams > 0 then
		for k,teamcmd in pairs(teams) do
			sql.Query([[INSERT INTO spawnpoints_teams(id, map, jobID) VALUES(]] .. id .. [[, ]] .. sql.SQLStr(map) .. [[, ]] .. sql.SQLStr(teamcmd) .. [[);]])
		end
	end
	SPAWNS.SPAWNPOINTS = {}
	print("Nowy spawn [ID: "..id.."] z priorytetem [".. prio .."/100] | POS: ".. tostring(pos) .. "")

	return id
end

-- Изменение позиции спавна. Может понадобиться в дальнешем.
-- function SPAWNS.UpdateSpawnPos(id, pos)
-- 	 sql.Query([[UPDATE spawnpoints SET x = ]] .. pos[1] .. [[, y = ]] .. pos[2] .. [[, z = ]] .. pos[3] .. [[ WHERE id = ]] .. id)
--	 SPAWNS.SPAWNPOINTS = {}
-- end

function SPAWNS.UpdatePriority(id, prio)
	local id = sql.SQLStr(id, true)
	prio = math.Clamp(tonumber(prio) or 0, 0, 100)
	sql.Query([[UPDATE spawnpoints SET prio = ]] .. prio .. [[ WHERE id = ]] .. id)
	SPAWNS.SPAWNPOINTS = {}
end

function SPAWNS.UpdateTeams(id, teams)
	local map = string.lower(game.GetMap())
	local id = sql.SQLStr(id, true)
	sql.Query([[DELETE FROM spawnpoints_teams WHERE id = ]]..id)
	if istable(teams) and #teams > 0 then
		for k,teamcmd in pairs(teams) do
			sql.Query([[INSERT INTO spawnpoints_teams(id, map, jobID) VALUES(]] .. id .. [[, ]] .. sql.SQLStr(map) .. [[, ]] .. sql.SQLStr(teamcmd) .. [[);]])
		end
	end
	SPAWNS.SPAWNPOINTS = {}
end

function SPAWNS.DeleteSpawn(id)
	local id = sql.SQLStr(id, true)
	sql.Query([[DELETE FROM spawnpoints WHERE id = ]]..id)
	sql.Query([[DELETE FROM spawnpoints_teams WHERE id = ]]..id)
	SPAWNS.SPAWNPOINTS = {}
end

function SPAWNS.RemoveAllMapSpawns(map)
	local map = sql.SQLStr(map)
	sql.Query([[DELETE FROM spawnpoints WHERE map = ]]..map)
	sql.Query([[DELETE FROM spawnpoints_teams WHERE map = ]]..map)
	SPAWNS.SPAWNPOINTS = {}
end

function SPAWNS.RemoveAllSpawns()
	sql.Query([[DROP TABLE spawnpoints]])
	sql.Query([[DROP TABLE spawnpoints_teams]])
	InitSpawnDatabase()
end

--------------------= Выбор точек спавна =--------------------

local function GetJobInfo(ply)
	-- Функция получения данных о профессии игрока. Нужно заменить под нужный гейммод
	local jobTable = re.jobs[ply:Team()]
	return jobTable.jobID
end

local function ConvertToVectors(tbl)
	for k,v in pairs(tbl) do
		tbl[k] = Vector(v.x, v.y, v.z)
	end
	return tbl
end

local function GetPrioritySpawns(jobID)
	local job = sql.SQLStr(jobID)
	local map = sql.SQLStr(string.lower(game.GetMap()))
	local maxpriority = sql.QueryValue([[SELECT MAX(spawnpoints.prio) FROM spawnpoints WHERE spawnpoints.id IN (SELECT spawnpoints_teams.id FROM spawnpoints_teams WHERE spawnpoints_teams.jobID = ]]..job..[[ AND map = ]]..map..[[);]])
	local result_spawns = sql.Query([[SELECT x, y, z FROM spawnpoints WHERE prio = ]]..maxpriority..[[ AND spawnpoints.id IN (SELECT spawnpoints_teams.id FROM spawnpoints_teams WHERE spawnpoints_teams.jobID = ]]..job..[[ AND map = ]]..map..[[);]])
	
	if result_spawns == nil then 
		return false 
	end
	-- return ConvertToVectors(result_spawns)

	for _, e in pairs(ents.FindByName( "spawnpoint_" .. jobID .. "_*" )) do
		e:Remove()
	end

	local spawns = {}
	for i, pos in pairs(ConvertToVectors(result_spawns)) do
		spawns[i] = ents.Create("spawn_point")
		spawns[i]:SetName("spawnpoint_" .. jobID .. "_" .. i)
		spawns[i]:SetPos(pos)
		spawns[i]:Spawn()
	end

	return spawns
end

local function GetSpawnsForJob(job)
	local result = false
	local cachedtable = SPAWNS.SPAWNPOINTS

	-- При первом обращении к БД кэшируем результат для быстрого доступа в дальнейшем
	-- Кэш очищается при каждом изменении спавнов
	-- Таблицы в нашем случае работают быстрее обращения к SQL

	if istable(cachedtable[job]) or cachedtable[job] == false then
		result = cachedtable[job]
	else
		result = GetPrioritySpawns(job)
		cachedtable[job] = result
	end
	return result
end

function SPAWNS.SelectSpawn(ply)
	local team = ply:Team()
	-- print(team, TEAM_CONNECTING, TEAM_SPECTATOR, TEAM_UNASSIGNED)
	if team == TEAM_CONNECTING or team == TEAM_SPECTATOR or team == TEAM_UNASSIGNED then return false end

	-- В эту функцию можно прикрутить различные проверки из других модулей
	local job = re.jobs[team].jobID
	return GetSpawnsForJob(job)
end

-- Спиральное распределение игроков вокруг точки
local function spiralGrid(rings)
	local grid = {}
	local col, row

	for ring=1, rings do -- For each ring...
		row = ring
		for col=1-ring, ring do -- Walk right across top row
			table.insert( grid, {col, row} )
		end

		col = ring
		for row=ring-1, -ring, -1 do -- Walk down right-most column
			table.insert( grid, {col, row} )
		end

		row = -ring
		for col=ring-1, -ring, -1 do -- Walk left across bottom row
			table.insert( grid, {col, row} )
		end

		col = -ring
		for row=1-ring, ring do -- Walk up left-most column
			table.insert( grid, {col, row} )
		end
	end

	return grid
end
-- TODO: Можно сделать возможность настройки "ширины" каждого спавна отдельно
local tpGrid = spiralGrid( 5 )

function ents.FindPlayersInBox( vCorner1, vCorner2 )
	local tEntities = ents.FindInBox( vCorner1, vCorner2 )
	local tPlayers = {}
	local iPlayers = 0
	
	for i = 1, #tEntities do
		if ( tEntities[ i ]:IsPlayer() ) then
			iPlayers = iPlayers + 1
			tPlayers[ iPlayers ] = tEntities[ i ]
		end
	end
	
	return tPlayers, iPlayers
end

local function GetSpawnAroundPoint(pos, attempt)
	if not attempt then attempt = 0 end
	if attempt > #tpGrid then return false end

	-- Размер одного спавна для 1 игрока
	local cell_size = 50 

	local old_pos = pos  -- Первый раз всегда спавним на самой точке, дальше начинаем выбирать спавн по спирали
	if attempt > 0 then
		local grid_pos = tpGrid[attempt]
		local offset = Vector( grid_pos[1] * cell_size, grid_pos[2] * cell_size, 0 )
		pos = pos + offset
	end

	-- Проверка занятости спавна и доступности
	local near_ents = ents.FindPlayersInBox( pos + Vector( -16, -16, 0 ), pos + Vector( 16, 16, 72 ) )
	if #near_ents > 0 then
		-- Если спавн недоступен, попробуем следующий из группы
		return GetSpawnAroundPoint(old_pos, attempt+1)
	end

	return pos
end

function SPAWNS.SpawnPlayer(ply, _, attempts_left)
    local isSpec = ply:Team() == TEAM_SPECTATOR or ply:Team() == TEAM_UNASSIGNED or ply:Team() == TEAM_CONNECTING

    local default_spawns = ents.FindByClass("info_player_start")

    if isSpec then
        -- Дефолтный спавн карты
        return default_spawns[math.random(#default_spawns)]
    end

    local spawns = SPAWNS.SelectSpawn(ply)
    if isbool(spawns) then
        -- Дефолтный спавн карты
        return default_spawns[math.random(#default_spawns)]
    end

    local random_entry = math.random(#spawns)
    local spawn
    local point

    if attempts_left then
        -- Если это не первая попытка, то будем принудительно проверять каждый спавн
        spawn = spawns[attempts_left]
        if not IsValid(spawn) then
            attempts_left = attempts_left - 1
            return SPAWNS.SpawnPlayer(ply, _, attempts_left)
        end
        point = GetSpawnAroundPoint(spawn:GetPos()) -- Пытаемся заспавнить на точке и вокруг неё
        attempts_left = attempts_left - 1
    else
        spawn = spawns[random_entry]
        if not IsValid(spawn) then
            return SPAWNS.SpawnPlayer(ply, _, #spawns)
        end
        point = GetSpawnAroundPoint(spawn:GetPos())
    end

    if isbool(point) then
        attempts_left = attempts_left or #spawns
        if attempts_left < 1 then
            -- Если все спавны заняты, то придётся спавнить как получится
            return spawns[random_entry], point
        end
        -- Что-то пошло не так с этой группой спавнов, выберем заново
        return SPAWNS.SpawnPlayer(ply, _, attempts_left)
    end

    -- DarkRP хочет получать точку спавна во втором аргументе
    return spawn, point
end
hook.Add("PlayerSelectSpawn", "SPEditorSpawn", SPAWNS.SpawnPlayer)

--------------------= Общение с клиентом =--------------------

net.Receive("SpawnPoints:CreateSpawn", function(len, ply)
	if not ply:IsSpawnPointAdmin() then return end

	local pos = net.ReadVector()
	local prio = net.ReadUInt(7)
	local teams = net.ReadTable()

	local id = SPAWNS.CreateSpawn(pos, prio, teams)

	if not isbool(id) then
		ply:PrintMessage(HUD_PRINTTALK, "Nowy spawn [ID: "..id.."] z priorytetem [".. prio .."/100] | Vector(".. tostring(pos) .. ") dla profesji:")
		ply:PrintMessage(HUD_PRINTTALK, table.ToString(teams))
	else
		ply:PrintMessage(HUD_PRINTTALK, "Błąd w tworzeniu spawnu")
	end
end)

net.Receive("SpawnPoints:GotoSpawn", function(len, ply)
	if not ply:IsSpawnPointAdmin() then return end

	local id = net.ReadUInt(32)
	local query = sql.QueryRow([[SELECT x, y, z FROM spawnpoints WHERE id =]].. sql.SQLStr(id, true))
	if istable(query) then
		local pos = GetSpawnAroundPoint(Vector(query.x, query.y, query.z))
		ply:SetPos(pos)
		ply:ChatPrint("Zostałeś przeniesiony do punktu "..id)
	end
end)

net.Receive("SpawnPoints:RefreshClientSpawns", function(len, ply)
	if not ply:IsSpawnPointAdmin() then return end

	local map = sql.SQLStr(string.lower(game.GetMap()))
	local spawns_tbl = sql.Query([[SELECT id, prio, x, y, z FROM spawnpoints WHERE map = ]]..map..[[;]])
	local result_tbl = {}
	if istable(spawns_tbl) then
		for k,v in pairs(spawns_tbl) do
			local query = sql.Query([[SELECT jobID FROM spawnpoints_teams WHERE id = ]].. v.id ..[[;]]) or {}
			local jobs_tbl = table.MemberValuesFromKey(query, "jobID")
			result_tbl[v.id] = {
				prio = v.prio,
				pos = Vector(v.x, v.y, v.z),
				jobs = jobs_tbl,
			}
		end
	end

	net.Start("SpawnPoints:RefreshClientSpawns")
		net.WriteTable(result_tbl)
	net.Send( ply )
end)

net.Receive("SpawnPoints:UpdateSpawn", function(len, ply)
	if not ply:IsSpawnPointAdmin() then return end

	local id = net.ReadUInt(32)
	local spawn_tbl = net.ReadTable()

	SPAWNS.UpdatePriority(id, spawn_tbl.prio)
	SPAWNS.UpdateTeams(id, spawn_tbl.jobs)
	ply:ChatPrint("Данные спавна "..id.." успешно обновлены!")
end)

net.Receive("SpawnPoints:DeleteSpawn", function(len, ply)
	if not ply:IsSpawnPointAdmin() then return end

	local id = net.ReadUInt(32)

	SPAWNS.DeleteSpawn(id)
	ply:ChatPrint("Spawn "..id.." został pomyślnie usunięty!")
end)

net.Receive("SpawnPoints:RemoveAllSpawns", function(len, ply)
	if not ply:IsSpawnPointSuperAdmin() then return end
	
	local purge = net.ReadBool() or false
	if purge then
		SPAWNS.RemoveAllSpawns()
		ply:ChatPrint("Usunięto wszystkie spawn'y!")
	else
		local map = string.lower(game.GetMap())
		SPAWNS.RemoveAllMapSpawns(map)
		ply:ChatPrint("Usunięto wszystkie spawn'y dla mapy "..map)
	end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
