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
SWEP.PrintName = "DC-15s"
SWEP.Trivia_Class = "Karabin blasterowy"
SWEP.Trivia_Desc = "Mniejszy od karabinu DC-15A, DC-15S nie mógł się pochwalić taką samą dalekosiężnością jak jego odpowiednik DC-15A, ale za to był łatwy w użyciu. Blastery DC-15s strzelały naładowanymi wiązkami plazmy, aktywowanymi gazem tibanna, przechowywanym w wymiennych nabojach blasterowych. Magazynki wystarczały na 500 strzałów, w zależności od ustawień mocy strzału. Broń tę preferowali niedoświadczeni, „błyskotliwi” klony. Korzystając z takiego blastera, nie było potrzeby noszenia ze sobą ciężkich magazynków z nabojami."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/dc15s.png"
SWEP.desc = 'Mniejszy od karabinu DC-15A, DC-15S nie mógł się pochwalić taką samą dalekosiężnością jak jego odpowiednik DC-15A, ale za to był łatwy w użyciu.'
-- Viewmodel & Entity Properties
SWEP.UseHands = true
SWEP.MirrorVMWM = true
SWEP.NoHideLeftHandInCustomization = false

SWEP.ViewModel = "models/servius/starwars/c_dc15s.mdl"
SWEP.WorldModel = "models/servius/starwars/w_dc15s.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModelOffset = {
    pos = Vector(-9, 3.5, -4.5),
    ang = Angle(-10, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
}

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 1.6,
    [HITGROUP_CHEST] = 1.2,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 45
SWEP.RangeMin = 198
SWEP.DamageMin = 21
SWEP.Range = 399
SWEP.Penetration = 1.1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400
SWEP.TraceNum = 2
SWEP.PhysTracerProfile = 1
SWEP.TracerNum = 1
SWEP.Tracer = "clone_tracer"
SWEP.TracerCol = Color(0, 0, 250)
SWEP.HullSize = 1
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 34

SWEP.Recoil = 0.1
SWEP.RecoilSide = 0.1
SWEP.RecoilRise = 0.2
SWEP.Delay = 65 / 255

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

SWEP.AccuracyMOA = 0.2
SWEP.HipDispersion = 100
SWEP.MoveDispersion = 60

-- Sounds & Muzzleflash
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 125
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.05

SWEP.ShootSound = "everfall/weapons/dlt-19/blasters_dlt19_laser_close_var_03.mp3"
SWEP.ShootSoundSilenced = "w/dc19.wav"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 250)

-- Ironsight & Holdtype
SWEP.IronSightStruct = {
    Pos = Vector(-2.837, 0.619, 1.656),
    Ang = Angle(0, 0, 0),
     Magnification = 1.3,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 55,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "smg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1

SWEP.ActivePos = Vector(0, 2, 0.5)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, 0, 0)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(10, -5, 1)
SWEP.CustomizeAng = Angle(15, 40, 30)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

-- Attachments 
SWEP.Attachments = {
    {
        PrintName = "Sight", 
        DefaultAttName = "Standard", 
        Slot = "optic",
        Bone = "DC15",
        Offset = {
            vpos = Vector(0, -1.6, -0.5),
            vang = Angle(90, 0, -90),
        },
    },    
    {
        PrintName = "Grip",
        DefaultAttName = "None",
        Slot = "foregrip",
        Bone = "DC15",
        Offset = {
            vpos = Vector(-0.101, 2.378, 6.164),
            vang = Angle(90, 0, -90),
        },
        SlideAmount = {
        vmin = Vector(-0.2, 0, 5.100),
        vmax = Vector(-0.2, 0, 9),
        },          
    },
    {
        PrintName = "Stock",
        DefaultAttName = "None",
        Bone = "DC15",
        Slot = "stock",
        Offset = {
            vpos = Vector(0, 0.5, -9.1),
            vang = Angle(0, 0, -90),
        },
    }, 
    {
        PrintName = "Tactical",
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        VMScale = Vector(0.7, 0.7, 0.7),
        Bone = "DC15", 
        Offset = {
            vpos = Vector(0.8, -0.5, 10),
            vang = Angle(90, 0, 0),
        },
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
        Bone = "DC15",
        Offset = {
            vpos = Vector(0.1, -0.442, 11.638),
            vang = Angle(90, 0, -90),

        },
    },    
    {
        PrintName = "Ammo",
        DefaultAttName = "Standard",
        Slot = {"ammo", "sw_stun"},
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
        Bone = "DC15",
        VMScale = Vector(0.7, 0.7, 0.7),
        Offset = {
            vpos = Vector(0.9, -0.7, 5.7),
            vang = Angle(90, 0, -90),
        },
    },     
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "DC15",
        Offset = {
            vpos = Vector(0.8, -0.2, -5),
            vang = Angle(90, 0, -90),
        },
    },      
}

-- Don't touch this unless you know what you're doing
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
        Mult = 1.4,
        SoundTable = {
            {
                s = "w/dc15s/overheat_manualcooling_resetfoley_generic_var_01.mp3",
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
                s = "w/dc15s/gunfoley_blaster_sheathe_var_03.mp3",
                p = 100, 
                v = 75, 
                t = 0,
                c = CHAN_ITEM,
            },
        }
    },
    ["reload"] = {
        Source = "reload", 
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        SoundTable = {
            {s = "dc15s_1", t = 1.68 / 60},
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_manualcooling_var_02.mp3", t = 0.1},
        },
    },

sound.Add({
    name =          "dc15s_1",
    channel =       CHAN_ITEM,
    volume =        1.5,
    sound =             "armasclasicas/wpn_empire_medreload.wav"
    }),

}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
