-- Definiujemy ID skilla (musi być identyczne z nazwą folderu, w którym jest ten plik)
local skillID = "damage_critical" 

-- Pobieramy istniejący obiekt lub tworzymy nowy, jeśli nie istnieje
local skill = re.skill.FindByID(skillID) or re.skill.New()
skill.unique = skillID

-- Konfiguracja wyświetlania w menu
skill.name = "Стрельба по шлемам"
skill.desc = "Урон от попадания в головы НПС увеличен на %d%%."
skill.subdesc = "Крит урон +%d%%"
skill.icon = Material("luna_icons/skull-crack.png", "smooth noclamp")

if SERVER then
    -- Rejestracja hooka serwerowego dla obrażeń
    skill:Hook("ScaleNPCDamage", "Skill_DamageCritical_" .. skillID, function(target, hitgroup, dmginfo)
        local attacker = dmginfo:GetAttacker()
        
        -- Sprawdzamy czy atakujący to gracz i czy trafił w głowę
        if IsValid(attacker) and attacker:IsPlayer() and hitgroup == HITGROUP_HEAD then
            -- Pobieramy dane z drzewka umiejętności (używając poprawnej nazwy re.skill)
            local skillData = re.skill.FindTreeBySkillID(skillID)
            if not skillData then return end -- Zabezpieczenie przed nil
            
            -- Pobieramy poziom umiejętności postaci
            local skillLevel = attacker:GetCharSkillLevel(skillData.unique)
            if skillLevel <= 0 then return end
            
            -- Obliczamy bonusowe obrażenia na podstawie danych z drzewka
            local bonusData = skillData.data(attacker, skillLevel)
            if bonusData and bonusData[1] then
                dmginfo:ScaleDamage(1 + (bonusData[1] / 100))
            end
        end
    end)
end

-- Kluczowy krok: Rejestrujemy w pełni skonfigurowany skill w systemie
re.skill.Register(skill)