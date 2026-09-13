--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2

-- Trivia
SWEP.Category = "[ArcCW] Republic Essentials - Masita"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "DC-17 Extended"
SWEP.Trivia_Class = "Pistolet blasterowy"
SWEP.Trivia_Desc = "Ręczny blaster DC-17, znany również jako pistolet blasterowy DC-17, był ciężkim pistoletem blasterowym, którym uzbrojeni byli żołnierze-klony Wielkiej Armii Galaktycznej Republiki podczas Wojen Klonów. Była to ulepszona broń palna, która trafiła do uzbrojenia elitarnych żołnierzy armii, przede wszystkim dowódców oddziałów zwiadowczych, dowódców oddziałów klonów i oddziałów klonów odrzutowych."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/dc17_ext.png"

SWEP.UseHands = true
SWEP.MirrorVMWM = true
SWEP.NoHideLeftHandInCustomization = false

SWEP.ViewModel = "models/everfall/weapons/viewmodels/c_dc17_extended.mdl"
SWEP.WorldModel = "models/everfall/weapons/worldmodels/w_dc17_extended.mdl"
SWEP.ViewModelFOV = 58
SWEP.WorldModelOffset = {
    pos = Vector(-13.3, 3, -4.9),
    ang = Angle(-10, 0, 180),
    scale = 1.1,
    bone = "ValveBiped.Bip01_R_Hand",
}

SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 34
SWEP.RangeMin = 132
SWEP.DamageMin = 23
SWEP.Range = 327
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400

SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1

SWEP.TracerNum = 1
SWEP.Tracer = "clone_tracer"
SWEP.TracerCol = Color(0, 0, 255)
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 27

SWEP.Recoil = 1.02
SWEP.RecoilPunch = 0.8
SWEP.RecoilSide = 0.17
SWEP.RecoilRise = 0.34

SWEP.Delay = 60 / 376
SWEP.Num = 1
SWEP.Firemodes = {
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

SWEP.AccuracyMOA = 0.22 
SWEP.HipDispersion = 530
SWEP.MoveDispersion = 50

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 255)

---- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-1.298, -1.102, 1.84),
    Ang = Vector(1.639, -2.372, 20.429),
     Magnification = 1.2,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 50,
}

SWEP.Primary.Ammo = "ar2"

-- Sound & Holdtype
SWEP.ShootVol = 125
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.05

SWEP.FirstShootSound = "armas/disparos/dc17ext_2.wav"
SWEP.ShootSound = "armas/disparos/dc17ext_1.wav"
SWEP.ShootSoundSilenced = "armas/disparos/dc19.wav"

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "revolver"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(0, 6, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(1, -6, -10)
SWEP.SprintAng = Angle(40, 0, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.CustomizePos = Vector(10, 0, 1)
SWEP.CustomizeAng = Angle(6.8, 30.7, 10.3)

-- Attachments 
SWEP.AttachmentElements = {}


SWEP.Attachments = {
    {
        PrintName = "Sight", 
        DefaultAttName = "Standard", 
        Slot = "optic",
        Bone = "dc17",
        Offset = {
            vpos = Vector(0.1, -2.5, 0),
            vang = Angle(90, 0, -90),
        },
        CorrectiveAng = Angle(-4, -1.2, 0),
        CorrectivePos = Vector(0, 0, 0),
    },  
    {
        PrintName = "Tactical",
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        WMScale = Vector(0.7, 0.7, 0.7),
        VMScale = Vector(0.7, 0.7, 0.7),
        Bone = "dc17",
        Offset = {
            vpos = Vector(0.1, 0.4, 5),
            vang = Angle(90, 0, -90),
        },
    },     
    {
        PrintName = "Muzzle", 
        DefaultAttName = "None", 
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle"},
        Bone = "dc17",
        Offset = {
            vpos = Vector(0.3, -0.8, 6.3),
            vang = Angle(90, 0, -90),
        },
    }, 
    {
        PrintName = "Grip",
        Slot = "grip",
        DefaultAttName = "Standard Grip"
    },        
    {
        PrintName = "Energization", 
        DefaultAttName = "Standard",
        Slot = "ammo",
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
        VMScale = Vector(0.7,0.7,0.7),
        Bone = "dc17",
        Offset = {
            vpos = Vector(0.7, -1, 0.184),
            vang = Angle(90, 0, -90),
        },
    },    
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "dc17",
        Offset = {
            vpos = Vector(0.6, -0.848, 3),
            vang = Angle(90, 0, -90),
        },
    },   
}


SWEP.Animations = {
    ["idle"] = {
        Source = "Idle",
    },
    ["bash"] = {
        Source = "Bash"
    },
    ["fire"] = {
        Source = "Shoot"
    },
    ["fire_iron"] = {
        Source = "Shoot"
    },
    ["draw"] = {
        Source = "Draw",
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
        Source = "Holster",
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
        Source = "Reload", 
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_03.mp3", t = 40 / 30 },
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_03.mp3", t = 0.1 / 30},
        },
    },


sound.Add({
    name =          "dc17_1",
    channel =       CHAN_ITEM,
    volume =        1.0,
    sound =             "armasclasicas/wpn_wristrocket_reload.wav"
    }),
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
