--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


function ENT:SetPosTurret()
	local Turret = self:GetTurretSeat()

	if not IsValid( Turret ) then return end

	local ID = self:LookupAttachment( "gunT" )
	local Att = self:GetAttachment( ID )

	if not Att then return end

	local PosL = self:WorldToLocal( Att.Pos + Att.Ang:Right() * 20 - Att.Ang:Up() * 5 )
	Turret:SetLocalPos( PosL )
end

function ENT:SetPoseParameterTurret( weapon )
	if self:GetIsCarried() then
		-- self:SetPoseParameter("cannon_pitch", 0 )
		-- self:SetPoseParameter("cannon_yaw", 180 )

		ent:ManipulateBoneAngles(3,Angle(0,0,0))

		if self.TurretWasSet then
			self.TurretWasSet = nil

			self:SetTurretPitch( 0 )
			self:SetTurretYaw( 180 )
		end

		return
	end

	self.TurretWasSet = true

	if not IsValid( weapon:GetDriver() ) and not weapon:GetAI() then return end

	local AimAng = weapon:WorldToLocal( weapon:GetPos() + weapon:GetAimVector() ):Angle()
	AimAng:Normalize()

	local AimRate = self.TurretTurnRate * FrameTime() 

	self:SetTurretPitch( math.ApproachAngle( self:GetTurretPitch(), AimAng.p, AimRate ) )
	self:SetTurretYaw( math.ApproachAngle( self:GetTurretYaw(), AimAng.y, AimRate ) )
	-- print(self:GetTurretPitch())
	local p = math.Clamp(self:GetTurretPitch(), -25, 15)
	-- local y = math.Clamp(AimAngl`es.y, -55, 55)

	self:ManipulateBoneAngles(2,Angle(0,-self:GetTurretYaw(),p))

	-- self:SetPoseParameter("cannon_pitch", self:GetTurretPitch() )
	-- self:SetPoseParameter("cannon_yaw", self:GetTurretYaw() )
end

function ENT:InitTurret()
	local weapon = {}
	weapon.Icon = Material("lvs/weapons/protontorpedo.png")
	weapon.Ammo = 160
	weapon.Delay = 1
	weapon.HeatRateUp = 0.2
	weapon.HeatRateDown = 0.25
	weapon.OnOverheat = function( ent ) end
	weapon.Attack = function( ent )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		if base:GetIsCarried() then ent:SetHeat( 0 ) return true end

		base:PlayAnimation( "top_shoot" )

		local ID = base:LookupAttachment( "gunT" )
		local Muzzle = base:GetAttachment( ID )

		if not Muzzle then return end

		local Driver = ent:GetDriver()

		local projectile = ents.Create( "lvs_protontorpedo" )
		projectile:SetPos( Muzzle.Pos )
		projectile:SetAngles( (-Muzzle.Ang:Right()):Angle() )
		projectile:SetParent( ent )
		projectile:Spawn()
		projectile:Activate()
		projectile:SetAttacker( IsValid( Driver ) and Driver or self )
		projectile:SetEntityFilter( ent:GetCrosshairFilterEnts() )
		projectile:SetSpeed( 4000 )
		projectile:Enable()

		ent:TakeAmmo()

		if not IsValid( base.SNDTurret ) then return end

		base.SNDTurret:PlayOnce( 100 + math.cos( CurTime() + ent:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )		
	end
	weapon.OnThink = function( ent, active )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		base:SetPoseParameterTurret( ent )
		base:SetPosTurret()
	end
	weapon.CalcView = function( ent, ply, pos, angles, fov, pod )
		local base = ent:GetVehicle()

		local view = {}
		view.origin = pos
		view.angles = angles
		view.fov = fov
		view.drawviewer = false

		if not IsValid( base ) then return view end

		local ID = base:LookupAttachment( "gunT" )
		local Att = base:GetAttachment( ID )

		if Att then
			local Pos,_= LocalToWorld( Vector(0,-185,-25), Angle(0,0,0), Att.Pos, Att.Ang )
			view.origin = Pos
		end

		if not pod:GetThirdPersonMode() then
			return view
		end

		local mn = self:OBBMins()
		local mx = self:OBBMaxs()
		local radius = ( mn - mx ):Length()
		local radius = radius + radius * pod:GetCameraDistance()

		local clamped_angles = pod:WorldToLocalAngles( angles )
		clamped_angles.p = math.max( clamped_angles.p, -20 )
		clamped_angles = pod:LocalToWorldAngles( clamped_angles )

		local StartPos = self:LocalToWorld( Vector(-40,0,280) )
		local EndPos = StartPos - clamped_angles:Forward() * radius + clamped_angles:Up() * radius * 0.2

		local WallOffset = 4

		local tr = util.TraceHull( {
			start = StartPos,
			endpos = EndPos,
			filter = function( e )
				local c = e:GetClass()
				local collide = not c:StartWith( "prop_physics" ) and not c:StartWith( "prop_dynamic" ) and not c:StartWith( "prop_ragdoll" ) and not e:IsVehicle() and not c:StartWith( "gmod_" ) and not c:StartWith( "lvs_" ) and not c:StartWith( "player" ) and not e.LVS

				return collide
			end,
			mins = Vector( -WallOffset, -WallOffset, -WallOffset ),
			maxs = Vector( WallOffset, WallOffset, WallOffset ),
		} )

		view.angles = angles + Angle(5,0,0)
		view.origin = tr.HitPos

		if tr.Hit and  not tr.StartSolid then
			view.origin = view.origin + tr.HitNormal * WallOffset
		end

		return view
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		if base:GetIsCarried() then return end

		local ID = base:LookupAttachment( "gunT" )
		local Muzzle = base:GetAttachment( ID )

		if not Muzzle then return end

		local dir = -Muzzle.Ang:Right()
		local pos = Muzzle.Pos

		local trace = util.TraceLine( {
			start = pos,
			endpos = (pos + dir * 50000),
			filter = function( entity ) 
				if base:GetCrosshairFilterLookup()[ entity:EntIndex() ] or entity:GetClass():StartWith( "lvs_protontorpedo" ) then
					return false
				end

				return true
			end,
		} )

		local Pos2D = trace.HitPos:ToScreen()

		self:PaintCrosshairCenter( Pos2D )
		self:PaintCrosshairOuter( Pos2D )
		self:LVSPaintHitMarker( Pos2D )
	end
	weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/vehicles/atte/overheat.mp3", 85) end
	self:AddWeapon( weapon, 2 )
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
