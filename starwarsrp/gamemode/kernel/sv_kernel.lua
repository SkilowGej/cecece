--
local forceUser_speedBoosts = {
    -- Профессия = скорость
    [TEAM_JEDI] = 200;
    [TEAM_JEDI1] = 125;
}

hook.Add( 'PlayerChangedTeam', 'speedBoost', function( p, oldT, newT )
    local speedBoost = forceUser_speedBoosts[ newT ]
    if speedBoost then
        local runSpeed = p:GetRunSpeed()
        p:SetRunSpeed( runSpeed + speedBoost )

        -- Если нужно обычный шаг тоже ускорять:
        /*p:SetWalkSpeed( p:GetWalkSpeed() + speedBoost )*/
    end
end )