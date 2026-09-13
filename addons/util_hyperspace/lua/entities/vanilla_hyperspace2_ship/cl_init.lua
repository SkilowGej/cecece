--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

function ENT:Initialize()
    local sound1 = "vanilla/hyperspace/vanilla_hyperspace_01.wav"
    local sound2 = "vanilla/hyperspace/vanilla_hyperspace_02.wav"

    if self:GetPlaySound() == "1" then
        local choose = math.random(0,1)
    	if choose == 0 then
    		surface.PlaySound(sound1)
    	else
    		surface.PlaySound(sound2)
    	end
    end
end

function ENT:Draw()
    self:DrawModel()
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
