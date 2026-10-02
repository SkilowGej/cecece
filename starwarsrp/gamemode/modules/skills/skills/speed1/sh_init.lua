if not skill then return end
local skill = skill
skill.name = "Stymulatory"
skill.desc = "Just Like The Simulations..."
skill.subdesc = "+%s%% do prędkości biegu"
skill.icon = Material("luna_icons/run.png", "smooth noclamp")

if SERVER then
	skill:Hook("PostLoadCharacter", "Skill_SpawnSpeed1", function(ply)
		local skillData = re.skills.FindTreeBySkillID(skill.unique)
		local skillLevel = ply:GetCharSkillLevel(skillData.unique)
		if skillLevel <= 0 then return end
		local runspeed = (ply:GetRunSpeed() / 100)
		local buff = runspeed * skillData.data(ply, skillLevel)[1]
		ply:SetRunSpeed(ply:GetRunSpeed() + buff)

	end)
end