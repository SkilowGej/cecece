--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

hook.Add( "EntityTakeDamage", "NoREcoil", function( target, dmginfo )
	if target:IsPlayer() and IsValid(dmginfo:GetAttacker()) then
		if GetConVar("sbox_playershurtplayers"):GetInt() == 0 or target:HasGodMode() then
			if dmginfo:GetAttacker():IsPlayer() then return end
		end
		target:SetHealth(target:Health() - dmginfo:GetDamage())
		dmginfo:ScaleDamage(0)
	end
end )

function CustomRagdollCollisionGroup(ply, model, ent)

	ent:SetCollisionGroup(15)
	
end

hook.Add("PlayerSpawnedRagdoll", "Custom_Player_Ragdoll_Spawn", CustomRagdollCollisionGroup)


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
