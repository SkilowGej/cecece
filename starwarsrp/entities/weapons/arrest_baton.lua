AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Pałka policyjna"
	SWEP.Slot = 1
	SWEP.SlotPos = 3
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix = "stunstick"

SWEP.UseHands = true

SWEP.ViewModel = Model("models/weapons/v_stunbaton.mdl")
SWEP.WorldModel = Model("models/weapons/w_stunbaton.mdl")

SWEP.Instructions = "Left click to arrest\nRight click to switch batons"

SWEP.Category = "Piwnica Granie • Różne"
SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Sound = Sound("weapons/stunstick/stunstick_swing1.wav")

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
	self:SetHoldType("melee")
end

function SWEP:PrimaryAttack()
	local eTrace = self.Owner:GetEyeTrace().Entity
	if eTrace and eTrace:IsPlayer() and not eTrace:GetNetVar("Arrested") and self.Owner:GetPos():DistToSqr(eTrace:GetPos()) < 8000 then
		if SERVER then
			netstream.Start(self.Owner, "DrawArestMenu", eTrace)
		end
	end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK);
	self:EmitSound(self.Sound,40)
	self:SetNextPrimaryFire(CurTime() + 1)
end

function SWEP:PreDrawViewModel( vm,pl,wep)
	return true
end
