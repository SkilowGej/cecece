--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

function ENT:OnSpawn( PObj )
	PObj:SetMass( 5000 )

	local GunnerSeat = self:AddPassengerSeat( Vector(0,0,55), Angle(0,-90,0) )
	GunnerSeat.HidePlayer = true
	self:SetGunnerSeat( GunnerSeat )

	self:AddEngine( Vector(0,0,-10) )

	self.PrimarySND = self:AddSoundEmitter( Vector(0,-40,57), "lvs/vehicles/droidtrifighter/fire_nose.mp3", "lvs/vehicles/droidtrifighter/fire_nose.mp3" )
	self.PrimarySND:SetSoundLevel( 110 )
	
	self.SecondarySND = self:AddSoundEmitter( Vector(0,-40,57), "lvs/vehicles/vulturedroid/fire.mp3", "lvs/vehicles/vulturedroid/fire.mp3" )
	self.SecondarySND:SetSoundLevel( 110 )

	local ID = self:LookupAttachment( "seat" )
	local Attachment = self:GetAttachment( ID )

	if Attachment then
		local Pos,Ang = LocalToWorld( Vector(0,0,30), Angle(0,180,0), Attachment.Pos, Attachment.Ang )

		GunnerSeat:SetParent( NULL )
		GunnerSeat:SetPos( Pos )
		GunnerSeat:SetAngles( Ang )
		GunnerSeat:SetParent( self )
	end
end

function ENT:OnEngineActiveChanged( Active )
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
