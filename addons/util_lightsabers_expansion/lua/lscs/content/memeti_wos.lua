--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local force = {}
force.PrintName = "Whirlwind"
force.Author = "Memeti"
force.Description = "Use the force to lift your target"
force.id = "whirlwind"
force.OnClk =  function( ply, TIME )
    if not IsValid( ply.WindTarget ) then return end
    if ply.WindTarget:IsPlayer() and not ply.WindTarget:Alive() then ply.WindTarget = nil return end
    local vec = ( ( ply:EyePos() + ply:GetAimVector()*ply.WindDistance  ) - ply.WindTarget:GetPos() )
    local vec2 = ( ( ply:EyePos() + ply:GetAimVector()*2*ply.WindDistance  ) - ply.WindTarget:GetPos() )

    if ply.WindTarget:IsPlayer() or ply.WindTarget:IsNPC() then
        ply.WindTarget:SetLocalVelocity( vec*10 )
    else
        local phys = ply.WindTarget:GetPhysicsObject()
        phys:SetVelocity( vec*10 )
    end

    ply:lscsTakeForce( 1 )

    if ply:lscsGetForce() < 1 then
        local ed = EffectData()
        ed:SetOrigin( ply.WindTarget:GetPos() + Vector( 0, 0, 36 ) )
        ed:SetRadius( 128 )
        util.Effect( "rb655_force_repulse_out", ed, true, true )
        if ply.WindTarget:IsPlayer() then
            if timer.Exists("force_whirlwind_p1_" .. ply.WindTarget:SteamID64()) then
                timer.Remove("force_whirlwind_p1_" .. ply.WindTarget:SteamID64())
            end
        end
        ply.WindTarget = nil
    end

    if not ply:KeyReleased( IN_ATTACK2 ) then return end

    local ed = EffectData()
    ed:SetOrigin( ply.WindTarget:GetPos() + Vector( 0, 0, 36 ) )
    ed:SetRadius( 128 )
    util.Effect( "rb655_force_repulse_out", ed, true, true )
    if ply.WindTarget:IsPlayer() or ply.WindTarget:IsNPC() then
        ply.WindTarget:SetLocalVelocity( vec2*10 )
    else
        local phys = ply.WindTarget:GetPhysicsObject()
        phys:SetVelocity( vec2*10 )
    end
    if ply.WindTarget:IsPlayer() then
        if timer.Exists("force_whirlwind_p1_" .. ply.WindTarget:SteamID64()) then
            timer.Remove("force_whirlwind_p1_" .. ply.WindTarget:SteamID64())
        end
    end
    ply.WindTarget = nil
end
force.StartUse = function( ply )
    if ply:lscsGetForce() < 1 then return end
    if IsValid( ply.WindTarget ) then return end
    local tr = util.TraceLine( util.GetPlayerTrace( ply ) )
    local dist = tr.HitPos:Distance( ply:GetPos() )
    if not tr.Entity then return end
    if tr.LFS then return end
    if string.match(tr.Entity:GetClass(), "_pod") then return end
    if dist >= 400 then return end
    ply.WindTarget = tr.Entity
    ply.WindDistance = dist

    return true
end
force.StopUse = function( ply )
    if not IsValid( ply.WindTarget ) then return end
    local ed = EffectData()
    ed:SetOrigin( ply.WindTarget:GetPos() + Vector( 0, 0, 36 ) )
    ed:SetRadius( 128 )
    util.Effect( "rb655_force_repulse_out", ed, true, true )

    ply.WindTarget = nil
end
LSCS:RegisterForce( force )

local force = {}
force.PrintName = "Force Choke"
force.Author = "Memeti"
force.Description = "Squeeze the life out of your target"
force.id = "choke"
force.OnClk =  function( ply, TIME )
    if not IsValid( ply.ChokeTarget ) then return end
    if ply.ChokeTarget:IsPlayer() and not ply.ChokeTarget:Alive() then ply.ChokeTarget = nil return end
    local vec = ( ( ply:EyePos() + ply:GetAimVector()*ply.WindDistance  ) - ply.ChokeTarget:GetPos() )
    local vec2 = ( ( ply:EyePos() + ply:GetAimVector()*2*ply.WindDistance  ) - ply.ChokeTarget:GetPos() )

    if ply.ChokeTarget:IsPlayer() or ply.ChokeTarget:IsNPC() then
        ply.ChokeTarget:SetLocalVelocity( vec*10 )
        ply.ChokeTarget:TakeDamage(5, ply, ply)
    else
        local phys = ply.ChokeTarget:GetPhysicsObject()
        phys:SetVelocity( vec*10 )
    end

    ply:lscsTakeForce( 3 )

    if ply:lscsGetForce() < 3 then
        local ed = EffectData()
        ed:SetOrigin( ply.ChokeTarget:GetPos() + Vector( 0, 0, 36 ) )
        ed:SetRadius( 128 )
        util.Effect( "rb655_force_repulse_out", ed, true, true )
        if ply.ChokeTarget:IsPlayer() then
            if timer.Exists("force_whirlwind_p1_" .. ply.ChokeTarget:SteamID64()) then
                timer.Remove("force_whirlwind_p1_" .. ply.ChokeTarget:SteamID64())
            end
        end
        ply.ChokeTarget = nil
    end
end
force.StartUse = function( ply )
    if ply:lscsGetForce() < 1 then return end
    if IsValid( ply.ChokeTarget ) then return end
    local tr = util.TraceLine( util.GetPlayerTrace( ply ) )
    local dist = tr.HitPos:Distance( ply:GetPos() )
    if not tr.Entity then return end
    if tr.LFS then return end
    if string.match(tr.Entity:GetClass(), "_pod") then return end
    if dist >= 400 then return end
    ply.ChokeTarget = tr.Entity
    ply.WindDistance = dist

    return true
end
force.StopUse = function( ply )
    if not IsValid( ply.ChokeTarget ) then return end
    local ed = EffectData()
    ed:SetOrigin( ply.ChokeTarget:GetPos() + Vector( 0, 0, 36 ) )
    ed:SetRadius( 128 )
    util.Effect( "rb655_force_repulse_out", ed, true, true )

    ply.ChokeTarget = nil
end
LSCS:RegisterForce( force )



local force = {}
force.PrintName = "Cloak"
force.Author = "Memeti"
force.Description = "Shroud yourself in the force"
force.id = "cloak" -- lowercase only
-- force.Spawnable = false  -- uncomment to unlist in q-menu
force.Cooldown = 10 -- cooldown in seconds

force.OnClk =  function( ply, TIME )
    if not ply:GetNWBool("IsCloaked", false) then return end
    if not ply.LSCS_Cloak then return end
    if ply:lscsGetForce() < 0.2 then ply:EndCloak() return end
    ply:lscsTakeForce( 0.5 )
end

force.StartUse = function( ply )
    if ply:lscsGetForce() < 1 then return end
    if ply:GetNWBool("IsCloaked", false) then
        ply.LSCS_Cloak = false
        ply:EndCloak()
        return
    end
    ply:SetNWBool("IsCloaked", true)
    ply.LSCS_Cloak = true

    return true
end

force.StopUse = function( ply )
	return
end

LSCS:RegisterForce( force )

local function EndAdrenaline(ply)
    if not ply.lscs_adrenaline then return end
    ply:SetRunSpeed(ply:GetRunSpeed() - 200)
    ply.lscs_adrenaline = false
end
local force = {}
force.PrintName = "Adrenaline"
force.Author = "Memeti"
force.Description = "Speed yourself up with the force"
force.id = "adrenaline" -- lowercase only
-- force.Spawnable = false  -- uncomment to unlist in q-menu
force.Cooldown = 10 -- cooldown in seconds

force.OnClk =  function( ply, TIME )
    if not ply.lscs_adrenaline then return end
    if ply:lscsGetForce() < 1 then EndAdrenaline(ply) return end
    ply:lscsTakeForce(0.5)
end

force.StartUse = function( ply )
    if ply.lscs_adrenaline then return end
    ply.lscs_adrenaline = true
    ply:SetRunSpeed(ply:GetRunSpeed() + 200)

    return true
end

force.StopUse = function( ply )
    if not ply.lscs_adrenaline then return end
	ply.lscs_adrenaline = false
    ply:SetRunSpeed(ply:GetRunSpeed() - 200)
end

LSCS:RegisterForce( force )


local force = {}
force.PrintName = "Teleport"
force.Author = "Memeti"
force.Description = "Transmit yourself to a location using the Force"
force.id = "teleport"
force.Cooldown = 2
force.StartUse = function( ply )
    local forceuse = 20
    if ply:lscsGetForce() < forceuse then return end

    local speed = 4000;
    local bFoundEdge = false;

    ply:SetNW2Float("wOS.ShowBlink", 0 );

    local hullTrace = util.TraceHull({
        start = ply:EyePos(),
        endpos = ply:EyePos() + ply:EyeAngles():Forward() * 1500,
        filter = ply,
        mins = Vector(-16, -16, 0),
        maxs = Vector(16, 16, 9)
    });

    local groundTrace = util.TraceEntity({
        start = hullTrace.HitPos + Vector(0, 0, 1),
        endpos = hullTrace.HitPos - (ply:EyePos() - ply:GetPos()),
        filter = ply
    }, ply);

    local edgeTrace;

    if (hullTrace.Hit and hullTrace.HitNormal.z <= 0) then
        local ledgeForward = Angle(0, hullTrace.HitNormal:Angle().y, 0):Forward();
        edgeTrace = util.TraceEntity({
            start = hullTrace.HitPos - ledgeForward * 33 + Vector(0, 0, 40),
            endpos = hullTrace.HitPos - ledgeForward * 33,
            filter = ply
        }, ply);

        if (edgeTrace.Hit and !edgeTrace.AllSolid) then
            local clearTrace = util.TraceHull({
                start = hullTrace.HitPos,
                endpos = hullTrace.HitPos + Vector(0, 0, 35),
                mins = Vector(-16, -16, 0),
                maxs = Vector(16, 16, 1),
                filter = ply
            });

            bFoundEdge = !clearTrace.Hit;
        end;
    end;

    if (!bFoundEdge and groundTrace.AllSolid) then
        return;
    end;

    local endPos = ( bFoundEdge and edgeTrace.HitPos ) or groundTrace.HitPos;

    ply:SetPos( endPos )
    ply:EmitSound("blink/exit" .. math.random(1, 2) .. ".wav");

    ply:lscsTakeForce( forceuse )

    return true
end
LSCS:RegisterForce( force )


local force = {}
force.PrintName = "Force Blind"
force.Author = "Memeti"
force.Description = "Enter your opponent's mind and blind them for a short time"
force.id = "blind"
force.Cooldown = 15
force.StartUse = function( ply )
    local forceuse = 80
    local CanDo = ply:lscsGetForce() >= forceuse
    if not CanDo then return end

    for k, v in ipairs(ents.FindInSphere(ply:GetPos(), 200)) do
        if not IsValid(v) or not v:IsPlayer() or not v:Alive() or v == ply then continue end
        v:ScreenFade(SCREENFADE.OUT, Color(0, 0, 0, 255), 0.5, 10)
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
