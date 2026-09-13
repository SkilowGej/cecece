--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

util.AddNetworkString("lunaObserverFlashlight")
hook.Add("PlayerNoClip", "luna.Observer-Noclip", function(ply, state)
	-- if ply:IsAdmin() then
	-- 	if state then
	-- 		ply:SetNoDraw(true)
	-- 		ply:SetNotSolid(true)
	-- 		ply:DrawWorldModel(false)
	-- 		ply:DrawShadow(false)
	-- 		ply:GodEnable()
	-- 		ply:SetNoTarget(true)
	-- 	elseif not state then
	-- 		ply:SetNoDraw(false)
	-- 		ply:SetNotSolid(false)
	-- 		ply:DrawWorldModel(true)
	-- 		ply:DrawShadow(true)
	-- 		ply:GodDisable()
	-- 		ply:SetNoTarget(false)
	-- 	end

	-- end
	return ply:IsAdmin()
end)

hook.Add("CanPlayerEnterVehicle", "luna.Observer-CanEnterVehicle", function(ply) if ply:GetMoveType() == MOVETYPE_NOCLIP then return false end end)
hook.Add("PlayerSwitchFlashlight", "luna.Observer-PlayerSwitchFlashlight", function(ply, state)
	if IsValid(ply) and ply:IsAdmin() and ply:Alive() and not ply:InVehicle() and ply:GetMoveType() == MOVETYPE_NOCLIP then
		if ply:GetNetVar("observerLight") then
			ply:SetNetVar("observerLight", false)
			net.Start("lunaObserverFlashlight")
			net.Send(ply)
			return false
		else
			net.Start("lunaObserverFlashlight")
			net.Send(ply)
			ply:SetNetVar("observerLight", true)
			return false
		end
	end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
