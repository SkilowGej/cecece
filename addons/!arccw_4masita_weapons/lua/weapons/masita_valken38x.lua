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
SWEP.Credits = "Kraken/Masita/Meeks"
SWEP.PrintName = "Valken 38x"
SWEP.Trivia_Class = "Blaster Sniper Rifle"
SWEP.Trivia_Desc = "The Valken-38x was a model of longblaster that was manufactured for high precision and power over long ranges. It was utilized by the Galactic Republic during the Clone Wars."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Tibanna Gas"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/valken38.png"

-- Viewmodel & Entity Properties
SWEP.UseHands = true
SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultWMBodygroups = "00000000"
SWEP.ViewModel = "models/servius/weapons/viewmodels/c_valken38x.mdl"
SWEP.WorldModel = "models/servius/weapons/worldmodels/w_valken38x.mdl"
SWEP.ViewModelFOV = 70
SWEP.HideViewmodel = false

-- Damage & Tracer
SWEP.BodyDamageMults = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1.3,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 105
SWEP.RangeMin = 230
SWEP.DamageMin = 73
SWEP.Range = 890
SWEP.Penetration = 1.2
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 45
SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1
SWEP.TracerNum = 1
SWEP.Tracer = "clone_tracer"
SWEP.TracerCol = Color(0, 0, 250)
SWEP.HullSize = 1
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 17
SWEP.Recoil = 0.14
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.1
SWEP.Delay = 60 / 120
SWEP.Num = 1
SWEP.Firemodes = {
	{
		Mode = 1
	},
    {
        Mode = 0
    },
}

SWEP.AccuracyMOA = 0.47
SWEP.HipDispersion = 376
SWEP.MoveDispersion = 60
SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.83
SWEP.SightTime = 0.2

-- Ammo, Sounds & MuzzleEffect
SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 250)
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 100
SWEP.ShootPitch = 100
SWEP.ShootSound = "armas/disparos/valken.wav"
SWEP.ShootSoundSilenced = "armas/disparos/silenced_sniper.mp3"

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-2.99, -4.258, 1.029),
    Ang = Vector(0, 0.127, 2.813),
     Magnification = 1,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 50,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(0, 2, 0.5)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, 0, 0)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(10, -5, 1)
SWEP.CustomizeAng = Angle(15, 40, 30)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

-- Attachments 
-- Attachments 
SWEP.DefaultElements = {"muzzle"}
SWEP.AttachmentElements = {
    ["muzzle"] = {
        WMElements = {
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(20, 0.5, -8),
                    ang = Angle(0, 0, 0)
                },
                IsMuzzleDevice = true
            }
        },
    },
}

SWEP.Attachments = {
    {
        PrintName = "Sight",
        DefaultAttName = "Standard",
        Slot = "optic",
        Bone = "Valken38x_material",
        Offset = {
            vpos = Vector(0.18, -6.25, 1.273),
            vang = Angle(0, -90, 0),
            wpos = Vector(6, 1.5, -5),
            wang = Angle(-10, 2, 180)
        },
        CorrectiveAng = Angle(0, 180, 0),
        CorrectivePos = Vector(0, 0, 0),
    },
    {
        PrintName = "Laser/Flashlight", 
        DefaultAttName = "None",
        Slot = {"tactical","tac_pistol"},
        Bone = "Valken38x_material",
        Offset = {
            vpos = Vector(0.972, 7.546, 0.651),
            vang = Angle(0, -90, 90),
            wpos = Vector(14, 2, -5.5),
            wang = Angle(-10, 5, -90)
        },
    },
    {
        PrintName = "Grip",
        DefaultAttName = "None",
        Slot = "foregrip",
        Bone = "Valken38x_material",
        Offset = {
            vpos = Vector(0, 1.628, 0),
            vang = Angle(0, -90, 0),
            wpos = Vector(9, .5, 2),
            wang = Angle(0, 0, 180)    
        },
        SlideAmount = {
        vmin = Vector(-0.2, 2, 0),
        vmax = Vector(-0.2, 7, 0),
        wmin = Vector(9, 0.8, -4), 
        wmax = Vector(9, 0.8, -4)
        },                  
    },     
    {
        PrintName = "Energization", -- print name
        DefaultAttName = "Standard Energization", -- used to display the "no attachment" text
        Slot = "ammo",
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
        Bone = "Valken38x_material",
        Offset = {
            vpos = Vector(0.6, -7.752, 0.5),
            vang = Angle(0, -90, 0),
            wpos = Vector(6, 1.8, -4.5),
            wang = Angle(0, 0, 180)
        },
    },          
}


SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = "Shoot"
    },
    ["draw"] = {
        Source = "draw",
        Mult = 1.4,
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
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        SoundTable = {
            {s = "valken38_r1", t = 1 / 30}, --s sound file
        },
    },


sound.Add({
    name =          "valken38_r1",
    channel =       CHAN_ITEM,
    volume =        1.1,
    sound =             "armas/misc/standard_reload.ogg"
    }),
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
