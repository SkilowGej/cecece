--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile("shared.lua")
include("shared.lua")

SWEP.Buff_Logic = function(self)
	local i = 0
	for k, v in pairs(ents.FindInSphere(self.Owner:GetPos(), self.Buff_Radius)) do
		if IsValid(v) and v:GetClass() == "prop_ragdoll" and IsValid(v.player) then
			i = i + 1

			net.Start("CC_BuffBase_SetHUDEffect")
			net.WriteColor(self.Buff_Color, false)
			net.WriteFloat(3)
			net.Send(v.player)

			local _cashPosition = v:GetPos()
			local _cashPlayer = v.player
			_cashPlayer:Spawn()
			_cashPlayer:SetPos(_cashPosition)

			for _, strWep in pairs(_cashPlayer.OldWeapons) do
				_cashPlayer:Give(strWep);
			end

			re.util.Notify("purple", v.player, "Gracz " .. self.Owner:Nick() .. " postawił cię na nogi!")

			if i >= 2 then
				return
			end
		end
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
