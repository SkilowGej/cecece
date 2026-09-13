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
			net.Start("CC_BuffBase_SetHUDEffect")
			net.WriteColor(self.Buff_Color, false)
			net.WriteFloat(self.Buff_Timer)
			net.Send(v)
			v:SetNWBool("CC_Buff_Damage", true)

			local cd = self.Buff_Timer
			local i = 1
			timer.Create("CC_Buff_Damage_" .. v:SteamID64(), 1, cd, function()
				if not IsValid(v) and not v:Alive() then
					timer.Remove("CC_Buff_Damage_" .. v:SteamID64())
				end

				if i >= cd and v:GetNWBool("CC_Buff_Damage", false) then
					v:SetNWBool("CC_Buff_Damage", false)
				end

				i = i + 1
			end)

			--re.util.Notify("purple", v, "Игрок " .. self.Owner:Nick() .. " усилил вашу огневую мощь!")
		end
	end
end

hook.Add("EntityTakeDamage", "CC_Buff_Damage_ScaleDamage", function(target, dmginfo)
	if not IsValid(dmginfo:GetAttacker()) or not dmginfo:GetAttacker():IsPlayer() then return end
	local _attackPly = dmginfo:GetAttacker()
	if not _attackPly:GetNWBool("CC_Buff_Damage", false) then return end
	dmginfo:ScaleDamage(1.15)
end)

hook.Add("PlayerDeath", "CC_Buff_Damage_PlayerDeath", function(ply)
	timer.Remove("CC_Buff_Damage_" .. ply:SteamID64())
	ply:SetNWBool("CC_Buff_Damage", false)
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
