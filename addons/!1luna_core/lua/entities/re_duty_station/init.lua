--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel('models/lucky/navalconsoleanimated.mdl')
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetSkin(1)
	self:SetUseType(SIMPLE_USE)
	self.ProtalVector = false
	-- Wake the physics object up
	local phys = self.Entity:GetPhysicsObject()

	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Wake()
	end
end

local function CalcDutyPlayers()
	local patrol = 0
	local station = 0
	local logistics = 0

	for k,v in pairs(player.GetAll()) do
		local status = v:GetNW2Int("Duty_Status", DUTY_NONE)
		if status == DUTY_NONE then continue end

		if status >= DUTY_PATROL_PREPARING and status <= DUTY_PATROL_FINISH then
			patrol = patrol + 1
		elseif status >= DUTY_STATION_PREPARING and status <= DUTY_STATION_FINISH then
			station = station + 1
		elseif status >= DUTY_LOGISTICS and status <= DUTY_LOGISTICS_CARRY then
			logistics = logistics + 1
		end
	end

	return {patrol, station, logistics}
end

function ENT:Use(activator, caller)
	local active_duty_players = CalcDutyPlayers()
	local top_duty_players = duty_leaderboard
	if IsValid(activator) and activator:IsPlayer() then
		net.Start("RE.Duty.Open_Terminal")
			net.WriteTable(active_duty_players)
			net.WriteTable(top_duty_players)
		net.Send(activator)
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
