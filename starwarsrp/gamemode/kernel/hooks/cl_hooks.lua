function GM:HUDDrawTargetID()
	return false
end

hook.Add('SpawnMenuOpen', 'SpawnmenuDisable', function()
	return LocalPlayer():GetUserGroup() ~= 'user'
end)

hook.Add('ChatText', 'hide_joinleave', function(index, name, text, typ) if typ == 'joinleave' then return true end end)
-- local mat_vignette = Material('celestia/cwrp/hud/vignette.png', 'smooth noclamp')
-- hook.Add('HUDPaint', 'vignette', function()
--     draw.Icon(0, 0, ScrW(), ScrH(), mat_vignette, color_white)
-- end)