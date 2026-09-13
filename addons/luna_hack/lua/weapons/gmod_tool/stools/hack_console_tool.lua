--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

TOOL.Category = "SUP • tools"
TOOL.Name = "Ustawienia włamania"

if CLIENT then
    language.Add("Tool.hack_console_tool.name", "Hack Console Tool")
    language.Add("Tool.hack_console_tool.desc", "Instalacja konsoli")
    language.Add("Tool.hack_console_tool.left", "Wybierz obiekt do włamania (drzwi, prop, itd)")
    language.Add("Tool.hack_console_tool.left_2", "Ustaw konsolę")
    language.Add("Tool.hack_console_tool.right_2", "Anuluj")
    language.Add("Tool.hack_console_tool.reload", "Otwórz menu ustawień")
    language.Add("Undone_Hack_Console", "Undone Hack Console")
end

TOOL.Information = {
    { name = "left", stage = 0 },

    { name = "left_2", stage = 1 },
    { name = "right_2", stage = 1 },

    { name = "reload", stage = 0 },
}

HackConsole = HackConsole or {}

HackConsole.ConsoleTypes = {
    "Zmija",
    "Reakcja",
    "Przytrzymanie przycisku"
}

local color_dark = Color(30, 30, 30)

local function fixupProp( ply, ent, hitpos, mins, maxs )
	local entPos = ent:GetPos()
	local endposD = ent:LocalToWorld( mins )
	local tr_down = util.TraceLine( {
		start = entPos,
		endpos = endposD,
		filter = { ent, ply }
	} )

	local endposU = ent:LocalToWorld( maxs )
	local tr_up = util.TraceLine( {
		start = entPos,
		endpos = endposU,
		filter = { ent, ply }
	} )

	-- Both traces hit meaning we are probably inside a wall on both sides, do nothing
	if ( tr_up.Hit && tr_down.Hit ) then return end

	if ( tr_down.Hit ) then ent:SetPos( entPos + ( tr_down.HitPos - endposD ) ) end
	if ( tr_up.Hit ) then ent:SetPos( entPos + ( tr_up.HitPos - endposU ) ) end
end

local function TryFixPropPosition( ply, ent, hitpos )
	fixupProp( ply, ent, hitpos, Vector( ent:OBBMins().x, 0, 0 ), Vector( ent:OBBMaxs().x, 0, 0 ) )
	fixupProp( ply, ent, hitpos, Vector( 0, ent:OBBMins().y, 0 ), Vector( 0, ent:OBBMaxs().y, 0 ) )
	fixupProp( ply, ent, hitpos, Vector( 0, 0, ent:OBBMins().z ), Vector( 0, 0, ent:OBBMaxs().z ) )
end

local function UpdatePos(ply, ent)
    local vStart = ply:GetShootPos()
    local vForward = ply:GetAimVector()

    local tr = util.TraceLine({
        start = vStart,
        endpos = vStart + (vForward * 2048),
        filter = ply,
    })

    if not IsValid(ent) then return end

    local ang = ply:EyeAngles()

    ang.yaw = ang.yaw + 180
    ang.roll = 0
    ang.pitch = 0

    ent:SetPos(tr.HitPos)
    ent:SetAngles(ang)

    TryFixPropPosition(ply, ent, tr.HitPos)
end

function TOOL:SpawnConsole(trace, target_entity, settings)

    local ent = ents.Create("hack_console")
    ent:SetModel(settings.model)

    ent:SetConsoleName(settings.name)
    ent:SetState(1)
    ent:SetType(settings.type)
    ent:SetAttemptLeft(settings.max_attempt)
    ent:SetStartTime(0)
    ent:SetHackTime(settings.time_for_hack)
    ent:SetCooldownTime(0)
    ent:SetCanRepeat(settings.can_repeat)
    ent.TargetEntity = target_entity
    ent.MaxAttempt = settings.max_attempt

    ent:Spawn()

    UpdatePos(self:GetOwner(), ent)

    undo.Create("Hack Console")
    undo.AddEntity(ent)
    undo.SetPlayer(self:GetOwner())
    undo.Finish()
end

function TOOL:LeftClick(trace)
    if self:GetStage() == 0 then
        local ent = trace.Entity
        
        if not IsValid(ent) or IsValid(ent) and not HackConsole.WhitelistEnts[ent:GetClass()] then
            if CLIENT and IsFirstTimePredicted() then chat.AddText("Wybierz drzwi lub prop!") end

            return true
        end

        if SERVER and IsFirstTimePredicted() then
            if not self:GetOwner().HackConsoleSettings then
                self:GetOwner():ChatPrint("Skonfiguruj konsolę! (przez R)")
                return true
            end
        end

        if CLIENT and not self.Settings and IsFirstTimePredicted() then
            return true
        end

        self.TargetEntity = ent

        self:SetStage(1)
    elseif self:GetStage() == 1 then
        if not IsValid(self.TargetEntity) then
            self:SetStage(0)
            return true
        end

        if SERVER and IsFirstTimePredicted() then
            if not self:GetOwner().HackConsoleSettings then
                self:GetOwner():ChatPrint("Skonfiguruj konsolę! (przez R)")
                return true
            end

            self:SpawnConsole(trace, self.TargetEntity, self:GetOwner().HackConsoleSettings)
        end


        self:SetStage(0)
    end

    return true
end

function TOOL:RightClick(trace)
    if self:GetStage() == 0 then return false end

    self:SetStage(0)

    return true
end



local OpenSettingsMenu

local function SettingsPanel(sheet, tool, frame)
    local panel = sheet:Add("DPanel")

    function panel:Paint(w, h) end

    local name_label = panel:Add("DLabel")
    name_label:SetPos(10, 10)
    name_label:SetText("Nazwa konsoli:")
    name_label:SizeToContents()
    name_label:SetTextColor(color_dark)

    local name_input = panel:Add("DTextEntry")
    name_input:SetPos(name_label:GetWide() + 10 + 6, 8)
    name_input:SetWide(260)
    name_input:SetTall(18)
    name_input:SetText(tool.Settings.name)

    function name_input:OnChange()
        tool.Settings.name = name_input:GetText()
    end


    local max_attempt = panel:Add("DNumSlider")
    max_attempt:SetPos(10, 34)
    max_attempt:SetText("Maksymalna liczba prób:")
    max_attempt:SetMinMax(0, 3)
    max_attempt:SetDecimals(0)
    max_attempt:SetValue(tool.Settings.max_attempt or 1)
    max_attempt:SetSize(400, 20)
    max_attempt.Label:SetTextColor(color_dark)

    function max_attempt:OnValueChanged(value)
        tool.Settings.max_attempt = math.Round(value)
    end


    local time_for_hack = panel:Add("DNumSlider")
    time_for_hack:SetPos(10, 60)
    time_for_hack:SetText("Czas na włamanie:")
    time_for_hack:SetMinMax(10, 120)
    time_for_hack:SetDecimals(0)
    time_for_hack:SetValue(tool.Settings.time_for_hack or 1)
    time_for_hack:SetSize(400, 20)
    time_for_hack.Label:SetTextColor(color_dark)

    function time_for_hack:OnValueChanged(value)
        tool.Settings.time_for_hack = math.Round(value)
    end

    local can_repeat_label = panel:Add("DLabel")
    can_repeat_label:SetPos(32, 90)
    can_repeat_label:SetText("Czy po wszystkich nieudanych próbach możliwe jest nieprawidłowe włamanie?")
    can_repeat_label:SizeToContents()
    can_repeat_label:SetTextColor(color_dark)

    local can_repeat_box = panel:Add("DCheckBox")
    can_repeat_box:SetPos(10, 90)
    can_repeat_box:SetValue(tool.Settings.can_repeat or false)

    function can_repeat_box:OnChange(value)
        tool.Settings.can_repeat = value
    end


    local type_label = panel:Add("DLabel")
    type_label:SetPos(10, 120)
    type_label:SetText("Typ konsoli:")
    type_label:SizeToContents()
    type_label:SetTextColor(color_dark)

    local type_menu = panel:Add("DComboBox")
    type_menu:SetPos(83, 118)
    type_menu:SetSize(120, 18)
    type_menu:SetValue(HackConsole.ConsoleTypes[tool.Settings.selected_type or 1])

    for k, v in pairs(HackConsole.ConsoleTypes) do
        type_menu:AddChoice(v)
    end

    function type_menu:OnSelect(index, value)
        tool.Settings.selected_type = index
    end


    local model_panel = panel:Add("DPanel")
    model_panel:SetPos(10, 90 + 60)
    model_panel:SetSize(653, 300 - 54)

    function model_panel:Paint(w, h)
        surface.SetDrawColor(220, 220, 220)
        surface.DrawRect(0, 0, w, h)
    end

    local model_list = model_panel:Add("DIconLayout")
    model_list:Dock(FILL)
    model_list:DockMargin(19, 19, 0, 0)
    model_list:SetSpaceX(5)
    model_list:SetSpaceY(5)

    local models = {}

    for k, v in pairs(HackConsole.ConsoleModels) do
        local model_pan = model_list:Add("SpawnIcon")
        model_pan:SetModel(v)
        model_pan:SetSize(64, 64)
        model_pan.Selected = false

        function model_pan:Paint(w, h)
            if self.Selected then
                draw.RoundedBox(4, 2, 2, w-4, h-4, Color(16, 106, 26))
            end
        end

        function model_pan:DoClick()
            for _, model in pairs(models) do
                model.Selected = false
            end

            self.Selected = true
            tool.Settings.selected_model = k
        end

        table.insert(models, model_pan)
    end

    models[tool.Settings.selected_model or 1].Selected = true

    local reset = panel:Add("DButton")
    reset:Dock(BOTTOM)
    reset:SetText("Resetuj ustawienia")
    reset:DockMargin(10, 0, 10, 0)

    function reset:DoClick()
        tool.Settings = defaultSettings
        frame:Remove()
        OpenSettingsMenu(tool)
    end

    return panel
end

local function RefreshList(con_list)
    con_list:Clear()

    for k, v in pairs(ents.FindByClass("hack_console")) do
        local panel = con_list:AddLine(v:EntIndex(), v:GetConsoleName(), v:GetModel(), v:GetAttemptLeft())
        panel.Entity = v
    end
end

local function SendAction(ent, act)
    net.Start("hack_console_action")
        net.WriteUInt(4, 8)
        net.WriteEntity(ent)
        net.WriteUInt(act, 8)
    net.SendToServer()
end

local function ConsoleListPanel(sheet, tool)
    local panel = sheet:Add("DPanel")

    local con_list = panel:Add("DListView")
    con_list:Dock(FILL)
    con_list:DockMargin(10, 10, 200, 10)
    con_list:SetMultiSelect(false)

    function con_list:OnRowRightClick(line_id, panel)
        local ent = panel.Entity

        local menu = DermaMenu()

        menu:AddOption("Usuń konsolę", function() SendAction(ent, 1) end):SetIcon("icon16/monitor_delete.png")
        menu:AddOption("Zresetuj konsolę", function() SendAction(ent, 3) end):SetIcon("icon16/monitor_lightning.png")
        menu:AddOption("Teleportuj do konsoli", function() SendAction(ent, 2) end):SetIcon("icon16/user_go.png")

        menu:Open()
    end

    local id = con_list:AddColumn("ID")
    id:SetMinWidth(20)
    id:SetMaxWidth(70)
    con_list:AddColumn("Nazwa"):SetMinWidth(50)
    con_list:AddColumn("Model"):SetMinWidth(260)
    con_list:AddColumn("Próby"):SetMinWidth(50)

    RefreshList(con_list)
    
    local refresh = panel:Add("DButton")
    refresh:SetPos(480, 10)
    refresh:SetSize(188, 30)
    refresh:SetText("Odśwież listę")
    
    function refresh:DoClick()
        RefreshList(con_list)
    end

    return panel
end

OpenSettingsMenu = function(tool)
    local frame = vgui.Create("DFrame")
    frame:SetSize(700, 500)
    frame:MakePopup()
    frame:Center()
    frame:SetTitle("Menu ustawień konsoli")

    local sheet = vgui.Create("DPropertySheet", frame)
    sheet:Dock(FILL)

    sheet:AddSheet("Ustawienia konsoli", SettingsPanel(sheet, tool, frame), "icon16/monitor_edit.png")
    sheet:AddSheet("Lista konsolek", ConsoleListPanel(sheet, tool), "icon16/application_view_tile.png")

    function frame:OnRemove()
        net.Start("hack_console_action")
            net.WriteUInt(3, 8) -- Settings
            net.WriteString(tool.Settings.name)
            net.WriteInt(tool.Settings.max_attempt, 16)
            net.WriteInt(tool.Settings.time_for_hack, 16)
            net.WriteBool(tool.Settings.can_repeat)
            net.WriteString(HackConsole.ConsoleModels[tool.Settings.selected_model])
            net.WriteInt(tool.Settings.selected_type, 16)
        net.SendToServer()
    end
end

function TOOL:Reload()
    if SERVER then return end
    if not IsFirstTimePredicted() then return end

    self.Settings = self.Settings or HackConsole.DefaultSettings

    OpenSettingsMenu(self)

    return false
end

function TOOL:UpdateGhost()
    if not IsValid(self.GhostEntity) then return end

    UpdatePos(LocalPlayer(), self.GhostEntity)

    local model = HackConsole.ConsoleModels[self.Settings.selected_model]

    if self.GhostEntity:GetModel() ~= model then
        self.GhostEntity:SetModel(model)
    end
end

function TOOL:Think()
    if CLIENT then
        if not self.Settings then return end

        if self:GetStage() < 1 then
            if IsValid(self.GhostEntity) then
                self.GhostEntity:Remove()
            end
            return
        end

        local model = HackConsole.ConsoleModels[self.Settings.selected_model]
        if not IsValid(self.GhostEntity) then
            self.GhostEntity = ClientsideModel(model,RENDERGROUP_OPAQUE)
            self.GhostEntity:SetModel(model)
            self.GhostEntity:SetColor(Color(255,255,150,255))
        else
            self:UpdateGhost()
        end
    else
        if not IsValid(self.TargetEntity) then
            self:SetStage(0)
        end
    end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
