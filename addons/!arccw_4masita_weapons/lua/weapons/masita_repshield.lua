--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

SWEP.Base = "arccw_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.AdminOnly = false

SWEP.Category = "[ArcCW] Republic Essentials - Masita"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "Republic Blast Shield"
SWEP.Trivia_Class = "Shield"
SWEP.Trivia_Desc = "Anti-blaster fire shield for the grand army of the Republic. Stops blaster fire, specially from those damm clankers."
SWEP.Trivia_Manufacturer = "Grand Army of the Republic"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/republic_shield.png"

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_shield.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_shield.mdl"
SWEP.ViewModelFOV = 60

SWEP.WorldModelOffset = {
    pos = Vector(0, 15, -12),
    ang = Angle(0, 0, 180 - 15)
}

SWEP.ShieldProps = {
    {
        Model = "models/weapons/arccw_go/v_shield.mdl",
        Pos = Vector(0, -15, -12),
        Ang = Angle(0, 0, 180 - 15),
        Resistance = 100
    }
}

SWEP.PrimaryBash = true

SWEP.SpeedMult = 0.85

SWEP.MeleeDamage = 35
SWEP.MeleeRange = 32
SWEP.MeleeDamageType = DMG_CLUB
SWEP.MeleeTime = 1
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
SWEP.MeleeAttackTime = 0

SWEP.MeleeSwingSound = {
    "arccw_go/shield/shield_push_01.wav",
}
SWEP.MeleeHitSound = {
    "physics/metal/metal_barrel_impact_hard7.wav",
}
SWEP.MeleeHitNPCSound = {
    "physics/body/body_medium_break3.wav",
}

SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "MELEE"
    },
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "melee2"

SWEP.Primary.ClipSize = -1

SWEP.Animations = {
    ["draw"] = {
        Source = "deploy",
    },
    -- ["idle"] = {
    --     Source = {"idle1", "idle2"}
    -- },
    ["idle"] = {
        Source = "idle",
    },
    ["bash"] = {
        Source = "bash",
        Time = 2,
    },
}

SWEP.IronSightStruct = false

SWEP.ActivePos = Vector(0, 0, 3)

SWEP.BashPreparePos = Vector(0, 0, 0)
SWEP.BashPrepareAng = Angle(0, 5, 0)

SWEP.CustomizePos = Vector(15, 5, 0)
SWEP.CustomizeAng = Angle(0, 60, 0)

SWEP.BashPos = Vector(0, 0, 0)
SWEP.BashAng = Angle(10, -10, 0)

SWEP.HolsterPos = Vector(0, -1, 2)
SWEP.HolsterAng = Angle(-15, 0, 0)

sound.Add({
    name = "ARCCW_GO_SHIELD.ShieldEquipStart",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/shield/shield_equip_04.wav"
})

sound.Add({
    name = "ARCCW_GO_SHIELD.ShieldEquipEnd",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/shield/shield_equip_05.wav"
})

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
