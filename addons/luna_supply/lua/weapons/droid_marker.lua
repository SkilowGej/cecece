--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if (CLIENT) then
    SWEP.PrintName = "Resetowanie droidów"
    SWEP.Slot                       = 4
    SWEP.SlotPos                    = 1
    SWEP.SwayScale                  = 4
    SWEP.UseHands                   = true
    SWEP.DrawAmmo                   = true
end

SWEP.Author = "Luiggi33"
SWEP.Contact = "Luiggi33 on Steam"
SWEP.Purpose = "Mark the Location for the Ammo Drop"
SWEP.Instructions = "Create the Flare with left click"

SWEP.Category = "SUP • Rozwój"

SWEP.ViewModel                  = "models/weapons/aussiwozzi/c_macrobinoculars.mdl"
SWEP.WorldModel                 = "models/weapons/aussiwozzi/w_macrobinoculars.mdl"
SWEP.HoldType                   = "revolver"
SWEP.Spawnable                  = true
SWEP.AdminSpawnable             = false

SWEP.Primary.Damage             = 1
SWEP.Primary.Force              = 1
SWEP.Primary.ClipSize           = 1
SWEP.Primary.DefaultClip        = 1
SWEP.Primary.Recoil             = 2
SWEP.Primary.Delay              = 10
SWEP.Primary.Automatic          = false
SWEP.Primary.Ammo               = "357"
SWEP.Primary.Sound              = {"weapons/kaito/swep_success.mp3"}
SWEP.Primary.DistantSound       = {"weapons/kaito/swep_success.mp3"}

SWEP.Secondary.ClipSize         = 0
SWEP.Secondary.DefaultClip      = 0
SWEP.Secondary.Automatic        = false
SWEP.Secondary.Ammo             = "none"

SWEP.Primary.DisableBulletCode  = true
SWEP.PrimaryEffects_MuzzleAttachment = 0
SWEP.PrimaryEffects_SpawnShells = false

SWEP.DelayOnDeploy              = 10
SWEP.Droid_Coldown             = 100
SWEP.Droid_icon = Material("luna_icons/ammo-box.png", "noclamp smooth")

SWEP.HasIdleAnimation           = false

SWEP.Slot = 4
SWEP.SlotPos = 1

if CLIENT then
    net.Receive("reDroidCallingInSound1", function()
        surface.PlaySound("weapons/kaito/swep_success.mp3")
    end)
end

SWEP.Droid_Logic = function(self)
	self.Owner:ChatPrint("Na dany moment reset jest niemożliwy!");
end

local color_grayDarkner = Color(31, 31, 31)
local color_gray = Color(75, 75, 75)
local color_grayLighter = Color(92, 92, 92)
local color_yellow = Color(255, 255, 0)

-- function SWEP:DrawHUD()
-- 	local W, H = ScrW(), ScrH()
-- 	local wide, height = 33, 33
-- 	local _remap = math.Remap((self:GetNextPrimaryFire() - CurTime()) / self.Droid_Coldown, 0, 1, 1, 0)
-- 	local _barHeight = math.min(height * _remap, height)
-- 	draw.RoundedBox(0, 375 - 2, H - height - 21 - 2, wide + 4, height + 4, color_grayLighter)
-- 	draw.RoundedBox(0, 375, H - height - 21, wide, height, color_gray)

-- 	if self:GetNextPrimaryFire() < CurTime() then
-- 		draw.RoundedBox(0, 375, H - height - 21, wide, height, color_grayDarkner)
-- 	else
-- 		draw.RoundedBox(0, 375, H - height - 21, wide, _barHeight, color_grayDarkner)
-- 	end

-- 	surface.SetDrawColor(255, 255, 255, 255)
-- 	surface.SetMaterial(self.Droid_icon)
-- 	surface.DrawTexturedRect(377, H - height - 18, 28, 28)

-- 	local ply = LocalPlayer()

--     local x, y = ScrW()-1505, ScrH()-40
  
--     draw.ShadowSimpleText("ЛКМ - Вызов сброса припасов", "lunaMontMini", x, y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
--     draw.ShadowSimpleText("Внимательнее при выборе точки! Не убей своих.", "lunaMontMini", x, y+20, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
-- end

if not SERVER then return end

util.AddNetworkString("reDroidCallingInSound1")

function SWEP:Initialize()
    self:SetWeaponHoldType( self.HoldType )
end

-- function SWEP:PrimaryAttack()
--     local ply = self:GetOwner()

--     if ( not ply:IsValid() ) then return end
--     if CLIENT then return end

--     ply:LagCompensation( true )

--     local proj = ents.Create("obj_flareround")
--     if ( not proj:IsValid() ) then
--         print("Error")
--         ply:LagCompensation(false)
--         return
--     end

--     if (self:GetNextPrimaryFire() > CurTime()) then return end;
-- 	self:SetNextPrimaryFire(CurTime() + self.Droid_Coldown);
-- 	self.Droid_Logic(self);

-- 	local snd = self.Droid_Sound()
-- 	if snd and IsValid(self:GetOwner()) then
-- 		self:GetOwner():EmitSound(self.Droid_Sound(), 85, 100, 1, CHAN_WEAPON)
-- 	end

--     local ply_Ang = ply:GetAimVector():Angle()
--     local ply_Pos = ply:GetShootPos()
--     if ply:IsPlayer() then proj:SetPos(ply_Pos) end
--     if ply:IsPlayer() then proj:SetAngles(ply_Ang) end
--     proj:SetOwner(ply)
--     proj:Activate()
--     proj:Spawn()

--     local phys = proj:GetPhysicsObject()

--     if IsValid(phys) and ply:IsPlayer() then
--         phys:SetVelocity(ply:GetAimVector() * 500)
--     end

--     timer.Simple(5, function()
--         if not IsValid(proj) then return end
--         callDroidDrop(proj:GetPos())
--     end )
--     ply:ChatPrint("КНС Ивент: Посылка в пути, ожидайте.")
--     timer.Simple(1, function()
--         net.Start("reDroidCallingInSound1")
--         net.Send(ply)
--     end)

--     self:TakePrimaryAmmo(1)
--     self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

--     ply:LagCompensation(false)
-- end

function SWEP:PrimaryAttack()
    local ply = self:GetOwner()

    if ( not ply:IsValid() ) then return end
    if CLIENT then return end

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

    timer.Simple(5, function()
        if not IsValid(proj) then return end
        callDroidDrop(proj:GetPos())
    end )
    ply:ChatPrint("CIS Event: Przesyłka w drodze, proszę czekać.")
    timer.Simple(1, function()
        net.Start("reDroidCallingInSound1")
        net.Send(ply)
    end)

    self:TakePrimaryAmmo(1)
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

    ply:LagCompensation(false)
end

function callDroidDrop(dropPosition)
    local dropShip = ents.Create("dropshipcis")
    if (not dropShip:IsValid()) then return end

    dropShip:SetPos(dropPosition)
    dropShip:Spawn()
end

function SWEP:SecondaryAttack()
end



--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
