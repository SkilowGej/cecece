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

util.AddNetworkString("SquadSystem.SquadCreated")
util.AddNetworkString("SquadSystem.SquadRemoved")
util.AddNetworkString("SquadSystem.MembersUpdated")
util.AddNetworkString("SquadSystem.RequestSquadKick")
util.AddNetworkString("SquadSystem.RequestPositionChange")
util.AddNetworkString("SquadSystem.Broadcast")
util.AddNetworkString("SquadSystem.Communications")
util.AddNetworkString("SquadSystem.RequestCommunication")
util.AddNetworkString("SquadSystem.Communication.EnemyPinged")
util.AddNetworkString("SquadSystem.RequestSquads")
util.AddNetworkString("SquadSystem.InvitePlayer")
util.AddNetworkString("SquadSystem.InviteDecision")
util.AddNetworkString("SquadSystem.RequestCreateSquad")
util.AddNetworkString("SquadSystem.RequestLeave")
util.AddNetworkString("SquadSystem.RequestCommand")
util.AddNetworkString("SquadSystem.RequestJoinPublic")
util.AddNetworkString("SquadSystem.RequestSquadList")


net.Receive("SquadSystem.RequestSquadKick", function(len, ply)
    local squadPos = ply:GetSquadPosition()

    if not squadPos == 1 or squadPos == 2 then return end

    local target = net.ReadEntity()
    local squad = ply:GetSquad()

    if not squad then return end

    squad:RemoveMember(target)
end)

net.Receive("SquadSystem.RequestPositionChange", function(len, ply)
    local squadPos = ply:GetSquadPosition()
    if squadPos != 1 and squadPos != 2 then return end

    local target = net.ReadEntity()
    local position = net.ReadInt(8)

    if not SquadSystem.Config.Positions[position] then return end
    if ply == target then print(0) return end

    local squad = ply:GetSquad()
    if not squad then return end

    squad:ChangePosition(target, position)
end)

net.Receive("SquadSystem.RequestCommunication", function(len, ply)
    local index = net.ReadString()
    local data = SquadSystem.Config.Communications[index]
    if not data then return end

    -- TODO Network cooldown

    ply:SquadCommunications(index)
end)

net.Receive("SquadSystem.RequestSquads", function(len, ply)
    net.Start("SquadSystem.RequestSquads")
    net.WriteTable(SquadSystem.Cache)
    net.Send(ply)
end)

net.Receive("SquadSystem.InviteDecision", function(len, ply)
    local accepted = net.ReadBool()

    if accepted then
        local id = ply:GetNWInt("SquadSystem.InvitedTo", -1)
        if Squad(id) then
            Squad(id):AddMember(ply)
        end
    end

    ply:SetNWInt("SquadSystem.InvitedTo", -1)
end)

net.Receive("SquadSystem.InvitePlayer", function(len, ply)
    local target = net.ReadEntity()

    if target:IsBot() then
        ply:GetSquad():AddMember(target)
        return
    end

    target:InviteToSquad(ply)
end)

net.Receive("SquadSystem.RequestCreateSquad", function(len, ply)
    if ply:GetSquad() then return end

    local title = net.ReadString()
    local isPublic = net.ReadBool()

    if #title <= 3 then
        return
    end

    if #title >= 20 then
        return
    end

    SquadSystem:Create(title, ply, isPublic)
end)

net.Receive("SquadSystem.RequestLeave", function(len, ply)
    local squad = ply:GetSquad()
    if not squad then print(0) return end

    squad:RemoveMember(ply)
end)

net.Receive("SquadSystem.RequestCommand", function(len, ply)
    ply:SquadCommand(net.ReadString())
end)

net.Receive("SquadSystem.RequestJoinPublic", function(len, ply)
    local id = net.ReadUInt(6)
    local squad = SquadSystem.Cache[id]

    if not squad then return end
    if not squad:IsPublic() then return end
    if ply:GetSquad() then return end

    squad:AddMember(ply)
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
