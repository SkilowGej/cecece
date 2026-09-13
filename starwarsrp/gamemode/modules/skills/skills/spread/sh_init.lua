if not skill then return end
local skill = skill
skill.name = "Скорострельность"
skill.desc = "Вы стреляете на %s%% быстрее из любого оружия."
skill.subdesc = "+%s%% к скорострельности"
skill.icon = Material("luna_icons/gluttonous-smile.png", "smooth noclamp")

if SERVER then
	skill:Hook("PostLoadCharacter", "Skill_PlayerSwitchWeapon", function(ply, oldWeapon, newWeapon)
		local skillData = re.skills.FindTreeBySkillID(skill.unique)
		local skillLevel = ply:GetCharSkillLevel(skillData.unique)
		if skillLevel <= 0 then return end
		local buff = (1 - skillData.data(pl, skillLevel)[1] / 100)

		local currentWeapon = ply:GetActiveWeapon()
		if IsValid(currentWeapon) and currentWeapon.FireDelay ~= nil and currentWeapon.FireDelay > 0 then
			currentWeapon.__FireDelay = currentWeapon.FireDelay
			currentWeapon.FireDelay = currentWeapon.FireDelay * buff
		end
	end)

	skill:Hook("PlayerSwitchWeapon", "Skill_PlayerSwitchWeapon", function(ply, oldWeapon, newWeapon)
		local skillData = re.skills.FindTreeBySkillID(skill.unique)
		local skillLevel = ply:GetCharSkillLevel(skillData.unique)
		if skillLevel <= 0 then return end
		local buff = (1 - skillData.data(pl, skillLevel)[1] / 100)

		if oldWeapon.__FireDelay then
			oldWeapon.FireDelay = oldWeapon.__FireDelay
			ply.__FireDelay = nil
		end

		if IsValid(newWeapon) and newWeapon.FireDelay ~= nil and newWeapon.FireDelay > 0 then
			newWeapon.__FireDelay = newWeapon.FireDelay
			newWeapon.FireDelay = newWeapon.FireDelay * buff
			print(newWeapon.FireDelay, newWeapon.__FireDelay)
		end
	end)
end