AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel('models/lucky/navallookinganimated.mdl')

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self:SetUseType( SIMPLE_USE )
end


function ENT:OnTakeDamage(dmginfo)
	return
end

util.AddNetworkString('RPIDChanger_OpenMenu')

function ENT:AcceptInput(inputName, user)
    netstream.Start(user,'RPIDChanger_OpenMenu',nil)
end