--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
	self:DrawShadow(false)
	self:SetModel("models/hunter/plates/plate1x1.mdl")
	self:SetMaterial("models/effects/vol_light001")
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self.heldby = 0
	self:SetMoveType(MOVETYPE_NONE)
end

function ENT:PhysicsUpdate(phys)
	if self.heldby <= 0 then
		phys:Sleep()
	end
end

local function textscreenpickup(ply, ent)
	if IsValid(ent) and ent:GetClass() == "sammyservers_textscreen" then
		ent.heldby = ent.heldby + 1
	end
end

hook.Add("PhysgunPickup", "textscreenpreventtravelpickup", textscreenpickup)

local function textscreendrop(ply, ent)
	if IsValid(ent) and ent:GetClass() == "sammyservers_textscreen" then
		ent.heldby = ent.heldby - 1
	end
end

hook.Add("PhysgunDrop", "textscreenpreventtraveldrop", textscreendrop)

local function textscreencantool(ply, trace, tool)
	if IsValid(trace.Entity) and trace.Entity:GetClass() == "sammyservers_textscreen" then
		if not (tool == "textscreen" or tool == "remover" or tool == "permaprops") then return false end
	end
end

hook.Add("CanTool", "textscreenpreventtools", textscreencantool)
util.AddNetworkString("textscreens_update")
util.AddNetworkString("textscreens_download")

function ENT:SetLine(line, text, color, size)
	self.lines = self.lines or {}

	self.lines[tonumber(line)] = {
		["text"] = text,
		["color"] = color,
		["size"] = size
	}
end

net.Receive("textscreens_download", function(len, ply)
	if not IsValid(ply) and not ply:IsAdmin() and not ply:IsSuperAdmin() then return end
	local ent = net.ReadEntity()

	if IsValid(ent) and ent:GetClass() == "sammyservers_textscreen" then
		ent.lines = ent.lines or {}
		net.Start("textscreens_update")
		net.WriteEntity(ent)
		net.WriteTable(ent.lines)
		net.Send(ply)
	end
end)

function ENT:Broadcast()
	net.Start("textscreens_update")
	net.WriteEntity(self)
	net.WriteTable(self.lines)
	net.Broadcast()
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
