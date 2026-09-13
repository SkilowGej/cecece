--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if CLIENT then return end

ArcCW.ShieldPropPile    = {} -- { {Model = NULL, Weapon = NULL} }

local function SV_ArcCW_CollectGarbage()
    local removed = 0

    local newpile = {}

    for _, k in pairs(ArcCW.ShieldPropPile) do
        if IsValid(k.Weapon) then
            table.insert(newpile, k)

            continue
        end

        SafeRemoveEntity(k.Model)

        removed = removed + 1
    end

    ArcCW.ShieldPropPile = newpile

    if GetConVar("developer"):GetBool() and removed > 0 then
        print("Removed " .. tostring(removed) .. " Shield Models")
    end
end

timer.Create("ArcCW Shield Model Garbage Collector", 5, 0, SV_ArcCW_CollectGarbage)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
