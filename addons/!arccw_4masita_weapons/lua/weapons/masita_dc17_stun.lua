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
SWEP.PrintName = "Stun DC-17"
SWEP.Trivia_Class = "Pistolet blasterowy"
SWEP.Trivia_Desc = "Ręczny blaster DC-17, znany również jako pistolet blasterowy DC-17, był ciężkim pistoletem blasterowym, którym uzbrojeni byli żołnierze-klony Wielkiej Armii Galaktycznej Republiki podczas Wojen Klonów. Była to ulepszona broń palna, która trafiła do uzbrojenia elitarnych żołnierzy armii, przede wszystkim dowódców oddziałów zwiadowczych, dowódców oddziałów klonów i oddziałów klonów odrzutowych."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/dc17_stun.png"

SWEP.UseHands = true
SWEP.MirrorVMWM = true
SWEP.NoHideLeftHandInCustomization = true

SWEP.ViewModel = "models/venator/weapons/viewmodels/c_dc17.mdl"
SWEP.WorldModel = "models/venator/weapons/worldmodels/w_dc-17.mdl"
SWEP.ViewModelFOV = 58
SWEP.WorldModelOffset = {
    pos = Vector(-11.3, 4.3, -3),
    ang = Angle(-10, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
}

SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 1.5,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 29
SWEP.RangeMin = 102
SWEP.DamageMin = 23
SWEP.Range = 299
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400

SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1

SWEP.TracerNum = 1
SWEP.Tracer = "tracer_blue"
SWEP.TracerCol = Color(0, 0, 255)
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 20

SWEP.Recoil = 0.98
SWEP.RecoilPunch = 0.8
SWEP.RecoilSide = 0.17
SWEP.RecoilRise = 0.24

SWEP.Delay = 60 / 300
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
    Pos = Vector(-3.922, -4.125, 0.237),
    Ang = Vector(0.158, -3.961, 0),
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

SWEP.FirstShootSound = "armas/disparos/dc17_2.wav"
SWEP.ShootSound = "armas/disparos/dc17_1.wav"
SWEP.ShootSoundSilenced = "armas/disparos/dc19.wav"

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(1, 6, 1)
SWEP.ActiveAng = Angle(-3.2, -3, 0)

SWEP.SprintPos = Vector(1, -6, -10)
SWEP.SprintAng = Angle(40, 0, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.CustomizePos = Vector(10, 0, -1.08)
SWEP.CustomizeAng = Angle(6.8, 30.7, 10.3)

-- Attachments 
SWEP.AttachmentElements = {
    ["dc17_powerpack"] = {
        VMBodygroups = {
            {ind = 4, bg = 1},
        },
    },
    ["dc17_cooling"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
    },
}


SWEP.Attachments = {
    {
        PrintName = "Sight", 
        DefaultAttName = "Standard", 
        Slot = "optic",
        Bone = "DC-17",
        Offset = {
            vpos = Vector(0, -2.3, 0),
            vang = Angle(90, 0, -90),
        },
        CorrectiveAng = Angle(9, 0, 0),
        CorrectivePos = Vector(0, 0, 0),
    },  
    {
        PrintName = "Tactical",
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        WMScale = Vector(0.7, 0.7, 0.7),
        VMScale = Vector(0.7, 0.7, 0.7),
        Bone = "DC-17",
        Offset = {
            vpos = Vector(0, -0.3, 2.7),
            vang = Angle(90, 0, -90),
        },
    },     
    {
        PrintName = "Muzzle", 
        DefaultAttName = "None", 
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle"},
        Bone = "DC-17",
        Offset = {
            vpos = Vector(0, -1.2, 3.442),
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
        Slot = {"ammo", "sw_ammo"},
    },
    {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = "perk",
    },
    {
        PrintName = "Cooling System",
        DefaultAttName = "None",
        Slot = "dc17_cooling",
    },
    {
        PrintName = "Powerpack",
        DefaultAttName = "None",
        Slot = "dc17_powerpack",
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
        Bone = "DC-17",
        Offset = {
            vpos = Vector(0.7, -0.848, 0.184),
            vang = Angle(90, 0, -90),
        },
    },    
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "DC-17",
        Offset = {
            vpos = Vector(0.7, -0.848, -3),
            vang = Angle(90, 0, -90),
        },
    },   
}


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
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        SoundTable = {
            {s = "dc17_1", t = 1 / 60}, --s sound file
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
