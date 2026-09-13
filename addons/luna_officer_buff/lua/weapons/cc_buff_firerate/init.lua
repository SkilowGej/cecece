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
			v:SetNWBool("CC_Buff_Firerate", true)
			local _curretWep = v:GetActiveWeapon()

			if IsValid(_curretWep) and _curretWep.FireDelay ~= nil and _curretWep.FireDelay > 0 then
				_curretWep.FireDelay = _curretWep.FireDelay * 0.7
				v.lastBuffedWep = _curretWep
			end

			local cd = self.Buff_Timer
			local i = 1
			timer.Create("CC_Buff_Firerate_" .. v:SteamID64(), 1, cd, function()
				if (not IsValid(v) and not v:Alive()) then
					timer.Remove("CC_Buff_Firerate_" .. v:SteamID64())
				end

				if i >= cd and IsValid(v.lastBuffedWep) then
					v.lastBuffedWep.FireDelay = v.lastBuffedWep.FireDelay / 0.7
					v.lastBuffedWep = nil
				end

				i = i + 1

				v:SetNWBool("CC_Buff_Firerate", false)
			end)

			re.util.Notify("purple", v, "Gracz " .. self.Owner:Nick() .. " zwiększył twoją szybkostrzelność!")
		end
	end
end

hook.Add("PlayerDeath", "CC_Buff_Firerate_PlayerDeath", function(ply)
	if IsValid(ply.lastBuffedWep) then
		ply.lastBuffedWep.FireDelay = ply.lastBuffedWep.FireDelay / 0.7
		ply.lastBuffedWep = nil
	end

	timer.Remove("CC_Buff_Firerate_" .. ply:SteamID64())
	ply:SetNWBool("CC_Buff_Firerate", false)
end)

hook.Add("PlayerSwitchWeapon", "CC_Buff_Firerate_SwitchWeapon", function(ply, oldWeapon, newWeapon)
	if not ply:GetNWBool("CC_Buff_Firerate", false) then return end

	if IsValid(ply.lastBuffedWep) then
		ply.lastBuffedWep.FireDelay = newWeapon.FireDelay / 0.7
	end

	if IsValid(newWeapon) and newWeapon.FireDelay ~= nil and newWeapon.FireDelay > 0 then
		newWeapon.FireDelay = newWeapon.FireDelay * 0.7
		ply.lastBuffedWep = newWeapon
	end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
