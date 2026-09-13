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

-- Trivia
SWEP.Category = "[ArcCW] Republic Essentials - Masita"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "DC-15sa"
SWEP.Trivia_Class = "Modułowy pistolet blasterowy"
SWEP.Trivia_Desc = "Blaster DC-15s to pistolet blasterowy stworzony przez firmę BlasTech Industries dla Wielkiej Armii Republiki. Pistolety DC-15s były używane przez komandosów klonów jako broń zapasowa, uzupełniająca cięższy system broni wymiennej DC-17m. Element energetyczny zapewniał powolne, ale stabilne przeładowywanie blastera."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/dc15sa.png"

SWEP.UseHands = true

SWEP.MirrorVMWM = false
SWEP.ViewModel = "models/jellyton/view_models/c_DC15SA.mdl"
SWEP.WorldModel = "models/bf2017/w_scoutblaster.mdl"
SWEP.ViewModelFOV = 60
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 1.5,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 36
SWEP.RangeMin = 90
SWEP.DamageMin = 23
SWEP.Range = 551
SWEP.Penetration = 1.1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400

SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1

SWEP.TracerNum = 1
SWEP.Tracer = "clone_tracer"
SWEP.TracerCol = Color(0, 0, 255)
SWEP.HullSize = 1

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 20

SWEP.Recoil = 0.34
SWEP.RecoilPunch = 0.4
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.17

SWEP.Delay = 60 / 253
SWEP.Num = 1
SWEP.Firemodes = {
	{
		Mode = 1
	},
    {
        Mode = 0
    },
}

SWEP.AccuracyMOA = 0.16
SWEP.HipDispersion = 410
SWEP.MoveDispersion = 37

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 255)

----AMMO / stuff----
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 100
SWEP.ShootPitch = 100
SWEP.ShootSound = "armas/disparos/dc15sa.wav"
SWEP.ShootSoundSilenced = "w/dc19.wav"

SWEP.InfiniteAmmo = true
SWEP.BottomlessClip = true
SWEP.Jamming = true
SWEP.HeatGain = 1 
SWEP.HeatCapacity = 20
SWEP.HeatDissipation = 15 
SWEP.HeatLockout = true
SWEP.HeatDelayTime = 0.5

SWEP.IronSightStruct = {
    Pos = Vector(-5.173, -6.689, 0.411),
    Ang = Vector(0, 0, 0),
     Magnification = 1.2,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 50,
}

SWEP.HoldtypeHolstered = "idle"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-4, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(0, 0, -20)
SWEP.SprintAng = Angle(40, 0, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Vector(-15, 0, 0)

SWEP.CustomizePos = Vector(10, -13, 0)
SWEP.CustomizeAng = Angle(12.149, 50.547, 45)

-- Attachments
SWEP.DefaultElements = {"dc15sa"}
SWEP.AttachmentElements = {
    ["dc15sa"] = {
        VMElements = {
            {
                Model = "models/cs574/weapons/dc15sa.mdl",
                Bone = "DC-15SA",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(-0.128, 4.4, -0.9),
                    ang = Angle(90, 0, -90),
                }
            }
        },
        WMElements = {
            {
                Model = "models/cs574/weapons/dc15sa.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(840, 100, 275),
                    ang = Angle(0, 0, 180)
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(1250, 100, -400),
                    ang = Angle(-15, 0, 180)
                },
                IsMuzzleDevice = true
            }, 
        },
    },
}
WMOverride = "models/cs574/weapons/dc15sa.mdl"
SWEP.Attachments = {
    {
        PrintName = "Sight", 
        DefaultAttName = "Standard", 
        Slot = "optic",
        WMScale = Vector(111, 111, 111),
        Bone = "DC-15SA",
        Offset = {
            vpos = Vector(-0.150, -1.9, -5.32),
            vang = Angle(90, 0, -90),
            wpos = Vector(400, 100, -475),
            wang = Angle(0, 0, 180)
        },
        CorrectiveAng = Angle(0, 0, 0),
        CorrectivePos = Vector(0, -4, 0),
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "None", 
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle"},
        WMScale = Vector(111, 111, 111),
        Bone = "DC-15SA", 
        Offset = {
            vpos = Vector(-0, -1.5, 4.2),
            vang = Angle(90, 0, 0),
            wpos = Vector(1450, 100, -400),
            wang = Angle(0, 0, 180)
        },
    },       
    {
        PrintName = "Tactical", 
        DefaultAttName = "None", 
        Slot = {"tactical","tac_pistol"},
        WMScale = Vector(100, 100, 100),
        Bone = "DC-15SA", 
        Offset = {
            vpos = Vector(-1.1, -0.6, 3),
            vang = Angle(90, 0, -90),
            wpos = Vector(1110, 100, -250),
            wang = Angle(0, 0, -180)
        },
    },      
    {
        PrintName = "Energization",
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
        Bone = "DC-15SA", 
        Offset = {
            vpos = Vector(0.503, -1.3, -5.336),
            vang = Angle(90, 0, -90),
            wpos = Vector(325, 180, -350),
            wang = Angle(-10, 0, 180)
        },
    },          
}

SWEP.Animations = {
    ["fire"] = {
        Source = "fire",
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
            {s = "dc15sa_1", t = 1 / 60}, --s sound file
        },
    },


sound.Add({
    name =          "dc15sa_1",
    channel =       CHAN_ITEM,
    volume =        1.0,
    sound =             "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_var_02.mp3"
    }),
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
