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
SWEP.PrintName = "Dual DC-17s"
SWEP.Trivia_Class = "Podwójne ciężkie pistolety blasterowe"
SWEP.Trivia_Desc = "Ręczny blaster DC-17s, znany również jako pistolet blasterowy DC-17s, był ciężkim pistoletem blasterowym, którym uzbrojeni byli żołnierze-klony Wielkiej Armii Galaktycznej Republiki podczas Wojen Klonów. Była to ulepszona broń palna, która trafiła do uzbrojenia elitarnych żołnierzy armii, przede wszystkim dowódców oddziałów zwiadowczych, dowódców oddziałów klonów i oddziałów klonów odrzutowych. Ta wersja jest potężna. Bardzo potężna."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Gaz Tibanna"
SWEP.Trivia_Year = 2024
SWEP.IconOverride = "entities/masita/dual_dc17s_red.png"

SWEP.Slot = 1

SWEP.UseHands = true
SWEP.ViewModel = "models/arccw/kraken/republic/v_akimbo_dc17s.mdl"
SWEP.WorldModel = "models/rising/base/c_akimbo.mdl"
SWEP.ViewModelFOV = 65

SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.09
}

SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 1.5,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.DefaultBodygroups = "000000000000"
SWEP.NoHideLeftHandInCustomization = true

SWEP.Damage = 45
SWEP.RangeMin = 100
SWEP.DamageMin = 17
SWEP.Range = 370
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400


SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1

SWEP.TracerNum = 1
SWEP.Tracer = "clone_tracer"
SWEP.TracerCol = Color(0, 0, 255)
SWEP.HullSize = 0

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 40

SWEP.Recoil = 0.78
SWEP.RecoilPunch = 0.6
SWEP.RecoilSide = 0.25
SWEP.RecoilRise = 0.31

SWEP.Delay = 60 / 348
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

SWEP.AccuracyMOA = 0.56 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 460 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 50

SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 100
SWEP.ShootPitch = 100
SWEP.ShootSound = "armas/disparos/dc17s.wav"
SWEP.ShootSoundSilenced = "armas/disparos/dc19.wav"
SWEP.MuzzleFlashColor = Color(0, 0, 255)

SWEP.IronSightStruct = {
    Pos = Vector(0, -4, 1),
    Ang = Angle(0, 0, 0),
     Magnification = 1,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 90,
}
SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "duel"
SWEP.HoldtypeSights = ""

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(0, 0, 2)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Vector(-25, 0, 0)

SWEP.ReloadPos = Vector(0, -10, -2)

SWEP.CustomizePos = Vector(0, 4, 0)
SWEP.CustomizeAng = Angle(0, 0, 0)

SWEP.BarrelLength = 60
SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)
SWEP.DefaultElements = {"dc17"}

SWEP.AttachmentElements = {
    ["dc17"] = {
        WMElements = {
            {
                Model = "models/weapon/ven/ggn/dc17s_single_world.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(30, 15, -10),
                    ang = Angle(180, -180, 2)
                }
            },
            {
                Model = "models/weapon/ven/ggn/dc17s_single_world.mdl",
                Bone = "ValveBiped.Bip01_L_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(-50, 230, -55),
                    ang = Angle(180, -180, 2)
                }
            },
        },            -- change the world model to something else. Please make sure it's compatible with the last one.
    }
}
WMOverride = "models/weapon/ven/ggn/dc17s_single_world.mdl"

--SWEP.Attachments 
SWEP.Attachments = {   
    [1] = {
        PrintName = "Energization", -- print name
        DefaultAttName = "Standard Energization", -- used to display the "no attachment" text
        Slot = "ammo",
    }
}


local path = "kraken/republic/dc17s/"

SWEP.Animations = {
    ["fire"] = {
        Source = {"shoot1_right", "shoot1_left"},
    },
    ["reload"] = {
        Source = "reload",
		MinProgress = 0.95,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PHYSGUN,
        SoundTable = {
		    {s = "kraken/movement1.wav", t = 0/30},
            {s = path .. "usp_clipout.wav", t = 5/30},
            {s = path .. "usp_clipout.wav", t = 8/30},
			{s = "kraken/movement2.wav", t = 19/30},
			{s = path .. "usp_clipin.wav", t = 45/30},
			{s = path .. "usp_clipin.wav", t = 55/30},
			{s = "kraken/movement3.wav", t = 65/30},
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
		MinProgress = 0.95,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PHYSGUN,
        SoundTable = {
		    {s = "kraken/movement1.wav", t = 0/30},
            {s = path .. "usp_clipout.wav", t = 7/30},
            {s = path .. "usp_clipout.wav", t = 8/30},
			{s = "kraken/movement2.wav", t = 19/30},
            {s = path .. "usp_clipin.wav", t = 50/30},
            {s = path .. "usp_clipin.wav", t = 55/30},
			{s = "kraken/movement3.wav", t = 65/30},
            {s = path .. "usp_sliderelease.wav", t = 75/30},
            {s = path .. "usp_sliderelease.wav", t = 77/30},
        },
    },
    ["ready"] = {
        Source = "draw",
        SoundTable = {
            {s = path .. "usp_draw.wav", t = 0/30},
            {s = path .. "usp_sliderelease.wav", t = 11/30},
            {s = path .. "usp_sliderelease.wav", t = 14/30},
        },
    },
    ["draw"] = {
        Source = "draw_short",
    },
    ["holster"] = {
        Source = "holster",
        SoundTable = {
            {s = "CSGO.Item.Movement", t = 0/30},
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
        Time = 1,
    },
    ["enter_sprint"] = {
        Source = "sprint_in",
        Time = 1,
    },
    ["idle_inspect"] = {
        Source = "lookat01",
        SoundTable = {
            {p = 100, s = "weapon_hand/reload_gentle/other/023d-00000adb.mp3", t = 1 / 30 },
            {p = 100, s = "weapon_hand/reload_gentle/other/023d-00000adb.mp3", t = 96 / 30 },
            {p = 100, s = "weapon_hand/reload_gentle/other/023d-00000adb.mp3", t = 170 / 30},
    },
    },
    ["enter_inspect"] = {
        Source = "lookat01",
        SoundTable = {
            {p = 100, s = "weapon_hand/reload_gentle/other/023d-00000adb.mp3", t = 1 / 30 },
            {p = 100, s = "weapon_hand/reload_gentle/other/023d-00000adb.mp3", t = 96 / 30 },
            {p = 100, s = "weapon_hand/reload_gentle/other/023d-00000adb.mp3", t = 170 / 30},
    },
    },
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
