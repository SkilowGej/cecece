if not skill then return end
local skill = skill
skill.name = "Броне пластины"
skill.desc = "Увелечение брони на %d едениц."
skill.subdesc = "+%s к Броне"
skill.icon = Material("luna_icons/artificial-hive.png", "smooth noclamp")

if SERVER then
	skill:Hook("PostLoadCharacter", "Skill_SpawnArmor1", function(ply)
		local skillData = re.skill.FindTreeBySkillID(skill.unique)
		local skillLevel = ply:GetCharSkillLevel(skillData.unique)
		if skillLevel <= 0 then return end
		local buff = skillData.data(pl, skillLevel)[1]
		local maxArmor = ply:GetNetVar("maxArmor", 255) + buff
		ply:SetNVar("maxArmor", maxArmor, NETWORK_PROTOCOL_PUBLIC)
		ply:SetArmor(ply:Armor() + buff)
	end)
end