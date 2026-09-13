--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 1 -- Change this if you want to select the weapon with other number

SWEP.Category = "[ArcCW] Republic Essentials - Masita"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "DC-17s [Red]"
SWEP.Trivia_Class = "Ciężki pistolet blasterowy"
SWEP.Trivia_Desc = "Ręczny blaster DC-17s, znany również jako pistolet blasterowy DC-17s, był ciężkim pistoletem blasterowym, którym uzbrojeni byli żołnierze-klony Wielkiej Armii Galaktycznej Republiki podczas Wojen Klonów. Była to ulepszona broń palna, którą wyposażano elitarnych żołnierzy armii, przede wszystkim dowódców oddziałów zwiadowczych, dowódców oddziałów klonów i oddziałów klonów odrzutowych. Ta wersja jest bardzo potężna."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/dc17s_red.png"

-- Viewmodel & Entity Properties
SWEP.MirrorVMWM = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapon/ven/ggn/dc17s_single.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_scoutblaster.mdl"
SWEP.ViewModelFOV = 60
SWEP.HideViewmodel = false
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

SWEP.DefaultSkin = 0

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 1.5,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.AutoReload = true
SWEP.Damage = 32
SWEP.RangeMin = 133
SWEP.DamageMin = 16
SWEP.Range = 550
SWEP.Penetration = 1.1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400
SWEP.PhysTracerProfile = 1
SWEP.TracerNum = 1
SWEP.Tracer = "clone_tracer"
SWEP.TracerCol = Color(0, 0, 255)
SWEP.HullSize = 1.5
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 20
SWEP.Recoil = 0.5
SWEP.RecoilPunch = 0.3
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.17
SWEP.Delay = 60 / 337
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
SWEP.AccuracyMOA = 0.57
SWEP.HipDispersion = 576
SWEP.MoveDispersion = 53

-- Sounds & Muzzleflash
SWEP.ShootSound = "armas/disparos/dc17s.wav"
SWEP.ShootSoundSilenced = "armas/disparos/dc19.wav"
SWEP.NoFlash = nil 
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 255)


-- Ironsight & Holdtype
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 100
SWEP.ShootPitch = 100
SWEP.IronSightStruct = {
    Pos = Vector(-3.947, 1.389, 0.526),
    Ang = Angle(0, 0, 0),
     Magnification = 1,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 60,
}

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
SWEP.DefaultElements = {"dc17s"}
SWEP.AttachmentElements = {
    ["dc17s"] = { 
        WMElements = {
            {
                Model = "models/weapon/ven/ggn/dc17s_single_world.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1, 1, 1),
                ModelSkin = 0,
                Offset = {
                    pos = Vector(450, 50, -100),
                    ang = Angle(0, -10, -180),
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(1900, 200, -200),
                    ang = Angle(0, -10, 180)
                },
                IsMuzzleDevice = true
            }, 
        },
    },
}
WMOverride = "models/weapon/ven/ggn/dc17s_single_world.mdl"

SWEP.Attachments = {
    {
        PrintName = "Sight", -- name of the attachment
        DefaultAttName = "Standard", -- default name (like: 'default', 'none', 'standard')
        Slot = "optic", -- slots, you can add attachments per slot using this: Slot = {"optic", "optics", "etc"},
        Bone = "DC17S_Root",
        WMScale = Vector(111, 111, 111),
        Offset = {
            vpos = Vector(0.001, -1.9, -2.32),
            vang = Angle(90, 0, -90),
            wpos = Vector(600, 100, -475),
            wang = Angle(0, -10, 180)
        },
    },
    {
        PrintName = "Laser/Flashlight", 
        DefaultAttName = "None",
        Slot = {"tac_pistol", "tactical"},
        Bone = "DC17S_Root",
        WMScale = Vector(111, 111, 111),
        Offset = {
            vpos = Vector(-0.101, 0.557, 7.738),
            vang = Angle(90, 0, -90),
            wpos = Vector(1450, 265, -175),
            wang = Angle(0, -10, 180)
        },
    },    
    {
        PrintName = "Ammo",
        DefaultAttName = "Standard",
        Slot = {"ammo", "special_ammo"}
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
        WMScale = Vector(111, 111, 111),
        Bone = "DC17S_Root",
        Offset = {
            vpos = Vector(0.768, -0.238, 0),
            vang = Angle(90, 0, -90),
            wpos = Vector(750, 225, -350),
            wang = Angle(0, -10, 180)
        },
    },          
}


-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["sprint"] = {
        Source = "base_sprint_loop"
    },
    ["fire"] = {
        Source = "shoot"
    },
    ["draw"] = {
        Source = "draw",
        Mult = 1.1,
        SoundTable = {
            {
                s = "armas/misc/dc17s_draw.wav",
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
                s = "armas/misc/dc17s_holster.wav",
                p = 100, 
                v = 75,
                t = 0,
                c = CHAN_ITEM,
            },
        }
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL, 
        SoundTable = {
            {s = "dc17s_1", t = 1 / 30},
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL, 
        SoundTable = {
            {s = "dc17s_2", t = 4 / 30},
        },
    },


sound.Add({
    name =          "dc17s_1",
    channel =       CHAN_ITEM,
    volume =        1.5,
    sound =             "armas/misc/dc17s_reload.wav"
    }),
sound.Add({
    name =          "dc17s_2",
    channel =       CHAN_ITEM,
    volume =        1.5,
    sound =             "armas/misc/dc17s_empty.wav"
    }),
}



--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
