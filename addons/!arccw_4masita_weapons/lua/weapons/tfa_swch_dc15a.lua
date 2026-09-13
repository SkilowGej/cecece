--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = 'DC-15a NPC'
	SWEP.Author = 'Syntax_Error752'
	SWEP.ViewModelFOV = 50
	SWEP.Slot = 1
	SWEP.SlotPos = 3
end

list.Add('NPCUsableWeapons', {
	class = 'tfa_swch_dc15a',
	title = 'DC-15a NPC'
})

function SWEP:OnDrop()
	self:Remove()
end

sound.Add({
	name = 'blaster.dc15_fire',
	channel = CHAN_WEAPON,
	volume = 0.5,
	level = 100,
	pitch = {100, 105},
	sound = 'weapon/venator/dc15a.wav'
})

SWEP.HoldType = 'shotgun'
SWEP.Base = 'swsft_base'
SWEP.Category = 'Star Wars'
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.ViewModel = 'models/everfall/weapons/viewmodels/c_dc15a.mdl'
SWEP.WorldModel = 'models/everfall/weapons/worldmodels/w_dc15a.mdl'
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
local FireSound = Sound'blaster.dc15_fire'
local ReloadSound = Sound'weapons/E5_reload.wav'
SWEP.Primary.Recoil = 0.001
SWEP.Primary.Damage = 60
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.01
SWEP.Primary.ClipSize = 150
SWEP.Primary.Delay = 0.300
SWEP.Primary.DefaultClip = 150
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = 'ar2'
SWEP.Primary.Tracer = 'clone_tracer'
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = 'none'
SWEP.IronSightsPos = Vector(-4.8, -4, 0.6)

function SWEP:PrimaryAttack()
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	local owner = self:GetOwner()
	if not self:CanPrimaryAttack() then return end
	self:EmitSound(FireSound)
	self:CSShootBullet(owner, self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone)
	self:TakePrimaryAmmo(1)

	if not owner:IsNPC() then
		owner:ViewPunch(Angle(math.Rand(-1, 1) * self.Primary.Recoil, math.Rand(-1, 1) * self.Primary.Recoil, 0))
	end
end

function SWEP:CSShootBullet(owner, dmg, recoil, numbul, cone)
	numbul = numbul or 1
	cone = cone or 0.01
	local npc = owner:IsNPC()
	local cone = npc and Vector(cone * 4.4, cone * 4.4, cone * 4.4) or Vector(cone, cone, 0)
	local dir = owner:GetAimVector()

	if npc then
		local target = owner:GetEnemy()

		if IsValid(target) then
			local index = target:LookupBone(math.random() < .1 and 'ValveBiped.Bip01_Head1' or 'ValveBiped.Bip01_Spine') or 0
			local pos = target:GetBonePosition(index > 0 and index or 0)
			dir = ((pos or target:GetPos()) - owner:GetShootPos()):Angle():Forward()
		end
	end

	self:FireBullets({
		Attacker = owner,
		Num = numbul,
		Src = owner:GetShootPos(),
		Dir = dir,
		Spread = cone,
		Tracer = 1,
		TracerName = self.Primary.Tracer,
		Force = 0.01,
		Damage = dmg
	})

	owner:MuzzleFlash()
	owner:SetAnimation(PLAYER_ATTACK1)
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
end

hook.Add("EntityTakeDamage", "DisablePlayerKnockback", function(target, dmginfo)
    -- Check if the target is a player
    if target:IsPlayer() then
        -- Nullify the force vector that applies the knockback
        dmginfo:SetDamageForce(Vector(0, 0, 0))
    end
end)

function SWEP:Reload()
	local owner = self:GetOwner()

	if owner then
		self:DefaultReload(ACT_VM_RELOAD)

		return
	end

	if self:Clip1() < self.Primary.ClipSize then
		if owner:GetAmmoCount(self.Primary.Ammo) > 0 then
			self:EmitSound(ReloadSound)
		end

		self:DefaultReload(ACT_VM_RELOAD)
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
