--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if (SERVER) then

	SWEP.Weight				= 5
	SWEP.AutoSwitchTo			= false
	SWEP.AutoSwitchFrom		= false
end

if ( CLIENT ) then
	SWEP.PrintName			= "Fortnite Emotes"	
	SWEP.DrawAmmo 			= false
	SWEP.DrawCrosshair 		= false
	SWEP.ViewModelFOV			= 77
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes		= true
	
	SWEP.Slot				= 2
	SWEP.SlotPos			= 0
	SWEP.IconLetter			= "j"
end

SWEP.Category			= "[wOS] Fortnite Dances"

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= false

SWEP.DrawWeaponInfoBox  	= false

SWEP.Weight					= 5
SWEP.AutoSwitchTo				= false
SWEP.AutoSwitchFrom			= false

SWEP.Primary.ClipSize			= -1
SWEP.Primary.Damage			= -1
SWEP.Primary.DefaultClip		= -1
SWEP.Primary.Automatic			= true
SWEP.Primary.Ammo			="none"


SWEP.Secondary.ClipSize			= -1
SWEP.Secondary.DefaultClip		= -1
SWEP.Secondary.Damage			= -1
SWEP.Secondary.Automatic		= true
SWEP.Secondary.Ammo			="none"

SWEP.DrawWorldModel = false

SWEP.SelectedAct = "dancemoves"

/*---------------------------------------------------------
Think
---------------------------------------------------------*/
function SWEP:Think()
end

/*---------------------------------------------------------
Initialize
---------------------------------------------------------*/
function SWEP:Initialize() 
	self:SetWeaponHoldType( "normal" ) 	 
end 

/*---------------------------------------------------------
Deploy
---------------------------------------------------------*/
function SWEP:Deploy()
	return true
end

/*---------------------------------------------------------
PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	if SERVER then
		if not self.Owner:Alive() then return end	
		if self.Owner:InVehicle() then return end
		local sequence_name = wOS.Fortnite.ValidEmotes[ self.SelectedAct ]
		if not sequence_name then return end
		self.Owner:SetNWString( "wOS.Fortnite.Emote", sequence_name )
		self.Owner:SetNWBool( "wOS.Fortnite.EmoteEnabled", true )
		net.Start( "wOS.Fortnite.StartTauntCamera" )
		net.Send( self.Owner )
	end
	self:SetNextPrimaryFire( CurTime() + 1 )
end

local Translations = {}
Translations[ "Best Mates" ] = "bestmates"
Translations[ "Boneless" ] = "boneless"
Translations[ "Breakdown" ] = "breakdown"
Translations[ "Dance Moves" ] = "dancemoves"
Translations[ "Disco Fever" ] = "discofever"
Translations[ "Flying Eagle" ] = "eagle"
Translations[ "Electro Shuffle" ] = "electroshuffle"
Translations[ "Flippin' Incredible" ] = "flippinincredible"
Translations[ "Flippin' Sexy" ] = "flippinsexy"
Translations[ "Floss" ] = "floss"
Translations[ "Fresh" ] = "fresh"
Translations[ "Gentleman's Dab" ] = "gentlemandab"
Translations[ "Groove Jam" ] = "groovejam"
Translations[ "Hand Signals" ] = "handsignals"
Translations[ "Hype" ] = "hype"
Translations[ "Infini-Dab" ] = "infinidab"
Translations[ "Intensity" ] = "intensity"
Translations[ "Jubilation" ] = "jubilation"
Translations[ "Laugh It Up" ] = "laughitup"
Translations[ "Livin' Large" ] = "livinglarge"
Translations[ "Orange Justice" ] = "orangejustice"
Translations[ "Poplock" ] = "poplock"
Translations[ "Rambunctious" ] = "rambunctious"
Translations[ "Re-Animated" ] = "reanimate"
Translations[ "Star Power" ] = "starpower"
Translations[ "Swipe It" ] = "swipeit"
Translations[ "Take the L" ] = "takethel"
Translations[ "True Heart" ] = "trueheart"
Translations[ "Twist" ] = "twist"
Translations[ "Wiggle" ] = "wiggle"
Translations[ "You're Awesome!" ] = "youreawesome"
Translations[ "Zany" ] = "zany"

function SWEP:SecondaryAttack()
	if CLIENT then
		gui.EnableScreenClicker( true )
		if self.MainMenu then
			self.MainMenu:Remove()
			self.MainMenu = nil
		end
		self.MainMenu = vgui.Create( "DScrollPanel" )
		self.MainMenu:SetSize( ScrW()*0.3, ScrH()*0.4 )
		self.MainMenu:Center()
		self.MainMenu:GetCanvas():DockPadding( 30, 30, 30, 30 )
		self.MainMenu.Think = function( pan )
			if not IsValid( self ) or not self.Owner:Alive() then
				pan:Remove()
				self.MainMenu = nil
				gui.EnableScreenClicker( false )
			end
		end
		
		for name, seq in pairs( Translations ) do
			local butt = vgui.Create( "DButton", self.MainMenu )
			butt:SetText( name )
			butt:Dock( TOP )
			butt.DoClick = function( pan )
				net.Start( "wOS.Fortnite.WeaponSelect" )
					net.WriteString( seq )
				net.SendToServer()
				self.MainMenu:Remove()
				self.MainMenu = nil
				gui.EnableScreenClicker( false )
			end
		end
		
	end
end

function SWEP:Reload()
	return false
end

/*---------------------------------------------------------
OnRemove
---------------------------------------------------------*/
function SWEP:OnRemove()
	return true
end

/*---------------------------------------------------------
Holster
---------------------------------------------------------*/
function SWEP:Holster()
	return true
end

if CLIENT then
	function SWEP:PreDrawViewModel() render.SetBlend(0) end
	function SWEP:DrawWorldModel() end
	function SWEP:DrawWeaponSelection(x,y,wide,tall,alpha) end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
