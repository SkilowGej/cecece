--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


ENT.Base = "lvs_base_repulsorlift"

ENT.PrintName = "LAAT/g"
ENT.Author = "Luna & Tic"
ENT.Information = "Heavy Close Air Support Gunship of the Galactic Republic"
ENT.Category = "[LVS] - Star Wars"

ENT.VehicleCategory = "Star Wars"
ENT.VehicleSubCategory = "Gunships"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/blu/laatg.mdl"
ENT.GibModels = {
	"models/gibs/helicopter_brokenpiece_01.mdl",
	"models/gibs/helicopter_brokenpiece_02.mdl",
	"models/gibs/helicopter_brokenpiece_03.mdl",
	"models/combine_apc_destroyed_gib02.mdl",
	"models/combine_apc_destroyed_gib04.mdl",
	"models/combine_apc_destroyed_gib05.mdl",
	"models/props_c17/trappropeller_engine.mdl",
	"models/gibs/airboat_broken_engine.mdl",
}

ENT.AITEAM = 2

ENT.VehicleIdentifierRange = 50000

ENT.MaxVelocity = 275
ENT.MaxThrust = 275

ENT.MaxPitch = 60

ENT.ThrustVtol = 200
ENT.ThrustRateVtol = 1

ENT.TurnRatePitch = 0.3
ENT.TurnRateYaw = 0.3
ENT.TurnRateRoll = 0.3

ENT.ForceLinearMultiplier = 1

ENT.ForceAngleMultiplier = 1
ENT.ForceAngleDampingMultiplier = 1

ENT.MaxHealth = 7500

ENT.AutomaticFrameAdvance = true

function ENT:OnSetupDataTables()
	self:AddDT( "Entity", "GunnerSeat" )
	self:AddDT( "Entity", "BTPodL" )
	self:AddDT( "Entity", "SecondGunnerSeat" )
	self:AddDT( "Entity", "ThirdGunnerSeat" )

	self:AddDT( "Bool", "WingTurretFire" )
	self:AddDT( "Vector", "WingTurretTarget" )

	self:AddDT( "Bool", "BTLFire" )
	self:AddDT( "Bool", "BTLFLIR" )

	self:AddDT( "Bool", "Gunner2Fire" )
	self:AddDT( "Bool", "Gunner2FLIR" )

	self:AddDT( "Bool", "Gunner3Fire" )
	self:AddDT( "Bool", "Gunner3FLIR" )

	self:AddDT( "Bool", "LightsActive" )
end

function ENT:InitWeapons()
	self:InitWeaponDriver()
	self:InitWeaponGunner()
	self:InitWeaponBTL()
	self:InitWeaponGunner2()
	self:InitWeaponGunner3()
end

sound.Add( {
	name = "LVS.LAAT.FLYBY",
	sound = {
		"lvs/vehicles/laat/flyby1.wav",
		"lvs/vehicles/laat/flyby2.wav",
		"lvs/vehicles/laat/flyby3.wav",
		"lvs/vehicles/laat/flyby4.wav",
		"lvs/vehicles/laat/flyby5.wav",
	}
} )

ENT.FlyByAdvance = 1
ENT.FlyBySound = "LVS.LAAT.FLYBY" 
ENT.DeathSound = "lvs/vehicles/generic_starfighter/crash.wav"

ENT.EngineSounds = {
	{
		sound = "lvs/vehicles/laat/loop.wav",
		Pitch = 80,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 40,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 3.5,
		UseDoppler = true,
	},
	{
		sound = "^lvs/vehicles/laat/dist.wav",
		Pitch = 80,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 40,
		FadeIn = 0.35,
		FadeOut = 1,
		FadeSpeed = 3.5,
		UseDoppler = true,
		VolumeMin = 0,
		VolumeMax = 1,
		SoundLevel = 110,
	},
}

function ENT:CalcMainActivity( ply )
	local Pod = ply:GetVehicle()

	if Pod == self:GetDriverSeat() or Pod == self:GetGunnerSeat() then return end

	if ply.m_bWasNoclipping then 
		ply.m_bWasNoclipping = nil 
		ply:AnimResetGestureSlot( GESTURE_SLOT_CUSTOM ) 

		if CLIENT then 
			ply:SetIK( true )
		end 
	end 

	if Pod == self:GetBTPodL() then
		ply.CalcIdeal = ACT_STAND
		ply.CalcSeqOverride = ply:LookupSequence( "drive_jeep" )

		return ply.CalcIdeal, ply.CalcSeqOverride
	end

	ply.CalcIdeal = ACT_STAND
	ply.CalcSeqOverride = ply:LookupSequence( "sit" )

	if ply:GetAllowWeaponsInVehicle() and IsValid( ply:GetActiveWeapon() ) then

		local holdtype = ply:GetActiveWeapon():GetHoldType()

		if holdtype == "smg" then 
			holdtype = "smg1"
		end

		local seqid = ply:LookupSequence( "idle_" .. holdtype )

		if seqid ~= -1 then
			ply.CalcSeqOverride = seqid
		end
	end

	return ply.CalcIdeal, ply.CalcSeqOverride
end

function ENT:CalcVtolThrottle( ply, cmd )
	local Delta = FrameTime()

	local ThrottleZero = self:GetThrottle() <= 0

	local VtolX = 0
	local VtolY = 0
	local VtolZ = ((ply:lvsKeyDown( "+VTOL_Z_SF" ) and 1 or 0) - (ply:lvsKeyDown( "-VTOL_Z_SF" ) and 1 or 0))

	local DesiredVtol = Vector(VtolX,VtolY,VtolZ)
	local NewVtolMove = self:GetNWVtolMove() + (DesiredVtol - self:GetNWVtolMove()) * self.ThrustRateVtol * Delta

	if not ThrottleZero or self:WorldToLocal( self:GetPos() + self:GetVelocity() ).x > 100 then
		NewVtolMove.x = 0
	end

	self:SetVtolMove( NewVtolMove )
end

hook.Add("LoadFlareConfiguration", "LAATg", function ()
    UF:RegisterFlareVehicleConfiguration("lvs_repulsorlift_gunship_heavy",
            {
                {
                    pos = Vector(-435, 31, 194),
                    dir = UF.CONST.BACKWARDS,
                },
                {
                    pos = Vector(-435, -31, 194),
                    dir = UF.CONST.BACKWARDS,
                },
                {
                    pos = Vector(-410.12, 51, 184),
                    dir = UF.CONST.LEFT,
                    dirMulti = 1000
                },
                {
                    pos = Vector(-410.12, -51, 184),
                    dir = UF.CONST.RIGHT,
                    dirMulti = 1000
                },
            },
            2, -- Which seat should control the flares. Default 0.
            48, -- The total times the flares can be used. Default 16.
            10 -- The amount of individual flares that should be deployed per burst. Default 5.
    )
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
