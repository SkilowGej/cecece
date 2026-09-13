AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Defibrylator"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
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
SWEP.ViewModel = "models/craphead_scripts/paramedic_essentials/weapons/c_defibrilator.mdl"
SWEP.WorldModel = "models/craphead_scripts/paramedic_essentials/weapons/w_defibrilator.mdl"
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

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

local REVIVE_TIME = 4
local NO_COLLISION_DURATION = 4

if CLIENT then
	-- function draw.drawSubSection(x, y, r, r2, startAng, endAng, step, cache)
	--     local positions = {}
	--     local inner = {}
	--     local outer = {}
	--     r2 = r+r2
	--     startAng = startAng or 0
	--     endAng = endAng or 0
	--     for i = startAng - 90, endAng - 90, step do
	--         table.insert(inner, {
	--             x = math.ceil(x + math.cos(math.rad(i)) * r2),
	--             y = math.ceil(y + math.sin(math.rad(i)) * r2)
	--         })
	--     end
	--     for i = startAng - 90, endAng - 90, step do
	--         table.insert(outer, {
	--             x = math.ceil(x + math.cos(math.rad(i)) * r),
	--             y = math.ceil(y + math.sin(math.rad(i)) * r)
	--         })
	--     end
	--     for i = 1, #inner * 2 do
	--         local outPoints = outer[math.floor(i / 2) + 1]
	--         local inPoints = inner[math.floor((i + 1) / 2) + 1]
	--         local otherPoints
	--         if i % 2 == 0 then
	--             otherPoints = outer[math.floor((i + 1) / 2)]
	--         else
	--             otherPoints = inner[math.floor((i + 1) / 2)]
	--         end
	--         table.insert(positions, {outPoints, otherPoints, inPoints})
	--     end
	--     if cache then
	--         return positions
	--     else
	--         for k,v in pairs(positions) do 
	--             surface.DrawPoly(v)
	--         end
	--     end
	-- end
	function SWEP:GetViewModelPosition(Pos, Ang)
		--Ang:RotateAroundAxis(Ang:Forward(), 90);
		--Pos = Pos + Ang:Forward() * 3;
		-- Pos = Pos + Ang:Up() * 6;
		return Pos, Ang
	end

	local mat_resurrect = Material("luna_ui_base/etc/resurrect.png", "noclamp")
	local alpha, lerp_alpha = 0, 0
	local toggle = true

	function SWEP:DrawHUD()
		local w, h = ScrW(), ScrH()
		local icon_size = 180

		if self:GetIsReanimate() then
			alpha = 190
		else
			alpha = 0
		end

		lerp_alpha = Lerp(FrameTime() * 10, lerp_alpha or 0, alpha or 0)
		local x, y, width, height = w / 2 - w / 10, h * .25, w / 5, h / 15
		local time = self:GetEndReanimateTime() - self:GetStartReanimateTime()
		local curtime = CurTime() - self:GetStartReanimateTime()
		local status = math.Clamp(curtime / time, 0, 1)
		-- draw.DrawText("Реанимируем раненного бойца...", luna.MontBase54, w / 2, y + 60, ColorAlpha(COLOR_WHITE, lerp_alpha), 1, 1)
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
		}, 0, status * 360, 100, 40, 20, ColorAlpha(COLOR_HOVER, lerp_alpha))

		draw.Icon(cx - (icon_size / 2), cy - (icon_size / 2), icon_size, icon_size, mat_resurrect, ColorAlpha(COLOR_WHITE, lerp_alpha))
		start = SysTime()
	end
end

function SWEP:Initialize()
	self:SetHoldType("dual")
end

function SWEP:Deploy()
	self:SetHoldType("dual")
	self:GetOwner():GetViewModel():SetPlaybackRate(5)

	return true
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "IsReanimate")
	self:NetworkVar("Float", 0, "StartReanimateTime")
	self:NetworkVar("Float", 1, "EndReanimateTime")
end

function SWEP:PrimaryAttack()
	if self:GetIsReanimate() then return end

	if SERVER then
		local eTrace = self:GetOwner():GetEyeTrace().Entity
		local pPlayer = eTrace.player

		if eTrace:GetClass() == "prop_ragdoll" and (pPlayer and IsValid(pPlayer)) then
			if not self:GetOwner():Crouching() then
				self:GetOwner():ChatPrint("Musisz kucnąć, aby przeprowadzić reanimację!")
				return
			end

			self.TargetEnt = pPlayer
			self.TargetPos = eTrace:GetPos()
			self:SetStartReanimateTime(CurTime())
			self:SetEndReanimateTime(CurTime() + REVIVE_TIME)
			self:SetIsReanimate(true)
		elseif eTrace:IsPlayer() and IsValid(eTrace) then
			eTrace:TakeDamage(math.random(10))
			self:SetNextPrimaryFire(CurTime() + 6)
		elseif eTrace:GetClass() == "money_printer" then
			eTrace:TakeDamage(100)
			self:SetNextPrimaryFire(CurTime() + 6)
		end
	end

	self:EmitSound("ambient/energy/zap1.wav", 40)
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
end

function SWEP:DisableCollision(ply)
	ply:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	timer.Simple(NO_COLLISION_DURATION, function()
		if IsValid(ply) then
			ply:SetCollisionGroup(COLLISION_GROUP_PLAYER)
		end
	end)
end

function SWEP:Reanimate(target, pos)
	target:Spawn()
	target:SetPos(pos)

	for _, strWep in pairs(target.OldWeapons) do
		target:Give(strWep)
	end

	self:DisableCollision(target)

	self:GetOwner():AddMoney(150)
	self:SetNextPrimaryFire(CurTime() + 6)
	re.util.Notify("green", self:GetOwner(), "Przywróciliście do życia rannego żołnierza! Republika zachęca do takich działań, otrzymajcie 150 KR.")
end

function SWEP:Think()
	if not SERVER then return end

	if self:GetIsReanimate() then
		self:GetOwner():LagCompensation(true)
		local target_entity = self:GetOwner():GetEyeTrace().Entity
		self:GetOwner():LagCompensation(false)

		if not IsValid(self.TargetEnt) or target_entity.player ~= self.TargetEnt then
			self:SetIsReanimate(false)
			return
		end

		if not self:GetOwner():Crouching() then
			re.util.Notify("red", self:GetOwner(), "Należy usiąść, aby przeprowadzić resuscytację!")
			self:SetIsReanimate(false)
			return
		end

		if not self:GetOwner():KeyDown(IN_ATTACK) then
			re.util.Notify("red", self:GetOwner(), "Należy przytrzymać LPM!")
			self:SetIsReanimate(false)
			return
		end

		if self:GetEndReanimateTime() <= CurTime() then
			self:Reanimate(self.TargetEnt, self.TargetPos)
			self:SetIsReanimate(false)
		end
	end
end

function SWEP:Think()
	if not SERVER then return end

	if self:GetIsReanimate() then
		self:GetOwner():LagCompensation(true)
		local target_entity = self:GetOwner():GetEyeTrace().Entity
		self:GetOwner():LagCompensation(false)

		if not IsValid(self.TargetEnt) or target_entity.player ~= self.TargetEnt then
			self:SetIsReanimate(false)

			return
		end

		if not self:GetOwner():Crouching() then
			re.util.Notify("red", self:GetOwner(), "Należy usiąść, aby przeprowadzić resuscytację!")
			self:SetIsReanimate(false)

			return
		end

		if not self:GetOwner():KeyDown(IN_ATTACK) then
			re.util.Notify("red", self:GetOwner(), "Należy przytrzymać LPM!")
			self:SetIsReanimate(false)

			return
		end

		if self:GetEndReanimateTime() <= CurTime() then
			self:Reanimate(self.TargetEnt, self.TargetPos)
			self:SetIsReanimate(false)
		end
	end
end

function SWEP:PreDrawViewModel(vm, pl, wep)
	return false
end

--[[*******************************************************
    SWEP Construction Kit base code
        Created by Clavus
    Available for public use, thread at:
       facepunch.com/threads/1032378
       
       
    DESCRIPTION:
        This script is meant for experienced scripters 
        that KNOW WHAT THEY ARE DOING. Don"t come to me 
        with basic Lua questions.
        
        Just copy into your SWEP or SWEP base of choice
        and merge with your own code.
        
        The SWEP.VElements, SWEP.WElements and
        SWEP.ViewModelBoneMods tables are all optional
        and only have to be visible to the client.
*******************************************************]]
-- function SWEP:Initialize()
-- 	-- other initialize code goes here
-- 	self:SetHoldType("shotgun")

-- 	if CLIENT then
-- 		-- Create a new table for every weapon instance
-- 		self.VElements = table.FullCopy(self.VElements)
-- 		self.WElements = table.FullCopy(self.WElements)
-- 		self.ViewModelBoneMods = table.FullCopy(self.ViewModelBoneMods)
-- 		self:CreateModels(self.VElements) -- create viewmodels
-- 		self:CreateModels(self.WElements) -- create worldmodels

-- 		-- init view model bone build function
-- 		if IsValid(self:GetOwner()) then
-- 			local vm = self:GetOwner():GetViewModel()

-- 			if IsValid(vm) then
-- 				self:ResetBonePositions(vm)

-- 				-- Init viewmodel visibility
-- 				if self.ShowViewModel == nil or self.ShowViewModel then
-- 					vm:SetColor(Color(255, 255, 255, 255))
-- 				else
-- 					-- we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
-- 					vm:SetColor(Color(255, 255, 255, 1))
-- 					-- ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
-- 					-- however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
-- 					vm:SetMaterial("Debug/hsv")
-- 				end
-- 			end
-- 		end
-- 	end
-- end

-- function SWEP:Holster()
-- 	if CLIENT and IsValid(self:GetOwner()) then
-- 		local vm = self:GetOwner():GetViewModel()

-- 		if IsValid(vm) then
-- 			self:ResetBonePositions(vm)
-- 		end
-- 	end

-- 	return true
-- end

-- function SWEP:OnRemove()
-- 	self:Holster()
-- end

-- if CLIENT then
-- 	SWEP.vRenderOrder = nil

-- 	function SWEP:ViewModelDrawn()
-- 		local vm = self:GetOwner():GetViewModel()
-- 		if not IsValid(vm) then return end
-- 		if not self.VElements then return end
-- 		self:UpdateBonePositions(vm)

-- 		if not self.vRenderOrder then
-- 			-- we build a render order because sprites need to be drawn after models
-- 			self.vRenderOrder = {}

-- 			for k, v in pairs(self.VElements) do
-- 				if v.type == "Model" then
-- 					table.insert(self.vRenderOrder, 1, k)
-- 				elseif v.type == "Sprite" or v.type == "Quad" then
-- 					table.insert(self.vRenderOrder, k)
-- 				end
-- 			end
-- 		end

-- 		for k, name in ipairs(self.vRenderOrder) do
-- 			local v = self.VElements[name]

-- 			if not v then
-- 				self.vRenderOrder = nil
-- 				break
-- 			end

-- 			if v.hide then continue end
-- 			local model = v.modelEnt
-- 			local sprite = v.spriteMaterial
-- 			if not v.bone then continue end
-- 			local pos, ang = self:GetBoneOrientation(self.VElements, v, vm)
-- 			if not pos then continue end

-- 			if v.type == "Model" and IsValid(model) then
-- 				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
-- 				ang:RotateAroundAxis(ang:Up(), v.angle.y)
-- 				ang:RotateAroundAxis(ang:Right(), v.angle.p)
-- 				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
-- 				model:SetAngles(ang)
-- 				--model:SetModelScale(v.size)
-- 				local matrix = Matrix()
-- 				matrix:Scale(v.size)
-- 				model:EnableMatrix("RenderMultiply", matrix)

-- 				if v.material == "" then
-- 					model:SetMaterial("")
-- 				elseif model:GetMaterial() ~= v.material then
-- 					model:SetMaterial(v.material)
-- 				end

-- 				if v.skin and v.skin ~= model:GetSkin() then
-- 					model:SetSkin(v.skin)
-- 				end

-- 				if v.bodygroup then
-- 					for k, v in pairs(v.bodygroup) do
-- 						if model:GetBodygroup(k) ~= v then
-- 							model:SetBodygroup(k, v)
-- 						end
-- 					end
-- 				end

-- 				if v.surpresslightning then
-- 					render.SuppressEngineLighting(true)
-- 				end

-- 				render.SetColorModulation(v.color.r / 255, v.color.g / 255, v.color.b / 255)
-- 				render.SetBlend(v.color.a / 255)
-- 				model:DrawModel()
-- 				render.SetBlend(1)
-- 				render.SetColorModulation(1, 1, 1)

-- 				if v.surpresslightning then
-- 					render.SuppressEngineLighting(false)
-- 				end
-- 			elseif v.type == "Sprite" and sprite then
-- 				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
-- 				render.SetMaterial(sprite)
-- 				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
-- 			elseif v.type == "Quad" and v.draw_func then
-- 				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
-- 				ang:RotateAroundAxis(ang:Up(), v.angle.y)
-- 				ang:RotateAroundAxis(ang:Right(), v.angle.p)
-- 				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
-- 				cam.Start3D2D(drawpos, ang, v.size)
-- 				v.draw_func(self)
-- 				cam.End3D2D()
-- 			end
-- 		end
-- 	end

-- 	SWEP.wRenderOrder = nil

-- 	function SWEP:DrawWorldModel()
-- 		if self.ShowWorldModel == nil or self.ShowWorldModel then
-- 			self:DrawModel()
-- 		end

-- 		if not self.WElements then return end

-- 		if not self.wRenderOrder then
-- 			self.wRenderOrder = {}

-- 			for k, v in pairs(self.WElements) do
-- 				if v.type == "Model" then
-- 					table.insert(self.wRenderOrder, 1, k)
-- 				elseif v.type == "Sprite" or v.type == "Quad" then
-- 					table.insert(self.wRenderOrder, k)
-- 				end
-- 			end
-- 		end

-- 		if IsValid(self:GetOwner()) then
-- 			bone_ent = self:GetOwner()
-- 		else
-- 			-- when the weapon is dropped
-- 			bone_ent = self
-- 		end

-- 		for k, name in pairs(self.wRenderOrder) do
-- 			local v = self.WElements[name]

-- 			if not v then
-- 				self.wRenderOrder = nil
-- 				break
-- 			end

-- 			if v.hide then continue end
-- 			local pos, ang

-- 			if v.bone then
-- 				pos, ang = self:GetBoneOrientation(self.WElements, v, bone_ent)
-- 			else
-- 				pos, ang = self:GetBoneOrientation(self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand")
-- 			end

-- 			if not pos then continue end
-- 			local model = v.modelEnt
-- 			local sprite = v.spriteMaterial

-- 			if v.type == "Model" and IsValid(model) then
-- 				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
-- 				ang:RotateAroundAxis(ang:Up(), v.angle.y)
-- 				ang:RotateAroundAxis(ang:Right(), v.angle.p)
-- 				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
-- 				model:SetAngles(ang)
-- 				--model:SetModelScale(v.size)
-- 				local matrix = Matrix()
-- 				matrix:Scale(v.size)
-- 				model:EnableMatrix("RenderMultiply", matrix)

-- 				if v.material == "" then
-- 					model:SetMaterial("")
-- 				elseif model:GetMaterial() ~= v.material then
-- 					model:SetMaterial(v.material)
-- 				end

-- 				if v.skin and v.skin ~= model:GetSkin() then
-- 					model:SetSkin(v.skin)
-- 				end

-- 				if v.bodygroup then
-- 					for k, v in pairs(v.bodygroup) do
-- 						if model:GetBodygroup(k) ~= v then
-- 							model:SetBodygroup(k, v)
-- 						end
-- 					end
-- 				end

-- 				if v.surpresslightning then
-- 					render.SuppressEngineLighting(true)
-- 				end

-- 				render.SetColorModulation(v.color.r / 255, v.color.g / 255, v.color.b / 255)
-- 				render.SetBlend(v.color.a / 255)
-- 				model:DrawModel()
-- 				render.SetBlend(1)
-- 				render.SetColorModulation(1, 1, 1)

-- 				if v.surpresslightning then
-- 					render.SuppressEngineLighting(false)
-- 				end
-- 			elseif v.type == "Sprite" and sprite then
-- 				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
-- 				render.SetMaterial(sprite)
-- 				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
-- 			elseif v.type == "Quad" and v.draw_func then
-- 				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
-- 				ang:RotateAroundAxis(ang:Up(), v.angle.y)
-- 				ang:RotateAroundAxis(ang:Right(), v.angle.p)
-- 				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
-- 				cam.Start3D2D(drawpos, ang, v.size)
-- 				v.draw_func(self)
-- 				cam.End3D2D()
-- 			end
-- 		end
-- 	end

-- 	function SWEP:GetBoneOrientation(basetab, tab, ent, bone_override)
-- 		local bone, pos, ang

-- 		if tab.rel and tab.rel ~= "" then
-- 			local v = basetab[tab.rel]
-- 			if not v then return end
-- 			-- Technically, if there exists an element with the same name as a bone
-- 			-- you can get in an infinite loop. Let"s just hope nobody"s that stupid.
-- 			pos, ang = self:GetBoneOrientation(basetab, v, ent)
-- 			if not pos then return end
-- 			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
-- 			ang:RotateAroundAxis(ang:Up(), v.angle.y)
-- 			ang:RotateAroundAxis(ang:Right(), v.angle.p)
-- 			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
-- 		else
-- 			bone = ent:LookupBone(bone_override or tab.bone)
-- 			if not bone then return end
-- 			pos, ang = Vector(0, 0, 0), Angle(0, 0, 0)
-- 			local m = ent:GetBoneMatrix(bone)

-- 			if m then
-- 				pos, ang = m:GetTranslation(), m:GetAngles()
-- 			end

-- 			if IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() and ent == self:GetOwner():GetViewModel() and self.ViewModelFlip then
-- 				ang.r = -ang.r -- Fixes mirrored models
-- 			end
-- 		end

-- 		return pos, ang
-- 	end

-- 	function SWEP:CreateModels(tab)
-- 		if not tab then return end

-- 		-- Create the clientside models here because Garry says we can"t do it in the render hook
-- 		for k, v in pairs(tab) do
-- 			if v.type == "Model" and v.model and v.model ~= "" and (not IsValid(v.modelEnt) or v.createdModel ~= v.model) and string.find(v.model, ".mdl") and file.Exists(v.model, "GAME") then
-- 				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)

-- 				if IsValid(v.modelEnt) then
-- 					v.modelEnt:SetPos(self:GetPos())
-- 					v.modelEnt:SetAngles(self:GetAngles())
-- 					v.modelEnt:SetParent(self)
-- 					v.modelEnt:SetNoDraw(true)
-- 					v.createdModel = v.model
-- 				else
-- 					v.modelEnt = nil
-- 				end
-- 			elseif v.type == "Sprite" and v.sprite and v.sprite ~= "" and (not v.spriteMaterial or v.createdSprite ~= v.sprite) and file.Exists("materials/" .. v.sprite .. ".vmt", "GAME") then
-- 				local name = v.sprite .. "-"

-- 				local params = {
-- 					["$basetexture"] = v.sprite
-- 				}

-- 				-- make sure we create a unique name based on the selected options
-- 				local tocheck = {"nocull", "additive", "vertexalpha", "vertexcolor", "ignorez"}

-- 				for i, j in pairs(tocheck) do
-- 					if v[j] then
-- 						params["$" .. j] = 1
-- 						name = name .. "1"
-- 					else
-- 						name = name .. "0"
-- 					end
-- 				end

-- 				v.createdSprite = v.sprite
-- 				v.spriteMaterial = CreateMaterial(name, "UnlitGeneric", params)
-- 			end
-- 		end
-- 	end

-- 	local allbones
-- 	local hasGarryFixedBoneScalingYet = false

-- 	function SWEP:UpdateBonePositions(vm)
-- 		if self.ViewModelBoneMods then
-- 			if not vm:GetBoneCount() then return end
-- 			-- !! WORKAROUND !! //
-- 			-- We need to check all model names :/
-- 			local loopthrough = self.ViewModelBoneMods

-- 			if not hasGarryFixedBoneScalingYet then
-- 				allbones = {}

-- 				for i = 0, vm:GetBoneCount() do
-- 					local bonename = vm:GetBoneName(i)

-- 					if self.ViewModelBoneMods[bonename] then
-- 						allbones[bonename] = self.ViewModelBoneMods[bonename]
-- 					else
-- 						allbones[bonename] = {
-- 							scale = Vector(1, 1, 1),
-- 							pos = Vector(0, 0, 0),
-- 							angle = Angle(0, 0, 0)
-- 						}
-- 					end
-- 				end

-- 				loopthrough = allbones
-- 			end

-- 			-- !! ----------- !! //
-- 			for k, v in pairs(loopthrough) do
-- 				local bone = vm:LookupBone(k)
-- 				if not bone then continue end
-- 				-- !! WORKAROUND !! //
-- 				local s = Vector(v.scale.x, v.scale.y, v.scale.z)
-- 				local p = Vector(v.pos.x, v.pos.y, v.pos.z)
-- 				local ms = Vector(1, 1, 1)

-- 				if not hasGarryFixedBoneScalingYet then
-- 					local cur = vm:GetBoneParent(bone)

-- 					while cur >= 0 do
-- 						local pscale = loopthrough[vm:GetBoneName(cur)].scale
-- 						ms = ms * pscale
-- 						cur = vm:GetBoneParent(cur)
-- 					end
-- 				end

-- 				s = s * ms

-- 				-- !! ----------- !! //
-- 				if vm:GetManipulateBoneScale(bone) ~= s then
-- 					vm:ManipulateBoneScale(bone, s)
-- 				end

-- 				if vm:GetManipulateBoneAngles(bone) ~= v.angle then
-- 					vm:ManipulateBoneAngles(bone, v.angle)
-- 				end

-- 				if vm:GetManipulateBonePosition(bone) ~= p then
-- 					vm:ManipulateBonePosition(bone, p)
-- 				end
-- 			end
-- 		else
-- 			self:ResetBonePositions(vm)
-- 		end
-- 	end

-- 	function SWEP:ResetBonePositions(vm)
-- 		if not vm:GetBoneCount() then return end

-- 		for i = 0, vm:GetBoneCount() do
-- 			vm:ManipulateBoneScale(i, Vector(1, 1, 1))
-- 			vm:ManipulateBoneAngles(i, Angle(0, 0, 0))
-- 			vm:ManipulateBonePosition(i, Vector(0, 0, 0))
-- 		end
-- 	end

-- 	--[[*************************
--         Global utility code
--     *************************]]
-- 	-- Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
-- 	-- Does not copy entities of course, only copies their reference.
-- 	-- WARNING: do not use on tables that contain themselves somewhere down the line or you"ll get an infinite loop
-- 	function table.FullCopy(tab)
-- 		if not tab then return nil end
-- 		local res = {}

-- 		for k, v in pairs(tab) do
-- 			if type(v) == "table" then
-- 				res[k] = table.FullCopy(v) -- recursion ho!
-- 			elseif type(v) == "Vector" then
-- 				res[k] = Vector(v.x, v.y, v.z)
-- 			elseif type(v) == "Angle" then
-- 				res[k] = Angle(v.p, v.y, v.r)
-- 			else
-- 				res[k] = v
-- 			end
-- 		end

-- 		return res
-- 	end
-- end