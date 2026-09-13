--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

function ENT:InitWeaponGunner2()	
	local COLOR_RED = Color(255,0,0,255)
	local COLOR_WHITE = Color(255,255,255,255)

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/hmg.png")
	weapon.Delay = 0.55
	weapon.HeatRateUp = 0.2
	weapon.HeatRateDown = 0.2	
	weapon.Attack = function( ent )
        	if not ent:GetVehicle() then return true end
		local pod = ent:GetDriverSeat()

		if not IsValid( pod ) then return end

		local dir = ent:GetAimVector()
		
		if ent:AngleBetweenNormal( dir, ent:GetForward() ) > 70 then return true end

		local trace = ent:GetEyeTrace()

		local veh = ent:GetVehicle()

		-- veh.SNDTail:PlayOnce( 60 + math.Rand(-3,3), 1 )
		
		local ID2 = self:LookupAttachment( "40mm" )
		local Muzzle2 = self:GetAttachment( ID2 )

		local bullet = {}
		bullet.Src = Muzzle2.Pos
		bullet.Dir = (trace.HitPos - bullet.Src):GetNormalized()	
		bullet.Spread 	= Vector( 0.0025,  0.0025, 0.0025 )
		bullet.TracerName = "lvs_laser_green"
		bullet.Force	= 30
		bullet.HullSize 	= 30
		bullet.Damage	= 300
		bullet.SplashDamage = 100
		bullet.SplashDamageRadius = 400
		bullet.Velocity = 10000
		bullet.Attacker 	= ent:GetDriver()
		bullet.Callback = function(att, tr, dmginfo)
			local effectdata = EffectData()
				effectdata:SetStart( Vector(-180,100,75) )
				effectdata:SetOrigin( tr.HitPos )
				effectdata:SetNormal( tr.HitNormal )
				-- util.Effect( "lvs_concussion_explosion", effectdata )
				util.Effect( "lvs_concussion_explosion_large", effectdata )
		end
		ent:LVSFireBullet( bullet )
		ent:EmitSound("lvs/vehicles/laat/fire_large.wav", 100 )
	end
	weapon.OnSelect = function( ent )
		ent:EmitSound("physics/metal/weapon_impact_soft3.wav")
	end
	weapon.OnOverheat = function( ent )
		ent:EmitSound("lvs/overheat.wav")
	end
	weapon.CalcView = function( ent, ply, pos, angles, fov, pod )
		local base = ent:GetVehicle()
		base.ZoomFov = 30

		if not IsValid( base ) then 
			return LVS:CalcView( ent, ply, pos, angles, fov, pod )
		end

		if pod:GetThirdPersonMode() then
			pos = pos + base:GetUp() * 100
		end

		return LVS:CalcView( base, ply, pos, angles, fov, pod )
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local Col = (ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > 70) and COLOR_RED or COLOR_WHITE

		local Pos2D = ent:GetEyeTrace().HitPos:ToScreen() 

		local base = ent:GetVehicle()

		base:LVSPaintHitMarker( Pos2D )

		if not ent:GetDriverSeat():GetThirdPersonMode() then
			local mat = Material( "hud/ac130/40mm.png" )
			surface.SetDrawColor( Col )
			surface.SetMaterial( mat ) 
			surface.DrawTexturedRectRotated( X - 962, Y -542, X , Y , 0 )
		else
			base:PaintCrosshairCenter( Pos2D, Col )
			base:PaintCrosshairOuter( Pos2D, Col )
		end

	end
	self:AddWeapon( weapon, 4 )



	local weapon = {}
	weapon.Icon = Material("lvs/weapons/FLIR.png")		
	weapon.Delay = 1
	weapon.HeatRateUp = 1
	weapon.HeatRateDown = 1
	weapon.StartAttack = function( ent )
		local base = ent:GetVehicle()
		if base:GetGunner2FLIR() == false then
			-- draw FLIR 
			ent:EmitSound( "lvs/vehicles/laat/nvg_on.wav", 100 )
			base:SetGunner2FLIR( true )
		else
			-- restore default view
			ent:EmitSound( "lvs/vehicles/laat/nvg_off.wav", 100 )
			base:SetGunner2FLIR( false )
		end
	end
	weapon.CalcView = function( ent, ply, pos, angles, fov, pod )
		local base = ent:GetVehicle()
		base.ZoomFov = 30

		if not IsValid( base ) then 
			return LVS:CalcView( ent, ply, pos, angles, fov, pod )
		end

		if pod:GetThirdPersonMode() then
			pos = pos + base:GetUp() * 100
		end

		return LVS:CalcView( base, ply, pos, angles, fov, pod )
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local base = ent:GetVehicle()
		if base:GetGunner2FLIR() == true then
            		-- enable FLIR view
			hook.Add( "HUDPaintBackground", "FLIR2", function()
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
				hook.Add("PostDrawOpaqueRenderables", "Highlight2", function()
					if not LocalPlayer():Alive() then 
						hook.Remove("HUDPaintBackground", "FLIR2")
						hook.Remove("PostDrawOpaqueRenderables", "Highlight2")
						hook.Remove("PostDrawEffects", "HighlightEffects2")
						hook.Remove("RenderScreenspaceEffects", "Darken2")
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
				hook.Add("PostDrawEffects", "HighlightEffects2", function()
					if not LocalPlayer():Alive() then 
						hook.Remove("HUDPaintBackground", "FLIR2")
						hook.Remove("PostDrawOpaqueRenderables", "Highlight2")
						hook.Remove("PostDrawEffects", "HighlightEffects2")
						hook.Remove("RenderScreenspaceEffects", "Darken2")
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
				hook.Add("RenderScreenspaceEffects", "Darken2", function()
					DrawBloom( 0, 1, 1, 11, 0, 0, 0, 0, 0 )
				end)
			end )
		else
			-- revert to default view
			hook.Remove("HUDPaintBackground", "FLIR2")
			hook.Remove("PostDrawOpaqueRenderables", "Highlight2")
			hook.Remove("PostDrawEffects", "HighlightEffects2")
			hook.Remove("RenderScreenspaceEffects", "Darken2")
		end
	end
	hook.Add( "LVS.PlayerLeaveVehicle", "LeavingWithFLIROn2", function( ply, veh )
		hook.Remove("HUDPaintBackground", "FLIR2")
		hook.Remove("PostDrawOpaqueRenderables", "Highlight2")
		hook.Remove("PostDrawEffects", "HighlightEffects2")
		hook.Remove("RenderScreenspaceEffects", "Darken2")
	end )
	hook.Add("EntityRemoved", "EntityRemovedFLIR2", function(ent)
		if ent == self then
			hook.Remove("HUDPaintBackground", "FLIR2")
			hook.Remove("PostDrawOpaqueRenderables", "Highlight2")
			hook.Remove("PostDrawEffects", "HighlightEffects2")
			hook.Remove("RenderScreenspaceEffects", "Darken2")
		end
	end)
	weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav") end
	self:AddWeapon( weapon, 4 )
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
