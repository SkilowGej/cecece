local LastKillMarker = 0
local LastHitMarker = 0
local LastCritMarker = 0

function HurtMarker( intensity )
	LocalPlayer():EmitSound( "lvs/hit_receive"..math.random(1,2)..".wav", 75, math.random(95,105), 0.25 + intensity * 0.75, CHAN_STATIC )
	util.ScreenShake( Vector(0, 0, 0), 25 * intensity, 25 * intensity, 0.5, 1 )
end

function KillMarker()
	LastKillMarker = CurTime() + 0.5

	LocalPlayer():EmitSound( "lvs/hit_kill.wav", 85, 100, 0.4, CHAN_VOICE )
end

function HitMarker()
	LastHitMarker = CurTime() + 0.15

	LocalPlayer():EmitSound( "lvs/hit.wav", 85, math.random(95,105), 0.4, CHAN_ITEM )
end

function CritMarker()
	LastCritMarker = CurTime() + 0.15

	LocalPlayer():EmitSound( "lvs/hit_crit.wav", 85, math.random(95,105), 0.4, CHAN_ITEM2 )
end

function GetHitMarker()
	return LastHitMarker or 0
end

function GetCritMarker()
	return LastCritMarker or 0
end

function GetKillMarker()
	return LastKillMarker or 0
end

hook.Add("ScalePlayerDamage", "Crosshair_ScalePlayerDamage", function(ply, hitgroup, dmginfo)
	if dmginfo:GetAttacker() == LocalPlayer() then
		if hitgroup == HITGROUP_HEAD then
			CritMarker()
		else
			HitMarker()
		end
	end
end)

local td = {}
hook.Add("HUDPaint", "Crosshair_HUDPaint", function()
	local FT, T, x, y = FrameTime(), CurTime(), ScrW(), ScrH()

	local lp = LocalPlayer()
	local scr = { x = x, y = y }

	if lp then
		td.start = lp:GetShootPos()
		td.endpos = td.start + (lp:EyeAngles() + lp:GetPunchAngle()):Forward() * 16384
		td.filter = lp

		tr = util.TraceLine(td)
		scr.x = tr.HitPos:ToScreen()
		scr.x, scr.y = scr.x.x, scr.x.y
	else
		scr.x, scr.y = math.Round(x * 0.5), math.Round(y * 0.5)
	end

	local aV = math.cos( math.rad( math.max(((GetHitMarker() - T) / 0.15) * 360,0) ) )
	if aV ~= 1 then
		local Start = 12 + (1 - aV) * 8
		local dst = 10

		surface.SetDrawColor( 255, 255, 0, 255 )

		surface.DrawLine( scr.x + Start, scr.y + Start, scr.x + Start, scr.y + Start - dst )
		surface.DrawLine( scr.x + Start, scr.y + Start, scr.x + Start - dst, scr.y + Start )

		surface.DrawLine( scr.x + Start, scr.y - Start, scr.x + Start, scr.y - Start + dst )
		surface.DrawLine( scr.x + Start, scr.y - Start, scr.x + Start - dst, scr.y - Start )

		surface.DrawLine( scr.x - Start, scr.y + Start, scr.x - Start, scr.y + Start - dst )
		surface.DrawLine( scr.x - Start, scr.y + Start, scr.x - Start + dst, scr.y + Start )

		surface.DrawLine( scr.x - Start, scr.y - Start, scr.x - Start, scr.y - Start + dst )
		surface.DrawLine( scr.x - Start, scr.y - Start, scr.x - Start + dst, scr.y - Start )

		scr.x = scr.x + 1
		scr.y = scr.y + 1

		surface.SetDrawColor( 0, 0, 0, 80 )

		surface.DrawLine( scr.x + Start, scr.y + Start, scr.x + Start, scr.y + Start - dst )
		surface.DrawLine( scr.x + Start, scr.y + Start, scr.x + Start - dst, scr.y + Start )

		surface.DrawLine( scr.x + Start, scr.y - Start, scr.x + Start, scr.y - Start + dst )
		surface.DrawLine( scr.x + Start, scr.y - Start, scr.x + Start - dst, scr.y - Start )

		surface.DrawLine( scr.x - Start, scr.y + Start, scr.x - Start, scr.y + Start - dst )
		surface.DrawLine( scr.x - Start, scr.y + Start, scr.x - Start + dst, scr.y + Start )

		surface.DrawLine( scr.x - Start, scr.y - Start, scr.x - Start, scr.y - Start + dst )
		surface.DrawLine( scr.x - Start, scr.y - Start, scr.x - Start + dst, scr.y - Start )
	end

	local aV = math.sin( math.rad( math.max(((GetCritMarker() - T) / 0.15) * 180,0) ) )
	if aV > 0.01 then
		local Start = 10 + aV * 40
		local End = 20 + aV * 45

		surface.SetDrawColor( 255, 100, 0, 255 )
		surface.DrawLine( scr.x + Start, scr.y + Start, scr.x + End, scr.y + End )
		surface.DrawLine( scr.x - Start, scr.y + Start, scr.x - End, scr.y + End ) 
		surface.DrawLine( scr.x + Start, scr.y - Start, scr.x + End, scr.y - End )
		surface.DrawLine( scr.x - Start, scr.y - Start, scr.x - End, scr.y - End ) 

		draw.NoTexture()
		surface.DrawTexturedRectRotated( scr.x + Start, scr.y + Start, 3, 20, 45 )
		surface.DrawTexturedRectRotated( scr.x - Start, scr.y + Start, 20, 3, 45 )
		surface.DrawTexturedRectRotated(  scr.x + Start, scr.y - Start, 20, 3, 45 )
		surface.DrawTexturedRectRotated( scr.x - Start, scr.y - Start, 3, 20, 45 )
	end

	local aV = math.sin( math.rad( math.sin( math.rad( math.max(((GetKillMarker() - T) / 0.2) * 90,0) ) ) * 90 ) )
	if aV > 0.01 then
		surface.SetDrawColor( 255, 255, 255, 15 * (aV ^ 4) )
		surface.DrawRect( 0, 0, ScrW(), ScrH() )

		local Start = 10 + aV * 40
		local End = 20 + aV * 45
		surface.SetDrawColor( 255, 0, 0, 255 )
		surface.DrawLine( scr.x + Start, scr.y + Start, scr.x + End, scr.y + End )
		surface.DrawLine( scr.x - Start, scr.y + Start, scr.x - End, scr.y + End ) 
		surface.DrawLine( scr.x + Start, scr.y - Start, scr.x + End, scr.y - End )
		surface.DrawLine( scr.x - Start, scr.y - Start, scr.x - End, scr.y - End ) 

		draw.NoTexture()
		surface.DrawTexturedRectRotated( scr.x + Start, scr.y + Start, 5, 20, 45 )
		surface.DrawTexturedRectRotated( scr.x - Start, scr.y + Start, 20, 5, 45 )
		surface.DrawTexturedRectRotated(  scr.x + Start, scr.y - Start, 20, 5, 45 )
		surface.DrawTexturedRectRotated( scr.x - Start, scr.y - Start, 5, 20, 45 )
	end

	local wep = lp:GetActiveWeapon()
	if IsValid(wep) then
		local wepclass = wep:GetClass() or ""
		if wepclass == "weapon_physgun" or wepclass == "gmod_tool" then
			draw.RoundedBox(4,x*0.5-3,y*0.5-3,6,6,Color(255,255,255,140))
		end
	end
end)