--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()
SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "[ ArcCW ] Star Wars Weapons" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "LRB-11"
SWEP.Trivia_Class = "Laser Recon Blaster"
SWEP.Trivia_Desc = "A light marksman rifle, The LRB or known as the 'Laser Recon Blaster' is a rifle produced by Eggsteen Industries. This blaster contains the mobility and versatility of a standard rifle, but it also has the stopping power of a sniper rifle.."
SWEP.Trivia_Manufacturer = "Eggsteen Industries"
SWEP.Trivia_Calibre = "Medium Density"
SWEP.Trivia_Mechanism = "Energized Compressed Tibanna"
SWEP.Trivia_Country = "GAR"

SWEP.ViewModel = "models/eggsteen/viewmodel/lrb_11_viewmodel.mdl"
SWEP.WorldModel = "models/eggsteen/worldmodel/lrb_11_worldmodelref.mdl"
SWEP.MirrorVMWM = false
SWEP.WorldModelOffset = {
    pos = Vector(-7, 3.4, -7),
    ang = Angle(0, -90, 180),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.09
}
SWEP.IconOverride = "entities/lrb_11_eggsteen.png"
SWEP.ViewModelFOV = 70

SWEP.DefaultBodygroups = "111"
SWEP.DefaultWMBodygroups = "111"
SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.Slot = 3

SWEP.NoHideLeftHandInCustomization = true

SWEP.Damage = 51
SWEP.DamageMin = 24 -- damage done at maximum range
SWEP.DamageRand = 0 -- damage will vary randomly each shot by this fraction
SWEP.RangeMin = 175 -- how far bullets will retain their maximum damage for
SWEP.Range = 475 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.DamageTypeHandled = false -- set to true to have the base not do anything with damage types
-- this includes: igniting if type has DMG_BURN; adding DMG_AIRBOAT when hitting helicopter; adding DMG_BULLET to DMG_BUCKSHOT

SWEP.MuzzleVelocity = 400 -- projectile muzzle velocity in m/s

SWEP.AlwaysPhysBullet = false
SWEP.NeverPhysBullet = false
SWEP.PhysTracerProfile = 3 -- color for phys tracer.

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerFinalMag = 0 -- the last X bullets in a magazine are all tracers
SWEP.Tracer = "tfa_tracer_red" -- override tracer (hitscan) effect
SWEP.TracerCol = Color(255, 0, 0)
SWEP.HullSize = 2 -- HullSize used by FireBullets

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 15 -- DefaultClip is automatically set.

SWEP.AmmoPerShot = 1

SWEP.ReloadInSights = false
SWEP.ReloadInSights_CloseIn = 0.25
SWEP.ReloadInSights_FOVMult = 0.875
SWEP.LockSightsInReload = false

SWEP.Recoil = 0.5
SWEP.RecoilSide = 0.15
SWEP.RecoilRise = 0.53
SWEP.VisualRecoilMult = 2
SWEP.RecoilPunch = 1.4
SWEP.RecoilPunchBackMax = 0.9

SWEP.RecoilDirection = Angle(1.1, 0, 0)
SWEP.RecoilDirectionSide = Angle(0, 1.1, 0)

SWEP.Delay = 60 / 170 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemode = 2 -- 0: safe, 1: semi, 2: auto, negative: burst
SWEP.Firemodes = {
	{
		Mode = 1,
   	},
    {
		Mode = 2,
    },
	{
		Mode = 0,
   	}
}

SWEP.NotForNPCS = true
SWEP.NPCWeaponType = nil -- string or table, the NPC weapons for this gun to replace

SWEP.AccuracyMOA = 5 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 410 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 65 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 35 -- dispersion that remains even in sights
SWEP.JumpDispersion = 200 -- dispersion penalty when in the air

SWEP.ShootWhileSprint = false

SWEP.Primary.Ammo = "ar2" -- what ammo type the gun uses
SWEP.MagID = "mpk1" -- the magazine pool this gun draws from

SWEP.ShootVol = 125 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = 0.05

SWEP.ShootSound = "lrb11/firing/blasters_se-44_laser_close_var_01.mp3"--"everfall/weapons/f-11d/blasters_f-11d_laser_close_var_05.mp3"
--SWEP.ShootSoundSilenced = "w/e11/e11supp.wav"
SWEP.FiremodeSound = "weapons/arccw/firemode.wav"
SWEP.MeleeSwingSound = "weapons/arccw/melee_lift.wav"
SWEP.MeleeMissSound = "weapons/arccw/melee_miss.wav"
SWEP.MeleeHitSound = "weapons/arccw/melee_hitworld.wav"
SWEP.MeleeHitNPCSound = "weapons/arccw/melee_hitbody.wav"


SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_red"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false -- Use Gmod muzzle effects rather than particle effects

SWEP.MuzzleEffectAttachment = "1" -- which attachment to put the muzzle on
SWEP.ProceduralViewBobAttachment = 1 -- attachment on which coolview is affected by, default is muzzleeffect
SWEP.MuzzleFlashColor = Color(255, 0, 0)

SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.75
SWEP.ShootSpeedMult = 1

SWEP.IronSightStruct = {
    Pos = Vector(-2.47, -0, 2.65),
    Ang = Angle(0, 1, 1),
    Midpoint = { -- Where the gun should be at the middle of it's irons
        Pos = Vector(0, 0, 0),
        Ang = Angle(0, 0, 0),
    },
    Magnification = 1,
    CrosshairInSights = false,
}


SWEP.SightTime = 0.13
SWEP.SprintTime = 0
-- If Malfunction is enabled, the gun has a random chance to be jammed
-- after the gun is jammed, it won't fire unless reload is pressed, which plays the "unjam" animation
-- if no "unjam", "fix", or "cycle" animations exist, the weapon will reload instead
SWEP.Malfunction = false
SWEP.MalfunctionJam = true -- After a malfunction happens, the gun will dryfire until reload is pressed. If unset, instead plays animation right after.
SWEP.MalfunctionTakeRound = true -- When malfunctioning, a bullet is consumed.
SWEP.MalfunctionWait = 0.5 -- The amount of time to wait before playing malfunction animation (or can reload)
SWEP.MalfunctionMean = nil -- The mean number of shots between malfunctions, will be autocalculated if nil
SWEP.MalfunctionVariance = 0.25 -- The fraction of mean for variance. e.g. 0.2 means 20% variance
SWEP.MalfunctionSound = "weapons/arccw/malfunction.wav"

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "smg"
SWEP.HoldtypeSights = "ar2"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.CanBash = true
SWEP.MeleeDamage = 25
SWEP.MeleeRange = 16
SWEP.MeleeDamageType = DMG_CLUB
SWEP.MeleeTime = 0.5
SWEP.MeleeGesture = nil
SWEP.MeleeAttackTime = 0.2

SWEP.SprintPos = Vector(1, -8, -10)
SWEP.SprintAng = Angle(45.524, 0, -11.046)

SWEP.BashPreparePos = Vector(2.187, -4.117, -7.14)
SWEP.BashPrepareAng = Angle(32.182, -3.652, -19.039)

SWEP.BashPos = Vector(8.876, 0, 0)
SWEP.BashAng = Angle(-16.524, 70, -11.046)

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetCrouch = nil
SWEP.BarrelOffsetHip = Vector(0, 0, 100)

SWEP.CustomizePos = Vector(13.824, -7.5, 2.897)
SWEP.CustomizeAng = Angle(12.149, 45.547, 45)

SWEP.InBipodPos = Vector(-8, 0, -4)
SWEP.InBipodMult = Vector(2, 1, 1)

SWEP.BarrelLength = 14

SWEP.SightPlusOffset = true

SWEP.DefaultElements = {"nil"}
SWEP.AttachmentElements = {
    ["nil"] = {
         VMElements = {},
        WMElements = {
            {
                Model = "models/eggsteen/worldmodel/lrb11_worldmodel.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1.3, 1.3, 1.3),
                Offset = {
                    pos = Vector(-120, 48, -65),
                    ang = Angle(-10, -90, 180)
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0.0, 0., 0.),
                Offset = {
                    pos = Vector(450, 15, -115),
                    ang = Angle(-0, 0, 180)
                },
                IsMuzzleDevice = true
            },            
        }, -- change the world model to something else. Please make sure it's compatible with the last one.
    }
}

SWEP.Attachments = {
	[1] = {
		PrintName = "Optic", -- print name
		DefaultAttName = "Iron Sights", -- used to display the "no attachment" text
		Slot = "optic",
        WMScale = Vector(11, 11, 11),
		Bone = "optic", -- relevant bone any attachments will be mostly referring to
		Offset = {
            vpos = Vector(3, 0.1, 0),
            vang = Angle(0.5, 0, -90),
            wpos = Vector(70, 9, -53),
            wang = Angle(-10, 0, 180)
        },
        CorrectiveAng = Angle(-2.4, 0.14, 0),
        NoWM = false
	},
    [2] = {
        PrintName = "Tactical", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        WMScale = Vector(11, 11, 11),
        Slot = {"tactical", "tac_pistol"},
        Bone = "optic", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(22.5, 1.2, 0.3),
            vang = Angle(0, 0, -90),
            wpos = Vector(380, 3, -87),
            wang = Angle(-11, 0, 180)
        },
        NoWM = false
    },
    [3] = {
        PrintName = "Charms", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = {"charm"},
        WMScale = Vector(11, 11, 11),
        Bone = "optic", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(1, 1.9, -0.4),
            vang = Angle(0, 0, -90),
            wpos = Vector(90, 15, -30.5),
            wang = Angle(0, 0, 180)
        },
    },
    [4] = {
        PrintName = "Foregrip", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = {"foregrip"},
        WMScale = Vector(11, 11, 11),
        Bone = "optic", -- relevant bone any attachments wwill be mostly referring to /
        Offset = {
            vpos = Vector(6, 1.8, 0.1),
            vang = Angle(0, 0, -90),
            wpos = Vector(130, 6, -36),
            wang = Angle(-11, 0, 180)            
        },     -- Set this to false if you want the foregrips to display on ViewModels.          
    },
    [5] = {
        PrintName = "Muzzle", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = {"muzzle"},
        WMScale = Vector(11, 11, 11),
        Bone = "optic", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(27.5, 0.09, 0.2),
            vang = Angle(1, 0, -90),
            wpos = Vector(440.4, 3, -113.4),
            wang = Angle(-11, 0, 180) 
        },
    },                                
    [6] = {
        PrintName = "Energization", -- print name
        DefaultAttName = "Standard Energization", -- used to display the "no attachment" text
        Slot = {"ammo", "sw_imp_ammo"},
    },
    [7] = {
        PrintName = "Training/Perk", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = "perk",
    },
    [8] = {
        PrintName = "Power Setting", -- print name
        DefaultAttName = "Default", -- used to display the "no attachment" text
        Slot = "stealth_setting",
    },
}
    

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
    },
    ["fire"] = {
        Source = {"shoot"},
    },
	["reload"] = {
        Source = "reload",
        LHIK = true,
        LHIKIn = 0.75,
        LHIKOut = 1.25,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
		SoundTable = {
			{
				s = "lrb11/reload/overheat_manualcooling_var_01.mp3", -- "everfall/weapons/miscellaneous/charge/blasters_deathray_charge_start_var_04.mp3"sound; can be string or table
				p = 100, -- pitch
				v = 100, -- volume
				t = 2 / 40, -- time at which to play relative to Animations.Time
				c = CHAN_ITEM, -- channel to play the sound
			},
            {
				s = "lrb11/reload/overheat_manualcooling_resetfoley_generic_var_03.mp3", -- sound; can be string or table
				p = 100, -- pitch
				v = 100, -- volume
				t = 54 / 40, -- time at which to play relative to Animations.Time
				c = CHAN_ITEM, -- channel to play the sound
			},
		}
    },
	["draw"] = {
        Source = "draw",
        Mult = 1.5,
        SoundTable = {
            {
                s = "lrb11/draw/overheat_manualcooling_resetfoley_generic_var_01.mp3", -- sound; can be string or table
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
                s = "lrb11/holster/gunfoley_blaster_sheathe_var_04.mp3", -- sound; can be string or table
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
