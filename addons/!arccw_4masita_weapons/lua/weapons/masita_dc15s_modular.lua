--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3 -- Change this if you want to select the weapon with other number

-- Trivia
SWEP.Category = "[ArcCW] Republic Essentials - Masita"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "Modular DC-15s"
SWEP.Trivia_Class = "Karabin blasterowy"
SWEP.Trivia_Desc = "Karabin blasterowy DC-15A, zwany również blasterem DC-15S, to model karabinu blasterowego używanego przez Wielką Armię Republiki. Należał on do rodziny DC-15. Pomimo tego, że jest mniejszy od większego karabinu blasterowego DC-15A, oba modele można zaliczyć do karabinów blasterowych. Była to jedna z najpopularniejszych broni wydawanych żołnierzom-klonom podczas Wojen Klonów i była używana w wielu bitwach."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/dc15s_modular.png"

-- Viewmodel & Entity Properties
SWEP.DefaultBodygroups = "000000000000000"

SWEP.UseHands = true
SWEP.MirrorVMWM = true
SWEP.NoHideLeftHandInCustomization = false

SWEP.ViewModel = "models/arccw/kraken/c_dc15s_modular.mdl"
SWEP.WorldModel = "models/arccw/kraken/w_dc15s_modular.mdl"
SWEP.ViewModelFOV = 58
SWEP.WorldModelOffset = {
    pos = Vector(-11, 4.3, -3.4),
    ang = Angle(-10, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
}

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1.2,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 37
SWEP.RangeMin = 198
SWEP.DamageMin = 21
SWEP.Range = 399
SWEP.Penetration = 1.1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400
SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1
SWEP.TracerNum = 1
SWEP.Tracer = "clone_tracer"
SWEP.TracerCol = Color(0, 0, 250)
SWEP.HullSize = 1
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 34

SWEP.Recoil = 0.67
SWEP.RecoilSide = 0.34
SWEP.RecoilRise = 0.53
SWEP.Delay = 60 / 255

SWEP.Num = 1
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

SWEP.AccuracyMOA = 0.2 
SWEP.HipDispersion = 490
SWEP.MoveDispersion = 60

-- Sounds & Muzzleflash
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 125
SWEP.ShootPitch = 90
SWEP.ShootPitchVariation = 0.05

SWEP.ShootSound = "armas/disparos/dc15s.wav"
SWEP.ShootSoundSilenced = "armas/disparos/dc19.wav"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 250)

-- Ironsight & Holdtype
SWEP.IronSightStruct = {
    Pos = Vector(-4.157, -6.7, 1.56),
    Ang = Angle(0, 0, 0),
     Magnification = 1.6,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 55,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "smg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(1, -0.5, -5)

SWEP.SprintPos = Vector(7, 0, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(9.824, 2, -2.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

-- Attachments 
SWEP.AttachmentElements = {
    ["15s_barrel"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        NameChange = "Sniper DC-15s",
        AttPosMods = {
            [6] = {
                vpos = Vector(-.1, 0.1, 24.6),
            },
        }
    },
    ["15s_mag_ext"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
    },
    ["15s_mag_a280"] = {
        VMBodygroups = {{ind = 2, bg = 2}},
    },
    ["15s_mag_drum"] = {
        VMBodygroups = {{ind = 2, bg = 3}},
    },
    ["15s_stock_extended"] = {
        VMBodygroups = {{ind = 6, bg = 1}},
    },
    ["15s_stock_skeleton"] = {
        VMBodygroups = {{ind = 6, bg = 2}},
    },
    ["15s_ironsight"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
    },
}
SWEP.Attachments = {
    [1] = {   
        PrintName = "Optic", 
        DefaultAttName = "Standard", 
        Slot = "optic",
        Bone = "DC15s",
        InstalledEles = {"15s_ironsight"},
        Offset = {
            vpos = Vector(-0.2, -0.7, 2.4),
            vang = Angle(90, 0, -90),
        },
    },    
    [2] = {
        PrintName = "Foregrip",
        DefaultAttName = "None",
        Slot = "foregrip",
        Bone = "DC15s",
        Offset = {
            vpos = Vector(-0.101, 2.378, 6.164),
            vang = Angle(90, 0, -90),
        },
        SlideAmount = {
        vmin = Vector(-0.1, 0, 7),
        vmax = Vector(-0.1, 0, 10),
        },          
    },
    [3] = {
        PrintName = "Stock",
        DefaultAttName = "None",
        Bone = "DC15s",
        Slot = {"stock", "15s_stock"},
        Offset = {
            vpos = Vector(-0.2, 1.3, -6.6),
            vang = Angle(0, 0, -90),
        },
    }, 
    [4] = {
        PrintName = "Tactical",
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        VMScale = Vector(0.7, 0.7, 0.7),
        Bone = "DC15s", 
        Offset = {
            vpos = Vector(0.4, 0, 11),
            vang = Angle(90, 0, 0),
        },
    },
    [5] = {
        PrintName = "Barrel",
        DefaultAttName = "None",
        Slot = {"15s_barrel"},
        Bone = "DC15s",
    },   
    [6] = {
        PrintName = "Muzzle",
        DefaultAttName = "None",
        Slot = {"15s_barrel", "muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
        Bone = "DC15s",
        Offset = {
            vpos = Vector(-.1, 0.1, 13.7),
            vang = Angle(90, 0, -90),
        },
    },    
    [7] = {
        PrintName = "Magazine",
        DefaultAttName = "Standard",
        Slot = {"15s_mag"},
    },
    [8] = {
        PrintName = "Ammo",
        DefaultAttName = "Standard",
        Slot = {"ammo"},
    },
    [9] = {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = "perk",
    },
    [10] = {
        PrintName = "Internal Modifications",
        DefaultAttName = "None",
        Slot = "uc_fg",
    },
    [11] = {
        PrintName = "Charm",
        DefaultAttName = "None",
        Slot = {"charm"},
        Bone = "DC15s",
        VMScale = Vector(0.7, 0.7, 0.7),
        Offset = {
            vpos = Vector(0.55, 1.5, 2.6),
            vang = Angle(90, 0, -90),
        },
    },     
    [12] = {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "DC15s",
        Offset = {
            vpos = Vector(0.65, 0.35, -3),
            vang = Angle(90, 0, -90),
        },
    },      
}

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = false,
    },
    ["fire"] = {
        Source = "fire"
    },
    ["fire_iron"] = {
        Source = false,
    },
    ["draw"] = {
        Source = "draw",
        Mult = 1.4,
        SoundTable = {
            {
                s = "w/dc15s/overheat_manualcooling_resetfoley_generic_var_01.mp3",
                p = 100,
                v = 75,
                t = 0,
                c = CHAN_ITEM,
            },
        }
    },
    ["holster"] = {
        Source = "holster",
        SoundTable = {
            {
                s = "w/dc15s/gunfoley_blaster_sheathe_var_03.mp3",
                p = 100, 
                v = 75, 
                t = 0,
                c = CHAN_ITEM,
            },
        }
    },
    ["reload"] = {
        Source = "reload", 
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_02.mp3", t = 10 / 60},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheat_reset_var_04.mp3", t = 120 / 60},
        },
    },
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
