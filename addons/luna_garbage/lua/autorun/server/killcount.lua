--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--симпл димпл аддон для поднятия пафоса в табе игроков путем засчитывания убийств НПЦ в таб

local function AddNPCtoFrag(npc, attacker, inflictor)
	
	if IsValid(attacker) then
		if attacker:IsPlayer() then
			attacker:SetFrags(attacker:Frags() + 1)
		end
	end
end
hook.Add("OnNPCKilled","OnNPCKilledFRAG",AddNPCtoFrag)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
