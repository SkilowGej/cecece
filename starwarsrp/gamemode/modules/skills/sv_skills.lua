function OpenSkillsMenu(pPlayer)
	netstream.Start(pPlayer, "OpenSkillsMenu")
end

function pMeta:AddCharSkill(unique, count)
	self:SetCharSkill(unique, self:GetCharSkillLevel(unique) + (count or 1))
end

function pMeta:SetCharSkill(unique, level)
	local skills = self:GetCharSkills()
	skills[unique] = level
	unique = MySQLite.SQLStr(unique)
	MySQLite.query(string.format("UPDATE `re_characters_skills` SET skills = %s WHERE char_id = %s;", MySQLite.SQLStr(util.TableToJSON(skills)), MySQLite.SQLStr(self:GetNetVar("character"))))
	self:SetNetVar("skills", skills, NETWORK_PROTOCOL_PRIVATE)
end

function pMeta:AddCharSkillPoints(points)
	if not isnumber(points) then return end
	self:SetCharSkillPoints(self:GetCharSkillPoints() + points)
end

function pMeta:GiveSkills()
	hook.Run("PlayerLoadout", self)
	for _, func in pairs(re.skill.hooks["PostLoadCharacter"]) do
		func(self)
	end
end

function pMeta:SetCharSkillPoints(points)
	if not self or not IsValid(self) or not self:GetNetVar("character") then return end
	if not isnumber(points) then return end
	MySQLite.query(string.format("UPDATE `re_characters_skills` SET points = %d WHERE char_id = %s;", points, MySQLite.SQLStr(self:GetNetVar("character"))))
	self:SetNetVar("skillPoints", points, NETWORK_PROTOCOL_PRIVATE)
end

hook.Add("PostLoadCharacter", "Skills_PostLoadCharacter", function(pPlayer, char_id)
	MySQLite.query(string.format("SELECT * FROM `re_characters_skills` WHERE char_id = %s;", MySQLite.SQLStr(char_id or pPlayer:GetNetVar("character"))), function(data)
		local skills, points = {}, 0

		if data and istable(data) then
			skills = util.JSONToTable(data[1].skills)
			points = data[1].points
		else
			MySQLite.query(string.format("INSERT INTO `re_characters_skills`(char_id, skills, points) VALUES(%s, \"[]\", 0);", MySQLite.SQLStr(char_id or pPlayer:GetNetVar("character"))))
		end

		pPlayer:SetNetVar("skills", skills, NETWORK_PROTOCOL_PRIVATE)
		pPlayer:SetNetVar("skillPoints", points, NETWORK_PROTOCOL_PRIVATE)
	end)
end)

netstream.Hook("CharSkillBuy", function(pl, unique)
	local tree = re.skill.FindTreeByUnique(unique)

	if tree.needLevel >= pl:GetCharLevel() then
		re.util.Notify("yellow", pl, "Potrzebujesz " .. tree.needLevel .. " poziom postaci!")

		return
	end

	if tree.prevSkills then
		for _, uni in pairs(tree.prevSkills) do
			if pl:GetCharSkillLevel(uni) <= 0 then
				re.util.Notify("yellow", pl, "Musisz najpierw aktywować " .. re.skill.FindByID(re.skill.FindTreeByUnique(uni).skill_id).name .. "!")

				return
			end
		end
	end

	if not pl:isEnoughMoney(tree.cost) then
		re.util.Notify("yellow", pl, "Nie masz wystarczająco KR!")

		return
	end

	if not pl:isEnoughSkillPoints(tree.points) then
		re.util.Notify("yellow", pl, "Nie masz wystarczająco punktów umiejętności!")

		return
	end

	pl:AddCharSkillPoints(-tree.points)
	pl:AddMoney(-tree.cost)
	pl:AddCharSkill(unique)
	netstream.Start(pl, "CharSkillBuy")

	pl:GiveSkills()
end)

netstream.Hook("CharSkillReset", function(pl, unique)
	local tree = re.skill.FindTreeByUnique(unique)

	if pl:GetCharSkillLevel(unique) <= 0 then
		re.util.Notify("yellow", pl, "Nie posiadasz tej umiejętności, aby ją dezaktywować!")

		return
	end

	if tree.needLevel >= pl:GetCharLevel() then
		re.util.Notify("yellow", pl, "Potrzebujesz " .. tree.needLevel .. " poziom postaci!")

		return
	end

	if not pl:CanResetSkill(unique) and pl:GetCharSkillLevel(unique) == 1 then
		re.util.Notify("yellow", pl, "Musisz najpierw dezaktywować poprzednie umiejętności!")

		return
	end

	pl:AddCharSkillPoints(tree.points)
	pl:AddMoney(math.floor(tree.cost / 2))
	pl:AddCharSkill(unique, -1)
	netstream.Start(pl, "CharSkillReset")

	pl:GiveSkills()
end)