-- Author: DuLL_FoX
-- Also i don't wanna work or update this plugin anymore, so if you want to update it, you can do it by yourself.
-- Of the problem areas here is the how localizations are handled, and it's not flexible enough for other screen resolutions.

-- Constants
local COLORS = {
    FRAME_BG = Color(25, 25, 30, 255),
    PANEL_BG = Color(35, 35, 40, 255),
    BTN_NORMAL = Color(41, 128, 185, 255),
    BTN_HOVER = Color(52, 152, 219, 255),
    BTN_DISABLED = Color(41, 128, 185, 100),
    INPUT_BG = Color(45, 45, 50, 255),
    WHITE = Color(255, 255, 255, 255),
    YELLOW = Color(241, 196, 15, 255),
    GREEN = Color(46, 204, 113, 255),
    RED = Color(231, 76, 60, 255),
    GRAY = Color(189, 195, 199, 255)
}

local FONTS = {
    HEADER_LARGE = "header_large",
    HEADER = "header",
    TEXT_MEDIUM = "text_medium",
    TEXT = "text",
    TITLE = "title"
}

-- Create fonts
local function CreateFont(name, size)
    surface.CreateFont(name, {
        font = name:find("header") and "Mont Black" or "Mont Bold",
        size = size,
        weight = name:find("header") and 500 or 0,
        extended = true,
    })
end

for name, size in pairs({header_large = 38, header = 36, text_medium = 24, title = 24, text = 16}) do
    CreateFont(name, size)
end

-- Utility functions
local function wrapText(text, font, maxWidth)
    local words, lines, currentLine = string.Explode(" ", text), {}, ""
    surface.SetFont(font)
    for _, word in ipairs(words) do
        local testLine = currentLine .. " " .. word
        local width = surface.GetTextSize(testLine)
        if width > maxWidth then
            table.insert(lines, currentLine)
            currentLine = word
        else
            currentLine = testLine
        end
    end
    if currentLine ~= "" then table.insert(lines, currentLine) end
    return lines
end

local function createPanel(parent, x, y, w, h, backgroundColor)
    local panel = vgui.Create("DPanel", parent)
    panel:SetPos(x, y)
    panel:SetSize(w, h)
    panel.Paint = function(_, w, h)
        draw.RoundedBox(8, 0, 0, w, h, backgroundColor or COLORS.PANEL_BG)
    end
    return panel
end

local function createLabel(parent, text, font, color, x, y, alignX, alignY)
    local label = vgui.Create("DLabel", parent)
    label:SetText(text)
    label:SetFont(font)
    label:SetTextColor(color)
    label:SetPos(x, y)
    label:SetContentAlignment(alignX or TEXT_ALIGN_LEFT)
    if alignY then label:SetTextInset(0, alignY) end
    label:SizeToContents()
    return label
end

local function createButton(parent, text, font, normalColor, hoverColor, disabledColor, x, y, w, h, onClick)
    local button = vgui.Create("DButton", parent)
    button:SetPos(x, y)
    button:SetSize(w, h)
    button:SetText("")
    button.Paint = function(self, w, h)
        local btnColor = self:IsEnabled() and (self:IsHovered() and hoverColor or normalColor) or disabledColor
        draw.RoundedBox(8, 0, 0, w, h, btnColor)
        draw.SimpleText(text, font, w/2, h/2, COLORS.WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    button.DoClick = onClick
    return button
end

local function createInput(parent, x, y, w, h, placeholder)
    local input = vgui.Create("DTextEntry", parent)
    input:SetPos(x, y)
    input:SetSize(w, h)
    input:SetFont(FONTS.TEXT)
    input:SetPlaceholderText(placeholder)
    input.Paint = function(self, w, h)
        draw.RoundedBox(6, 0, 0, w, h, COLORS.INPUT_BG)
        self:DrawTextEntryText(COLORS.WHITE, COLORS.BTN_NORMAL, COLORS.WHITE)
    end
    return input
end

-- Vote status UI
local VOTE_STATUS_UI = {}

local function resizeVoteStatusUI(voteId)
    local voteUI = VOTE_STATUS_UI[voteId]
    if not voteUI or not IsValid(voteUI.frame) then return end

    local resultsList = voteUI.resultsList
    local contentPanel = voteUI.contentPanel

    contentPanel:SetSize(380, contentPanel:GetTall())
    resultsList:SetPos(5, 5)
    resultsList:SetSize(370, contentPanel:GetTall() - 10)
    resultsList:Show()

    voteUI.frame:InvalidateLayout(true)
    voteUI.frame:SizeToChildren(false, true)
end

local function createRatingUI(parentPanel, voteId, minRating, maxRating)
    local panel = vgui.Create("DPanel", parentPanel)
    panel:SetSize(370, 60)
    panel:SetPos(5, 5)
    panel.Paint = function() end

    local ratingSlider = vgui.Create("DNumSlider", panel)
    ratingSlider:SetPos(0, 0)
    ratingSlider:SetSize(270, 30)
    ratingSlider:SetMin(minRating)
    ratingSlider:SetMax(maxRating)
    ratingSlider:SetDecimals(0)
    ratingSlider:SetText("Оценка")

    local submitButton = createButton(panel, "Отправить", FONTS.TEXT, COLORS.BTN_NORMAL, COLORS.BTN_HOVER, COLORS.BTN_DISABLED, 280, 0, 90, 30, function()
        net.Start("VotingPlugin")
        net.WriteUInt(4, 4)
        net.WriteUInt(voteId, 32)
        net.WriteInt(ratingSlider:GetValue(), 32)
        net.SendToServer()
        
        panel:Remove()
        resizeVoteStatusUI(voteId)
    end)

    return panel
end

local function createMultipleChoiceUI(parentPanel, voteId, options)
    local panel = vgui.Create("DPanel", parentPanel)
    panel:SetSize(370, 60)
    panel:SetPos(5, 5)
    panel.Paint = function() end

    local optionsCombo = vgui.Create("DComboBox", panel)
    optionsCombo:SetPos(0, 0)
    optionsCombo:SetSize(270, 30)
    optionsCombo:SetFont(FONTS.TEXT)
    for _, option in ipairs(options) do
        optionsCombo:AddChoice(option)
    end

    local submitButton = createButton(panel, "Голосовать", FONTS.TEXT, COLORS.BTN_NORMAL, COLORS.BTN_HOVER, COLORS.BTN_DISABLED, 280, 0, 90, 30, function()
        local selectedOption = optionsCombo:GetSelected()
        if selectedOption then
            net.Start("VotingPlugin")
            net.WriteUInt(4, 4)
            net.WriteUInt(voteId, 32)
            net.WriteString(selectedOption)
            net.SendToServer()
            
            panel:Remove()
            resizeVoteStatusUI(voteId)
        else
            createLabel(panel, "Выберите вариант!", FONTS.TEXT, COLORS.RED, 0, 35)
        end
    end)

    return panel
end

local function createVoteStatusUI(voteId, voteName, voteOptions, voteResponseType, voteMinRating, voteMaxRating, voteDuration)
    local PADDING = 5
    local TITLE_PADDING = 10
    local BOTTOM_HEIGHT = 30
    local MIN_CONTENT_HEIGHT = 100
    local MAX_FRAME_WIDTH = 400
    local MAX_FRAME_HEIGHT = ScrH() * 0.8

    local frame = vgui.Create("DFrame")
    frame:SetTitle("")
    frame:SetSize(MAX_FRAME_WIDTH, MAX_FRAME_HEIGHT)
    frame:SetPos(ScrW() - MAX_FRAME_WIDTH - 10, ScrH() / 2)
    frame:SetDraggable(false)
    frame:ShowCloseButton(false)
    frame.Paint = function(_, w, h)
        draw.RoundedBox(8, 0, 0, w, h, COLORS.FRAME_BG)
    end

    -- Title
    local titleLabel = vgui.Create("DLabel", frame)
    titleLabel:SetPos(PADDING, PADDING)
    titleLabel:SetFont(FONTS.TITLE)
    titleLabel:SetTextColor(COLORS.YELLOW)
    titleLabel:SetWrap(true)
    titleLabel:SetText(voteName)
    titleLabel:SetSize(MAX_FRAME_WIDTH - 2 * PADDING, 0)
    titleLabel:SetAutoStretchVertical(true)
    titleLabel:SetTooltip(voteName)

    -- Content Panel (Results List or Vote Panel)
    local contentPanel = vgui.Create("DPanel", frame)
    contentPanel:SetPos(PADDING, titleLabel:GetTall() + TITLE_PADDING)
    contentPanel.Paint = function(_, w, h)
        draw.RoundedBox(8, 0, 0, w, h, COLORS.PANEL_BG)
    end

    local resultsList = vgui.Create("DListView", contentPanel)
    resultsList:AddColumn("Вариант"):SetFixedWidth((MAX_FRAME_WIDTH - 4 * PADDING) / 2)
    resultsList:AddColumn("Голоса"):SetFixedWidth((MAX_FRAME_WIDTH - 4 * PADDING) / 2)
    resultsList:SetHeaderHeight(20)
    resultsList.Paint = function(_, w, h)
        draw.RoundedBox(4, 0, 0, w, h, COLORS.INPUT_BG)
    end
    resultsList.OnRowPaint = function(_, lineID, line)
        local bgColor = lineID % 2 == 0 and Color(50, 50, 55, 255) or Color(60, 60, 65, 255)
        surface.SetDrawColor(bgColor)
        surface.DrawRect(0, 0, line:GetWide(), line:GetTall())
    end

    local votePanel
    if voteResponseType == "Rating" then
        votePanel = createRatingUI(contentPanel, voteId, voteMinRating, voteMaxRating)
    elseif voteResponseType == "Multiple Choice" then
        votePanel = createMultipleChoiceUI(contentPanel, voteId, voteOptions)
    end

    -- Bottom Panel
    local bottomPanel = vgui.Create("DPanel", frame)
    bottomPanel:SetHeight(BOTTOM_HEIGHT)
    bottomPanel.Paint = function(_, w, h)
        draw.RoundedBox(8, 0, 0, w, h, COLORS.PANEL_BG)
    end

    local timerLabel = createLabel(bottomPanel, "Время: " .. voteDuration .. "с", FONTS.TEXT, COLORS.WHITE, 10, 5)

    local closeButton = createButton(bottomPanel, "X", FONTS.TEXT, COLORS.RED, COLORS.RED, COLORS.RED, bottomPanel:GetWide() - 25, 5, 20, 20, function()
        frame:Close()
        VOTE_STATUS_UI[voteId] = nil
    end)

    local cancelButton
    if LocalPlayer():IsAdmin() then
        cancelButton = createButton(bottomPanel, "Отмена", FONTS.TEXT, COLORS.RED, COLORS.RED, COLORS.RED, bottomPanel:GetWide() - 80, 5, 50, 20, function()
            net.Start("VotingPlugin")
            net.WriteUInt(5, 4)
            net.WriteUInt(voteId, 32)
            net.SendToServer()
            frame:Close()
            VOTE_STATUS_UI[voteId] = nil
        end)
    end

    -- Dynamically adjust sizes and positions
    local function updateLayout()
        local frameHeight = titleLabel:GetTall() + TITLE_PADDING + math.max(MIN_CONTENT_HEIGHT, contentPanel:GetTall()) + BOTTOM_HEIGHT + 3 * PADDING
        frame:SetSize(MAX_FRAME_WIDTH, math.min(frameHeight, MAX_FRAME_HEIGHT))
        
        contentPanel:SetSize(MAX_FRAME_WIDTH - 2 * PADDING, frame:GetTall() - titleLabel:GetTall() - TITLE_PADDING - BOTTOM_HEIGHT - 3 * PADDING)
        contentPanel:SetPos(PADDING, titleLabel:GetTall() + TITLE_PADDING)
        
        if votePanel and votePanel:IsValid() then
            votePanel:SetSize(contentPanel:GetWide() - 2 * PADDING, votePanel:GetTall())
            votePanel:SetPos(PADDING, PADDING)
            resultsList:SetPos(PADDING, votePanel:GetTall() + 2 * PADDING)
            resultsList:SetSize(contentPanel:GetWide() - 2 * PADDING, contentPanel:GetTall() - votePanel:GetTall() - 3 * PADDING)
        else
            resultsList:SetPos(PADDING, PADDING)
            resultsList:SetSize(contentPanel:GetWide() - 2 * PADDING, contentPanel:GetTall() - 2 * PADDING)
        end
        
        bottomPanel:SetSize(MAX_FRAME_WIDTH - 2 * PADDING, BOTTOM_HEIGHT)
        bottomPanel:SetPos(PADDING, frame:GetTall() - BOTTOM_HEIGHT - PADDING)
        
        if cancelButton and cancelButton:IsValid() then
            cancelButton:SetPos(bottomPanel:GetWide() - 80, 5)
        end
        closeButton:SetPos(bottomPanel:GetWide() - 25, 5)
    end

    updateLayout()
    frame.Think = updateLayout

    VOTE_STATUS_UI[voteId] = {
        frame = frame,
        resultsList = resultsList,
        timerLabel = timerLabel,
        votePanel = votePanel,
        contentPanel = contentPanel,
        titleLabel = titleLabel,
        closeButton = closeButton,
        cancelButton = cancelButton,
        bottomPanel = bottomPanel
    }

    timer.Create("VotingPluginTimer_" .. voteId, 1, voteDuration, function()
        if not IsValid(frame) then return end
        voteDuration = voteDuration - 1
        if voteDuration >= 0 then
            if IsValid(timerLabel) then
                timerLabel:SetText("Время: " .. voteDuration .. "с")
            end
        else
            if IsValid(timerLabel) then
                timerLabel:SetText("Голосование закрыто")
            end
        end
    end)

    return frame
end

local function updateVoteStatusUI(voteId, voteResults, isClosed)
    local voteUI = VOTE_STATUS_UI[voteId]
    if not voteUI or not IsValid(voteUI.frame) then return end

    local resultsList = voteUI.resultsList

    resultsList:Clear()
    resultsList:Show()

    for option, votes in pairs(voteResults) do
        local line = resultsList:AddLine(option, votes)
        for _, v in pairs(line.Columns) do
            v:SetFont(FONTS.TEXT)
            v:SetTextColor(COLORS.WHITE)
        end
    end

    if isClosed then
        if IsValid(voteUI.timerLabel) then
            voteUI.timerLabel:SetText("Голосование закрыто")
        end
        timer.Simple(10, function()
            if IsValid(voteUI.frame) then
                voteUI.frame:Close()
                VOTE_STATUS_UI[voteId] = nil
            end
        end)
    end

    if IsValid(voteUI.votePanel) then
        voteUI.votePanel:Remove()
        resizeVoteStatusUI(voteId)
    end
end

-- Vote creation menu
local function getRatingSettings(ratingPanel)
    local minRatingInput = ratingPanel:GetChildren()[3]
    local maxRatingInput = ratingPanel:GetChildren()[4]
    local minRating = tonumber(minRatingInput:GetValue()) or 0
    local maxRating = tonumber(maxRatingInput:GetValue()) or 5

    return math.max(0, minRating), math.max(minRating + 1, maxRating)
end

local function getVoteOptions(optionsPanel)
    local optionsList = optionsPanel:GetChildren()[2]
    local voteOptions = {}
    for _, line in ipairs(optionsList:GetLines()) do
        table.insert(voteOptions, line:GetValue(1))
    end
    return voteOptions
end

local function validateInputs(nameInput, durationInput, responseCombo, ratingSettings, optionsSettings)
    local voteName = nameInput:GetValue()
    local voteDuration = durationInput:GetValue()
    local responseType = responseCombo:GetSelected()
    local minRating, maxRating = getRatingSettings(ratingSettings)
    local voteOptions = getVoteOptions(optionsSettings)

    if string.Trim(voteName) == "" then
        Derma_Message("Требуется название голосования.", "Ошибка", "ОК")
        return false
    end

    if responseType == "Множественный выбор" and #voteOptions == 0 then
        Derma_Message("Для голосования с множественным выбором требуется хотя бы один вариант.", "Ошибка", "ОК")
        return false
    end

    if minRating >= maxRating then
        Derma_Message("Минимальная оценка должна быть меньше максимальной.", "Ошибка", "ОК")
        return false
    end

    if voteDuration <= 0 then
        Derma_Message("Длительность голосования должна быть больше 0.", "Ошибка", "ОК")
        return false
    end

    return true
end

local function createRatingSettingsPanel(parentPanel)
    local panel = vgui.Create("DPanel", parentPanel)
    panel:SetSize(260, 240)
    panel:SetVisible(false)
    panel.Paint = function() end

    createLabel(panel, "Минимальная оценка:", FONTS.TEXT_MEDIUM, COLORS.WHITE, 10, 20)
    local minRatingInput = vgui.Create("DNumberWang", panel)
    minRatingInput:SetPos(10, 50)
    minRatingInput:SetSize(240, 30)
    minRatingInput:SetMin(0)
    minRatingInput:SetMax(9)
    minRatingInput:SetValue(0)
    minRatingInput:SetFont(FONTS.TEXT)

    createLabel(panel, "Максимальная оценка:", FONTS.TEXT_MEDIUM, COLORS.WHITE, 10, 100)
    local maxRatingInput = vgui.Create("DNumberWang", panel)
    maxRatingInput:SetPos(10, 130)
    maxRatingInput:SetSize(240, 30)
    maxRatingInput:SetMin(1)
    maxRatingInput:SetMax(10)
    maxRatingInput:SetValue(5)
    maxRatingInput:SetFont(FONTS.TEXT)
    
    minRatingInput.OnValueChanged = function(self, value)
        maxRatingInput:SetMin(value + 1)
        if maxRatingInput:GetValue() <= value then
            maxRatingInput:SetValue(value + 1)
        end
    end
    
    maxRatingInput.OnValueChanged = function(self, value)
        minRatingInput:SetMax(value - 1)
        if minRatingInput:GetValue() >= value then
            minRatingInput:SetValue(value - 1)
        end
    end

    -- Set initial values and trigger OnValueChanged
    minRatingInput:SetValue(0)
    maxRatingInput:SetValue(5)

    return panel
end

local function createOptionsSettingsPanel(parentPanel)
    local panel = vgui.Create("DPanel", parentPanel)
    panel:SetSize(260, 270)
    panel:SetVisible(true)
    panel.Paint = function() end

    createLabel(panel, "Варианты голосования:", FONTS.TEXT_MEDIUM, COLORS.WHITE, 10, 10)

    local optionsList = vgui.Create("DListView", panel)
    optionsList:SetPos(10, 40)
    optionsList:SetSize(240, 180)
    optionsList:SetMultiSelect(false)
    optionsList:AddColumn("Вариант")
    optionsList:SetHeaderHeight(20)
    optionsList.Paint = function(_, w, h)
        draw.RoundedBox(4, 0, 0, w, h, COLORS.INPUT_BG)
    end
    
    optionsList.OnRowPaint = function(_, lineID, line)
        local bgColor = lineID % 2 == 0 and Color(50, 50, 55, 255) or Color(60, 60, 65, 255)
        surface.SetDrawColor(bgColor)
        surface.DrawRect(0, 0, line:GetWide(), line:GetTall())
    end
    
    optionsList.OnRowSelected = function(_, _, line)
        for _, v in pairs(line.Columns) do
            v:SetFont(FONTS.TEXT)
        end
    end

    local addOptionButton = createButton(panel, "Добавить вариант", FONTS.TEXT, COLORS.BTN_NORMAL, COLORS.BTN_HOVER, COLORS.BTN_DISABLED, 10, 230, 115, 30, function()
        Derma_StringRequest("Добавить вариант", "Введите текст варианта:", "", function(text)
            if text ~= "" then
                local line = optionsList:AddLine(text)
                for _, v in pairs(line.Columns) do
                    v:SetFont(FONTS.TEXT)
                    v:SetTextColor(COLORS.WHITE)
                end
            end
        end)
    end)

    local removeOptionButton = createButton(panel, "Удалить вариант", FONTS.TEXT, COLORS.RED, Color(255, 100, 100), COLORS.BTN_DISABLED, 135, 230, 115, 30, function()
        local selectedItem = optionsList:GetSelectedLine()
        if selectedItem then
            optionsList:RemoveLine(selectedItem)
        end
    end)

    return panel
end

local function sendVoteData(nameInput, durationInput, responseCombo, ratingSettings, optionsSettings)
    local voteName = nameInput:GetValue()
    local voteDuration = durationInput:GetValue()
    local responseType = responseCombo:GetSelected()
    local minRating, maxRating = getRatingSettings(ratingSettings)
    local voteOptions = getVoteOptions(optionsSettings)

    net.Start("VotingPlugin")
    net.WriteUInt(2, 4) -- 2: CreateVote
    net.WriteString(voteName)
    net.WriteTable(voteOptions)
    net.WriteString(responseType)
    net.WriteInt(minRating, 32)
    net.WriteInt(maxRating, 32)
    net.WriteUInt(voteDuration, 32)
    net.SendToServer()
end

local function createVoteCreationMenu()
    local frame = vgui.Create("DFrame")
    frame:SetTitle("")
    frame:SetSize(600, 550)
    frame:Center()
    frame:MakePopup()
    frame:SetDraggable(true)
    frame.Paint = function(_, w, h)
        draw.RoundedBox(8, 0, 0, w, h, COLORS.FRAME_BG)
    end

    local titleLabel = createLabel(frame, "Создать голосование", FONTS.HEADER_LARGE, COLORS.YELLOW, 0, 20, TEXT_ALIGN_CENTER)
    titleLabel:SetPos(frame:GetWide() / 2 - titleLabel:GetWide() / 2, 20)

    local mainPanel = createPanel(frame, 10, 70, 580, 540)

    createLabel(mainPanel, "Детали", FONTS.HEADER, COLORS.YELLOW, 20, 20)
    
    createLabel(mainPanel, "Название голосования", FONTS.TEXT_MEDIUM, COLORS.WHITE, 20, 70)
    local nameInput = createInput(mainPanel, 20, 100, 260, 100)
    nameInput:SetMultiline(true)
    nameInput:SetFont(FONTS.TEXT)

    createLabel(mainPanel, "Длительность (секунды)", FONTS.TEXT_MEDIUM, COLORS.WHITE, 20, 210)
    local durationInput = vgui.Create("DNumberWang", mainPanel)
    durationInput:SetPos(20, 240)
    durationInput:SetSize(260, 30)
    durationInput:SetMin(1)
    durationInput:SetMax(86400)
    durationInput:SetValue(60)
    durationInput:SetFont(FONTS.TEXT)

    createLabel(mainPanel, "Тип ответа", FONTS.HEADER, COLORS.YELLOW, 310, 20)
    local responseCombo = vgui.Create("DComboBox", mainPanel)
    responseCombo:SetPos(310, 70)
    responseCombo:SetSize(240, 30)
    responseCombo:SetFont(FONTS.TEXT)
    responseCombo:AddChoice("Оценка")
    responseCombo:AddChoice("Множественный выбор")
    responseCombo:SetValue("Выберите тип ответа")

    local settingsPanel = createPanel(mainPanel, 300, 120, 260, 370)

    local ratingSettings = createRatingSettingsPanel(settingsPanel)
    local optionsSettings = createOptionsSettingsPanel(settingsPanel)

    responseCombo.OnSelect = function(_, _, value)
        ratingSettings:SetVisible(value == "Оценка")
        optionsSettings:SetVisible(value == "Множественный выбор")
    end

    responseCombo:ChooseOptionID(1) -- Default to Rating

    local createButton = createButton(mainPanel, "Создать голосование", FONTS.TEXT_MEDIUM, COLORS.BTN_NORMAL, COLORS.BTN_HOVER, COLORS.BTN_DISABLED, 20, 420, 540, 40, function()
        if validateInputs(nameInput, durationInput, responseCombo, ratingSettings, optionsSettings) then
            sendVoteData(nameInput, durationInput, responseCombo, ratingSettings, optionsSettings)
            frame:Close()
        end
    end)

    return frame
end

-- Handle vote results
local function handleVoteResults(voteId, voteResults, responseType)
    print(responseType)
    if responseType == "Rating" then
        local totalRating, numVotes = 0, 0
        for rating, votes in pairs(voteResults) do
            totalRating = totalRating + (rating * votes)
            numVotes = numVotes + votes
        end
        local averageRating = numVotes > 0 and (totalRating / numVotes) or 0
        chat.AddText(COLORS.YELLOW, "[Голосование] ", COLORS.WHITE, "Средняя оценка: ", COLORS.GREEN, string.format("%.2f", averageRating))
    elseif responseType == "Multiple Choice" then
        local maxVotes, winningOptions = 0, {}
        for option, votes in pairs(voteResults) do
            if votes > maxVotes then
                maxVotes = votes
                winningOptions = {option}
            elseif votes == maxVotes then
                table.insert(winningOptions, option)
            end
        end
        if #winningOptions == 1 then
            chat.AddText(COLORS.YELLOW, "[Голосование] ", COLORS.WHITE, "Победивший вариант: ", COLORS.GREEN, winningOptions[1])
        else
            local randomWinner = winningOptions[math.random(1, #winningOptions)]
            chat.AddText(COLORS.YELLOW, "[Голосование] ", COLORS.WHITE, "Несколько вариантов имеют одинаковое количество голосов. Случайный победитель: ", COLORS.GREEN, randomWinner)
        end
    end
end

-- Net message handlers
net.Receive("VotingPlugin", function()
    local messageType = net.ReadUInt(4)

    if messageType == 1 then -- OpenMenu
        createVoteCreationMenu()
    elseif messageType == 3 then -- VoteStatus
        local voteStatusType = net.ReadUInt(2)

        if voteStatusType == 1 then -- Notify vote
            local voteId = net.ReadUInt(32)
            local voteName = net.ReadString()
            local voteOptions = net.ReadTable()
            local voteResponseType = net.ReadString()
            local voteMinRating = net.ReadInt(32)
            local voteMaxRating = net.ReadInt(32)
            local voteDuration = net.ReadUInt(32)

            createVoteStatusUI(voteId, voteName, voteOptions, voteResponseType, voteMinRating, voteMaxRating, voteDuration)
        elseif voteStatusType == 2 then -- Update vote status
            local voteId = net.ReadUInt(32)
            local voteResults = net.ReadTable()
            local isClosed = net.ReadBool()
            local responseType = net.ReadString()
            updateVoteStatusUI(voteId, voteResults, isClosed, responseType)
        elseif voteStatusType == 3 then -- Vote results
            local voteId = net.ReadUInt(32)
            local voteResults = net.ReadTable()
            local responseType = net.ReadString()

            handleVoteResults(voteId, voteResults, responseType)
        end
    elseif messageType == 6 then -- CancelVote
        local voteId = net.ReadUInt(32)
        local frame = VOTE_STATUS_UI[voteId]
        if IsValid(frame) then
            frame:Close()
            VOTE_STATUS_UI[voteId] = nil
        end
        chat.AddText(COLORS.YELLOW, "[Голосование] ", COLORS.WHITE, "Голосование было отменено администратором.")
    end
end)

concommand.Add("votecreate", function(ply)
    if IsValid(ply) and ply:IsAdmin() then
        createVoteCreationMenu()
    else
        chat.AddText(COLORS.RED, "У вас нет прав для создания голосований.")
    end
end)