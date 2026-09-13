--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


AddCSLuaFile()

SWEP.ViewModel = Model('models/milrp/weapons/antitank/v_mine.mdl')
SWEP.UseHands = true
SWEP.WorldModel = Model("models/milrp/weapons/antitank/w_mine.mdl")

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.PrintName	= "Squad Shield Activator"
SWEP.Category	= "Star Wars Utility"

SWEP.Slot		= 4
SWEP.SlotPos	= 1

SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.Spawnable		= true
SWEP.AdminOnly		= false

if SERVER then
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

function SWEP:Initialize()
	self:SetHoldType('normal')
	if CLIENT then return end
end



function SWEP:Reload() end

function SWEP:PrimaryAttack()
	if CLIENT then return end
	if IsValid(self.Owner:GetNWEntity('CSquadShield')) then return end
	if self.Owner:GetNWInt('CSqShCooldown') ~= 0 and CurTime() < self.Owner:GetNWInt('CSqShCooldown') then return end
	local tr = util.TraceHull({
		start=self.Owner:GetShootPos(),
		endpos=self.Owner:GetShootPos()-Vector(0,0,1024),
		filter=self.Owner,
		mins=self.Owner:OBBMins(),
		maxs=self.Owner:OBBMaxs(),
		mask=MASK_PLAYERSOLID
	})
	if !self.Owner:IsOnGround() or !tr.HitWorld then return end
	local shield = ents.Create('squad_shield')
	shield:SetPos(self.Owner:GetPos())
	shield:Initialize(self.Owner)
end

function SWEP:SecondaryAttack() end

function SWEP:Deploy() return true end

function SWEP:ShouldDropOnDie() return false end

function SWEP:OnRemove() end

function SWEP:OnDrop() end


if SERVER then return end

--function SWEP:DrawHUD() end
--function SWEP:PrintWeaponInfo( x, y, alpha ) end

--function SWEP:HUDShouldDraw( name )
	--if ( name == "CHudWeaponSelection" ) then return true end
	--if ( name == "CHudChat" ) then return true end
	--return false
--end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
