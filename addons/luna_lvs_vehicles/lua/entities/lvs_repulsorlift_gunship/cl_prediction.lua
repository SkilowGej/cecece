--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


function ENT:PredictBTL()
	local pod = self:GetBTPodL()

	if not IsValid( pod ) then return end

	local plyL = LocalPlayer()
	local ply = pod:GetDriver()

	if ply ~= plyL then return end

	self:SetPosBTL()
	self:SetPoseParameterBTL( pod:lvsGetWeapon() )
end

function ENT:PredictBTR()
	local pod = self:GetBTPodR()

	if not IsValid( pod ) then return end

	local plyL = LocalPlayer()
	local ply = pod:GetDriver()

	if ply ~= plyL then return end

	self:SetPosBTR()
	self:SetPoseParameterBTR( pod:lvsGetWeapon() )
end

function ENT:PredictPoseParamaters()
	self:PredictBTL()
	self:PredictBTR()

	self:InvalidateBoneCache()
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
