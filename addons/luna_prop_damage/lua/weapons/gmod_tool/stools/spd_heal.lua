--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if SERVER then
	AddCSLuaFile("spd_heal.lua")
end

if CLIENT then
	language.Add("tool.spd_heal.name", "SPD Heal")
	language.Add("tool.spd_heal.desc", "Heal a prop back to full health.")
	language.Add("tool.spd_heal.0", "Left-Click to heal a prop back to full health.")
end

TOOL.Category = "SPD"
TOOL.Name = "#tool.spd_heal.name"

function TOOL.BuildCPanel(panel)
	panel:AddControl("Header", {
		Text = "#tool.spd_heal.name",
		Description = "#tool.spd_heal.desc"
	})
end

function TOOL:LeftClick(trace)
	local owner = self:GetOwner()
	local ent = trace.Entity

	if IsValid(ent) and ent:GetClass() == "prop_physics" then
		spdHealEffect(ent)
		if CLIENT then return true end

		if spdGetColor(ent) then
			ent:SetColor(spdGetColor(ent))
		end

		ent:RemoveAllDecals()
		spdClear(ent)

		return true
	end

	return false
end

function spdHealEffect(ent)
	local entPos = ent:GetPos()
	local effect = EffectData()
	effect:SetStart(entPos)
	effect:SetOrigin(entPos)
	effect:SetEntity(ent)
	util.Effect("phys_freeze", effect)
	local effect2 = EffectData()
	effect2:SetStart(entPos)
	effect2:SetOrigin(entPos)
	effect2:SetEntity(ent)
	util.Effect("phys_unfreeze", effect)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
