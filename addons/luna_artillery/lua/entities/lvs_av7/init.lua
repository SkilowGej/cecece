--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.SpawnNormalOffset = 45

local WheelMass = 100
local WheelRadius = 32
local WheelPos = {
	Vector(-400,-100,-27),
	Vector(-400,100,-27),
	Vector(400,-100,-27),
	Vector(400,100,-27),
}

function ENT:OnSpawn( PObj )

	PObj:SetMass( 10000 )

	self:ManipulateBoneAngles(self:LookupBone("root"), Angle(0, 90, 0))


    local Pod = self:AddDriverSeat(Vector(-10,-33,157), Angle(0,-90,0))

	--local Pod = self:AddPassengerSeat( Vector(400,-100,-20), Angle(0,0,0) )
	
	local driver = self:GetDriver()

	for _, Pos in pairs( WheelPos ) do 
		self:AddWheel( Pos, WheelRadius, WheelMass, 10 )
	end
	self:AddEngineSound( Vector(0,0,30) )

end

function ENT:OnTick()
end

function ENT:OnKeyThrottle( bPressed )
end

function ENT:OnLandingGearToggled( bOn )
end



--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
