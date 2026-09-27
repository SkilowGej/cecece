TOOL.Category		=	"Renaissance Tools"
TOOL.Name			=	"Control Points"
TOOL.Command		=	nil
TOOL.ConfigName		=	""

if CLIENT then
	language.Add("tool.control_points.name", "Control Points")
	language.Add("tool.control_points.0", "")
	language.Add("tool.control_points.desc", "")
end

-- PrintTable(CONTROLPOINT_ICONS)
-- local icon
-- timer.Simple(0, function()
--     icon = CreateConVar( "controlpoints_icon", table.GetFirstKey(CONTROLPOINT_ICONS), true, false )
--     icon = CreateConVar( "controlpoints_name", 'Control Point', true, false )
-- end)

TOOL.ClientConVar[ "icon" ] = table.GetFirstKey(CONTROLPOINT_ICONS)
TOOL.ClientConVar[ "radius" ] = 400
TOOL.ClientConVar[ "name" ] = 'Control Point'
TOOL.ClientConVar[ "team" ] = table.GetFirstValue(CONTROLPOINT_TEAMS).name
TOOL.ClientConVar[ "time" ] = 1
TOOL.ClientConVar[ "occupied" ] = 1
TOOL.ClientConVar[ "countbuff" ] = 0
TOOL.ClientConVar[ "countoccupied" ] = 1
TOOL.ClientConVar[ "momentoccupied" ] = 0

function TOOL:LeftClick( trace )
    if not self:GetOwner():IsAdmin() then return end
    if SERVER then
        local ent = ents.Create('control_point')
        ent:Spawn()
        ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0) )
        ent:SetPos( trace.HitPos )
        ent:SetNWString( "Name", self:GetClientInfo( "name" ) )
        ent:SetNWString( "Icon", self:GetClientInfo( "icon" ) )

        local fraction = 0
        for id, frac in pairs(CONTROLPOINT_TEAMS) do
            if frac.name == self:GetClientInfo( "team" ) then
                fraction = id
            end
        end
        ent:SetNWInt( "Occupied", self:GetClientInfo( "occupied" )/100 )
        ent:SetNWBool( "CountBuff", self:GetClientInfo( "countbuff" ) == '1' and true or false )
        ent:SetNWBool( "CountOccupied", self:GetClientInfo( "countoccupied" ) == '1' and true or false )
        ent:SetNWBool( "MomentOccupied", self:GetClientInfo( "momentoccupied" ) == '1' and true or false )
        ent:SetNWInt( "Team", fraction )
        ent:SetNWInt( "Time", self:GetClientInfo( "time" ) )
        ent:SetNWInt( "Radius", self:GetClientInfo( "radius" ) )

        if not trace.Entity:IsWorld() then
            local target = trace.Entity
            constraint.Weld( ent, target, 0, trace.PhysicsBone, 0, false, true )
        end
    end
    return true
end

function TOOL:Deploy()
    -- if SERVER and (self.NextQuery or 0) <= CurTime() then
    --     self.NextQuery = CurTime() + 1
    --     local spawns = GetInfoAllSpawns()

	--     netstream.Start(self:GetOwner(), 'SpawnPoints_SendAllPlayerInfoStarts', spawns)
    -- end
end

function TOOL:DrawHUD()

end

function TOOL:RightClick( trace )
    if not self:GetOwner():IsAdmin() then return end
    if trace.Entity:GetClass() ~= 'control_point' then return end

    if SERVER then
        trace.Entity:Remove()
    end

    return true
end

function TOOL:Reload( trace )
    if not self:GetOwner():IsAdmin() then return end
    if trace.Entity:GetClass() ~= 'control_point' then return end
    local ent = trace.Entity

    ent:SetNWString( "Name", self:GetClientInfo( "name" ) )
    ent:SetNWString( "Icon", self:GetClientInfo( "icon" ) )

    local fraction = 0
    for id, frac in pairs(CONTROLPOINT_TEAMS) do
        if frac.name == self:GetClientInfo( "team" ) then
            fraction = id
        end
    end
    ent:SetNWBool( "CountBuff", self:GetClientInfo( "countbuff" ) == '1' and true or false )
    ent:SetNWBool( "CountOccupied", self:GetClientInfo( "countoccupied" ) == '1' and true or false )
    ent:SetNWBool( "MomentOccupied", self:GetClientInfo( "momentoccupied" ) == '1' and true or false )
    ent:SetNWInt( "Team", fraction )
    ent:SetNWInt( "Time", self:GetClientInfo( "time" ) )
    ent:SetNWInt( "Radius", self:GetClientInfo( "radius" ) )

    return true
end

local ConVarsDefault = TOOL:BuildConVarList()
function TOOL.BuildCPanel( CPanel )
    CPanel:AddControl( "Header", { Description = "LKM – ustaw punkt kontrolny\nPPM – usuń\nR – przywróć bieżące ustawienia" } )
    CPanel:AddControl( "ComboBox", { MenuButton = 1, Folder = "rc_controlpoints", Options = { [ "#preset.default" ] = ConVarsDefault }, CVars = table.GetKeys( ConVarsDefault ) } )

    local combo = CPanel:ComboBox("Ikona", "control_points_icon")
    for name, mat in pairs(CONTROLPOINT_ICONS) do
		combo:AddChoice( name )
	end
    local combo = CPanel:ComboBox("Frakcja", "control_points_team")
    for _, frac in pairs(CONTROLPOINT_TEAMS) do
		combo:AddChoice( frac.name )
	end
    CPanel:TextEntry('Tytuł', 'control_points_name')
    CPanel:AddControl( "Slider", { Label = "Promień", Type = "Float", Command = "control_points_radius", Min = 100, Max = 2000 } )
    CPanel:AddControl( "Slider", { Label = "Bonus do czasu przechwycenia", Type = "Float", Command = "control_points_time", Min = 1, Max = 60 } )
    CPanel:AddControl( "Slider", { Label = "Wskaźnik zwrotu z inwestycji", Type = "Float", Command = "control_points_occupied", Min = 1, Max = 100 } )
    CPanel:AddControl( "CheckBox", { Label = "Przyspieszać, gdy jest więcej graczy", Command = "control_points_countbuff" } )
    CPanel:AddControl( "Header", { Description = "Zezwól na zajęcie punktu, gdy graczy z przeciwnej frakcji jest więcej.\nJeśli opcja jest wyłączona, to tylko wtedy, gdy na punkcie nie ma ani jednego wroga." } )
    CPanel:AddControl( "CheckBox", { Label = "Zajmować tylko wtedy, gdy jest więcej", Command = "control_points_countoccupied" } )
    CPanel:AddControl( "Header", { Description = "Dodaje tryb neutralny, tak jak w klasycznej wersji BF II (zanim strona zdobędzie punkt, będzie musiała najpierw przejąć kontrolę nad frakcją, a dopiero potem uzyskać neutralność)" } )
    CPanel:AddControl( "CheckBox", { Label = "Natychmiastowa zmiana strony", Command = "control_points_momentoccupied" } )
end
