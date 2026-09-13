--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

function ENT:OnSpawn()
end

ENT.EngineColor = Color( 101, 181, 212)
ENT.EngineGlow = Material("sprites/light_glow02_add")
ENT.EnginePos = {
	Vector(-465,34,185),
	Vector(-465,-34,185),
	Vector(-465,34,250),
	Vector(-465,-34,250),
	Vector(-500,210,170),
	Vector(-500,-210,170),
	Vector(-500,202,152.5),
	Vector(-500,-202,152.5),
	Vector(-500,195,135),
	Vector(-500,-195,135),
	Vector(-500,190,120),
	Vector(-500,-190,120),
	Vector(-500,130,203),
	Vector(-500,-130,203),
	Vector(-500,124,187.5),
	Vector(-500,-124,187.5),
	Vector(-500,115,170),
	Vector(-500,-115,170),
	Vector(-500,170,185),
	Vector(-500,-170,185),
	Vector(-500,160,165),
	Vector(-500,-160,165),
	Vector(-500,150,145),
	Vector(-500,-150,145),
	
}


function ENT:OnSpawn()
end

function ENT:OnFrame()
end

function ENT:OnWingsChanged()
end

function ENT:StartWindSounds()
    self:StopWindSounds()

    if LocalPlayer():lvsGetVehicle() ~= self then return end

    self._WaterSFX = CreateSound( self, "LVS.Physics.Water" )
    self._WaterSFX:PlayEx(0,100)
end   

function ENT:PostDrawTranslucent()
    if not self:GetEngineActive() then return end

    local Size = 200 + self:GetThrottle() * 120 + self:GetBoost() * 2

    render.SetMaterial( self.EngineGlow )

    for _, pos in pairs( self.EnginePos ) do
        render.DrawSprite(  self:LocalToWorld( pos ), Size, Size, self.EngineColor )
    end
end

function ENT:OnStartBoost()
	self:EmitSound( "^lvs/vehicles/shuttle/flyby.wav", 85 )
end

function ENT:OnStopBoost()
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
