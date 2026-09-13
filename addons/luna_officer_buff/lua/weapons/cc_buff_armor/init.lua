--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile("shared.lua")
include("shared.lua")

SWEP.Buff_Logic = function(self)
    for k, v in pairs(ents.FindInSphere(self.Owner:GetPos(), self.Buff_Radius)) do
        if IsValid(v) and v:IsPlayer() and v:Alive() then
            net.Start("CC_BuffBase_SetHUDEffect")
            net.WriteColor(self.Buff_Color, false)
            net.WriteFloat(self.Buff_Timer)
            net.Send(v)

            -- Используем значение по умолчанию, если maxArmor не определен
            local maxArmor = v.maxArmor and v:maxArmor() or 300 -- Замените 300 на нужное значение по умолчанию

            local newArmor = math.min(v:Armor() + 150, maxArmor)
            v:SetArmor(newArmor)
        end
    end
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
