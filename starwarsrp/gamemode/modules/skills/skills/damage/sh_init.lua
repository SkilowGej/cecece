if not skill then return end
local skill = skill
skill.name = "Быстрый и разъярённый"
skill.desc = "Вы наносите больше урона. Не распространяется на оружие ближнего боя. "
skill.subdesc = "+%s%% к урону от оружия"
skill.icon = Material("luna_icons/bullets.png", "smooth noclamp")

if SERVER then
	skill:Hook("EntityTakeDamage", "Skill_Damage", function(target, dmginfo)
		local attacker = dmginfo:GetAttacker()
		if IsValid(attacker) and attacker:IsPlayer() then
			local wep = attacker:GetActiveWeapon()
			if wep and IsValid(wep) and not wep.SWBWeapon then
				return
			end

			local skillData = re.skills.FindTreeBySkillID(skill.unique)
			local skillLevel = attacker:GetCharSkillLevel(skillData.unique)
			if skillLevel <= 0 then return end
			dmginfo:ScaleDamage(1 + skillData.data(attacker, skillLevel)[1] / 100)
		end
	end)
end