--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Category = "[ArcCW] Republic Essentials - Masita"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "SB-2"
SWEP.Trivia_Class = "Ciężka strzelba blasterowa"
SWEP.Trivia_Desc = "SB-2 to rodzaj blastera, który może przebić obronę wroga. Używali go żołnierze-klony Wielkiej Armii Republiki podczas Wojen Klonów między Galaktyczną Republiką a Konfederacją Niezależnych Systemów. DP-23 strzelał niebieskimi pociskami blasterowymi, miał żebrowaną lufę ze spiczastym wylotem, czarną kolbę i niewielką rękojeść."
SWEP.Trivia_Manufacturer = "Nieznany"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/sb2.png"

SWEP.Slot = 3

SWEP.UseHands = true

SWEP.ViewModel = "models/servius/weapons/viewmodels/c_sb-2.mdl"
SWEP.WorldModel = "models/servius/weapons/worldmodels/w_sb-2.mdl"
SWEP.ViewModelFOV = 55
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-5, 5, -6),
    ang = Angle(-10, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
}

SWEP.DefaultBodygroups = "000000000000"

SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 1.5,
    [HITGROUP_CHEST] = 1.5,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 35
SWEP.NoLastCycle = true
SWEP.ManualAction = true
SWEP.ShotgunReload = true
SWEP.RangeMin = 15
SWEP.DamageMin = 25
SWEP.Range = 35
SWEP.Penetration = 1
SWEP.DamageType = DMG_BUCKSHOT
SWEP.MuzzleVelocity = 400

SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1

SWEP.TracerNum = 1
SWEP.Tracer = "clone_tracer"
SWEP.TracerCol = Color(0, 0, 255)
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 8

SWEP.Recoil = 2
SWEP.RecoilSide = 2
SWEP.RecoilPunch = 0.9
SWEP.RecoilRise = 0.9

SWEP.Delay = 15/30
SWEP.Num = 5
SWEP.Firemodes = {
	{
		Mode = 1
	},
    {
        Mode = 0
    },
}

SWEP.AccuracyMOA = 50 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 450 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 100

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 255)


----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 100
SWEP.ShootPitch = 100

SWEP.ShootSound = "armas/disparos/sb2.wav"
SWEP.ShootSoundSilenced = "armas/disparos/silenced_sniper.mp3"

SWEP.IronSightStruct = {
    Pos = Vector(-3.724, -3.964, 2.733),
    Ang = Vector(0, 0, 3),
     Magnification = 1.2,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 50,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "smg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(-1, 4, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(.5, -6, -12)
SWEP.SprintAng = Angle(40, 0, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.CustomizePos = Vector(20.824, -3, 3.897)
SWEP.CustomizeAng = Angle(12.149, 50.547, 45)

SWEP.Attachments = {
    {
        PrintName = "Sight", 
        DefaultAttName = "Standard",
        Slot = "optic",
        Bone = "w_sb2",
        Offset = {
            vpos = Vector(0.261, 0.523, 2.338),
            vang = Angle(0, -90, 0),
        },
        CorrectiveAng = Angle(0, 180, 0),
        CorrectivePos = Vector(0, 0, 0),
    }, 
    {
        PrintName = "Tactical", 
        DefaultAttName = "None",
        Slot = {"tactical","tac_pistol"},
        Bone = "w_sb2", 
        Offset = {
            vpos = Vector(0.894, 8.522, 1.233),
            vang = Angle(0, -90, 90),
        },
    },    
    {
        PrintName = "Muzzle", 
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle"},
        Bone = "w_sb2",
        Offset = {
            vpos = Vector(0.2, 15.5, 1.1),
            vang = Angle(0, -90, 0),
        },
    },    
    {
        PrintName = "Energization", 
        DefaultAttName = "Standard",
        Slot = {"ammo", "shotgun_ammo"}
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
        Bone = "w_sb2", 
        Offset = {
            vpos = Vector(0.796, -0.996, 1.276),
            vang = Angle(0, -90, 0),
        },
    },          
}
SWEP.Animations = {
    ["idle"] = {
        Source = "neutral"
    },
    ["fire"] = {
        Source = "shoot",
    },
    ["cycle"] = {
        Source = "pump",
        Time = 0.9,
        SoundTable = {
            {s = "armas/disparos/sb2_pump.wav", t = 0.1 / 30}, 
        },
    },
    ["draw"] = {
        Source = "draw",
        Mult = 1.4,
        SoundTable = {
            {
                s = "draw/gunfoley_blaster_draw_var_10.mp3",
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
                s = "w/dc15s/gunfoley_blaster_sheathe_var_03.mp3", -- sound; can be string or table
                p = 100, -- pitch
                v = 75, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["sgreload_start"] = {
        Source = "reload_start",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {
			{s = "everfall/weapons/handling/misc_handling/hard_pickups/023d-0000106a.mp3", 	t = 0/30},
			{s = "weapons/fesiugmw2/foley/wpfoly_winchester_reload_loop_v1.wav", 	t = 14/30},
		},
    },
    ["sgreload_insert"] = {
        Source = "reload_insert",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {{s = "everfall/weapons/handling/reload_shells/heavy_shells/023d-00000777.mp3", 		t = 3/30}},
        RestoreAmmo = 1,
    },
    ["sgreload_finish"] = {
        Source = {"reload_finish"},
        SoundTable = {{s = "armas/disparos/sb2_pump.wav", 		t = 8/30}},
    },


sound.Add({
    name =          "ArcCW_dc15a.reload2",
    channel =       CHAN_ITEM,
    volume =        1.0,
    sound =             "weapons/bf3/heavy.wav"
    }),
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
