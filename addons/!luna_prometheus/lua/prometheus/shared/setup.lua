--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local CLIENT = CLIENT

local GROUP_PROPS = 1
local GROUP_WEAPONS = 2
local GROUP_NPCS = 3

local prop_flag = SF_PHYSPROP_MOTIONDISABLED + SF_PHYSBOX_NEVER_PICK_UP

local prop_class = {
	prop_physics = true,
	prop_physics_multiplayer = true,
	prop_ragdoll = true,
	prop_static = true,
	prop_detail = true,
	prop_dynamic = true
}

local door_class = {
	func_door = true,
	func_door_rotating = true,
	prop_door_rotating = true
}

-- local function SetupFog(ent)
-- 	ent:SetKeyValue('fogenable', '1')
-- 	ent:SetKeyValue('fogstart', '0')
-- 	ent:SetKeyValue('fogend', '20000')
-- 	ent:SetKeyValue('farz', '25000')
-- 	ent:Activate()
-- 	hasfog = true
-- end

-- булевые можно убрать по идее

local hasfog = false
local function OnEntityCreated(ent)
	local class = ent:GetClass()
	if class == 'worldspawn' then
		ent:SetKeyValue('maxoccludeearea', '90.0')
		ent:SetKeyValue('minoccluderarea', '7.0')
		ent:SetKeyValue('shadowcastdist', '1')
	-- elseif class == 'env_fog_controller' then
	-- 	SetupFog(ent)
	elseif door_class[class] then
		ent._Prop = true
		ent._Door = true
		ent._GROUP = GROUP_PROPS
		ent:SetCustomCollisionCheck(true)
		ent:CollisionRulesChanged()
		ent:SetKeyValue('fademindist', '7500')
		ent:SetKeyValue('fademaxdist', '7500')
		ent:SetKeyValue('spawnflag', prop_flag)
		ent:SetKeyValue('PerformanceMode', '1')
		ent:SetKeyValue('disableshadows', '1')
		ent:SetKeyValue('LagCompensate', '0')
		ent:SetKeyValue('shadowcastdist', '250')
		ent:SetKeyValue('disablereceiveshadows', '0')
		ent:SetKeyValue('disableshadowdepth', '0')
		ent:SetKeyValue('is_autoaim_target', '0')
		ent:SetKeyValue('speed', '240')
		ent:SetKeyValue('returndelay', '60')
	elseif ent:IsPlayer() then
		ent._Player = true
		ent:SetKeyValue('fademindist', '7500')
		ent:SetKeyValue('fademaxdist', '7500')
		ent:SetKeyValue('shadowcastdist', '250')
		ent:SetKeyValue('LagCompensate', '0')
		--ent:SetKeyValue('disablereceiveshadows', '0')
		--ent:SetKeyValue('disableshadowdepth', '0')
		ent:SetKeyValue('is_autoaim_target', '0')
		if CLIENT then ent:SetIK(false) end
	elseif ent:IsNPC() then
		ent._GROUP = GROUP_NPCS
		ent:SetCustomCollisionCheck(true)
		ent:CollisionRulesChanged()
		ent:SetKeyValue('fademindist', '7500')
		ent:SetKeyValue('fademaxdist', '7500')
		if CLIENT then ent:SetIK(false) end
	elseif ent:IsWeapon() then
		ent._Weapon = true
		ent._GROUP = GROUP_WEAPONS
		ent:SetCustomCollisionCheck(true)
		ent:CollisionRulesChanged()
		ent:SetKeyValue('fademindist', '1500')
		ent:SetKeyValue('fademaxdist', '1500')
		ent:SetKeyValue('disableshadows', '1')
		ent:SetKeyValue('shadowcastdist', '1')
		ent:SetKeyValue('disablereceiveshadows', '1')
		ent:SetKeyValue('disableshadowdepth', '1')
	elseif prop_class[class] then
		ent._GROUP = GROUP_PROPS
		ent:SetCustomCollisionCheck(true)
		ent:CollisionRulesChanged()
		ent:SetKeyValue('fademindist', '100000')
		ent:SetKeyValue('fademaxdist', '100000')
		ent:SetKeyValue('spawnflag', prop_flag)
		ent:SetKeyValue('PerformanceMode', '1')
		ent:SetKeyValue('disableshadows', '1')
		ent:SetKeyValue('LagCompensate', '0')
		ent:SetKeyValue('shadowcastdist', '250')
		ent:SetKeyValue('disablereceiveshadows', '0')
		ent:SetKeyValue('disableshadowdepth', '0')
		ent:SetKeyValue('is_autoaim_target', '0')
		ent:SetKeyValue('shadowdepthnocache', '2')
	end
end

-- hook.Add('ShouldCollide', 'GroupCollide', function(a, b)
-- 	if a._GROUP ~= nil and a._GROUP == b._GROUP then return false end
-- 	return true
-- end)

-- local function SetupWorld()
-- 	for _, ent in next, ents.GetAll() do
-- 		OnEntityCreated(ent)
-- 	end

-- 	if not hasfog and SERVER then
-- 		local ent = ents.Create'env_fog_controller'
-- 		ent:Spawn()
-- 		SetupFog(ent)
-- 	end
-- end

hook.Add('OnEntityCreated', 'SetupVariables', OnEntityCreated)
hook.Add('InitPostEntity', 'SetupVariables', SetupWorld)
hook.Add('PostCleanupMap', 'SetupVariables', SetupWorld)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
