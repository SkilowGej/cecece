--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--THIS SHIT YOU SHOULD NOT NEED TO MESS WITH
if (SERVER) then
	AddCSLuaFile("shared.lua")
	
	-- resource.AddFile("sound/weapons/weapon_drakamassif/dogbark_1.wav")
	-- resource.AddFile("sound/weapons/weapon_drakamassif/dogbark_2.wav")
	-- resource.AddFile("sound/weapons/weapon_drakamassif/dogbark_3.wav")
	-- resource.AddFile("sound/weapons/weapon_drakamassif/doggrowl_1.wav")
	
	-- resource.AddFile("materials/vgui/weapons/weapon_drakamassif/biteicon.vtf")
	-- resource.AddFile("materials/vgui/weapons/weapon_drakamassif/biteicon.vmt")
	
	-- resource.AddFile("models/weapons/blank.mdl")
	
	SWEP.Weight = 10
end
--END OF SHIT THAT SHOULDN'T BE MESSED WITH

-- if (CLIENT) then
-- 	SWEP.BounceWeaponIcon = false
-- 	SWEP.WepSelectIcon = surface.GetTextureID("vgui/weapons/weapon_drakamassif/biteicon")
-- 	killicon.Add("weapon_drakamassif", "vgui/weapons/weapon_drakamassif/biteicon", Color(255, 80, 0, 255))
-- end

SWEP.Author = "Draka"
--Credit for audio resources: audioblocks.com
SWEP.Contact = ""
SWEP.Purpose = "Taper... Grogner... Grogner.. Taper.."
SWEP.Instructions = "M1: Taper, M2: Grogner"

SWEP.Category = "SUP • Różne"
SWEP.PrintName = "Masyw"
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom	= true

--Configured for DarkRP.
--For Sandbox set these two to "true"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 1
SWEP.SlotPos = 3
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

--How should we hold the ability to bite?
SWEP.HoldType = "fist"

--Should they bite underwater?
SWEP.FiresUnderwater = true

--Since it's a pet's ability to bite, it doesn't need ammo
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1

--Attributes of biting someone
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Force = 20
SWEP.Primary.Damage = 250
SWEP.Primary.Recoil = 5

--Semi-auto biting preferred, unless it's a beaver on cocainum
SWEP.Primary.Automatic = false

--Ammo is capacity to bite... so none.
SWEP.Primary.Ammo = ""

--The sound of biting
SWEP.Primary.Sound = Sound("weapons/weapon_drakamassif/doggrowl_1.wav")

--How beaver-like the bites should be in seconds
SWEP.Primary.Delay = 0.5

--Basically the same for the Secondary functions
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

--How Alley Cat-like the barking should be in seconds
SWEP.Secondary.Delay = 0.5

--Open wide (initialize the biting)
function SWEP:Initialize()	
	util.PrecacheSound("sound/weapons/weapon_drakamassif/dogbark_1.wav")
	util.PrecacheSound("sound/weapons/weapon_drakamassif/dogbark_2.wav")
	util.PrecacheSound("sound/weapons/weapon_drakamassif/dogbark_3.wav")
	util.PrecacheSound("sound/weapons/weapon_drakamassif/doggrowl_1.wav")
	
	if (SERVER) then
		self:SetWeaponHoldType(self.HoldType)
		self.Weapon:SetMoveType( MOVETYPE_WALK )
	end
	
	--The sounds of barking
	DogBarks = {
		Sound( "weapons/weapon_drakamassif/dogbark_1.wav" ),
		Sound( "weapons/weapon_drakamassif/dogbark_2.wav" ),
		Sound( "weapons/weapon_drakamassif/dogbark_3.wav" )
	}
end

function SWEP:Deploy()
	if SERVER then
		self.Owner:DrawViewModel(false)
		self.Owner:DrawWorldModel(false)
	end
end

--The bite of the pet.
function SWEP:PrimaryAttack()
	if (!self:CanPrimaryAttack()) then return end
	
	--the meat of the bite
	if self.Owner:Alive() then
		self.Weapon:EmitSound(self.Primary.Sound)
		self:Bite()
		self.Owner:ViewPunch(Angle(rnda, rndb, rnda))
		self.Weapon:SetNextPrimaryFire(CurTime()+self.Primary.Delay)
		self.Weapon:SetNextSecondaryFire(CurTime()+self.Primary.Delay)
	end
end

function SWEP:CanPrimaryAttack()
	if (self.Weapon.Primary.ClipSize <= 0) then
		return true
	end
end

function SWEP:Bite()
	pos = self.Owner:GetShootPos()
	ang = self.Owner:GetAimVector()
	dmg = self.Primary.Damage
	
	local trace = self.Owner:GetEyeTrace()
	
	if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 100 then
		if(trace.Entity:GetClass() == "prop_physics") then
			self.Weapon:EmitSound(self.Primary.Sound)
			return
		end
		local bite = {}
		bite.Num = self.Primary.NumberofShots
		bite.Src = pos
		bite.Dir = ang
		bite.Spread = Vector(0, 0, 0)
		bite.Tracer = 0
		bite.Force = self.Primary.Force
		bite.Damage = dmg
		local rnda = self.Primary.Recoil*-1
		local rndb = self.Primary.Recoil*math.random(-1,1)
		self.Owner:FireBullets(bite)
	
		if(trace.Entity:IsPlayer() || trace.Entity:IsNPC() || trace.Entity:GetClass() == "prop_ragdoll") then
			self:EmitSound(Sound("Weapon_Crowbar.Melee_Hit"))
			local effectdata = EffectData()
			util.Effect( "BloodImpact", effectdata )
		end
	end
end

--The bark, should be worse than the bite.
function SWEP:SecondaryAttack()
	self:CanSecondaryAttack()

	--the wood of the bark
	if self.Owner:Alive() then
		self:Bark()
		self.Owner:ViewPunch(Angle(rnda, rndb, rnda))
		self.Weapon:SetNextPrimaryFire(CurTime()+self.Secondary.Delay)
		self.Weapon:SetNextSecondaryFire(CurTime()+self.Secondary.Delay)
	end
end

function SWEP:CanSecondaryAttack()
	if (self.Weapon.Secondary.ClipSize <= 0) then
		return true
	end
end

function SWEP:Bark()
	pos = self.Owner:GetShootPos()
	ang = self.Owner:GetAimVector()
	
	self.Weapon:EmitSound(DogBarks[math.random(1,#DogBarks)])
	
	if (SERVER) and IsValid(self.Owner) and IsValid(self.Weapon) then
		local bark = {}
		bark.Num = self.Primary.NumberofShots
		bark.Src = pos
		bark.Dir = ang
		local rnda = self.Primary.Recoil*-1
		local rndb = self.Primary.Recoil*math.random(-1,1)
		self.Weapon:EmitSound(DogBarks[math.random(1,#DogBarks)])
	end
end

--extra necessary unnecessary shit
function SWEP:Reload()
end

function SWEP:Think()
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
