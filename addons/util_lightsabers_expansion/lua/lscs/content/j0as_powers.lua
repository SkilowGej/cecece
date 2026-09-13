--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local force = {}
force.PrintName = "Asfixia"
force.Author = "j0as"
force.Description = "Usa la Fuerza para asfixiar a tu objetivo"
force.id = "asfixia"

-- Función para aplicar daño periódico al objetivo
local function ApplyDamage(ply)
    if IsValid(ply) then
        ply:TakeDamage(10, ply, ply)  -- Aplica el daño al objetivo
    end
end

-- Tabla para rastrear los objetivos que están siendo estrangulados y elevados
local asphyxiationTargets = {}

-- Función llamada cuando se activa el poder
force.OnClk = function(ply, TIME)
    if not IsValid(ply.AsphyxiationTarget) then
        return
    end

    local target = ply.AsphyxiationTarget

    -- Si el objetivo ya está siendo estrangulado y elevado, no se hace nada
    if asphyxiationTargets[target] then
        return
    end

    -- Marca al objetivo como estrangulado y elevado
    asphyxiationTargets[target] = true

    -- Calcula la nueva posición para el objetivo
    local newPos = target:GetPos() + Vector(0, 0, 35) -- Ajusta la altura según sea necesario

    -- Establece la nueva posición del objetivo
    target:SetPos(newPos)

    -- Envía un mensaje de notificación al objetivo indicando que está siendo estrangulado por la Fuerza
    target:Notify("Estás siendo estrangulado por la fuerza.")

    -- Envía un mensaje en el chat indicando que el objetivo se levanta mientras está siendo estrangulado por la Fuerza
    target:Say("/me se levanta siendo estrangulado por la fuerza.")

    -- Función para aplicar daño periódico al objetivo cada segundo
    local function DamageLoop()
        if IsValid(target) then
            ApplyDamage(target)
            timer.Create("AsphyxiationDamage_" .. target:EntIndex(), 1, 0, function() ApplyDamage(target) end)  -- Inicia el bucle de daño
        else
            asphyxiationTargets[target] = nil
        end
    end

    -- Inicia el bucle de daño
    DamageLoop()
end

-- Función llamada cuando se inicia el uso del poder
force.StartUse = function(ply)
    -- Verifica que el jugador tenga un objetivo válido y cercano
    local tr = util.TraceLine(util.GetPlayerTrace(ply))
    if not tr.Entity or tr.Entity:IsWorld() then
        return false  -- Devuelve false para indicar que no se pudo iniciar el uso del poder
    end
    
    ply.AsphyxiationTarget = tr.Entity
    return true
end

-- Función llamada cuando se detiene el uso del poder
force.StopUse = function(ply)
    -- Detiene el daño periódico
    local target = ply.AsphyxiationTarget
    if IsValid(target) then
        asphyxiationTargets[target] = nil
        target:SetPos(target:GetPos() - Vector(0, 0, 35)) -- Restablece la posición del objetivo

        -- Ajusta ligeramente la posición del jugador para que esté un poco por encima del suelo
        local trace = util.TraceEntity({start=target:GetPos(), endpos=target:GetPos() - Vector(0, 0, 10), filter=target}, target)
        if trace.Hit then
            target:SetPos(trace.HitPos + Vector(0, 0, 5)) -- Ajusta la posición por encima del suelo
        end

        timer.Remove("AsphyxiationDamage_" .. target:EntIndex())  -- Detiene el bucle de daño
    end
    ply.AsphyxiationTarget = nil
end

-- Registra el poder en el sistema de poderes del LSCS
LSCS:RegisterForce(force)




--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
