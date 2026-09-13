--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

if (CLIENT) then
	SWEP.PrintName = "Small Combine Shield"
	SWEP.Slot = 1
	SWEP.SlotPos = 2
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
    SWEP.Icon = "vgui/ttt/icon_nades" -- most generic icon I guess
end

SWEP.Kind = WEAPON_HEAVY
SWEP.CanBuy = nil
SWEP.AutoSpawnable = true
SWEP.AllowDrop = true
SWEP.IsSilent = false

SWEP.Category = "Riot Shields - Black Tea"
SWEP.Author = "Black Tea"
SWEP.Instructions = "Just hold and Block some shit"
SWEP.Purpose = "Just hold and Block some shit"
SWEP.Drop = false
SWEP.typeShield = "genericShield"

SWEP.HoldType = "shotgun"

SWEP.ViewModelFOV = 47
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "shotgun"

SWEP.ViewTranslation = 4

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Primary.Damage = 7.5
SWEP.Primary.Delay = 0.7

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.ViewModel = Model("models/weapons/c_arms_animations.mdl")
SWEP.WorldModel = Model("models/pg_props/pg_weapons/pg_cp_shield_w.mdl")

SWEP.UseHands = true
SWEP.LowerAngles = Angle(15, -10, -20)

SWEP.FireWhenLowered = true

function SWEP:Precache()
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self:SetDTBool(0, false)

	local wep, realWep
	for k, v in pairs(btShield.shieldList) do
		if (k == self:GetClass()) then
			local info = btShield.shieldInfo[v]
			if (info) then
				self:SetDTInt(0, info.game.health)
			end

			break
		end
	end
end

function SWEP:Deploy()
	local client = self.Owner

	if (IsValid(client)) then
		for k, v in pairs(btShield.shieldList) do
			if (k != self:GetClass()) then
				if (client:HasWeapon(k)) then
					local weapon = client:GetWeapon(k)

					if (IsValid(weapon)) then
						weapon:Remove()
					end
				end
			end
		end
	end
end

function SWEP:PrimaryAttack()
end

function SWEP:OnLowered()
end

function SWEP:Holster(nextWep)
	self:OnLowered()

	return true
end

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Initialize
---------------------------------------------------------------------------------------------------------------------------------------------
*/


function SWEP:SetupShield()
	if CLIENT then return end;
	self.shieldProp = ents.Create("prop_physics");
	self.shieldProp:SetModel("models/bshields/dshield_open.mdl");
	self.shieldProp:Spawn(); 
	self.shieldProp:SetModelScale(0,0);
	local phys = self.shieldProp:GetPhysicsObject();
	if not IsValid(phys) then
		self.Owner:ChatPrint("not valid physics object!");
		return;
	end
	phys:SetMass(5000);
	
	local nothand = false;
	local attach = self.Owner:LookupAttachment("anim_attachment_RH");
	if attach == nil or attach == 0 then
		--self.Owner:ChatPrint("Attachment 'anim_attachment_RH' not found for this player model!");
		attach = self.Owner:LookupAttachment("forward");
		nothand = true;
		if attach == nil or attach == 0 then
			self.Owner:ChatPrint("Attachment 'anim_attachment_RH' and 'forward' not found for this player model!");
			return;
		end
	end
	
	local up = 3;
	local forward = 11;
	local right = 0;
	
	local aforward = 20;
	local aup = 70;
	
	if nothand then
	    up = -20;
		forward = 17;
		aforward = 0;
		aup = 90;
	end
	local attachTable = self.Owner:GetAttachment(attach);
	self.shieldProp:SetPos(attachTable.Pos + attachTable.Ang:Up()*up + attachTable.Ang:Forward()*forward + attachTable.Ang:Right()*right);
	
	attachTable.Ang:RotateAroundAxis(attachTable.Ang:Forward(),aforward);
	attachTable.Ang:RotateAroundAxis(attachTable.Ang:Up(),aup);
	self.shieldProp:SetAngles(attachTable.Ang);
	self.shieldProp:SetCollisionGroup( COLLISION_GROUP_WORLD );
	self.shieldProp:SetParent(self.Owner,attach);
	timer.Simple(0.2,function()
		if IsValid(self) and IsValid(self.shieldProp) then
			self.shieldProp:SetModelScale(1,0);
			net.Start("disable_shielddraw") net.WriteEntity(self) net.WriteEntity(self.shieldProp) net.Send(self.Owner);
		end
	end)
end


/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				CheckPlace
---------------------------------------------------------------------------------------------------------------------------------------------
*/
function SWEP:CheckPlace(pos)

	local mins = Vector( -10, -20, -3);
	local maxs = Vector( 20, 20, 40);
	local tr = {
		start = pos, 
		endpos = pos + Vector(0,0,5), 
		mins = mins, 
		maxs = maxs,
		filter = {self.Owner,self.shieldProp}
	}
	local hullTrace = util.TraceHull( tr );
	if ( hullTrace.Hit ) then
		return false;
	end	
	return true;	
end

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Deploy
---------------------------------------------------------------------------------------------------------------------------------------------
*/

function SWEP:SecondaryAttack()
	if CLIENT then return end;
	local ang = self.Owner:GetAngles()
	ang.p = 0;
	ang.r = 0;
	local pos = self.Owner:GetPos() + ang:Forward()*45 + Vector(0,0,30);
	local checkingPlace = self:CheckPlace(pos);
	if not checkingPlace then return end;
	local shieldEnt = ents.Create("police_shield");
	shieldEnt:SetPos(pos);
	local tempAngle = self.Owner:GetAngles();
	shieldEnt:SetAngles(Angle(0,tempAngle.y,0));
	
	shieldEnt.canBeDestroyedByDamage = self.canBeDestroyedByDamage;
	shieldEnt.onlyExplosionDamage = self.onlyExplosionDamage;
	shieldEnt.currentHealth = self.defaultHealth;
	
	shieldEnt:Spawn();
	shieldEnt.Owner = self.Owner;
	self.Owner:Freeze(true);
	local ply = self.Owner;
	timer.Simple(0.2,function()
		if IsValid(ply) then
			ply:Freeze(false);			
		end
	end)
	self:Remove();
end

function SWEP:DrawViewModel()
end

function SWEP:DrawWorldModel()
    if (!IsValid(self.Owner)) then
        self:DrawModel()
    end
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
