AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

util.AddNetworkString( 'Tickets:Menu' )
util.AddNetworkString( 'Tickets:Buy' )
util.AddNetworkString( 'Tickets:Sync' )

local function syncAll()
	net.Start( 'Tickets:Sync' )
		net.WriteTable( GMap.Vehicles )
	net.Broadcast()
end

net.Receive( 'Tickets:Buy', function( _, p )
	if not p:IsAdmin() then p:ChatPrint('Nie jesteś administratorem.') return end

	local count = net.ReadUInt( 8 )
	local class = net.ReadString()
	local price = net.ReadUInt( 16 )
	local tickets = tonumber( GetTickets() )

	if not count or not class or not price then return end

	if tickets <= price then
		p:ChatPrint( '[!] Za mało biletów!' )
		return
	end

	if GMap.Vehicles[class] then
		GMap.Vehicles[class] = GMap.Vehicles[class] + count
		AddTickets( price )

		p:ChatPrint( '[!] Kupiłeś '.. GMap.Vehicles[class] + count.. ' szt. sprzętu "'.. class.. '".' )

		syncAll()
		return 
	end

	GMap.Vehicles[class] = count
	TakeTickets( price )

	p:ChatPrint( '[!] Kupiłeś '.. count.. ' szt. sprzętu "'.. class.. '".' )

	syncAll()
end )

function ENT:Initialize()
	self:SetModel('models/lucky/navallookinganimated.mdl')

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
    self.ProtalVector = false

	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:EnableMotion( false )
		phys:Wake()
	end
end

local function HasRequiredRank(ply)
    local playerType = re.jobs[ply:Team()].Type
    local rank = ply:GetNWString("rating")
    
    if not ALIVE_RATINGS[playerType] then return false end
    
    for i = 9, 24 do
        if ALIVE_RATINGS[playerType][i] == rank then
            return true
        end
    end
    
    return false
end

function ENT:Use(activator, caller)
    if not IsValid(activator) or not activator:IsPlayer() then return end
    
    if game.GetMap() == DEFAULT_MAP then
        re.util.Notify("red", activator, "Na domowej mapie nie można! Fuj!")
        return
    end

    if HasRequiredRank(activator) then
        net.Start('Tickets:Menu')
        net.Send(activator)
    else
        activator:ChatPrint('Nie masz dostępu do tego menu.')
    end
end