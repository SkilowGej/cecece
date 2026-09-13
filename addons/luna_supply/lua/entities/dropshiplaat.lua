--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName		= "DropShipLAAT"
ENT.Author 			= "Luna"
ENT.Category		= "SUP • Rozwój"

ENT.Spawnable = false
ENT.AdminOnly = false

ENT.soundLoop = nil

ENT.AutomaticFrameAdvance = true

-- List of Entities that will be dropped
ENT.SupplyTable = {"ammo_drop"}
-- The Height of the flight
ENT.Height = 3000
-- Delay Between Items in Drops
ENT.Delay = 0.1
-- Speed of the Ship
ENT.Speed = -1000
-- Model of the Ship
ENT.Model = "models/fisher/laat/laatspace.mdl"
-- Sound of the Ship
ENT.Sound = "laat/loop.wav"

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
    function ENT:Initialize()
        self.soundLoop = Sound(self.Sound)
        self:EmitSound(self.soundLoop, 140, 100, 1, CHAN_STATIC)
    end
    function ENT:OnRemove()
        self:StopSound(self.soundLoop)
    end
end

if not SERVER then return end

function ENT:OnRemove()
    if timer.Exists("FlyID" .. self:GetCreationID()) then
        timer.Remove("FlyID" .. self:GetCreationID())
    end
end

function ENT:Initialize()
    if table.IsEmpty(self.SupplyTable) then
        error("SupplyTable is empty")
        self:Remove()
        return
    end
    local oPos = self:GetPos()
    self:SetModel(self.Model)
    self:SetPos(self:GetPos() + Vector(5000,0,self.Height))
    self:SetAngles(Angle( 0, 180, 0 ))
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_FLY)
    self:SetCollisionGroup(COLLISION_GROUP_WORLD)
    self:SetSolid(SOLID_VPHYSICS)
    local phyis = self:GetPhysicsObject()
    if (phyis:IsValid()) then
        phyis:Wake()
    end
    SupplyDropOfFlight(self, self:GetPos(), oPos)
end

function SupplyDropOfFlight(ent, startPos, dropPos)
    local delay = 0

    local radius = 200
    local height = ent.Height

    if #ent.SupplyTable == 1 then
        radius = 20
    end

    timer.Create("FlyID" .. ent:GetCreationID(), FrameTime(), 0, function()
        if table.HasValue(ents.FindInSphere(dropPos + Vector(-200, 0, height), radius), ent) then
            if table.IsEmpty(ent.SupplyTable) then
                timedRemoval(ent, 3)
            else
                if CurTime() < delay then
                    goto after
                end

                local rand = math.random(1, #ent.SupplyTable)
                local randItem = ent.SupplyTable[rand]
                table.remove(ent.SupplyTable, rand)
                local drop = ents.Create(randItem)
                drop:SetPos(ent:GetPos())
                drop:SetMoveType(MOVETYPE_FLY)
                drop:SetSolid(SOLID_VPHYSICS)
                drop:SetCollisionGroup(COLLISION_GROUP_PLAYER)
                drop:Spawn()
                drop:Activate()
                controlledSupplyFall(drop, dropPos)
                delay = CurTime() + ent.Delay
            end
        end

        ::after::
        ent:SetVelocity(Vector(-1000, 0, 0))
    end)
end

function controlledSupplyFall(entity, toDropPos)
    if not entity:IsValid() then return end
    local timerName = "controlledSupplyFall" .. entity:GetCreationID()
    timer.Create(timerName, FrameTime(), 0, function()
        if not IsValid(entity) then
            timer.Remove(timerName)
        end
        local mins = entity:OBBMins() + Vector(0, 0, -50)
        local maxs = entity:OBBMaxs() + Vector(0, 0, -50)
        local startpos = entity:GetPos()

        local tr = {
            start = startpos,
            endpos = startpos,
            mins = mins,
            maxs = maxs
        }

        local hullTrace = util.TraceHull(tr)

        if (hullTrace.HitWorld) then
            timer.Remove(timerName)
            --entity:SetPos(entity:GetPos() + Vector(0, 0, -40))
            entity:SetMoveType(MOVETYPE_VPHYSICS)
            entity:SetSolid(SOLID_VPHYSICS)
            entity:SetCollisionGroup(COLLISION_GROUP_PLAYER)
            entity:DropToFloor()
        end
    end)
end

function timedRemoval(ent, secs)
    timer.Simple(secs, function()
        if IsValid(ent) then
            ent:Remove()
        end
    end)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
