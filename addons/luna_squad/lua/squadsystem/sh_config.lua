--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--[[
   _____                       _  _____           _                 
  / ____|                     | |/ ____|         | |                
 | (___   __ _ _   _  __ _  __| | (___  _   _ ___| |_ ___ _ __ ___  
  \___ \ / _` | | | |/ _` |/ _` |\___ \| | | / __| __/ _ \ '_ ` _ \ 
  ____) | (_| | |_| | (_| | (_| |____) | |_| \__ \ ||  __/ | | | | |
 |_____/ \__, |\__,_|\__,_|\__,_|_____/ \__, |___/\__\___|_| |_| |_|
            | |                          __/ |                      
            |_|                         |___/                       

	Created by Summe: https://steamcommunity.com/id/DerSumme/ 
    Purchased content: https://discord.gg/k6YdMwj9w2
]]--

SquadSystem.Config = {}

/* ----------------------------- Color settings ----------------------------- */

SquadSystem.Config.Theme = {
    primary = Color(0,228,171),
}

/* ----- Default keybind, users can change it via "summelibrary_hotkeys" ---- */
/* ------------------------- in their client console ------------------------ */

SquadSystem.Config.Key = KEY_G

/* ---------------------------- Language settings --------------------------- */
/* -------------------- Currently available: en | de | ru ------------------- */

SquadSystem.Config.Language = "en"

/* ---------------- Whether the sideboard should show avatars --------------- */

SquadSystem.Config.Sideboard = {
    showAvatars = true,
}

/* ------------- Whether to block damage caused by squad members ------------ */
/* ------------------------- Basically friendly fire ------------------------ */

SquadSystem.Config.BlockDamage = false

/* ------------------ Experience Rewards (Leveling System) ------------------ */
/* --------- (Vrondakis, Sublime, Bricks, Glorified & VoidFactions) --------- */

SquadSystem.Config.XPRewards = {
    enabled = false, -- whether to give a player xp every x minutes for being part of a squad
    frequency = 25, -- the interval in minutes
    amount = 100, -- the amount of xp to give
    notify = true, -- whether the player should be notified about it
}

/* ------------------------ Creator & Squadlist NPCs ------------------------ */

SquadSystem.Config.NPCModels = {
    creator = "models/lucky/navallookinganimated.mdl",
    publicList = "models/lucky/navalconsoleanimated.mdl",
}

/* -------------------- Customization of the squad ranks -------------------- */
/* ------------ The first two ALWAYS have the squadlead privilege ----------- */

SquadSystem.Config.Positions = {
    [1] = {
        name = "Leader",
        imgur = "lQvVSrI",
    },
    [2] = {
        name = "Deputy",
        imgur = "qw3mwbm",
    },
    [3] = {
        name = "Heavy Combatant",
        imgur = "qw3mwbm",
    },
    [4] = {
        name = "Wsparcie",
        imgur = "qw3mwbm",
    },
    [5] = {
        name = "Specjalista",
        imgur = "qw3mwbm",
    },
    [6] = {
        name = "Inżynier",
        imgur = "qw3mwbm",
    },
    [7] = {
        name = "Kierowca-pilot",
        imgur = "qw3mwbm",
    },
    [8] = {
        name = "Medyk",
        imgur = "qw3mwbm",
    },
    [9] = {
        name = "Strzelec",
        imgur = "qw3mwbm",
    },
}

/* --------------- Customization of the communication options --------------- */

SquadSystem.Config.Communications = {
    ["Potrzebuję leczenia!"] = {
        chatMsg = "%PLAYER% wymaga pomocy medycznej!",
        overheadMsg = "Potrzebuję leczenia!",
        imgur = "cEQtLqG",
        color = Color(245, 0, 37),
        time = 10,
    },
    ["Śledzę teren!"] = {
        chatMsg = "%PLAYER% śledzi teren!",
        overheadMsg = "Śledzę teren!",
        imgur = "U28VhFB",
        color = Color(0,238,255),
        time = 5,
    },
    ["Potrzebuję zapory ogniowej!"] = {
        chatMsg = "%PLAYER% Potrzebuje zapory ogniowej!",
        overheadMsg = "Potrzebuje zapory ogniowej",
        imgur = "08hfeEA",
        color = Color(255,0,255),
        time = 5,
    },
    ["Na pozycji!"] = {
        chatMsg = "%PLAYER% na pozycji!",
        overheadMsg = "Na pozycji!",
        imgur = "0hxDode",
        color = Color(0,212,28),
        time = 5,
    },
    ["Czekam na rozkazy!"] = {
        chatMsg = "%PLAYER% czeka na rozkazy!",
        overheadMsg = "Czekam na rozkazy!",
        imgur = "MJm7l87",
        color = Color(255,0,0),
        time = 5,
    },
    ["Sektor czysty!"] = {
        chatMsg = "%PLAYER% oczyścił sektor!",
        overheadMsg = "Sektor czysty!",
        imgur = "Es3rhnR",
        color = Color(0,255,115),
        time = 5,
    },
    ["Wskazać (zwykły)"] = { -- If u change the name (Ping (Normal)) then change it also down there in the developer section!
        chatMsg = "%PLAYER% oznaczył teren!",
        overheadMsg = "Rozejrzyj się!",
        imgur = "A2zzbvB",
        color = Color(255,166,0),
        time = 5,
        callbackSv = function(ply)
            ply:SquadPing("normal")
        end,
    },
    ["Wskazać (Wrog)"] = { -- If u change the name (Ping (Enemy)) then change it also down there in the developer section!
        chatMsg = "%PLAYER% wykrył wroga!",
        overheadMsg = "wykrył wroga!",
        imgur = "nWeRozA",
        color = Color(255,0,34),
        time = 5,
        callbackSv = function(ply)
            ply:SquadPing("enemy")
        end,
    },
}

/* ----------------- Customization of the squadlead commands ---------------- */

SquadSystem.Config.Commands = {
    ["Zbiórka!"] = {
        chatMsg = "%PLAYER% nakazuje: zbiórkę!",
        color = Color(255,255,255),
        imgur = "LQMO027",
    },
    ["Obrona okrężna!"] = {
        chatMsg = "%PLAYER% nakazuje: Obrona okrężna!",
        color = Color(255,255,255),
        imgur = "LQMO027",
    },
    ["Utrzymać pozycję!"] = {
        chatMsg = "%PLAYER% nakazuje: Utrzymać pozycję!",
        color = Color(255,255,255),
        imgur = "LQMO027",
    },
    ["Wszyscy żołnierze, atak!"] = {
        chatMsg = "%PLAYER% nakazuje: Wszyscy żołnierze, atak!",
        color = Color(255,255,255),
        imgur = "LQMO027",
    },
    ["Przerwać ogień!"] = {
        chatMsg = "%PLAYER% nakazuje: Przerwać ogień!",
        color = Color(255,255,255),
        imgur = "LQMO027",
    },
    ["Kontratak!"] = {
        chatMsg = "%PLAYER% nakazuje: Kontratak!",
        color = Color(255,255,255),
        imgur = "LQMO027",
    },
    ["Rozproszyć się!"] = {
        chatMsg = "%PLAYER% nakazuje: Rozproszyć się!",
        color = Color(255,255,255),
        imgur = "LQMO027",
    },
    ["Wszyscy do schronu!"] = {
        chatMsg = "%PLAYER% nakazuje: Wszyscy do schronu!",
        color = Color(255,255,255),
        imgur = "LQMO027",
    },
}

/* -------------------------------------------------------------------------- */
/*                              Developer section                             */
/*                Please only touch if u know what u are doing                */
/* -------------------------------------------------------------------------- */


hook.Add("SquadSystem.Loaded", "SquadSystem.PingKeybinds", function()
    if not CLIENT then return end
    SummeLibrary:RegisterBind({
        name = "SquadSystem - Ping",
        key = nil,
        func = function()
            if not LocalPlayer():GetSquad() then return end
            SquadSystem:RequestCommunication("Ping (Normal)") -- If you have changed the name above, change it also here!
        end,
    })

    SummeLibrary:RegisterBind({
        name = "SquadSystem - Ping (enemy)",
        key = nil,
        func = function()
            if not LocalPlayer():GetSquad() then return end
            SquadSystem:RequestCommunication("Ping (Enemy)") -- If you have changed the name above, change it also here!
        end,
    })
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
