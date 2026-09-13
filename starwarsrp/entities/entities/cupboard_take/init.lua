AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel('models/props_furniture/scifi_closet.mdl')
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetModelScale(0.7)
	self.ProtalVector = false
	-- Wake the physics object up
	local phys = self.Entity:GetPhysicsObject()

	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Wake()
	end
end

function ENT:AcceptInput(inputName, pPlayer)
	if (pPlayer.nextUse or 0) >= CurTime() then return end
	pPlayer.nextUse = CurTime() + 1

	if re.jobs[pPlayer:Team()].Type == TYPE_CLONE then
		netstream.Start(pPlayer, "Cupboard_OpenMenu", {
			ent_index = self:EntIndex()
		})
	end
	-- for _, wep in pairs(re.jobs[pPlayer:Team()].weapons) do
	--     pPlayer:Give(wep)
	-- end
	-- local team = re.jobs[pPlayer:Team()]
	-- local rating = pPlayer:GetNWString("rating")
	-- local feature_weapons = {}
	-- if rating then
	--     feature_weapons = (team.FeatureRatings and team.FeatureRatings[rating].weapons) and team.FeatureRatings[rating].weapons or {}
	-- end
	-- -- print(feature_weapons)
	-- -- PrintTable(feature_weapons)
	-- for _, wep in pairs(feature_weapons) do
	-- 	pPlayer:Give(wep)
	-- end
end

netstream.Hook("Cupboard_TakeModel", function(pPlayer, data)
	local name = data.name
	local feat = FEATURE_ARMORMODELS[name] or false

	if feat and feat.check(pPlayer) == true then
		local model = feat.model

		if model and pPlayer and IsValid(pPlayer) then
			pPlayer.oldModel = pPlayer:GetModel()
			pPlayer:SetModel(model)
			-- pPlayer:SetNetVar("model", model)
		end
	end
end)

netstream.Hook("Cupboard_TakeOffModel", function(pPlayer, data)
	for key, feat in pairs(FEATURE_ARMORMODELS) do
		if feat.model == pPlayer:GetModel() then
			local model = pPlayer:GetNetVar("model")

			if model and pPlayer and IsValid(pPlayer) then
				pPlayer:SetModel(model)
				-- pPlayer:SetNetVar("model", model)
			end

			break
		end
	end
end)