--/*
if not SERVER then return end

local function antipidormap()
	for _, v in pairs( ents.FindByName("aie5auiayuawyaawyawyw4u7")) do v:Remove() end
	for _, v in pairs( ents.FindByClass( "trigger_hurt" ) ) do v:Remove() end
end

hook.Add("InitPostEntity", "antipidormap", antipidormap)
hook.Add("PostCleanupMap", "antipidormap", antipidormap)

hook.Add("PlayerShouldTakeDamage", "No trigger_hurt", function(ply, attacker)
	if (attacker:GetClass() == "trigger_hurt") then
        return false;
    end
end);
--*/