--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--This is a global version of the Garry's Mod Taunt Camera function, intended to work on any gamemode.
--I TAKE NO CREDIT FOR THIS, SO DON'T TRY AND BULLSHIT ANYTHING

wOS = wOS or {}
wOS.Fortnite = wOS.Fortnite or {}

function wOS.Fortnite:CreateTauntCamera( endless )

	local CAM = {}

	local WasOn					= false

	local CustomAngles			= Angle( 0, 0, 0 )
	local PlayerLockAngles		= nil

	local InLerp				= 0
	local OutLerp				= 1

	CAM.Remove = function( self )
		self = nil
		return
	end
	
	CAM.ShouldDrawLocalPlayer = function( self, ply, on )

		return on || OutLerp < 1

	end

	CAM.CalcView = function( self, view, ply, on )

		if ( !ply:Alive() || !IsValid( ply:GetViewEntity() ) || ply:GetViewEntity() != ply ) then on = false end

		if ( WasOn != on ) then

			if ( on ) then InLerp = 0 end
			if ( !on ) then OutLerp = 0 end

			WasOn = on

		end

		if ( !on && OutLerp >= 1 ) then

			CustomAngles = view.angles * 1
			PlayerLockAngles = nil
			InLerp = 0
			return

		end

		if ( PlayerLockAngles == nil ) then return end

		local TargetOrigin = view.origin - CustomAngles:Forward() * 100
		local tr = util.TraceHull( { start = view.origin, endpos = TargetOrigin, mask = MASK_SHOT, filter = player.GetAll(), mins = Vector( -8, -8, -8 ), maxs = Vector( 8, 8, 8 ) } )
		TargetOrigin = tr.HitPos + tr.HitNormal
		view.drawviewer = self:ShouldDrawLocalPlayer( ply, on )

		if ( InLerp < 1 ) then

			InLerp = InLerp + FrameTime() * 5.0
			view.origin = LerpVector( InLerp, view.origin, TargetOrigin )
			view.angles = LerpAngle( InLerp, PlayerLockAngles, CustomAngles )
			return view

		end

		if ( OutLerp < 1 ) then

			OutLerp = OutLerp + FrameTime() * 3.0
			view.origin = LerpVector( 1-OutLerp, view.origin, TargetOrigin )
			view.angles = LerpAngle( 1-OutLerp, PlayerLockAngles, CustomAngles )
			return view

		end

		view.angles = CustomAngles * 1
		view.origin = TargetOrigin
		return view

	end

	CAM.CreateMove = function( self, cmd, ply, on )
	
		if ( !ply:Alive() ) then on = false end
		if ( !on ) then return end

		--Added check for endless taunts
		if ( endless and cmd:KeyDown( IN_JUMP ) ) then
			self:Remove()
			wOS.Fortnite.TauntCamera = nil
			net.Start( "wOS.Fortnite.CancelEmote" )
			net.SendToServer()
		end

		
		if ( PlayerLockAngles == nil ) then
			PlayerLockAngles = cmd:GetViewAngles()
		end
	
		CustomAngles.pitch	= CustomAngles.pitch	+ cmd:GetMouseY() * 0.01
		CustomAngles.yaw	= CustomAngles.yaw		- cmd:GetMouseX() * 0.01

		cmd:SetViewAngles( PlayerLockAngles )
		cmd:ClearButtons()
		cmd:ClearMovement()

		return true

	end

	return CAM

end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
