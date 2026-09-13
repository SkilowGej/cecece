local function GetMultiplier(ply)
    local userGroup = ply:GetUserGroup()
    if ROLE_MULTIPLIERS[userGroup] and ROLE_MULTIPLIERS[userGroup].money then
        return ROLE_MULTIPLIERS[userGroup].money
    end
    return 1
end

function pMeta:SetCharLevel(intCount)
	-- self:SavePlayerData("level",intCount)
	MySQLite.query(string.format("UPDATE re_characters_levels SET %s = %s WHERE char_id = %s;", "level", MySQLite.SQLStr(intCount), MySQLite.SQLStr(self:GetNetVar("character"))))
	self:SetNetVar("level", intCount, NETWORK_PROTOCOL_PUBLIC)
	local effectdata = EffectData()
	effectdata:SetEntity(self)
	effectdata:SetStart(self:GetPos())
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetScale(1)
	util.Effect("entity_remove", effectdata)
	-- self:EmitSound("garrysmod/save_load"..math.random(4)..".wav")
	self:EmitSound("luna_sound_effects/levelup/levelup1.mp3")
end

function pMeta:AddCharLevel(intCount)
	intCount = self:GetCharLevel() + intCount
	self:SetCharLevel(intCount)
end

function pMeta:SetCharExperience(intCount)
	-- self:SavePlayerData("experience",intCount)
	if not self or not IsValid(self) or not self:GetNetVar("character") then return end
	MySQLite.query(string.format("UPDATE re_characters_levels SET experience = %s WHERE char_id = %s;", MySQLite.SQLStr(intCount), MySQLite.SQLStr(self:GetNetVar("character"))))
	self:SetNetVar("experience", intCount, NETWORK_PROTOCOL_PUBLIC)
	self:isCharPassedLevel()
end

function pMeta:AddCharExperience(intCount)
	intCount = self:GetCharExperience() + intCount
	self:SetCharExperience(intCount)
end

function pMeta:isCharPassedLevel()
	if self:GetCharExperience() >= self:GetCharNeedExperience() then
		self:AddCharLevel(1)
		self:SetCharExperience(0)

		re.util.Notify("yellow", self, "Poziom podwyższony!")

		if isfunction(self.AddCharSkillPoints) then
			local level = self:GetCharLevel()
			local count = 1

			if level >= 30 then
				count = 4
			elseif level >= 20 then
				count = 2
			end

			self:AddCharSkillPoints(count)
			re.util.Notify("yellow", self, "Otrzymałeś " .. count .. " punktów umiejętności!")
		end
	end
end

timer.Create("LevelTimer", 120, 0, function()
	for _, pPlayer in ipairs(player.GetAll()) do
		if not IsValid(pPlayer) or not pPlayer:Alive() then continue end
		local expCount = math.random(5, 30) * ( 1 + (pPlayer:GetCharLevel() or 0))
		pPlayer:AddCharExperience(expCount)
		-- TODO: notify
		-- print(expCount.." > "..pPlayer:Name())
	end
end)

hook.Add("PostLoadCharacter", "Levelsystem_PostLoadCharacter", function(pPlayer, char_id)
	MySQLite.query(string.format("SELECT * FROM `re_characters_levels` WHERE char_id = %s;", MySQLite.SQLStr(char_id)), function(data)
		local level, experience

		if data and istable(data) then
			level, experience = data[1].level, data[1].experience
		else
			level, experience = 0, 0
			MySQLite.query(string.format("INSERT INTO `re_characters_levels`(char_id, level, experience) VALUES(%s, %s, %s);", MySQLite.SQLStr(char_id), MySQLite.SQLStr(level), MySQLite.SQLStr(experience)))
		end

		pPlayer:SetNetVar("level", level, NETWORK_PROTOCOL_PUBLIC)
		pPlayer:SetNetVar("experience", experience, NETWORK_PROTOCOL_PUBLIC)
	end)
end)

-- timer.Create("MoneyTimer", 1200, 0, function()
-- 	for _, pPlayer in ipairs(player.GetAll()) do
-- 		if not IsValid(pPlayer) or not pPlayer:Alive() then continue end
-- 		-- local expCount = math.random(30,60)*pPlayer:GetLevel()
-- 		-- pPlayer:AddCharExperience(expCount)
-- 		-- local job_price = re.jobs[pPlayer:Team()].Salary
-- 		if job_price then
-- 			re.util.Notify("blue", pPlayer, "Вы получили " .. formatMoney(job_price) .. " за то что играете на нашем сервере.")
-- 			pPlayer:AddMoney(job_price)
-- 		end
-- 		-- TODO: notify
-- 		-- print(expCount.." > "..pPlayer:Name())
-- 	end
-- end)
hook.Add("OnNPCKilled", "Levelsystem_OnNPCKilled", function(npc, attacker, inflictor)
	if attacker and attacker:IsPlayer() then
		local multiplier = GetMultiplier(attacker)
		local expCount = math.Round(math.random(1, 10) * ( 1 + (attacker:GetCharLevel() or 0) / 2)) * multiplier
		re.util.Notify("blue", attacker, "Zabiłeś NPC, i otrzymałeś za to " .. formatMoney(NPC_REWARD * multiplier) .. " i " .. expCount .. " doświadczenia.")
		attacker:AddMoney(NPC_REWARD)
		attacker:AddCharExperience(expCount)
	end
end)


hook.Add("PlayerDeath", "Levelsystem_PlayerDeath", function(victim, inflictor, attacker)
	if attacker and attacker:IsPlayer() and victim ~= attacker then
		local expCount = math.Round(math.random(1, 15) * ( 1 + (attacker:GetCharLevel() or 0) / 2)) * multiplier
		re.util.Notify("blue", attacker, "Zabiłeś gracza, i otrzymałeś za to " .. formatMoney(PLAYER_REWARD * multiplier) .. " i " .. expCount .. " doświadczenia.")
		attacker:AddMoney(PLAYER_REWARD)
		attacker:AddCharExperience(expCount)
	end
end)