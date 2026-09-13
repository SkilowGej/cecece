--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

SWRPShield = SWRPShield or {}
SWRPShield.ents = {}

local shieldmat = Material( "effects/shieldgen/joeisgay" )
local col1 = Color(50,50,255,255)

hook.Add( "PostDrawTranslucentRenderables", "SWRPShield:DrawLasers", function( bDepth, bSkybox )
    if bSkybox then return end
    for ent,_ in pairs(SWRPShield.ents) do
        if not IsValid(ent) then continue end
        if ent:GetSequence() != 3 then return end
        local StartPos, Angle = ent:GetBonePosition(ent:LookupBone( "gen" ))
        render.SetMaterial( shieldmat )
        render.DrawBeam( StartPos, StartPos + Vector(0,0,ent.laserlength) , 3 + math.Rand(0,2), 1, 0, col1 )
        render.SetMaterial( shieldmat )
        render.DrawBeam( StartPos, StartPos + Vector(0,0,ent.laserlength) , 1 + math.Rand(0.5,1), 1, 0, color_white )
    end
end )

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
