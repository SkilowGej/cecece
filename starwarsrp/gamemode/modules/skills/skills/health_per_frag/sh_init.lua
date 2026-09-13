if not skill then return end
local skill = skill
skill.name = "Жажда жизни"
skill.desc = "Убивая, вы получаете %s едениц здоровья."
skill.subdesc = "За каждое убийство +%sхп"
skill.icon = Material("luna_icons/vampire-dracula.png", "smooth noclamp")

if SERVER then
	skill:Hook("OnNPCKilled", "Skill_OnNPCKilled", function(npc, attacker, inflictor)
		if IsValid(attacker) and attacker:IsPlayer() then
			local skillData = re.skills.FindTreeBySkillID(skill.unique)
			local skillLevel = attacker:GetCharSkillLevel(skillData.unique)
			if skillLevel <= 0 then return end
			attacker:SetHealth(math.Clamp( attacker:Health() + skillData.data(attacker, skillLevel)[1], 0, attacker:GetMaxHealth() ))
		end
	end)

	skill:Hook("PlayerDeath", "Skill_PlayerDeath", function(victim, inflictor, attacker)
		if IsValid(attacker) and attacker:IsPlayer() then
			local skillData = re.skills.FindTreeBySkillID(skill.unique)
			local skillLevel = attacker:GetCharSkillLevel(skillData.unique)
			if skillLevel <= 0 then return end
			attacker:SetHealth(math.Clamp( attacker:Health() + skillData.data(attacker, skillLevel)[1], 0, attacker:GetMaxHealth() ))
		end
	end)
end