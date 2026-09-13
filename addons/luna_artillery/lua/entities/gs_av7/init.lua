--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("Use-XYAV-7")
util.AddNetworkString("Change-XYAV-7")
util.AddNetworkString("Fire-XYAV-7")

ENT.Delay = 10

function ENT:Initialize()	
  	self:SetModel("models/helios/vehicles/av7/av7.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetMoveType(MOVETYPE_NONE)
	self:DrawShadow(false)

	self.AV7NetDefense = true

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end

	self:ManipulateBoneAngles(self:LookupBone("gun"), Angle(0, 0, -50))
end

function ENT:Use(ply)
	if not IsValid(ply) or not ply:IsPlayer() then
		return
	end

	net.Start("Use-XYAV-7")
		net.WriteEntity(self)
	net.Send(ply)
end

function ENT:Think()
	self:NextThink(CurTime())

	local currentPos = self:GetPos()
	local targetPos = Vector(self:GetX(), self:GetY(), currentPos.z) 

	local desiredAng = (targetPos - currentPos):Angle() + Angle(0, 90, 0)
	desiredAng.p = 0 

	local currentAng = self:GetAngles()
	local lerpSpeed = FrameTime() * 5
	local newAng = LerpAngle(lerpSpeed, currentAng, desiredAng)

	self:SetAngles(newAng)

	return true
end

function ENT:SetCoords(x,y)
	self:SetX(x)
	self:SetY(y)
end

net.Receive("Change-XYAV-7", function(len, ply)
	local ent = net.ReadEntity()

	if not IsValid(ent) or not ent.AV7NetDefense or ply:GetPos():Distance(ent:GetPos()) > 500 then
		return
	end

	local x, y = net.ReadFloat(), net.ReadFloat()
	if x >= OBBMapMins.x and x <= OBBMapMaxs.x or y >= OBBMapMins.y or y <= OBBMapMaxs.y then
		ent:SetCoords(x, y)
	end
end)

net.Receive("Fire-XYAV-7", function(len, ply)
	local ent = net.ReadEntity()

	if not IsValid(ent) or not ent.AV7NetDefense or ply:GetPos():Distance(ent:GetPos()) > 500 or ent:GetDelay() > CurTime() then
		return
	end

	local ID_1 = ent:LookupAttachment( "muzzle" )
	local Muzzle1 = ent:GetAttachment( ID_1 )
	local Pos = Muzzle1.Pos				
	local Dir =  (Muzzle1.Ang):Up()	

	local projectile = ents.Create( "gs_missel" )
	projectile:SetPos(Pos)
	projectile:SetAngles(Dir:Angle())
	projectile:SetParent()
	projectile:Spawn()
	projectile:Activate()
	projectile:EmitSound( "vehicle/starwars/av7/av7fire.wav" )
	projectile:SetX(ent:GetX())
	projectile:SetY(ent:GetY())
	projectile.Direction = (Pos - ent:GetPos()):GetNormalized()

	util.ScreenShake(ent:GetPos(), 100, 40, 1, 2000, true )
	for i=1,10 do
		local effectdata = EffectData()
		effectdata:SetOrigin( ent:GetPos() )
		effectdata:SetRadius(500 * 500)
		effectdata:SetScale(24 * 20)
		util.Effect( "ThumperDust", effectdata, true, true )
	end

	ent:SetDelay(CurTime() + ent.Delay)
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
