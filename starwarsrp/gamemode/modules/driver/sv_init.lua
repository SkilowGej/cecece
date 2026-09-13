netstream.Hook("Driver_ReturnVehicle", function(pPlayer, data)
	-- local t, f = pPlayer:Team(), pPlayer:GetNetVar("features")
	-- if not (f and (f["land"] or f["air"])) then return end
	local class = data.class

	-- for k, e in pairs(ents.FindByClass(class)) do
	-- 	if e.VehicleSalesPlayer == pPlayer then
	-- 		e:Remove()
	-- 	end
	-- end

	if IsValid( pPlayer.currentVeh ) then
		pPlayer.currentVeh:Remove()
	end

	if game.GetMap() ~= DEFAULT_MAP then
		GMap.Vehicles[class] = GMap.Vehicles[class] + 1
		net.Start( 'Tickets:Sync' )
			net.WriteTable( GMap.Vehicles )
		net.Broadcast()
	end
end)

netstream.Hook("Driver_BuyVehicle", function(pPlayer, data)
	-- local t, f = pPlayer:Team(), pPlayer:GetNetVar("features")
	-- if not (f and (f["land"] or f["air"])) then return end
	local class = data.class
	local vehicle = false
	local trace = pPlayer:GetEyeTrace()
	local target = trace.Entity
	if target:GetClass() ~= "npc_driver" then return end
	local features = pPlayer:GetNetVar("features")

	for feature, data in pairs(VEHICLES_FEATURES) do
		for cl, veh in pairs(data) do
			if cl == class then
				if features[feature] then
					vehicle = veh
				else
					re.util.Notify("red", pPlayer, "Ten sprzęt nie jest dla Ciebie dostępna.")
					-- break

					return
				end

				break
			end
		end
	end

	if game.GetMap() == DEFAULT_MAP then
		if vehicle and pPlayer:GetMoney() >= vehicle.price then
			local tbl = pPlayer:GetNetVar("vehicles")
			tbl = istable and tbl or util.JSONToTable(tbl)
			tbl[class] = true
			pPlayer:SavePlayerData("vehicles", util.TableToJSON(tbl), false)
			pPlayer:SetNetVar("vehicles", tbl, NETWORK_PROTOCOL_PUBLIC)
			pPlayer:PS_TakePoints(vehicle.price)
		else
			re.util.Notify("red", pPlayer, "Nie masz wystarczająco pieniędzy.")
		end
	else
		if not GMap.Vehicles[vehicle] or GMap.Vehicles[vehicle] <= 0 then
			re.util.Notify("red", pPlayer, "Ten sprzęt jest niedostępna w magazynie.")
			return
		end

		GMap.Vehicles[vehicle] = GMap.Vehicles[vehicle] - 1
		net.Start( 'Tickets:Sync' )
			net.WriteTable( GMap.Vehicles )
		net.Broadcast()
	end
end)

netstream.Hook("Driver_SpawnVehicle", function(pPlayer, data)
	-- print(pPlayer, data)
	-- local t, f = pPlayer:Team(), pPlayer:GetNetVar("features")
	-- if not (f and (f["land"] or f["air"])) then return end
	local vehicle_class = data.class
	local point = data.point
	local tbl = pPlayer:GetNetVar("vehicles")
	local trace = pPlayer:GetEyeTrace()
	local target = trace.Entity
	if target:GetClass() ~= "npc_driver" then return end
	local duble_spawn = true

	for _, ent in pairs(ents.GetAll()) do
		if ent:GetNWEntity("VehicleSalesPlayer") == pPlayer then
			duble_spawn = false
			break
		end
	end

	if not duble_spawn then
		re.util.Notify("red", pPlayer, "Masz już pojazd.")

		return
	end

	local vehicle = false

	for feature, data in pairs(VEHICLES_FEATURES) do
		for class, veh in pairs(data) do
			if vehicle_class == class then
				vehicle = veh
				break
			end
		end
	end

	local VEHICLES_SPAWNPOINT = VEHICLES_SPAWNPOINT
	local ent_spawns = ents.FindByClass("vehicles_spawn")

	if #ent_spawns ~= 0 then
		VEHICLES_SPAWNPOINT = {}

		for _, e in ipairs(ent_spawns) do
			table.insert(VEHICLES_SPAWNPOINT, e:GetPos())
		end
	end

	if tbl[vehicle_class] or (vehicle and vehicle.price == 0) then

		if not game.GetMap() == DEFAULT_MAP then
			if not GMap.Vehicles[vehicle_class] or GMap.Vehicles[vehicle_class] <= 0 then
				re.util.Notify("red", pPlayer, "Ten sprzęt jest niedostępna w magazynie.")
				return
			end
		end

		local veh = ents.Create(vehicle_class)
		veh:Spawn()

		-- veh:Activate()
		if VEHICLES_SPAWNPOINT then
			veh:SetPos(VEHICLES_SPAWNPOINT[point] and VEHICLES_SPAWNPOINT[point] or table.Random(VEHICLES_SPAWNPOINT))
		end

		veh.VehicleSalesPlayer = pPlayer
		veh:SetNWEntity("VehicleSalesPlayer", pPlayer)
		pPlayer.currentVeh = veh
		
		if not game.GetMap() == DEFAULT_MAP then
			GMap.Vehicles[vehicle_class] = GMap.Vehicles[vehicle_class] - 1
			net.Start( 'Tickets:Sync' )
				net.WriteTable( GMap.Vehicles )
			net.Broadcast()
		end
	end
end)