--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


function ENT:UnRagdoll()
	if not self.Constrainer then return end

	self:SetTargetSpeed( 200 )
	self:SetIsRagdoll( false )

	-- local RearEnt = self:GetRearEntity()

	for _, ent in pairs( self.Constrainer ) do
		if not IsValid( ent ) then continue end

		if ent ~= self then
			ent:Remove()
		end
	end

	self.Constrainer = nil

	self.DoNotDuplicate = false
end

function ENT:BecomeRagdoll()
	if self.Constrainer then return end

	self:SetIsRagdoll( true )

	-- self:EmitSound( "lvs/vehicles/atte/becomeragdoll.ogg", 85 )

	-- local RearEnt = self:GetRearEntity()

	self.Constrainer = {
		-- [-1] = RearEnt,
		[0] = self,
	}

	self.DoNotDuplicate = true

	local legs = {
		[1] = {
			mdl = "models/sw/atot_veh/AT-AP_legBig3.mdl",
			pos = Vector( -53.25, 81.03, 206.37 ),
			ang = Angle(184.215007781982,-90.94340515137,120.648578643799),
			constraintent = 0,
			relative = self,
			mass = 100,
		},
		[2] = {
			mdl = "models/sw/atot_veh/AT-AP_legBig2.mdl",
			pos = Vector( -126, 91.03, 136.37 ),
			ang = Angle(184,-90,120),
			constraintent = 1,
			relative = self,
			mass = 100,
		},
		[3] = {
			mdl = "models/sw/atot_veh/AT-AP_legBig0.mdl",
			pos = Vector( -16, 91.03, 106.37 ),
			ang = Angle(7.58911895752,-95.624977111816,-4.3076190948486),
			constraintent = 2,
			relative = self,
			mass = 500,
		},
		[4] = {
			mdl = "models/sw/atot_veh/AT-AP_legBig3.mdl",
			pos = Vector( -53.25, -81.03, 196.37 ),
			ang = Angle(184.215007781982,90.94340515137,10.648578643799),
			constraintent = 0,
			relative = self,
			mass = 100,
		},
		[5] = {
			mdl = "models/sw/atot_veh/AT-AP_legBig2.mdl",
			pos = Vector( -136, -91.03, 156.37 ),
			ang = Angle(184,90,-100),
			constraintent = 4,
			relative = self,
			mass = 100,
		},
		[6] = {
			mdl = "models/sw/atot_veh/AT-AP_legBig0.mdl",
			pos = Vector( -26, -101.03, 106.37 ),
			ang = Angle(7.58911895752,-95.624977111816,-4.3076190948486),
			constraintent = 5,
			relative = self,
			mass = 500,
		},
		[7] = {
			mdl = "models/sw/atot_veh/AT-AP_legSmall2.mdl",
			pos = Vector( 0, 0, 196.37 ),
			ang = Angle(0,90,30),
			constraintent = 0,
			relative = self,
			mass = 100,
		},
		[8] = {
			mdl = "models/sw/atot_veh/AT-AP_legSmall2.mdl",
			pos = Vector( 20, 0, 126.37 ),
			ang = Angle(0,-90,-180),
			constraintent = 7,
			relative = self,
			mass = 100,
		},
		[9] = {
			mdl = "models/sw/atot_veh/AT-AP_legSmall0.mdl",
			pos = Vector( 80, 0, 186.37 ),
			ang = Angle(7.58911895752,-95.624977111816,-4.3076190948486),
			constraintent = 8,
			relative = self,
			mass = 500,
		},
		
	}

	for k, v in pairs( legs ) do
		if not IsValid( v.relative ) then continue end

		local ent = ents.Create( "lvs_walker_atte_component" )
		ent:SetModel( v.mdl )
		ent:SetPos( v.relative:LocalToWorld( v.pos ) )
		ent:SetAngles( v.relative:LocalToWorldAngles( v.ang ) )
		ent:SetBase( self )
		ent:Spawn()
		ent:Activate()
		ent:SetCollisionGroup( COLLISION_GROUP_WORLD )
		self:DeleteOnRemove( ent )

		self.Constrainer[ k ] = ent

		local PhysObj = ent:GetPhysicsObject()
		if IsValid( PhysObj ) then
			PhysObj:SetMass( v.mass )
		end

		self:TransferCPPI( ent )

		ent.DoNotDuplicate = true
	end

	for k, v in pairs( legs ) do
		local ent = self.Constrainer[ k ]
		local TargetEnt = self.Constrainer[ v.constraintent ]
		if not IsValid( ent ) or not IsValid( TargetEnt ) then continue end

		local ballsocket = constraint.AdvBallsocket(ent, TargetEnt,0,0, Vector(0,0,0), Vector(0,0,0),0,0, -30, -30, -30, 30, 30, 30, 0, 0, 0, 0, 1)
		ballsocket.DoNotDuplicate = true
		self:TransferCPPI( ballsocket )
	end

	self:ForceMotion()
end

function ENT:NudgeRagdoll()
	if not istable( self.Constrainer ) then return end

	for _, ent in pairs( self.Constrainer ) do
		if not IsValid( ent ) or ent == self or ent == self:GetRearEntity() then continue end

		local PhysObj = ent:GetPhysicsObject()

		if not IsValid( PhysObj ) then continue end

		PhysObj:EnableMotion( false )

		ent:SetPos( ent:GetPos() + self:GetUp() * 100 )

		timer.Simple( FrameTime() * 2, function()
			if not IsValid( ent ) then return end

			local PhysObj = ent:GetPhysicsObject()
			if IsValid( PhysObj ) then
				PhysObj:EnableMotion( true )
			end
		end)
	end
end

function ENT:ForceMotion()
	for _, ent in ipairs( self:GetContraption() ) do
		if not IsValid( ent ) then continue end

		local phys = ent:GetPhysicsObject()

		if not IsValid( phys ) then continue end

		if not phys:IsMotionEnabled() then
			phys:EnableMotion( true )
		end
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
