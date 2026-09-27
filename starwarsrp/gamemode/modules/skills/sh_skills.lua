re.skills = re.skill or { store = {}, hooks = {} } -- For stored skills

re.skills.tree = {
	["armor_1"] = { -- Уникальный id скила
		disabled = true,
		skill_id = "armor1",
		max_mult = 1,
		pos = {x = 192, y = 0}, -- Позиция в меню
		needLevel = 10, -- Какой лвл нужен для доступа
		points = 2, -- Цена разблокировки в поинтах
		cost = 50000, -- Цена разблокировки в РК
		after = { -- Следущие перки по ветке
			["armor_2"] = {
				skill_id = "armor1",
				max_mult = 5,
				pos = {x = 0, y = 384},
				needLevel = 15,
				points = 8, -- Цена разблокировки в поинтах
				cost = 85000, -- Цена разблокировки в РК
				data = function(player, skillLevel)
					return {5 * skillLevel}
				end,
				after = {
					["armor_3"] = {
						disabled = true,
						skill_id = "armor1",
						max_mult = 5,
						pos = {x = 0, y = 128},
						needLevel = 20,
						points = 16, -- Цена разблокировки в поинтах
						cost = 90000, -- Цена разблокировки в РК
						data = function(player, skillLevel)
							return {50, 1 / skillLevel}
						end,
						after = {
							["armor_4"] = {
								disabled = true,
								skill_id = "armor1",
								max_mult = 1,
								pos = {x = 0, y = 128},
								needLevel = 40,
								points = 30, -- Цена разблокировки в поинтах
								cost = 100000, -- Цена разблокировки в РК
							},
						}
					},
				},
			},
		}
	},
	["speed_1"] = { -- Скорость
		skill_id = "speed1",
		max_mult = 5,
		pos = {x = 64, y = 0},
		needLevel = 15,
		points = 4,
		cost = 60000,
		data = function(player, skillLevel)
			return {10 * skillLevel}
		end,
		after = {
			["speed_2"] = {
				skill_id = "speed1",
				max_mult = 5,
				pos = {x = 0, y = 256},
				needLevel = 25,
				points = 10, -- Цена разблокировки в поинтах
				cost = 100000, -- Цена разблокировки в РК
				data = function(player, skillLevel)
					return {25 * skillLevel}
				end,
				after = {
					["speed_3"] = {
						disabled = true,
						skill_id = "speed1",
						max_mult = 5,
						pos = {x = 0, y = 128},
						needLevel = 35,
						points = 20,
						cost = 100000,
						data = function(player, skillLevel)
							return {15 * skillLevel}
						end,
					},
				}
			},
		}
	},
	["health_1"] = { -- Увеличиное здоровье
		skill_id = "health1",
		max_mult = 5,
		pos = {x = -128, y = 0},
		needLevel = 20,
		points = 4,
		cost = 45000,
		data = function(player, skillLevel)
			return {10 * skillLevel}
		end, -- На сколько увеличивает здоровье
		after = {
			["health_2"] = {
				skill_id = "health1",
				max_mult = 5,
				pos = {x = 0, y = 128},
				needLevel = 20,
				data = function(player, skillLevel)
					return {10 * skillLevel}
				end, -- На сколько востанавливает хп при убийстве врага
				points = 5,
				cost = 55000,
				after = {
					["health_3"] = {
						skill_id = "health1",
						max_mult = 5,
						pos = {x = 0, y = 128},
						needLevel = 25,
						data = function(player, skillLevel)
							return {3, 2 * skillLevel}
						end,
						points = 30,
						cost = 80000,
						after = {
							["health_4"] = {
								disabled = true,
								skill_id = "health1",
								max_mult = 5,
								pos = {x = 0, y = 128},
								needLevel = 30,
								points = 20,
								cost = 100000,
								data = function(player, skillLevel)
									return {20 * skillLevel}
								end,
							},
						}
					},
				}
			},
		},
	},
	["damage_1"] = {
		skill_id = "damage",
		max_mult = 5,
		pos = {x = -320, y = 128},
		needLevel = 30,
		points = 15,
		cost = 85000,
		data = function(player, skillLevel)
			return {15 * skillLevel}
		end,
		after = {
			["spread_1"] = {
				skill_id = "spread",
				max_mult = 5,
				pos = {x = 0, y = 128},
				needLevel = 35,
				points = 18,
				cost = 85000,
				data = function(player, skillLevel)
					return {2 * skillLevel}
				end,
			},
		}
	},
	["damage_1"] = {
		skill_id = "damage_critical",
		max_mult = 5,
		pos = {x = -320, y = 128},
		needLevel = 35,
		points = 15,
		cost = 85000,
		data = function(player, skillLevel)
			return {15 * skillLevel}
		end,
		after = {
			["spread_1"] = {
				skill_id = "spread",
				max_mult = 5,
				pos = {x = 0, y = 128},
				needLevel = 45,
				points = 18,
				cost = 85000,
				data = function(player, skillLevel)
					return {2 * skillLevel}
				end,
			},
		}
	}
}

local function LocalePreviusSkills(lasttree, prevSkill)
	for uni, tree in pairs(lasttree) do
		tree.unique = uni

		if tree.prevSkills then
			table.insert(tree.prevSkills, prevSkill)
		elseif prevSkill then
			tree.prevSkills = {prevSkill}
		end

		if tree.after then
			LocalePreviusSkills(tree.after, uni)
		end
	end
end

LocalePreviusSkills(re.skills.tree)

function pMeta:GetCharSkills()
	return self:GetNetVar("skills", {}) or {}
end

function pMeta:GetCharSkillLevel(unique)
	return self:GetCharSkills()[unique] or 0
end

function pMeta:GetCharSkillPoints()
	return self:GetNetVar("skillPoints", 0) or 0
end

function pMeta:isEnoughSkillPoints(points)
	return self:GetCharSkillPoints() >= points
end

function pMeta:CanResetSkill(unique, lasttree)
	if self:GetCharSkillLevel(unique) <= 0 then
		return false
	end

	for uni, tree in pairs(lasttree or re.skill.FindTreeByUnique(unique).after or {}) do
		if self:GetCharSkillLevel(uni) > 0 then
			return false
		end

		if tree.after then
			return self:CanResetSkill(unique, tree.after)
		end
	end

	return true
end

local object = {}
object.__index = object

function object:Hook(eventName, identifier, callback)
	self.hooks[eventName] = self.hooks[eventName] or {}
	self.hooks[eventName][identifier] = callback

	re.skill.hooks[eventName] = re.skill.hooks[eventName] or {}
	re.skill.hooks[eventName][identifier] = callback

	hook.Add(eventName, "re_" .. identifier, callback)
end

function re.skill.New()
	local skill = {}
	skill.hooks = {}

	return setmetatable(skill, object)
end

function re.skill.Register(skill)
	re.skills.store[skill.unique] = skill
end

function re.skill.FindByID(unique)
	return re.skills.store[unique]
end

function re.skill.FindTreeBySkillID(skill_id, lasttree)
	local to_return = false
	for uni, tree in pairs(lasttree or re.skills.tree) do
		if to_return then break end

		if tree.after then
			to_return = re.skill.FindTreeBySkillID(skill_id, tree.after)
		end

		if tree.skill_id == skill_id then
			to_return = tree
		end
	end

	return to_return
end

function re.skill.FindTreeByUnique(unique, lasttree)
	local to_return = false
	for uni, tree in pairs(lasttree or re.skills.tree) do
		if to_return then break end

		if tree.after then
			to_return = re.skill.FindTreeByUnique(unique, tree.after)
		end

		if uni == unique then
			to_return = tree
		end
	end

	return to_return
end

-- function re.skill.FindTreeByUnique(unique, lasttree)
-- 	local to_return = false
-- 	for uni, tree in pairs(lasttree or re.skills.tree) do
-- 		print(uni, unique, tree.after)
-- 		if uni == unique then
-- 			print(uni == unique)
-- 			to_return = tree
-- 			break
-- 		end

-- 		if tree.after then
-- 			to_return = re.skill.FindTreeByUnique(unique, tree.after)
-- 		end
-- 	end

-- 	return to_return
-- end

function re.skill.LoadFiles()
	local path = GAMEMODE.FolderName .. "/gamemode/modules/skills/skills/"
	local _, folders = file.Find(path .. "*", "LUA")
	hook.Call("re_PreLoadSkills")

	for k, folder in pairs(folders) do
		skill = re.skill.FindByID(folder) or re.skill.New()
		skill.unique = folder
		skill.path = path .. folder .. "/"

		if file.Exists(path .. folder .. "/init.lua", "LUA") then
			luna.loader.Server(path .. folder .. "/init.lua")
		end

		if file.Exists(path .. folder .. "/sh_init.lua", "LUA") then
			-- print(path, folder)
			luna.loader.Shared(path .. folder .. "/sh_init.lua")
		end

		if file.Exists(path .. folder .. "/cl_init.lua", "LUA") then
			luna.loader.Client(path .. folder .. "/cl_init.lua")
		end

		if skill.name then
			re.skill.Register(skill)
			print("Registered skill \"" .. skill.name .. "\"!")
		else
			print("Failed to load skill \"" .. folder .. "\"!")
		end

		skill = nil
	end

	hook.Call("re_PostLoadSkills")
end

if SERVER then
	-- Error bypass at server startup.
	timer.Simple(0, function()
		re.skill.LoadFiles()
	end)
else
	re.skill.LoadFiles()
end
