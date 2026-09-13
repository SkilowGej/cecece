--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile("shared.lua")
include("shared.lua")

SWEP.Buff_Logic = function(self)
	for k, v in pairs(ents.FindInSphere(self.Owner:GetPos(), self.Buff_Radius)) do
		if IsValid(v) and v:IsPlayer() and v:Alive() then
			if timer.Exists("CC_Buff_Speed_" .. v:SteamID64()) then return end
			v:SetRunSpeed(v:GetRunSpeed() * 1.4)

			net.Start("CC_BuffBase_SetHUDEffect")
			net.WriteColor(self.Buff_Color, false)
			net.WriteFloat(self.Buff_Timer)
			net.Send(v)

			timer.Create("CC_Buff_Speed_" .. v:SteamID64(), self.Buff_Timer, 1, function()
				if not IsValid(v) and not v:Alive() then
					timer.Remove("CC_Buff_Speed_" .. v:SteamID64())
				end

				v:SetRunSpeed(v:GetRunSpeed() / 1.4)
			end)

			re.util.Notify("purple", v, "Gracz " .. self.Owner:Nick() .. " dał ci prędkość!")
		end
	end
end

hook.Add("PlayerDeath", "CC_Buff_Speed_RemoveTimer", function(ply)
	timer.Remove("CC_Buff_Speed_" .. ply:SteamID64())
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
