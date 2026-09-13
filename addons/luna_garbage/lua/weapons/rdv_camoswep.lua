--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if CLIENT then
	SWEP.PrintName = "Kamuflaż"
	SWEP.Author = "Nicolas, Kay"
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.WepSelectIcon = surface.GetTextureID("camo/camo_wepselecticon.vmt")
end

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = "none"
SWEP.DrawAmmo = false

SWEP.HoldType = "normal"
SWEP.Category = "SUP • Wyposażenie";
SWEP.UseHands = false

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Primary.Automatic= false

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = ""

local CamoActivate = Sound("camo/camo_on.wav")
local CamoDeactivate = Sound("camo/camo_off.wav")

local CamoMat = Material("ace/sw/hologram")

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

function SWEP:SecondaryAttack()
	return
end

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
end

function SWEP:Deploy()
	self:SetNextPrimaryFire(CurTime() + .2)
	self:GetOwner():DrawViewModel(false)
end

function SWEP:DrawWorldModel()
	return false
end

function SWEP:Reload()
	return
end

if SERVER then
    CreateConVar("rdv_camo_npchostilemovement", 0, FCVAR_ARCHIVE, "Should NPC's attack players when they are partially invisible? (moving with cloak engaged.)")
    CreateConVar("rdv_camo_firecloakdisable", 1, FCVAR_ARCHIVE, "Should cloak be disabled when the player fires a weapon?")

    function SWEP:PrimaryAttack()
        self:SetNextPrimaryFire(CurTime() + 3)
        
        local CamoIsOn = self:GetOwner():GetNWBool("CamoEnabled", false)
        
        if CamoIsOn then
            self:GetOwner():SetNoTarget(false)
        else
            self:GetOwner():SetNoTarget(true)
        end

        self:GetOwner():SetNWBool("CamoEnabled",!CamoIsOn)
    end

    local function CheckPlayerStill(ply)
        local CamoIsOn = ply:GetNWBool("CamoEnabled", false)

        if CamoIsOn then
            if ply:GetVelocity():Length() <= 1 then
                if GetConVar("rdv_camo_npchostilemovement"):GetBool() then ply:SetNoTarget(true) end

                ply:SetNoDraw(true)
            else
                if GetConVar("rdv_camo_npchostilemovement"):GetBool() then ply:SetNoTarget(false) end

                ply:SetNoDraw(false)
            end
        else
            ply:SetNoDraw(false)
        end
    end
    hook.Add("PlayerTick","SetPlayerCamoAlpha",CheckPlayerStill)
        
    local function CheckPlayerDead(ply)
        local CamoIsOn = ply:GetNWBool("CamoEnabled", false)
            
        if CamoIsOn then
            ply:SetNWBool("CamoEnabled",false)
            ply:SetNoTarget(false)
        end
    end
    hook.Add("PlayerDeath","RemoveDeadPlayerCamo",CheckPlayerDead)

    hook.Add("EntityFireBullets", "RDV.CAMO", function(ent, data)
        if !GetConVar("rdv_camo_firecloakdisable"):GetBool() then return end

        if ent:IsPlayer() and ent:GetNWBool("CamoEnabled") then
            ent:SetNWBool("CamoEnabled",false)
            ent:SetNoTarget(false)
        end
    end)
else
    local function DrawPlayerMaterial(ply)
        local CamoIsOn = ply:GetNWBool("CamoEnabled", false)
    
        if CamoIsOn then
            render.ModelMaterialOverride(CamoMat)
        end
    end
    hook.Add("PrePlayerDraw","DrawPlayerCamo",DrawPlayerMaterial)
        
    local function UndoPlayerMaterial(ply)
        render.ModelMaterialOverride()
    end
    hook.Add("PostPlayerDraw","UndoPlayerCamo",UndoPlayerMaterial)

    function SWEP:PrimaryAttack()
        self:SetNextPrimaryFire(CurTime() + 3)
        
        local CamoIsOn = self:GetOwner():GetNWBool("CamoEnabled", false)

        if CamoIsOn then
            surface.PlaySound(CamoDeactivate)
        else
            surface.PlaySound(CamoActivate)
        end
    end
end

-- Only firstperson view:
--[[
    local mat = 'ace/sw/hologram' 
    hook.Add( 'PreDrawViewModel', 'dsaasd', function( vm, p, wep )
        local CamoIsOn = p:GetNWBool( "CamoEnabled", false )

        if CamoIsOn then
            vm:SetMaterial( mat )
        end
    end )
--]]

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
