if not skill then return end
local skill = skill
skill.name = "Strzelanie do hełmów"
skill.desc = "Obrażenia zadawane przy trafieniu w głowę przeciwników zostały zwiększone o %d%%."
skill.subdesc = "Kret – obrażenia +%d%%"
skill.icon = Material("luna_icons/skull-crack.png", "smooth noclamp")

if SERVER then
	skill:Hook("ScaleNPCDamage", "Skill_DamageCritical", function(target, hitgroup, dmginfo)
		local attacker = dmginfo:GetAttacker()
		if IsValid(attacker) and attacker:IsPlayer() and hitgroup == HITGROUP_HEAD then
			local skillData = re.skills.FindTreeBySkillID(skill.unique)
			local skillLevel = attacker:GetCharSkillLevel(skillData.unique)
			if skillLevel <= 0 then return end
			dmginfo:ScaleDamage(1 + skillData.data(attacker, skillLevel)[1] / 100)
		end
	end)
end