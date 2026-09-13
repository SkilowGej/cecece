--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local force = {}
force.PrintName = "Better Heal"
force.Author = "Memeti"
force.Description = "Heal yourself using the Force"
force.id = "betterheal"
force.Cooldown = 2
force.StartUse = function( ply )
	local available = ply:lscsGetForce()
	local need = ply:GetMaxHealth() - ply:Health()
    local MaxHeal = ply:GetMaxHealth() * 0.2

	if need > 0 and available >= 5 then
		local take = math.min( need, available, MaxHeal )
        local ForceUse = math.Round((take / MaxHeal)*10)
		ply:lscsTakeForce( ForceUse )
		ply:SetHealth( math.min(ply:Health() + take ) )

		ply:EmitSound("lscs/force/heal.mp3")

		local effectdata = EffectData()
			effectdata:SetOrigin( ply:GetPos() )
			effectdata:SetEntity( ply )
		util.Effect( "force_heal", effectdata, true, true )

        return true
	end

    return false
end
LSCS:RegisterForce( force )


local force = {}
force.PrintName = "Group Heal"
force.Author = "Apollo"
force.Description = "Mend the injuries of your nearby allies"
force.id = "groupheal"
force.Cooldown = 10
force.StartUse = function( ply )
    local forceuse = 60
    local CanDo = ply:lscsGetForce() >= forceuse
    if not CanDo then return end

    for k,v in ipairs(ents.FindInSphere(ply:GetPos(), 150)) do
        if not IsValid(v) or not v:IsPlayer() or not v:Alive() then continue end
        v:SetHealth(math.min(v:Health() + v:GetMaxHealth()*0.4, v:GetMaxHealth()))
        local effectdata = EffectData()
            effectdata:SetOrigin( v:GetPos() )
            effectdata:SetEntity( v )
        util.Effect( "force_heal", effectdata, true, true )
    end
    local ent = ents.Create("pfx4_0b")
    if IsValid(ent) then
        local stopvfx = 1.5
        ent:SetPos(ply:GetPos())
        ent:SetOwner(ply)
        ent:SetParent(ply)
        ent:Spawn()
        timer.Simple(stopvfx, function()
            if not IsValid(ent) then return end
            SafeRemoveEntity(ent)
        end)
    end

    ply:lscsTakeForce( forceuse )

    return true
end
LSCS:RegisterForce( force )

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
