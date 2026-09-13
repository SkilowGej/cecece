--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")
include( "sh_mainweapons.lua" )
include( "sh_ballturret_left.lua" )
include( "sh_wingturret.lua" )
include( "cl_drawing.lua" )
include( "sh_gunner2.lua" )
include( "sh_gunner3.lua" )
include( "cl_prediction.lua" )
include( "cl_lights.lua" )

function ENT:CalcViewOverride( ply, pos, angles, fov, pod )
	if pod == self:GetDriverSeat() then

		if pod:GetThirdPersonMode() then
			pos = pos + self:GetUp() * 100, angles, fov
		end

		return pos, angles, fov
	end

	if pod:GetThirdPersonMode() then
		pos = ply:GetShootPos() + pod:GetUp() * 40
	else
		pos = pos + pod:GetUp() * 40
	end

	return pos, angles, fov
end

function ENT:OnSpawn()
end

function ENT:OnFrame()
	self:AnimLights()
	self:WingTurretProjector()
	self:BTLProjector()
	self:PredictPoseParamaters()
end
	
function ENT:BTLProjector()
	local Fire = self:GetBTLFire()

	if Fire == self.OldFireBTL then return end

	self.OldFireBTL = Fire
	
	if Fire then
		local effectdata = EffectData()
		effectdata:SetEntity( self )
		util.Effect( "lvs_laat_left_projector", effectdata )
	end
end

function ENT:WingTurretProjector()
	local FireWingTurret = self:GetWingTurretFire()

	if FireWingTurret == self.OldWingTurretFire then return end

	self.OldWingTurretFire = FireWingTurret

	if FireWingTurret then
		local effectdata = EffectData()
		effectdata:SetEntity( self )
		util.Effect( "lvs_laat_wing_projector", effectdata )
	end
end


function ENT:OnStartBoost()
	self:EmitSound( "^lvs/vehicles/laat/boost_"..math.random(1,2)..".wav", 85 )
end

function ENT:OnStopBoost()
end

hook.Add( "HUDPaintBackground", "!!!!!LVS_hudBackground", function()
    local ply = LocalPlayer()

    if ply:GetViewEntity() ~= ply then return end

    local Pod = ply:GetVehicle()
    local Parent = ply:lvsGetVehicle()

    if not IsValid( Pod ) or not IsValid( Parent ) then
        ply._lvsoldPassengers = {}

        return
    end

    local X = ScrW()
    local Y = ScrH()

    local base = Pod:lvsGetWeapon()
    if IsValid( base ) then
        local weapon = base:GetActiveWeapon()
        if weapon and weapon.HUDPaintBackground then
            weapon.HUDPaintBackground( base, X, Y, ply )
        end
    else
        local weapon = Parent:GetActiveWeapon()
        if ply == Parent:GetDriver() and weapon and weapon.HUDPaintBackground then
            weapon.HUDPaintBackground( Parent, X, Y, ply )
        end
    end
end )

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
