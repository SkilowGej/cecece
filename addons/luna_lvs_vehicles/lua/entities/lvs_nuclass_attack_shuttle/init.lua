--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.SpawnNormalOffset = 25

function ENT:OnSpawn( PObj )
	PObj:SetMass( 25000 )

	self:SetWingsDown(false)

    local DriverSeat = self:AddDriverSeat( Vector(425,0,280), Angle(0,-90,-0) )
	DriverSeat.HidePlayer = true
	DriverSeat.ExitPos = Vector(-70,-2.40,193)
	DriverSeat:SetCameraDistance(3.5)
	
	self.PrimarySND = self:AddSoundEmitter( Vector(675,0, -15), "lvs/vehicles/naboo_n1_starfighter/fire.mp3", "lvs/vehicles/naboo_n1_starfighter/fire.mp3" )
	self.PrimarySND:SetSoundLevel( 110 )

	self.SecondarySND = self:AddSoundEmitter( Vector(675,0, -15), "lvs/vehicles/nuclass/gbran.wav", "lvs/vehicles/nuclass/gbran.wav" )
	self.SecondarySND:SetSoundLevel( 110 )

	local Seat1 = self:AddPassengerSeat(Vector(0,-50,200),Angle(0,0,0))
	Seat1.ExitPos = Vector(0,-10,200)
	local Seat2 = self:AddPassengerSeat(Vector(-25,-50,200),Angle(0,0,0))
	Seat2.ExitPos = Vector(-25,-10,200)
	local Seat3 = self:AddPassengerSeat(Vector(-55,-50,200),Angle(0,0,0))
	Seat3.ExitPos = Vector(-55,-10,200)
	local Seat4 = self:AddPassengerSeat(Vector(-85,-50,200),Angle(0,0,0))
	Seat4.ExitPos = Vector(-85,-10,200)
	local Seat5 = self:AddPassengerSeat(Vector(-110,-50,200),Angle(0,0,0))
	Seat5.ExitPos = Vector(-110,-10,200)
	local Seat6 = self:AddPassengerSeat(Vector(-140,-50,200),Angle(0,0,0))
	Seat6.ExitPos = Vector(-140,-10,200)
	local Seat7 = self:AddPassengerSeat(Vector(-170,-50,200),Angle(0,0,0))
	Seat7.ExitPos = Vector(-160,-10,200)

	local Seat8 = self:AddPassengerSeat(Vector(0,50,200),Angle(0,180,0))
	Seat8.ExitPos = Vector(0,20,200)
	local Seat9 = self:AddPassengerSeat(Vector(-25,50,200),Angle(0,180,0))
	Seat9.ExitPos = Vector(-25,20,200)
	local Seat10 = self:AddPassengerSeat(Vector(-55,50,200),Angle(0,180,0))
	Seat10.ExitPos = Vector(-55,20,200)
	local Seat11 = self:AddPassengerSeat(Vector(-85,50,200),Angle(0,180,0))
	Seat11.ExitPos = Vector(-85,20,200)
	local Seat12 = self:AddPassengerSeat(Vector(-110,50,200),Angle(0,180,0))
	Seat12.ExitPos = Vector(-110,20,200)
	local Seat13 = self:AddPassengerSeat(Vector(-140,50,200),Angle(0,180,0))
	Seat13.ExitPos = Vector(-140,20,200)
	local Seat14 = self:AddPassengerSeat(Vector(-170,50,200),Angle(0,180,0))
	Seat14.ExitPos = Vector(-160,20,200)
	
	self:AddEngine( Vector(-475,210,170) )
	self:AddEngine( Vector(-475,124,187.5) )
	self:AddEngine( Vector(-475,-195,135) )
	self:AddEngine( Vector(-475,-160,165) )
	self:AddEngine( Vector(-500,0,210) )
	self:AddEngineSound( Vector(-825,0,200) )

	self:PlayAnimation( "wings_close" )

	self:SetHatchOpen(true)
	self:ManipulateBoneAngles(1, Angle(0,0,-90))
	self:ManipulateBoneAngles(2, Angle(0,0,180))

end

function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "lvs/vehicles/shuttle/startup.wav")
		self:SetSequence( "wings_close")
	else
		self:EmitSound( "lvs/vehicles/shuttle/shutdown.wav" )
	end
end

function ENT:OnVehicleSpecificToggled()
	if not self:GetWingsDown(false) then
		self:EmitSound("lvs/vehicles/shuttle/sfoils.mp3")
		self:SetMaxThrottle(1)
		self:SetWingsDown(true)
		self:PlayAnimation( "wings_open" )
	else
		self:EmitSound("lvs/vehicles/shuttle/sfoils.mp3")
		self:SetMaxThrottle(0.8)
		self:SetWingsDown(false)
		self:PlayAnimation( "wings_close" )
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
