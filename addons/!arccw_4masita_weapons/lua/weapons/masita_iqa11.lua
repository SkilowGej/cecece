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
SWEP.PrintName = "IQA-11"
SWEP.Trivia_Class = "Karabin snajperski typu blaster"
SWEP.Trivia_Desc = "IQA-11 Blaster Rifle to model karabinu snajperskiego o eleganckim i niedrogim wyglądzie, który sprawił, że stał się on ulubioną bronią najemników i łowców nagród, poszukujących niezawodności na dużych odległościach. Karabin mógł być modyfikowany, np. poprzez wydłużenie lufy i dodanie celownika z podwójnym powiększeniem. Podczas Wojen Klonów łowca nagród Rumi Paramita używał IQA-11, chroniąc feluciańskich farmerów przed bandą Ohnaka. Mon Calamari również używał tej broni w epoce Imperium."
SWEP.Trivia_Manufacturer = "Unknown"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/iqa11.png"

SWEP.UseHands = true

SWEP.ViewModel = "models/servius/weapons/viewmodels/c_iqa11.mdl"
SWEP.WorldModel = "models/servius/weapons/worldmodels/w_iqa-11.mdl"
SWEP.ViewModelFOV = 70
SWEP.MirrorVMWM = false
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

SWEP.DefaultBodygroups = "000000000000"
-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 4,
    [HITGROUP_CHEST] = 1.3,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 200
SWEP.RangeMin = 200
SWEP.DamageMin = 63
SWEP.Range = 950
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400


SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1

SWEP.TracerNum = 1
SWEP.Tracer = "clone_tracer"
SWEP.TracerCol = Color(250, 0, 0)
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 10

SWEP.Recoil = 1.2
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.18

SWEP.Delay = 200 / 210
SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 1
    },
    {
        Mode = 0
    },         
}

SWEP.AccuracyMOA = 0.1 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 530 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 50

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(255, 0, 0)


-- Properties
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 120
SWEP.ShootPitchVariation = 0.05
SWEP.ShootPitch = 70

SWEP.ShootSound = "armas/disparos/nt242.mp3"
SWEP.ShootSoundSilenced = "armas/disparos/silenced_sniper.mp3"

SWEP.IronSightStruct = {
    Pos = Vector(-3.49, -3.547, 2.612),
    Ang = Angle(0, 0, 0),
     Magnification = 1.2,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 50,
}
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN
SWEP.ManualAction = true

SWEP.ActivePos = Vector(0, 0, 2)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, 0, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(9.824, 2, -2.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)


SWEP.DefaultElements = {}
SWEP.AttachmentElements = {}

SWEP.InBipodPos = Vector(-8, 0, -4)
SWEP.InBipodMult = Vector(2, 1, 1)

SWEP.Bipod_Integral = true
SWEP.BipodDispersion = 1
SWEP.BipodRecoil = 1 

--SWEP.Attachments 
SWEP.DefaultElements = {"iqa11"}
SWEP.AttachmentElements = {
    ["iqa11"] = {
        WMElements = {
            {
                Model = "models/servius/weapons/viewmodels/c_iqa11.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                WBodygroups = {{ind = 1, bg = 1}},
                Offset = {
                    pos = Vector(-800, 500, -500),
                    ang = Angle(-15, 0, 180)
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(4700, 80, -1500),
                    ang = Angle(0, 0, 100)
                },
                IsMuzzleDevice = true
            },
        },
    },
}
WMOverride = "models/servius/weapons/viewmodels/c_iqa11.mdl"
SWEP.Attachments = {
    {
        PrintName = "Sight", -- print name
        DefaultAttName = "Standard", -- used to display the "no attachment" text
        Slot = "optic",
        WMScale = Vector(111, 111, 111),
        Bone = "IQA11_mesh", -- relevant bone any attachments wwill be mostly referring to
        Offset = {
            vpos = Vector(0.032, -1.043, 1.723),
            vang = Angle(0, -90, 0),
            wpos = Vector(650, 85, -510),
            wang = Angle(-15, 0, 180)
        },
        CorrectiveAng = Angle(0, 180, 0),
        CorrectivePos = Vector(0, 0, 0),
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard",
        Slot = {"muzzle", "dlt19_muzzle", "dc15a_muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
        WMScale = Vector(111, 111, 111),
        Bone = "IQA11_mesh",
        Offset = {
            vpos = Vector(0.059, 33.666, 0.86),
            vang = Angle(0, -90, 0),
            wpos = Vector(4700, 80, -1500),
            wang = Angle(-15, 0, -90)
        },
    },
    {
        PrintName = "Tactical", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = {"tactical","tac_pistol"},
        WMScale = Vector(111, 111, 111),
        Bone = "IQA11_mesh", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.7, 9.63, 1.113),
            vang = Angle(0, -90, 90),
            wpos = Vector(2000, 150, -750),
            wang = Angle(-15, 0, -90)
        },
    },    
    {
        PrintName = "Grip", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = {"foregrip", "bipod"},
        WMScale = Vector(111, 111, 111),
        Bone = "IQA11_mesh", -- relevant bone any attachments wwill be mostly referring to
        Offset = {
            vpos = Vector(-0.222, 9.911, 0),
            vang = Angle(0, -90, 0),
            wang = Angle(165, 180, 0),
        },
        SlideAmount = {
            vmin = Vector(-0, 9.9, 0),
            vmax = Vector(-0, 3.5, 0),
            wmin = Vector(1600, 80, -550), 
            wmax = Vector(1600, 80, -550)   -- how far this attachment can slide in both directions.
        },  
    }, 
    {
        PrintName = "Ammo", -- print name
        DefaultAttName = "Standard", -- used to display the "no attachment" text
        Slot = "ammo",
    },  
    {
        PrintName = "Perk", -- print name
        DefaultAttName = "Standard", -- used to display the "no attachment" text
        Slot = "perk",
    },
    {
        PrintName = "Charm", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = {"charm"},
        WMScale = Vector(111, 111, 111),
        Bone = "IQA11_mesh", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.546, -0.829, 0.085),
            vang = Angle(0, -90, 0),
            wpos = Vector(900, 145, -420),
            wang = Angle(-10 , 0, -180)
        },
    },          
}
SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["cycle"] = {
        Source = "Pump",
        SoundTable = {
                {s = "everfall/weapons/handling/reload_gentle/locknload/023d-00000922.mp3", t = 1 / 60},
        },
    },
    ["fire"] = {
        Source = "Shoot"
    },
    ["draw"] = {
        Source = "draw",
        SoundTable = {
            {
                s = "draw/gunfoley_blaster_dc17m_draw_var_03.mp3", -- sound; can be string or table
                p = 100, -- pitch
                v = 100, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["holster"] = {
        Source = "holster",
        SoundTable = {
            {
                s = "holster/gunfoley_blaster_sheathe_var_04.mp3", -- sound; can be string or table
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
            {s = "ArcCW_dp24.reload2", t = 4 / 30}, --s sound file
        },
    },


sound.Add({
    name =          "ArcCW_dp24.reload2",
    channel =       CHAN_ITEM,
    volume =        1.0,
    sound =             "armasclasicas/wpn_republic_medreload.wav"
    }),
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
