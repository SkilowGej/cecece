--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

att.PrintName = "[ Starwars ] Stun Rounds"
att.AbbrevName = "Stun round (10 seconds)"
att.SortOrder = -2
att.Icon = Material("") -- Укажите путь к иконке, если она есть
att.Description = "Stun round."

att.Desc_Pros = {
    "Causes stun for 10 seconds!"
}
att.Desc_Cons = {}
att.Desc_Neutrals = {}

att.Slot = {"sw_stun"}

att.SortOrder = -9001
att.AutoStats = true

att.Override_AmmoPerShot = 1 -- Обычно для патронов количество на один выстрел 1
att.Override_Num_Priority = 9001
att.Override_Tracer = "effect_sw_laser_blue_stun"

-- Обработчик попадания пули
att.Hook_BulletHit = function(wep, data)
    local target = data.tr.Entity
    if IsValid(target) and target:IsPlayer() then
        -- Применяем эффект стана к цели
        target:SetNWFloat("StunEndTime", CurTime() + 15) -- Устанавливаем время окончания стана
        target:SetNWBool("IsStunned", true)
        
        -- Пример использования: заблокировать движение цели
        target:SetMoveType(MOVETYPE_NONE)
        
        -- Дополнительные действия (например, визуальные эффекты) можно добавить здесь
    end
end

-- Обработчик звукового эффекта при выстреле
att.Hook_GetShootSound = function(wep, sound)
    return false -- Используем собственный звук выстрела
end

att.Hook_AddShootSound = function(wep, data)
    -- Убедитесь, что путь к звуковому файлу правильный и файл существует
    if file.Exists("sound/w/stun_sound.wav", "GAME") then
        wep:EmitSound("w/stun_sound.wav", data.volume, data.pitch, 1, CHAN_WEAPON)
    end
end

-- Обновляем состояние стана на клиенте
hook.Add("Think", "UpdateStunStatus", function()
    for _, ply in ipairs(player.GetAll()) do
        if ply:GetNWBool("IsStunned", false) and CurTime() > ply:GetNWFloat("StunEndTime", 0) then
            ply:SetNWBool("IsStunned", false)
            ply:SetMoveType(MOVETYPE_WALK) -- Восстанавливаем обычное движение
        end
    end
end)


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
