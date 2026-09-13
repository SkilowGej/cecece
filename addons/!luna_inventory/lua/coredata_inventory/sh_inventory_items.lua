--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--[[
    Все типы слотов в инвентаре:
            main
            secondary
            heavy
            var
    Все типы иконок - 
            dc15s 
            de10
            dc15a 
            dc17
            detonator
            medpack
            helmet19
            z6
            saber
            fists
            ammo
]]
local function ref()
    for id in pairs(game.GetAmmoTypes()) do
        local data = game.GetAmmoData(id)
        if data.name == 'RPG_Rocket' then continue end
        local dat
        if data.name == 'RPG_Round' then
            dat = {
                nicename = data.name,
                class = string.upper(data.name),
                type = 'ammo',
                weptype = 'ammo',
                icon = 'ammo',
                kg = 1,
                giveamount = 15,
                hiddenamount = 1,
                amount = 1,
                togive = 0,
            }
        else
            dat = {
                nicename = data.name,
                class = string.upper(data.name),
                type = 'ammo',
                weptype = 'ammo',
                icon = 'ammo',
                kg = .05,
                giveamount = 15,
                hiddenamount = 1,
                amount = 1,
                togive = 99,
            }
        end

        RegisterItem(dat)
    end
end

ref()
hook.Add('PostGamemodeLoaded', 'kgakwgfkaifwajfk_LOADITEMS', function() ref() end)
--[[

    medicine section

]]
--[[
RegisterItem{
    nicename = 'Бакта-бинт',
    class = 'none',
    weptype = 'none',
    type = 'medicine',
    icon = '',
    kg = .25,
    customuse = function(ply, limb, target)
        local org = ply:GetOrganism()
        org:Treat('wound', limb)
        org:Treat('bleeding', limb)
        local max = ply:GetMaxHealth()
        ply:SetHealth(math.min(ply:Health() + max * .1, -- 10%
            max))

        print(ply, limb)
        return true
    end
}

RegisterItem{
    nicename = 'Шина',
    class = 'none',
    weptype = 'none',
    type = 'medicine',
    icon = '',
    kg = .25,
    customuse = function(ply, limb, target)
        local org = ply:GetOrganism()
        org:Treat('fracture', limb)
        org:Sync(ply)
        print(ply, limb)
        return true
    end
}

RegisterItem{
    nicename = 'Морфин',
    class = 'none',
    weptype = 'none',
    type = 'medicine',
    icon = '',
    kg = .25,
    customuse = function(ply, limb, target)
        local org = ply:GetOrganism()
        org:AddPulse(-10)
        print(ply, limb)
        return true
    end
}

RegisterItem{
    nicename = 'Адреналин',
    class = 'none',
    weptype = 'none',
    type = 'medicine',
    icon = '',
    kg = .25,
    customuse = function(ply, limb, target)
        local org = ply:GetOrganism()
        org:AddPulse(20)
        print(ply, limb)
        return true
    end
}

RegisterItem{
    nicename = 'Дефибрилятор',
    class = 'none',
    weptype = 'none',
    type = 'medicine',
    icon = '',
    kg = .25,
    customuse = function(ply, limb, target)
        local org = ply:GetOrganism()
        if limb ~= 'chest' then return false end
        org:AddPulse(80)
        print(ply, limb)
        return true
    end
}

RegisterItem{
    nicename = 'Жгут',
    class = 'none',
    weptype = 'none',
    type = 'medicine',
    amount = 1,
    icon = '',
    kg = .25,
    customuse = function(ply, limb, target)
        local org = ply:GetOrganism()
        org:Treat('bleeding', limb)
        return true
    end
}
--]]
--[[

    end of medicine section

]]
RegisterItem{
    nicename = 'DC-15s',
    class = 'masita_dc15s',
    weptype = 'main',
    type = 'weapon',
    icon = 'dc15s',
    width = 2,
    height = 1,
    kg = 10,
}

RegisterItem{
    nicename = 'DC-19',
    class = 'masita_dc19',
    weptype = 'main',
    type = 'weapon',
    icon = 'dc15s',
    width = 2,
    height = 1,
    kg = 18,
}

RegisterItem{
    nicename = 'DC-15s Grenadier',
    class = 'masita_dc15s_grenadier',
    weptype = 'main',
    type = 'weapon',
    icon = 'dc15s',
    width = 2,
    height = 1,
    kg = 10,
}

RegisterItem{
    nicename = 'DC-15a',
    class = 'masita_dc15a',
    weptype = 'main',
    type = 'weapon',
    icon = 'dc15a',
    width = 3,
    height = 1,
    kg = 13,
}

RegisterItem{
    nicename = 'DC-15le',
    class = 'masita_dc15le',
    weptype = 'main',
    type = 'weapon',
    icon = 'dc15a',
    width = 3,
    height = 1,
    kg = 15,
}

RegisterItem{
    nicename = 'DC-15a Heavy',
    class = 'masita_dc15a_heavy',
    weptype = 'main',
    type = 'weapon',
    icon = 'dc15a',
    width = 3,
    height = 1,
    kg = 20,
}

RegisterItem{
    nicename = 'z6 Rotary Blaster',
    class = 'arccw_meeks_z6',
    weptype = 'heavy',
    type = 'weapon',
    icon = 'z6',
    width = 4,
    height = 2,
    kg = 25,
}

RegisterItem{
    nicename = 'DC-15sa',
    class = 'masita_dc15sa',
    weptype = 'secondary',
    type = 'weapon',
    icon = 'dc17',
    width = 1,
    height = 1,
    kg = 8,
}

RegisterItem{
    nicename = 'DC-17',
    class = 'masita_dc17',
    weptype = 'secondary',
    type = 'weapon',
    icon = 'dc17',
    width = 1,
    height = 1,
    kg = 5,
}

RegisterItem{
    nicename = 'DC-17s Red',
    class = 'masita_dc17s_red',
    weptype = 'secondary',
    type = 'weapon',
    icon = 'dc17',
    width = 1,
    height = 1,
    kg = 5,
}

RegisterItem{
    nicename = 'DC-17 Extended',
    class = 'masita_dc17ext',
    weptype = 'secondary',
    type = 'weapon',
    icon = 'dc17',
    width = 1,
    height = 1,
    kg = 5,
}

RegisterItem{
    nicename = 'DC-17s',
    class = 'masita_dc17s',
    weptype = 'secondary',
    type = 'weapon',
    icon = 'dc17',
    width = 1,
    height = 1,
    kg = 8,
}

RegisterItem{
    nicename = 'DC-15x',
    class = 'luna_weapons_dc15x',
    weptype = 'main',
    type = 'weapon',
    icon = 'dc15x',
    width = 3,
    height = 1,
    kg = 20,
}

RegisterItem{
    nicename = 'DC-17 Dual',
    class = 'masita_dual_dc17',
    weptype = 'secondary',
    type = 'weapon',
    icon = 'dc17dual',
    width = 2,
    height = 2,
    kg = 10,
}

RegisterItem{
    nicename = 'DC-17s Dual',
    class = 'masita_dual_dc17s',
    weptype = 'secondary',
    type = 'weapon',
    icon = 'dc17dual',
    width = 2,
    height = 2,
    kg = 16,
}

RegisterItem{
    nicename = 'DC-17 Dual Extended',
    class = 'masita_dual_dc17ext',
    weptype = 'secondary',
    type = 'weapon',
    icon = 'dc17dual',
    width = 2,
    height = 2,
    kg = 10,
}

RegisterItem{
    nicename = 'a280 Rifle',
    class = 'luna_weapons_a280cfe',
    weptype = 'main',
    type = 'weapon',
    icon = 'a280',
    width = 4,
    height = 1,
    kg = 20,
}

RegisterItem{
    nicename = 'CR-2',
    class = 'masita_cr2',
    weptype = 'main',
    type = 'weapon',
    icon = 'cr2',
    width = 2,
    height = 2,
    kg = 16,
}

RegisterItem{
    nicename = 'DC-17m',
    class = 'arccw_kraken_dc17m',
    weptype = 'main',
    type = 'weapon',
    icon = 'dc17m',
    width = 4,
    height = 2,
    kg = 20,
}

RegisterItem{
    nicename = 'DC-17m Launcher',
    class = 'masita_dc17m_launcher',
    weptype = 'main',
    type = 'weapon',
    icon = 'dc17ml',
    width = 4,
    height = 2,
    kg = 20,
}

RegisterItem{
    nicename = 'Бомба',
    class = 'm9k_suicide_bomb',
    weptype = 'var',
    type = 'weapon',
    icon = 'bomb',
    width = 4,
    height = 2,
    kg = 8,
}

RegisterItem{
    nicename = 'Мина',
    class = 'm9k_proxy_mine',
    weptype = 'var',
    type = 'weapon',
    icon = 'mine',
    width = 4,
    height = 2,
    kg = 5,
}

-- RegisterItem{
--     nicename = 'DC-17m',
--     class = 'arccw_kraken_dc17m',
--     weptype = 'main',
--     type = 'weapon',
--     icon = 'dc17m',
--     width = 4,
--     height = 2,
--     kg = 20,
-- }
RegisterItem{
    nicename = 'BTRS-41',
    class = 'arccw_btrs_41',
    weptype = 'heavy',
    type = 'weapon',
    icon = 'btrs',
    width = 5,
    height = 2,
    kg = 20,
}

RegisterItem{
    nicename = 'RPS-6',
    class = 'arccw_sw_rocket_rps6',
    weptype = 'heavy',
    type = 'weapon',
    icon = 'rps6',
    width = 5,
    height = 2,
    kg = 25,
}

RegisterItem{
    nicename = 'IQA-11',
    class = 'masita_iqa11',
    weptype = 'main',
    type = 'weapon',
    icon = 'iqa11',
    width = 5,
    height = 2,
    kg = 15,
}

RegisterItem{
    nicename = 'DC-15x',
    class = 'masita_dc15x',
    weptype = 'main',
    type = 'weapon',
    icon = 'dc15x',
    width = 5,
    height = 2,
    kg = 12,
}

RegisterItem{
    nicename = 'NT-242',
    class = 'masita_nt242',
    weptype = 'main',
    type = 'weapon',
    icon = 'nt242',
    width = 5,
    height = 2,
    kg = 15,
}

RegisterItem{
    nicename = 'SB-2',
    class = 'masita_sb2',
    weptype = 'heavy',
    type = 'weapon',
    icon = 'sb2',
    width = 3,
    height = 2,
    kg = 10,
}

RegisterItem{
    nicename = 'DP-23',
    class = 'masita_dp23',
    weptype = 'heavy',
    type = 'weapon',
    icon = 'sb2',
    width = 3,
    height = 2,
    kg = 12,
}

RegisterItem{
    nicename = 'STW-48',
    class = 'luna_weapons_stw48',
    weptype = 'main',
    type = 'weapon',
    icon = 'stw48',
    width = 3,
    height = 2,
    kg = 22,
}

RegisterItem{
    nicename = 'TL-50',
    class = 'luna_weapons_tl50',
    weptype = 'main',
    type = 'weapon',
    icon = 'tl50',
    width = 3,
    height = 2,
    kg = 20,
}

RegisterItem{
    nicename = 'Valken-38x',
    class = 'masita_valken38x',
    weptype = 'main',
    type = 'weapon',
    icon = 'valken',
    width = 4,
    height = 2,
    kg = 12,
}

RegisterItem{
    nicename = 'WESTAR-M5',
    class = 'masita_westarm5',
    weptype = 'main',
    type = 'weapon',
    icon = 'westarm5',
    width = 4,
    height = 2,
    kg = 10,
}

RegisterItem{
    nicename = 'WESTAR-M5 Alpha',
    class = 'masita_westarm5_alpha',
    weptype = 'main',
    type = 'weapon',
    icon = 'westarm5',
    width = 4,
    height = 2,
    kg = 10,
}

RegisterItem{
    nicename = 'Wibro-Nóż',
    class = 'vibrokinfe_base',
    weptype = 'var',
    type = 'weapon',
    icon = 'knife',
    width = 1,
    height = 1,
    kg = 2,
}

RegisterItem{
    nicename = 'Tarcza Klonów',
    class = 'masita_repshield',
    weptype = 'var',
    type = 'weapon',
    icon = 'shield',
    width = 3,
    height = 3,
    kg = 15,
}

RegisterItem{
    nicename = 'Tarcza Gwardii',
    class = 'masita_cgshield',
    weptype = 'var',
    type = 'weapon',
    icon = 'shield',
    width = 3,
    height = 3,
    kg = 15,
}

-- RegisterItem{
--     nicename = 'Медикаменты',
--     class = 'rust_syringe',
--     weptype = 'var',
--     type = 'weapon',
--     icon = 'hook',
--     width = 2,
--     height = 2,
--     kg = 8,
-- }
RegisterItem{
    nicename = 'Szczypce',
    class = 'defuser_bomb',
    weptype = 'var',
    type = 'weapon',
    icon = 'splies', -- spanner.png
    width = 1,
    height = 1,
    kg = 8,
}

RegisterItem{
    nicename = 'Zestaw medyczny',
    class = 'weapon_bactainjector',
    weptype = 'var',
    type = 'weapon',
    icon = 'medpack', -- med-pack.png
    width = 4,
    height = 4,
    kg = 2,
}

RegisterItem{
    nicename = 'Bandaże',
    class = 'rust_syringe',
    weptype = 'var',
    type = 'weapon',
    icon = 'bandage', -- bandage-roll.png
    width = 1,
    height = 1,
    kg = 8,
}

RegisterItem{
    nicename = 'Defibrylator',
    class = 'weapon_defibrillator',
    weptype = 'var',
    type = 'weapon',
    icon = 'defib', -- first-aid-kit.png
    width = 2,
    height = 2,
    kg = 2,
}

RegisterItem{
    nicename = 'Zatrzask',
    class = 'cc_modules_repairkit',
    weptype = 'var',
    type = 'weapon',
    icon = 'fixator', -- tinker.png
    width = 2,
    height = 2,
    kg = 2,
}

RegisterItem{
    nicename = 'Kajdanki',
    class = 'handcuffs',
    weptype = 'var',
    type = 'weapon',
    icon = 'handcuffs', -- handcuffs.png
    width = 1,
    height = 1,
    kg = 2,
}

RegisterItem{
    nicename = 'Palnik',
    class = 'weapon_lvsrepair',
    weptype = 'var',
    type = 'weapon',
    icon = 'fusion', -- screwdriver.png
    width = 2,
    height = 2,
    kg = 2,
}

RegisterItem{
    nicename = 'Naprawa pancerza',
    class = 'armorkit',
    weptype = 'var',
    type = 'weapon',
    icon = 'armor', --overdrive.png
    width = 2,
    height = 2,
    kg = 2,
}

RegisterItem{
    nicename = 'Tablet',
    class = 'fort_datapad',
    weptype = 'var',
    type = 'weapon',
    icon = 'tablet', -- smartphone.png
    width = 2,
    height = 2,
    kg = 5,
}

RegisterItem{
    nicename = 'Kamuflaż',
    class = 'rdv_camoswep',
    weptype = 'var',
    type = 'weapon',
    icon = 'camo', -- spy.png
    width = 2,
    height = 2,
    kg = 2,
}

RegisterItem{
    nicename = 'Lornetka',
    class = 'waypoint_designator',
    weptype = 'var',
    type = 'weapon',
    icon = 'binos', -- binoculars.png
    width = 2,
    height = 2,
    kg = 2,
}

-- RegisterItem{
--     nicename = 'Вибро-Нож',
--     class = 'rust_syringe',
--     weptype = 'var',
--     type = 'weapon',
--     icon = 'hook',
--     width = 2,
--     height = 2,
--     kg = 8,
-- }
-- RegisterItem{
--     nicename = 'Вибро-Нож',
--     class = 'rust_syringe',
--     weptype = 'var',
--     type = 'weapon',
--     icon = 'hook',
--     width = 2,
--     height = 2,
--     kg = 8,
-- }
-- RegisterItem{
--     nicename = 'Вибро-Нож',
--     class = 'rust_syringe',
--     weptype = 'var',
--     type = 'weapon',
--     icon = 'hook',
--     width = 2,
--     height = 2,
--     kg = 8,
-- }
-- RegisterItem{
--     nicename = 'Вибро-Нож',
--     class = 'rust_syringe',
--     weptype = 'var',
--     type = 'weapon',
--     icon = 'hook',
--     width = 2,
--     height = 2,
--     kg = 8,
-- }
for _, info in pairs(list.Get('Weapon')) do
    local class = info.ClassName
    if weapons.GetStored(class) and not sup_inv.ValidItem(class) then
        local wepdata = weapons.GetStored(class)
        RegisterItem{
            nicename = '[FALLBACK] ' .. wepdata.PrintName and wepdata.PrintName or '',
            class = class,
            weptype = 'var',
            type = 'weapon',
            icon = 'empty',
            kg = 4,
        }
    end
end

ref()

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
