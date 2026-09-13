--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Category = "[ArcCW] Republic Essentials - Masita"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "DP-23"
SWEP.Trivia_Class = "Ciężka strzelba blasterowa"
SWEP.Trivia_Desc = "DP-23 to rodzaj blastera, który może przebić obronę wroga. Był używany przez żołnierzy-klonów Wielkiej Armii Republiki podczas Wojen Klonów między Galaktyczną Republiką a Konfederacją Niezależnych Systemów. DP-23 strzelał niebieskimi pociskami blasterowymi, miał żebrowaną lufę ze spiczastym wylotem, czarną kolbę i niewielką rękojeść."
SWEP.Trivia_Manufacturer = "Unknown"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/dp23.png"

SWEP.Slot = 3

SWEP.UseHands = true
SWEP.ViewModel = "models/arccw/bf2017/c_dlt19.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"
SWEP.ViewModelFOV = 55
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 1.5,
    [HITGROUP_CHEST] = 1.5,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 30
SWEP.RangeMin = 20
SWEP.DamageMin = 17
SWEP.Range = 55
SWEP.Penetration = 1.1
SWEP.DamageType = DMG_BUCKSHOT
SWEP.MuzzleVelocity = 400

SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1

SWEP.TracerNum = 1
SWEP.Tracer = "clone_tracer"
SWEP.TracerCol = Color(0, 0, 255)
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 12

SWEP.Recoil = 2
SWEP.RecoilSide = 2
SWEP.RecoilPunch = 0.9
SWEP.RecoilRise = 0.9

SWEP.Delay = 50 / 70
SWEP.Num = 5
SWEP.Firemodes = {
	{
		Mode = 1
	},
    {
        Mode = 0
    },
}

SWEP.AccuracyMOA = 50
SWEP.HipDispersion = 450
SWEP.MoveDispersion = 100

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 250)
SWEP.Primary.Ammo = "ar2"

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-3.325, -5.188, 2),
    Ang = Vector(0, 0, 0),
     Magnification = 1.2,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 50,
}

-- Holdtype
SWEP.ShootVol = 100
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.04
SWEP.ShootSound = "armas/disparos/dp23.wav"
SWEP.ShootSoundSilenced = "armas/disparos/silenced_sniper.mp3"

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "smg"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(-1, 2, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(4.019, -5.226, -0.805)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.CustomizePos = Vector(7, -3, -1.206)
SWEP.CustomizeAng = Angle(18.291, 30.954, 17.587)

SWEP.DefaultElements = {"dp23", "muzzle"}
SWEP.AttachmentElements = {
    ["dp23"] = {
        VMElements = {
            {
                Model = "models/tor/dp23_base.mdl",
                Bone = "v_dlt19_reference001",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(-0.5, 5, 1.5),
                    ang = Angle(0, -180, 0)
                }
            }
        }
    },
    ["muzzle"] = {
         VMElements = {
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "dlt19_sight",
                Scale = Vector(0, 0, 0),             
                Offset = {
                    pos = Vector(-0.5, 5, 8),
                    ang = Angle(90, 0, 0)
                },
                IsMuzzleDevice = true
            }
        },
        WMElements = {
            {
                Model = "models/tor/dp23_base.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1.2, 1.2, 1.2),
                Offset = {
                    pos = Vector(1100, -50, -450),
                    ang = Angle(5, 90, 190)
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(2800, 0, -500),
                    ang = Angle(-15, 0, 180)
                },
                IsMuzzleDevice = true
            },            
        }, 
    }
}
WMOverride = "models/tor/dp23_base.mdl"

--SWEP.Attachments
SWEP.Attachments = {
    {
        PrintName = "Sight", 
        DefaultAttName = "Standard",
        Slot = "optic",
        Bone = "dlt19_sight",
        VMScale = Vector(0.8, 0.8, 0.8),
        WMScale = Vector(111, 111, 111),
        Offset = {
            vpos = Vector(-0.150, 0.6, -1.5),
            vang = Angle(90, 0, -90),
            wpos = Vector(1000, 50, -740),
            wang = Angle(-5, -1, 180)
        },
        CorrectiveAng = Angle(0, 0, 0),
        CorrectivePos = Vector(0, 0, 0),
    }, 
    {
        PrintName = "Tactical",
        DefaultAttName = "None", 
        Slot = {"tactical", "tac_pistol", "tac"},
        VMScale = Vector(0.8, 0.8, 0.8),
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(0.8, 2.5, 7),
            vang = Angle(90, 0, -0),
            wpos = Vector(2300, 200, -600),
            wang = Angle(-5, -1, -90)
        },
    },    
    {
        PrintName = "Grenade Launcher", 
        DefaultAttName = "None",
        Slot = "rep_ubgl",
        Bone = "v_dlt19_reference001",
        WMScale = Vector(130, 130, 130),
        Offset = {
            vpos = Vector(0, 5, 1.6),
            vang = Angle(0, -90, 0),
            wpos = Vector(1200, 50, -530),
            wang = Angle(-5, -1, -180)
        },   
        LHIK = true    
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "None", 
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
        Bone = "dlt19_sight", 
        WMScale = Vector(111, 111, 111),
        Offset = {
            vpos = Vector(0, 2.5, 10),
            vang = Angle(90, 0, -90),
            wpos = Vector(2800, 50, -650),
            wang = Angle(-5, 0.5, 180)
        },
    },  
    {
        PrintName = "Energization",
        DefaultAttName = "Standard Energization",
        Slot = {"ammo", "shotgun_ammo"}
    }, 
    {
        PrintName = "Internal Modifications",
        DefaultAttName = "None",
        Slot = {"uc_fg"},
    },       
    {
        PrintName = "Training/Perk",
        DefaultAttName = "None",
        Slot = "perk",
    },
    {
        PrintName = "Charm",
        DefaultAttName = "None",
        Slot = {"charm"},
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(0.5, 2.5, -6),
            vang = Angle(90, 0, -90),
            wpos = Vector(400, 150, -430),
            wang = Angle(-5, 0, 180)
        },
    },           
}
SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = {"shoot1", "shoot2", "shoot3"}
    },
    ["fire_iron"] = {
        Source = {"shoot1", "shoot2", "shoot3"}
    },
    ["draw"] = {
        Source = "draw",
        SoundTable = {
            {
                s = "draw/gunfoley_pistol_draw_var_06.mp3", -- sound; can be string or table
                p = 100, -- pitch
                v = 75, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["holster"] = {
        Source = "holster",
        SoundTable = {
            {
                s = "holster/gunfoley_pistol_sheathe_var_09.mp3", -- sound; can be string or table
                p = 100, -- pitch
                v = 75, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_04.mp3", t = 0.1/30},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_01.mp3", t = 2},
        },
    },
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
