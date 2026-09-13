--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

TOOL.Category = "Vanilla"

TOOL.Name = "Vanilla's Hyperspace Tool 2"

if CLIENT then
    language.Add("Tool.vanilla_hyperspacetool2.name","Vanilla's Hyperspace Tool 2")
    language.Add("Tool.vanilla_hyperspacetool2.desc","Make any entity or prop emerge or jump to hyperspace")
    language.Add("Tool.vanilla_hyperspacetool2.left","Choose a location for the entity/prop to jump to")
    language.Add("Tool.vanilla_hyperspacetool2.right","Choose an entity/prop to jump into hyperspace")
end

TOOL.ClientConVar[ "height" ] = "0"
TOOL.ClientConVar[ "angle" ] = "0"
TOOL.ClientConVar[ "ship" ] = ""
TOOL.ClientConVar[ "ai" ] = "0"
TOOL.ClientConVar[ "freeze" ] = "0"
TOOL.ClientConVar[ "flip" ] = "0"
TOOL.ClientConVar[ "shake" ] = "0"
TOOL.ClientConVar[ "sound" ] = "0"
TOOL.ClientConVar[ "delay" ] = "0"
TOOL.ClientConVar[ "model" ] = ""
TOOL.ClientConVar[ "spawnmodel" ] = "0"

TOOL.Information = {
    { name = "left" },
    { name = "right" }
}

function TOOL:LeftClick( trace )
    if not trace.HitPos then return false end

    local Delay = self:GetClientInfo("delay")
    local Height = self:GetClientNumber("height")
    local vAngle = self:GetClientNumber("angle")
    local Ship = self:GetClientInfo("ship")
    local AI = self:GetClientInfo("ai")
    local Freeze = self:GetClientInfo("freeze")
    local Flip = self:GetClientInfo("flip")
    local Shake = self:GetClientInfo("shake")
    local vSound = self:GetClientInfo("sound")
    local vModel = self:GetClientInfo("model")
    local SpawnModel = self:GetClientInfo("spawnmodel")

    local Valid = false

    for k, v in pairs(scripted_ents.GetList()) do
        if Ship == v.t.ClassName then
            Valid = true
        end
    end

    if list.HasEntry("NPC",Ship) then
        Valid = true
    end

    if SpawnModel == "1" then
        Valid = true
    end

    if Valid == true && SERVER then
        timer.Simple(Delay, function()
            local ent = ents.Create("vanilla_hyperspace2_ship")
            if not IsValid(ent) then return end
            ent:SetKeyValue("AI", AI)
            ent:SetKeyValue("Freeze", Freeze)
            ent:SetKeyValue("Flip", Flip)
            ent:SetKeyValue("Shake", Shake)
            ent:SetKeyValue("Sound", vSound)
            ent:SetKeyValue("SpawnModel", SpawnModel)
            ent:SetKeyValue("ActualModel", vModel)
            ent:SetKeyValue("Entity", Ship)
            ent:SetOwner(self:GetOwner())
            ent:SetPos(trace.HitPos + Vector(0,0,Height))
            ent:SetAngles(Angle(0,0,0) + Angle(0,vAngle,0))
            ent:Spawn()
            ent:SetMoveType(MOVETYPE_NONE)

            undo.Create( "Ship" )
                undo.AddEntity( ent )
                undo.SetPlayer( self:GetOwner() )
                undo.SetCustomUndoText("Undone Ship")
            undo.Finish()
            return false
        end)
    end
end


local timerName = tostring(SysTime())

function TOOL:RightClick( trace )
    local ent = trace.Entity

    if not IsValid(ent) then return end

    if not SERVER then return end
    local sound = ents.Create("vanilla_highwake2")
    if not IsValid(sound) then return end
    sound:SetPos(ent:GetPos())
    sound:Spawn()
    sound:SetNoDraw(true)

    if IsValid(ent) then
        timer.Simple(3,function()
            if not IsValid(ent) then return end
            timer.Create(timerName,0,0.2,function()
                if not ent:IsValid() then return end
                if self:GetClientInfo("flip") == "0" then
                    ent:SetPos(ent:GetPos() + ent:GetForward() * 700)
                else
                    ent:SetPos(ent:GetPos() - ent:GetForward() * 700)
                end
            end)
        end)
        timer.Create(timerName .. "Ender",5 + 1,1,function()
            timer.Remove(timerName)
            if not IsValid(ent) then return end
            ent:Remove()
        end)
    end
end

function TOOL:Think()
    if not ( IsValid( self.GhostEntity ) ) then
        self:MakeGhostEntity( "models/xqm/jetbody3_s5.mdl", Vector( 0, 0, 0 ), Angle( 0, 0, 0 ) )
    end
    self:UpdateGhost( self.GhostEntity, self:GetOwner() )

    if not timer.Exists(timerName .. "Ender") then return end
    if timer.RepsLeft(timerName .. "Ender") == 0 then
        timer.Remove(timerName .. "Ender")
    end
end

function TOOL:UpdateGhost( ent, pl )
    if not ( IsValid( ent ) ) then return end
    local trace = pl:GetEyeTrace()
    if not trace.Hit then
        ent:SetNoDraw( true )
        return
    end
    ent:SetPos( trace.HitPos + Vector(0,0,self:GetClientNumber("height")) )
    if self:GetClientNumber("flip") == 0 then
        ent:SetAngles( (Angle(0,0,0) + Angle(0,90,0)) + Angle(0,self:GetClientNumber("angle"),0) )
    else
        ent:SetAngles( Angle(0,0,0) + Angle(0,270,0) + Angle(0,self:GetClientNumber("angle"),0))
    end
ent:SetNoDraw( false )
    ent:SetMaterial("phoenix_storms/dome",true)
    ent:SetColor(Color(0,255,0,125))
end

local ConVarsDefault = TOOL:BuildConVarList()

function TOOL.BuildCPanel( CPanel )
    if not CLIENT then return end

    CPanel:SetName( "Vanilla's Hyperspace Tool 2" )

    local header = vgui.Create("DImage", CPanel)
    header:SetSize(267, 134)
    header:SetImage("vanilla_header/hyperspacetool_header.png")
    CPanel:AddItem(header)

    CPanel:Help( "Version: 1.0" )

    CPanel:AddControl( "ComboBox", { MenuButton = 1, Folder = "vanilla_hyperspacetool2", Options = { [ "#preset.default" ] = ConVarsDefault }, CVars = table.GetKeys( ConVarsDefault ) } )

    CPanel:NumSlider("Height", "vanilla_hyperspacetool2_height", 0, 10000)
    CPanel:ControlHelp("Sets the height of the spawned ship.")

    CPanel:NumSlider("Angle", "vanilla_hyperspacetool2_angle", 0, 360)
    CPanel:ControlHelp("Sets the angle of the spawned ship.")

    CPanel:NumSlider("Delay", "vanilla_hyperspacetool2_delay", 0, 10, 1)
    CPanel:ControlHelp("Sets the delay (in seconds) of the spawned ship.")

    local divider1 = vgui.Create("DImage", CPanel)
    divider1:SetSize(267, 19)
    divider1:SetImage("vanilla_header/vanilla_divider.png")
    CPanel:AddItem(divider1)

    CPanel:TextEntry("Entity Name", "vanilla_hyperspacetool2_ship")
    CPanel:ControlHelp("The entity name of the desired ship.")

    CPanel:CheckBox("Model Ship", "vanilla_hyperspacetool2_spawnmodel")
    CPanel:ControlHelp("Tick this if you would like to spawn in a model instead of an entity.")

    CPanel:TextEntry("Model Name", "vanilla_hyperspacetool2_model")
    CPanel:ControlHelp("Only use if you would like to spawn in a model that is not an entity.")

    local divider2 = vgui.Create("DImage", CPanel)
    divider2:SetSize(267, 19)
    divider2:SetImage("vanilla_header/vanilla_divider.png")
    CPanel:AddItem(divider2)

    CPanel:CheckBox("Enable AI","vanilla_hyperspacetool2_ai")
    CPanel:ControlHelp("Enables AI for the spawned ship. (LFS ONLY)")

    CPanel:CheckBox("Freeze","vanilla_hyperspacetool2_freeze")
    CPanel:ControlHelp("Freezes the spawned ship.")

    CPanel:CheckBox("Flip","vanilla_hyperspacetool2_flip")
    CPanel:ControlHelp("Flips the spawned ship. (For ships with models that are backwards.) Effects the direction the ship will jump to aswell.")

    CPanel:CheckBox("Enable Screenshake","vanilla_hyperspacetool2_shake")
    CPanel:ControlHelp("Enables screenshake for people near the ship.")

    CPanel:CheckBox("Enable Sound","vanilla_hyperspacetool2_sound")
    CPanel:ControlHelp("Plays sound of the ship jumping in to all players.")

end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
