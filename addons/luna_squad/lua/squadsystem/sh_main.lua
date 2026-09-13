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

SquadSystem.Cache = SquadSystem.Cache or {}
SquadSystem.SquadObj = SquadSystem.SquadObj or {}
SquadSystem.SquadObj.__index = SquadSystem.SquadObj or {}

/* -------------------------------------------------------------------------- */
/*                     Squad object: SquadSystem.SquadObj                     */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                              Returns the title                             */
/* -------------------------------------------------------------------------- */

function SquadSystem.SquadObj:GetTitle()
    return self.name or "NOT FOUND"
end

/* -------------------------------------------------------------------------- */
/*                               Returns the id                               */
/* -------------------------------------------------------------------------- */

function SquadSystem.SquadObj:GetID()
    return self.id or -1
end

/* -------------------------------------------------------------------------- */
/*                             Returns all members                            */
/* -------------------------------------------------------------------------- */

function SquadSystem.SquadObj:GetMembers()
    --if self.members == nil then return {} end
    --return self.members
    
    local id = self:GetID()
    local ents = player.GetAll()
    local matches = {}

    for key, ply in SortedPairs(ents) do
        if id == ply:GetSquadID() then
            table.insert(matches, ply)
        end
    end

    return matches
end

/* -------------------------------------------------------------------------- */
/*                       Returns one of the squadleaders                      */
/* -------------------------------------------------------------------------- */

function SquadSystem.SquadObj:GetOwner()
    local members = self:GetMembers()

    for k, ply in pairs(members) do
        if ply:GetSquadPosition() == 1 then
            return ply
        end
    end

    for k, ply in pairs(members) do -- if we fail search for another squadlead member (including deputy)
        if ply:IsSquadLeader() then
            return ply
        end
    end

    return false
end

/* -------------------------------------------------------------------------- */
/*                  Returns whether a squad is set to public                  */
/* -------------------------------------------------------------------------- */

function SquadSystem.SquadObj:IsPublic()
    return self.public
end

local PLAYER = FindMetaTable("Player")

/* -------------------------------------------------------------------------- */
/*                        Returns the squad of a player                       */
/* -------------------------------------------------------------------------- */

function PLAYER:GetSquad()
    local squadID = self:GetNWInt("SquadSystem.SquadID", -1)
    if squadID == -1 then return false end

    local squad = SquadSystem.Cache[squadID]
    if not squad then return false end

    return squad
end

/* -------------------------------------------------------------------------- */
/*                      Returns the squad id of a player                      */
/* -------------------------------------------------------------------------- */

function PLAYER:GetSquadID()
    return self:GetNWInt("SquadSystem.SquadID", -1)
end

/* -------------------------------------------------------------------------- */
/*                 Returns whether a player is part of a squad                */
/* -------------------------------------------------------------------------- */

function PLAYER:IsMemberOfSquad(squadIDToCheck)
    local squadID = self:GetNWInt("SquadSystem.SquadID", -1)
    if squadID == -1 then return false end

    return squadID == squadIDToCheck
end

/* -------------------------------------------------------------------------- */
/*                      Returns the players squad positon                     */
/* -------------------------------------------------------------------------- */

function PLAYER:GetSquadPosition()
    local pos = self:GetNWInt("SquadSystem.SquadPosition", #SquadSystem.Config.Positions)

    if pos == -1 then return #SquadSystem.Config.Positions end

    return pos
end

/* -------------------------------------------------------------------------- */
/*        Returns whether the player is a squadleader (position 1 or 2)       */
/* -------------------------------------------------------------------------- */

function PLAYER:IsSquadLeader()
    local pos = self:GetNWInt("SquadSystem.SquadPosition", #SquadSystem.Config.Positions)

    if pos == 1 or pos == 2 then
        return true
    end
    return false
end

/* -------------------------------------------------------------------------- */
/*           For easier indexing, returns the squad via the given id          */
/* -------------------------------------------------------------------------- */

function Squad(index)
    return SquadSystem.Cache[index]
end

/* -------------------------------------------------------------------------- */
/*                          Returns the primary color                         */
/* -------------------------------------------------------------------------- */

function SquadSystem:GetPrimaryColor()
    return SquadSystem.Config.Theme.primary or color_white
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
