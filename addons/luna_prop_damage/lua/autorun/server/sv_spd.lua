--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("spd/server/sv_spd.lua")

CreateConVar("spd_enabled", 1, FCVAR_ARCHIVE + FCVAR_NOTIFY)

local cvartbl = {
	["spd_prophealth"] = 1, -- Множитель здоровья prop
	["spd_effects"] = 0, -- Включить эффекты частиц
	-- ["spd_explosion"] = 0, -- Включить эффект взрыва
	["spd_color"] = 0, -- Enable Color Change
	["spd_unfreeze"] = 1, -- Включить размораживание

	["spd_removeconstraints_threshold"] = 0.25, -- Порог устранения ограничений
	-- ["spd_explosion_effect"] = "none", -- #Explosion Effect none/Explosion/HelicopterMegaBomb/RPGShotDown/AntlionGib/balloon_pop/cball_explode/WaterSurfaceExplosion
	-- ["spd_effect"] = "none", -- #First Effect
	-- ["spd_effect2"] = "none", -- #Second Effect
	["spd_physicsdamage"] = 0, -- Включить физическое повреждение
	["spd_bulletdamage"] = 1, -- Включить повреждение от пуль
	["spd_explosiondamage"] = 1, -- Включить повреждение от взрыва
	["spd_health_weightratio"] = 0.5, -- Коэффициент объема: Чем выше это число, тем больше базового здоровья будет у реквизита за счет объема. Установка значения 0 означает, что объем не влияет на здоровье реквизита. Используйте множитель Prop Health для масштабной настройки здоровья реквизита.
	["spd_health_volumeratio"] = 0.5, -- Коэффициент веса: Чем выше это число, тем больше базового здоровья будет у реквизита из-за веса. Установка значения 0 означает, что вес не влияет на здоровье реквизита. Используйте множитель Prop Health для масштабной настройки здоровья реквизита.
	["spd_colorfade_r"] = 255,
	["spd_colorfade_g"] = 0,
	["spd_colorfade_b"] = 0,
	["spd_debris"] = 0, -- Включить обломки
}

for cvar, default in pairs(cvartbl) do
	CreateConVar(cvar, default, FCVAR_ARCHIVE)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
