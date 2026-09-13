--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local Pos = Vector(0, 0, 0)

hook.Add("PostDrawTranslucentRenderables", "ee_rendercore", function(depth, skybox)
	for _, pl in ipairs(player.GetAll()) do
		if not IsValid(pl) or not pl:Alive() then continue end
		local _activeWeapon = pl:GetActiveWeapon()
		local _validWeapon = IsValid(_activeWeapon) and weapons.IsBasedOn(_activeWeapon:GetClass(), "cc_buff_base") or false
		if not _validWeapon then continue end

		local Pos = pl:GetPos()
		--render.BorderSphereUnit(ColorAlpha(_activeWeapon.Buff_Color, 130), Pos, _activeWeapon.Buff_Radius, 60, 4)
	end
end)


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
