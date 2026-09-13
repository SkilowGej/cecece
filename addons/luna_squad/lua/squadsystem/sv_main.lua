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

/* -------------------------------------------------------------------------- */
/*                   Creates a squad, for internal use only                   */
/* -------------------------------------------------------------------------- */

function SquadSystem:CreateInternal(name, isPublic)
	local squadron = {
		name = name,
		members = {},
		public = isPublic,
	}

	local id = table.insert(SquadSystem.Cache, squadron)

	setmetatable(SquadSystem.Cache[id], SquadSystem.SquadObj)

	SquadSystem.Cache[id].id = id

	net.Start("SquadSystem.SquadCreated")
	net.WriteTable(SquadSystem.Cache[id])
	net.Broadcast()

	return SquadSystem.Cache[id]
end

/* -------------------------------------------------------------------------- */
/*                 Creates a squad with given name and leader                 */
/* -------------------------------------------------------------------------- */

function SquadSystem:Create(name, leader, isPublic)
	local squad = SquadSystem:CreateInternal(name, isPublic or false)
	squad:AddMember(leader)
	squad:ChangePosition(leader, 1)

	SummeLibrary:Notify(leader, "success", "Squads", SquadSystem:L("CREATOR_Success"))
end

/* -------------------------------------------------------------------------- */
/*                       Adds a member to a squad object                      */
/* -------------------------------------------------------------------------- */

function SquadSystem.SquadObj:AddMember(ply)
	if ply:GetSquad() then
		return
	end

    --table.insert(self.members, ply)

	ply:SetNWInt("SquadSystem.SquadID", self:GetID())
	ply:SetNWInt("SquadSystem.SquadPosition", #SquadSystem.Config.Positions)

	timer.Simple(1, function()
		net.Start("SquadSystem.MembersUpdated")
		net.WriteInt(self:GetID(), 8)
		--net.WriteTable(self.members)
		net.Send(self:GetMembers())
	end)

	self:Broadcast(ply:Name().. SquadSystem:L("BROADCASTS_PlayerJoined"))

	SummeLibrary:Notify(ply, "success", "Squads", SquadSystem:L("INVITE_SuccessfullyJoined").. self:GetTitle())

	return self
end

/* -------------------------------------------------------------------------- */
/*                    Removes a member from a squad object                    */
/* -------------------------------------------------------------------------- */

function SquadSystem.SquadObj:RemoveMember(ply)
	if ply:GetSquad() != self then return end

	if (#self:GetMembers() - 1) < 1 then -- Remove the squad when the last member leaves
		self:Remove()
		return
	end

	local squadPos = ply:GetSquadPosition()

	self:Broadcast(ply:Name().. SquadSystem:L("BROADCASTS_PlayerLeft"))

	net.Start("SquadSystem.MembersUpdated")
	net.WriteInt(self:GetID(), 8)
	--net.WriteTable(self.members)
	net.Send(self:GetMembers())

	ply:SetNWInt("SquadSystem.SquadID", -1)
	ply:SetNWInt("SquadSystem.SquadPosition", #SquadSystem.Config.Positions)

	if squadPos == 1 then
		local switchedOwner = false
		for k, v in pairs(self:GetMembers()) do
			if v:GetSquadPosition() == 2 then
				self:ChangePosition(v, 1)
				switchedOwner = true
				break
			end
		end

		if not switchedOwner then
			local target = table.Random(self:GetMembers())
			self:ChangePosition(target, 1)
		end
	end

	return self
end

/* -------------------------------------------------------------------------- */
/*              Changes the position of a player within the squad             */
/* -------------------------------------------------------------------------- */

function SquadSystem.SquadObj:ChangePosition(ply, position)
	ply:SetNWInt("SquadSystem.SquadPosition", position)

	self:Broadcast(ply:Name().. SquadSystem:L("BROADCASTS_PositionChange").. SquadSystem.Config.Positions[position].name)

	return self
end

/* -------------------------------------------------------------------------- */
/*                           Removes a squad obejct                           */
/* -------------------------------------------------------------------------- */

function SquadSystem.SquadObj:Remove()
	for key, tbl in pairs(SquadSystem.Cache) do
		if tbl == self then
			for _, ply in pairs(self:GetMembers()) do
				ply:SetNWInt("SquadSystem.SquadID", -1)
				ply:SetNWInt("SquadSystem.SquadPosition", #SquadSystem.Config.Positions)
			end
			
			self:Broadcast(SquadSystem:L("BROADCASTS_SquadRemoved"))
			net.Start("SquadSystem.SquadRemoved")
			net.WriteInt(self:GetID(), 8)
			net.Broadcast()
			SquadSystem.Cache[key] = nil
			return
		end
	end
end

/* -------------------------------------------------------------------------- */
/*                  Sends a chat message to all squad members                 */
/* -------------------------------------------------------------------------- */

function SquadSystem.SquadObj:Broadcast(...)
	net.Start("SquadSystem.Broadcast")
	net.WriteTable({...})
	net.Send(self:GetMembers())
end

/* -------------------------------------------------------------------------- */
/*                 Helper function to display the players name                */
/* -------------------------------------------------------------------------- */

local function FormatText(txt, ply)
	return string.Replace(txt, "%PLAYER%", ply:Name())
end

local PLAYER = FindMetaTable("Player")

/* -------------------------------------------------------------------------- */
/*               Invites a player to a squad by a given inviter               */
/* -------------------------------------------------------------------------- */

function PLAYER:InviteToSquad(inviter)
	local squad = inviter:GetSquad()
	if not squad then return end

	if not inviter:IsSquadLeader() then return end

	if self:GetNWInt("SquadSystem.InvitedTo", -1) != -1 then
		SummeLibrary:Notify(inviter, "warning", "Squads", self:Name()..SquadSystem:L("INVITE_Err_AlreadyOpenInvitation"))
		return
	end

	net.Start("SquadSystem.InvitePlayer")
	net.WriteEntity(inviter)
	net.Send(self)

	self:SetNWInt("SquadSystem.InvitedTo", squad:GetID())
end

/* -------------------------------------------------------------------------- */
/*           Does a communication executed by a squad member player           */
/* -------------------------------------------------------------------------- */

function PLAYER:SquadCommunications(index)
    local squad = self:GetSquad()
	if not squad then return end

	local data = SquadSystem.Config.Communications[index]
    if not data then return end

	squad:Broadcast(FormatText(data.chatMsg, self))

	if data.callbackSv then
		data.callbackSv(self)
	end

	net.Start("SquadSystem.Communications")
	net.WriteString(index)
	net.WriteEntity(self)
	net.Send(squad:GetMembers())
end

/* -------------------------------------------------------------------------- */
/*           Pings a world position to all squad members by a player          */
/* -------------------------------------------------------------------------- */

function PLAYER:SquadPing(type)
	local eyetrace = self:GetEyeTrace()
	if not eyetrace or not eyetrace.HitPos then return end -- TODO Maybe we dont need to network the vector idk

	local squad = self:GetSquad()
	if not squad then return end

	net.Start("SquadSystem.Communication.EnemyPinged")
	net.WriteVector(eyetrace.HitPos)
	net.WriteEntity(self)
	net.WriteString(type)
	net.Send(squad:GetMembers())
end

/* -------------------------------------------------------------------------- */
/*             Executes a command by a player to all squad members            */
/* -------------------------------------------------------------------------- */

function PLAYER:SquadCommand(index)
	local squad = self:GetSquad()
	if not squad then return end

	local typeData = SquadSystem.Config.Commands[index]
    if not typeData then return end

	if not self:IsSquadLeader() then return end -- TODO Check this everywhere

	net.Start("SquadSystem.RequestCommand")
    net.WriteString(index)
	net.WriteEntity(self)
    net.Send(squad:GetMembers())

	squad:Broadcast(FormatText(typeData.chatMsg, self))
end

/* -------------------------------------------------------------------------- */
/*             Registers commands using SummeLibrary's command helper         */
/* -------------------------------------------------------------------------- */

SummeLibrary:RegisterCommand({
    key = "SquadSystem.Create",
    commandList = {"!createsquad"},
    allowedRanks = false,
    func = function(ply, arguments)
		local squad = ply:GetSquad()
    	if squad then return end
		net.Start("SquadSystem.RequestCreateSquad")
		net.Send(ply)
    end,
})

SummeLibrary:RegisterCommand({
    key = "SquadSystem.Invite",
    commandList = {"!invitesquad"},
    allowedRanks = false,
    func = function(ply, arguments)
		local squad = ply:GetSquad()
    	if not squad then return end
		if not ply:IsSquadLeader() then return end

		local target = SummeLibrary:GetPlayer(arguments[1])
		if not target then
			SummeLibrary:Notify(ply, "warning", "Squads", SquadSystem:L("ERROR_PlayerNotFound"))
			return
		end

		target:InviteToSquad(ply)
		SummeLibrary:Notify(ply, "success", "Squads", target:Name().. SquadSystem:L("INVITE_Successfull"))
    end,
})

SummeLibrary:RegisterCommand({
    key = "SquadSystem.List",
    commandList = {"!squads"},
    allowedRanks = false,
    func = function(ply, arguments)
		net.Start("SquadSystem.RequestSquadList")
		net.Send(ply)
    end,
})

/* -------------------------------------------------------------------------- */
/*                Removes a player from the squad on disconnect               */
/* -------------------------------------------------------------------------- */

hook.Add("PlayerDisconnected", "SquadSystem.RemoveFromSquad", function(ply)
	local squad = ply:GetSquad()
	if not squad then return end

	squad:RemoveMember(ply)
end)

/* -------------------------------------------------------------------------- */
/*                  Adds the workshop content to autodownload                 */
/* -------------------------------------------------------------------------- */

--resource.AddWorkshop("2686130557")

/* -------------------------------------------------------------------------- */
/*                     Block damage given by squad members                    */
/* -------------------------------------------------------------------------- */

if SquadSystem.Config.BlockDamage then
	hook.Add("PlayerShouldTakeDamage", "SquadSystem.BlockSquadDamage", function(ply, attacker)
		local squad = ply:GetSquad()
		
		if not squad then return end
		if not IsValid(attacker) then return end
		if not attacker:IsPlayer() then return end
	
		if squad == attacker:GetSquad() then return false end
	end)
end

/* -------------------------------------------------------------------------- */
/*                 Rewards all players part of a squad with xp                */
/* -------------------------------------------------------------------------- */

hook.Add("InitPostEntity", "SquadSystem.InitializeReward", function()
	if not SquadSystem.Config.XPRewards.enabled then return end

	local timerString = "SquadSystem.RewardXPTimer"

	if timer.Exists(timerString) then
		timer.Remove(timerString)
	end

	timer.Create(timerString, SquadSystem.Config.XPRewards.frequency * 60, 0, function()
		SquadSystem:RewardXP()
	end)
end)

function SquadSystem:RewardXP()
	print("REWARD")
	for _, ply in pairs(player.GetAll()) do
		if not IsValid(ply) then continue end
		
		local squad = ply:GetSquad()
		if not squad then return end

		if #squad:GetMembers() > 1 then
			if SquadSystem:GiveXP(ply, SquadSystem.Config.XPRewards.amount) then
				if not SquadSystem.Config.XPRewards.notify then continue end
				SummeLibrary:Notify(ply, "success", "Squads", SquadSystem:L("BROADCASTS_XPReward"))
			end
		end
	end
end

function SquadSystem:GiveXP(ply, amount)
	if LevelSystemConfiguration then -- https://github.com/uen/Leveling-System/ | Vrondakis
		ply:addXP(amount, false)
		return true
	end

	if Sublime then -- https://www.gmodstore.com/market/view/sublime-levels | Sublime Levels
		ply:SL_AddExperience(amount, "", false)
		return true
	end

	if BRICKS_SERVER then -- https://www.gmodstore.com/market/view/bricks-essentials | Brick's Essentials
		if BRICKS_SERVER.Func.IsSubModuleEnabled("essentials", "inventory") then
			ply:AddExperience(amount, "")
			return true
		end
	end

	if VoidFactions then -- https://www.gmodstore.com/market/view/voidfactions | VoidFactions
		ply:AddXP(amount)
		return true
	end

	if GlorifiedLeveling then -- https://github.com/GlorifiedPig/GlorifiedLeveling | GlorifiedLeveling
		GlorifiedLeveling.AddPlayerXP(ply, amount)
		return true
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
