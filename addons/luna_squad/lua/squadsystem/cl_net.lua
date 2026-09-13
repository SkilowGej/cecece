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
]]--

net.Receive("SquadSystem.RequestSquads", function(len)
    SquadSystem.Cache = net.ReadTable()

    for key, v in pairs(SquadSystem.Cache) do
        setmetatable(SquadSystem.Cache[key], SquadSystem.SquadObj)
    end
end)

local blurMat = Material("pp/blurscreen")

net.Receive("SquadSystem.InvitePlayer", function(len)
    local inviter = net.ReadEntity()
    SquadSystem:InviteFrame(inviter)
end)

local pingTypes = {
    ["normal"] = {
        imgur = "A2zzbvB",
        txt = "- "..SquadSystem:L("PING_Normal").." -",
        col = Color(255,217,45),
        normalCol = Color(214,214,214,157),
    },
    ["enemy"] = {
        imgur = "nWeRozA",
        txt = "- "..SquadSystem:L("PING_Enemy").." -",
        col = Color(255,45,45),
        normalCol = Color(214,214,214,157),
    },
}

net.Receive("SquadSystem.Communication.EnemyPinged", function()
    local vector = net.ReadVector()
    local ply = net.ReadEntity()
    local type = net.ReadString()

    local typeData = pingTypes[type]

    if not typeData then return end

    local hookName = "SquadSystem.Communication.Ping.".. tostring(ply:SteamID64())
    local removeTime = CurTime() + 10
    local plyName = ply:Name()

    surface.PlaySound("summe/squadsystem/ping.mp3")

    SummeLibrary:GetImgurMaterial(typeData.imgur, function(material)
        hook.Add("HUDPaint", hookName, function()
            local pos = vector:ToScreen()
            local dist = math.Round(LocalPlayer():GetPos():DistToSqr(vector) / 40000)
            local removeTimeConv = math.Round(removeTime - CurTime())
    
            --draw.RoundedBox(5, pos.x - 5, pos.y, 10, 10, color_white)

            draw.DrawText(typeData.txt, "SquadSystem.Ping", pos.x, pos.y - 40, typeData.normalCol, TEXT_ALIGN_CENTER)
            draw.DrawText(plyName, "SquadSystem.PingSmall", pos.x, pos.y - 25, typeData.normalCol, TEXT_ALIGN_CENTER)
    
            draw.DrawText(tostring(dist).. "m", "SquadSystem.Ping", pos.x, pos.y + 25, typeData.normalCol, TEXT_ALIGN_CENTER)
    
            --draw.DrawText(removeTimeConv, "SquadSystem.OverHead", pos.x, pos.y - 40, color_white, TEXT_ALIGN_CENTER)

            surface.SetDrawColor(typeData.col)
            surface.SetMaterial(material)
            surface.DrawTexturedRect(pos.x - 15, pos.y - 8, 32, 32)
    
            if removeTime <= CurTime() then
                hook.Remove("HUDPaint", hookName)
            end
        end)
    end)
end)

net.Receive("SquadSystem.SquadCreated", function()
    local squadData = net.ReadTable()

    SquadSystem.Cache[squadData.id] = squadData
    setmetatable(SquadSystem.Cache[squadData.id], SquadSystem.SquadObj)

    hook.Call("SquadSystem.Client.SquadCreated", SquadSystem.Cache[squadData.id])
end)

net.Receive("SquadSystem.SquadRemoved", function()
    local squadID = net.ReadInt(8)

    if LocalPlayer():IsMemberOfSquad(squadID) then
        SquadSystem.Sideboard:Remove()
    end

    SquadSystem.Cache[squadID] = nil
end)

net.Receive("SquadSystem.MembersUpdated", function()
    local squadID = net.ReadInt(8)

    if not SquadSystem.Cache[squadID] then
        ErrorNoHaltWithStack("Cant get obj from cache!")
        return
    end

    timer.Simple(1, function()
        SquadSystem:CreateSideboard()
    end)
end)

net.Receive("SquadSystem.Broadcast", function(len)
    local squad = LocalPlayer():GetSquad()
    if not squad then return end

    local args = net.ReadTable()

    chat.AddText(Color(7, 110, 203), squad:GetTitle(), Color(90,90,90)," • ", Color(255,255,255), unpack(args))
end)

net.Receive("SquadSystem.RequestCreateSquad", function()
    SquadSystem.Creator:Open()
end)

net.Receive("SquadSystem.RequestCommand", function(len)
    if IsValid(SquadSystem.CommandNotify) then SquadSystem.CommandNotify:Remove() end

    local index = net.ReadString()
    local ply = net.ReadEntity()

    local typeData = SquadSystem.Config.Commands[index]
    if not typeData then return end

    local width, height = ScrW() * .5, ScrH() * .12

    SquadSystem.CommandNotify = vgui.Create("DPanel")
    SquadSystem.CommandNotify:SetSize(width, height)
    SquadSystem.CommandNotify:SetPos(ScrW() / 2 - width/2, ScrH() * .2)
    SquadSystem.CommandNotify:SetAlpha(0)
    SquadSystem.CommandNotify:AlphaTo(255, 1)
    SquadSystem.CommandNotify:AlphaTo(0, 1, 5, function()
        SquadSystem.CommandNotify:Remove()
    end)
    SquadSystem.CommandNotify.PolationStatus1 = 0
    SquadSystem.CommandNotify.PolationStatus2 = 1
    function SquadSystem.CommandNotify:Paint(w, h)
        self.PolationStatus1 = math.Clamp(self.PolationStatus1 + .5 * FrameTime(), 0, 1)
        self.PolationStatus2 = math.Clamp(self.PolationStatus2 - .5 * FrameTime(), 0, 1)
        draw.RoundedBox(8, 0, 0, w * self.PolationStatus1, h * .95, Color(0, 0, 0, 50))
        draw.DrawText("- • ROZKAZ DLA ODDZIAŁU • -", "SquadSystem.Commands.SubTitle", w * .5, h * .15, Color(216,216,216), TEXT_ALIGN_CENTER)
        draw.DrawText(index, "SquadSystem.Commands.Title", w * .5, h * .38, typeData.color, TEXT_ALIGN_CENTER)
        draw.RoundedBox(8, 0, 0, w * self.PolationStatus1, h * .02, color_white)
        draw.RoundedBox(8, width * self.PolationStatus2, h * .95, w, h * .02, color_white)
    end

    surface.PlaySound("summe/squadsystem/command.mp3")

    hook.Run("SquadSystem.PostCommand", index, typeData, ply)
end)

net.Receive("SquadSystem.Communications", function(len)
    local index = net.ReadString()
    local ply = net.ReadEntity()
    SquadSystem:DoComms(index, ply)
end)

net.Receive("SquadSystem.RequestSquadList", function(len)
    SquadSystem:OpenList()
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
