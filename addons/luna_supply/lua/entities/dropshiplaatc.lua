--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName		= "DropShipLAATc"
ENT.Author 			= "Luna"
ENT.Information		= "Supplyship"
ENT.Category		= "VehicleDrops"

ENT.Spawnable = false
ENT.AdminOnly = false

ENT.AutomaticFrameAdvance = true

if CLIENT then
    soundLoop = Sound("laat/loop.wav")

    function ENT:Draw()
        self:DrawModel()
    end

    hook.Add("OnEntityCreated", "VDropshipFlying", function(ent)
        if (ent:GetClass() == "dropshipheli") then
            ent:EmitSound(soundLoop, 140, 100, 1, CHAN_STATIC)
        end
    end)

    function ENT:OnRemove()
        self:StopSound(soundLoop)
    end
end

if not SERVER then return end

local originalAngle = Angle(0,0,0)

function ENT:Initialize()
    local originalPosition = self:GetPos()
    self:SetPos(self:GetPos() + Vector(5000,0,3000))
    self:SetAngles(Angle( 0, 180, 0 ))
    self:SetModel("models/blu/laat_c.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_FLY)
    self:SetCollisionGroup(COLLISION_GROUP_WORLD)
    self:SetSolid(SOLID_VPHYSICS)
    local phyis = self:GetPhysicsObject()
    if (phyis:IsValid()) then
        phyis:Wake()
    end
    dropoffFlight(self, originalPosition)
end

function removeEntity(entity)
    entity:StopSound("LAATi_ENGINE")
    entity:Remove()
end

function dropoffFlight(entity, dropPos)
    local inFlight = true
    local dropped = false
    local timerName = "inFlightTimer" .. math.random(0, 1000)
    local dropVehicle = ents.Create("lvs_walker_atte")
	originalAngle = dropVehicle:GetAngles()
    timer.Create(timerName, FrameTime(), 0, function()
        if inFlight == true then
            if entity:GetPos().x >= dropPos.x - 500 or entity:GetPos().x <= dropPos.x + 500 then
                if dropped == false then
                    dropPos = dropPos + Vector(-270, 0, 3000)

                    controlledFall(dropVehicle, dropPos)

                    dropped = true
                end

                --entity:SetVelocity(Vector(-3000,0,0))

                timer.Remove(timerName)

                timer.Simple(5, function() inFlight = false removeEntity(entity) end)
            end
            entity:SetVelocity(Vector(-3000, 0, 0))
        end
    end)
end

function controlledFall(dropVehicle, toDropPos)
    dropVehicle:SetMoveType(MOVETYPE_FLY)

    if not dropVehicle:IsValid() then return end

    dropVehicle:SetPos(toDropPos)
    timer.Simple(1.8, function() dropVehicle:Spawn() end)

    timer.Create("controlledFall", FrameTime(), 0, function()
        local mins = dropVehicle:OBBMins() + Vector(0,0,-50)
        local maxs = dropVehicle:OBBMaxs() + Vector(0,0,-50)
        local startpos = dropVehicle:GetPos()

        local tr = {
            start = startpos,
            endpos = startpos,
            mins = mins,
            maxs = maxs
        }

        local hullTrace = util.TraceHull( tr )
        if (hullTrace.HitWorld) then
            timer.Remove( "controlledFall" )
            dropVehicle:SetMoveType(MOVETYPE_VPHYSICS)
        end
    end)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
