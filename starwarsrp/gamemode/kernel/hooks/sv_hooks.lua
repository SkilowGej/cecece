function GM:Initialize()
	re.config = {}
end

function GM:PlayerInitialSpawn(ply)
	ply:SetTeam(DEFAULT_TEAM)

	ply:RequestCharacters(function(characters, player_data)
		ply.Characters = characters
		netstream.Start(ply, "OpenCharacterMenu", characters)
	end)
end

function GM:PlayerSpawn(ply, transiton)
    player_manager.SetPlayerClass(ply, "rc_player")
    player_manager.OnPlayerSpawn(ply, transiton)
    player_manager.RunClass(ply, "Spawn")

	ply.Initialized = true

	local team = re.jobs[ply:Team()] or {}

	if team.PlayerSpawn then
		team.PlayerSpawn(ply)
	end

	gamemode.Call("PlayerSetModel", ply)
    gamemode.Call("PlayerLoadout", ply)
end

function GM:PlayerSetHandsModel(ply, hands)
    local simplemodel = player_manager.TranslateToPlayerModelName(ply:GetModel())

    local info = player_manager.TranslatePlayerHands(simplemodel)

    if info then
        hands:SetModel(info.model)
        hands:SetSkin(info.skin)
        hands:SetBodyGroups(info.body)
    end

    return
end

function GM:PlayerSetModel(ply)
	local team = re.jobs[ply:Team()]

	if ply:GetNetVar('model') then
		ply:SetModel(ply:GetNetVar('model'))
	else
		if istable(team.WorldModel) then
			ply:SetModel(team.WorldModel[math.random(1, #team.WorldModel)])
		else
			ply:SetModel(team.WorldModel)
		end
	end

    ply:SetupHands()

    hook.Run("PlayerSetHandsModel", ply, ply:GetHands())
end

local curent_map = game.GetMap()
local spawn_positions = {}

function pMeta:SetMaxArmor(int)
	self:SetNetVar('maxArmor', int or 255, NETWORK_PROTOCOL_PUBLIC)
end

util.AddNetworkString('Player_SetCustomCollisionCheck')

function GM:PlayerLoadout(ply)
	local team = re.jobs[ply:Team()]
	if not team then return end

	ply:SetMaxHealth(team.maxHealth or 100)
	ply:SetHealth(team.maxHealth or 100)
	ply:SetArmor(team.maxArmor or 255)
	ply:SetNetVar('maxArmor', team.maxArmor or 255, NETWORK_PROTOCOL_PUBLIC)
	ply:SetNetVar('maxHealth', team.maxHealth or 100, NETWORK_PROTOCOL_PUBLIC)
	ply:ShouldDropWeapon(false)

	if ply:FlashlightIsOn() then
		ply:Flashlight(false)
	end

	if team.PlayerLoadout then
		timer.Simple(0.1, function()
			team.PlayerLoadout(ply)
		end)
	end

	ply:AddEFlags(EFL_NO_DAMAGE_FORCES)
	ply:SetCollisionGroup(COLLISION_GROUP_PLAYER)
	ply:SetMaterial("")
	ply:SetMoveType(MOVETYPE_WALK)
	ply:Extinguish()
	ply:UnSpectate()
	ply:GodDisable()
	ply:ConCommand("-duck")
	ply:SetColor(Color(255, 255, 255, 255))
	ply:SetupHands()
	ply:AllowFlashlight(ply:IsUserGroup('user') or team.flashlight or false)
	ply:SetModelScale(1)

	local rating = ply:GetNetVar('rating')
	local feature_weapons = {}

	if rating then
		feature_weapons = (team.FeatureRatings and team.FeatureRatings[rating].weapons) and team.FeatureRatings[rating].weapons or {}
	end

	for _, wep in pairs(feature_weapons) do
		ply:Give(wep)
	end

	ply:SetNoTarget(team.notarget and team.notarget or false)

	for _, wep in pairs(team.weapons) do
		ply:Give(wep)
	end

	ply:Give('weapon_hands')
	ply:SelectWeapon('weapon_hands')
	ply:SetPlayerColor(Vector(1, 1, 1))

	ply:SetCrouchedWalkSpeed(0.5)
	ply:SetWalkSpeed(DEFAULT_PLAYER_STATS['WalkSpeed'])
	ply:SetJumpPower(DEFAULT_PLAYER_STATS['JumpPower'])
	ply:SetRunSpeed(DEFAULT_PLAYER_STATS['RunSpeed'])
	ply:SetCustomCollisionCheck(true)

	net.Start('Player_SetCustomCollisionCheck')
	net.WriteEntity(ply)
	net.Broadcast()

	if GROUPS_HAS_TOOLS[ply:GetUserGroup()] then
		for _, w in pairs(GROUP_TOOLS) do
			ply:Give(w)
		end
	end

	-- Prevent default Loadout.
	hook.Run("PostPlayerLoadout", player)

	return true
end

function GM:GetFallDamage(ply, flFallSpeed)
	local t = ply:Team()
	if t == TEAM_CONNECTING or t == TEAM_SPECTATOR or t == TEAM_UNASSIGNED then return 0 end
	local features = ply:GetNetVar('features')
	if features and features['desu'] then return 0 end

	return flFallSpeed / 10
end

function GM:PlayerSpawnSWEP(ply, class, info)
	return ply:IsAdmin() or ply:IsUserGroup("commander")
end

function GM:PlayerGiveSWEP(ply, class, info)
	return ply:IsAdmin() or ply:IsUserGroup("commander")
end

function GM:PlayerSpawnEffect(ply, model)
	return ply:IsAdmin() or ply:IsUserGroup("commander")
end

function GM:PlayerSpawnVehicle(ply, model, class, info)
	return ply:IsAdmin()
end

function GM:PlayerSpawnedVehicle(ply, ent)
	return ply:IsAdmin()
end

function GM:PlayerSpawnNPC(ply, type, weapon)
	return ply:IsAdmin() or ply:IsUserGroup("commander")
end

function GM:PlayerSpawnedNPC(ply, ent)
	return ply:IsAdmin() or ply:IsUserGroup("commander")
end

function GM:PlayerSpawnRagdoll(ply, model)
	return ply:IsAdmin()
end

function GM:PlayerSpawnedRagdoll(ply, model, ent)
	return ply:IsAdmin()
end

function GM:PlayerSpawnSENT(ply, class)
	return ply:IsAdmin() or ply:IsUserGroup("commander")
end

function GM:PlayerSpawnProp(ply, model)
	return ply:IsAdmin() or ply:IsUserGroup("commander")
end

function GM:CanPlayerEnterVehicle(ply, vehicle, role)
	local job = re.jobs[ply:Team()]
	if job and job.candrive then return true end
	local vehicles = VEHICLES_TYPES
	local features = ply:GetNetVar('features') or {}
	local base = vehicle:GetParent()

	if isfunction(base.GetDriverSeat) and base:GetDriverSeat() == vehicle then
		if features["air_land"] or features["admin_class"] or features["jedi_class1"] or features["jedi_class2"] or features["jedi_class3"] or features["jedi_class4"] or features["jedi_class5"] or features["jedi_class6"] or features["jedi_medic"] then
			return true
		else
			if #base:GetPassengerSeats() > 0 then
				ply:EnterVehicle(table.Random(base:GetPassengerSeats()))
			else
				re.util.Notify("red", ply, "Miejsce pilota/kierowcy jest dla Ciebie niedostępne z powodu braku specjalizacji!")
			end

			return false
		end
	end
	-- return true

	return true
end

function GM:PlayerEnteredVehicle(ply, vehicle, role)
	return false
end

function GM:PlayerUse(pl, ent)
	return true
end

function GM:PlayerSpray(ply)
	return true
end

function GM:OnPhysgunFreeze(weapon, phys, ent, pl)
    if ent.PhysgunFreeze and (ent:PhysgunFreeze(pl) == false) then return false end
    if ent:GetPersistent() then return false end
    
    if not IsValid(phys) then return false end
    
    -- Object is already frozen (!?)
    if not phys:IsMoveable() then return false end
    if ent:GetUnFreezable() then return false end
    phys:EnableMotion(false)

    -- With the jeep we need to pause all of its physics objects
    -- to stop it spazzing out and killing the server.
    if ent:GetClass() == "prop_vehicle_jeep" then
        local objects = ent:GetPhysicsObjectCount()

        for i = 0, objects - 1 do
            local physobject = ent:GetPhysicsObjectNum(i)
            if IsValid(physobject) then
                physobject:EnableMotion(false)
            end
        end
    end

    -- Add it to the player's frozen props
    pl:AddFrozenPhysicsObject(ent, phys)

    return true
end

local function activateflash(ply, state)
    local can = false

	if not IsValid(ply) or not ply:Alive() or ply:InVehicle() then
		return can
	end

    local ison = ply:FlashlightIsOn()

	if ply:GetMoveType() == MOVETYPE_NOCLIP then
		if ison then
			ply:Flashlight(can)
		end

		return can
	end

    can = true

    return can
end

function GM:PlayerSwitchFlashlight(ply, state)
	return activateflash(ply, state)
end