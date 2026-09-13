--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if (CLIENT) then
    SWEP.PrintName = "Flare Gun (Vehicle)"
    SWEP.Slot                       = 1
    SWEP.SlotPos                    = 1
    SWEP.SwayScale                  = 4
    SWEP.UseHands                   = true
    SWEP.DrawAmmo                   = true
end

SWEP.Author = "Luiggi33"
SWEP.Contact = "Luiggi33 on Steam"
SWEP.Purpose = "Create a Flare"
SWEP.Instructions = "Create the Flare with left click"

SWEP.Category = "VehicleDrops"

SWEP.ViewModel                  = "models/joes/c_datapad.mdl"
SWEP.WorldModel                 = "models/joes/w_datapad.mdl"
SWEP.HoldType                   = "revolver"
SWEP.Spawnable                  = true
SWEP.AdminSpawnable             = false

SWEP.Primary.Damage             = 1
SWEP.Primary.Force              = 1
SWEP.Primary.ClipSize           = 1
SWEP.Primary.DefaultClip        = 3
SWEP.Primary.Recoil             = 2
SWEP.Primary.Delay              = 10
SWEP.Primary.Automatic          = false
SWEP.Primary.Ammo               = "357"
SWEP.Primary.Sound              = {"flare/fire.wav"}
SWEP.Primary.DistantSound       = {"flare/fire_dist.wav"}

SWEP.Secondary.ClipSize         = 0
SWEP.Secondary.DefaultClip      = 0
SWEP.Secondary.Automatic        = false
SWEP.Secondary.Ammo             = "none"

SWEP.Primary.DisableBulletCode  = true
SWEP.PrimaryEffects_MuzzleAttachment = 0
SWEP.PrimaryEffects_SpawnShells = false

SWEP.DelayOnDeploy              = 10

SWEP.HasIdleAnimation           = false

function SWEP:Initialize()
    self:SetWeaponHoldType( self.HoldType )
end

function SWEP:PrimaryAttack()
    if CLIENT then return end

    local ply = self:GetOwner()

    if ( not ply:IsValid() ) then return end

    ply:LagCompensation( true )


    local proj = ents.Create("obj_flareround")
    if ( not proj:IsValid() ) then
        print("Error")
        ply:LagCompensation(false)
        return
    end

    local ply_Ang = ply:GetAimVector():Angle()
    local ply_Pos = ply:GetShootPos()
    if ply:IsPlayer() then proj:SetPos(ply_Pos) end
    if ply:IsPlayer() then proj:SetAngles(ply_Ang) end
    proj:SetOwner(ply)
    proj:Activate()
    proj:Spawn()

    local phys = proj:GetPhysicsObject()

    if IsValid(phys) and ply:IsPlayer() then
        phys:SetVelocity(ply:GetAimVector() * 500)
    end

    timer.Simple(5, function() callVehicleDrop(proj:GetPos()) end )

    self:TakePrimaryAmmo(1)
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

    ply:LagCompensation(false)
end

function callVehicleDrop(dropPosition)
    local dropLAATc = ents.Create("dropshiplaatc")
    if (not dropLAATc:IsValid()) then return end

    dropLAATc:SetPos(dropPosition)
    dropLAATc:Spawn()
end

function SWEP:SecondaryAttack()
end



--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
