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
SWEP.PrintName = "DC-17m Sniper"
SWEP.Trivia_Class = "Modułowa snajperka blasterowa"
SWEP.Trivia_Desc = "DC-17m Interchangeable Weapon System, znany również jako DC-17m Repeating Blaster Rifle, to rodzaj karabinu blasterowego z mechanizmem powtarzalnym, używanego przez komandosów Republiki podczas Wojen Klonów. Dzięki wymiennej lufie karabinu można było przełączać go między trybem karabinu blasterowego z mechanizmem powtarzalnym a granatnikiem."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/dc17m_sniper_new.png"

SWEP.Slot = 3

SWEP.UseHands = true
SWEP.NoHideLeftHandInCustomization = true
SWEP.MirrorVMWM = true
SWEP.UseHands = true
SWEP.ViewModel = "models/arccw/kraken/c_dc17m_sniper.mdl"
SWEP.WorldModel = "models/arccw/kraken/w_dc17m_sniper.mdl"
SWEP.ViewModelFOV = 70
SWEP.HideViewmodel = false
SWEP.WorldModelOffset = {
    pos = Vector(-5, 9, -6),
    ang = Angle(-10, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 1,
}

-- Damage & Properties
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 5	,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 150
SWEP.RangeMin = 190
SWEP.DamageMin = 35
SWEP.Range = 630
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400
SWEP.TracerNum = 1
SWEP.Tracer = "clone_tracer"
SWEP.TracerCol = Color(0, 0, 255)
SWEP.HullSize = 1.5
SWEP.ChamberSize = 0

SWEP.Primary.ClipSize = 5

SWEP.Recoil = 1.28
SWEP.RecoilSide = 0.12
SWEP.RecoilRise = 0.98

SWEP.Delay = 100 / 102
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
SWEP.MoveDispersion = 100

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false --
SWEP.MuzzleFlashColor = Color(0, 0, 255)

-- Ironsight & Properties
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 150
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.05

SWEP.ShootSound = "armas/disparos/dc17m/dc17m_sniper_fire0.wav"
SWEP.FirstShootSound = "armas/disparos/dc17m/dc17m_sniper_fire0.wav"
SWEP.ShootSoundSilenced = "armas/disparos/dc17m/dc17m_fire_silenced.wav"

SWEP.IronSightStruct = {
    Pos = Vector(-7.594, 0, 0.651),
    Ang = Angle(0.574, -1.456, 0),
     Magnification = 1.6,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 55,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-3, 3, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, 0, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(0, 3, -4)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

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
            vpos = Vector(0, -0.1, 4.8),
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
        PrintName = "Muzzle",
        DefaultAttName = "None",
        Slot = {"muzzle", "dlt19_muzzle", "dc15a_muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
        Bone = "weaponAttach_R",
        Offset = {
            vpos = Vector(28, 0, 3.9),
            vang = Angle(0, 0, 0),
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
        Bone = "weaponAttach_R",
        VMScale = Vector(0.7, 0.7, 0.7),
        Offset = {
            vpos = Vector(0, -1.4, 2.4),
            vang = Angle(0, 0, 0),
        },
    },
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "weaponAttach_R",
        VMScale = Vector(0.9, 0.9, 0.9),
        Offset = {
            vpos = Vector(-2, -1.3, 3.4),
            vang = Angle(0, 0, 20),
        },
    },
}

SWEP.Animations = {
    ["enter_inspect"]= {
        Source = "pose",
        SoundTable = {
            {
                s = "armas/disparos/dc17m/dc17m_sniper_pose.wav", -- sound; can be string or table
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
    ["draw"] = {
        Source = "draw",
        SoundTable = {
            {
                s = "armas/disparos/dc17m/dc17m_sniper_unholster.wav", -- sound; can be string or table
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
                s = "armas/disparos/dc17m/dc17m_sniper_unholster.wav", -- sound; can be string or table
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
            {s = "armas/disparos/dc17m/dc17m_sniper_reload.wav", t = 0.1 }, --s sound file
        },
    },
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
