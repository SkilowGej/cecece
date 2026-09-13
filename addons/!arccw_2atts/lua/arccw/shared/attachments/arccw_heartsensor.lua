--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "Heartbeat Sensor"
att.Icon = Material("entities/arccw_heartsensor.png")
att.Description = "Sensor that is able to track targets through walls. It's somewhat bulky, but makes for a good scouting tool."
att.Desc_Pros = {
    "Displays people close to you"
}
att.Desc_Cons = {
    "Slow refresh rate"
}
att.Slot = "charm"

att.Model = "models/weapons/arccw/atts/heartsensor.mdl"
att.ModelScale = Vector(1, 1, 1)
att.ModelOffset = Vector(0, -2.25, 0)

att.Mult_SightTime = 1.2
att.Mult_ReloadTime = 1.1
att.Mult_ReloadTime = 1.1
att.Mult_SpeedMult = 0.9
att.IgnorePickX = false
att.AutoStats = true
att.Free = false


local sensorFade = 0

hook.Add("OnEntityCreated", "ArcCW_HeartbeatNPCs", function(ent)
	if !ArcCW.sensorNPCs then return end
    if !ent:IsValid() then return end

    if ent:IsNPC() or ent:IsNextBot() then
        ArcCW.sensorNPCs[#ArcCW.sensorNPCs + 1] = ent
	end

end)

hook.Add("EntityRemoved", "ArcCW_HeartbeatNPCs", function(ent)
	if !ArcCW.sensorNPCs then return end

    if ent:IsNPC() or ent:IsNextBot() then
        table.RemoveByValue(ArcCW.sensorNPCs, ent)
    end
end)


if CLIENT then
	ArcCW.sensorNPCs = ArcCW.sensorNPCs or {}
	local mainScreen = Material("models/arccw/mw2/mw2_sensor_screen_2")
	local sensorScreen = Material("models/arccw/mw2/mw2_sensor_screen_1")
	local sensorDot = Material("models/arccw/mw2/sensordot.png", "ignorez")
	local RTTexture = GetRenderTarget("ArcCWHeartSensor", 512, 512)
	local spotsound = false
	local sx, sy = 250, 326
	local colorNPC = Color(255, 0, 50, 255)
	local colorFriendly = Color(50, 175, 50, 255)
	local colorNeutral = Color(200, 175, 50, 255)
	local colorHostile = Color(200, 50, 50, 255)
	
	local function DrawSensor(v, plypos, updatepos)
		if IsValid(v) then
			if !v.ArcCW_SensorPos or updatepos then
				local pos = v:GetPos()
				local dist = pos:DistToSqr(plypos)
				if dist < 320000 then
					v.ArcCW_SensorPos = pos
				else
					v.ArcCW_SensorPos = vector_origin
				end
			end
			local pos = v.ArcCW_SensorPos
			if pos != vector_origin then
				pos.z = plypos.z
				
				pos = ( pos - plypos )*0.33
				pos:Rotate( Angle( 0, -LocalPlayer():EyeAngles().y+90, 0 ) )
				pos.y = -pos.y * 2 + ( (sy+25) * 0.78 )
				pos.x = pos.x + ( sx * 0.5 )
				
				if pos.x > 5 and pos.x < sx+25 and pos.y < sy and pos.y > -100 then
					local class = v:GetClass()
					colorNPC = (IsFriendEntityName(class) and colorFriendly) or (IsEnemyEntityName(class) and colorHostile) or colorNeutral
					colorNPC.a = sensorFade
					surface.SetDrawColor( colorNPC )
					surface.DrawTexturedRect( pos.x - 16, math.max(-32, pos.y - 16), 64, 128 )
					if !spotsound and updatepos and colorNPC != colorFriendly then
						LocalPlayer():EmitSound("arccw/heartsensor_spot.wav", 40, 100 + math.random(-2, 2))
						spotsound = true
					end
				end
			end
		end
	end
	
	att.DrawFunc = function(wep, element, wm)
		if wm then return end
		local sframe = mainScreen:GetInt("$frame")
		sensorScreen:SetTexture("$basetexture", RTTexture)
		render.PushRenderTarget( RTTexture, 0, 0, RTTexture:Width(), RTTexture:Height() )
		cam.Start2D()
		local ply = LocalPlayer()
		local plypos = ply:GetPos()
		local updatepos = sframe < 12 and sframe > 4
		
		local sensorNPCs = ArcCW.sensorNPCs

		if updatepos then
			sensorFade = 255
		else
			sensorFade = sensorFade-(50*FrameTime())
			spotsound = false
		end
		
		render.Clear(0,0,0,0)
		surface.SetMaterial(sensorDot)
		
		for k,v in ipairs(sensorNPCs) do
			DrawSensor(v, plypos, updatepos)
		end
		
		if !game.SinglePlayer() then
			surface.SetDrawColor( 200, 175, 50, sensorFade )
			
			for k,v in ipairs(player.GetAll()) do --not efficient, im lazy :[
				if v != ply and v:Alive() then
					if !v.ArcticMedShots_ActiveEffects or !v.ArcticMedShots_ActiveEffects["coldblooded"] then
						DrawSensor(v, plypos, updatepos)
					end
				end
			end
		end
		
		cam.End2D()
		render.PopRenderTarget()
	end

end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
