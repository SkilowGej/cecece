--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

SWEP.PrintName = "Zapalnik bomby"
SWEP.Author =	"Joe"

SWEP.Spawnable =	true
SWEP.Adminspawnable =	false
SWEP.Category = "SUP • Wyposażenie"
SWEP.ShowWorldModel = false


SWEP.HoldType = "slam"
SWEP.ViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/thejoe/v_detonator.mdl"
SWEP.WorldModel = "models/thejoe/w_detonator.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.DrawCrosshair = false

SWEP.Primary.Clipsize =	-1
SWEP.Primary.DefaultClip =	-1
SWEP.Primary.Automatic =	false
SWEP.Primary.Ammo =	"none"

SWEP.Secondary.Clipsize =	-1
SWEP.Secondary.DefaultClip =	-1
SWEP.Secondary.Automatic =	false
SWEP.Secondary.Ammo =	"none"
SWEP.UseHands = true

SWEP.animinprogress = false

SWEP.state = true

function SWEP:PrimaryAttack()
	if not SERVER then return end
	local vm = self.Owner:GetViewModel()
	if vm:GetSequence() != self:LookupSequence("idle_open") then return end
	self:RunAnim("press", function()
		if not IsValid(self.bomb) then if IsValid(self) then self:Remove() end return end
		if self.bomb.defused then  if IsValid(self) then self:Remove() end return end
		if not self.bomb.activated then return end
		self.bomb:Explode()
		if not IsValid(self) then return end
		self:Remove()
		if self.Owner:GetActiveWeapon() != self then return end
		local wep = self.Owner:GetWeapons()[1] 
		if not IsValid(wep) then return end
		self.Owner:SetActiveWeapon(wep)
	end)
end

function SWEP:SecondaryAttack()
	if not SERVER then return end
	if self.animinprogress then return end
	if not IsValid(self.bomb) then if IsValid(self) then self:Remove() end return end
	if self.bomb.activated then
		self.bomb:DeactivateBomb()
		self:RunAnim("cap_open_to_closed", function() self:RunAnim("idle_closed") end)
	else
		self.bomb:ActivateBomb()
		self:RunAnim("cap_closed_to_open", function() self:RunAnim("idle_open") end)
	end
	self:SetNextSecondaryFire(CurTime() + 2)
	self.Owner:EmitSound("weapons/slam/mine_mode.wav")
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:Deploy()
	if not SERVER then return end
	if IsValid(self.bomb) and self.bomb.activated == false then
		self:RunAnim("idle_closed")
	else
		self:RunAnim("idle_open")
	end
end

function SWEP:RunAnim(anim,callback)
	if self.animinprogress then return end
	self.animinprogress = true
	local vm = self.Owner:GetViewModel()

	if isstring(anim) then
		anim = vm:LookupSequence( anim ) 
	end
	vm:SendViewModelMatchingSequence( anim )
	timer.Simple(self:SequenceDuration(anim), function()
		if not IsValid(self) then return end
		self.animinprogress = false
		if callback then callback() end
	end)
end

function SWEP:Holster()
	self.animinprogress = false
	return true
end

function SWEP:OnRemove()

end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
