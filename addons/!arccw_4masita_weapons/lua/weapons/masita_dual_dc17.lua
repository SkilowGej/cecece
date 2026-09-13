--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true

SWEP.Category = "[ArcCW] Republic Essentials - Masita"
SWEP.Credits = "Kraken (Discord: @elbestiamasita)"
SWEP.PrintName = "Dual DC-17"
SWEP.Trivia_Class = "Podwójne pistolety blasterowe"
SWEP.Trivia_Desc = "Ręczny blaster DC-17s, znany również jako pistolet blasterowy DC-17s, był ciężkim pistoletem blasterowym, którym uzbrojeni byli żołnierze-klony Wielkiej Armii Galaktycznej Republiki podczas Wojen Klonów. Była to ulepszona broń palna, którą wyposażano elitarnych żołnierzy armii, przede wszystkim dowódców oddziałów zwiadowczych, dowódców oddziałów klonów i oddziałów klonów odrzutowych. Ta wersja jest bardzo potężna."
SWEP.Trivia_Manufacturer = "BlastTech Industries"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2024
SWEP.IconOverride = "entities/masita/dual_dc17.png"

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/arccw/kraken/republic/v_akimbo_dc17.mdl"
SWEP.WorldModel = "models/rising/base/c_akimbo.mdl"

SWEP.ViewModelFOV = 65

SWEP.HideViewmodel = false
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.09
}

-- Damage & Tracer
SWEP.BodyDamageMults = {
    [HITGROUP_HEAD] = 1.5,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 0.9,
    [HITGROUP_RIGHTLEG] = 0.9,
}

SWEP.Damage = 40
SWEP.DamageMin = 22
SWEP.RangeMin = 0
SWEP.Range = 250
SWEP.Penetration = 10
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 4000

SWEP.TracerNum = 1
SWEP.TracerCol = Color(0, 0, 250)
SWEP.TracerWidth = 1
SWEP.Tracer = "clone_tracer"
SWEP.HullSize = 0

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 40

SWEP.RecoilSide = 0.3
SWEP.RecoilRise = 0.3
SWEP.Recoil = 0.3

SWEP.Delay = 40 / 260
SWEP.Num = 1
SWEP.Firemode = 1
SWEP.Firemodes = {
    {
		Mode = 1,
    },
    {
        Mode = -3,
        PostBurstDelay = 0.1,
        RunawayBurst = false,
        Mult_RPM = 3,
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

-- Speed Mult
SWEP.SpeedMult = 1.1
SWEP.SightedSpeedMult = 0.77
SWEP.ShootSpeedMult = 1

-- Ammo, Sounds & MuzzleEffect
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 100
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.15

SWEP.ShootSound = "everfall/weapons/scout_trooper_pistol/fire/blasters_scouttrooperpistol_laser_close_var_14.mp3"
SWEP.ShootSound = "everfall/weapons/scout_trooper_pistol/fire/blasters_scouttrooperpistol_laser_close_var_14.mp3"
SWEP.ShootSoundSilenced = "weapons/silenced.wav"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = false
SWEP.FastMuzzleEffect = false
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 250)

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(0, -4, 1),
    Ang = Angle(0, 0, 0),
     Magnification = 1,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 90,
}

-- Holdtype
SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "duel"
SWEP.HoldtypeSights = ""

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.MovingPos = Vector(0, -1.5, -0.8)
SWEP.MovingAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(0, -1.5, -1)
SWEP.CrouchAng = Angle(0, 0, -5)

SWEP.SprintPos = Vector(-1, 0, -1)
SWEP.SprintAng = Angle(0, 0, -5)

SWEP.CustomizePos = Vector(0, 0, 0)
SWEP.CustomizeAng = Angle(0, 0, 0)

--SWEP.Attachments 

--SWEP.Attachments 
SWEP.DefaultElements = {"dc17"}
SWEP.AttachmentElements = {
    ["dc17"] = {
        WMElements = {
            {
                Model = "models/venator/weapons/worldmodels/w_dc-17.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(-45, 15, 10),
                    ang = Angle(180, -180, 2)
                }
            },
            {
                Model = "models/venator/weapons/worldmodels/w_dc-17.mdl",
                Bone = "ValveBiped.Bip01_L_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(-135, 230, -35),
                    ang = Angle(180, -180, 2)
                }
            },
        },   
    }
}
WMOverride = "models/venator/weapons/worldmodels/w_dc-17.mdl"

SWEP.Attachments = {   
    [1] = {
        PrintName = "Energization", -- print name
        DefaultAttName = "Standard Energization", -- used to display the "no attachment" text
        Slot = "ammo",
    }
}


local path = "kraken/republic/dc17/"

SWEP.Animations = {
    ["fire"] = {
        Source = {"fire_right", "fire_left"}
    },
    ["reload"] = {
        Source = "reload_short",
		MinProgress = 0.725,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PHYSGUN,
        SoundTable = {
			{s = path .. "wfoly_pi_mike1911_reload_empty_lift.ogg", t = 0/30},
			{s = path .. "wfoly_pi_mike1911_fast_reload_empty_lift.ogg", t = 4/30},
			{s = path .. "wfoly_pi_mike1911_reload_empty_magout_01.ogg", t = 6/30},
			{s = path .. "wfoly_pi_mike1911_fast_reload_empty_magout_01.ogg", t = 10/30},
			{s = path .. "wfoly_pi_mike1911_reload_empty_magin_v2_01.ogg", t = 49/30},
			{s = path .. "wfoly_pi_mike1911_reload_empty_magin_v2_01.ogg", t = 52/30},
			{s = path .. "wfoly_pi_mike1911_reload_empty_magin_v2_02.ogg", t = 54/30},
			{s = path .. "wfoly_pi_mike1911_fast_reload_magin_01.ogg", t = 54/30},
			{s = path .. "wfoly_pi_mike1911_reload_end.ogg", t = 62/30},
			{s = path .. "wfoly_pi_mike1911_fast_reload_end.ogg", t = 62/30},
        },
    },
    ["reload_empty"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PHYSGUN,
		MinProgress = 0.8,
        SoundTable = {
			{s = path .. "wfoly_pi_mike1911_reload_empty_lift.ogg", t = 0/30},
			{s = path .. "wfoly_pi_mike1911_fast_reload_empty_lift.ogg", t = 5/30},
			{s = path .. "wfoly_pi_mike1911_reload_empty_magout_01.ogg", t = 7/30},
			{s = path .. "wfoly_pi_mike1911_fast_reload_empty_magout_01.ogg", t = 12/30},
			{s = path .. "wfoly_pi_mike1911_reload_empty_magin_v2_01.ogg", t = 52/30},
			{s = path .. "wfoly_pi_mike1911_fast_reload_empty_magin_01.ogg", t = 54/30},
			{s = path .. "wfoly_pi_mike1911_reload_empty_end.ogg", t = 60/30},
			{s = path .. "wfoly_pi_mike1911_reload_empty_end.ogg", t = 61/30},
			{s = path .. "wfoly_pi_mike1911_reload_empty_chamber_01.ogg", t = 73/30},
			{s = path .. "wfoly_pi_mike1911_reload_empty_chamber_01.ogg", t = 76/30},
        },
    },
    ["ready"] = {
        Source = "draw_first",
        SoundTable = {
            {s = path .. "wfoly_pi_mike1911_first_raise_lift.ogg", t = 0/30},
            {s = path .. "wfoly_pi_mike1911_first_raise_slide_pull.ogg", t = 24/30},
			{s = path .. "wfoly_pi_mike1911_first_raise_slide_release.ogg", t = 25/30},
			{s = path .. "wfoly_pi_mike1911_first_raise_chamber_end.ogg", t = 28/30},
        },
    },
    ["draw"] = {
        Source = "draw",
		MinProgress = 0.3,
        FireASAP = true,
        SoundTable = {
            {s = path .. "wfoly_pi_mike1911_raise.ogg", t = 0/30},
        },
    },
    ["holster"] = {
        Source = "holster",
        SoundTable = {
            {s = path .. "wfoly_pi_mike1911_reload_empty_end.ogg", t = 0/30},
            {s = path .. "wfoly_pi_mike1911_fast_reload_end.ogg", t = 5/30},
        },
    },
    ["idle"] = {
        Source = "idle",
    },
    ["idle_sprint"] = {
        Source = "sprint",
    },
    ["exit_sprint"] = {
        Source = "sprint_out",
		Time = 0.25,
    },
    ["enter_sprint"] = {
        Source = "sprint_in",
		Time = 0.25,
    },
    ["enter_inspect"] = {
        Source = "lookat01",
		MinProgress = 0.1,
		FireASAP = true,
        SoundTable = {
            {s = path .. "wfoly_pi_mike1911_inspect_01.ogg", t = 0/30},
			{s = path .. "wfoly_pi_mike1911_inspect_02.ogg", t = 36/30},
			{s = path .. "wfoly_pi_mike1911_inspect_03.ogg", t = 61/30},
			{s = path .. "wfoly_pi_mike1911_inspect_04.ogg", t = 112/30},
        },
    },
    ["bash"] = {
        Source = {"melee","melee2","melee3"},
    },
}


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
