--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

util.AddNetworkString('NPCJobs_OpenMenu')

function ENT:Initialize()
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal()
	self:SetSolid( SOLID_BBOX )
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE + CAP_TURN_HEAD )
	self:SetUseType( SIMPLE_USE )

    self:SetModel('models/galactic/supnpc/shopdroid/shopdroid.mdl')
end

function ENT:OnTakeDamage(dmginfo)
	return
end

function ENT:AcceptInput(inputName, user)
    user:PS_ToggleMenu()
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
