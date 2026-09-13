--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


function ENT:OnFrame()
	self:PredictPoseParamaters()
	self:DamageFX()

	-- local RearEnt = self:GetRearEntity()

	-- if not IsValid( RearEnt ) then return end

	if self:GetIsRagdoll() then 
		self:LegClearAll()
		-- RearEnt:LegClearAll()

		return
	end

	local Up = self:GetUp()
	local Forward = self:GetForward()
	local Vel = self:GetVelocity()
	
	local Stride = 40
	local Lift = 20
	
	local FT = math.min(FrameTime(),0.08) -- if fps lower than 12, clamp the frametime to avoid spazzing.

	local Rate = FT * 20

	if Vel:Length() < 10 then -- sync with server animation when not moving
		self.Move = self:GetMove()
	else
		self.Move = self.Move and self.Move + self:WorldToLocal( self:GetPos() + Vel ).x * FT * 1.8 or 0
	end
	
	local Cycl1 = self.Move
	local Cycl2 = self.Move + 180
	local Cycl3 = self.Move + 90
	local Cycl4 = self.Move + 270
	local Cycl5 = self.Move
	local Cycl6 = self.Move + 180
	local Cycl7 = self.Move + 270
	local Cycl8 = self.Move

	local IsMoving = self:GetIsMoving()
	
	if self:GetIsCarried() then
		self.TRACEPOS1 = self:LocalToWorld( Vector(-30,80,220) )
		self.TRACEPOS2 = self:LocalToWorld( Vector(-30,-80,220) )
		-- self.TRACEPOS3 = self:LocalToWorld( Vector(-160,-70,-480) )
		self.TRACEPOS4 = self:LocalToWorld( Vector(-160,70,-480) )
		self.TRACEPOS5 = self:LocalToWorld( Vector(0,-140,150) )
		self.TRACEPOS6 = self:LocalToWorld( Vector(0,140,150) )
		self.TRACEPOS7 = self:LocalToWorld( Vector(200,70,-580) )
		self.TRACEPOS8 = self:LocalToWorld( Vector(200,-70,-580) )
		Cycl1 = 0
		Cycl2 = 0
		Cycl3 = 0
		Cycl4 = 0
		Cycl5 = 0
		Cycl6 = 0
		Cycl7 = 0
		Cycl8 = 0
		IsMoving = true
	end

	local MoveRoll = math.cos( math.rad(self:GetMove()) ) * 2

	local ZParametr = (self:GetCannonMode() == 1 and 40) or 20

	local X = -30 + math.cos( math.rad(Cycl1) ) * Stride
	local Z = math.max( math.sin( math.rad(-Cycl1) ), 0) * Lift
	local STARTPOS = self:LocalToWorld( Vector( -30.66, 86.78, 201.25 ) )
	self.TRACEPOS1 = self.TRACEPOS1 and self.TRACEPOS1 or STARTPOS
	if Z > 0 or not IsMoving then 
		self.TRACEPOS1 = self.TRACEPOS1 + (STARTPOS + Forward * X - self.TRACEPOS1) * Rate
		self.FSOG1 = false
	else
		self.FSOG1 = true
	end
	local ENDPOS = util.TraceLine( { start = self.TRACEPOS1 - Up * 50, endpos = self.TRACEPOS1 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end,} ).HitPos + Up * (ZParametr+Z)
	if self.FSOG1 ~= self.oldFSOG1 then
		self.oldFSOG1 = self.FSOG1
		if self.FSOG1 then
			sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4).."_light.ogg" ), ENDPOS, SNDLVL_70dB)
			local effectdata = EffectData()
				effectdata:SetOrigin( ENDPOS - Vector(0,0,45) )
			util.Effect( "lvs_walker_stomp", effectdata )
		else
			sound.Play( Sound( "lvs/vehicles/atte/hydraulic"..math.random(1,7)..".ogg" ), ENDPOS, SNDLVL_70dB)
		end
	end
	
	local ATTACHMENTS = {
		Leg1 = {MDL = "models/sw/atot_veh/AT-AP_legBig3.mdl", Ang = Angle(180,-90,-105), Pos = Vector(0,-4,16)},
		Leg2 = {MDL = "models/sw/atot_veh/AT-AP_legBig2.mdl", Ang = Angle(180,-90,20), Pos = Vector(0,0,-4)},
		Foot = {MDL = "models/sw/atot_veh/AT-AP_legBig0.mdl", Ang = Angle(0,-90,MoveRoll), Pos = Vector(-3,-13,0)}
	}
	self:GetLegEnts( 1, 115, 115, self:LocalToWorldAngles( Angle(90,0,0) ), STARTPOS, ENDPOS, ATTACHMENTS )


	-- FRONT RIGHT
	local STARTPOS = self:LocalToWorld( Vector( -30.66, -86.78, 201.25 ) )
	local X = -30 + math.cos( math.rad(Cycl2) ) * Stride
	local Z = math.max( math.sin( math.rad(-Cycl2) ), 0) * Lift
	self.TRACEPOS2 = self.TRACEPOS2 and self.TRACEPOS2 or STARTPOS
	if Z > 0 or not IsMoving then 
		self.TRACEPOS2 = self.TRACEPOS2 + (STARTPOS + Forward * X - self.TRACEPOS2) * Rate
		self.FSOG2 = false
	else
		self.FSOG2 = true
	end
	local ENDPOS = util.TraceLine( { start = self.TRACEPOS2 - Up * 50, endpos = self.TRACEPOS2 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end, } ).HitPos + Up * (ZParametr+Z)
	if self.FSOG2 ~= self.oldFSOG2 then
		self.oldFSOG2 = self.FSOG2
		if self.FSOG2 then
			sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4).."_light.ogg" ), ENDPOS, SNDLVL_70dB)
			local effectdata = EffectData()
				effectdata:SetOrigin( ENDPOS - Vector(0,0,45) )
			util.Effect( "lvs_walker_stomp", effectdata )
		else
			sound.Play( Sound( "lvs/vehicles/atte/hydraulic"..math.random(1,7)..".ogg" ), ENDPOS, SNDLVL_70dB)
		end
	end
	
	local ATTACHMENTS = {
		Leg1 = {MDL = "models/sw/atot_veh/AT-AP_legBig3.mdl", Ang = Angle(180,90,-105), Pos = Vector(0,4,16)},
		Leg2 = {MDL = "models/sw/atot_veh/AT-AP_legBig2.mdl", Ang = Angle(180,90,20), Pos = Vector(0,0,4)},
		Foot = {MDL = "models/sw/atot_veh/AT-AP_legBig0.mdl", Ang = Angle(0,90,-MoveRoll), Pos = Vector(0,13,0)}
	}
	
	self:GetLegEnts( 2, 115, 115, self:LocalToWorldAngles( Angle(90,0,0) ), STARTPOS, ENDPOS, ATTACHMENTS )
-- print(self:GetCannonMode())
	local STARTPOS = self:LocalToWorld( Vector( 9, 0, 180 ) )
	local X = 80--50 + math.cos( math.rad(Cycl3) ) * Stride

	-- self.LegRotate = 0

	local Z
	local TargetValue = (self:GetCannonMode() == 1 and -1) or 1

	if ((self:GetCannonMode() == 1) and (Z != 110)) 
		or ((self:GetCannonMode() == 0) and (Z != 10)) then
		self.LegRotate = math.Clamp(self.LegRotate + TargetValue * FrameTime(), 0, 1)
	end

	-- print(self.LegRotate)

	Z = (self.LegRotate*100) + 10
	-- local Z = (self:GetCannonMode()==1 and 10) or 110--math.max( math.sin( math.rad(-Cycl3) ), 0) * Lift
	self.TRACEPOS3 = self.TRACEPOS3 and self.TRACEPOS3 or STARTPOS
	if Z > 0 or not IsMoving then 
		self.TRACEPOS3 = self.TRACEPOS3 + (STARTPOS + Forward * X - self.TRACEPOS3) * Rate
		self.FSOG3 = false
	else
		self.FSOG3 = true
	end
	local ENDPOS = util.TraceLine( { start = self.TRACEPOS3 - Up * 50, endpos = self.TRACEPOS3 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end, } ).HitPos + Up * (30+Z)
	if self.FSOG3 ~= self.oldFSOG3 then
		self.oldFSOG3 = self.FSOG3
		if self.FSOG3 then
			sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4).."_light.ogg" ), ENDPOS, SNDLVL_70dB)
			local effectdata = EffectData()
				effectdata:SetOrigin( ENDPOS - Vector(0,0,45) )
			util.Effect( "lvs_walker_stomp", effectdata )
		else
			sound.Play( Sound( "lvs/vehicles/atte/hydraulic"..math.random(1,7)..".ogg" ), ENDPOS, SNDLVL_70dB)
		end
	end
	
	local ATTACHMENTS = {
		Leg1 = {MDL = "models/sw/atot_veh/AT-AP_legSmall2.mdl", Ang = Angle(180,90,50), Pos = Vector(0,0,0)},
		Leg2 = {MDL = "models/sw/atot_veh/AT-AP_legSmall2.mdl", Ang = Angle(180,90,45), Pos = Vector(0,0,14)},
		Foot = {MDL = "models/sw/atot_veh/AT-AP_legSmall0.mdl", Ang = Angle(MoveRoll,90,0), Pos = Vector(0,0,0)}
	}
	
	self:GetLegEnts( 3, 80, 90, self:LocalToWorldAngles( Angle(90,0,0) ), STARTPOS, ENDPOS, ATTACHMENTS )


end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
