--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if SERVER then
	AddCSLuaFile("shared.lua")
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("animations.lua")
end

SWEP.PrintName 			= "Naprawa pancerza"
SWEP.Category			= "SUP • Wyposażenie"
SWEP.Armor_icon = Material("luna_ui_base/etc/pokecog.png", "noclamp smooth")
SWEP.Author = "MuguFugu"
SWEP.Purpose = ""

SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/c_medkit.mdl"--"models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/weapons/w_hacktool.mdl" --"models/weapons/w_medkit.mdl"

SWEP.Primary.ClipSize = 300
SWEP.Primary.DefaultClip = 300
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.MaxAmmo = 1000
SWEP.ArmorAmount = 40
SWEP.DefaultMaxArmor = 100

function SWEP:Initialize()
	self:SetHoldType("slam")

	if CLIENT then
		self:Anim_Initialize()
	end

	if not SERVER then return end

	self.TimerName = "armorkit_ammo" .. self:EntIndex()
	local wep = self
	timer.Create(self.TimerName,1,0,function()
		if IsValid(wep) then
			if wep:Clip1() < wep.MaxAmmo then
				wep:SetClip1(math.min(wep:Clip1() + 2,wep.MaxAmmo))
			end
		else
			timer.Remove(wep.TimerName)
		end
	end)

end

function SWEP:Deploy()
	--self:SendWeaponAnim(ACT_VM_DRAW)
	self.IdleAnimation = CurTime() + self:SequenceDuration()
	self:SetHoldType("slam")

	return true
end

function SWEP:Think()
	if self.IdleAnimation and self.IdleAnimation <= CurTime() then
		self.IdleAnimation = nil
		self:SendWeaponAnim(ACT_VM_IDLE)
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	return false
end

function SWEP:CanAttack()
	if self:Clip1() <= 0 then
		self:GetOwner():EmitSound("items/suitchargeno1.wav")
		self:SetNextFire(CurTime() + 2)
		return false
	end

	return self:GetNextPrimaryFire() <= CurTime()
end

function SWEP:GetHitTrace()
	local shoot = self:GetOwner():GetShootPos()
	return util.TraceLine({
		start = shoot,
		endpos = shoot + self:GetOwner():GetAimVector() * 64,
		filter = self:GetOwner(),
	})
end

function SWEP:SetNextFire(time)
	self:SetNextPrimaryFire(time)
	self:SetNextSecondaryFire(time)
end

function SWEP:GetEntityMaxArmor(ent)
	return ent:GetNetVar("maxArmor") or self.DefaultMaxArmor
end

function SWEP:PrimaryAttack()
	if not self:CanAttack() then return end

	self:SetNextFire(CurTime() + 2)

	local tr = self:GetHitTrace()
	local ent = tr.Entity

	local need = self.ArmorAmount
	if IsValid(ent) and ent:IsPlayer() then
		local maxArmor = self:GetEntityMaxArmor(ent)
		local currentArmor = ent:Armor()

		need = math.min(maxArmor - currentArmor, self.ArmorAmount)
	end

	if self:Clip1() >= need and tr.Hit and IsValid(ent) and ent:IsPlayer() then
		local maxArmor = self:GetEntityMaxArmor(ent)
		if ent:Armor() < maxArmor then
			self:GetOwner():SetAnimation(PLAYER_ATTACK1)
			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
			self.IdleAnimation = CurTime() + self:SequenceDuration()

			if SERVER then
				self:TakePrimaryAmmo(need)
				self:GetOwner():SetAnimation(PLAYER_ATTACK1)
				ent:SetArmor(math.min(maxArmor, ent:Armor() + need))
				ent:EmitSound("items/battery_pickup.wav")
			end
		elseif SERVER then
			self:GetOwner():EmitSound("items/suitchargeno1.wav")
		end
	elseif SERVER then
		self:GetOwner():EmitSound("items/suitchargeno1.wav")
	end
end

function SWEP:SecondaryAttack()
	if not self:CanAttack() then return end
	self:SetNextFire(CurTime() + 2)

	local maxArmor = self:GetEntityMaxArmor(self:GetOwner())
	local need = math.min(maxArmor - self:GetOwner():Armor(), self.ArmorAmount)
	if self:GetOwner():Armor() < maxArmor and self:Clip1() >= need then
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
		self.IdleAnimation = CurTime() + self:SequenceDuration()

		if SERVER then
			self:TakePrimaryAmmo(need)
			self:GetOwner():SetAnimation(PLAYER_ATTACK1)
			self:GetOwner():SetArmor(math.min(maxArmor, self:GetOwner():Armor() + need))
			self:GetOwner():EmitSound("items/battery_pickup.wav")
		end
	elseif SERVER then
		self:GetOwner():EmitSound("items/suitchargeno1.wav")
	end
end


function SWEP:Holster()
	if CLIENT then
		self:Anim_Holster()
	end
	return true
end


function SWEP:OnRemove()
	if not SERVER then return end
	timer.Remove(self.TimerName)
end


function SWEP:CustomAmmoDisplay()
	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = true
	self.AmmoDisplay.PrimaryClip = self:Clip1()

	return self.AmmoDisplay
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
