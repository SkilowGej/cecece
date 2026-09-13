--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if SERVER then
	AddCSLuaFile()
	util.AddNetworkString("TurretBlockAttackToggle")
	
elseif CLIENT then
	local shouldBlockAttack=false
	net.Receive("TurretBlockAttackToggle",function()
		local blockBit=net.ReadBit()
		if blockBit==1 then
			shouldBlockAttack=true
		elseif blockBit==0 then
			shouldBlockAttack=false
		end
	end)
	
	hook.Add("CreateMove", "RedirectTurretAttack", function(cmd)
		local lp = LocalPlayer()
		if shouldBlockAttack and IsValid(lp) and bit.band(cmd:GetButtons(), IN_ATTACK) > 0 then
			-- cmd:SetButtons(bit.bor(cmd:GetButtons() - IN_ATTACK, IN_BULLRUSH))
		end
	end)

 
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
