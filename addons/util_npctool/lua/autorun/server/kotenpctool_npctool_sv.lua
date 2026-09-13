--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if CLIENT then return end

-- hook.Add("Think", "SpawnNPC", function()
-- timer.Remove( "SpawnNPC" )
-- timer.Create( "SpawnNPC", 1, 0, function()
-- 	for _, ent in pairs(ents.FindByClass("obj_npcspawner")) do
-- 		-- if IsValid(ent.m_entEffect) and CurTime() > ent.m_nextEffect then
-- 		-- 	ent.m_entEffect:Fire("SetSequence", "teleport", 0)
-- 		-- 	ent.m_nextEffect = CurTime() + 8
-- 		-- end

-- 		if not ent:GetEnabled() then return end

-- 		if CurTime() > ent.m_nextSpawn then
-- 			ent.m_nextSpawn = CurTime() + ent:GetSpawnDelay()
-- 			-- print("+", CurTime(), ent.m_nextSpawn)
-- 			ent:SpawnNPC()
-- 		end
-- 	end
-- end)

local NEXT_THINK

hook.Add("Think", "NPCThink", function()
	local TIME = CurTime()

	if (NEXT_THINK or 0) < TIME then
		NEXT_THINK = TIME + 1 -- lets make sure we build relationship for only one vehicle per 1 seconds so it doesn't destroy your servers fps

		for _, ent in pairs(ents.FindByClass("obj_npcspawner")) do
			-- if IsValid(ent.m_entEffect) and CurTime() > ent.m_nextEffect then
			-- 	ent.m_entEffect:Fire("SetSequence", "teleport", 0)
			-- 	ent.m_nextEffect = CurTime() + 8
			-- end
	
			if not ent:GetEnabled() then return end
	
			if CurTime() > ent.m_nextSpawn then
				ent.m_nextSpawn = CurTime() + ent:GetSpawnDelay()
				-- print("+", CurTime(), ent.m_nextSpawn)
				ent:SpawnNPC()
			end
		end

		for _, npc in pairs(ents.FindByClass("*ragdoll*")) do
			if npc.StartFade and npc.StartFade > CurTime() then
				npc:Fire("FadeAndRemove", 0.5)
			end
		end
	end
end)

hook.Add("CreateEntityRagdoll", "obj_npcspawner_fadetime", function(src, dst)
	if src:GetVar("FadeTime") and src:GetVar("FadeTime") > 0 then
		src.StartFade = CurTime() + src:GetVar("FadeTime")

		-- timer.Simple(val, function()
		-- 	if IsValid(dst) then
		-- 		dst:Fire("FadeAndRemove", 0.5)
		-- 	end
		-- end)
	end
end)

util.AddNetworkString("kotenpctool_notify_sendtoclient")

local function kotenpctoolnotify(ply, text)
	net.Start("kotenpctool_notify_sendtoclient")
	net.WriteString(text)
	net.Send(ply)
end

-----------------------------------------------ВЫДАЧАХП-----------------------------------------------
function kotenpctoolgivehealthtool(tr, health, ply)
	if tr.Entity:IsValid() and tr.Entity:IsNPC() then
		tr.Entity:SetHealth(health)
		print(health)
		kotenpctoolnotify(ply, "Pokaż zdrowie " .. tr.Entity:GetClass() .. " ustawiono na " .. health)
	end
end

-----------------------------------------------ВЫДАЧАХП-----------------------------------------------
-----------------------------------------------ВЫДАЧАУРОНА-----------------------------------------------
function kotenpctoolgivedamagetool(tr, damage, scale, ply)
	if tr.Entity:IsValid() and tr.Entity:IsNPC() then
		tr.Entity:SetNW2Int("kotenpctooladddamage", damage)
		tr.Entity:SetModelScale(scale, 1)
		kotenpctoolnotify(ply, "Mnożnik obrażeń dla " .. tr.Entity:GetClass() .. " ustawiono na " .. damage)
		kotenpctoolnotify(ply, "Mnożnik rozmiaru dla " .. tr.Entity:GetClass() .. " ustawiono na " .. scale)
	end
end

-----------------------------------------------ВЫДАЧАУРОНА-----------------------------------------------
-----------------------------------------------ФЛАГИ-----------------------------------------------
function kotenpctoolgiveflagstool(tr, flags, ply)
	if tr.Entity:IsValid() and tr.Entity:IsNPC() then
		tr.Entity:SetKeyValue("spawnflags", flags + 8192)
		--tr.Entity:SetMaxLookDistance( 6000 )
		kotenpctoolnotify(ply, "Flagi dla " .. tr.Entity:GetClass() .. " ustawione")
	end
end

-----------------------------------------------ФЛАГИ-----------------------------------------------
hook.Add("ScalePlayerDamage", "kotenpctoolsscaleplayerdamage", function(ply, hitgroup, dmginfo)
	if dmginfo:GetAttacker():IsNPC() then
		if dmginfo:GetAttacker():GetNW2Int("kotenpctooladddamage", 0) ~= 0 then
			dmginfo:SetDamage(dmginfo:GetAttacker():GetNW2Int("kotenpctooladddamage", 0))
		end
	end
end)

hook.Add("OnNPCKilled", "NPcRemoveRagdols", function(npc, killer, indificator)
	if npc:HasSpawnFlags(SF_NPC_FADE_CORPSE) then
		npc:SetModel("models/alyx_gestures.mdl")
		npc:Remove()
	end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
