--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3 

-- Trivia
SWEP.Category = "[ArcCW] Star Wars Weapons"
SWEP.Credits = "Kraken"
SWEP.PrintName = "DC-17m"
SWEP.Trivia_Class = "Interchangeable Weapon System"
SWEP.Trivia_Desc = "The DC-17m Interchangeable Weapon System, also known as the DC-17m Repeating Blaster Rifle, or DC-17M ICWS, was a type of repeating blaster rifle used by Republic clone commandos during the Clone Wars. It could change between a repeating blaster rifle and grenade launcher by switching the weapon's barrel module. The weapon was also used by pirates from Hondo Ohnaka's gang."
SWEP.Trivia_Manufacturer = "BlastTech Industries"
SWEP.Trivia_Calibre = "Laser Bolt"
SWEP.Trivia_Mechanism = "Tibanna Gas"
SWEP.Trivia_Country = "Galactic Republic, Galactic Empire"
SWEP.Trivia_Year = 2024
SWEP.IconOverride = "entities/dc17m.png"

-- Viewmodel & Entity Properties
SWEP.UseHands = true
SWEP.MirrorVMWM = true
SWEP.ViewModel = "models/arccw/kraken/v_dc17m_modular.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"
SWEP.ViewModelFOV = 60
SWEP.HideViewmodel = false
SWEP.WorldModelOffset = {
    pos = Vector(-13.4, 7, -3.6),
    ang = Angle(-15, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 1
}

-- Damage and things

SWEP.Damage = 45
SWEP.DamageMin = 23
SWEP.RangeMin = 0
SWEP.Range = 400
SWEP.Penetration = 2
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 800

SWEP.BodyDamageMults = {
    [HITGROUP_HEAD] = 2.5,
    [HITGROUP_CHEST] = 1.15,
    [HITGROUP_STOMACH] = 1.1,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 0.75,
    [HITGROUP_RIGHTLEG] = 0.75,
}

SWEP.TraceNum = 1
SWEP.Tracer = "clone_tracer"
SWEP.TracerCol = Color(0, 0, 250)
SWEP.ChamberSize = 0
SWEP.HullSize = 1
SWEP.Primary.ClipSize = 100

SWEP.Recoil = 0.1
SWEP.RecoilSide = 0.1
SWEP.RecoilRise = 0.2

SWEP.Delay = 60 / 480
SWEP.Num = 1
SWEP.Firemode = 1
SWEP.Firemodes = {
    {
        Mode = 1
    },
    {
        Mode = 2
    },
    {
        Mode = 0
    },         
}

SWEP.AccuracyMOA = 0.3 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 300 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150

-- Speed Mult
SWEP.SpeedMult = 0.95
SWEP.SightedSpeedMult = 0.80
SWEP.SightTime = 0.3

-- Sounds & Muzzleflash
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 100
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.05

SWEP.FirstShootSound = "arccw/kraken/dc17m/normal.mp3"
SWEP.ShootSound = "arccw/kraken/dc17m/normal.mp3"
SWEP.ShootSoundSilenced = "arccw/kraken/dc17m/silenced.wav"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 250)

-- Ironsight & Holdtype
SWEP.IronSightStruct = {
    Pos = Vector(-6.512, -1.598, 0.5),
    Ang = Angle(0, 0, 0),
     Magnification = 1,
     SwitchToSound = "weapon_hand/ads/0242-00001a48.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a47.mp3",
     ViewModelFOV = 55,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-2, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, 0, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(9.824, 2, -2.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

-- Attachments 
SWEP.DefaultElements = {}
SWEP.AttachmentElements = {
    ["17m_module_sniper"] = {
        NameChange = "Sniper DC-17m",
        VMBodygroups = {{ind = 1, bg = 3}},
        AttPosMods = {
            [4] = {
                vpos = Vector(0.1, -42, -0.8),
            },
            [5] = {
                vpos = Vector(2.4, -14, -0.3),
            },
        }
    },
--    ["17m_module_antitank"] = { -- coming soon
--       NameChange = "Anti-Tank DC-17m",
--        VMBodygroups = {{ind = 1, bg = 1}},
--        AttPosMods = {
--            [2] = {
--                vpos = Vector(00, -1.3, 31.7),
--            },
--        }
--    },
    ["17m_module_shotgun"] = {
        NameChange = "Shotgun DC-17m",
        VMBodygroups = {{ind = 1, bg = 2}},
        AttPosMods = {
            [3] = {
                vpos = Vector(0.06, -12, -3.4),
            },
            [4] = {
                vpos = Vector(0.1, -21, -1.6),
            },
        }
    },
    ["17m_mag_drum"] = {
        VMBodygroups = {{ind = 2, bg = 2}},
        AttPosMods = {
            [2] = {
                vpos = Vector(00, -1.3, 31.7),
            },
        }
    },
    ["17m_mag_extended"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        AttPosMods = {
            [2] = {
                vpos = Vector(00, -1.3, 31.7),
            },
        }
    },
    ["17m_mag_sniper"] = {
        VMBodygroups = {{ind = 2, bg = 3}},
        AttPosMods = {
            [2] = {
                vpos = Vector(00, -1.3, 31.7),
            },
        }
    },
    ["17m_mag_sniper_ext"] = {
        VMBodygroups = {{ind = 2, bg = 4}},
        AttPosMods = {
            [2] = {
                vpos = Vector(00, -1.3, 31.7),
            },
        }
    },
}

SWEP.Attachments = {
    {
        PrintName = "Module",
        DefaultAttName = "Standard",
        Slot = {"17m_module"},
    }, 
    {
        PrintName = "Magazine",
        DefaultAttName = "Standard",
        Slot = {"17m_mag"},
    }, 
    {
        PrintName = "Optic", 
        DefaultAttName = "Standard", 
        Slot = "optic",
        Bone = "DC-17M",
        Offset = {
            vpos = Vector(0.06, -5, -1.6),
            vang = Angle(0, 90, 180),
        },
        CorrectiveAng = Angle(0, 180, 0),
        CorrectivePos = Vector(0, 0, 0)
    }, 
    {
        PrintName = "Muzzle",
        DefaultAttName = "None",
        Slot = {"muzzle", "stun"},
        Bone = "DC-17M", 
        Offset = {
            vpos = Vector(0.1, -20, -0.9),
            vang = Angle(0, 90, -90),
        },
    },      
    {
        PrintName = "Tactical",
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        VMScale = Vector(0.8, 0.8, 0.8),
        Bone = "DC-17M", 
        Offset = {
            vpos = Vector(1.7, -13, 0.1),
            vang = Angle(0, 90, -90),
        },
    },
    {
        PrintName = "Internal Compression",
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
    },    
    {
        PrintName = "Ammo",
        DefaultAttName = "Standard",
        Slot = {"ammo"},
    },
    {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = "perk_commando",
    },
    {
        PrintName = "Internal Modifications",
        DefaultAttName = "None",
        Slot = "uc_fg",
    },
    {
        PrintName = "Charm",
        DefaultAttName = "None",
        Slot = {"charm"},
        Bone = "DC-17M",
        VMScale = Vector(0.7, 0.7, 0.7),
        Offset = {
            vpos = Vector(1.3, -1, -0.2),
            vang = Angle(0, 90, 200),
        },
    },     
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "DC-17M",
        Offset = {
            vpos = Vector(1.45, -3.7, -0.2),
            vang = Angle(0, 90, 200),
        },
    },      
}

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
    },
    ["fire"] = {
        Source = {"shoot"},
    },
    ["fire_iron"] = {
        Source = false,
    },
    ["draw"] = {
        Source = "draw",
        Mult = 1,
        SoundTable = {
            {
                s = "arccw/kraken/dc17m/equip.wav",
                p = 100,
                v = 75,
                t = 0.1,
                c = CHAN_ITEM,
            },
        }
    },
    ["holster"] = {
        Source = "holster",
        SoundTable = {
            {
                s = "arccw/kraken/dc17m/holster.wav",
                p = 100, 
                v = 75, 
                t = 0.1,
                c = CHAN_ITEM,
            },
        }
    },
    ["reload"] = {
        Source = "reload", 
        LHIK = true,
        Mult = 1,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "weapon_hand/reload_heavy/mag_eject/023d-00000080.mp3", t = 10 / 60},
            {s = "weapon_hand/reload_gentle/mag_load/023d-00000648.mp3", t = 90 / 60},
            {s = "weapon_hand/reload_gentle/mag_load/023d-00000668.mp3", t = 110 / 60},
        },
    },
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
