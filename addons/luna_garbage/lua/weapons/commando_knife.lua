--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


AddCSLuaFile()

SWEP.PrintName				= "Ostrze Komando"
SWEP.Slot					= 0
SWEP.SlotPos				= 1

SWEP.Spawnable				= true

SWEP.ViewModel				= Model( "models/weapons/v_commando_knife.mdl" )
SWEP.WorldModel				= ""
SWEP.ViewModelFOV			= 55

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none"

SWEP.DrawAmmo				= false

SWEP.HitDistance			= 48

local SwingSound = Sound( "WeaponFrag.Throw" )
local HitSound = Sound( "Flesh.ImpactHard" )

function SWEP:Initialize()

	self:SetHoldType( "knife" )

end

function SWEP:SetupDataTables()

	self:NetworkVar( "Float", 0, "NextMeleeAttack" )
	self:NetworkVar( "Float", 1, "NextIdle" )

end

function SWEP:GetViewModelPosition( pos, ang )
	return pos + Vector(0,0,3), ang
end

function SWEP:UpdateNextIdle()

	local vm = self.Owner:GetViewModel()
	self:SetNextIdle( CurTime() + vm:SequenceDuration() )

end

function SWEP:PrimaryAttack()

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "attack" ) )

	self:EmitSound( SwingSound )

	self.Owner:FireBullets({
		Attacker= self.Owner,
		Damage= 300,
		Distance= 100,
		Dir= self.Owner:GetAimVector(),
		Src = self.Owner:GetShootPos(),
		Tracer = 0
	})

	self:UpdateNextIdle()
	self:SetNextMeleeAttack( CurTime() + 0.2 )

	self:SetNextPrimaryFire( CurTime() + 0.9 )
	self:SetNextSecondaryFire( CurTime() + 0.9 )

end

function SWEP:SecondaryAttack()

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "swipe" ) )

	self:EmitSound( SwingSound )

	self.Owner:FireBullets({
		Attacker= self.Owner,
		Damage= 300,
		Distance= 50,
		Dir= self.Owner:GetAimVector(),
		Src = self.Owner:GetShootPos(),
		Tracer = 0
	})

	self:UpdateNextIdle()
	self:SetNextMeleeAttack( CurTime() + 0.2 )

	self:SetNextPrimaryFire( CurTime() + 0.9 )
	self:SetNextSecondaryFire( CurTime() + 0.9 )

end

function SWEP:OnDrop()

	self:Remove()

end

function SWEP:Deploy()

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle" ) )

	return true

end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
