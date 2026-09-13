--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

hook.Add("PlayerPostThink", "CloakingDevice", function(ply)
	if not ply:GetNWBool("IsCloaked", false) then return end
	if not IsValid(ply:GetActiveWeapon()) then return end

	local weapon = ply:GetActiveWeapon()
	
	local current_alpha = ply:GetColor().a
	local new_alpha = math.max(ply:GetVelocity():Length() - 70, 0)
	new_alpha = math.Approach(current_alpha, new_alpha, 500 * FrameTime())
	
    ply:RemoveAllDecals()
    ply:DrawShadow(false)
    ply:SetDSP(14)

    ply:SetRenderMode(RENDERMODE_TRANSCOLOR)
	weapon:SetRenderMode(RENDERMODE_TRANSCOLOR)
    ply:SetColor(Color(255, 255, 255, new_alpha))
	local weapon_alpha = new_alpha < 70 and new_alpha or 0
	weapon:SetColor(Color(255, 255, 255, weapon_alpha))

	if not SERVER then return end
	ply:SetNoTarget(new_alpha < 70)
end)

hook.Add("PostEntityTakeDamage", "Cloak_OnDamageHook", function(ent)
	if not IsValid(ent) then return end
	if ent:IsPlayer() then
		if ent:GetNWBool("IsCloaked", false) then
            ent:EndCloak()
        end
	end
end)

hook.Add("LSCS:EntityFireBullets", "Cloak_OnFireHook", function(ent, data)
	if not IsValid(ent) then return end
	local ply = ent:IsPlayer() and ent or ent:GetOwner()
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if ply:GetNWBool("IsCloaked", false) then
		ply:EndCloak()
	end
end)

hook.Add("PlayerDeath", "Cloak_OnDeathHook", function(ply)
    if not IsValid(ply) then return end
    if ply:GetNWBool("IsCloaked", false) then
        ply:EndCloak()
    end
end)

local pMeta = FindMetaTable("Player")
function pMeta:EndCloak()
	if not IsValid(self) then return end
	local weapon = self:GetActiveWeapon()
	self:SetNWBool("IsCloaked", false)
	self.LSCS_Cloak = false
	timer.Simple(0.2, function()
		if SERVER then
			self:SetNoTarget(false)
		end
		self:SetColor(Color(255, 255, 255, 255))
        if IsValid(weapon) then weapon:SetColor(Color(255, 255, 255, 255)) end
		self:SetDSP(0)
		self:DrawShadow(true)
	end)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
