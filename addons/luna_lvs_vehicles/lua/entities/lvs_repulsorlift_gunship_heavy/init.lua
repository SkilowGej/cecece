--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_prediction.lua" )
AddCSLuaFile( "sh_mainweapons.lua" )
AddCSLuaFile( "sh_ballturret_left.lua" )
AddCSLuaFile( "sh_wingturret.lua" )
AddCSLuaFile( "sh_gunner2.lua" )
AddCSLuaFile( "sh_gunner3.lua" )
AddCSLuaFile( "cl_drawing.lua" )
AddCSLuaFile( "cl_lights.lua" )
include("shared.lua")
include( "sh_mainweapons.lua" )
include( "sh_ballturret_left.lua" )
include( "sh_wingturret.lua" )
include( "sh_gunner2.lua" )
include( "sh_gunner3.lua" )	

ENT.SpawnNormalOffset = 25

function ENT:OnSpawn( PObj )
	PObj:SetMass( 10000 )

	local DriverSeat = self:AddDriverSeat( Vector(207,0,120), Angle(0,-90,0) )
	DriverSeat:SetCameraDistance( 1 )
	DriverSeat.ExitPos = Vector(400,0,20)

	self:AddEngine( Vector(-385,0,255) )
	self:AddEngineSound( Vector(-180,0,230) )

	self.PrimarySND = self:AddSoundEmitter( Vector(256,0,36), "lvs/vehicles/laat/fire.mp3", "lvs/vehicles/laat/fire.mp3" )
	self.PrimarySND:SetSoundLevel( 110 )

	self.WingRightSND = self:AddSoundEmitter( Vector(-206,-341,109), "lvs/vehicles/laat/ballturret_loop.wav", "lvs/vehicles/laat/ballturret_loop.wav" )
	self.WingRightSND:SetSoundLevel( 110 )

	self.WingLeftSND = self:AddSoundEmitter( Vector(-206,-341,109), "lvs/vehicles/laat/ballturret_loop.wav", "lvs/vehicles/laat/ballturret_loop.wav" )
	self.WingLeftSND:SetSoundLevel( 110 )

	self.SNDTail = self:AddSoundEmitter( Vector(-440,0,157), "lvs/vehicles/arc170/fire_gunner.mp3", "lvs/vehicles/arc170/fire_gunner.mp3" )
	self.SNDTail:SetSoundLevel( 110 )

	local GunnerSeat = self:AddPassengerSeat( Vector(111.87,0,156), Angle(0,-90,0) )
	GunnerSeat.ExitPos = Vector(350,0,20)

	self:SetGunnerSeat( GunnerSeat )

	do
		local BallTurretPod = self:AddPassengerSeat( Vector(0,0,100), Angle(0,-90,0) )
		BallTurretPod.ExitPos = Vector(0,-200,20)
		BallTurretPod.HidePlayer = true

		local ID = self:LookupAttachment( "muzzle_ballturret_left" )
		local Muzzle = self:GetAttachment( ID )

		if Muzzle then
			local Pos,Ang = LocalToWorld( Vector(0,-28,-65), Angle(180,0,-90), Muzzle.Pos, Muzzle.Ang )

			BallTurretPod:SetParent( NULL )
			BallTurretPod:SetPos( Pos )
			BallTurretPod:SetAngles( Ang )
			BallTurretPod:SetParent( self )
			self:SetBTPodL( BallTurretPod )

			self.sndBTL = self:AddSoundEmitter( Vector(0,0,0), "lvs/vehicles/laat/ballturret_loop.wav", "lvs/vehicles/laat/ballturret_loop.wav" )
			self.sndBTL:SetSoundLevel( 110 )
			self.sndBTL:SetParent( NULL )
			self.sndBTL:SetPos( Muzzle.Pos )
			self.sndBTL:SetAngles( Muzzle.Ang )
			self.sndBTL:SetParent( self, ID )
		end
	end

	do
		local GunnerSeat2 = self:AddPassengerSeat( Vector(-180,80,75), Angle(0,0,0) )
		GunnerSeat2.ExitPos = Vector(80,-150,20)
		GunnerSeat2.HidePlayer = true

		local ID2 = self:LookupAttachment( "40mm" )
		local Muzzle2 = self:GetAttachment( ID2 )
		if Muzzle2 then
			local Pos,Ang = LocalToWorld( Vector(4,0,-35), Angle(0,-90,0), Muzzle2.Pos, Muzzle2.Ang )

			GunnerSeat2:SetParent( NULL )
			GunnerSeat2:SetPos( Pos )
			GunnerSeat2:SetAngles( Ang )
			GunnerSeat2:SetParent( self )
			self:SetSecondGunnerSeat( GunnerSeat2 )
		end
		
	end
	do
		local GunnerSeat3 = self:AddPassengerSeat(  Vector(-225,80,100), Angle(0,0,0) )
		GunnerSeat3.ExitPos = Vector(200,-150,20)
		GunnerSeat3.HidePlayer = true

		local ID3 = self:LookupAttachment( "105mm" )
		local Muzzle3 = self:GetAttachment( ID3 )
		if Muzzle3 then
			local Pos,Ang = LocalToWorld( Vector(4,0,-35), Angle(0,-90,0), Muzzle3.Pos, Muzzle3.Ang )

			GunnerSeat3:SetParent( NULL )
			GunnerSeat3:SetPos( Pos )
			GunnerSeat3:SetAngles( Ang )
			GunnerSeat3:SetParent( self )
			self:SetThirdGunnerSeat( GunnerSeat3 )
		end
		
	end
	self:SetPoseParameter("ballturret_left_pitch", 0 )
	self:SetPoseParameter("ballturret_left_yaw", -70 )
end

function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/start.wav" )
	else
		self:EmitSound( "lvs/vehicles/laat/landing.wav" )
	end
end

function ENT:OnBallturretMounted( ismounted, oldvar )
	if ismounted == oldvar then return end

	self._CanUseBT = ismounted

	if ismounted then
		if IsValid( self.BTPodL_ent_orig ) then 
			self:SetBTPodL( self.BTPodL_ent_orig )
			self.BTPodL_ent_orig:SetNWInt( "pPodIndex", self.BTPodL_index_orig )
		end
	else
		local Pod_L = self:GetBTPodL()
		if IsValid( Pod_L ) then 
			self.BTPodL_ent_orig = Pod_L
			self.BTPodL_index_orig = Pod_L:GetNWInt( "pPodIndex" )
			Pod_L:SetNWInt( "pPodIndex", -1 )

			local ply = Pod_L:GetDriver()
			if IsValid( ply ) then
				ply:ExitVehicle()
			end
		end

		self:SetBTPodL( NULL )
	end
end

function ENT:OnTick()

	local BTbodygroup = self:GetBodygroup(4)

	if BTbodygroup ~= self.oldBTbodygroup then
		self:OnBallturretMounted( BTbodygroup == 0, self.oldBTbodygroup == 0 )

		self.oldBTbodygroup = BTbodygroup
	end
end

function ENT:BallturretDamage( target, attacker, HitPos, HitDir )
	if not IsValid( target ) then return end

	if not IsValid( attacker ) then
		attacker = self
	end

	if target ~= self then
		local dmginfo = DamageInfo()
		dmginfo:SetDamage( 1000 * FrameTime() )
		dmginfo:SetAttacker( attacker )
		dmginfo:SetDamageType( DMG_SHOCK + DMG_ENERGYBEAM + DMG_AIRBOAT )
		dmginfo:SetInflictor( self ) 
		dmginfo:SetDamagePosition( HitPos ) 
		dmginfo:SetDamageForce( HitDir * 10000 ) 
		target:TakeDamageInfo( dmginfo )
	end
end

function ENT:OnVehicleSpecificToggled( IsActive )
	if self:GetBodygroup( 5 ) ~= 1 or self:GetAI() then
		if not self:GetLightsActive() then return end

		self:SetLightsActive( false )

		return
	end

	self:SetLightsActive( IsActive )

	self:EmitSound( "buttons/lightswitch2.wav", 75, 105 )
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
