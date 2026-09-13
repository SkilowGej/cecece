function pMeta:GetCharLevel()
	return self:GetNetVar("level", 0) or 0
end

function pMeta:GetCharExperience()
	return self:GetNetVar("experience", 0) or 0
end

function pMeta:CharLevelToExperience(intLevel)
	return (intLevel ^ 1.25) * 1000
end

function pMeta:GetCharNeedExperience()
	return self:CharLevelToExperience(self:GetCharLevel())
end

function pMeta:CharHasLevel(num)
	return tonumber(self:GetCharLevel()) >= num
end