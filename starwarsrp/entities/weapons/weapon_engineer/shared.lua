--[[--------------------------------------------
            DO NOT EDIT BELOW THIS LINE
--------------------------------------------]]
--
if (SERVER) then
    AddCSLuaFile()
end

-- Swep info
SWEP.PrintName = "Narzędzie"
SWEP.Author = ""
SWEP.Instructions = ""
SWEP.Contact = ""
SWEP.Purpose = ""
-- Spawnable
SWEP.AdminSpawnable = true
SWEP.Spawnable = true
-- Model
SWEP.ViewModel = Model("models/galactic/repairtool/v_repairtool.mdl")
SWEP.WorldModel = Model("models/galactic/repairtool/w_repairtool.mdl")
SWEP.UseHands = true

-- Client info
if (CLIENT) then
    SWEP.Category = "Piwnica Granie • Różne"
    SWEP.Slot = 4
    SWEP.SlotPos = 2
    SWEP.ViewModelFOV = 69
    SWEP.DrawCrosshair = true
    SWEP.DrawAmmo = true
end

-- Primary attack info
SWEP.Primary.Ammo = "None"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Delay = 2
SWEP.Primary.Automatic = false
-- Secondary attack info
SWEP.Secondary.Ammo = "None"
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.ClipSize = -1

-- Weapon 
function SWEP:Initialize()
    self.lastPrimaryFire = CurTime()
end

function SWEP:Deploy()
    self:SetHoldType("pistol")

    return true
end

-- if CLIENT then
--     local WorldModel = ClientsideModel(SWEP.WorldModel)

--     -- Settings...
--     WorldModel:SetNoDraw(true)

--     function SWEP:DrawWorldModel()
--         local _Owner = self:GetOwner()

--         if (IsValid(_Owner)) then
--             -- Specify a good position
--             local offsetVec = Vector(-15, -6, -12)
--             local offsetAng = Angle(0, 0, 180)
            
--             local boneid = _Owner:LookupBone("ValveBiped.Bip01_R_Hand") -- Right Hand
--             if !boneid then return end

--             local matrix = _Owner:GetBoneMatrix(boneid)
--             if !matrix then return end

--             local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())

--             WorldModel:SetPos(newPos)
--             WorldModel:SetAngles(newAng)

--             WorldModel:SetupBones()
--         else
--             WorldModel:SetPos(self:GetPos())
--             WorldModel:SetAngles(self:GetAngles())
--         end

--         WorldModel:DrawModel()
--     end
-- end