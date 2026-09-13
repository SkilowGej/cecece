--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

-- RunConsoleCommand("sv_tfa_bullet_penetration_power_mul", "0")

hook.Add( "EntityTakeDamage", "SWRPShields:Effects", function( ent, dmginfo )
    if not ent.isshield then return end
    local pos1 = dmginfo:GetDamagePosition()
    local pos2 =  ent.gen:GetPos()

    local tr = util.TraceLine( {
        start = pos2,
        endpos = pos1,
        filter = {ent.gen}
    } )

    local effectdata = EffectData()
    effectdata:SetOrigin( tr.HitPos )
    effectdata:SetNormal( (tr.HitPos - pos2 ):GetNormalized() )
    effectdata:SetScale(dmginfo:GetDamage() * 5)
    util.Effect( "riffle", effectdata )
    sound.Play("swrpshield/shoot" .. math.random(1, 3) .. ".wav", tr.HitPos,100,100,1)
end )

hook.Add("PhysgunPickup", "SWRPShields:Unfreeze", function(ply,ent)
    if ent.isshield or (ent.isgenerator and ent:GetSequence() == 3) then return false end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
