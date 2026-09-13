function re.SQLCreateTable(tableName, query)
	MySQLite.query("CREATE TABLE IF NOT EXISTS " .. tableName .. " ( " .. query .. " );")
end

hook.Add( "DatabaseInitialized", "DatabaseInitialized", function()
	-- local UTF8MB4 = "ALTER DATABASE s1589_supreme CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci"

	-- MySQLite.query(UTF8MB4,nil,function(err)
	-- 	print(err)
	-- end)

	re.SQLCreateTable("re_players", [[
		id int auto_increment not null primary key,
		steam_id varchar(25),
		community_id TEXT,
		player varchar(255),
		money INT,
		vehicles TEXT,
		description varchar(255),
		items TEXT
	]])

	re.SQLCreateTable("re_characters", [[
		char_id int auto_increment not null primary key,
		player_id int,
		rpid int,
		rating varchar(255),
		features TEXT,
		team_id varchar(255),
		character_name varchar(255),
		model varchar(255),
		data TEXT,
		FOREIGN KEY (player_id) REFERENCES re_players(id)
	]])

	re.SQLCreateTable("re_characters_levels", [[
		char_id int auto_increment not null primary key,
		level INT(4),
		experience INT(4),
		FOREIGN KEY (char_id) REFERENCES re_characters(char_id)
	]])

	re.SQLCreateTable("re_characters_skills", [[
		char_id int auto_increment not null primary key,
		skills TEXT,
		points int,
		FOREIGN KEY (char_id) REFERENCES re_characters(char_id)
	]])

	re.SQLCreateTable("re_spawnpoints", [[
		map varchar(255),
		vector TEXT,
		category varchar(255)
	]])

	re.SQLCreateTable("re_legions", [[
		team_id varchar(255) not null primary key,
		description TEXT,
		last_editor int,
		FOREIGN KEY (last_editor) REFERENCES re_players(id)
	]])

	local jobs_query = {}
	for _, jdata in pairs(re.jobs) do
		table.insert(jobs_query, "(" .. MySQLite.SQLStr(jdata.jobID) .. ", \"Brak opisu\", 1)")
	end

	MySQLite.query("INSERT IGNORE re_legions (team_id, description, last_editor) VALUES " .. string.Implode(",\n", jobs_query) .. ";")

	-- MySQLite.query([[
	-- 	CREATE TABLE IF NOT EXISTS re_player_inventory(
	-- 		steam_id varchar(25),
	-- 		community_id TEXT,
	-- 		data TEXT,
	-- 		clothes TEXT,
	-- 		scraps TEXT,
	-- 		PRIMARY KEY (`steam_id`)
	-- 	);
	-- ]])
	-- MySQLite.query([[
	-- 	CREATE TABLE IF NOT EXISTS re_doorsystem_data(
	-- 		id INT AUTO_INCREMENT,
	-- 		mapid INT,
	-- 		vector VARCHAR(255),
    --         rpgroup INT,
	-- 		PRIMARY KEY (id)
	-- 	);
	-- ]],nil,function(error)
	-- 	print(error)
	-- end)
end)