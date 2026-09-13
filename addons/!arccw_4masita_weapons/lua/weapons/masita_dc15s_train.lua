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
SWEP.PrintName = "Training DC-15s"
SWEP.Trivia_Class = "Karabin Blasterowy"
SWEP.Trivia_Desc = "Karabin blasterowy DC-15A, zwany również blasterem DC-15S, to model karabinu blasterowego używanego przez Wielką Armię Republiki. Należał on do rodziny DC-15. Pomimo tego, że jest mniejszy od większego karabinu blasterowego DC-15A, oba modele można zaliczyć do karabinów blasterowych. Była to jedna z najpopularniejszych broni wydawanych żołnierzom-klonom podczas Wojen Klonów i była używana w wielu bitwach."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/dc15s_training.png"

-- Viewmodel & Entity Properties
SWEP.UseHands = true
SWEP.MirrorVMWM = true
SWEP.NoHideLeftHandInCustomization = true

SWEP.ViewModel = "models/servius/starwars/c_dc15s.mdl"
SWEP.WorldModel = "models/servius/starwars/w_dc15s.mdl"
SWEP.ViewModelFOV = 58
SWEP.WorldModelOffset = {
    pos = Vector(-9, 3.5, -4.5),
    ang = Angle(-10, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
}

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 1.6,
    [HITGROUP_CHEST] = 1.2,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 1
SWEP.RangeMin = 198
SWEP.DamageMin = 1
SWEP.Range = 399
SWEP.Penetration = 1.1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400
SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1
SWEP.TracerNum = 1
SWEP.Tracer = "tracer_orange"
SWEP.TracerCol = Color(250, 167, 0)
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

SWEP.AccuracyMOA = 0.5 
SWEP.HipDispersion = 490
SWEP.MoveDispersion = 60

-- Sounds & Muzzleflash
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 125
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.05

SWEP.ShootSound = "armas/disparos/dc15s.wav"
SWEP.ShootSoundSilenced = "armas/disparos/dc19.wav"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_orange"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(250, 162, 0)

-- Ironsight & Holdtype
SWEP.IronSightStruct = {
    Pos = Vector(-2.837, 0.619, 1.656),
    Ang = Angle(0, 0, 0),
     Magnification = 1.3,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 55,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "smg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1

SWEP.ActivePos = Vector(0, 2, 0.5)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, 0, 0)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(10, -5, 1)
SWEP.CustomizeAng = Angle(15, 40, 30)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

-- Attachments 
SWEP.Attachments = {
    {
        PrintName = "Sight", 
        DefaultAttName = "Standard", 
        Slot = "optic",
        Bone = "DC15",
        Offset = {
            vpos = Vector(0, -1.6, -0.5),
            vang = Angle(90, 0, -90),
        },
    },    
    {
        PrintName = "Grip",
        DefaultAttName = "None",
        Slot = "foregrip",
        Bone = "DC15",
        Offset = {
            vpos = Vector(-0.101, 2.378, 6.164),
            vang = Angle(90, 0, -90),
        },
        SlideAmount = {
        vmin = Vector(-0.2, 0, 5.100),
        vmax = Vector(-0.2, 0, 9),
        },          
    },
    {
        PrintName = "Stock",
        DefaultAttName = "None",
        Bone = "DC15",
        Slot = "stock",
        Offset = {
            vpos = Vector(0, 0.5, -9.1),
            vang = Angle(0, 0, -90),
        },
    }, 
    {
        PrintName = "Tactical",
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        VMScale = Vector(0.7, 0.7, 0.7),
        Bone = "DC15", 
        Offset = {
            vpos = Vector(0.8, -0.5, 10),
            vang = Angle(90, 0, 0),
        },
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
        Bone = "DC15",
        Offset = {
            vpos = Vector(0.1, -0.442, 11.638),
            vang = Angle(90, 0, -90),

        },
    },    
    {
        PrintName = "Ammo",
        DefaultAttName = "Standard",
        Slot = {"ammo"},
    },
    {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = "perk",
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
        Bone = "DC15",
        VMScale = Vector(0.7, 0.7, 0.7),
        Offset = {
            vpos = Vector(0.9, -0.7, 5.7),
            vang = Angle(90, 0, -90),
        },
    },     
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "DC15",
        Offset = {
            vpos = Vector(0.8, -0.2, -5),
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
            {s = "dc15s_1", t = 1.68 / 60},
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_manualcooling_var_02.mp3", t = 0.1},
        },
    },

sound.Add({
    name =          "dc15s_1",
    channel =       CHAN_ITEM,
    volume =        1.5,
    sound =             "armasclasicas/wpn_empire_medreload.wav"
    }),

}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
