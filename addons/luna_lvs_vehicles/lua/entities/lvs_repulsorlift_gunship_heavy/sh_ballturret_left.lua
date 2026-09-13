--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

function ENT:SetPosBTL()
	local BTL = self:GetBTPodL()

	if not IsValid( BTL ) then return end

	local ID = self:LookupAttachment( "muzzle_ballturret_left" )
	local Muzzle = self:GetAttachment( ID )

	if Muzzle then
		local PosL = self:WorldToLocal( Muzzle.Pos + Muzzle.Ang:Right() * 28 - Muzzle.Ang:Up() * 65 )
		BTL:SetLocalPos( PosL )
	end
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

function ENT:SetPoseParameterBTL( weapon )
	if not IsValid( weapon:GetDriver() ) and not weapon:GetAI() then return end

	local AimAng = weapon:WorldToLocal( weapon:GetPos() + weapon:GetAimVector() ):Angle()
	AimAng:Normalize()

	self:SetPoseParameter("ballturret_left_pitch", AimAng.p )
	self:SetPoseParameter("ballturret_left_yaw", AimAng.y )
end

function ENT:InitWeaponBTL()
	local COLOR_RED = Color(255,0,0,255)
	local weapon = {}
	weapon.Icon = Material("lvs/weapons/dual_mg.png")
	weapon.Delay = 0.05
	weapon.HeatRateUp = 0.545
	weapon.HeatRateDown = 0.5
	weapon.OnOverheat = function( ent )
		if ent:GetAI() then return end
		ent:EmitSound("lvs/overheat.wav")
	end
	weapon.Attack = function( ent )
		local base = ent:GetVehicle()
		local ID = base:LookupAttachment( "muzzle_ballturret_left" )
		local Muzzle = base:GetAttachment( ID )
		local bullet = {}
			bullet.Src 	= Muzzle.Pos
			bullet.Dir 	= Muzzle.Ang:Up()
			bullet.Spread 	= Vector( 0.0125,  0.0125, 0 )
			bullet.TracerName = "lvs_laser_green"
			bullet.Force	= 100
			bullet.HullSize 	= 10
			bullet.Damage	= 10
			bullet.SplashDamage = 50
			bullet.SplashDamageRadius = 200
			bullet.Velocity = 15000
			bullet.Attacker 	= ent:GetDriver()
			bullet.Callback = function(att, tr, dmginfo)
				local effectdata = EffectData()
					effectdata:SetStart( Muzzle.Pos ) 
					effectdata:SetOrigin( tr.HitPos )
					effectdata:SetNormal( tr.HitNormal )
				util.Effect( "lvs_laser_explosion", effectdata )
			end
			ent:LVSFireBullet( bullet )
			-- ent:EmitSound("lvs/vehicles/laat/fire.mp3", 50 )
			self.sndBTL:EmitSound( "lvs/vehicles/laat/fire.mp3", 65 )
	end
	weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav") end
	weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	weapon.OnThink = function( ent, active )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		base:SetPoseParameterBTL( ent )
		base:SetPosBTL()

		if not ent:GetAI() then return end

		local ID = base:LookupAttachment( "muzzle_ballturret_left" )
		local Muzzle = base:GetAttachment( ID )
		if not Muzzle then return end


	end
	weapon.CalcView = function( ent, ply, pos, angles, fov, pod )
		local base = ent:GetVehicle()
		base.ZoomFov = 20

		local view = {}
		view.origin = pos
		view.angles = angles
		view.fov = fov
		view.drawviewer = false

		if not IsValid( base ) then return view end

		local ID = base:LookupAttachment( "muzzle_ballturret_left" )
		local Muzzle = base:GetAttachment( ID )

		if Muzzle then
			local Pos,Ang = LocalToWorld( Vector(0,25,-45), Angle(270,0,-90), Muzzle.Pos, Muzzle.Ang )

			view.origin = Pos
		end

		return view
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		local Pos2D = base:TraceBTL().HitPos:ToScreen()

		base:PaintCrosshairCenter( Pos2D, COLOR_RED )
		base:PaintCrosshairOuter( Pos2D, color_white )
		base:LVSPaintHitMarker( Pos2D )
	end
	self:AddWeapon( weapon, 3 )





	local weapon = {}
	weapon.Icon = Material("lvs/weapons/laserbeam.png")
	weapon.Ammo = -1
	weapon.Delay = 0
	weapon.HeatRateUp = 0.345
	weapon.HeatRateDown = 0.1
	weapon.OnOverheat = function( ent )
		if ent:GetAI() then return end
		ent:EmitSound("lvs/overheat.wav")
	end
	weapon.OnSelect = function( ent )
		ent:EmitSound("physics/metal/weapon_impact_soft3.wav")
	end
	weapon.Attack = function( ent )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		if not base._CanUseBT then return end

		local trace = base:TraceBTL()

		base:BallturretDamage( trace.Entity, ent:GetDriver(), trace.HitPos, (trace.HitPos - ent:GetPos()):GetNormalized() )
	end
	weapon.StartAttack = function( ent )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		if not base._CanUseBT then return end

		base:SetBTLFire( true )

		if not IsValid( self.sndBTL ) then return end

		self.sndBTL:Play()
		self.sndBTL:EmitSound( "lvs/vehicles/laat/ballturret_fire.mp3", 110 )
	end
	weapon.FinishAttack = function( ent )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		base:SetBTLFire( false )

		if not IsValid( self.sndBTL ) then return end

		self.sndBTL:Stop()
	end
	weapon.OnThink = function( ent, active )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		base:SetPoseParameterBTL( ent )
		base:SetPosBTL()

		if not ent:GetAI() then return end

		local ID = base:LookupAttachment( "muzzle_ballturret_left" )
		local Muzzle = base:GetAttachment( ID )
		if not Muzzle then return end

		if ent:AngleBetweenNormal(Muzzle.Ang:Up(),ent:GetAimVector()) > 5 then
			ent:SetHeat( 1 )
			ent:SetOverheated( true )
		end
	end
	weapon.CalcView = function( ent, ply, pos, angles, fov, pod )
		local base = ent:GetVehicle()
		base.ZoomFov = 20

		local view = {}
		view.origin = pos
		view.angles = angles
		view.fov = fov
		view.drawviewer = false

		if not IsValid( base ) then return view end

		local ID = base:LookupAttachment( "muzzle_ballturret_left" )
		local Muzzle = base:GetAttachment( ID )

		if Muzzle then
			local Pos,Ang = LocalToWorld( Vector(0,25,-45), Angle(270,0,-90), Muzzle.Pos, Muzzle.Ang )

			view.origin = Pos
		end

		return view
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		local Pos2D = base:TraceBTL().HitPos:ToScreen()

		base:PaintCrosshairCenter( Pos2D, COLOR_RED )
		base:PaintCrosshairOuter( Pos2D, color_white )
		base:LVSPaintHitMarker( Pos2D )
	end
	self:AddWeapon( weapon, 3 )



	local weapon = {}
	weapon.Icon = Material("lvs/weapons/FLIR.png")		
	weapon.Delay = 1
	weapon.HeatRateUp = 1
	weapon.HeatRateDown = 1
	weapon.StartAttack = function( ent )
		local base = ent:GetVehicle()
		if base:GetBTLFLIR() == false then
            		-- enable FLIR view
			self.sndBTL:EmitSound( "lvs/vehicles/laat/nvg_on.wav", 100 )
			base:SetBTLFLIR( true )
		else
			-- revert to default view
			self.sndBTL:EmitSound( "lvs/vehicles/laat/nvg_off.wav", 100 )
			base:SetBTLFLIR( false )
		end
		
	end
	weapon.CalcView = function( ent, ply, pos, angles, fov, pod )
		local base = ent:GetVehicle()
		base.ZoomFov = 20

		local view = {}
		view.origin = pos
		view.angles = angles
		view.fov = fov
		view.drawviewer = false

		if not IsValid( base ) then return view end

		local ID = base:LookupAttachment( "muzzle_ballturret_left" )
		local Muzzle = base:GetAttachment( ID )

		if Muzzle then
			local Pos,Ang = LocalToWorld( Vector(0,25,-45), Angle(270,0,-90), Muzzle.Pos, Muzzle.Ang )

			view.origin = Pos
		end

		return view
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local base = ent:GetVehicle()
		if base:GetBTLFLIR() == true then
            		-- enable FLIR view
			hook.Add( "HUDPaintBackground", "FLIR1", function()
				local tab = {
					[ "$pp_colour_addr" ] 		= -.4,
					[ "$pp_colour_addg" ] 		= -.5,
					[ "$pp_colour_addb" ] 		= -.5,
					[ "$pp_colour_colour" ] 	= 0,
					[ "$pp_colour_mulr" ] 		= 0,
					[ "$pp_colour_mulg" ] 		= 0,
					[ "$pp_colour_mulb" ] 		= 0,
				}
				-- highlighting players, NPCs, and LVS vehicles
				hook.Add("PostDrawOpaqueRenderables", "Highlight1", function()
					if not LocalPlayer():Alive() then 
						hook.Remove("HUDPaintBackground", "FLIR1")
						hook.Remove("PostDrawOpaqueRenderables", "Highlight1")
						hook.Remove("PostDrawEffects", "HighlightEffects1")
						hook.Remove("RenderScreenspaceEffects", "Darken1")
						return
					end
					tab["$pp_colour_brightness"] = -0.1
					tab["$pp_colour_contrast"] = 1
					DrawColorModify(tab)

					render.SetStencilWriteMask( 0xFF )
					render.SetStencilTestMask( 0xFF )
					render.SetStencilReferenceValue( 0 )
					render.SetStencilCompareFunction( STENCIL_ALWAYS )
					render.SetStencilPassOperation( STENCIL_KEEP )
					render.SetStencilFailOperation( STENCIL_KEEP )
					render.SetStencilZFailOperation( STENCIL_KEEP )
					render.ClearStencil()

					render.SetStencilEnable(true)
					render.SetStencilCompareFunction( STENCIL_NEVER )
					render.SetStencilFailOperation( STENCIL_REPLACE )

					render.SetStencilReferenceValue( 1 )
					render.SetStencilWriteMask( 1 )
					for _, ent in pairs(ents.GetAll()) do
						if (ent:IsPlayer() and not ent:InVehicle()) or (ent:IsNPC()) or (ent.LVS)  then
							local tr = util.TraceLine( {
								start = LocalPlayer():EyePos(),
								endpos = ent:GetPos() + Vector(0,0,10),
								filter = LocalPlayer()
							} )

							if not tr.HitWorld then
								ent:DrawModel()
							end
						end
					end
					render.SetStencilTestMask(1)
					render.SetStencilReferenceValue( 1 )
					render.SetStencilCompareFunction( STENCIL_EQUAL )
					render.ClearBuffersObeyStencil( 255, 255, 255, 255, false )
	
					render.SetStencilEnable(false)
				end)
				-- highlighting effects
				hook.Add("PostDrawEffects", "HighlightEffects1", function()
					if not LocalPlayer():Alive() then 
						hook.Remove("HUDPaintBackground", "FLIR1")
						hook.Remove("PostDrawOpaqueRenderables", "Highlight1")
						hook.Remove("PostDrawEffects", "HighlightEffects1")
						hook.Remove("RenderScreenspaceEffects", "Darken1")
						return
					end
					tab["$pp_colour_brightness"] = 0.5
					--tab["$pp_colour_contrast"] = 1
					DrawColorModify(tab)

					render.SetStencilWriteMask( 0xFF )
					render.SetStencilTestMask( 0xFF )
					render.SetStencilReferenceValue( 0 )
					render.SetStencilCompareFunction( STENCIL_ALWAYS )
					render.SetStencilPassOperation( STENCIL_KEEP )
					render.SetStencilFailOperation( STENCIL_KEEP )
					render.SetStencilZFailOperation( STENCIL_KEEP )
					render.ClearStencil()

					render.SetStencilEnable(true)
					render.SetStencilCompareFunction( STENCIL_NEVER )
					render.SetStencilFailOperation( STENCIL_REPLACE )

					render.SetStencilReferenceValue( 1 )
					render.SetStencilWriteMask( 1 )
					for _, ent in pairs(ents.FindByClass("*")) do
						if string.find(ent:GetClass(), "effect") then
							local tr = util.TraceLine( {
								start = LocalPlayer():EyePos(),
								endpos = ent:GetPos() + Vector(0,0,10),
								filter = LocalPlayer()
							} )

							if not tr.HitWorld then
								ent:DrawModel()
							end
						end
					end
					render.SetStencilTestMask(1)
					render.SetStencilReferenceValue( 1 )
					render.SetStencilCompareFunction( STENCIL_EQUAL )
					render.ClearBuffersObeyStencil( 255, 255, 255, 255, false )
	
					render.SetStencilEnable(false)
				end)
				-- add bloom to highlighted objects
				hook.Add("RenderScreenspaceEffects", "Darken1", function()
					DrawBloom( 0, 1, 1, 11, 0, 0, 0, 0, 0 )
				end)
			end )
		else
			-- revert to default view
			hook.Remove("HUDPaintBackground", "FLIR1")
			hook.Remove("PostDrawOpaqueRenderables", "Highlight1")
			hook.Remove("PostDrawEffects", "HighlightEffects1")
			hook.Remove("RenderScreenspaceEffects", "Darken1")
		end
	end
	hook.Add( "LVS.PlayerLeaveVehicle", "LeavingWithFLIROn1", function( ply, veh )
		hook.Remove("HUDPaintBackground", "FLIR1")
		hook.Remove("PostDrawOpaqueRenderables", "Highlight1")
		hook.Remove("PostDrawEffects", "HighlightEffects1")
		hook.Remove("RenderScreenspaceEffects", "Darken1")
	end )
	hook.Add("EntityRemoved", "EntityRemovedFLIR1", function(ent)
		if ent == self then
			hook.Remove("HUDPaintBackground", "FLIR1")
			hook.Remove("PostDrawOpaqueRenderables", "Highlight1")
			hook.Remove("PostDrawEffects", "HighlightEffects1")
			hook.Remove("RenderScreenspaceEffects", "Darken1")
		end
	end)
	weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav") end
	self:AddWeapon( weapon, 3 )
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
