function pMeta:GetCharData(key)
	local data = self:GetNetVar("data")
	if key then
		if not istable(data[key]) then return false end
		return data[key]
	end
	return data
end