--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local force = {}
force.PrintName = "Boulder Throw"
force.Author = "Memeti"
force.Description = "Lob a boulder at your foe"
force.id = "boulderthrow"
force.Cooldown = 30
force.StartUse = function( ply )
    if ply:lscsGetForce() < 40 then return end -- do we have enough force points ?
    local Time = CurTime()
    if not ply.ConfirmBoulder or ply.ConfirmBoulder < CurTime() then
        ply.ConfirmBoulder = CurTime() + 5
        ply:ChatPrint("Activate again to confirm boulder throw.")
        return
    end
    ply.ConfirmBoulder = nil

	ply:lscsTakeForce( 40 ) -- take amount of force we need
    
	LSCS:PlayVCDSequence( ply, "gesture_signal_halt", 0 ) -- play animation
    
    local ent = ents.Create( "boulder" )
    ent:SetPos( ply:EyePos() + (ply:GetAimVector() * 60) )
    ent:SetAngles( ply:EyeAngles() )
    ent:Spawn()
    ent:SetOwner( ply )

    local phys = ent:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:SetVelocity( ply:GetAimVector() * 1200 )
    end

    return true
end
LSCS:RegisterForce( force )



local force = {}
force.PrintName = "Rebuke"
force.Author = "Memeti"
force.Description = "Strengthen your resolve and reflect a percentage of damage back to the attacker"
force.id = "rebuke"
force.Cooldown = 10
force.StartUse = function( ply )
    local forceuse = 20
	local CanDo = ply:lscsGetForce() >= forceuse
	if not CanDo then return end

	ply:SetNWFloat("lscs_rebuke", CurTime() + 10)
    ply:lscsTakeForce( forceuse )

    return true
end
LSCS:RegisterForce( force )



local force = {}
force.PrintName = "Force Wave"
force.Author = "Apollo"
force.Description = "Create a ripple in the force to repel and damage your opponents"
force.id = "forcewave"
force.Cooldown = 5
force.StartUse = function( ply )
    local forceuse = 40
    local CanDo = ply:lscsGetForce() >= forceuse
    if not CanDo then return end

    for k,v in ipairs(ents.FindInCone(ply:GetPos(), ply:GetAimVector(), 250, 0.5)) do
        if not IsValid(v) then continue end
        v:TakeDamage(75, ply, ply)
        local plypos = ply:GetPos()
        local vpos = v:GetPos()
        local dir = (vpos - plypos)
        local dist = dir:LengthSqr()
        dir:Normalize()
        local maxforce = 300
        local pushforce = math.max(maxforce / dist, 1)
        v:SetVelocity((dir + Vector(0,0,0.4)) * pushforce)
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
