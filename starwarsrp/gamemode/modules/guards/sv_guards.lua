function pMeta:Arrest(time, pPlayer)
	if not self:GetNetVar("Arrested") then
		time = time or 300
		self:StripWeapons()
		self:StripAmmo()
		self:SetPos(table.Random(JAIL_VECTORS))
		self:SetNetVar("Arrested", true, NETWORK_PROTOCOL_PUBLIC)
		self:SetNetVar("ArrestedTime", CurTime() + time, NETWORK_PROTOCOL_PUBLIC)
		re.util.NotifyAll("red", pPlayer:Name() .. " aresztował " .. self:Name() .. " na " .. time .. "sek.")

		timer.Create("Arrested_" .. self:SteamID64(), time, 1, function()
			if IsValid(self) then
				self:UnArrest()
			end
		end)
	end
end

function pMeta:UnArrest(pPlayer)
	self:SetNetVar("Arrested", false, NETWORK_PROTOCOL_PUBLIC)
	self:Spawn()
	hook.Call("PlayerLoadout", GAMEMODE, self)
	timer.Remove("Arrested_" .. self:SteamID64())
end

netstream.Hook("ArrestPlayer", function(pPlayer, data)
	if not pPlayer:HasWeapon("arrest_baton") then return end
	data.pTarget:Arrest(data.time, pPlayer)
end)

-- GetGlobalString("defcon")
if not GetGlobalString("defcon") then
	SetGlobalString("defcon", "")
end

-- plogs.Register("Defcons", false)
re.defcon_cooldown = re.defcon_cooldown or true

netstream.Hook("SendCommandDefcon", function(pPlayer, data)
	local name = data.name
	timer.Remove("DefconTimer")

	if not pPlayer:IsAdmin() then
		pPlayer:ChatPrint("You must be an admin to change the DEFCON status.")
		return
	end

	if TEAMS_CANUSE_DEFCONS[pPlayer:Team()] and DEFCON_TYPES[name] and re.defcon_cooldown then
		-- plogs.PlayerLog(pPlayer, "Defcons", pPlayer:NameID() .. " активировал defcon \"" .. name .. "\"", {
		-- 	["Name"] = pPlayer:Name(),
		-- 	["SteamID"] = pPlayer:SteamID(),
		-- })

		SetGlobalString("defcon", name)

		if DEFCON_TYPES[name].sound then
			BroadcastLua("surface.PlaySound(\"" .. DEFCON_TYPES[name].sound .. "\")")
		end

		re.defcon_cooldown = false

		timer.Create("DefconCooldown", 30, 1, function()
			re.defcon_cooldown = true
		end)

		if name == "6" then
			timer.Create("DefconTimer", 1, 1, function()
				SetGlobalString("defcon", "")
			end)
		end
	end
end)

hook.Add("PlayerShouldTakeDamage", "AntiTeamkill", function(ply, attacker)
	if IsValid(ply) and ply:IsPlayer() and not ply:IsBot() then
		if not IsValid(attacker) or not isfunction(attacker.GetActiveWeapon) then return end
		local wep = attacker:GetActiveWeapon()

		if wep and IsValid(wep) and wep.SWBWeapon and wep.FireMode and wep.FireMode == "stun" then
			local timer_name = "Stun_Timer" .. ply:UniqueID()
			ply:SetNWInt("LastStun", CurTime())
			ply:AddFlags(FL_FROZEN)

			if ply.lastTimer then
				timer.Remove(ply.lastTimer)
			end

			ply.lastTimer = timer_name

			timer.Create(timer_name, 8, 0, function()
				if ply and IsValid(ply) then
					ply:RemoveFlags(FL_FROZEN)
				end
			end)

			return false
		end
	end
end)