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

SWEP.PrintName = "RSKF-44 Heavy Blaster"
SWEP.Trivia_Class = "Heavy Blaster Pistol"
SWEP.Trivia_Desc = "A two-barreled blaster design, firing two blaster bolts per shot."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "High Tibanna Gas"
SWEP.Trivia_Mechanism = "Pistol"

SWEP.ViewModel = "models/weapons/v_rskf_44.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_scoutblaster.mdl"
SWEP.MirrorVMWM = false
SWEP.WorldModelOffset = {
    pos = Vector(-0.7, 2.5, -1.9),
    ang = Angle(0, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.09
}
SWEP.IconOverride = "entities/rskf_eggsteen.png"
SWEP.ViewModelFOV = 70

SWEP.DefaultBodygroups = nil
SWEP.DefaultWMBodygroups = nil

SWEP.NoHideLeftHandInCustomization = false

SWEP.Damage = 33
SWEP.DamageMin = 26 -- damage done at maximum range
SWEP.DamageRand = 0 -- damage will vary randomly each shot by this fraction
SWEP.RangeMin = 245 -- how far bullets will retain their maximum damage for
SWEP.Range = 410 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.DamageTypeHandled = false -- set to true to have the base not do anything with damage types
-- this includes: igniting if type has DMG_BURN; adding DMG_AIRBOAT when hitting helicopter; adding DMG_BULLET to DMG_BUCKSHOT

SWEP.MuzzleVelocity = 400 -- projectile muzzle velocity in m/s

SWEP.AlwaysPhysBullet = false
SWEP.NeverPhysBullet = false
SWEP.Tracer = "tfa_tracer_red"
SWEP.PhysTracerProfile = 3 -- color for phys tracer.

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerFinalMag = 0 -- the last X bullets in a magazine are all tracers
SWEP.HullSize = 2 -- HullSize used by FireBullets

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 8 -- DefaultClip is automatically set.

SWEP.AmmoPerShot = 2

SWEP.ReloadInSights = false
SWEP.ReloadInSights_CloseIn = 0.25
SWEP.ReloadInSights_FOVMult = 0.875
SWEP.LockSightsInReload = false

SWEP.Recoil = 1.7
SWEP.RecoilSide = 0.15
SWEP.RecoilRise = 2
SWEP.VisualRecoilMult = 2
SWEP.RecoilPunch = 1.4
SWEP.RecoilPunchBackMax = 0.9

SWEP.RecoilDirection = Angle(1.1, 0, 0)
SWEP.RecoilDirectionSide = Angle(0, 1.1, 0)

SWEP.Delay = 60 / 100 -- 60 / RPM.
SWEP.Num = 2 -- number of shots per trigger pull.
SWEP.Firemode = 2 -- 0: safe, 1: semi, 2: auto, negative: burst
SWEP.Firemodes = {
    {
		Mode = 1,
    },
	{
		Mode = 0,
   	}
}

SWEP.NotForNPCS = true
SWEP.NPCWeaponType = nil -- string or table, the NPC weapons for this gun to replace

SWEP.AccuracyMOA = 10 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 330 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 65 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 45 -- dispersion that remains even in sights
SWEP.JumpDispersion = 200 -- dispersion penalty when in the air

SWEP.ShootWhileSprint = false

SWEP.Primary.Ammo = "357" -- what ammo type the gun uses
SWEP.MagID = "mpk1" -- the magazine pool this gun draws from

SWEP.ShootVol = 125 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootPitchVariation = 0.05

SWEP.ShootSound = Sound("RKSF.Fire")

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_red"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false -- Use Gmod muzzle effects rather than particle effects
SWEP.MuzzleFlashColor = Color(238, 19, 19)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.ProceduralViewBobAttachment = 1 -- attachment on which coolview is affected by, default is muzzleeffect

SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.75
SWEP.ShootSpeedMult = 1

SWEP.IronSightStruct = {
    Pos = Vector(-1.87, 7, -2.5),
    Ang = Angle(0, 0, 0),
    Midpoint = { -- Where the gun should be at the middle of it's irons
        Pos = Vector(0, 0, 0),
        Ang = Angle(0, 0, 0),
    },
    Magnification = 1,
    SwitchToSound = "zoom_in/gunfoley_zoomin_blasterpistol_04.mp3",
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

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.CanBash = true
SWEP.MeleeDamage = 25
SWEP.MeleeRange = 16
SWEP.MeleeDamageType = DMG_CLUB
SWEP.MeleeTime = 0.5
SWEP.MeleeGesture = nil
SWEP.MeleeAttackTime = 0.2

SWEP.SprintPos = Vector(2, 2, -14)
SWEP.SprintAng = Angle(45, 0, -10)

SWEP.BashPreparePos = Vector(2.187, -4.117, -7.14)
SWEP.BashPrepareAng = Angle(32.182, -3.652, -19.039)

SWEP.BashPos = Vector(8.876, 0, 0)
SWEP.BashAng = Angle(-16.524, 70, -11.046)

SWEP.ActivePos = Vector(0, 6, -3)
SWEP.ActiveAng = Angle(1.45, 0.6, 0)

SWEP.HolsterPos = Vector(6, 0, 0)
SWEP.HolsterAng = Angle(-15.633, 0.881, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetCrouch = nil
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.CustomizePos = Vector(15.824, -3, -1.897)
SWEP.CustomizeAng = Angle(12.149, 50.547, 45)

SWEP.InBipodPos = Vector(-8, 0, -4)
SWEP.InBipodMult = Vector(2, 1, 1)

SWEP.BarrelLength = 24

SWEP.SightPlusOffset = true

SWEP.DefaultElements = {"nil"}
SWEP.AttachmentElements = {
    ["nil"] = {
         VMElements = {},
        WMElements = {
            {
                Model = "models/weapons/v_rskf_44.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(-10, 40, -15),
                    ang = Angle(-0, 0, 180)
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0.0, 0., 0.),
                Offset = {
                    pos = Vector(180, 15, -25),
                    ang = Angle(-0, 0, 180)
                },
                IsMuzzleDevice = true
            },            
        }, -- change the world model to something else. Please make sure it's compatible with the last one.
    }
}

WMOverride = "models/weapons/v_rskf_44.mdl"

SWEP.Attachments = {
	[1] = {
		PrintName = "Optic", -- print name
		DefaultAttName = "Iron Sights", -- used to display the "no attachment" text
		Slot = {"", ""},
        DefaultEles = {"ironsight"},
		Bone = "", -- relevant bone any attachments will be mostly referring to
		Offset = {
            vpos = Vector(-0.75, 0.35, -4.),
            vang = Angle(89, 1, -90),
            wpos = Vector(6, 1.5, -4.8),
            wang = Angle(-10, 2, 180)
        },
        NoWM = false
	},
    [2] = {
        PrintName = "Tactical", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = {"tactical", "tac_pistol"},
        WMScale = Vector(11, 11, 11),
        Bone = "optic", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(-1.3, 3.1, -4.3),
            vang = Angle(90, 00, -90),
            wpos = Vector(120, 19, -10.8),
            wang = Angle(-0, 2, 180)
        },
        NoWM = false
    },
    [3] = {
        PrintName = "Charms", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = {"charm"},
        NoWM = true,
        Bone = "optic", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(-0.7, 2.45, -9),
            vang = Angle(90, 0, -90),
            wpos = Vector(3.5, 1.8, -2.5),
            wang = Angle(0, 0, 180)
        },
    },
    [4] = {
        PrintName = "Foregrip", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = "foregrip",
        Bone = "optic", -- relevant bone any attachments wwill be mostly referring to /
        Offset = {
            vpos = Vector(-1.05, 3, -4.9),
            vang = Angle(90, 0, -90),         
        },
        NoWM = true,        -- Set this to false if you want the foregrips to display on ViewModels.          
    },
    [5] = {
        PrintName = "Ammo", -- print name
        DefaultAttName = "Standard Ammo", -- used to display the "no attachment" text
        Slot = {"ammo"},
    },
    [6] = {
        PrintName = "Muzzle", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = {""},
        Bone = "optic", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(-0.4, 0, 7.6),
            vang = Angle(90, 0, -90),
            wpos = Vector(14.4, 1.6, -5.8),
            wang = Angle(-12, 0, 180) 
        },
    }, 
    [7] = {
        PrintName = "Training/Perk", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = "perk",
    },                             
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
    },
    ["fire"] = {
        Source = {"fire"},
    },
	["reload"] = {
        Source = "reload",
        LHIK = true,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
    },
	["draw"] = {
        Source = "deploy",
    },
	["holster"] = {
        Source = "holster",
        SoundTable = {
            {
                s = "w/dt12/gunfoley_pistol_sheathe_var_01.mp3", -- sound; can be string or table
                p = 100, -- pitch
                v = 75, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
}

sound.Add({
	name = "RKSF.Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
	sound = { "rskf/rksf_fire.wav" }
})

sound.Add({
	name = "RKSF.Shuffle1",
    channel = CHAN_ITEM,
    volume = 1.0,
	sound = { "rskf/cloth_startreload01.wav" }
})

sound.Add({
	name = "RKSF.Shuffle2",
    channel = CHAN_ITEM,
    volume = 1.0,
	sound = { "rskf/cloth_magtransition01.wav" }
})

sound.Add({
	name = "RKSF.Shuffle3",
    channel = CHAN_ITEM,
    volume = 1,
	sound = { "rskf/cloth_returntoidle01.wav" }
})

sound.Add({
	name = "RKSF.Open",
    channel = CHAN_ITEM,
    volume = 1.0,
	sound = { "rskf/revolver_open_chamber.wav" }
})

sound.Add({
	name = "RKSF.Close",
    channel = CHAN_ITEM,
    volume = 1.0,
	sound = { "rskf/revolver_close_chamber.wav" }
})

sound.Add({
	name = "RKSF.Dump",
    channel = CHAN_ITEM,
    volume = 1.0,
	sound = { "rskf/revolver_dump_rounds.wav" }
})

sound.Add({
	name = "RKSF.Load",
    channel = CHAN_ITEM,
    volume = 1.0,
	sound = { "rskf/revolver_speed_loader_insert.wav" }
})


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
