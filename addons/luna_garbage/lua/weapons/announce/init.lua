--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

SWEP.AutoSwitchFrom = false

SWEP.ReloadTime = CurTime()
SWEP.ReloadRate = 4

function SWEP:Initialize()
	self:SetHoldType( self.HoldType )
end

function SWEP:ChangeTalkDistance(delta)
	if self:GetAllTalk() then return end
	self:SetDistance(math.max(self:GetDistance() + delta,40000))
end

function SWEP:PrimaryAttack()
	self:ChangeTalkDistance(62500)
end

function SWEP:SecondaryAttack()
	self:ChangeTalkDistance(-62500)
end

function SWEP:Reload()
	if CurTime() > self.ReloadTime then
		self:SetAllTalk(not self:GetAllTalk())
		self.ReloadTime = CurTime() + self.ReloadRate
	end
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
