--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

TOOL.Category = "SUP • tools"
TOOL.Name = "Podłączanie generatora"
TOOL.Command = nil
TOOL.ConfigName = ""

TOOL.ClientConVar["remove_welds"] = "1"
TOOL.ClientConVar["health"] = "500"
TOOL.ClientConVar["model"] = "models/props/machine1.mdl"
TOOL.ClientConVar["take_all_damage"] = "0"
TOOL.ClientConVar["health_bar"] = "0"

if (CLIENT) then
    TOOL.Information = {
        {name = "info", stage = 1},
        {name = "left"},
        {name = "right"},
        {name = "reload"}
    }

    language.Add("tool.rsgen_linker.name", "Generator Linker")
    language.Add("tool.rsgen_linker.desc", "Used to link rayshields to generators")
    language.Add("tool.rsgen_linker.left", "Select rayshield")
    language.Add("tool.rsgen_linker.right", "Link rayshield to generator")
    language.Add("tool.rsgen_linker.reload", "Unlink generator from rayshield")
    language.Add("tool.rsgen_linker.health", "Health")
    language.Add("tool.rsgen_linker.model", "Model")
    language.Add("tool.rsgen_linker.removewelds", "Link welded props")
    language.Add("tool.rsgen_linker.takealldamage", "Take any damage")
    language.Add("tool.rsgen_linker.healthbar", "Show health bar")
end

local ent = NULL

function TOOL:LeftClick(trace)
    if !trace.Entity or !trace.Entity:IsValid() or trace.Entity:GetClass() != "prop_physics" then return false end -- If we hit nothing, or it's not a physics prop, do nothing
    if (CLIENT) then return true end

    ent = trace.Entity -- If it is a physics prop, and we're on the server-side, just keep the entity cached
    return true
end

function TOOL:RightClick(trace)
    if (CLIENT) then return true end

    if (ent != NULL && ent:IsValid()) then -- If there is a valid rayshield cached
        if !trace.Entity or !trace.Entity:IsValid() or trace.Entity:GetClass() != "laser_rayshield_gen" then return false end -- If entity is not a rayshield generator, do nothing

        if (trace.Entity:GetNWEntity("rs") != NULL) then -- If the generator is already linked to a rayshield, do nothing and inform the user
            self:GetOwner():ChatPrint("Generator jest już podłączony.")
        return true end

        local gen = trace.Entity
        gen:SetNWEntity("rs", ent) -- Update the generator entity to link the rayshield to the generator

        local health = self:GetClientNumber("health")
        gen:SetNWInt("max_health", health) -- Update to specified health
        gen:SetNWInt("health", health)

        local model = self:GetClientInfo("model")
        if (model != "models/props_wasteland/horizontalcoolingtank04.mdl" && model != "") then
            gen:SetModel(model) -- Update to specified model
            gen:PhysicsInit(SOLID_VPHYSICS) -- Reset physics mesh for entity as model has changed
        end

        local removewelds = self:GetClientBool("remove_welds")
        gen:SetNWBool("remove_welds", removewelds) -- Update if welded props should be removed too on destruction

        local takedamage = self:GetClientBool("take_all_damage")
        gen:SetNWBool("take_all_damage", takedamage) -- Update if damage should be taken from all sources

        local healthbar = self:GetClientBool("health_bar")
        gen:SetNWBool("health_bar", healthbar) -- Update if health bar should be shown

        self:GetOwner():ChatPrint("Generator podłączony!")

        ent = NULL
        return true
    else -- No valid rayshield cached
        self:GetOwner():ChatPrint("Wybierz to, co chcesz podłączyć!")
        return true
    end
end

function TOOL:Reload(trace)
    if (CLIENT) then return true end

    if !trace.Entity or !trace.Entity:IsValid() or trace.Entity:GetClass() != "laser_rayshield_gen" then return false end -- If entity is not a rayshield generator, do nothing
    if (trace.Entity:GetNWEntity("rs") == NULL) then return false end -- If no RS is linked, do nothing

    local gen = trace.Entity
    gen:SetNWEntity("rs", NULL)
    gen:SetNWInt("max_health", 500)
    gen:SetNWInt("health", 500)
    gen:SetModel("models/props/machine1.mdl")
    gen:PhysicsInit(SOLID_VPHYSICS)
    gen:SetNWBool("remove_welds", true)
    gen:SetNWBool("take_all_damage", false)
    gen:SetNWBool("health_bar", false)

    self:GetOwner():ChatPrint("Generator odłączony.")
    return true
end

local ConVarsDefault = TOOL:BuildConVarList()
function TOOL.BuildCPanel(panel)
    panel:AddControl("ComboBox", {MenuButton = 1, Folder = "rsgen_linker", Options = {["#preset.default"] = ConVarsDefault}, CVars = table.GetKeys(ConVarsDefault)})

    panel:AddControl("Slider", {Label = "#tool.rsgen_linker.health", Command = "rsgen_linker_health", Type = "integer", Min = 1, Max = 10000})
    panel:AddControl("TextBox", {Label = "#tool.rsgen_linker.model", Command = "rsgen_linker_model"})
    panel:AddControl("Checkbox", {Label = "#tool.rsgen_linker.removewelds", Command = "rsgen_linker_remove_welds"})
    panel:AddControl("Checkbox", {Label = "#tool.rsgen_linker.takealldamage", Command = "rsgen_linker_take_all_damage"})
    panel:AddControl("Checkbox", {Label = "#tool.rsgen_linker.healthbar", Command = "rsgen_linker_health_bar"})
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
