--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if SERVER then
	AddCSLuaFile("spd_toggle.lua")
end

if CLIENT then
	language.Add("tool.spd_toggle.name", "SPD Toggle")
	language.Add("tool.spd_toggle.desc", "Przełączenie SPD na określony prop.")
	language.Add("tool.spd_toggle.0", "Kliknij lewym przyciskiem myszy, aby wyłączyć SPD na prop. Kliknij prawym przyciskiem myszy, aby włączyć SPD na prop.")
end

TOOL.Category = "SPD"
TOOL.Name = "#tool.spd_toggle.name"

function TOOL.BuildCPanel(panel)
	panel:AddControl("Header", {
		Text = "#tool.spd_toggle.name",
		Description = "#tool.spd_toggle.desc"
	})
end

function TOOL:RightClick(trace)
	local owner = self:GetOwner()
	local ent = trace.Entity

	if owner:IsAdmin() == false then
		if CLIENT then
			notification.AddLegacy("This tool is restricted to admins!", NOTIFY_ERROR, 5)

			return false
		end

		return false
	end

	if IsValid(ent) and ent:GetClass() == "prop_physics" then
		spdDisableEffect(ent)
		if CLIENT then return true end
		spdDisable(ent)

		return true
	end

	return false
end

function TOOL:LeftClick(trace)
	local owner = self:GetOwner()
	local ent = trace.Entity

	if owner:IsAdmin() == false then
		if CLIENT then
			notification.AddLegacy("This tool is restricted to admins!", NOTIFY_ERROR, 5)

			return false
		end

		return false
	end

	if IsValid(ent) and ent:GetClass() == "prop_physics" then
		spdEnableEffect(ent)
		if CLIENT then return true end
		spdEnable(ent)

		return true
	end

	return false
end

function spdEnableEffect(ent)
	local effect = EffectData()
	local entPos = ent:GetPos()
	effect:SetStart(entPos)
	effect:SetOrigin(entPos)
	effect:SetEntity(ent)
	util.Effect("phys_freeze", effect)
end

function spdDisableEffect(ent)
	local effect = EffectData()
	local entPos = ent:GetPos()
	effect:SetStart(entPos)
	effect:SetOrigin(entPos)
	effect:SetEntity(ent)
	util.Effect("phys_unfreeze", effect)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
