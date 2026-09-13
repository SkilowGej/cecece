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
SWEP.PrintName = "Modular DC-15a"
SWEP.Trivia_Class = "Karabin blasterowy"
SWEP.Trivia_Desc = "Karabin blasterowy DC-15A, znany po prostu jako karabin blasterowy DC-15, to ciężki karabin blasterowy produkowany przez firmę BlasTech Industries i należący do rodziny DC-15. Podczas wojen klonów przeciwko Konfederacji Niezależnych Systemów była ona jednym ze standardowych rodzajów broni klonów-desantników Galaktycznej Republiki – armii sklonowanych żołnierzy Wielkiej Armii Republiki."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/dc15a_modular.png"

-- Viewmodel & Entity Properties
SWEP.MirrorVMWM = true
SWEP.NoHideLeftHandInCustomization = false
SWEP.UseHands = true
SWEP.ViewModel = "models/everfall/weapons/viewmodels/c_dc15a.mdl"
SWEP.WorldModel = "models/everfall/weapons/worldmodels/w_dc15a.mdl"

SWEP.DefaultBodygroups = "000000000000000"

SWEP.ViewModelFOV = 50
SWEP.WorldModelOffset = {
    pos = Vector(-13, 6, -4.5),
    ang = Angle(-10, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
}

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 1.5,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 32
SWEP.RangeMin = 207
SWEP.DamageMin = 24
SWEP.Range = 301
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400

SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1
SWEP.TracerNum = 1
SWEP.Tracer = "clone_tracer"
SWEP.TracerCol = Color(0, 0, 250)

SWEP.HullSize = 1
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 50

SWEP.Recoil = 0.55
SWEP.RecoilSide = 0.23
SWEP.RecoilRise = 0.63
SWEP.Delay = 60 / 324
SWEP.Num = 1
SWEP.Firemodes = {
	{
		Mode = 2
	},
    {
        Mode = 1
    },
    {
        Mode = 0
    },            
}

SWEP.AccuracyMOA = 0.50
SWEP.HipDispersion = 500
SWEP.MoveDispersion = 50

-- Ammo, Sounds & MuzzleEffect
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 125
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.05

SWEP.ShootSound = "armas/disparos/dc15.wav"
SWEP.ShootSoundSilenced = "armas/disparos/dc19.wav"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 255)

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-4.987, -14, 0.939),
    Ang = Angle(0, 0, 0),
     Magnification = 1.4,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 55,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(4.019, -5.226, -6)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(15, -5, -1.321)
SWEP.CustomizeAng = Angle(18.2, 39.4, 14.8)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.InBipodPos = Vector(-8, 0, -4)
SWEP.InBipodMult = Vector(2, 1, 1)

SWEP.Bipod_Integral = true 
SWEP.BipodDispersion = 1
SWEP.BipodRecoil = 1 

-- Attachments
SWEP.AttachmentElements = {
    ["15a_rangefinder"] = {
        VMBodygroups = {{ind = 6, bg = 2}},
    },
    ["15a_barrel_up"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
    },
    ["15a_barrel_short"] = {
        NameChange = "Short DC-15a",
        VMBodygroups = {{ind = 3, bg = 2}},
        AttPosMods = {
            [2] = {
                vpos = Vector(00, -1.3, 25.7),
            },
        }
    },
    ["15a_barrel_extended"] = {
        NameChange = "Extended DC-15a",
        VMBodygroups = {{ind = 3, bg = 3}},
        AttPosMods = {
            [2] = {
                vpos = Vector(00, -1.3, 31.7),
            },
        }
    },
    ["15a_barrel_longrange"] = {
        NameChange = "DC-15x",
        VMBodygroups = {{ind = 3, bg = 4}},
        AttPosMods = {
            [2] = {
                vpos = Vector(00, -1.3, 31.7),
            },
        }
    },
    ["15a_foregrip"] = {
        VMBodygroups = {
            {ind = 5, bg = 1},
            {ind = 6, bg = 2}
        },
    },
    ["15a_top_short"] = {
        VMBodygroups = {{ind = 7, bg = 1}},
    },
    ["15a_top_closecombat"] = {
        NameChange = "Close-quarter DC-15a",
        VMBodygroups = {{ind = 7, bg = 2}},
    },
    ["15a_top_stabilizer"] = {
        NameChange = "DC-15le",
        VMBodygroups = {{ind = 8, bg = 1}},
    },
    ["15a_stock_short"] = {
        NameChange = "Skeleton DC-15a",
        VMBodygroups = {{ind = 10, bg = 1}},
    },
}

SWEP.Attachments = {
    [1] = {
        PrintName = "Long-Range Scope",
        DefaultAttName = "Standard", 
        Slot = "optic", 
        Bone = "dc-15a",
        Offset = {
            vpos = Vector(0, -2.2, 2.2),
            vang = Angle(90, 0, -90),
        },
        CorrectiveAng = Angle(0, 0, 0),
        CorrectivePos = Vector(0, 0, 0),
    },     
    [2] = {
        PrintName = "Muzzle",
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
        Bone = "dc-15a",
        Offset = {
            vpos = Vector(00, -1.3, 30.5),
            vang = Angle(90, 0, -90),

        },
    },       
    [3] = {
        PrintName = "Barrel",
        DefaultAttName = "None",
        Slot = "15a_barrel",
    },   
    [4] = {
        PrintName = "Foregrip",
        DefaultAttName = "None",
        Slot = {"15a_foregrip", "foregrip"},
        Bone = "dc-15a",
        InstalledEles = {"15a_rangefinder"},
        Offset = {
            vpos = Vector(0.1, 0, 11),
            vang = Angle(90, 0, -90),

        },
    },  
    [5] = {
        PrintName = "Top",
        DefaultAttName = "None",
        Slot = "15a_top",
    },  
    [6] = {
        PrintName = "Mag",
        DefaultAttName = "None",
        Slot = {"dc15a_magazine_75"},
        Bone = "dc-15a",
        Offset = {
            vpos = Vector(-0.7, -0.6, 2.5),
            vang = Angle(0, 0, 0),
        },
    },  
    [7] = {
        PrintName = "Stock",
        DefaultAttName = "None",
        Slot = "15a_stock",
    },  
    [8] = {
        PrintName = "Internal Modifications",
        DefaultAttName = "None",
        Slot = "uc_fg",
    },   
    [9] = {
        PrintName = "Ammo", 
        DefaultAttName = "Standard",
        Slot = "ammo",
    },
    [10] = {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = "perk",
    },
    [11] = {
        PrintName = "Charms",
        DefaultAttName = "None",
        Slot = {"charm"},
        Bone = "dc-15a",
        Offset = {
            vpos = Vector(0.830, -1.83, 10.273),
            vang = Angle(90, 0, -90),
        },
    },    
    [12] = {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "dc-15a",
        Offset = {
            vpos = Vector(0.830, -1.1, -1),
            vang = Angle(90, 0, -90),
        },
    },         
}

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "Idle"
    },
    ["fire"] = {
        Source = "shoot"
    },
    ["draw"] = {
        Source = "draw",
        SoundTable = {
            {
                s = "armasclasicas/wpn_empire_lgequip.wav",
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
                s = "armasclasicas/wpn_empire_medequip.wav",
                p = 100,
                v = 75,
                t = 0,
                c = CHAN_ITEM,
            },
        }
    },
    ["reload"] = {
        Source = "reload", 
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_03.mp3", t = 2.2 },
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_03.mp3", t = 0.1 / 30},
        },
    },
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
