if not skill then return end
local skill = skill
skill.name = "Стрельба по шлемам"
skill.desc = "Урон от попадания в головы НПС увеличен на %d%%."
skill.subdesc = "Крит урон +%d%%"
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