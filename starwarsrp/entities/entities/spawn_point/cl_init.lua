include('shared.lua')
function ENT:Draw()
    local p = LocalPlayer()
    if IsValid(p) and p:Alive() and p:IsAdmin() then
        local w = p:GetActiveWeapon()
        if IsValid(w) and w:GetClass() == 'gmod_tool' then
            self:DrawModel()
        end
    end
end