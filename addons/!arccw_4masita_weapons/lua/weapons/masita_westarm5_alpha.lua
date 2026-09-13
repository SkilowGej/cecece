--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 1 

SWEP.Category = "[ArcCW] Republic Essentials - Masita"
SWEP.Credits = "Kraken/Masita/Meeks"
SWEP.PrintName = "Westar M-5 Alpha"
SWEP.Trivia_Class = "Modular Blaster"
SWEP.Trivia_Desc = "The WESTAR-M5 blaster rifle was a blaster rifle used during the Clone Wars by the Grand Army of the Republic. They were mainly used by the Alpha-class Advanced Recon Commandos during the later years of the conflict."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Tibanna Gas"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/westarm5_alpha.png"

SWEP.ViewModel = "models/ser/starwars/c_westarm5.mdl"
SWEP.WorldModel = "models/ser/starwars/w_westarm5.mdl"
SWEP.ViewModelFOV = 70

SWEP.DefaultBodygroups = "111"
SWEP.DefaultWMBodygroups = "111"
SWEP.DefaultSkin = 3
SWEP.DefaultWMSkin = 3

SWEP.NoHideLeftHandInCustomization = false

SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 1.7,
    [HITGROUP_CHEST] = 1.5,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 47
SWEP.DamageMin = 22 -- damage done at maximum range
SWEP.RangeMin = 172 -- how far bullets will retain their maximum damage for
SWEP.Range = 340 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.DamageTypeHandled = false

SWEP.MuzzleVelocity = 472

SWEP.AlwaysPhysBullet = false
SWEP.NeverPhysBullet = false
SWEP.PhysTracerProfile = 3
SWEP.TracerNum = 1 
SWEP.TracerFinalMag = 0 
SWEP.Tracer = "tracer_blue"
SWEP.TracerCol = Color(0, 47, 255)
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 50 -- DefaultClip is automatically set.

SWEP.AmmoPerShot = 1

SWEP.ReloadInSights = false
SWEP.ReloadInSights_CloseIn = 0.25
SWEP.ReloadInSights_FOVMult = 0.875
SWEP.LockSightsInReload = false

SWEP.Recoil = 0.2
SWEP.RecoilSide = 0.1
SWEP.RecoilRise = 0
SWEP.MaxRecoilBlowback = 1
SWEP.VisualRecoilMult = 1

SWEP.RecoilDirection = Angle(0.2, 0, 0)
SWEP.RecoilDirectionSide = Angle(0, 1.1, 0)

SWEP.Delay = 60 / 580 
SWEP.Num = 1 
SWEP.Firemode = 2 
SWEP.Firemodes = {
	{
		Mode = 2,
   	},
    {
		Mode = 1,
    },
	{
		Mode = 0,
   	}
}

SWEP.NotForNPCS = true
SWEP.NPCWeaponType = nil

SWEP.AccuracyMOA = 5 
SWEP.HipDispersion = 410 
SWEP.MoveDispersion = 65
SWEP.SightsDispersion = 150 
SWEP.JumpDispersion = 200

SWEP.ShootWhileSprint = false

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 125 
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.05

SWEP.FirstShootSound = "armas/disparos/westar_1.wav"
SWEP.ShootSound = "armas/disparos/westar_2.wav"
SWEP.ShootSoundSilenced = "armas/disparos/dc19.wav"

SWEP.FiremodeSound = "weapons/arccw/firemode.wav"
SWEP.MeleeSwingSound = "weapons/arccw/melee_lift.wav"
SWEP.MeleeMissSound = "weapons/arccw/melee_miss.wav"
SWEP.MeleeHitSound = "weapons/arccw/melee_hitworld.wav"
SWEP.MeleeHitNPCSound = "weapons/arccw/melee_hitbody.wav"


SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false 

SWEP.MuzzleEffectAttachment = 1 
SWEP.ProceduralViewBobAttachment = 1
SWEP.MuzzleFlashColor = Color(0, 102, 255)

SWEP.SpeedMult = 0.87
SWEP.SightedSpeedMult = 0.77
SWEP.ShootSpeedMult = 1

SWEP.IronSightStruct = {
    Pos = Vector(-3.05, -0, 2.1),
    Ang = Angle(0, 0, 0),
    Midpoint = {
        Pos = Vector(0, 0, 0),
        Ang = Angle(0, 0, 0),
    },
    Magnification = 1.2,
    SwitchToSound = "armasclasicas/wpn_cis_medequip.wav",
    CrosshairInSights = false,
}


SWEP.SightTime = 0.13
SWEP.SprintTime = 0


SWEP.Malfunction = false
SWEP.MalfunctionJam = true 
SWEP.MalfunctionTakeRound = true 
SWEP.MalfunctionWait = 0.5 
SWEP.MalfunctionMean = nil 
SWEP.MalfunctionVariance = 0.25
SWEP.MalfunctionSound = "weapons/arccw/malfunction.wav"

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "ar2"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.CanBash = true
SWEP.MeleeDamage = 27
SWEP.MeleeRange = 16
SWEP.MeleeDamageType = DMG_CLUB
SWEP.MeleeTime = 0.5
SWEP.MeleeGesture = nil
SWEP.MeleeAttackTime = 0.2
SWEP.SprintPos = Vector(.5, -6, -12)
SWEP.SprintAng = Angle(40, 0, 0)
SWEP.BashPreparePos = Vector(2.187, -4.117, -7.14)
SWEP.BashPrepareAng = Angle(32.182, -3.652, -19.039)
SWEP.BashPos = Vector(8.876, 0, 0)
SWEP.BashAng = Angle(-16.524, 70, -11.046)
SWEP.ActivePos = Vector(0, 3, 1)
SWEP.ActiveAng = Angle(0, 0, 0)
SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)
SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetCrouch = nil
SWEP.BarrelOffsetHip = Vector(3, 0, -3)
SWEP.CustomizePos = Vector(6.824, -7, 4.897)
SWEP.CustomizeAng = Angle(12.149, 45.547, 45)
SWEP.InBipodPos = Vector(-8, 0, -4)
SWEP.InBipodMult = Vector(2, 1, 1)

SWEP.SightPlusOffset = true

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
                    pos = Vector(15, 0.5, -8),
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
		Bone = "weapon",
		Offset = {
            vpos = Vector(0.02, -2.4, 2),
            vang = Angle(90, 0, -90),
            wpos = Vector(6, 1, -7),
            wang = Angle(-10, 2, 180)
        },
	},
    {
        PrintName = "Tactical",
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol"},
		Bone = "weapon",
        Offset = {
            vpos = Vector(0.8, -0.8, 4),
            vang = Angle(90, 0, -0),
            wpos = Vector(7, 2, -5.5),
            wang = Angle(-10, 5, -90)
        },
    },
    {
        PrintName = "Charms", 
        DefaultAttName = "None",
        Slot = {"charm"},
		Bone = "weapon",
        Offset = {
            vpos = Vector(1, -1, -3.2),
            vang = Angle(90, 0, -90),
            wpos = Vector(1.2, 2.2, -4.5),
            wang = Angle(0, 0, 180)
        },
    },
    {
        PrintName = "Foregrip",
        DefaultAttName = "No Attachment", 
        Slot = "foregrip",
        Bone = "weapon",
        Offset = {
            vpos = Vector(0, 2.2, 2.5),
            vang = Angle(90, 0, -90),
            wpos = Vector(9, .5, -1.5),
            wang = Angle(0, 0, 180)            
        },
        NoWM = true,
        NoVM = true,    
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
        PrintName = "Muzzle",
        DefaultAttName = "None",
        Slot = {"muzzle", "dlt19_muzzle", "dc15a_muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
		Bone = "weapon",
        Offset = {
            vpos = Vector(0, -0.9, 8.1),
            vang = Angle(90, 0, 0),
            wpos = Vector(16, .5, -7.2),
            wang = Angle(-10, 0, -90)
        },
    },                              
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
    },
	["fire"] = {
        Source = "fire",
    },
	["idle_sights"] = {
        Source = "idle",
        Mult = 10000,
    },
	["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
		SoundTable = {
	        {s = "armas/misc/westar_reload.mp3", t = 0.1 }
        },
    },
    ["draw"] = {
        Source = "draw",
        Mult = 1.5,
        SoundTable = {
            {
                s = "w/dc15s/overheat_manualcooling_resetfoley_generic_var_02.mp3", -- sound; can be string or table
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
                s = "everfall/weapons/handling/023d-00000d8c.mp3", -- sound; can be string or table
                p = 100, -- pitch
                v = 75, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
