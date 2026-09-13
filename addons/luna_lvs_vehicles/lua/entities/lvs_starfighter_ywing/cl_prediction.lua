--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

function ENT:PredictPoseParameters()
    local Pod = self:GetTopGunnerSeat()

    if not IsValid( Pod ) then return end

    local plyL = LocalPlayer()
    local ply = Pod:GetDriver()

    if ply ~= plyL then return end

    self:SetPoseParameterTopGun( Pod:lvsGetWeapon() )

    self:InvalidateBoneCache()
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
