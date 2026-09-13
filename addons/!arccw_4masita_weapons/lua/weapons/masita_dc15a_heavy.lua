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
SWEP.PrintName = "Heavy DC-15a"
SWEP.Trivia_Class = "Ciężki karabin blasterowa"
SWEP.Trivia_Desc = "Karabin blasterowy DC-15A, znany również jako karabin blasterowy DC-15, był ciężkim karabinem blasterowym produkowanym przez BlastTech Industries jako część rodziny DC-15. Był to jeden z najpopularniejszych karabinów Wielkiej Armii Klonów podczas wojny klonów przeciwko Konfederacji Niezależnych Systemów. Ciężka modyfikacja DC-15A charakteryzuje się zwiększoną szybkostrzelnością praktycznie bez utraty mocy rażenia."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/dc15a_hvy.png"

-- Viewmodel & Entity Properties
SWEP.DefaultBodygroups = "000400000001"
SWEP.MirrorVMWM = true
SWEP.UseHands = true
SWEP.ViewModel = "models/everfall/weapons/viewmodels/c_dc15a.mdl"
SWEP.WorldModel = "models/everfall/weapons/worldmodels/w_dc15a.mdl"
SWEP.ViewModelFOV = 60
SWEP.WorldModelOffset = {
    pos = Vector(-13, 6, -4.5),
    ang = Angle(-10, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
}

SWEP.NoHideLeftHandInCustomization = true

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 1.8,
    [HITGROUP_CHEST] = 1.5,
    [HITGROUP_LEFTARM] = 1.1,
    [HITGROUP_RIGHTARM] = 1.1,
}

SWEP.Damage = 40
SWEP.RangeMin = 100
SWEP.DamageMin = 15
SWEP.Range = 200
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 413
SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1
SWEP.TracerNum = 1
SWEP.Tracer = "clone_tracer"
SWEP.TracerCol = Color(0, 0, 250)
SWEP.HullSize = 1
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 55
SWEP.Recoil = 0.23
SWEP.RecoilSide = 0.11
SWEP.RecoilRise = 0.11
SWEP.Delay = 50 / 399
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
SWEP.AccuracyMOA = 0.59
SWEP.HipDispersion = 447
SWEP.MoveDispersion = 54

-- Speed Mult
SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.83
SWEP.SightTime = 0.2

-- Ammo, Sounds & MuzzleEffect
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 100
SWEP.ShootPitch = 90
SWEP.ShootSound = "weapon/venator/dc15a.wav"
SWEP.ShootSoundSilenced = "armas/disparos/dc19.wav"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 255)

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-4.987, -9.924, 0.939),
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

SWEP.ActivePos = Vector(0, -2, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(4.019, -5.226, -0.805)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(15, -5, -1.321)
SWEP.CustomizeAng = Angle(18.2, 39.4, 14.8)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.InBipodPos = Vector(-8, 0, -4)
SWEP.InBipodMult = Vector(2, 1, 1)

SWEP.Bipod_Integral = true -- Integral bipod (ie, weapon model has one)
SWEP.BipodDispersion = 1 -- Bipod dispersion for Integral bipods
SWEP.BipodRecoil = 1 -- Bipod recoil for Integral bipods

-- Attachments
SWEP.Attachments = {      
    {
        PrintName = "Magazine Capacity",
        DefaultAttName = "Standard",
        Bone = "dc-15a",
        Slot = {"dc15a_magazine_75"},
        Offset = {
            vpos = Vector(-1.7, -0.6, 2.5),
            vang = Angle(0, 0, 0),
        },
    },         
    {
        PrintName = "Ammo", 
        DefaultAttName = "Standard",
        Slot = {"ammo", "special_ammo"},
    },
    {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = "perk",
    }, 
    {
        PrintName = "Grenade Launcher",
        DefaultAttName = "None",
        Slot = {"rep_ubgl"},
        Bone = "dc-15a",
        Offset = {
            vpos = Vector(0, -1.4, 20.675),
            vang = Angle(90, 0, -90),
        },
    },    
    {
        PrintName = "Tactical",
        DefaultAttName = "None",
        Slot = {"tactical","tac_pistol"},
        Bone = "dc-15a",
        Offset = {
            vpos = Vector(0, -1.4, 20.7),
            vang = Angle(90, 0, 0),
        },
    },      
    {
        PrintName = "Muzzle",
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
        Bone = "dc-15a",
        Offset = {
            vpos = Vector(0, -1.4, 31.2),
            vang = Angle(90, 0, 0),
        },
    },  
    {
        PrintName = "Charms",
        DefaultAttName = "None",
        Slot = {"charm"},
        Bone = "dc-15a",
        Offset = {
            vpos = Vector(0.830, -1.83, 10.273),
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
