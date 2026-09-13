--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

util.AddNetworkString("hack_console_action")

--[[
    States
    1 - Waiting Player
    2 - Mini game
    3 - All attempts failed
    4 - Success
    5 - Fail

    404 - Target Entity has deleted


    Minigames
    1 - Snake
    2 - Reaction
    3 - Holding


    Actions
    SV -> CL
    1 - Start minigame, expect "holding"
    2 - Close minigame, expect "holding"

    CL -> SV
    1 - Success
    2 - Fail
    3 - Apply settings
    4 - Console Action

]]

function ENT:Initialize()
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_VPHYSICS)

    if self:GetType() == 3 then
        self:SetUseType(CONTINUOUS_USE) -- ONOFF_USE
    else
        self:SetUseType(SIMPLE_USE)
    end

    if IsValid(self.TargetEntity) then
        local cb = HackConsole.EntsSpawnCallback[self.TargetEntity:GetClass()]

        if cb then
            cb(self, self.TargetEntity)
        end
    end
end

function ENT:Use(caller, _, useType, val)
    if not IsValid(caller) then return end
    if not caller:IsPlayer() then return end
    if not IsValid(self.TargetEntity) then return end

    local state = self:GetState()

    
    if state == 1 then
        self.Player = caller
        self:SetState(2)
        self:SetStartTime(CurTime())
        self:SetLastHoldTime(CurTime())
        self:SetWarningHold(false)
        self:OpenMenu()

        if self:GetType() ~= 3 then
            self:OpenMenu()
        end
    elseif state == 2 then
        if self:GetType() == 3 then
            if caller ~= self.Player then return end

            self:SetLastHoldTime(CurTime())
        end
    end
end

function ENT:Reset()
    local state = self:GetState()

    if state == 2 then
        self:CloseMenu()
    end

    self:SetState(1)
end

function ENT:OpenMenu()
    if not IsValid(self.Player) then return end

    net.Start("hack_console_action")
        net.WriteUInt(1, 8)
        net.WriteEntity(self)
    net.Send(self.Player)
end

function ENT:CloseMenu()
    if not IsValid(self.Player) then return end

    net.Start("hack_console_action")
        net.WriteUInt(2, 8)
        net.WriteEntity(self)
    net.Send(self.Player)
end

function ENT:OnSuccess(ply)
    local cb = HackConsole.EntsHackCallback[self.TargetEntity:GetClass()]

    if cb then
        cb(self, ply, self.TargetEntity)
    end

    self:CloseMenu()
    self:SetState(4)
    self:SetUseType(SIMPLE_USE)
    self.Player = nil
end

function ENT:OnFailed(ply)
    local attemptleft = self:GetAttemptLeft()

    attemptleft = attemptleft - 1

    if attemptleft == 0 then
        self:SetAttemptLeft(self.MaxAttempt)
        self:SetState(3)
    else
        self:SetAttemptLeft(attemptleft)
        self:SetState(5)
    end

    self:SetCooldownTime(CurTime())
    
    self:CloseMenu()
    self:SetUseType(SIMPLE_USE)
    self.Player = nil
end

function ENT:OnRemove()
    self:CloseMenu()
end

function ENT:Think()

    local state = self:GetState()
    local type = self:GetType()

    local cooldown_time = self:GetCooldownTime()
    local start_time = self:GetStartTime()
    local hack_time = self:GetHackTime()
    local lasthold_time = self:GetLastHoldTime()

    if not IsValid(self.TargetEntity) and state ~= 4 then self:SetState(404) return end

    if state == 2 then
        if not IsValid(self.Player) then
            self:OnFailed()
            return
        end

        if not self.Player:Alive() then
            self:OnFailed(self.Player)
            return
        end

        if type == 3 then
            local pos = self:LocalToWorld(self:OBBCenter())

            if (CurTime() - lasthold_time) > 0.1 then
                self:SetWarningHold(true)
            else
                self:SetWarningHold(false)
            end
    
            if (CurTime() - lasthold_time) > 0.5 then
                self:OnFailed(self.Player)
                return
            end
        end

        if CurTime() > (start_time + hack_time) then
            if type == 3 then
                self:OnSuccess(self.Player)
            else
                self:OnFailed(self.Player)
            end 
        end
    elseif state == 3 then
        local can_repeat = self:GetCanRepeat()

        if not can_repeat then
            return
        end

        if CurTime() > (cooldown_time + HackConsole.ConsoleAllFailedCooldown) then
            self:SetState(1)
        end
    elseif state == 5 then
        if CurTime() > (cooldown_time + HackConsole.ConsoleFailedCooldown) then
            self:SetState(1)
            --Entity:SetBodygroup(0,1)
        end
    end
end

local function ApplySettingsPlayer(ply)
    
    local name = net.ReadString()
    local max_attempt = net.ReadInt(16)
    local time_for_hack = net.ReadInt(16)
    local can_repeat = net.ReadBool()
    local selected_model = net.ReadString()
    local selected_type = net.ReadInt(16)

    ply.HackConsoleSettings = {
        name = name,
        max_attempt = max_attempt,
        time_for_hack = time_for_hack,
        can_repeat = can_repeat,
        model = selected_model,
        type = selected_type,
    }
end

net.Receive("hack_console_action", function(_, ply)
    local action = net.ReadUInt(8)

    if action == 3 and ply:IsAdmin() then ApplySettingsPlayer(ply) return end

    local ent = net.ReadEntity()

    if not IsValid(ent) then return end
    if ent:GetClass() ~= "hack_console" then return end -- cheats moment?

    local state = ent:GetState()

    if state == 2 then
        local console_ply = ent.Player

        if not IsValid(console_ply) then return end
        if console_ply ~= ply then return end

        if action == 1 then
            ent:OnSuccess(ply)
        elseif action == 2 then
            ent:OnFailed(ply)
        end
    end

    if action == 4 and ply:IsAdmin() then
        local sub_action = net.ReadUInt(8)

        if sub_action == 1 then
            ent:Remove()
        elseif sub_action == 2 then
            local pos = HackConsole.ConsoleModelsTexts[ent:GetModel()].pos

            ply:SetPos(ent:LocalToWorld(pos))
        elseif sub_action == 3 then
            ent:Reset()
        end
    end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
