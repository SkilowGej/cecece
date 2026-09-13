--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("CC_BuffBase_SetHUDEffect");

SWEP.Buff_Logic = function(self)
	self.Owner:ChatPrint("Zdolność wzmocnienia nie została zrealizowana..");
end

function SWEP:PrimaryAttack()
	if (self:GetNextPrimaryFire() > CurTime()) then return end;
	self:SetNextPrimaryFire(CurTime() + self.Buff_Coldown);
	self.Buff_Logic(self);

	local snd = self.Buff_Sound()
	if snd and IsValid(self:GetOwner()) then
		self:GetOwner():EmitSound(self.Buff_Sound(), 85, 100, 1, CHAN_WEAPON)
	end
end

function SWEP:SecondaryAttack()
	return;
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
