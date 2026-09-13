--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile("shared.lua")
include("shared.lua")

SWEP.Buff_Logic = function(self)
	-- net.Start("CC_BuffBase_SetHUDEffect")
	-- net.WriteColor(self.Buff_Color, true)
	-- net.WriteFloat(10)
	-- net.Send(self.Owner)

	timer.Create("CC_Buff_Regeneration_" .. self.Owner:SteamID64(), 1, self.Buff_Timer, function()
		if not IsValid(self.Owner) and not self.Owner:Alive() then
			timer.Remove("CC_Buff_Regeneration_" .. v:SteamID64())
		end

		for k, v in pairs(ents.FindInSphere(self.Owner:GetPos(), self.Buff_Radius)) do
			if IsValid(v) and v:IsPlayer() and v:Alive() then
				net.Start("CC_BuffBase_SetHUDEffect")
					net.WriteColor(self.Buff_Color, false)
					net.WriteFloat(1)
					net.WriteBool(false)
				net.Send(v)

				if v:Health() >= v:GetMaxHealth() then continue end
				v:SetHealth(math.min(v:Health() + 10, v:GetMaxHealth()))
			end
		end
	end)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
