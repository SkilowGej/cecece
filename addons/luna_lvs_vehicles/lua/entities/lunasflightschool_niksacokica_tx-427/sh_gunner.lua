--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher



function ENT:CanUseBTL()
end

function ENT:CanUseTurret()
end

function ENT:TraceBTL()
	local ID = self:LookupAttachment( "muzzle_ballturret_left" )
	local Muzzle = self:GetAttachment( ID )

	if not Muzzle then return end

	local dir = Muzzle.Ang:Up()
	local pos = Muzzle.Pos

	local trace = util.TraceLine( {
		start = pos,
		endpos = (pos + dir * 50000),
	} )

	return trace
end

function ENT:GetAimAngles()
	local trace = self:GetEyeTrace()

	local AimAnglesR = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld( Vector(10,-60,81) ) ):GetNormalized():Angle() )
	local AimAnglesL = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld( Vector(10,60,81) ) ):GetNormalized():Angle() )

	return AimAnglesR, AimAnglesL
end

function ENT:WeaponsInRange()

	local AimAnglesR, AimAnglesL = self:GetAimAngles()

	return not ((AimAnglesR.p >= 30 and AimAnglesL.p >= 30) or (AimAnglesR.p <= -25 and AimAnglesL.p <= -25) or (math.abs(AimAnglesL.y) + math.abs(AimAnglesL.y)) >= 60)
end

function ENT:SetPoseParameterBlasterTurret( ent, active, weapon )

		self:SetPoseParameter("blasters_right_pitch", 0 )
		self:SetPoseParameter("blasters_right_yaw", 0 )

		self:SetPoseParameter("blasters_left_pitch", 0 )
		self:SetPoseParameter("blasters_left_yaw", 0 )

	local AimAnglesR, AimAnglesL = ent:GetAimAngles()

	self:SetPoseParameter("blasters_right_pitch", AimAnglesR.p )
	self:SetPoseParameter("blasters_right_yaw", AimAnglesR.y )

	self:SetPoseParameter("blasters_left_pitch", AimAnglesL.p )
	self:SetPoseParameter("blasters_left_yaw", AimAnglesL.y )

end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
