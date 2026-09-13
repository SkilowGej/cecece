--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if SERVER then
    local util_AddNetworkString = util.AddNetworkString
    local net_Receive = net.Receive
    local net_ReadString = net.ReadString
    local string_Replace = string.Replace
    local CurTime = CurTime
    local utf8_len = utf8.len
    local string_sub = string.sub
    local net_ReadBool = net.ReadBool
    local hook_Call = hook.Call
    local net_Start = net.Start
    local net_WriteInt = net.WriteInt
    local net_WriteString = net.WriteString
    local net_WriteBool = net.WriteBool
    local net_Broadcast = net.Broadcast

    local chatCooldown = 2
    local MaxLetters = 600

    local chatCooldowns = {}

    util_AddNetworkString('SupremeChat.Send')
    util_AddNetworkString('SupremeChat.Send2')

    util_AddNetworkString('SupremeChat.ChatPrintFix')
    util_AddNetworkString('SupremeChat.ChatState')
    
    net_Receive('SupremeChat.Send', function(_, p)

        local str = net_ReadString()
        str = string_Replace( str, '\n', '' )
        
        if not chatCooldowns[p] then
            chatCooldowns[p] = CurTime() + chatCooldown
        elseif chatCooldowns[p] > CurTime() then
            return
        else
            chatCooldowns[p] = CurTime() + chatCooldown
        end
        
        if utf8_len(str) > MaxLetters then
            str = string_sub(str, 1, MaxLetters)
        end
        
        local teamChat = net_ReadBool() or false
        local dead = net_ReadBool() or false
        
        local msg = hook_Call('PlayerSay', GAMEMODE, p, str, teamChat)
        if msg ~= '' then
            net_Start('SupremeChat.Send2')
                net_WriteInt(p:EntIndex(), 32)
                net_WriteString(str)
                net_WriteBool(teamChat)
                net_WriteBool(dead)
            net_Broadcast()
        end

        -- if not IsValid(ply) then return end
        -- ply.SupremeChatCooldown = ply.SupremeChatCooldown or 0
        -- if ply.SupremeChatCooldown > CurTime() then return end
        -- local str = net.ReadString()
        -- local teamc = net.ReadBool()
        -- if not str or teamc == nil then return end
        -- local len = string.len(str)
        -- if len > 320 then str = string.sub(str, 0, 320) end
        -- str = str:gsub('[\n\r]', ' ')
        -- if teamc then
        --     ply:TeamChat(str)
        -- else
        --     ply:Say(str)
        -- end
        -- ply.SupremeChatCooldown = CurTime() + .5
    end)

    net_Receive('SupremeChat.ChatState', function(_, ply)
        if not IsValid(ply) then return end
        local chatOpen = net.ReadBool()
        ply:SetNWBool('ChatOpen', chatOpen)
    end)

    local PLAYER = FindMetaTable('Player')

    local PLAYER = FindMetaTable('Player')

    local oldChatPrint = PLAYER.ChatPrint
    function PLAYER:ChatPrint( ... )
        if not self or not IsValid( self ) then return end
    
        local args = {...}
    
        local id = #args
        net.Start('SupremeChat.ChatPrintFix')
            net.WriteUInt(id, 8)
            for i = 1, id do
                local v = args[i]
                net.WriteString(v)
            end
        net.Send(self)
    
        oldChatPrint(self, ...)
    end
end

if CLIENT then
    net.Receive('SupremeChat.ChatPrintFix', function()
        local count = net.ReadUInt(8)

        local args = {}
        for i = 1, count do
            args[i] = net.ReadString()
        end
        SupremeChat.ChatBox.Scroll:AddMCText( args )
    end)

    net.Receive( 'SupremeChat.Send2', function()
        local plyid = net.ReadInt(32)
        local str = net.ReadString()
        local teamChat = net.ReadBool()
        local dead = net.ReadBool()
        
        local ply = ents.GetByIndex(plyid)
        if IsValid(ply) then
            hook.Call('OnPlayerChat', GAMEMODE, ply, str, teamChat, dead)
        end
    end	)

    ChatColors = ChatColors or {
        top = Color(144, 120, 250),
        top_grad = Color(25, 25, 25, 215)
    }

    function ScaleW(x) return math.Round(ScrW() / 1920 * x) end
    function ScaleH(y) return math.Round(ScrH() / 1080 * y) end

    local PANEL = {}
    function PANEL:Init()
        local hover = 0
        self.VBar:SetHideButtons(true)
        self.VBar:SetWide(ScaleW(8))
        self.VBar.btnGrip.Paint = function(self, w, h) draw.RoundedBox(ScaleW(8), 0, 0, w, h, ChatColors.top_grad) end
        self.VBar.Paint = function(self, w, h) end
    end

    derma.DefineControl("scrollpanel", "", PANEL, "DScrollPanel")

    SupremeChat = SupremeChat or {}
    
    local color_shadow, color_w = Color(0, 0, 0, 200), Color(255, 255, 255)
    function SupremeChat.ShadowText(t, f, x, y, col, ax, ay)
        draw.SimpleText(t, f, x + 1, y + 1, color_shadow, ax or 0, ay or 0)
        draw.SimpleText(t, f, x, y, col or color_w, ax or 0, ay or 0)
    end

    surface.CreateFont('SupremeChat.Label', {
        font = 'Mont Bold',
        size = ScaleW(19), -- 19
        weight = 0,
        antialias = true,
        extended = true
    })

    surface.CreateFont('SupremeChat.Prefix', {
        font = 'Mont Bold',
        size = ScaleW(17), -- 17
        weight = 0,
        antialias = true,
        extended = true
    })

    surface.CreateFont('SupremeChat.TextEnter', {
        font = 'Mont Bold',
        size = ScaleW(20),
        weight = 0,
        antialias = true,
        extended = true
    })

    local PANEL = {}
    function PANEL:Init()
        self:SetText('')
    end

    function PANEL:SetPrefix(text)
        self._Text = text
    end

    function PANEL:SetColor(col, col2)
        self._Color = col
        self._Color2 = col2
    end

    function PANEL:Paint(w, h)
        local colors = self._Color
        colors.a = 200
        draw.RoundedBox(8, 0, 0, w - ScaleH(2), h - ScaleW(2), colors or Color(255, 255, 255, 100))
        draw.SimpleText(self._Text, 'SupremeChat.Prefix', ScaleH(7), ScaleW(2), color_white or Color(255, 255, 255), 0, 0)
    end

    derma.DefineControl('SupremeChat.ChatPrefix', 'Chat Prefix', PANEL, 'DButton')

    PANEL = {}
    function PANEL:Init()
        self:SetText('')
    end

    function PANEL:SetMCText(text)
        self._Text = text
    end

    function PANEL:SetColor(col)
        self._Color = col
    end

    function PANEL:SetUnderline(b)
        self._Underline = b
    end

    function PANEL:Paint(w, h)
        SupremeChat.ShadowText(self._Text, 'SupremeChat.Label', w / 2, ScaleW(2), self._Color or Color(255, 255, 255), 1, 0)
        if self._Underline then draw.RoundedBox(0, 0, h - 4, w, 1, self._Color or Color(255, 255, 255)) end
    end

    derma.DefineControl('SupremeChat.ChatLabel', 'Chat Label (Button)', PANEL, 'DButton')

    PANEL = {}
    function PANEL:Init()
        self.Expire = SysTime() + 15
        self.Created = SysTime()
        self._Table = {}
        self._Msg = ''
    end

    local patterns = {
        {
            pattern = '^(STEAM_[0-3]:[01]:%d+)',
            function(str)
                return {
                    data = str,
                    type = 'steamid',
                    color = Color(231, 121, 18),
                    copy = true
                }
            end
        },
        {
            pattern = '^(https?://(([%w_.~!*:@&+$/?%%#-]-)(%w[-.%w]*%.)(%w+)(:?)(%d*)(/?)([%w_.~!*:@&+$/?%%#=-]*)))',
            function(str)
                return {
                    data = str,
                    type = 'link',
                    color = Color(62, 103, 165),
                    underline = true
                }
            end
        }
    }

    local function parse(str)
        if #str == 1 then return {str} end
        local entities = {}
        local i = 1
        local lastMatchEnd = 0
        while i < #str do
            local finish
            local found = nil
            for k, v in pairs(patterns) do
                local _, e, r = str:find(v.pattern, i)
                if r then
                    finish = e
                    found = v[1](r)
                    break
                end
            end

            if found then
                if lastMatchEnd ~= i - 1 then table.insert(entities, str:sub(lastMatchEnd + 1, i - 1)) end
                table.insert(entities, found)
                lastMatchEnd = finish
                i = finish + 1
            else
                i = i + 1
            end
        end

        if lastMatchEnd < #str then table.insert(entities, str:sub(lastMatchEnd + 1, #str)) end
        return entities
    end

    SupremeChat.prefixes = SupremeChat.prefixes or {}
    local function addprefix(str, fancy, col, col2, adjust)
        SupremeChat.prefixes[str] = {
            name = fancy,
            color = col,
            color2 = col2,
            adjust = adjust or nil
        }
    end

    local pink = Color(193, 154, 255)
    local red = Color(255, 135, 135)
    local green = Color(116, 255, 202)
    addprefix('OOC', 'OOC', Color(78, 148, 59), Color(184, 255, 141))
    addprefix('Sieć chroniona', 'Sieć chroniona', Color(179, 62, 62), red, 8)
    addprefix('Sieć niezabezpieczona', 'Sieć niezabezpieczona', Color(0, 126, 50), Color(185, 255, 213))
    addprefix('[Akcja]', 'Akcja', Color(107, 27, 128), Color(241, 185, 255))
    addprefix('[Szansa]', 'Szansa', Color(74, 27, 112), Color(255, 255, 255))
    addprefix('CIS', 'Armia Droidów', Color(44, 72, 122), Color(255, 255, 255))
    addprefix('RP', 'Akcja', Color(69, 136, 237), Color(255, 255, 255))
    addprefix('WHO', 'Nieznana Częstotliwość', Color(90, 96, 124), Color(255, 255, 255))
    addprefix('WHISPER', 'Szept', Color(46, 46, 46), Color(216, 216, 216))
    addprefix('YELL', 'Krzyk', Color(141, 41, 18), Color(255, 200, 187))
    addprefix('LOOC', 'LOOC', Color(107, 107, 107), Color(214, 214, 214))
    addprefix('|', 'Supreme', Color(254, 24, 125), pink)
    addprefix('[Czat administracyjny]', 'Czat administracyjny', Color(28, 32, 124), Color(205, 198, 255))
    addprefix('[TEST]', 'TEST TIPO', Color(28, 33, 119), Color(201, 194, 255))
    addprefix('Sieć lokalna', 'Sieć lokalna', Color(255, 153, 0), Color(140, 198, 202))
    addprefix('Holonet', 'Holonet', Color(48, 92, 201), Color(48, 92, 201))
    addprefix('[LS-OT]', 'LS-OT', Color(143, 139, 86), Color(201, 202, 140))
    addprefix('COMM1', 'Częstotliwość bazy', Color(0, 126, 50), Color(255, 255, 255))
    addprefix('COMM2', 'Częstotliwość chroniona', Color(37, 123, 180), Color(255, 255, 255))
    addprefix('COMM3', 'Częstotliwość niezabezpieczona', Color(175, 62, 62), Color(255, 255, 255))

    local function isprefix(str)
        str = string.Trim(str)
        return SupremeChat.prefixes[str] or false
    end

    function PANEL:AddMCText(args)
        surface.SetFont('SupremeChat.Label')
        for k, v in ipairs(args) do
            if istable(v) then
                table.insert(self._Table, v)
                continue
            end
    
            -- Sometimes for some reason v not a Player, idk why
            local text
            if type(v) == "string" or type(v) == "number" then
                text = tostring(v)
            elseif type(v) == "Player" then
                text = v:Nick()
            else
                text = tostring(v)
            end
    
            local expl = string.Explode(' ', text)
            if #expl > 1 then
                for i, t in ipairs(expl) do
                    local ins = t
                    table.insert(self._Table, string.Trim(ins))
                    self._Msg = self._Msg .. string.Trim(ins)
                    if i ~= #expl then
                        table.insert(self._Table, ' ')
                        self._Msg = self._Msg .. ' '
                    end
                end
            else
                table.insert(self._Table, text)
                self._Msg = self._Msg .. text
            end
        end

        local x, y = 0, 0
        local col = Color(255, 255, 255)
        local w
        local prefixed = false
        for k, v in ipairs(self._Table) do
            if istable(v) then
                col = v
                continue
            end

            local preftbl = isprefix(v)
            local message = self._Msg
            local prefix = string.match(message, "%[(.-)%]") or string.match(message, "([^:]+):")
            if preftbl and not prefixed then
                local prefixname = preftbl.name
                local prefix = vgui.Create('SupremeChat.ChatPrefix', self)
                prefix:SetPrefix(prefixname)
                prefix:SetColor(preftbl.color, preftbl.color2)
                w = select(1, surface.GetTextSize(prefixname)) + ScaleH(12)
                if preftbl.adjust then w = select(1, surface.GetTextSize(prefixname)) + preftbl.adjust end
                prefix:SetSize(w, ScaleW(24))
                prefix:SetPos(x, -ScaleW(24))
                prefix:MoveTo(x, y, 0.4, 0, 0.2)
                prefix:SetAlpha(0)
                prefix:AlphaTo(255, 0.2, 0)
                prefixed = true
                x = x + w
                local prefixStar = vgui.Create('SupremeChat.ChatLabel', self)
                prefixStar:SetMCText("• ")
                local prefixStarW = surface.GetTextSize("• ")
                prefixStar:SetSize(prefixStarW, ScaleW(24))
                prefixStar:SetColor(color_white)
                prefixStar:SetPos(x, -ScaleW(24))
                prefixStar:MoveTo(x, y, 0.4, 0, 0.2)
                prefixStar:SetAlpha(0)
                prefixStar:AlphaTo(255, 0.2, 0)
                x = x + prefixStarW
                continue
            end

            local parsing = parse(v)
            for _, msg_data in ipairs(parsing) do
                lbl = vgui.Create('SupremeChat.ChatLabel', self)
                lbl:SetMCText(istable(msg_data) and msg_data.data or msg_data)
                w = surface.GetTextSize(lbl._Text)
                lbl:SetSize(w, ScaleW(24))
                lbl:SetColor(col)
                lbl.DoRightClick = function(s)
                    SetClipboardText(self._Msg)
                    notification.AddLegacy('Skopiowano: ' .. self._Msg, NOTIFY_GENERIC, 5)
                end

                lbl:SetAlpha(0)
                lbl:AlphaTo(255, .5, 0)
                if w > self:GetWide() - x then
                    x = 0
                    y = y + ScaleW(24)
                    self:SetTall(y + ScaleW(24))
                end

                if lbl then
                    lbl:SetPos(x, -ScaleW(24))
                    lbl:MoveTo(x, y, 0.4, 0, 0.2)
                end

                if istable(msg_data) then
                    if msg_data.color then lbl:SetColor(msg_data.color) end
                    if msg_data.type == 'link' then lbl.DoClick = function(s) gui.OpenURL(msg_data.data) end end
                    if msg_data.underline then lbl:SetUnderline(true) end
                    if msg_data.copy then
                        lbl.DoRightClick = function(s)
                            SetClipboardText(msg_data.data)
                            notification.AddLegacy('Skopiowano: ' .. msg_data.data, NOTIFY_GENERIC, 5)
                        end
                    end
                end

                x = x + w
            end
        end
    end

    function PANEL:Paint(w, h)
    end

    derma.DefineControl('SupremeChat.ChatLine', 'Chat Frame', PANEL, 'DPanel')

    PANEL = {}
    local chatx, chaty = ScaleH(5), ScrH() - ScaleW(480)
    local chatw, chath = ScaleH(580), ScaleW(300)
    local global_w = math.Round(chatw)
    local global_h = math.Round(chath)
    local global_x = math.Round(chatx)
    local global_y = math.Round(chaty)
    local utf8_sub = utf8.sub
    
    function PANEL:Init()
        self:SetMinWidth(ScaleH(300))
        self:SetMinHeight(ScaleW(200))
        self:SetPos(global_x, global_y)
        self:SetSize(global_w, global_h)
        self:ShowCloseButton(false)
        self:SetDraggable(true)
        self:SetTitle('')
        self:SetKeyboardInputEnabled(false)
        self:SetSizable(true)
        self:SetScreenLock(true)
        self.History = {}
        self.AutoNames = {}
        self.CurrentAutoName = 0
        self.Paint = function(s, w, h)
            if self:IsKeyboardInputEnabled() then 
                draw.RoundedBoxEx(8, 0, 35, w, h, Color(25, 25, 25, 185), true, true, true, true)
            end
            if input.IsKeyDown(KEY_ESCAPE) and self:IsKeyboardInputEnabled() then
                SupremeChat.closeChatbox()
                gui.HideGameUI()
            end
        end
    
        self.BottomPanel = vgui.Create('Panel', self)
        self.BottomPanel:Dock(BOTTOM)
        self.BottomPanel:DockMargin(0, 0, 0, 0)
        self.BottomPanel:SetTall(ScaleW(30))
    
        self.TextEntry = vgui.Create('DTextEntry', self.BottomPanel)
        self.TextEntry:Dock(FILL)
        self.TextEntry:SetDrawBorder(false)
        self.TextEntry:SetPaintBackground(false)
        self.TextEntry:SetFont('SupremeChat.TextEnter')
        self.TextEntry:SetTextColor(Color(255, 255, 255))
        self.TextEntry:SetCursorColor(Color(255, 255, 255))
        self.TextEntry:SetPlaceholderColor(Color(0, 0, 0))
        self.TextEntry:SetHighlightColor(Color(55, 55, 55, 200))
        self.TextEntry:SetDrawLanguageID(false)
        self.TextEntry.Paint = function(s, w, h)
            if self:IsKeyboardInputEnabled() then
                draw.RoundedBox(8, 0, 0, w, h, Color(16, 16, 16, 85))
                s:DrawTextEntryText(Color(255, 255, 255), Color(0, 0, 0), Color(170, 170, 170))
                if not s.AutoFillText then return end
                surface.SetFont('SupremeChat.TextEnter')
                local x = surface.GetTextSize(s:GetValue())
                local w2, h2 = surface.GetTextSize(s.AutoFillText)
                surface.SetDrawColor(Color(14, 144, 217))
                surface.DrawRect(x + ScaleW(4), ScaleH(2), w2, h - ScaleH(4))
                surface.SetTextColor(Color(255, 255, 255))
                draw.SimpleText(s.AutoFillText, 'SupremeChat.TextEnter', x + ScaleW(2), h / 2, color_white, 0, 1)
            end
        end
    
        self.TextEntry.OnEnter = function(s)
            local message = s:GetText()
            if string.Trim(message) ~= "" then
                net.Start('SupremeChat.Send')
                net.WriteString(message)
                net.WriteBool(self.Team or false)
                net.SendToServer()
                
                table.insert(self.History, 1, message)
                s.historyPos = 0
                self.Scroll.VBar:AnimateTo(self.Scroll.pnlCanvas:GetTall(), 0.5, 0, 0.5)
                s:SetText("")
            end
            SupremeChat.closeChatbox()
        end
    
        self.TextEntry.CalculateAutoFill = function(s)
            local curSel = self.AutoNames[self.CurrentAutoName]
            table.Empty(self.AutoNames)
            local words = string.Explode(' ', s:GetValue())
            match = words[#words]
            if not match or match == '' then
                self.CurrentAutoName = 0
                return
            end
    
            for k, v in ipairs(player.GetAll()) do
                if (string.find(v:Name():lower(), match:lower(), 1, true) or -1) == 1 then
                    if curSel and curSel.SteamID == v:SteamID() then 
                        self.CurrentAutoName = #self.AutoNames + 1 
                    end
                    self.AutoNames[#self.AutoNames + 1] = {
                        Name = v:Name(),
                        SteamID = v:SteamID()
                    }
                end
            end
        end
    
        self.TextEntry.GetAutoFill = function(s, step)
            step = step or 0
            local words = string.Explode(' ', s:GetValue())
            match = words[#words]
            if not match or match == '' then return end
            self.CurrentAutoName = self.CurrentAutoName + step
            if not self.AutoNames[self.CurrentAutoName] then 
                self.CurrentAutoName = self.CurrentAutoName <= 0 and #self.AutoNames or 1 
            end
            local fillData = self.AutoNames[self.CurrentAutoName]
            if fillData then 
                fillData.CompleteString = utf8_sub(fillData.Name, utf8.len(match) + 1) 
            end
            return fillData
        end
    
        self.TextEntry.DoAutoFill = function(s)
            local pl = s:GetAutoFill()
            if not pl then return end
            local words = string.Explode(' ', s:GetValue())
            match = words[#words]
            if not match or match == '' then return end
            local pref = utf8_sub(s:GetValue(), 1, 1)
            local fillVal
            local firstargs = utf8_sub(s:GetValue(), 2, (string.find(s:GetValue(), ' ') or utf8.len(s:GetValue()) + 2) - 1)
            if (pref == '/' or pref == '!') and firstargs == 'pm' then
                fillVal = pl.SteamID
            else
                fillVal = pl.Name
            end
    
            s:SetText(utf8_sub(s:GetValue(), 1, -(utf8.len(match) + 1)) .. fillVal .. ' ')
        end
    
        self.TextEntry.historyPos = 0
        self.TextEntry.OnKeyCodeTyped = function(s, code)
            if code == KEY_TAB or code == KEY_RIGHT and s:GetCaretPos() == utf8.len(s:GetValue()) then
                s:DoAutoFill()
                s:OnTextChanged()
                s:SetCaretPos(utf8.len(s:GetValue()))
            elseif code == KEY_UP then
                if #self.AutoNames > 0 and self.GetAutoFill then
                    local auto = self:GetAutoFill(1)
                    if auto then s.AutoFillText = auto and auto.CompleteString or nil end
                else
                    if self.History[s.historyPos + 1] then
                        s.historyPos = s.historyPos + 1
                        s:SetText(self.History[s.historyPos])
                        s:SetCaretPos(utf8.len(s:GetValue()))
                    end
                end
            elseif code == KEY_DOWN then
                if #self.AutoNames > 0 and self.GetAutoFill then
                    local auto = self:GetAutoFill(1)
                    if auto then s.AutoFillText = auto and auto.CompleteString or nil end
                else
                    if self.History[s.historyPos - 1] or s.historyPos - 1 == 0 then
                        s.historyPos = s.historyPos - 1
                        s:SetText(self.History[s.historyPos] or '')
                        s:SetCaretPos(utf8.len(s:GetValue()))
                    end
                end
            elseif code == KEY_BACKQUOTE then
                gui.HideGameUI()
            elseif code == KEY_ENTER then
                s:OnEnter()
            end
        end
    
        self.TextEntry.OnLoseFocus = function(s)
            if input.IsKeyDown(KEY_TAB) then
                s:RequestFocus()
                s:SetCaretPos(utf8.len(s:GetText()))
            end
        end
    
        self.TextEntry.OnTextChanged = function(s)
            s:CalculateAutoFill()
            local auto = s:GetAutoFill()
            s.AutoFillText = auto and auto.CompleteString or nil
            if s:GetValue():len() > 320 then
                s:SetValue(string.sub(s:GetValue(), 1, 320))
                s:SetCaretPos(320)
            end

            gamemode.Call('ChatTextChanged', s:GetValue())
        end

        self.TextEntry.AllowInput = function(s)
            if utf8.len(s:GetValue()) >= 320 then
                surface.PlaySound('resource/warning.wav')
                return true
            end
        end
    
        self.Send = vgui.Create('DButton', self.BottomPanel)
        self.Send:Dock(RIGHT)
        self.Send:DockMargin(5, 0, 0, 0)
        self.Send:SetWide(ScaleW(50))
        self.Send:SetText('')
        local send = Material('luna_ui_base/etc/play-button.png', 'smooth')
        self.Send.Paint = function(s, w, h)
            local col = s.Hovered and ChatColors.top_grad or color_white
            draw.RoundedBox(4, 0, 0, w, h, Color(16, 16, 16, 85))
            surface.SetMaterial(send)
            surface.SetDrawColor(col)
            surface.DrawTexturedRect(w / 2 - ScaleW(10), h / 2 - ScaleW(10), ScaleW(20), ScaleW(20))
        end
    
        self.Send.DoClick = function(s)
            self.TextEntry:OnEnter()
        end
    
        self.Send:Hide()
    
        self.Scroll = vgui.Create('scrollpanel', self)
        self.Scroll:Dock(FILL)
        self.Scroll:DockMargin(0, ScaleH(15), 0, ScaleH(10))
        self.Scroll.VBar:SetHideButtons(true)
        self.Scroll.VBar.Paint = function() end
        self.Scroll.VBar.btnGrip.Paint = function(s, w, h) 
            if self:IsKeyboardInputEnabled() then 
                draw.RoundedBox(ScaleW(8), 0, 0, w, h, ChatColors.top_grad) 
            end 
        end
        self.Scroll.AddMCText = function(s, args)
            local lbls = s.pnlCanvas:GetChildren()
            local l = lbls[#lbls]
            local h, y
            if l then
                _, h = l:GetSize()
                _, y = l:GetPos()
            else
                h = 0
                y = 0
            end
    
            local lbl = self.Scroll:Add('SupremeChat.ChatLine')
            lbl:SetSize(s:GetWide(), ScaleW(24))
            lbl:AddMCText(args)
            lbl:SetPos(0, y + h)
            if not self:IsKeyboardInputEnabled() or (s.pnlCanvas:GetTall() - ScaleW(250)) - s.VBar:GetScroll() < ScaleW(30) then 
                s.VBar:AnimateTo(s.pnlCanvas:GetTall(), 0.5, 0, 0.5) 
            end
        end
    
        self.Scroll.Paint = function(s, w, h) end
        self.Scroll.Think = function(s)
            local lbls = s.pnlCanvas:GetChildren()
            local count = #lbls
            for k, v in pairs(lbls) do
                if k < count - 200 then
                    local _, h = v:GetSize()
                    for nk, nv in pairs(lbls) do
                        if k ~= nk then
                            local _, y = nv:GetPos()
                            nv:SetPos(0, y - h)
                        end
                    end
    
                    v:Remove()
                    continue
                end
    
                if not v.Expire then continue end
                local _, y = v:GetPos()
                if s.VBar:GetScroll() - 30 > y then
                    v:Hide()
                    continue
                end
    
                if SupremeChat.ChatBox:IsKeyboardInputEnabled() then
                    v:Show()
                    continue
                end
    
                if v.Expire > SysTime() then
                    v:Show()
                else
                    v:Hide()
                end
            end
        end
    end
    
    function PANEL:OnRemove()
    end
    
    derma.DefineControl('SupremeChat.Chatbox', 'Chatbox', PANEL, 'DFrame')
    
    function SupremeChat.Create()
        if SupremeChat.ChatBox then SupremeChat.ChatBox:Remove() end
        SupremeChat.ChatBox = vgui.Create('SupremeChat.Chatbox')
    end
    
    hook.Add('PlayerBindPress', 'SupremeChat.PlayerBindPress', function(ply, bind, pressed)
        local bTeam
        if bind == 'messagemode' then
            bTeam = false
        elseif bind == 'messagemode2' then
            bTeam = true
        else
            return
        end
    
        SupremeChat.openChatbox(bTeam)
        return true
    end)
    
    function SupremeChat.openChatbox(bTeam)
        SupremeChat.ChatBox.Team = bTeam
        SupremeChat.ChatBox:MakePopup()
        SupremeChat.ChatBox.TextEntry:RequestFocus()
        SupremeChat.ChatBox.Scroll.VBar:SetScroll(SupremeChat.ChatBox.Scroll.pnlCanvas:GetTall())
        SupremeChat.ChatBox.Send:Show()
        hook.Run('StartChat')
        
        net.Start('SupremeChat.ChatState')
        net.WriteBool(true)
        net.SendToServer()
    end
    
    function SupremeChat.closeChatbox()
        SupremeChat.ChatBox:SetMouseInputEnabled(false)
        SupremeChat.ChatBox:SetKeyboardInputEnabled(false)
        SupremeChat.ChatBox.Scroll.VBar:SetScroll(SupremeChat.ChatBox.Scroll.pnlCanvas:GetTall())
        SupremeChat.ChatBox.Send:Hide()
        gui.EnableScreenClicker(false)
        hook.Run('FinishChat')
        SupremeChat.ChatBox.TextEntry:SetText('')
        SupremeChat.ChatBox.TextEntry.AutoFillText = nil
        hook.Run('ChatTextChanged', '')
        local x, y = SupremeChat.ChatBox:GetPos()
        local w, h = SupremeChat.ChatBox:GetWide(), SupremeChat.ChatBox:GetTall()
        global_x = math.Round(x)
        global_y = math.Round(y)
        global_w = math.Round(w)
        global_h = math.Round(h)
        
        net.Start('SupremeChat.ChatState')
        net.WriteBool(false)
        net.SendToServer()
    end
    
    hook.Add('OnPlayerChat', 'SupremeChat.HandlePlayerChat', function(ply, text, teamChat, isDead)
        if not IsValid(ply) then return end

        local color = team.GetColor(ply:Team()) or Color(255, 255, 255)
        local prefix = isDead and "[DEAD] " or (teamChat and "(TEAM) " or "")
        local playerName = ply:Nick()
        
        if not teamChat and not isDead then
            local localPlayer = LocalPlayer()
            if localPlayer:GetPos():Distance(ply:GetPos()) > CHAT_DISTANCE then
                return true
            end
        end
        
        chat.AddText(Color(200, 200, 200), prefix, color, playerName, Color(255, 255, 255), ": " .. text)
        
        return true
    end)
    
    hook.Add('ChatText', 'SupremeChat.ChatText', function(index, name, text, type)
        -- if type == 'joinleave' or type == 'none' then return end
    end)
    
    hook.Add('HUDShouldDraw', 'SupremeChat.HUDShouldDraw', function(name)
        if name == 'CHudChat' then return false end
    end)
    
    if not SupremeChat.Replaced then
        local oldAddText = chat.AddText
        function chat.AddText(...)
            if not SupremeChat.ChatBox then
                SupremeChat.Create()
            end
            local args = {...}
            SupremeChat.ChatBox.Scroll:AddMCText(args)
            oldAddText(...)
        end
    
        SupremeChat.Replaced = true
    end

    local PLAYER = FindMetaTable('Player')

    local oldChatPrint = PLAYER.ChatPrint
    function PLAYER:ChatPrint(...)
        local args = {...}
        SupremeChat.ChatBox.Scroll:AddMCText(args)
        oldChatPrint(self, ...)
    end
    
    timer.Simple(.1, function()
        SupremeChat.Create()
    end)
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
