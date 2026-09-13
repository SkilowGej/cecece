--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

HackConsole = HackConsole or {}

HackConsole.ConsoleModelsTexts = {
    ["models/props/console2.mdl"] = {
        pos = Vector(0, -5, 45),
        ang = Angle(0, 90, 0),
    },
    ["models/props/consolebox.mdl"] = {
        pos = Vector(0, 0, 55),
        ang = Angle(0, 90, 0),
    },
    ["models/props/doorpanel1.mdl"] = {
        pos = Vector(0, 0, 30),
        ang = Angle(0, 90, 0),
    },
}

HackConsole.ConsoleTextDistance = 1024

HackConsole.ConsoleModels = {
    "models/gateway/aussiwozzi/ling_intel_console.mdl",
}

HackConsole.ConsoleFailedCooldown = 20 -- RETURN TO 20
HackConsole.ConsoleAllFailedCooldown = 60 -- RETURN TO 60

local SNAKE_MAP_BACKGROUND = 0
local SNAKE_MAP_ROAD       = 1
local SNAKE_MAP_END        = 2

local SNAKE_VISUAL_START   = 0 -- 40x67
local SNAKE_VISUAL_END     = 1 -- 40x67
local SNAKE_VISUAL_CHIP    = 2 -- 94x93 ???

local function Vector2(x, y) return {X = x, Y = y} end

HackConsole.MinigamesSettings = {
    Reaction = {
        ButtonMaterial = "luna_ui_base/elements/lock.png",
        ButtonSize = 40,
        SpawnInterval = 1.2,
        Colors = {
            Color(234, 32, 39),
            Color(6, 82, 221),
            Color(0, 255, 0),
            Color(255, 127, 0),
            Color(255 ,255, 0),
            Color(131, 52, 113),
            Color(10, 189, 227),
        }
    },
    Snake = {
        SnakeSpeed = 100,
        Debug = false,
        GetMap = 0,
        Maps = { // map size 626x626
            {
                Objects = {
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(34, 556),
                        Size = Vector2(330, 30),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(334, 42),
                        Size = Vector2(30, 544),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(334, 42),
                        Size = Vector2(250, 30),
                    },
                    {
                        Type = SNAKE_MAP_END,
                        Pos = Vector2(572, 5),
                        Size = Vector2(50, 100),
                        NoDraw = true,
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(334, 334),
                        Size = Vector2(100, 30),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(234, 334),
                        Size = Vector2(130, 30),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(234, 134),
                        Size = Vector2(30, 230),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(234, 334),
                        Size = Vector2(30, 130),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(134, 434),
                        Size = Vector2(130, 30),
                    },
                },
                Visual = {
                    {
                        Type = SNAKE_VISUAL_START,
                        Pos = Vector2(34, 571),
                        NoDraw = false,
                    },
                    {
                        Type = SNAKE_VISUAL_END,
                        Pos = Vector2(592, 55),
                        NoDraw = false,
                    },
                    {
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(462, 347),
                    },
                    {
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(116, 449),
                    },
                    {
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(250, 115),
                    },
                },
                Start = Vector(60, 571, 3), -- x, y, direction (0 - up, 1 - down, 2 - left, 3 - right)
            },
            {
                Objects = {
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(34, 556),
                        Size = Vector2(400, 30),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(410, 286),
                        Size = Vector2(30, 300),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(180, 286),
                        Size = Vector2(260, 30),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(180, 40),
                        Size = Vector2(30, 276),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(180, 40),
                        Size = Vector2(400, 30),
                    },
                    {
                        Type = SNAKE_MAP_END,
                        Pos = Vector2(572, 5),
                        Size = Vector2(50, 100),
                        NoDraw = true,
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(410+(14/2), 40),
                        Size = Vector2(30-14, 300),
                    },
                },
                Visual = {
                    {
                        Type = SNAKE_VISUAL_START,
                        Pos = Vector2(34, 571),
                        NoDraw = false,
                    },
                    {
                        Type = SNAKE_VISUAL_END,
                        Pos = Vector2(592, 55),
                        NoDraw = false,
                    },
                    {
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(312, 188),
                    },
                    {
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(533, 400),
                    },
                    {
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(196, 417),
                    },
                    {
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(62, 130),
                    },
                    {
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(563, 175),
                    },
                },
                Start = Vector(60, 571, 3),
            },
            {
                Objects = {
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(34, 120),
                        Size = Vector2(176, 30),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(180, 130),
                        Size = Vector2(30, 366),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(180, 130+366),
                        Size = Vector2(380, 30),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(150+380, 235),
                        Size = Vector2(30, 291),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(364, 235),
                        Size = Vector2(190, 30),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(364, 40),
                        Size = Vector2(30, 225),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(364, 40),
                        Size = Vector2(250, 30),
                    },
                    {
                        Type = SNAKE_MAP_END,
                        Pos = Vector2(572, 5),
                        Size = Vector2(50, 100),
                        NoDraw = false,
                    }
                },
                Visual = {
                    {
                        Type = SNAKE_VISUAL_START,
                        Pos = Vector2(34, 135),
                        NoDraw = false,
                    },
                    {
                        Type = SNAKE_VISUAL_END,
                        Pos = Vector2(592, 55),
                        NoDraw = false,
                    },
                    {
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(87, 316),
                        NoDraw = false,
                    },
                    {
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(169, 51),
                        NoDraw = false,
                    },
                    {
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(428, 396),
                        NoDraw = false,
                    },
                    {
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(483, 582),
                        NoDraw = false,
                    },
                    {
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(496, 161),
                        NoDraw = false,
                    },
                    {
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(76, 559),
                        NoDraw = false,
                    },
                    {
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(287, 247),
                        NoDraw = false,
                    },
                },
                Start = Vector(60, 120+15, 3),
            },
            {
                Objects = {
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(34, 120),
                        Size = Vector2(126, 30),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(130, 130),
                        Size = Vector2(30, 450),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(130, 130+420),
                        Size = Vector2(240, 30),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(340, 170),
                        Size = Vector2(30, 400),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(340, 170),
                        Size = Vector2(160, 30),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(310+160, 170),
                        Size = Vector2(30, 340),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(470, 340+170),
                        Size = Vector2(130, 30),
                    },
                    {
                        Type = SNAKE_MAP_END,
                        Pos = Vector2(572, 475),
                        Size = Vector2(50, 100),
                        NoDraw = true,
                    }
                },
                Visual = {
                    {
                        Type = SNAKE_VISUAL_START,
                        Pos = Vector2(34, 135),
                        NoDraw = false,
                    },
                    {
                        Type = SNAKE_VISUAL_END,
                        Pos = Vector2(592, 525),
                        NoDraw = false,
                    },{
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(246, 137),
                        NoDraw = false,
                    },{
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(242, 484),
                        NoDraw = false,
                    },{
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(421, 524),
                        NoDraw = false,
                    },{
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(56, 540),
                        NoDraw = false,
                    },{
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(423, 96),
                        NoDraw = false,
                    },{
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(552, 325),
                        NoDraw = false,
                    },
                },
                Start = Vector(60, 120+15, 3),
            },
            {
                Objects = {
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(34, 360),
                        Size = Vector2(160, 30),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(130+34, 160),
                        Size = Vector2(30, 230),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(164, 160),
                        Size = Vector2(130, 30),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(264, 70),
                        Size = Vector2(30, 120),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(264, 70),
                        Size = Vector2(170, 30),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(264+140, 70),
                        Size = Vector2(30, 400),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(404, 440),
                        Size = Vector2(130, 30),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(504, 285),
                        Size = Vector2(30, 185),
                    },
                    {
                        Type = SNAKE_MAP_ROAD,
                        Pos = Vector2(504, 285),
                        Size = Vector2(100, 30),
                    },
                    {
                        Type = SNAKE_MAP_END,
                        Pos = Vector2(572, 250),
                        Size = Vector2(50, 100),
                        NoDraw = false,
                    }
                },
                Visual = {
                    {
                        Type = SNAKE_VISUAL_START,
                        Pos = Vector2(34, 375),
                        NoDraw = false,
                    },
                    {
                        Type = SNAKE_VISUAL_END,
                        Pos = Vector2(592, 300),
                        NoDraw = false,
                    },
                    {
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(178, 94),
                        NoDraw = false,
                    },{
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(264, 374),
                        NoDraw = false,
                    },{
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(134, 525),
                        NoDraw = false,
                    },{
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(334, 525),
                        NoDraw = false,
                    },{
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(526, 130),
                        NoDraw = false,
                    },{
                        Type = SNAKE_VISUAL_CHIP,
                        Pos = Vector2(351, 160),
                        NoDraw = false,
                    },
                },
                Start = Vector(60, 375, 3),
            },
        }
    }
}

HackConsole.WhitelistEnts = {
    func_door = true,
    prop_physics = true
}

HackConsole.EntsHackCallback = {
    func_door = function(console, ply, ent)
        ent:Fire("Unlock")
        ent:Fire("Open")
    end,
    prop_physics = function(console, ply, ent)
        ent:Remove()
    end
}

HackConsole.EntsSpawnCallback = {
    func_door = function(console, ent)
        ent:Fire("Lock")
    end
}

HackConsole.DefaultSettings = {
    name = "Konsola",
    max_attempt = 1,
    time_for_hack = 20,
    can_repeat = false,
    selected_model = 1,
    selected_type = 1,
}

if SERVER then
    AddCSLuaFile("hack_console/reaction_minigame.lua")
    AddCSLuaFile("hack_console/snake_minigame.lua")
else
    include("hack_console/reaction_minigame.lua")
    include("hack_console/snake_minigame.lua")

    function HackConsole.Minigames.Stop()
        if not IsValid(HackConsole.Minigames.Minigame) then return end
    
        HackConsole.Minigames.Minigame.Finished = true
        HackConsole.Minigames.Minigame:Remove()
        HackConsole.Minigames.Minigame = nil
    end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
