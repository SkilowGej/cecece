include('shared.lua')

local mat_lightcone = Material( "models/Jellyton/BF2/Misc/Props/Command_Post/M_LightCone_01_Hi_D" )
local mat_postbase = Material( "models/Jellyton/BF2/Misc/Props/Command_Post/M_REP_CommandPost_01" )
local mat_sepinsignia = Material( "models/Jellyton/BF2/Misc/Props/Command_Post/M_SEP_Insignia" )
local mat_repinsignia = Material( "models/Jellyton/BF2/Misc/Props/Command_Post/M_REP_Insignia" )

function ENT:Draw()
    -- self:DrawModel()

    self:DrawModel()
    local faction = self:GetNWString('Team')
    local white = Vector(1, 1, 1)

    local teams = CONTROLPOINT_TEAMS

    if faction == CONTROL_REPUBLIC then
        mat_lightcone:SetVector( "$color2", teams[CONTROL_REPUBLIC].color:ToVector() )
        mat_repinsignia:SetVector( "$color2", teams[CONTROL_REPUBLIC].color:ToVector() )
        mat_postbase:SetVector( "$emissiveBlendTint", Vector(0, 0.45, 1) )
    elseif faction == CONTROL_CIS then
        mat_lightcone:SetVector( "$color2", teams[CONTROL_CIS].color:ToVector() )
        mat_sepinsignia:SetVector( "$color2", teams[CONTROL_CIS].color:ToVector() )
        mat_postbase:SetVector( "$emissiveBlendTint", teams[CONTROL_CIS].color:ToVector() )
    else
        mat_lightcone:SetVector( "$color2", white )
        mat_repinsignia:SetVector( "$color2", white )
        mat_sepinsignia:SetVector( "$color2", white )
        mat_postbase:SetVector( "$emissiveBlendTint", Vector(0, 0, 0) )
    end


    local pos = self:GetPos() + Vector(0, 0, 15)
    render.SetAmbientLight( 0, 0, 1 )
    render.SetMaterial( mat_lightcone )
    render.SetModelLighting( BOX_FRONT, 0,0,255 )
    render.DrawBeam(pos, pos + Vector(0, 0, 130), 90, 0, 1)
end
