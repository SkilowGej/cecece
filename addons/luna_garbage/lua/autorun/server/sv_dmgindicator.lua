--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

util.AddNetworkString("DamageIndicator")

hook.Add("EntityTakeDamage", "DamageIndicator.Listener", function(target, info)
	if (target:IsPlayer()) then
		local pos = nil

		if (IsValid(info:GetAttacker())) then
			pos = info:GetAttacker():GetPos()
		elseif (IsValid(info:GetInflictor())) then
			pos = info:GetInflictor():GetPos()
		else
			return -- give up if we can't find who it came from
		end

		net.Start("DamageIndicator")
		net.WriteVector(pos)
		net.WriteUInt(info:GetDamage(), 16)
		net.Send(target)
	end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
