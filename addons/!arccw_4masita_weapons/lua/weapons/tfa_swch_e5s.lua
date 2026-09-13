--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = 'NPC E-5 Sniper'
	SWEP.Author = 'Syntax_Error752'
	SWEP.ViewModelFOV = 50
	SWEP.Slot = 1
	SWEP.SlotPos = 3
end

-- list.Add('NPCUsableWeapons', {
-- 	class = 'weapon_e5',
-- 	title = 'E-5 Blaster Sniper'
-- })

function SWEP:OnDrop()
	self:Remove()
end

sound.Add({
	name = 'blaster.e5s_fire',
	channel = CHAN_WEAPON,
	volume = 0.5,
	level = 100,
	pitch = {100, 105},
	sound = 'lrb11/firing/blasters_se-44_laser_close_var_01.mp3'
})

SWEP.HoldType = 'ar2'
SWEP.Base = 'swsft_base'
SWEP.Category = 'Star Wars'
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.ViewModel = 'models/arccw/weapons/synbf3/c_e11.mdl'
SWEP.WorldModel = 'models/weapons/synbf3/w_dlt19.mdl'
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
local FireSound = Sound'blaster.e5s_fire'
local ReloadSound = Sound'weapons/E5_reload.wav'
SWEP.Primary.Recoil = 0.001
SWEP.Primary.Damage = 500
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.01
SWEP.Primary.ClipSize = 150
SWEP.Primary.Delay = 1
SWEP.Primary.DefaultClip = 150
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = 'ar2'
SWEP.Primary.Tracer = 'tfa_tracer_red'
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = 'none'
SWEP.IronSightsPos = Vector(-4.8, -4, 0.6)

-- function SWEP:PrimaryAttack()
-- 	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
-- 	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
-- 	local owner = self:GetOwner()
-- 	if not self:CanPrimaryAttack() then return end
-- 	self:EmitSound(FireSound)
-- 	self:CSShootBullet(owner, self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone)
-- 	self:TakePrimaryAmmo(1)

-- 	if not owner:IsNPC() then
-- 		owner:ViewPunch(Angle(math.Rand(-1, 1) * self.Primary.Recoil, math.Rand(-1, 1) * self.Primary.Recoil, 0))
-- 	end
-- end

function SWEP:PrimaryAttack()
    local owner = self:GetOwner()
    
    if not self:CanPrimaryAttack() then return end

    local curTime = CurTime()
    self:SetNextSecondaryFire(curTime + self.Primary.Delay)
    self:SetNextPrimaryFire(curTime + self.Primary.Delay)

    self:EmitSound(FireSound)
    self:CSShootBullet(owner, self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone)
    self:TakePrimaryAmmo(1)

    if not owner:IsNPC() then
        local recoilAngle = Angle(math.Rand(-1, 1) * self.Primary.Recoil, math.Rand(-1, 1) * self.Primary.Recoil, 0)
        owner:ViewPunch(recoilAngle)
    end
end

-- function SWEP:CSShootBullet(owner, dmg, recoil, numbul, cone)
-- 	numbul = numbul or 1
-- 	cone = cone or 0.01
-- 	local npc = owner:IsNPC()
-- 	local cone = npc and Vector(cone * 4.4, cone * 4.4, cone * 4.4) or Vector(cone, cone, 0)
-- 	local dir = owner:GetAimVector()

-- 	if npc then
-- 		local target = owner:GetEnemy()

-- 		if IsValid(target) then
-- 			local index = target:LookupBone(math.random() < .1 and 'ValveBiped.Bip01_Head1' or 'ValveBiped.Bip01_Spine') or 0
-- 			local pos = target:GetBonePosition(index > 0 and index or 0)
-- 			dir = ((pos or target:GetPos()) - owner:GetShootPos()):Angle():Forward()
-- 		end
-- 	end

-- 	self:FireBullets({
-- 		Attacker = owner,
-- 		Num = numbul,
-- 		Src = owner:GetShootPos(),
-- 		Dir = dir,
-- 		Spread = cone,
-- 		Tracer = 1,
-- 		TracerName = self.Primary.Tracer,
-- 		Force = 0.01,
-- 		Damage = dmg
-- 	})

-- 	owner:MuzzleFlash()
-- 	owner:SetAnimation(PLAYER_ATTACK1)
-- 	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
-- end

function SWEP:CSShootBullet(owner, dmg, recoil, numbul, cone)
	numbul = numbul or 1
	cone = cone or 0.01
	local npc = owner:IsNPC()
	local aimCone = (npc and Vector(cone * 4.4, cone * 4.4, cone * 4.4)) or Vector(cone, cone, 0)
	local dir = owner:GetAimVector()

	if npc then
		local target = owner:GetEnemy()
		if IsValid(target) then
			local boneName = math.random() < 0.1 and 'ValveBiped.Bip01_Head1' or 'ValveBiped.Bip01_Spine'
			local index = target:LookupBone(boneName) or 0
			local pos = target:GetBonePosition(index) or target:GetPos()
			dir = (pos - owner:GetShootPos()):GetNormalized() -- использование GetNormalized для получения нормализованного вектора
		end
	end

	self:FireBullets({
		Attacker = owner,
		Num = numbul,
		Src = owner:GetShootPos(),
		Dir = dir,
		Spread = aimCone,
		Tracer = 1,
		TracerName = self.Primary.Tracer,
		Force = 0.01,
		Damage = dmg
	})

	-- Убираем дублирование вызовов
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
