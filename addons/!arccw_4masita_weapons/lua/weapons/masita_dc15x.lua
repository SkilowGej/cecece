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
SWEP.PrintName = "DC-15x"
SWEP.Trivia_Class = "Karabin snajperski typu blaster"
SWEP.Trivia_Desc = "Karabin snajperski DC-15x to karabin snajperski stworzony dla snajperów-klonów Galaktycznej Republiki poprzez znaczną modyfikację standardowego karabinu blasterowego DC-15A."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/dc15x.png"

-- Viewmodel & Entity Properties
SWEP.UseHands = true
SWEP.NoHideLeftHandInCustomization = true

SWEP.ViewModel = "models/ser/starwars/c_dc15x.mdl"
SWEP.WorldModel = "models/ser/starwars/w_dc15x.mdl"

SWEP.ViewModelFOV = 50
SWEP.WorldModelOffset = {
    pos = Vector(8, 1., -3.5),
    ang = Angle(-5, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 1.2
}

SWEP.DefaultBodygroups = "111"
SWEP.DefaultWMBodygroups = "111"

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 2.5,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 140
SWEP.RangeMin = 433
SWEP.DamageMin = 54
SWEP.Range = 1075
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
SWEP.Primary.ClipSize = 11

SWEP.Recoil = 1.2
SWEP.RecoilSide = 0.36
SWEP.RecoilRise = 0.76

SWEP.Delay = 65 / 70
SWEP.Num = 1
SWEP.Firemodes = {
	{
		Mode = 1
	},
    {
        Mode = 0
    },
}

SWEP.AccuracyMOA = 0.1
SWEP.HipDispersion = 500
SWEP.MoveDispersion = 76

SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.83
SWEP.SightTime = 0.35

-- Ammo, Sounds & MuzzleEffect
SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 250)
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 125
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.05

SWEP.ShootSound = "armas/disparos/dc15x.wav"
SWEP.ShootSoundSilenced = "armas/disparos/silenced_sniper.mp3"

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-2.941, -6.442, 1.307),
    Ang = Vector(0, 0, 0),
     Magnification = 1.5,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 50,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(1, 3, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, 0, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(10, -5, 1)
SWEP.CustomizeAng = Angle(15, 40, 30)

SWEP.InBipodPos = Vector(-8, 0, -4)
SWEP.InBipodMult = Vector(2, 1, 1)

SWEP.Bipod_Integral = true
SWEP.BipodDispersion = 1
SWEP.BipodRecoil = 1

-- Attachments 
SWEP.Attachments = {
	{
		PrintName = "Sight", 
		DefaultAttName = "Standard",
		Slot = "optic",
		Bone = "optic",
		Offset = {
            vpos = Vector(0.02, 0, 0),
            vang = Angle(90, 0, -90),
            wpos = Vector(6, 0.8, -4.6),
            wang = Angle(-7, 0, 180),
        },
	},
    {
        PrintName = "Tactical", 
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        Bone = "optic",
        Offset = {
            vpos = Vector(0.8, 1, 15),
            vang = Angle(90, 0, -0),
            wpos = Vector(24, 1.4, -5),
            wang = Angle(-5, 0, -90),
        },
    },
    {
        PrintName = "Grip",
        DefaultAttName = "None",
        Slot = "foregrip",
        Bone = "optic",
        Offset = {
            vpos = Vector(0, 2, 15),
            vang = Angle(90, 0, -90),    
            wang = Angle(-3, 0, 180)     
        },
        SlideAmount = {
        vmin = Vector(-0.2, 2.6, 6),
        vmax = Vector(-0.2, 2.6, 12),
        wmin = Vector(15, 0.6, -2.3), 
        wmax = Vector(15, 0.6, -2.3)
        },         
    }, 
    {
        PrintName = "Muzzle",
        DefaultAttName = "None", 
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
        Bone = "optic", 
        Offset = {
            vpos = Vector(0, 1, 20),
            vang = Angle(90, 0, -90),
            wpos = Vector(26, 0.75, -5.25),
            wang = Angle(-5, 0.5, 180)
        },
    },  
    {
        PrintName = "Energization",
        DefaultAttName = "Standard Energization",
        Slot = "ammo",
    },  
    {
        PrintName = "Internal Modifications",
        DefaultAttName = "None",
        Slot = "uc_fg",
    }, 
    {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = "perk",
    },
    {
        PrintName = "Charm",
        DefaultAttName = "None",
        Slot = {"charm"},
        Bone = "optic",
        VMScale = Vector(0.7, 0.7, 0.7),
        Offset = {
            vpos = Vector(1, 1.6, -3.8),
            vang = Angle(90, 0, -90),
            wpos = Vector(2.3, 1.8, -2.3),
            wang = Angle(0, 0, 180)
        },
    },       
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "optic",
        Offset = {
            vpos = Vector(1, 1.350, -6),
            vang = Angle(90, 0, -90),
            wpos = Vector(-2, 1.8, -2.3),
            wang = Angle(-5, 0, 180)
        },
    },      
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = "fire"
    },
    ["fire_iron"] = {
        Source = false,
    },
    ["draw"] = {
        Source = "draw",
        SoundTable = {
            {
                s = "draw/sw01_characters_gunfoley_draw_blaster_var14.mp3", -- sound; can be string or table
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
                s = "w/dc15s/gunfoley_blaster_sheathe_var_03.mp3", -- sound; can be string or table
                p = 100, -- pitch
                v = 75, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["reload"] = {
        Source = "reload", 
        LHIK = true,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "dc15x-1", t = 0.1 }, --s sound file
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_03.mp3", t = 0.1 },
            {s = "everfall/weapons/handling/reload_heavy/mag_load/023d-000000ae.mp3", t = 0.9 }, --s sound file
        },
    },

sound.Add({
    name =          "dc15x-1",
    channel =       CHAN_ITEM,
    volume =        1.1,
    sound =             "everfall/weapons/handling/reload_heavy/mag_eject/023d-00000628.mp3"
    }),
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
