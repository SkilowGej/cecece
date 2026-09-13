AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel('models/coruscantpropspackswtor/picture_size2.mdl')

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self:SetUseType( SIMPLE_USE )
end


function ENT:OnTakeDamage(dmginfo)
	return
end

util.AddNetworkString('GUMCommand_OpenMenu')

function ENT:AcceptInput(inputName, user)
	if GUM_RATING_EDITORS[user:GetNWString('rating')] then
		netstream.Start(user,'GUMCommand_OpenMenu',self)
	end
end

netstream.Hook('GUMCommand_SelectGum', function(ply, data)
	if not ply:IsSuperAdmin() then return end

	data.ent:SetGUM(data.gum)
end)

netstream.Hook('GUMCommand_Activate', function(ply, data)
	if not GUM_RATING_EDITORS[ply:GetNWString('rating')] then return end
	local gums = GetGlobalTable('gums')
	local gum = data.ent:GetGUM()

	gums[gum] = {
		text = data.text,
		ply = ply
	}

	ply:Say('/comm Zajął ' .. GUM_ROOMS[gum] .. ' z powodu "' .. data.text .. '".')

	SetGlobalTable('gums', gums)
end)

netstream.Hook('GUMCommand_Clean', function(ply, data)
	local gums = GetGlobalTable('gums')
	local gum = data.ent:GetGUM()

	gums[gum] = false

	SetGlobalTable('gums', gums)
end)