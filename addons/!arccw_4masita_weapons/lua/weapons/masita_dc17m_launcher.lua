--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true

SWEP.Category = "[ArcCW] Republic Essentials - Masita"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "DC-17m Launcher"
SWEP.Trivia_Class = "Modułowa granatnik"
SWEP.Trivia_Desc = "DC-17m Interchangeable Weapon System, znany również jako DC-17m Repeating Blaster Rifle, to rodzaj karabinu blasterowego z mechanizmem powtarzalnym, używanego przez komandosów Republiki podczas Wojen Klonów. Dzięki wymiennej lufie karabinu można było przełączać go między trybem karabinu blasterowego z mechanizmem powtarzalnym a granatnikiem."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/dc17m_launcher_new.png"

SWEP.Slot = 3

SWEP.UseHands = true
SWEP.MirrorVMWM = true
SWEP.UseHands = true
SWEP.ViewModel = "models/arccw/kraken/c_dc17m_grenade.mdl"
SWEP.WorldModel = "models/arccw/kraken/w_dc17m_antiarmour.mdl"
SWEP.ViewModelFOV = 55
SWEP.HideViewmodel = false
SWEP.WorldModelOffset = {
    pos = Vector(-13, 7, -6),
    ang = Angle(-10, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 1,
}

-- Grenade Launcher properties
SWEP.ShootEntity = "arccw_nade_launcher17m"
SWEP.MuzzleVelocity = 4000

-- Damage & Tracer
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 1
SWEP.ExtendedClipSize = 1
SWEP.ReducedClipSize = 1

SWEP.Recoil = 0.1
SWEP.RecoilSide = 0.175
SWEP.RecoilRise = 0.76

SWEP.Delay = 60 / 105
SWEP.Num = 1
SWEP.Firemode = 1
SWEP.Firemodes = {
    {
		Mode = 1,
        PrintName = "ROCKET",
    },
	{
		Mode = 0,
   	}
}

SWEP.AccuracyMOA = 1
SWEP.HipDispersion = 300
SWEP.MoveDispersion = 125 
SWEP.SightsDispersion = 0 
SWEP.JumpDispersion = 200

-- Ammo, Sounds & MuzzleEffect
SWEP.Primary.Ammo = "grenade"
SWEP.ShootVol = 120
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.2

SWEP.FirstShootSound = "armas/disparos/dc17m/dc17m_grenade_fire0.wav"
SWEP.ShootSound = "armas/disparos/dc17m/dc17m_grenade_fire0.wav"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_orange"
SWEP.FastMuzzleEffect = false
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(250, 167, 0)


SWEP.IronSightStruct = {
    Pos = Vector(-4.14, -0.32, 2.207),
    Ang = Angle(2.267, -0.76, 0),
     Magnification = 1.5,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 55,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(0, 3, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, 0, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(0, 2, 2)
SWEP.CustomizeAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)


-- Attachments
SWEP.Attachments = {
    {
        PrintName = "Sight",
        DefaultAttName = "Standard",
        Slot = "optic",
        Bone = "weaponAttach_R",
        Offset = {
            vpos = Vector(3.3, -0.1, 4.9),
            vang = Angle(0, -0.5, 0),
        },
        CorrectiveAng = Angle(0, 1, 0),
        CorrectivePos = Vector(0, 0, 0),
    },
    {
        PrintName = "Tactical",
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol"},
        VMScale = Vector(0.7, 0.7, 0.7),
        Bone = "weaponAttach_R",
        Offset = {
            vpos = Vector(13, -1.76, 2.7),
            vang = Angle(0, 0, 90),
        },
    },
    {
        PrintName = "Rocket",
        DefaultAttName = "Standard",
        Slot = {"ammo_rocket"}
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
        Bone = "weaponAttach_R",
        VMScale = Vector(0.7, 0.7, 0.7),
        Offset = {
            vpos = Vector(0, -1.4, 2.4),
            vang = Angle(0, 0, 0),
        },
    },
}



SWEP.Animations = {
    ["enter_inspect"]= {
        Source = "pose",
        SoundTable = {
            {
                s = "masita/weapons/dc17m/dc17m_grenade_pose.wav", -- sound; can be string or table
                p = 100, -- pitch
                v = 100, -- volume
                t = 1, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["idle"] = {
        Source = "idle",
    },
    ["bash"] = {
        Source = "melee", 
        SoundTable = {
            {s = "armas/disparos/dc17m/melee0.wav", t = 0.1 },
        },
    },
    ["fire"] = {
        Source = "fire"
    },
    ["fire_iron"] = {
        Source = false
    },
    ["idle_iron"] = {
        Source = false
    },
    ["idle_sight"] = {
        Source = false
    },
    ["draw"] = {
        Source = "draw",
        SoundTable = {
            {
                s = "masita/weapons/dc17m/dc17m_grenade_draw.wav", -- sound; can be string or table
                p = 100, -- pitch
                v = 100, -- volume
                t = 0.1, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["holster"] = {
        Source = "holster",
        SoundTable = {
            {
                s = "masita/weapons/dc17m/dc17m_grenade_holster.wav", -- sound; can be string or table
                p = 100, -- pitch
                v = 75, -- volume
                t = 0.1, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2, 
        SoundTable = {
            {s = "masita/weapons/dc17m/dc17m_grenade_reload.wav", t = 0.1 }, --s sound file
        },
    },
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
