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
SWEP.PrintName = "Training DC-15a"
SWEP.Trivia_Class = "Karabin blasterowy"
SWEP.Trivia_Desc = "Karabin blasterowy DC-15A, znany po prostu jako karabin blasterowy DC-15, to ciężki karabin blasterowy produkowany przez firmę BlasTech Industries i należący do rodziny DC-15. Podczas wojen klonów przeciwko Konfederacji Niezależnych Systemów była ona jednym ze standardowych rodzajów broni klonów-desantników Galaktycznej Republiki – armii sklonowanych żołnierzy Wielkiej Armii Republiki."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/dc15a_training.png"

-- Viewmodel & Entity Properties
SWEP.UseHands = true
SWEP.NoHideLeftHandInCustomization = true
SWEP.ViewModel = "models/servius/weapons/viewmodels/c_dc15a.mdl"
SWEP.WorldModel = "models/servius/weapons/worldmodels/w_dc-15a.mdl"
SWEP.ViewModelFOV = 56

SWEP.DefaultBodygroups = "010"
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 1.5,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 1
SWEP.RangeMin = 243
SWEP.DamageMin = 1
SWEP.Range = 510
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400

SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1
SWEP.TracerNum = 1
SWEP.Tracer = "tracer_orange"
SWEP.TracerCol = Color(250, 146, 0)

SWEP.HullSize = 1
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 55

SWEP.Recoil = 0.43
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
		Mode = -2
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
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_orange"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(255, 157, 0)

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-4.66, -12.75, 2.529),
    Ang = Angle(0, 0, 0),
     Magnification = 1.5,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 50,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 2, 3)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, 0, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(15, -5, 1)
SWEP.CustomizeAng = Angle(15, 40, 30)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.InBipodPos = Vector(-8, 0, -4)
SWEP.InBipodMult = Vector(2, 1, 1)

SWEP.Bipod_Integral = true 
SWEP.BipodDispersion = 1
SWEP.BipodRecoil = 1 

-- Attachments
SWEP.DefaultElements = {"dc15"}
SWEP.AttachmentElements = {
    ["dc15"] = {
        WMElements = {
            {
                Model = "models/servius/weapons/worldmodels/w_dc-15a.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                WBodygroups = {{ind = 0, bg = 0}},
                Offset = {
                    pos = Vector(-550, 0, 470),
                    ang = Angle(-15, 0, 180)
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(4150, 0, -1100),
                    ang = Angle(-15, 0, 100)
                },
                IsMuzzleDevice = true
            },
        },
    },
}
WMOverride = "models/servius/weapons/worldmodels/w_dc-15a.mdl"

SWEP.Attachments = {
    {
        PrintName = "Sight",
        DefaultAttName = "Standard", 
        Slot = "optic", 
        WMScale = Vector(111, 111, 111),
        Bone = "dc15a_DC15_mat",
        Offset = {
            vpos = Vector(0.110, -3.771, 2.1),
            vang = Angle(0, -90, 0),
            wpos = Vector(420, 50, -450),
            wang = Angle(-15, 0, 180)
        },
        CorrectiveAng = Angle(0, 180, 0),
        CorrectivePos = Vector(0, 0, 0),
    },          
    {
        PrintName = "Magazine Capacity",
        DefaultAttName = "Standard",
        Slot = {"dc15a_magazine_75"},
        WMScale = Vector(111, 111, 111),
        Bone = "dc15a_DC15_mat",
        Offset = {
            vpos = Vector(0, -3.7, 0.5),
            vang = Angle(0, 0, 90),
            wpos = Vector(550, 115, -250),
            wang = Angle(-15, -90, -90)
        },
    },      
    {
        PrintName = "Internal Modifications",
        DefaultAttName = "None",
        Slot = "uc_fg",
    },   
    {
        PrintName = "Ammo", 
        DefaultAttName = "Standard",
        Slot = "ammo",
    },
    {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = "perk",
    },
    {
        PrintName = "Charms",
        DefaultAttName = "None",
        Slot = {"charm"},
        VMScale = Vector(0.7, 0.7, 0.7),
        WMScale = Vector(111, 111, 111),
        Bone = "dc15a_DC15_mat",
        Offset = {
            vpos = Vector(1.3, -6.739, 0.504),
            vang = Angle(0, -90, 0),
            wpos = Vector(115, 180, -125),
            wang = Angle(-10 , 0, 180)
        },
    },    
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        WMScale = Vector(111, 111, 111),
        Bone = "dc15a_DC15_mat",
        Offset = {
            vpos = Vector(1.1, -9, 0.7),
            vang = Angle(0, -90, 0),
            wpos = Vector(-100, 180, -75),
            wang = Angle(-15 , 0, 180)
        },
    },         
}

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "Neutral"
    },
    ["fire"] = {
        Time = 2.3,
        Source = {"shoot", "shoot2"},
    },
    ["fire_iron"] = {
        Source = false,
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
            {s = "dc15a_reload1", t = 2 / 10},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_03.mp3", t = 2 },
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_03.mp3", t = 2 / 30},
        },
    },


sound.Add({
    name =          "dc15a_reload1",
    channel =       CHAN_ITEM,
    volume =        1.0,
    sound =             "armas/misc/dc17s_reload.wav"
    }),
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
