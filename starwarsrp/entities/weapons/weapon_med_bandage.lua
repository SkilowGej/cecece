AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Bandaż"
	SWEP.Slot = 4
	SWEP.SlotPos = 2
	SWEP.ViewModelFOV = 69
	SWEP.DrawCrosshair = true
	SWEP.DrawAmmo = true
end

SWEP.Author = "pack"
SWEP.Purpose = ""
SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix = "rpg"
SWEP.UseHands = true
SWEP.Category = "Piwnica Granie • Medycyna"
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.ViewModel = Model("models/craphead_scripts/paramedic_essentials/weapons/c_medpack.mdl")
SWEP.WorldModel = Model("models/craphead_scripts/paramedic_essentials/weapons/w_medpack.mdl")
SWEP.ShowWorldModel = false

-- SWEP.WElements = {
-- 	["reanimator"] = {
-- 		type = "Model",
-- 		model = "models/weapons/defib/w_eq_defibrillator.mdl",
-- 		bone = "ValveBiped.Bip01_R_Hand",
-- 		rel = "",
-- 		pos = Vector(1.557, 5.714, -1.558),
-- 		angle = Angle(-165.971, -73.322, -97.612),
-- 		size = Vector(1, 1, 1),
-- 		color = Color(255, 255, 255, 255),
-- 		surpresslightning = false,
-- 		material = "",
-- 		skin = 0,
-- 		bodygroup = {}
-- 	}
-- }

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

if CLIENT then
	local mat_resurrect = Material("luna_icons/ambulance.png", "smooth noclamp")
	local alpha, lerp_alpha = 0, 0
	local toggle = true

	function SWEP:DrawHUD()
		local w, h = ScrW(), ScrH()
		local icon_size = 100

		if self:GetIsDressing() then
			alpha = 190
		else
			alpha = 0
		end

		lerp_alpha = Lerp(FrameTime() * 10, lerp_alpha or 0, alpha or 0)
		local x, y, width, height = w / 2 - w / 10, h * .25, w / 5, h / 15
		local time = self:GetEndDressingTime() - self:GetStartDressingTime()
		local curtime = CurTime() - self:GetStartDressingTime()
		local status = math.Clamp(curtime / time, 0, 1)
		-- draw.DrawText("Реанимируем раненного бойца...", "font_base_54", w / 2, y + 60, ColorAlpha(COLOR_WHITE, lerp_alpha), 1, 1)
		-- surface.SetDrawColor(0, 180, 0, 230)
		-- draw.NoTexture()
		local cx, cy = ScrW() / 2, ScrH() / 2

		draw.Arc({
			x = cx,
			y = cy
		}, 0, 360, 100, 40, 100, ColorAlpha(COLOR_BG, lerp_alpha))

		draw.Arc({
			x = cx,
			y = cy
		}, 0, 360, 100, 40, 20, ColorAlpha(COLOR_BG, lerp_alpha))

		draw.Arc({
			x = cx,
			y = cy
		}, 0, status * 360, 100, 40, 20, ColorAlpha(Color(186,218,85), lerp_alpha))

		draw.Icon(cx - (icon_size / 2), cy - (icon_size / 2), icon_size, icon_size, mat_resurrect, ColorAlpha(COLOR_WHITE, lerp_alpha))
		start = SysTime()
	end
end

function SWEP:Initialize()
	self:SetHoldType("slam")
end

function SWEP:Deploy()
	self:SetHoldType("slam")
	self:GetOwner():GetViewModel():SetPlaybackRate(5)

	return true
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "IsDressing")
	self:NetworkVar("Float", 0, "StartDressingTime")
	self:NetworkVar("Float", 1, "EndDressingTime")
end

function SWEP:PrimaryAttack()
	if self:GetIsDressing() then return end

	if SERVER then
		local eTrace = self:GetOwner():GetEyeTrace().Entity

		if not eTrace or not IsValid(eTrace) then return end
		if not eTrace:IsPlayer() then return end

		self:SetStartDressingTime(CurTime())
		self:SetEndDressingTime(CurTime() + 4)
		self:SetIsDressing(true)

		self.TargetEnt = eTrace

		-- if eTrace:GetClass() == "prop_ragdoll" and (pPlayer and IsValid(pPlayer)) then
		-- 	if not self:GetOwner():Crouching() then
		-- 		self:GetOwner():ChatPrint("Необходимо присесть для реанимации!")

		-- 		return
		-- 	end

			-- self.TargetEnt = pPlayer
		-- 	self.TargetPos = eTrace:GetPos()
		-- 	self:SetStartDressingTime(CurTime())
		-- 	self:SetEndDressingTime(CurTime() + 4)
		-- 	self:SetIsDressing(true)
		-- elseif eTrace:IsPlayer() and IsValid(eTrace) then
		-- 	eTrace:TakeDamage(math.random(10))
		-- 	self:SetNextPrimaryFire(CurTime() + 6)
		-- elseif eTrace:GetClass() == "money_printer" then
		-- 	eTrace:TakeDamage(100)
		-- 	self:SetNextPrimaryFire(CurTime() + 6)
		-- end
	end

	-- self:EmitSound("ambient/energy/zap1.wav", 40)
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
end

function SWEP:EndDressing(target)

	target:RepairLeg()

	self:GetOwner():AddMoney(100)
	re.util.Notify("green", self:GetOwner(), "Wyleczyłeś złamanie! Republika nagradza takie działania, otrzymujesz 100 KR")

end

function SWEP:Think()
	if not SERVER then return end

	if self:GetIsDressing() then
		self:GetOwner():LagCompensation(true)
		local eTrace = self:GetOwner():GetEyeTrace().Entity
		self:GetOwner():LagCompensation(false)

		if not IsValid(self.TargetEnt) or eTrace ~= self.TargetEnt then
			self:SetIsDressing(false)

			return
		end

		-- if not self:GetOwner():Crouching() then
		-- 	self:GetOwner():ChatPrint("Необходимо присесть для реанимации!")
		-- 	self:SetIsDressing(false)

		-- 	return
		-- end

		if not self:GetOwner():KeyDown(IN_ATTACK) then
			re.util.Notify("red", self:GetOwner(), "Musisz przytrzymać lewy przycisk myszy!")
			self:SetIsDressing(false)

			return
		end

		if self:GetEndDressingTime() <= CurTime() then
			self:EndDressing(self.TargetEnt)
			self:SetIsDressing(false)
		end
	end
end

-- if CLIENT then
-- 	local WorldModel = ClientsideModel(SWEP.WorldModel)
-- 	-- Settings...
-- 	WorldModel:SetNoDraw(true)

-- 	function SWEP:DrawWorldModel()
-- 		local _Owner = self:GetOwner()

-- 		if IsValid(_Owner) then
-- 			-- Specify a good position
-- 			local offsetVec = Vector(-10, -4, -1)
-- 			local offsetAng = Angle(0, 0, 180)
-- 			local boneid = _Owner:LookupBone("ValveBiped.Bip01_R_Hand") -- Right Hand
-- 			if not boneid then return end
-- 			local matrix = _Owner:GetBoneMatrix(boneid)
-- 			if not matrix then return end
-- 			local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())
-- 			WorldModel:SetPos(newPos)
-- 			WorldModel:SetAngles(newAng)
-- 			WorldModel:SetupBones()
-- 		else
-- 			WorldModel:SetPos(self:GetPos())
-- 			WorldModel:SetAngles(self:GetAngles())
-- 		end

-- 		WorldModel:DrawModel()
-- 	end
-- end