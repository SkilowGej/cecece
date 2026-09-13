--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

hook.Add("EntityTakeDamage", "lscs_rebuke_hook", function(ply, dmginfo)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if ply:GetNWFloat("lscs_rebuke", 0) < CurTime() then return end

	local damage = dmginfo:GetDamage()
	local attacker = dmginfo:GetAttacker()
	local blockpercent = 0.5

	dmginfo:ScaleDamage(1 - blockpercent)
	if not IsValid(attacker) or dmginfo:IsFallDamage() then return end
	attacker:TakeDamage(damage * blockpercent, ply, ply)
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
