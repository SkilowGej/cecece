Achievements = Achievements or {}

Achievements.colors = {
    back = Color( 0, 0, 0, 100 );
    white = Color( 255, 255, 255 );
    white2 = Color( 255, 255, 255, 50 );
    blue = Color( 7, 110, 203, 255 );
    gray = Color( 160, 160, 160, 255 );

    gray2 = Color( 160, 160, 160, 50 );
    green = Color( 80, 163, 47 );
    red = Color(236, 48, 48);
}

Achievements.mats = {
    bg1 = Material( 'luna_menus/achievements/achieve_icon/element_1.png', 'smooth mips' );
    bg2 = Material( 'luna_menus/achievements/achieve_icon/element_2.png', 'smooth mips' );
    bg3 = Material( 'luna_menus/achievements/achieve_icon/element_3.png', 'smooth mips' );

    completed1 = Material( 'luna_menus/achievements/gradient_bg.png', 'smooth mips' );
    -- completed2 = Material( 'luna_menus/achievements/lines_bg.png', 'smooth mips' );
    completed3 = Material( 'luna_menus/achievements/sparkles_1.png', 'smooth mips' );
}

Achievements.Table = {
    {
        name = 'DOMINACJA KLONÓW';
        description = 'zniszczyć droidy ';
        color = Color( 247, 163, 44 );
        reward = {
            -- Если оружие
            isWeapon = true;
            class = 'pistol';
            -- Если деньги, то:
            -- money = 1000;
            name = 'WESTAR-M5';
            image = Material( 'w.png', 'smooth mips' );
        };
        image = Material( 'luna_icons/eye-target.png', 'smooth mips' );
        -- Уникальное ID, кол-во необходимое, чтобы выполнить ачивку
        check = { 'KillDroids'; 500; };
    };

    -- {
    --     name = '';
    --     description = '';
    --     color = Color( 0, 0, 0 );
    --     reward = {
    --         money = 1000;
    --         name = '10, 000 РК';
    --         image = Material( 'w.png', 'smooth mips' );
    --     };
    --     image = Material( 'luna_icons/eye-target.png', 'smooth mips' );
    --     check = { 'Money1'; 20; };
    -- };
}

if SERVER then
    include('core/sh_metadata.lua')
    include('core/sv_achievements.lua')
    include('core/sv_hooks.lua')
    AddCSLuaFile('core/sh_metadata.lua')
    AddCSLuaFile('core/cl_achievements.lua')
    AddCSLuaFile('derma/cl_check.lua')
    AddCSLuaFile('derma/cl_item.lua')
    AddCSLuaFile('derma/cl_scroll.lua')
    AddCSLuaFile('derma/cl_util.lua')
else
    include('core/sh_metadata.lua')
    include('core/cl_achievements.lua')
    include('derma/cl_check.lua')
    include('derma/cl_item.lua')
    include('derma/cl_scroll.lua')
    include('derma/cl_util.lua')
end

