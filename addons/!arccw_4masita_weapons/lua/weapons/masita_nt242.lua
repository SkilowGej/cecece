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
SWEP.PrintName = "NT-242"
SWEP.Trivia_Class = "Karabin snajperski typu blaster"
SWEP.Trivia_Desc = "NT-242 – typ karabinu snajperskiego. Wielu użytkowników uważało NT-242 za jeden z najcięższych długich karabinów. NT-242 miał duży zasięg strzału i mógł być modyfikowany do niszczenia pojazdów."
SWEP.Trivia_Manufacturer = "Nieznany"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/nt242.png"

SWEP.UseHands = true

SWEP.ViewModel = "models/everfall/weapons/viewmodels/c_nt242.mdl"
SWEP.WorldModel = "models/everfall/weapons/worldmodels/w_nt242.mdl"
SWEP.ViewModelFOV = 55
SWEP.MirrorVMWM = true
SWEP.HideViewmodel = false
SWEP.WorldModelOffset = {
    pos = Vector(-11.5, 4, -5),
    ang = Angle(-10, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
}

SWEP.DefaultWMBodygroups = "02"
SWEP.DefaultBodygroups = "02"

-- Properties
SWEP.BodyDamageMults = {
    [HITGROUP_HEAD] = 2.5,
    [HITGROUP_CHEST] = 1.3,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 130
SWEP.RangeMin = 273
SWEP.DamageMin = 69
SWEP.Range = 1072

SWEP.Penetration = 1.3
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400

SWEP.TracerNum = 1
SWEP.Tracer = "clone_tracer"
SWEP.TracerCol = Color(247, 0, 255)
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 18

SWEP.Recoil = 1
SWEP.RecoilSide = 0.3
SWEP.RecoilRise = 0.1

SWEP.Delay = 70 / 98
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
SWEP.HipDispersion = 300

SWEP.MoveDispersion = 60
SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_purple"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(247, 0, 255)

SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 100
SWEP.ShootPitch = 80

SWEP.ShootSound = "armas/disparos/nt242.mp3"
SWEP.ShootSoundSilenced = "armas/disparos/silenced_sniper.mp3"
SWEP.IronSightStruct = {
    Pos = Vector(-3.71, -5.549, 1.526),
    Ang = Angle(0, 0, 0),
     Magnification = 2,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 50,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 0, 2)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, 0, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(9.824, 2, -2.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.InBipodPos = Vector(-8, 0, -4)
SWEP.InBipodMult = Vector(2, 1, 1)

SWEP.Bipod_Integral = true
SWEP.BipodDispersion = 1
SWEP.BipodRecoil = 1

SWEP.AttachmentElements = {
    ["242_barrel_extended"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        NameChange = "Extended NT-242",
        AttPosMods = {
            [3] = {
                vpos = Vector(0.007, 0.98, 47.5),
            },
        }
    },
}

SWEP.Attachments = {
    [1] = {
        PrintName = "Sight",
        DefaultAttName = "Standard", 
        Slot = "optic",
        Bone = "nt242", 
        Offset = {
            vpos = Vector(0, -1.1, 4.93),
            vang = Angle(90, 0, -90),
        },
        CorrectiveAng = Angle(0, 0, 0),
        CorrectivePos = Vector(0, 0, 0),
    },
    [2] = {
        PrintName = "Barrel", 
        DefaultAttName = "Standard",
        Slot = "242_barrel",
    },  
    [3] = {
        PrintName = "Muzzle",
        DefaultAttName = "Standard",
        Slot = {"muzzle", "dlt19_muzzle", "dc15a_muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
        Bone = "nt242",
        Offset = {
            vpos = Vector(0.007, 0.98, 40.043),
            vang = Angle(90, 0, 0),
        },
    },
    [4] = {
        PrintName = "Grip",
        DefaultAttName = "None",
        Slot = {"foregrip", "bipod"},
        Bone = "nt242", 
        Offset = {
            vpos = Vector(0, 2.253, 15.001),
            vang = Angle(90, 0, -90),
        },
        SlideAmount = {
            vmin = Vector(0, 2, 15),
            vmax = Vector(0, 2, 25),
        },  
    }, 
    [5] = {
        PrintName = "Tactical", 
        DefaultAttName = "None",
        Slot = {"tactical","tac_pistol"},
        Bone = "nt242", 
        Offset = {
            vpos = Vector(0.939, 0.982, 14.303),
            vang = Angle(90, 0, 0),
        },
    },    
    [6] = {
        PrintName = "Ammo", 
        DefaultAttName = "Standard",
        Slot = "ammo",
    },  
    [7] = {
        PrintName = "Perk", 
        DefaultAttName = "Standard",
        Slot = "perk",
    },
    [8] = {
        PrintName = "Charm", 
        DefaultAttName = "None", 
        Slot = {"charm"},
        Bone = "nt242", 
        VMScale = Vector(0.7, 0.7, 0.7),
        Offset = {
            vpos = Vector(0.931, 1.174, 0),
            vang = Angle(90, 0, -90),
        },
    },    
    [9] = {
        PrintName = "Killcounter", 
        DefaultAttName = "None", 
        Slot = {"killcounter"},
        VMScale = Vector(0.9, 0.9, 0.9),
        Bone = "nt242", 
        Offset = {
            vpos = Vector(0.931, 1.174, 5),
            vang = Angle(90, 0, -90),
        },
    },          
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
    },
    ["fire"] = {
        Source = "shoot"
    },
    ["draw"] = {
        Source = "draw",
        Mult = 1.1,
        SoundTable = {
            {s = "everfall/weapons/handling/reload_heavy/locknload/023d-00000f08.mp3", t = 1}
        },
    },
    ["reload"] = {
        Source = "reload",
        LHIK = true,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2, 
        SoundTable = {
            {s = "nt242_r1", t = 3 / 30}, --s sound file
            {s = "everfall/weapons/handling/reload_heavy/locknload/023d-00000f08.mp3", t = 2.2}
        },
    },


sound.Add({
    name =          "nt242_r1",
    channel =       CHAN_ITEM,
    volume =        1.5,
    sound =             "armasclasicas/wpn_republic_medreload.wav"
    }),
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
