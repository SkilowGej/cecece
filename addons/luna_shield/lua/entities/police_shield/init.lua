--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFAULT_HEALTH = 10000


/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Initialize
---------------------------------------------------------------------------------------------------------------------------------------------
*/


function ENT:SpawnFunction(ply,tr,class)
    local weap = ply:Give("weapon_smallriotshield");
    weap.Owner = ply;
    weap.defaultHealth = DEFAULT_HEALTH;
end


function ENT:Initialize()
    self:SetModel("models/bshields/dshield_open.mdl");
    self:PhysicsInit(SOLID_VPHYSICS);
    self:SetSolid(SOLID_VPHYSICS);
    self:SetMoveType(MOVETYPE_VPHYSICS);
    self:SetUseType(SIMPLE_USE);
    local phys = self:GetPhysicsObject();
    phys:Wake();
    phys:SetMass(1000)
    local ply = self.Getowning_ent and self:Getowning_ent() or nil;
    if IsValid(ply) and ply:IsPlayer() then
        self.Owner = ply;
        self:CPPISetOwner(ply);
    end
    
    self:ResetSequence(self:LookupSequence("deploy"));
    
    self.currentHealth = self.defaultHealth or DEFAULT_HEALTH
end





/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Use function
---------------------------------------------------------------------------------------------------------------------------------------------
*/



function ENT:Use(activator, caller)
	if self.Owner == nil then self:Remove(); return end;
	if not IsValid(self.Owner) then self:Remove(); return end;
	if self.Owner != activator then return end;
	
	local weap = activator:Give("weapon_smallriotshield");
	weap.Owner = activator;
	self:Remove();
end 



/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				On Take Damage
---------------------------------------------------------------------------------------------------------------------------------------------
*/

function ENT:OnTakeDamage(dmg)
    local typ = dmg:GetDamageType();
    
    if self.onlyExplosionDamage and bit.band(typ, DMG_BLAST) ~= DMG_BLAST then return end;
    local damage = dmg:GetDamage();
    
    if not self.currentHealth then
        self.currentHealth = self.defaultHealth or DEFAULT_HEALTH
    end
    
    self.currentHealth = self.currentHealth - damage;
    if self.currentHealth <= 0 then 
        self:Remove();
    end
end

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Another
---------------------------------------------------------------------------------------------------------------------------------------------
*/
 
function ENT:Think()
	self:NextThink(CurTime());  return true;
end

function ENT:OnRemove()

end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
