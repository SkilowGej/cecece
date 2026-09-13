--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if (SERVER) then
	AddCSLuaFile()
	AddCSLuaFile("shield_config.lua")
	-- FOR SHOW HITBOX OF SHIELD
	-- util.AddNetworkString("ShieldHitboxRender")
	include("shield_config.lua")
	include("shield_server.lua")
else
	include("shield_config.lua")
end


btShield.blocker = btShield.blocker or {}

local function rayQuadIntersect(vOrigin, vDirection, vPlane, vX, vY)
	local vp = vDirection:Cross(vY)

	local d = vX:DotProduct(vp)

	if (d <= 0.0) then return end

	local vt = vOrigin - vPlane
	local u = vt:DotProduct(vp)
	if (u < 0.0 or u > d) then return end

	local v = vDirection:DotProduct(vt:Cross(vX))
	if (v < 0.0 or v > d) then return end

	return u / d,v / d
end

if (CLIENT) then
	local meta = FindMetaTable("Player")

	function meta:hasBallisticShield()
		if not IsValid(self) then return false end
		return self:GetNWString("btShield.hasBali", false)
	  end

	function meta:getCurrentShield()
		return self:GetNWString("btShield.class"), self:GetNWEntity("btShield.weapon")
	end

	-- ALTERNATIVE CURRENTLY WORKING VARIANT FOR SHOW HITBOX OF SHIELD
	-- net.Receive("ShieldHitboxRender", function()
    --     local shieldOwner = net.ReadEntity()
    --     local pos = net.ReadVector()
    --     local ang = net.ReadAngle()

    --     if not btShield.shieldRenderData then btShield.shieldRenderData = {} end
    --     btShield.shieldRenderData[shieldOwner] = {pos = pos, ang = ang, time = CurTime()}
    -- end)

    -- hook.Add("PostDrawTranslucentRenderables", "RenderShieldHitboxes", function()
    --     if not LocalPlayer():IsAdmin() then return end

    --     local curTime = CurTime()
    --     for shieldOwner, data in pairs(btShield.shieldRenderData or {}) do
    --         if IsValid(shieldOwner) and curTime - data.time < 0.1 then
    --             local pos, ang = data.pos, data.ang
    --             local shieldWidth, shieldHeight = 80, 90

    --             cam.Start3D2D(pos, ang, 1)
    --             surface.SetDrawColor(255, 255, 255, 100)
    --             surface.DrawOutlinedRect(-shieldWidth/2, -shieldHeight/2, shieldWidth, shieldHeight)
    --             cam.End3D2D()

    --             render.DrawLine(pos, pos + ang:Forward() * 20, Color(255, 0, 0))
    --             render.DrawLine(pos, pos + ang:Right() * 20, Color(0, 255, 0))
    --             render.DrawLine(pos, pos + ang:Up() * 20, Color(0, 0, 255))
    --         end
    --     end
    -- end)
end

function btShield:addHook(a, b)
	hook.Add(a, "btShield_hook", b)
end

btShield:addHook("StartCommand", function(client, ucmd)
	if (client:hasBallisticShield() == true) then
		local curShield, weapon = client:getCurrentShield()
	end
end)

btShield:addHook("DoPlayerHasShield", function(client, weapon, curShield)
	local class = weapon:GetClass()

	if (IsValid(weapon)) then
		if (class != curShield[1]) then
			for k, v in ipairs(btShield.dualWield) do
				if (class == v) then
					return
				end
			end
		else
			return
		end
	end

	return !btShield.shieldList[class] and false
end)

if (CLIENT) then
	-- surface.CreateFont( "DisplayShield", {
	-- 	font = "Montserrat Bold",
	-- 	size = ScreenScale(10),
	-- 	extended = true,
	-- })

	-- surface.CreateFont( "DisplayShield2", {
	-- 	font = "Montserrat Bold",
	-- 	size = ScreenScale(8),
	-- 	extended = true,
	-- })

	btShield.clModels = btShield.clModels or {}

	btShield:addHook("Think", function()
		if (btShield.clModels) then
			for idx, entity in pairs(btShield.clModels) do
				if (!IsValid(entity)) then
					if (!IsValid(entity.ownerEntity)) then
						entity:Remove()
					end

					btShield.clModels[idx] = nil
				end
			end
		end
	end)

	btShield:addHook("DrawShield", function(client)
		-- ONLY_FOR_DEVELOPERS = (RealTime() % 1 < 0.5)
		if (IsValid(client) and client:hasBallisticShield()) then
			local curShield, weapon = client:getCurrentShield()
			if (!IsValid(weapon)) then return end

            if not LocalPlayer():ShouldDrawLocalPlayer() and client == LocalPlayer() then
                return
            end

			if (curShield and weapon:GetDTBool(0, false) != true) then
					local sInfo = btShield.shieldInfo[curShield]

                    local ang_r, ang_b = sInfo.render.ang, sInfo.block.ang
                    local pos_r, pos_b = sInfo.render.pos, sInfo.block.pos
                    local bone = sInfo.bone

                    if IsValid(client) and IsValid(client:GetActiveWeapon()) and table.KeyFromValue( btShield.dualWield, client:GetActiveWeapon():GetClass() ) ~= nil then
                        bone = 'ValveBiped.Bip01_Spine2'
                        ang_r = Angle(90,-90,-180)
                        pos_r = Vector(0,0,8)

                        ang_b = Angle(90,0,90)
                        pos_b = Angle(0,0,10)
                    end

					if (sInfo) then
						if (!IsValid(client.btShieldModel)) then
							client.btShieldModel = ClientsideModel(sInfo.model)
							client.btShieldModel:SetNoDraw(true)
							client.btShieldModel.ownerEntity = client
							table.insert(btShield.clModels, client.btShieldModel)
						else
							if (client.btShieldModel:GetModel() != sInfo.model) then
								client.btShieldModel:SetModel(sInfo.model)
							end

							local pos, ang = client:GetBonePosition(client:LookupBone(bone) or 1)
							if (!pos or !ang) then return end

							local tempAng = Angle(ang)
								ang:RotateAroundAxis(tempAng:Forward(), ang_r[1])
								ang:RotateAroundAxis(tempAng:Up(), ang_r[2])
								ang:RotateAroundAxis(tempAng:Right(), ang_r[3])
								pos = pos
								+ tempAng:Up() * pos_r[1]
								+ tempAng:Forward() * pos_r[2]
								+ tempAng:Right() * pos_r[3]
							tempAng = nil

							local weapon = client:GetActiveWeapon()
							if (!IsValid(weapon)) then return end

							if (LocalPlayer() == client and !client:ShouldDrawLocalPlayer() and btShield.shieldList[weapon:GetClass()] == curShield) then
							pos, ang = client:GetShootPos(), client:EyeAngles()

							local vel = client:GetVelocity():Length2D()
							local swayMeter = math.min(1, vel/client:GetWalkSpeed())

							local tempAng = Angle(ang)
								ang:RotateAroundAxis(tempAng:Forward(), sInfo.render.fang[1])
								ang:RotateAroundAxis(tempAng:Up(), sInfo.render.fang[2])
								ang:RotateAroundAxis(tempAng:Right(), sInfo.render.fang[3])

								pos = pos
								+ tempAng:Up() * sInfo.render.fpos[1] + tempAng:Up() * (math.sin(RealTime()*10) * .5 ) * swayMeter
								+ tempAng:Forward() * sInfo.render.fpos[2] + tempAng:Right() * (math.cos(RealTime()*5) * .5) * swayMeter
								+ tempAng:Right() * sInfo.render.fpos[3]
							tempAng = nil

							client.btShieldModel:SetRenderOrigin(pos)
							client.btShieldModel:SetRenderAngles(ang)
						else
							client.btShieldModel:SetRenderOrigin(pos)
							client.btShieldModel:SetRenderAngles(ang)
						end

						if (!client:GetNoDraw()) then
							client.btShieldModel:DrawModel()
						end

						btShield.blocker[client:EntIndex()] = client

							if LocalPlayer():IsAdmin() then
                            --print(table.KeyFromValue( btShield.dualWield, weapon:GetClass() ) ~= nil)

                        	-- print(client, weapon:GetClass(), table.GetKeys(btShield.shieldList)[weapon:GetClass()]  )
                            -- local bone = sInfo.bone
                            -- local pos2, ang2 = sInfo.block.pos, sInfo.block.ang

							-- local pos, ang = client:GetBonePosition(client:LookupBone(bone) or 1)
							-- local tempAng = Angle(ang)
							-- ang:RotateAroundAxis(tempAng:Forward(), ang_b[1])
							-- ang:RotateAroundAxis(tempAng:Up(), ang_b[2])
							-- ang:RotateAroundAxis(tempAng:Right(), ang_b[3])
							-- pos = pos
							-- + tempAng:Up() * pos_b[1]
							-- + tempAng:Forward() * pos_b[2]
							-- + tempAng:Right() * pos_b[3]
							-- tempAng = nil
							-- cam.Start3D2D(pos, ang, 1)
							-- draw.RoundedBox(0, -sInfo.block.sizex/2, -sInfo.block.sizey/2, sInfo.block.sizex, sInfo.block.sizey, color_white)
							-- cam.End3D2D()

							-- surface.SetDrawColor(255, 255, 255)
							-- render.DrawLine(pos, pos + ang:Forward() * 10, Color(255, 0, 0))
							-- render.DrawLine(pos, pos + ang:Right() * 10, Color(0, 255, 0))
							-- render.DrawLine(pos, pos + ang:Up() * 20, Color(0, 0, 255))
							end
					end
				end
			end
		end
	end)

	btShield:addHook("PreDrawTranslucentRenderables", function()
		local client = LocalPlayer()

		hook.Run("DrawShield", client)
	end)

	btShield:addHook("PostPlayerDraw", function(client)
		hook.Run("DrawShield", client)
	end)
end

hook.Add('PostEntityFireBullets', 'EntityFireBullets_Shields', function(ent, bulletData)
    local tr = bulletData["Trace"]
    local direction = (tr["HitPos"] - tr["StartPos"]):GetNormalized()

    local trace = util.TraceLine({
        start = tr["StartPos"],
        endpos = tr["HitPos"],
        filter = function(ent)
            return ent:GetClass() == 'shield_circle'
        end
    })

    if hook.GetTable()['PostEntityFireBullets']['btShield_hook'](ent, bulletData, bulletData["Attacker"]) then
        return false
    end

    if trace.Hit and not trace.Entity:IsWorld() then
        local dist = trace.HitPos:Distance(tr["StartPos"])
        bulletData["Distance"] = 0
        bulletData["Damage"] = 0
        bulletData["Force"] = 0
    end

    return true
end)

btShield:addHook("PostEntityFireBullets", function(entity, bulletTable, attacker)
    local trace = bulletTable["Trace"]
    
    if (btShield.blocker) then
        if (!IsFirstTimePredicted()) then return end

        for _, client in pairs(btShield.blocker) do
            if (client:hasBallisticShield() != true) then continue end
            local curShield, weapon = client:getCurrentShield()
            if (!IsValid(weapon)) then continue end
            if (weapon:GetDTBool(0) == true) then continue end

            if client ~= bulletTable["Attacker"] then
                local sInfo = btShield.shieldInfo[curShield]
                if (!sInfo) then continue end

                local ang_r, ang_b = sInfo.render.ang, sInfo.block.ang
                local pos_r, pos_b = sInfo.block.pos, sInfo.block.pos
                local bone = sInfo.bone

                if IsValid(client) and IsValid(client:GetActiveWeapon()) and table.KeyFromValue(btShield.dualWield, client:GetActiveWeapon():GetClass()) ~= nil then
                    bone = 'ValveBiped.Bip01_Spine2'
                    ang_r = Angle(90, -90, 0)
                    pos_r = Vector(0, 40, 0)
                    ang_b = Angle(90, 0, 90)
                    pos_b = Angle(0, 0, 10)
                end

                local pos, ang = client:GetBonePosition(client:LookupBone(bone) or 1)
                if (!pos or !ang) then continue end

                local tempAng = Angle(ang)
                ang:RotateAroundAxis(tempAng:Forward(), ang_b[1])
                ang:RotateAroundAxis(tempAng:Up(), ang_b[2])
                ang:RotateAroundAxis(tempAng:Right(), ang_b[3])
                
                ang:RotateAroundAxis(ang:Up(), -10)
                ang:RotateAroundAxis(ang:Right(), 10)
                
                pos = pos + tempAng:Up() * pos_b[1] + tempAng:Forward() * pos_b[2] + tempAng:Right() * pos_b[3]

                local horizontalShift = 50
                pos = pos + ang:Right() / horizontalShift

                local direction
                if trace and trace["HitPos"] and trace["StartPos"] then
                    direction = (trace["HitPos"] - trace["StartPos"]):GetNormalized()
                else
                    continue
                end

                if direction then
                    local shieldForward = ang:Forward()
                    local shieldRight = ang:Right()
                    local shieldUp = ang:Up()
                    local dotProduct = shieldForward:Dot(direction)
                    local sideDotProduct = shieldRight:Dot(direction)
                    local verticalDotProduct = shieldUp:Dot(direction)
                    
                    local forwardThreshold = -0.2
                    local secondForwardThreshold = 0.6
                    local sideThreshold = 0.6
                    
                    if dotProduct > forwardThreshold and dotProduct < secondForwardThreshold and math.abs(sideDotProduct) < sideThreshold then
                        local shieldWidth = 80
                        local shieldHeight = 90

                        local topLeft = pos + shieldUp * (shieldHeight / 2) - shieldRight * (shieldWidth / 2)
                        local topRight = pos + shieldUp * (shieldHeight / 2) + shieldRight * (shieldWidth / 2)
                        local bottomLeft = pos - shieldUp * (shieldHeight / 2) - shieldRight * (shieldWidth / 2)
                        local bottomRight = pos - shieldUp * (shieldHeight / 2) + shieldRight * (shieldWidth / 2)

                        local hitPos = util.IntersectRayWithPlane(trace["StartPos"], direction, pos, shieldForward)

						-- FOR SHOW HITBOX OF SHIELD
						-- net.Start("ShieldHitboxRender")
						-- net.WriteEntity(client)
						-- net.WriteVector(pos)
						-- net.WriteAngle(ang)
						-- net.Send(client)
                        
                        if hitPos then
                            local localHit = WorldToLocal(hitPos, Angle(0,0,0), pos, ang)
                            
                            local margin = 20
                            if math.abs(localHit.y) <= (shieldWidth / 2) + margin and math.abs(localHit.z) <= (shieldHeight / 2) + margin then
                                local distanceFromCenter = math.sqrt(localHit.y^2 + localHit.z^2)
                                local maxDistance = math.sqrt((shieldWidth/2)^2 + (shieldHeight/2)^2)
                                local hitPercentage = (distanceFromCenter / maxDistance) * 100

                                if hitPercentage < 100 then
                                    hook.Run("OnBlockBullet", client, sInfo, hitPos, bulletTable)

                                    bulletTable["Damage"] = 0
                                    bulletTable["Force"] = 0
                                    bulletTable.Callback = function() return true end

                                    local effectdata = EffectData()
                                    effectdata:SetOrigin(hitPos)
                                    effectdata:SetNormal(-direction)
                                    util.Effect("MetalSpark", effectdata)

                                    client:EmitSound(btShield.blockSound[math.random(1, #btShield.blockSound)], 75, 100, 1, CHAN_AUTO, 0, 0)

                                    return true
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return false
end)

btShield:addHook("OnBlockBullet", function(client, info, hitPos, bulletTable)
    local curShield, weapon = client:getCurrentShield()

    if (SERVER) then
        if (!SUPRESS_SHIELD_DAMAGE) then
            weapon:SetDTInt(0, math.max(0, weapon:GetDTInt(0, info.game.health) - (bulletTable["Damage"] == 0 and 5 or bulletTable["Damage"])))
        end
    end

    if (weapon:GetDTBool(0) != true and weapon:GetDTInt(0, info.game.health) <= 0) then
        weapon.nextHeal = weapon.nextHeal or CurTime()
        weapon.nextHeal = CurTime() + info.game.brokenRegenDelay
        weapon:SetDTBool(0, true)

        local effectdata = EffectData()
        effectdata:SetOrigin(hitPos)
        effectdata:SetNormal(-bulletTable["Trace"].Normal)
        effectdata:SetMagnitude(1)
        effectdata:SetScale(1)
        effectdata:SetRadius(1)
        util.Effect("cball_explode", effectdata)
    else
        weapon.nextHeal = weapon.nextHeal or CurTime()
        weapon.nextHeal = CurTime() + info.game.regenDelay
    end

    local effectdata = EffectData()
    effectdata:SetOrigin(hitPos)
    effectdata:SetNormal(-bulletTable["Trace"].Normal)
    effectdata:SetMagnitude(1)
    effectdata:SetScale(1)
    effectdata:SetRadius(1)
    util.Effect("MetalSpark", effectdata)

    weapon:EmitSound(btShield.blockSound[math.random(1, #btShield.blockSound)], 75, 100, 1, CHAN_AUTO, 0, 0)
end)


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
