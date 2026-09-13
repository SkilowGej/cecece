--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

function ENT:Initialize()
	self:SetModel("models/props_phx/construct/wood/wood_boardx4.mdl");
	self:EmitSound("heart/turbolaser/heart_turbolaser_shot.wav", 511, math.random(95,125));

	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetSolid(SOLID_VPHYSICS);

	local phys = self:GetPhysicsObject();

	if (phys:IsValid()) then
		phys:EnableGravity(false);
		phys:EnableDrag(false);
		phys:EnableCollisions(true);

		phys:Wake();
	end

	self:SetScale(self:GetVar("scale", 1));

	self:SetColR(self:GetVar("r", 255));
	self:SetColG(self:GetVar("g", 0));
	self:SetColB(self:GetVar("b", 0));
end

function ENT:PhysicsUpdate()
	self:GetPhysicsObject():SetVelocity(self:GetForward() * self:GetVar("speed", 1000));
end

function ENT:PhysicsCollide()
	local pos = self:GetPos();
	local radius = self:GetVar("radius", 150) * 500;

	local effect = EffectData();
	effect:SetStart(pos);
	effect:SetOrigin(pos);
	effect:SetScale(radius);

	--util.Effect("Explosion", effect);
	util.Effect("lvs_atap_bullet_explosion", effect);

	util.BlastDamage( self, self, pos, self:GetVar("radius", 150), self:GetVar("damage", 1000));
	self:EmitSound("ARTILLERYIMPACT", 400, 100);

	self:Remove();
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
