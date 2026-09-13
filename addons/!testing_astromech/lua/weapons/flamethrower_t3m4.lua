--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


if ( CLIENT ) then

	SWEP.PrintName			= "Miotacz ognia Astromecha"	
	SWEP.Slot			= 1
	SWEP.SlotPos			= 1
	SWEP.Author			= "T3M4"

end


SWEP.Category		= "SUP • Różne"
SWEP.Purpose		= "Set stuff on fire"
SWEP.Instructions	= "Left-Click: Fire\nReload: Regenerate Ammunition"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true

SWEP.ViewModel			= "models/weapons/c_smg1.mdl"
SWEP.WorldModel			= "models/droid_arm/t3m4/t3m4_droid_arm.mdl"

SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.HoldType			= "smg"

SWEP.FiresUnderwater            = false

SWEP.Primary.Automatic		= true
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip		= -1
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= 75
SWEP.Secondary.DefaultClip		= -1
SWEP.Secondary.Automatic		= true
SWEP.Secondary.Ammo		= "ar2"

SWEP.ReloadDelay = 0


function SWEP:PrimaryAttack()

if (SERVER) then
if (self.Owner:GetAmmoCount("ar2") < 1) || (self.ReloadDelay == 1) then
self:RunoutReload()
return end
end

if (self.Owner:GetAmmoCount("ar2") > 0) && (self.ReloadDelay == 0) then

self.Owner:RemoveAmmo( 1, self.Weapon:GetSecondaryAmmoType() )

self.Owner:MuzzleFlash()

self.Weapon:SetNextPrimaryFire( CurTime() + 0.08 )

if (SERVER) then

	local trace = self.Owner:GetEyeTrace()
	local Distance = self.Owner:GetPos():Distance(trace.HitPos)

	if Distance < 300 then


	//This is how we ignite stuff
	local Ignite = function()

	//Safeguard
	if !self:IsValid() then return end

	//Damage things in radius of impact
	local flame = ents.Create("point_hurt")
	flame:SetPos(trace.HitPos)
	flame:SetOwner(self.Owner)
	flame:SetKeyValue("DamageRadius",128)
	flame:SetKeyValue("Damage",4)
	flame:SetKeyValue("DamageDelay",0.32)
	flame:SetKeyValue("DamageType",8)
	flame:Spawn()
	flame:Fire("TurnOn","",0) 
	flame:Fire("kill","",0.72)

	if trace.HitWorld then
	local nearbystuff = ents.FindInSphere(trace.HitPos, 100)

	for _, stuff in pairs(nearbystuff) do

	if stuff != self.Owner then

	if stuff:GetPhysicsObject():IsValid() && !stuff:IsNPC() && !stuff:IsPlayer() then
	if !stuff:IsOnFire() then stuff:Ignite(math.random(1,2), 100) end end

	if stuff:IsPlayer() then
	if stuff:GetPhysicsObject():IsValid() then
	stuff:Ignite(1, 100) end end

	if stuff:IsNPC() then
	if stuff:GetPhysicsObject():IsValid() then
	local npc = stuff:GetClass()
	if npc == "npc_antlionguard" || npc == "npc_hunter" || npc == "npc_kleiner"
	|| npc == "npc_gman" || npc == "npc_eli" || npc == "npc_alyx"
	|| npc == "npc_mossman" || npc == "npc_breen" || npc == "npc_monk"
	|| npc == "npc_vortigaunt" || npc == "npc_citizen" || npc == "npc_rebel"
	|| npc == "npc_barney" || npc == "npc_magnusson" then
	stuff:Fire("Ignite","",1)
	end
	stuff:Ignite(math.random(1,2), 100) end end

	end
	end
	end

	if trace.Entity:IsValid() then

	if trace.Entity:GetPhysicsObject():IsValid() && !trace.Entity:IsNPC() && !trace.Entity:IsPlayer() then
	if !trace.Entity:IsOnFire() then trace.Entity:Ignite(math.random(1,2), 100) end end

	if trace.Entity:IsPlayer() then
	if trace.Entity:GetPhysicsObject():IsValid() then
	trace.Entity:Ignite(math.random(1,2), 100) end end

	if trace.Entity:IsNPC() then
	if trace.Entity:GetPhysicsObject():IsValid() then
	local npc = trace.Entity:GetClass()
	if npc == "npc_antlionguard" || npc == "npc_hunter" || npc == "npc_kleiner"
	|| npc == "npc_gman" || npc == "npc_eli" || npc == "npc_alyx"
	|| npc == "npc_mossman" || npc == "npc_breen" || npc == "npc_monk"
	|| npc == "npc_vortigaunt" || npc == "npc_citizen" || npc == "npc_rebel"
	|| npc == "npc_barney" || npc == "npc_magnusson" then
	trace.Entity:Fire("Ignite","",1)
	end
	trace.Entity:Ignite(math.random(1,2), 100) end end

	end

	if (SERVER) then
	local firefx = EffectData()
	firefx:SetOrigin(trace.HitPos)
	util.Effect("weapon_zi_flamethrower_flame",firefx,true,true)
	end

	end


	//Ignite stuff; based on how long it takes for flame to reach it
	timer.Simple(Distance/1520, Ignite)

	end

end
end
end



function SWEP:SecondaryAttack()
end



function SWEP:Deploy()
self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
if (SERVER) then
self.Owner:EmitSound( "ambient/machines/keyboard2_clicks.wav", 42, 100 )
end
return true
end



function SWEP:Think()

if self.Owner:KeyReleased(IN_ATTACK) && (self.Owner:GetAmmoCount("ar2") > 1) && (self.ReloadDelay != 1) then
if (SERVER) then
self.Owner:EmitSound( "ambient/fire/mtov_flame2.wav", 24, 100 )
end
end

if (self.Owner:GetAmmoCount("ar2") > 0) && (self.ReloadDelay == 0) then

if self.Owner:KeyPressed(IN_ATTACK) then
if (SERVER) then
self.Owner:EmitSound( "ambient/machines/thumper_dust.wav", 46, 100 )
end
end

if self.Owner:KeyDown(IN_ATTACK) then
if (SERVER) then
self.Owner:EmitSound( "ambient/fire/mtov_flame2.wav", math.random(27,35), math.random(32,152) )
end
local trace = self.Owner:GetEyeTrace()
if (SERVER) then
local flamefx = EffectData()
flamefx:SetOrigin(trace.HitPos)
flamefx:SetStart(self.Owner:GetShootPos())
flamefx:SetAttachment(1)
flamefx:SetEntity(self.Weapon)
util.Effect("weapon_zi_flamethrower_flame",flamefx,true,true)
end
end

end
end



function SWEP:Reload()

if (self.Owner:GetAmmoCount("ar2") > 74) || (self.ReloadDelay == 1) then return end

self.ReloadDelay = 1

if (SERVER) then
self.Owner:EmitSound( "vehicles/tank_readyfire1.wav", 30, 100 )
end

timer.Simple(1.82, function() if self:IsValid() then self:ReloadSelf() end end)

end



function SWEP:RunoutReload()

if (self.Owner:GetAmmoCount("ar2") > 74) || (self.ReloadDelay == 1) then return end

self.ReloadDelay = 1

if (SERVER) then
self.Owner:EmitSound( "ambient/machines/thumper_dust.wav", 48, 100 )
self.Owner:EmitSound( "vehicles/tank_readyfire1.wav", 30, 100 )
end

timer.Simple(1.82, function() if self:IsValid() then self:ReloadSelf() end end)

end



function SWEP:ReloadSelf()

//Safeguards
if !self then return end
if !self:IsValid() then return end

if (SERVER) then
local ammo = math.Clamp( (75 - self.Owner:GetAmmoCount("ar2")), 0, 75)
self.Owner:GiveAmmo(ammo, "ar2")
end
self.ReloadDelay = 0
if self.Owner:KeyDown(IN_ATTACK) then
if (SERVER) then
self.Owner:EmitSound( "ambient/machines/thumper_dust.wav", 46, 100 )
end
end

end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
