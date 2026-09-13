--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--[[
   _____                       _  _____           _                 
  / ____|                     | |/ ____|         | |                
 | (___   __ _ _   _  __ _  __| | (___  _   _ ___| |_ ___ _ __ ___  
  \___ \ / _` | | | |/ _` |/ _` |\___ \| | | / __| __/ _ \ '_ ` _ \ 
  ____) | (_| | |_| | (_| | (_| |____) | |_| \__ \ ||  __/ | | | | |
 |_____/ \__, |\__,_|\__,_|\__,_|_____/ \__, |___/\__\___|_| |_| |_|
            | |                          __/ |                      
            |_|                         |___/                       

	Created by Summe: https://steamcommunity.com/id/DerSumme/ 
    Purchased content: https://discord.gg/k6YdMwj9w2
]]
--
local colorBlank = Color(0, 0, 0, 0)
local class_icon = Material('luna_ui_base/elements/republic.png', 'smooth noclamp')
--[[ -------------------------------------------------------------------------- ]]
--[[         Creates the squad overview on the right side of the screen         ]]
--[[ -------------------------------------------------------------------------- ]]
-- Old version of the sideboard
-- function SquadSystem:CreateSideboard()
--     if IsValid(self.Sideboard) then self.Sideboard:Remove() end
--     local squad = LocalPlayer():GetSquad()
--     if not squad then return end
--     local width, height = ScrW() * .15, ScrH() * .5
--     --local posX, posY = ScrW() * .005, ScrH() * .035
--     local posX, posY = ScrW() * .005, ScrH() - height - 200
--     local title = squad:GetTitle()
--     local intPol
--     local pPanelHeight = height * .07
--     self.Sideboard = vgui.Create('DPanel')
--     --self.Sideboard:SetSize(width, height)
--     self.Sideboard:SetSize(width, math.Clamp((#squad:GetMembers() + 1 or 0) * pPanelHeight + height * .11, 0, 500))
--     self.Sideboard.IsFocused = false
--     self.Sideboard:SetPos(posX, ScrH() - self.Sideboard:GetTall() - 100)
--     function self.Sideboard:Paint(w, h)
--         --draw.RoundedBox(8, 0, 0, w, h, ColorAlpha(color_white, 10))
--         --draw.DrawText('Отряд: ' ..title, 'SquadSystem.Sideboard.Title', w * .025, h * .01, color_white, TEXT_ALIGN_LEFT)
--         -- draw.RoundedBox(8, w * .1, h * .09, w * .5, h *.003, ColorAlpha(color_white, 50))
--         -- draw.RoundedBox(8, w * .7, h * .09, w, h *.003, ColorAlpha(color_white, 50))
--         -- draw.RoundedBox(8, w * .5, h * .095, w * .7, h *.003, ColorAlpha(color_white, 50))
--         -- draw.RoundedBox(8, 0, h * .095, w * .4, h *.003, ColorAlpha(color_white, 50))
--         intPol = math.abs(math.cos(CurTime())) * 255
--     end

--     function SquadSystem.Sideboard:Open()
--         if not IsValid(self) then
--             print(0)
--             return
--         end

--         SquadSystem:CreateRadial()
--         self:MakePopup()
--         self:SetKeyboardInputEnabled(false)
--         self.IsFocused = true
--     end

--     function SquadSystem.Sideboard:Close()
--         if not IsValid(self) then return end
--         self:SetMouseInputEnabled(false)
--         self.IsFocused = false
--     end

--     function SquadSystem.Sideboard:Think()
--         local keyDown = input.IsKeyDown(SummeLibrary:GetBind('SquadSystem - Main'))
--         if keyDown then return end
--         self:Close()
--     end

--     local panel = vgui.Create('DScrollPanel', self.Sideboard)
--     panel:Dock(FILL)
--     panel:DockMargin(width * .01, height * .11, width * .01, height * .01)
--     function panel:Paint(w, h)
--     end

--     local sbar = panel:GetVBar()
--     sbar:SetSize(0, 0)
--     function sbar:Paint(w, h)
--         draw.RoundedBox(8, 0, 0, 0, 0, Color(124, 124, 124))
--     end

--     function sbar.btnUp:Paint(w, h)
--         draw.RoundedBox(8, 0, 0, 0, 0, Color(124, 124, 124))
--     end

--     function sbar.btnDown:Paint(w, h)
--         draw.RoundedBox(8, 0, 0, 0, 0, Color(124, 124, 124))
--     end

--     function sbar.btnGrip:Paint(w, h)
--         draw.RoundedBox(8, 0, 0, 0, 0, Color(124, 124, 124))
--     end

--     for k, v in SortedPairs(squad:GetMembers()) do
--         local playerPanel = vgui.Create('DButton', panel)
--         playerPanel:Dock(TOP)
--         playerPanel:SetText('')
--         playerPanel:DockMargin(0, 0, 0, height * .01)
--         playerPanel:SetSize(0, pPanelHeight)
--         playerPanel.NormalColor = colorBlank
--         function playerPanel:Paint(w, h)
--             if not IsValid(v) then return end
--             local bgCol = colorBlank
--             if self:IsHovered() then
--                 bgCol = Color(255, 255, 255, 20)
--                 draw.RoundedBox(10, 0, 0, w, h, self.NormalColor)
--             end

--             local icon
--             local logic = v:GetNetVar("features")
--             if logic then
--                 for feature, status in pairs(logic) do
--                     if status then
--                         icon = Material(FEATURES_TO_NORMAL[feature].icon)
--                         break
--                     end
--                 end
--             end

--             surface.SetDrawColor(color_white)
--             surface.SetMaterial(icon and icon or class_icon)
--             surface.DrawTexturedRect(width * .023, height * .0, 36, 36)
--             self.NormalColor = SummeLibrary:LerpColor(FrameTime() * 12, self.NormalColor, bgCol)
--             local tw1 = draw.SimpleText(v:Name(), 'SquadSystem.Sideboard.PlayerName', w * .2, h * .01, color_white, TEXT_ALIGN_LEFT)
--             local tw2 = draw.SimpleText(SquadSystem.Config.Positions[v:GetSquadPosition()].name, 'SquadSystem.Sideboard.PlayerDetails', w * .20, h * .45, color_white, TEXT_ALIGN_LEFT)
--             local color = color_white
--             local health = v:Health()
--             if health <= 75 and health >= 40 then
--                 color = Color(255, 174, 0)
--             elseif health <= 39 and health >= 10 then
--                 color = Color(255, 0, 0)
--             elseif health < 10 then
--                 color = Color(110, 0, 0)
--             end

--             surface.SetDrawColor(ColorAlpha(color, intPol))
--             SummeLibrary:DrawImgur(w * .86, h * .25, w * .1, h * .5, 'GeDR0zh')
--             if not SquadSystem.Config.Sideboard.showAvatars then local tw1 = draw.SimpleText('-', 'SquadSystem.Sideboard.PlayerName', w * .08, h * .18, color_white, TEXT_ALIGN_LEFT) end
--         end

--         local options = {
--             [1] = {
--                 func = function() SquadSystem:RequestSquadKick(v) end,
--                 name = SquadSystem:L('ADMINISTRATION_KickPlayer'),
--                 imgur = 'OAS57GL',
--             },
--         }

--         local blurMat = Material('pp/blurscreen')
--         function playerPanel:DoClick()
--             if not LocalPlayer():IsSquadLeader() then return end
--             local menu = DermaMenu()
--             function menu:Paint(w, h)
--                 surface.SetMaterial(blurMat)
--                 surface.SetDrawColor(255, 255, 255)
--                 local x, y = self:LocalToScreen(0, 0)
--                 for i = -(passes or 0.2), 1, 0.2 do
--                     blurMat:SetFloat('$blur', i * 5)
--                     blurMat:Recompute()
--                     render.UpdateScreenEffectTexture()
--                     surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
--                 end
--             end

--             for _, data in SortedPairs(options) do
--                 local line = menu:AddOption(data.name, data.func)
--                 line:SetColor(color_white)
--                 line:SetFont('SquadSystem.Sideboard.Context')
--                 function line:Paint(w, h)
--                     if self:IsHovered() then
--                         draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(color_white, 20))
--                     else
--                         draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(color_white, 10))
--                     end

--                     if not data.imgur then return end
--                     surface.SetDrawColor(color_white)
--                     SummeLibrary:DrawImgur(w * .025, h * .05, h * .9, h * .9, data.imgur)
--                 end
--             end

--             local subMenu, rankSubMenu = menu:AddSubMenu(SquadSystem:L('ADMINISTRATION_ChangePos'))
--             rankSubMenu:SetColor(color_white)
--             rankSubMenu:SetFont('SquadSystem.Sideboard.Context')
--             function rankSubMenu:Paint(w, h)
--                 if self:IsHovered() then
--                     draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(color_white, 20))
--                 else
--                     draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(color_white, 10))
--                 end

--                 surface.SetDrawColor(color_white)
--                 SummeLibrary:DrawImgur(w * .025, h * .05, h * .9, h * .9, 'MuT41yi')
--             end

--             function subMenu:Paint(w, h)
--                 if self:IsHovered() then
--                     draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(color_white, 20))
--                 else
--                     draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(color_white, 10))
--                 end
--             end

--             for key, data in SortedPairs(SquadSystem.Config.Positions) do
--                 local line = subMenu:AddOption(data.name, function() SquadSystem:RequestPositionChange(v, key) end)
--                 line:SetColor(color_white)
--                 line:SetFont('SquadSystem.Sideboard.Context')
--                 function line:Paint(w, h)
--                     if self:IsHovered() then
--                         draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(color_white, 20))
--                     else
--                         draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(color_white, 10))
--                     end

--                     if not data.imgur then return end
--                     surface.SetDrawColor(color_white)
--                     SummeLibrary:DrawImgur(w * .025, h * .05, h * .9, h * .9, data.imgur)
--                 end
--             end

--             menu:Open()
--         end
--     end
-- end

function SquadSystem:CreateSideboard()
    if IsValid(self.Sideboard) then self.Sideboard:Remove() end
    local squad = LocalPlayer():GetSquad()
    if not squad then return end
    local width, height = ScrW() * .15, ScrH() * .5
    local posX, posY = ScrW() * .005, ScrH() - height - 200
    local title = squad:GetTitle()
    local intPol
    local pPanelHeight = height * .07
    self.Sideboard = vgui.Create('DPanel')
    self.Sideboard:SetSize(width, pPanelHeight * 2 + height * .11)
    self.Sideboard.IsFocused = false
    self.Sideboard:SetPos(posX, ScrH() - self.Sideboard:GetTall() - 125)
    function self.Sideboard:Paint(w, h)
        intPol = math.abs(math.cos(CurTime())) * 255
    end

    -- НЕ ПРОВЕРЕНО КАК ВЫГЛЯДИТ С БОЛЬШИМ ОТРЯДОМ, ЕСЛИ ЧТО ПРОСТО ЗАКОММЕНТИТЬ ЭТУ ПАНЕЛЬ
    local positionCountPanel = vgui.Create('DPanel', self.Sideboard)
    positionCountPanel:SetSize(width, pPanelHeight)
    positionCountPanel:SetPos(0, height * .11)
    function positionCountPanel:Paint(w, h)
        local positionCounts = {}
        for _, member in pairs(squad:GetMembers()) do
            local pos = member:GetSquadPosition()
            if pos == 1 then continue end
            positionCounts[pos] = (positionCounts[pos] or 0) + 1
        end

        local x = w * 0.05
        for pos, count in SortedPairs(positionCounts) do
            local posName = SquadSystem.Config.Positions[pos].name
            local text = posName .. ": " .. count
            local textW, textH = surface.GetTextSize(text)
            draw.SimpleText(text, 'SquadSystem.Sideboard.Context', x, h * 0.5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            x = x + textW + w * 0.05
        end
    end

    function SquadSystem.Sideboard:Open()
        if not IsValid(self) then return end
        SquadSystem:CreateRadial()
        self:MakePopup()
        self:SetKeyboardInputEnabled(false)
        self.IsFocused = true
    end

    function SquadSystem.Sideboard:Close()
        if not IsValid(self) then return end
        self:SetMouseInputEnabled(false)
        self.IsFocused = false
    end

    function SquadSystem.Sideboard:Think()
        local keyDown = input.IsKeyDown(SummeLibrary:GetBind('SquadSystem - Main'))
        if keyDown then return end
        self:Close()
    end

    local panel = vgui.Create('DScrollPanel', self.Sideboard)
    panel:Dock(FILL)
    panel:DockMargin(width * .01, height * .11 + pPanelHeight, width * .01, height * .01)
    function panel:Paint(w, h) end

    local sbar = panel:GetVBar()
    sbar:SetSize(0, 0)
    function sbar:Paint(w, h) end
    function sbar.btnUp:Paint(w, h) end
    function sbar.btnDown:Paint(w, h) end
    function sbar.btnGrip:Paint(w, h) end

    local leader
    for k, v in SortedPairs(squad:GetMembers()) do
        local playerPanel = vgui.Create('DButton', panel)
        playerPanel:Dock(TOP)
        playerPanel:SetText('')
        playerPanel:DockMargin(0, 0, 0, height * .01)
        playerPanel:SetSize(0, pPanelHeight)
        playerPanel.NormalColor = colorBlank
        
        if v:GetSquadPosition() == 1 then
            leader = v
            playerPanel:SetVisible(true)
        else
            playerPanel:SetVisible(false)
        end

        function playerPanel:Paint(w, h)
            if not IsValid(v) then return end
            local bgCol = colorBlank
            if self:IsHovered() then
                bgCol = Color(255, 255, 255, 20)
                draw.RoundedBox(10, 0, 0, w, h, self.NormalColor)
            end

            local icon
            local logic = v:GetNetVar("features")
            if logic then
                for feature, status in pairs(logic) do
                    if status then
                        icon = Material(FEATURES_TO_NORMAL[feature].icon)
                        break
                    end
                end
            end

            surface.SetDrawColor(color_white)
            surface.SetMaterial(icon and icon or class_icon)
            surface.DrawTexturedRect(width * .023, height * .0, 32, 32)
            self.NormalColor = SummeLibrary:LerpColor(FrameTime() * 12, self.NormalColor, bgCol)
            local tw1 = draw.SimpleText(v:Name(), 'SquadSystem.Sideboard.PlayerName', w * .2, h * .01, color_white, TEXT_ALIGN_LEFT)
            local tw2 = draw.SimpleText(SquadSystem.Config.Positions[v:GetSquadPosition()].name, 'SquadSystem.Sideboard.PlayerDetails', w * .20, h * .45, color_white, TEXT_ALIGN_LEFT)
            local color = color_white
            local health = v:Health()
            if health <= 75 and health >= 40 then
                color = Color(255, 174, 0)
            elseif health <= 39 and health >= 10 then
                color = Color(255, 0, 0)
            elseif health < 10 then
                color = Color(110, 0, 0)
            end

            surface.SetDrawColor(ColorAlpha(color, intPol))
            SummeLibrary:DrawImgur(w * .86, h * .25, w * .1, h * .5, 'GeDR0zh')
            if not SquadSystem.Config.Sideboard.showAvatars then local tw1 = draw.SimpleText('-', 'SquadSystem.Sideboard.PlayerName', w * .08, h * .18, color_white, TEXT_ALIGN_LEFT) end
        end

        function playerPanel:DoClick()
            if not LocalPlayer():IsSquadLeader() then return end
            local menu = DermaMenu()
            function menu:Paint(w, h)
                surface.SetMaterial(blurMat)
                surface.SetDrawColor(255, 255, 255)
                local x, y = self:LocalToScreen(0, 0)
                for i = -(passes or 0.2), 1, 0.2 do
                    blurMat:SetFloat('$blur', i * 5)
                    blurMat:Recompute()
                    render.UpdateScreenEffectTexture()
                    surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
                end
            end

            local options = {
                [1] = {
                    func = function() SquadSystem:RequestSquadKick(v) end,
                    name = SquadSystem:L('ADMINISTRATION_KickPlayer'),
                    imgur = 'OAS57GL',
                },
            }

            for _, data in SortedPairs(options) do
                local line = menu:AddOption(data.name, data.func)
                line:SetColor(color_white)
                line:SetFont('SquadSystem.Sideboard.Context')
                function line:Paint(w, h)
                    if self:IsHovered() then
                        draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(color_white, 20))
                    else
                        draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(color_white, 10))
                    end

                    if not data.imgur then return end
                    surface.SetDrawColor(color_white)
                    SummeLibrary:DrawImgur(w * .025, h * .05, h * .9, h * .9, data.imgur)
                end
            end

            local subMenu, rankSubMenu = menu:AddSubMenu(SquadSystem:L('ADMINISTRATION_ChangePos'))
            rankSubMenu:SetColor(color_white)
            rankSubMenu:SetFont('SquadSystem.Sideboard.Context')
            function rankSubMenu:Paint(w, h)
                if self:IsHovered() then
                    draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(color_white, 20))
                else
                    draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(color_white, 10))
                end

                surface.SetDrawColor(color_white)
                SummeLibrary:DrawImgur(w * .025, h * .05, h * .9, h * .9, 'MuT41yi')
            end

            function subMenu:Paint(w, h)
                if self:IsHovered() then
                    draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(color_white, 20))
                else
                    draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(color_white, 10))
                end
            end

            for key, data in SortedPairs(SquadSystem.Config.Positions) do
                local line = subMenu:AddOption(data.name, function() SquadSystem:RequestPositionChange(v, key) end)
                line:SetColor(color_white)
                line:SetFont('SquadSystem.Sideboard.Context')
                function line:Paint(w, h)
                    if self:IsHovered() then
                        draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(color_white, 20))
                    else
                        draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(color_white, 10))
                    end

                    if not data.imgur then return end
                    surface.SetDrawColor(color_white)
                    SummeLibrary:DrawImgur(w * .025, h * .05, h * .9, h * .9, data.imgur)
                end
            end

            menu:Open()
        end
    end
end

--[[ -------------------------------------------------------------------------- ]]
--[[                        Opens the squad creator menu                        ]]
--[[ -------------------------------------------------------------------------- ]]
SquadSystem.Creator = {}
local blurMat = Material('pp/blurscreen')
function SquadSystem.Creator:Open()
    if IsValid(SquadSystem.CreatorMenu) then SquadSystem.CreatorMenu:Remove() end
    local width = ScrW() * .4
    local height = ScrH() * .4
    SquadSystem.CreatorMenu = vgui.Create('DFrame')
    SquadSystem.CreatorMenu:SetTitle('')
    SquadSystem.CreatorMenu:SetSize(width, height)
    SquadSystem.CreatorMenu:MakePopup()
    SquadSystem.CreatorMenu:Center()
    SquadSystem.CreatorMenu:SetDraggable(false)
    SquadSystem.CreatorMenu:ShowCloseButton(false)
    function SquadSystem.CreatorMenu:Paint(w, h)
        --surface.SetMaterial(blurMat)
        --surface.SetDrawColor(255,255,255)
        --draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 50))
        -- draw.RoundedBoxPoly(20, 0, 0, w, h)
        -- surface.SetMaterial(blurMat)
        --surface.SetDrawColor(0, 0, 0, 50)
        -- draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 50))
        local x, y = self:LocalToScreen(0, 0)
        -- for i = -(passes or 0.2), 1, 0.2 do
        --     -- Do things to the blur material to make it blurry.
        --     blurMat:SetFloat('$blur', i * 5)
        --     blurMat:Recompute()
        --     -- Draw the blur material over the screen.
        --     render.UpdateScreenEffectTexture()
        --     surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
        -- end
        draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 150))
        --draw.OutlinedBox(0, 0, w, h, 1, color_white)
        draw.DrawText('Rejestracja oddziału', 'SquadSystem.Invite.Title', w * .03, h * .02, color_white, TEXT_ALIGN_LEFT)
        draw.RoundedBox(4, w * .03, h * .2, w * .44, h * .01, ColorAlpha(color_white, 50))
        surface.SetDrawColor(ColorAlpha(color_white, 50))
        SummeLibrary:DrawImgur(w * .03, h * .75, h * .2, h * .2, 'EqAsayW')
    end

    local closeButton = vgui.Create('SummeLibrary.CloseButton', SquadSystem.CreatorMenu)
    closeButton:SetPos(width * .95, height * .015)
    closeButton:SetSize(height * .07, height * .07)
    closeButton:SetUp(function() SquadSystem.CreatorMenu:Remove() end)
    local titleInput = vgui.Create('SummeLibrary.TextEntry', SquadSystem.CreatorMenu)
    titleInput:SetSize(width * .3, height * .1)
    titleInput:SetPos(width * .035, height * .3)
    titleInput:SetPlaceholder(SquadSystem:L('CREATOR_Placeholder'))
    titleInput:SetFont('SquadSystem.Commands.SubTitle')
    titleInput:SetText('')
    local publicButton = vgui.Create('DButton', SquadSystem.CreatorMenu)
    publicButton:SetPos(width * .03, height * .5)
    publicButton:SetSize(width * .28, height * .08)
    publicButton:SetText('')
    publicButton.PolationStatus = 0
    publicButton.NormalColor = Color(158, 158, 158, 0)
    publicButton.Status = false
    function publicButton:Paint(w, h)
        local bgCol = Color(158, 158, 158, 0)
        if self:IsHovered() then
            bgCol = Color(160, 160, 160, 40)
            self.PolationStatus = math.Clamp(self.PolationStatus + 10 * FrameTime(), 0, 1)
        else
            self.PolationStatus = math.Clamp(self.PolationStatus - 10 * FrameTime(), 0, 1)
        end

        self.NormalColor = SummeLibrary:LerpColor(FrameTime() * 12, self.NormalColor, bgCol)
        draw.RoundedBox(8, 0, 0, w, h, self.NormalColor)
        surface.SetDrawColor(color_white)
        SummeLibrary:DrawImgur(w * .02, h * .1, h * .8, h * .8, publicButton.Status and 'ExHkfJq' or 'aVmdI7R')
        draw.DrawText('Publiczna jednostka?', 'SquadSystem.Sideboard.PlayerName', w * .2, h * .15, SummeLibrary:GetColor('greyLight'), TEXT_ALIGN_LEFT)
    end

    function publicButton:Toggle()
        if self.Status then
            self.Status = false
        else
            self.Status = true
        end
    end

    function publicButton:DoClick()
        self:Toggle()
    end

    local hintText = vgui.Create('DLabel', SquadSystem.CreatorMenu)
    hintText:SetSize(width * .6, height * .4)
    hintText:SetPos(width * .165, height * .647)
    hintText:SetColor(ColorAlpha(color_white, 50))
    hintText:SetFont('SquadSystem.Create.Hint')
    hintText:SetText(SquadSystem:L('CREATOR_Hint'))
    hintText:SetWrap(true)
    local acceptButton = vgui.Create('DButton', SquadSystem.CreatorMenu)
    acceptButton:SetPos(width * .55, height * .3)
    acceptButton:SetSize(width * .35, height * .35)
    acceptButton:SetText('')
    acceptButton.PolationStatus = 0
    acceptButton.NormalColor = Color(255, 255, 255)
    function acceptButton:Paint(w, h)
        local bgCol = Color(255, 255, 255)
        if self:IsHovered() then
            bgCol = Color(5, 255, 5)
            self.PolationStatus = math.Clamp(self.PolationStatus + 5 * FrameTime(), 0, 1)
        else
            self.PolationStatus = math.Clamp(self.PolationStatus - 5 * FrameTime(), 0, 1)
        end

        self.NormalColor = SummeLibrary:LerpColor(FrameTime() * 12, self.NormalColor, bgCol)
        surface.SetDrawColor(ColorAlpha(bgCol, 30))
        draw.NoTexture()
        draw.Circle(w * .5, h * .5, h * .5 * self.PolationStatus, 100)
        surface.SetDrawColor(bgCol)
        SummeLibrary:DrawImgur(w * .35, h * .25, h * .5, h * .5, 'rK9aMT4')
    end

    function acceptButton:DoClick()
        local title = titleInput:GetText()
        if #title <= 3 then return end
        if #title >= 20 then return end
        acceptButton:Remove()
        net.Start('SquadSystem.RequestCreateSquad')
        net.WriteString(title)
        net.WriteBool(publicButton.Status)
        net.SendToServer()
        SquadSystem.CreatorMenu:AlphaTo(0, .2, 0, function() SquadSystem.CreatorMenu:Remove() end)
    end
end

--[[ -------------------------------------------------------------------------- ]]
--[[                  Defines the options for the action wheel                  ]]
--[[ -------------------------------------------------------------------------- ]]
local options = {
    [1] = {
        name = 'Opuść oddział',
        imgur = 'w0UIzGm',
        func = function() SquadSystem:RequestLeave() end,
        requirement = function() return true end,
    },
    [2] = {
        name = SquadSystem:L('ACTIONWHEEL_Cmds'),
        imgur = 'qpXNf1l',
        func = function(master)
            local pnl = vgui.Create('SquadSystem.Radial')
            pnl:SetSize(ScrW(), ScrH())
            pnl:Center()
            pnl:MakePopup()
            pnl:SetKeyboardInputEnabled(false)
            pnl:SetTitle(SquadSystem:L('ACTIONWHEEL_Cmds'))
            pnl:SetPrimaryColor(Color(131, 131, 131, 164))
            pnl:SetBackgroundColor(Color(0, 0, 0, 100))
            for k, v in SortedPairs(SquadSystem.Config.Commands) do
                --if not v.requirement() then continue end
                pnl:AddContent({
                    display = {
                        type = 'imgur',
                        text = k,
                        imgur = v.imgur,
                    },
                    func = function() SquadSystem:RequestCommand(k) end,
                })
            end
        end,
        requirement = function() return LocalPlayer():IsSquadLeader() end,
    },
    [3] = {
        name = SquadSystem:L('ACTIONWHEEL_Comms'),
        imgur = 'GBoikHo',
        func = function()
            local pnl = vgui.Create('SquadSystem.Radial')
            pnl:SetSize(ScrW(), ScrH())
            pnl:Center()
            pnl:MakePopup()
            pnl:SetKeyboardInputEnabled(false)
            pnl:SetTitle('Komunikacja')
            pnl:SetPrimaryColor(Color(131, 131, 131, 164))
            pnl:SetBackgroundColor(Color(0, 0, 0, 100))
            for k, v in SortedPairs(SquadSystem.Config.Communications) do
                --if not v.requirement() then continue end
                pnl:AddContent({
                    display = {
                        type = 'imgur',
                        text = k,
                        imgur = v.imgur,
                    },
                    func = function() SquadSystem:RequestCommunication(k) end,
                })
            end
        end,
        requirement = function() return true end,
    },
    [4] = {
        name = SquadSystem:L('ACTIONWHEEL_ToggleNametags'),
        imgur = 'OqJEYU6',
        func = function() SquadSystem:ToggleNametags() end,
        requirement = function() return true end,
    },
    [5] = {
        name = SquadSystem:L('ACTIONWHEEL_Invite'),
        imgur = '6sP5SH9',
        func = function(master)
            local entity = LocalPlayer():GetEyeTrace().Entity
            if not entity:IsPlayer() then return end
            SquadSystem:RequestInvitation(entity)
        end,
        requirement = function()
            if not LocalPlayer():IsSquadLeader() then return false end
            local entity = LocalPlayer():GetEyeTrace().Entity
            if not entity:IsPlayer() then return false end
            if LocalPlayer():GetSquad() == entity:GetSquad() then return false end
            return true
        end,
    },
}

--[[ -------------------------------------------------------------------------- ]]
--[[                      Creates the general action wheel                      ]]
--[[ -------------------------------------------------------------------------- ]]
function SquadSystem:CreateRadial()
    self.Radial = vgui.Create('SquadSystem.Radial')
    self.Radial:SetSize(ScrW(), ScrH())
    self.Radial:Center()
    self.Radial:MakePopup()
    self.Radial:SetKeyboardInputEnabled(false)
    self.Radial:SetTitle('Меню отряда')
    self.Radial:SetPrimaryColor(Color(0, 0, 0, 150))
    self.Radial:SetBackgroundColor(Color(0, 0, 0, 100))
    for k, v in pairs(options) do
        if not v.requirement() then continue end
        self.Radial:AddContent({
            display = {
                type = 'imgur',
                text = v.name,
                imgur = v.imgur,
            },
            func = v.func,
        })
    end

    function SquadSystem.Radial:Think()
        local keyDown = input.IsKeyDown(SummeLibrary:GetBind('SquadSystem - Main'))
        if keyDown then return end
        self:Close()
    end
end

--[[ -------------------------------------------------------------------------- ]]
--[[                          Creates the invite frame                          ]]
--[[ -------------------------------------------------------------------------- ]]
function SquadSystem:InviteFrame(inviter)
    local squad = inviter:GetSquad()
    if not squad then
        ErrorNoHaltWithStack('Error while getting Squad from cache!')
        return
    end

    local squadTitle = string.upper(squad:GetTitle())
    local width = ScrW() * .6
    local height = ScrH() * .7
    self.inviteFrame = vgui.Create('DFrame')
    self.inviteFrame:SetTitle('')
    self.inviteFrame:SetSize(width, height)
    self.inviteFrame:MakePopup()
    self.inviteFrame:Center()
    self.inviteFrame:SetDraggable(false)
    self.inviteFrame:ShowCloseButton(false)
    function self.inviteFrame:Paint(w, h)
        --surface.SetMaterial(blurMat)
        --surface.SetDrawColor(255,255,255)
        --draw.RoundedBox(8, 0, 0, w, h, Color(44,44,44,171))
        --draw.RoundedBoxPoly(20, 0, 0, w, h)
        -- surface.SetMaterial(blurMat)
        -- surface.SetDrawColor(255, 255, 255)
        local x, y = self:LocalToScreen(0, 0)
        -- for i = -(passes or 0.2), 1, 0.2 do
        --     -- Do things to the blur material to make it blurry.
        --     blurMat:SetFloat('$blur', i * 5)
        --     blurMat:Recompute()
        --     -- Draw the blur material over the screen.
        --     render.UpdateScreenEffectTexture()
        --     surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
        -- end
        draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 150))
        --draw.OutlinedBox(0, 0, w, h, 1, color_white)
        draw.DrawText(SquadSystem:L('INVITE_Title'), 'SquadSystem.Invite.Title', w * .03, h * .02, color_white, TEXT_ALIGN_LEFT)
        draw.RoundedBox(8, w * .03, h * .12, w * .54, h * .005, ColorAlpha(color_white, 50))
        draw.SimpleText(SquadSystem:L('INVITE_SubTitle'), 'SquadSystem.Invite.Text', w * .6, h * .2, color_white, TEXT_ALIGN_LEFT)
        local _w = draw.SimpleText(squadTitle, 'SquadSystem.Invite.Text', w * .63, h * .265, color_white, TEXT_ALIGN_LEFT)
        draw.SimpleText('?', 'SquadSystem.Invite.Text', w * .63 + _w, h * .265, color_white, TEXT_ALIGN_LEFT)
    end

    local closeButton = vgui.Create('SummeLibrary.CloseButton', self.inviteFrame)
    closeButton:SetPos(width * .967, height * .01)
    closeButton:SetSize(height * .04, height * .04)
    closeButton:SetUp(function()
        closeButton:Remove()
        net.Start('SquadSystem.InviteDecision')
        net.WriteBool(false)
        net.SendToServer()
        self.inviteFrame:AlphaTo(0, .2, 0, function() self.inviteFrame:Remove() end)
    end)

    local avatar = vgui.Create('SummeLibrary.CircularAvatar', self.inviteFrame)
    avatar:SetPlayer(inviter, 512)
    avatar:SetSize(height * .3, height * .3)
    avatar:SetPos(width * .29, height * .2)
    local avatar = vgui.Create('SummeLibrary.CircularAvatar', self.inviteFrame)
    avatar:SetPlayer(LocalPlayer(), 512)
    avatar:SetSize(height * .3, height * .3)
    avatar:SetPos(width * .4, height * .2)
    local avMap = {
        [1] = {
            pos = {
                x = width * .1,
                y = height * .2
            },
            size = {
                w = height * .15,
                h = height * .15
            }
        },
        [2] = {
            pos = {
                x = width * .04,
                y = height * .3
            },
            size = {
                w = height * .1,
                h = height * .1
            }
        },
        [3] = {
            pos = {
                x = width * .2,
                y = height * .2
            },
            size = {
                w = height * .08,
                h = height * .08
            }
        },
        [4] = {
            pos = {
                x = width * .03,
                y = height * .14
            },
            size = {
                w = height * .09,
                h = height * .09
            }
        },
        [5] = {
            pos = {
                x = width * .15,
                y = height * .36
            },
            size = {
                w = height * .12,
                h = height * .12
            }
        },
        [6] = {
            pos = {
                x = width * .24,
                y = height * .3
            },
            size = {
                w = height * .06,
                h = height * .06
            }
        }
    }

    for key, ply in RandomPairs(squad:GetMembers()) do
        if ply == inviter then continue end
        local selMap, k = table.Random(avMap)
        if not selMap then continue end
        avMap[k] = nil
        local avatar = vgui.Create('SummeLibrary.CircularAvatar', self.inviteFrame)
        avatar:SetPlayer(ply, 212)
        avatar:SetSize(selMap.size.w, selMap.size.h)
        avatar:SetPos(selMap.pos.x, selMap.pos.y)
    end

    local acceptButton = vgui.Create('DButton', self.inviteFrame)
    acceptButton:SetPos(width * .025, height * .575)
    acceptButton:SetSize(width * .4, height * .4)
    acceptButton:SetText('')
    acceptButton.PolationStatus = 0
    acceptButton.NormalColor = Color(255, 255, 255)
    function acceptButton:Paint(w, h)
        local bgCol = Color(255, 255, 255)
        if self:IsHovered() then
            bgCol = Color(5, 255, 5)
            self.PolationStatus = math.Clamp(self.PolationStatus + 5 * FrameTime(), 0, 1)
        else
            self.PolationStatus = math.Clamp(self.PolationStatus - 5 * FrameTime(), 0, 1)
        end

        self.NormalColor = SummeLibrary:LerpColor(FrameTime() * 12, self.NormalColor, bgCol)
        surface.SetDrawColor(ColorAlpha(bgCol, 30))
        draw.NoTexture()
        draw.Circle(w * .5, h * .5, h * .5 * self.PolationStatus, 100)
        surface.SetDrawColor(bgCol)
        SummeLibrary:DrawImgur(w * .32, h * .25, h * .5, h * .5, 'rK9aMT4')
    end

    function acceptButton:DoClick()
        self:Remove()
        net.Start('SquadSystem.InviteDecision')
        net.WriteBool(true)
        net.SendToServer()
        SquadSystem.inviteFrame:AlphaTo(0, .2, 0, function() SquadSystem.inviteFrame:Remove() end)
    end

    local denyButton = vgui.Create('DButton', self.inviteFrame)
    denyButton:SetPos(width * .525, height * .575)
    denyButton:SetSize(width * .4, height * .4)
    denyButton:SetText('')
    denyButton.PolationStatus = 0
    denyButton.NormalColor = Color(255, 255, 255)
    function denyButton:Paint(w, h)
        local bgCol = Color(255, 255, 255)
        if self:IsHovered() then
            bgCol = Color(255, 5, 5)
            self.PolationStatus = math.Clamp(self.PolationStatus + 5 * FrameTime(), 0, 1)
        else
            self.PolationStatus = math.Clamp(self.PolationStatus - 5 * FrameTime(), 0, 1)
        end

        self.NormalColor = SummeLibrary:LerpColor(FrameTime() * 12, self.NormalColor, bgCol)
        surface.SetDrawColor(ColorAlpha(bgCol, 30))
        draw.NoTexture()
        draw.Circle(w * .5, h * .5, h * .5 * self.PolationStatus, 100)
        surface.SetDrawColor(bgCol)
        SummeLibrary:DrawImgur(w * .32, h * .25, h * .5, h * .5, 'WiffD9w')
    end

    function denyButton:DoClick()
        self:Remove()
        net.Start('SquadSystem.InviteDecision')
        net.WriteBool(false)
        net.SendToServer()
        SquadSystem.inviteFrame:AlphaTo(0, .2, 0, function() SquadSystem.inviteFrame:Remove() end)
    end

    timer.Simple(60, function() if IsValid(self.inviteFrame) then denyButton:DoClick() end end)
end

--[[ -------------------------------------------------------------------------- ]]
--[[                             Squad browser list                             ]]
--[[ -------------------------------------------------------------------------- ]]
function SquadSystem:OpenList()
    local width = ScrW() * .6
    local height = ScrH() * .7
    self.list = vgui.Create('DFrame')
    self.list:SetTitle('')
    self.list:SetSize(width, height)
    self.list:MakePopup()
    self.list:Center()
    self.list:SetDraggable(false)
    self.list:ShowCloseButton(false)
    function self.list:Paint(w, h)
        --surface.SetMaterial(blurMat)
        --surface.SetDrawColor(255,255,255)
        --draw.RoundedBox(8, 0, 0, w, h, Color(44,44,44,171))
        --draw.RoundedBoxPoly(20, 0, 0, w, h)
        -- surface.SetMaterial(blurMat)
        -- surface.SetDrawColor(255, 255, 255)
        local x, y = self:LocalToScreen(0, 0)
        -- for i = -(passes or 0.2), 1, 0.2 do
        --     -- Do things to the blur material to make it blurry.
        --     blurMat:SetFloat('$blur', i * 5)
        --     blurMat:Recompute()
        --     -- Draw the blur material over the screen.
        --     render.UpdateScreenEffectTexture()
        --     surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
        -- end
        --draw.OutlinedBox(0, 0, w, h, 1, color_white)
        draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 150))
        draw.DrawText(SquadSystem:L('PUBLIC_Title'), 'SquadSystem.Invite.Title', w * .03, h * .02, color_white, TEXT_ALIGN_LEFT)
        draw.RoundedBox(8, w * .03, h * .12, w * .34, h * .005, ColorAlpha(color_white, 50))
    end

    local closeButton = vgui.Create('SummeLibrary.CloseButton', self.list)
    closeButton:SetPos(width * .967, height * .01)
    closeButton:SetSize(height * .04, height * .04)
    closeButton:SetUp(function()
        closeButton:Remove()
        self.list:AlphaTo(0, .2, 0, function() self.list:Remove() end)
    end)

    local scroll = vgui.Create('DScrollPanel', self.list)
    scroll:SetSize(width * .94, height * .83)
    scroll:SetPos(width * .03, height * .14)
    local sbar = scroll:GetVBar()
    sbar:SetSize(0, 0)
    function sbar:Paint(w, h)
        draw.RoundedBox(8, 0, 0, 0, 0, Color(124, 124, 124))
    end

    function sbar.btnUp:Paint(w, h)
        draw.RoundedBox(8, 0, 0, 0, 0, Color(124, 124, 124))
    end

    function sbar.btnDown:Paint(w, h)
        draw.RoundedBox(8, 0, 0, 0, 0, Color(124, 124, 124))
    end

    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(8, 0, 0, 0, 0, Color(124, 124, 124))
    end

    sbar.LerpTarget = 0
    function sbar:AddScroll(dlta)
        local OldScroll = self.LerpTarget or self:GetScroll()
        dlta = dlta * 75
        self.LerpTarget = math.Clamp(self.LerpTarget + dlta, -self.btnGrip:GetTall(), self.CanvasSize + self.btnGrip:GetTall())
        return OldScroll ~= self:GetScroll()
    end

    sbar.Think = function(s)
        local frac = FrameTime() * 5
        if math.abs(s.LerpTarget - s:GetScroll()) <= s.CanvasSize / 10 then frac = FrameTime() * 2 end
        local newpos = Lerp(frac, s:GetScroll(), s.LerpTarget)
        s:SetScroll(math.Clamp(newpos, 0, s.CanvasSize))
        if s.LerpTarget < 0 and s:GetScroll() <= 0 then
            s.LerpTarget = 0
        elseif s.LerpTarget > s.CanvasSize and s:GetScroll() >= s.CanvasSize then
            s.LerpTarget = s.CanvasSize
        end
    end

    for k, squad in pairs(SquadSystem.Cache) do
        if not squad:IsPublic() then continue end
        local owner = squad:GetOwner()
        local members = #squad:GetMembers()
        local plySquad = LocalPlayer():GetSquad()
        local isCurrentSquad = plySquad == squad
        if not owner or not IsValid(owner) then
            SummeLibrary:Print('squadsystem', 'Did not found owner of squad. Skipping it...')
            return
        end

        local panel = vgui.Create('DPanel', scroll)
        panel:Dock(TOP)
        panel:SetSize(0, height * .1)
        panel:DockMargin(0, 0, 0, height * .01)
        function panel:Paint(w, h)
            if not squad then return end
            local _w = draw.SimpleText(squad.name, 'SquadSystem.List.SQTitle', w * .08, h * .14, color_white, TEXT_ALIGN_LEFT) -- replace with oop
            draw.SimpleText(owner:Name(), 'SquadSystem.List.Details', w * .08, h * .55, color_white, TEXT_ALIGN_LEFT)
            --draw.OutlinedBox(0, 0, w, h, 1, color_white)
            draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 100))
            draw.RoundedBox(8, w * .09 + _w, h * .18, w * .06, h * .285, Color(0, 0, 0, 86))
            surface.SetDrawColor(color_white)
            SummeLibrary:DrawImgur(w * .1 + _w, h * .23, h * .2, h * .2, 'qw3mwbm')
            draw.DrawText(members, 'SquadSystem.List.Details', w * .1235 + _w, h * .185, color_white, TEXT_ALIGN_LEFT) -- replace with oop
        end

        local avatar = vgui.Create('SummeLibrary.CircularAvatar', panel)
        avatar:SetPlayer(owner, 128)
        avatar:SetPos(width * .01, height * .01)
        avatar:SetSize(height * .08, height * .08)
        local joinButton = vgui.Create('DButton', panel)
        joinButton:SetPos(width * .86, height * .01)
        joinButton:SetSize(width * .08, height * .08)
        joinButton:SetText('')
        joinButton.PolationStatus = 0
        joinButton.NormalColor = Color(255, 255, 255)
        function joinButton:Paint(w, h)
            local bgCol = Color(255, 255, 255)
            if self:IsHovered() then
                bgCol = isCurrentSquad and Color(255, 64, 64) or Color(5, 255, 5)
                self.PolationStatus = math.Clamp(self.PolationStatus + 5 * FrameTime(), 0, 1)
            else
                self.PolationStatus = math.Clamp(self.PolationStatus - 5 * FrameTime(), 0, 1)
            end

            self.NormalColor = SummeLibrary:LerpColor(FrameTime() * 12, self.NormalColor, bgCol)
            surface.SetDrawColor(ColorAlpha(bgCol, 30))
            draw.NoTexture()
            draw.Circle(w * .5, h * .5, h * .5 * self.PolationStatus, 100)
            surface.SetDrawColor(bgCol)
            SummeLibrary:DrawImgur(w * .37, h * .1, h * .5, h * .5, '4ViitKb')
            draw.DrawText('Dołącz', 'SquadSystem.List.Details', w * .5, h * .55, bgCol, TEXT_ALIGN_CENTER)
        end

        function joinButton:DoClick()
            if not squad then return end
            if isCurrentSquad then
                SummeLibrary:Notify('warning', 'Squads', SquadSystem:L('ERROR_AlreadyInSquad'))
                return
            end

            if LocalPlayer():GetSquad() then
                SummeLibrary:Notify('warning', 'Squads', SquadSystem:L('ERROR_AlreadyInASquad'))
                return
            end

            self:Remove()
            SquadSystem:RequestJoinPublic(squad:GetID())
            SquadSystem.list:AlphaTo(0, .2, 0, function() SquadSystem.list:Remove() end)
        end
    end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
