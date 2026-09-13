--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

function SWEP:DrawHalos()
	local _haloTarget = {};
	for k,v in pairs(ents.FindInSphere(LocalPlayer():GetPos(), self.Buff_Radius)) do
		if (IsValid(v) && v:GetClass() == "prop_ragdoll" && IsValid(v:GetNWEntity("Player"))) then
			table.insert(_haloTarget, v);
		end
	end

	return _haloTarget;
end



--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
