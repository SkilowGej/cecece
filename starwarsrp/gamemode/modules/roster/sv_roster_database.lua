if not SERVER then return end

Roster = Roster or {}
Roster.Database = Roster.Database or {}

local DB = Roster.Database


-- =========================================================
-- DEBUG
-- =========================================================

local function Debug(...)
    if Roster.Config and Roster.Config.Debug then
        print("[ROSTER][DB]", ...)
    end
end


-- =========================================================
-- TWORZENIE TABEL
-- =========================================================

function DB.CreateTables()

    -- =====================================================
    -- PLUTONY
    -- =====================================================

    re.SQLCreateTable("re_roster_platoons", [[

        id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,

        team_id VARCHAR(255) NOT NULL,

        name VARCHAR(128) NOT NULL,

        specialization VARCHAR(128) DEFAULT '',

        commander_player_id INT DEFAULT NULL,

        custom_data TEXT,

        created_by_player_id INT DEFAULT NULL,

        created_at INT NOT NULL,

        updated_at INT NOT NULL

    ]])


    -- =====================================================
    -- DRUŻYNY / PODODDZIAŁY
    -- =====================================================

    re.SQLCreateTable("re_roster_units", [[

        id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,

        team_id VARCHAR(255) NOT NULL,

        platoon_id INT NOT NULL,

        name VARCHAR(128) NOT NULL,

        specialization VARCHAR(128) DEFAULT '',

        max_players INT NOT NULL DEFAULT 0,

        commander_player_id INT DEFAULT NULL,

        equipment TEXT,

        custom_data TEXT,

        created_by_player_id INT DEFAULT NULL,

        created_at INT NOT NULL,

        updated_at INT NOT NULL

    ]])


    -- =====================================================
    -- CZŁONKOWIE ROSTERA
    -- =====================================================

    re.SQLCreateTable("re_roster_members", [[

        id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,

        team_id VARCHAR(255) NOT NULL,

        player_id INT NOT NULL,

        char_id INT NOT NULL,

        unit_id INT DEFAULT NULL,

        platoon_commander TINYINT(1) NOT NULL DEFAULT 0,

        unit_commander TINYINT(1) NOT NULL DEFAULT 0,

        trainer TINYINT(1) NOT NULL DEFAULT 0,

        specialization_caretaker VARCHAR(128) DEFAULT '',

        missions INT NOT NULL DEFAULT 0,

        activity_rating INT NOT NULL DEFAULT 0,

        behavior_rating INT NOT NULL DEFAULT 0,

        discord VARCHAR(128) DEFAULT '',

        note TEXT,

        custom_data TEXT,

        added_by_player_id INT DEFAULT NULL,

        added_at INT NOT NULL,

        last_active INT DEFAULT NULL,

        UNIQUE KEY unique_roster_character (char_id)

    ]])

    Debug("Tabele zostały utworzone/sprawdzone.")

    return true
end


-- =========================================================
-- START
-- =========================================================

hook.Add("DatabaseInitialized", "Roster.Database.Initialize", function()

    timer.Simple(0, function()

        if not Roster or not Roster.Database then

            ErrorNoHalt(
                "[ROSTER][DB] Roster.Database nie istnieje!\n"
            )

            return
        end

        local success = Roster.Database.CreateTables()

        if success then

            print(
                "[ROSTER][DB] Database initialized."
            )

        else

            ErrorNoHalt(
                "[ROSTER][DB] Database initialization failed!\n"
            )

        end

    end)

end)