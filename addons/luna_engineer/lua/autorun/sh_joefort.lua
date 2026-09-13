--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

JoeFort = JoeFort or {}
/*

JoeFort:AddEnt("Barrier","Barriers",{
    classname = string,
    model = string,
    health = int,
    buildtime = int,
    neededresources = int,
    CanSpawn = function(ply, wep)

    end,
    OnSpawn = function(ply,ent)

    end,
    OnDamaged = function(ent, spawner, attacker)

    end,
    OnDestroyed = function(ent, spawner, attacker)

    end,
    OnRepaired = function(spawner, repairer, ent)

    end,
    OnRemoved = function(spawner, remover, ent)

    end,
    OnBuildEntitySpawned = function(spawner, ent)
    
    end,
})

*/

JoeFort.structs = {}
function JoeFort:AddEnt(name,category,data)
    if not name or not category or not data then return end
    if not data.classname or not data.model then return end
    JoeFort.structs[category] = JoeFort.structs[category] or {}

    data.name = name
    data.health = data.health or 100
    data.buildtime = data.buildtime or 10
    data.neededresources = data.neededresources or 25

    table.insert(JoeFort.structs[category], data)
end

function JoeFort:GetRessourcePool()
    return JoeFort.Ressources or 0
end

if file.Exists("sh_fort_config.lua", "LUA") then
    if SERVER then
        include("sh_fort_config.lua")
        AddCSLuaFile("sh_fort_config.lua")
    elseif CLIENT then
        include("sh_fort_config.lua")
    end
end

JoeFort.Ressources = JoeFort.Ressources or 250
if JoeFort.configoverride then return end

JoeFort:AddEnt("Schronienie • 1","Schronienia",{
    classname = "",
    model = "models/gateway/aussiwozzi/simple_barricade.mdl",
    health = 15000,
    buildtime = 5,
    neededresources = 20,
})

JoeFort:AddEnt("Schronienie • 2","Schronienia",{
    classname = "",
    model = "models/gateway/aussiwozzi/barricade.mdl",
    health = 20000,
    buildtime = 7,
    neededresources = 25,
})

JoeFort:AddEnt("Schronienie • 3","Schronienia",{
    classname = "",
    model = "models/gateway/aussiwozzi/barricade2.mdl",
    health = 40000,
    buildtime = 9,
    neededresources = 50,
})

JoeFort:AddEnt("Schronienie • 4","Schronienia",{
    classname = "",
    model = "models/gateway/aussiwozzi/barricade3.mdl",
    health = 30000,
    buildtime = 7,
    neededresources = 40,
})

-- JoeFort:AddEnt("Укрытие • 5","Укрытия",{
--     classname = "",
--     model = "models/gateway/aussiwozzi/barricade_corner.mdl",
--     health = 30000,
--     buildtime = 7,
--     neededresources = 40,
-- })

-- JoeFort:AddEnt("Укрытие • 6","Укрытия",{
--     classname = "",
--     model = "models/lordtrilobite/starwars/props/imp_landingpad_wall.mdl",
--     health = 30000,
--     buildtime = 6,
--     neededresources = 30,
-- })

JoeFort:AddEnt("Schronienie • 5","Schronienia",{
    classname = "",
    model = "models/props/swsandbags.mdl",
    health = 80000,
    buildtime = 20,
    neededresources = 150,
})

JoeFort:AddEnt("Schronienie • 6","Schronienia",{
    classname = "",
    model = "models/props/swsandbuild1.mdl",
    health = 25000,
    buildtime = 6,
    neededresources = 25,
})

JoeFort:AddEnt("Drabina • 1","Schronienia",{
    classname = "",
    model = "models/rp_anaxes/rp_anaxes_3rdfloor_stairs_large_left.mdl",
    health = 25000,
    buildtime = 6,
    neededresources = 100,
})

JoeFort:AddEnt("Drabina • 2","Schronienia",{
    classname = "",
    model = "models/rp_anaxes/rp_anaxes_training_stairs1.mdl",
    health = 25000,
    buildtime = 6,
    neededresources = 100,
})

JoeFort:AddEnt("Drabina • 3","Schronienia",{
    classname = "",
    model = "models/shystudios/rb/detail/rb_commandstairs.mdl",
    health = 25000,
    buildtime = 6,
    neededresources = 100,
})

JoeFort:AddEnt("Barykada • 1","Schronienia",{
    classname = "",
    model = "models/niksacokica/neu/neu_battlefield_tank_blocker_01.mdl",
    health = 25000,
    buildtime = 6,
    neededresources = 100,
})

JoeFort:AddEnt("Barykada • 2","Schronienia",{
    classname = "",
    model = "models/props_eotl/eotl_barricade.mdl",
    health = 25000,
    buildtime = 6,
    neededresources = 100,
})

-- JoeFort:AddEnt("Укрытие • 9","Укрытия",{
--     classname = "",
--     model = "models/fyu/cedi/misc/v4/misc_9.mdl",
--     health = 26000,
--     buildtime = 6,
--     neededresources = 25,
-- })

-- JoeFort:AddEnt("Укрытие • 10","Укрытия",{
--     classname = "",
--     model = "models/galactic/me3fix/wall_concrete01.mdl",
--     health = 27000,
--     buildtime = 7,
--     neededresources = 30,
-- })

-- JoeFort:AddEnt("Укрытие • 11","Укрытия",{
--     classname = "",
--     model = "models/galactic/me3fix/wall_cover01_l.mdl",
--     health = 27000,
--     buildtime = 7,
--     neededresources = 30,
-- })

-- JoeFort:AddEnt("Укрытие • 12","Укрытия",{
--     classname = "",
--     model = "models/fyu/cedi/balmorra/v4/balmorra_stuff_21.mdl",
--     health = 60000,
--     buildtime = 12,
--     neededresources = 70,
-- })

-- JoeFort:AddEnt("Укрытие • 13","Укрытия",{
--     classname = "",
--     model = "models/fyu/cedi/belsavis/v4/belsavis_stuff_26.mdl",
--     health = 40000,
--     buildtime = 8,
--     neededresources = 35,
-- })

-- JoeFort:AddEnt("ПВО","Орудия",{
--     classname = "lvs_turret_aa",
--     model = "models/antiairturret/rep_anti-airturret.mdl",
--     health = 20000,
--     buildtime = 10,
--     neededresources = 300,
-- })

-- JoeFort:AddEnt("Противотанковое","Орудия",{
--     classname = "lvs_turret_av",
--     model = "models/antivehicleturret/anti-vehicleturret.mdl",
--     health = 25000,
--     buildtime = 10,
--     neededresources = 400,
-- })
JoeFort:AddEnt("Stacja naprawy sprzętu","Szczególne",{
    classname = "lvs_vehicle_repair",
    model = "models/battleground/droids/r1_astromech.mdl",
    health = 30000,
    buildtime = 20,
    neededresources = 500,
})
JoeFort:AddEnt("Droid Medyczny","Szczególne",{
    classname = "lvs_player_repair",
    model = "models/battleground/droids/fx7_medical_droid.mdl",
    health = 30000,
    buildtime = 20,
    neededresources = 800,
})
JoeFort:AddEnt("Stacja wydania amunicji","Szczególne",{
    classname = "lvs_ammo_repair",
    model = "models/battleground/droids/gonk_droid.mdl",
    health = 30000,
    buildtime = 20,
    neededresources = 1000,
})

JoeFort:AddEnt("Przeciwpiechotne","Szczególne",{
    classname = "sent_40k_fieldcannon",
    model = "models/ordoredactus/wheelchairs/40k_fieldgun.mdl",
    health = 30000,
    buildtime = 10,
    neededresources = 2000,
})

JoeFort:AddEnt("Platforma artyleryjska","Szczególne",{
    classname = "or_gun_platform_artillery",
    model = "models/ordoredactus/platforms/gun_platform_artillery.mdl",
    health = 2000,
    buildtime = 50,
    neededresources = 2500,
})
JoeFort:AddEnt("obrona przeciwlotnicza","Szczególne",{
    classname = "lvs_turret_aa",
    model = "models/antiairturret/rep_anti-airturret.mdl",
    health = 2000,
    buildtime = 50,
    neededresources = 1500,
})

-- JoeFort:AddEnt("Артиллерия Наводящая","Осадное",{
--     classname = "pe_artillery_cannon_venator",
--     model = "models/kingpommes/starwars/venator/turbolaser_base.mdl",
--     health = 50000,
--     buildtime = 50,
--     neededresources = 2500,
-- })
-- local TURRET_COLORS = { -- [Batalion] - Color
--     ["212"] = 1,
--     ["DOOM"] = 2,
-- }

-- JoeFort:AddEnt("Турель T1", "Турели",{
--     classname = "sentry_base",
--     model = "models/trumpetplayer/torbjorn/torbjorn_turret.mdl",
--     health = 800,
--     buildtime = 4,
--     neededresources = 200,
--     CanSpawn = function (ply, wep)
--         if ply:IsAdmin() then return true end

--         local turretLastSpawnTime = ply:GetNWInt("TurretLastSpawnTime", -1)
--         if turretLastSpawnTime <= CurTime() and turretLastSpawnTime != 0 then
--            ply:SetNWInt("TurretLastSpawnTime", CurTime() + 80)
--            return true
--         end
--         if turretLastSpawnTime == -1 then
--             ply:SetNWInt("TurretLastSpawnTime", CurTime() + 80)
--             return true
--         end
--         local errText = string.format("Ты сможешь заспавнить новую турель только через %d секунд(ы)", turretLastSpawnTime-CurTime())
--         ChatAddText(ply, errText)
--         return false
--     end,

--     OnSpawn = function (ply, ent)
--         ent.Level = 1
--         ent:SetLevelBodyGroups()
--         ent:SetMaxHealth(800)
--     end
-- })
-- JoeFort:AddEnt("Турель T2", "Турели",{
--     classname = "sentry_base",
--     model = "models/trumpetplayer/torbjorn/torbjorn_turret.mdl",
--     health = 1200,
--     buildtime = 4,
--     neededresources = 350,
--     CanSpawn = function (ply, wep)
--         if ply:IsAdmin() then return true end

--         local turretLastSpawnTime = ply:GetNWInt("TurretLastSpawnTime", -1)
--         if turretLastSpawnTime <= CurTime() and turretLastSpawnTime != 0 then
--            ply:SetNWInt("TurretLastSpawnTime", CurTime() + 80)
--            return true
--         end
--         if turretLastSpawnTime == -1 then
--             ply:SetNWInt("TurretLastSpawnTime", CurTime() + 80)
--             return true
--         end
--         local errText = string.format("Ты сможешь заспавнить новую турель только через %d секунд", turretLastSpawnTime-CurTime())
--         ChatAddText(ply, errText)
--         return false
--     end,
--     OnSpawn = function (ply, ent)
--         ent.Level = 2
--         ent:SetLevelBodyGroups()
--         ent:SetMaxHealth(1200)
--     end

-- })
-- JoeFort:AddEnt("Турель T3", "Турели",{
--     classname = "sentry_base",
--     model = "models/trumpetplayer/torbjorn/torbjorn_turret.mdl",
--     health = 1800,
--     buildtime = 4,
--     neededresources = 500,
--     CanSpawn = function (ply, wep)
--         if ply:IsAdmin() then return true end
--         local turretLastSpawnTime = ply:GetNWInt("TurretLastSpawnTime", -1)
--         if turretLastSpawnTime <= CurTime() and turretLastSpawnTime != 0 then
--            ply:SetNWInt("TurretLastSpawnTime", CurTime() + 80)
--            return true
--         end
--         if turretLastSpawnTime == -1 then
--             ply:SetNWInt("TurretLastSpawnTime", CurTime() + 80)
--             return true
--         end
--         local errText = string.format("Ты сможешь заспавнить новую турель только через %d секунд(ы)", turretLastSpawnTime-CurTime())
--         ChatAddText(ply, errText)
--         return false
--     end,
--     OnSpawn = function (ply, ent)
--         ent.Level = 3
--         ent:SetLevelBodyGroups()
--         ent:SetMaxHealth(1800)

--     end
-- })
JoeFort:AddEnt("Bariery","Szczególne",{
    classname = "shield_2",
    model = "models/jackjack/props/shieldgen.mdl",
    health = 100,
    buildtime = 10,
    neededresources = 90,
})

JoeFort:AddEnt("100 Zasoby","Zasoby",{
     classname = "joefort_ressource_100",
     model = "models/props/campcrate2.mdl",
     health = 100,
     buildtime = 15,
     neededresources = 100,
 })

JoeFort:AddEnt("250 Zasoby","Zasoby",{
    classname = "joefort_ressource_250",
     model = "models/props/campcrate.mdl",
     health = 200,
     buildtime = 25,
     neededresources = 250,
 })

 JoeFort:AddEnt("1000 Zasoby","Zasoby",{
     classname = "joefort_ressource_1000",
     model = "models/props/campcratebig.mdl",
     health = 300,
     buildtime = 65,
     neededresources = 1000,
 })


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
