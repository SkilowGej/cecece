if not skill then return end
local skill = skill
skill.name = "Иньекция"
skill.desc = "Благодаря Иньекции в ваше тело, у вас повышается иммунитет при нахождении на других планетах"
skill.subdesc = "+%s%% к Здоровью"
skill.icon = Material("luna_menus/medsys/narkoman.png", "smooth noclamp")

if SERVER then
	skill:Hook("PostLoadCharacter", "Skill_SpawnHealth1", function(ply)
		local skillData = re.skill.FindTreeBySkillID(skill.unique)
		local skillLevel = ply:GetCharSkillLevel(skillData.unique)
		if skillLevel <= 0 then return end
		local max_health = ply:GetMaxHealth()
		local buff = (max_health / 100) * skillData.data(pl, skillLevel)[1]
		local maxHealth = max_health + buff
		ply:SetNetVar("maxHealth", maxHealth, NETWORK_PROTOCOL_PUBLIC)
		ply:SetMaxHealth(maxHealth)
		ply:SetHealth(ply:Health() + buff)
	end)
end