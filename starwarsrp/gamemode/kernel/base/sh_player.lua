local pmeta = FindMetaTable("Player")

pmeta.SteamName = pmeta.SteamName or pmeta.Nick
pmeta.OldName = pmeta.OldName or pmeta.Name

function pmeta:Name()
    if not IsValid(self) then
        return "Invalid Player"
    end

    local rpname = self:GetNWString("rpname", "")
    local rpid = self:GetRPID()
    local rating = self:GetNWString('rating', '')

	-- local cp_rpname = self:GetNWString( "cp_rpname" )

	-- if cp_rpname then
	-- 	local tm = self:Team()
	-- 	if tm and TEAMS_CP_PREFIXES and TEAMS_CP_PREFIXES[tm] then
	-- 		local cp_refix = TEAMS_CP_PREFIXES[tm]

	-- 		if cp_rpname ~= '' and cp_refix then
	-- 			return string.format(cp_refix, team.GetName(tm), cp_rpname)
	-- 		end
	-- 	end
	-- end

	-- if CLIENT and LocalPlayer():IsAdmin() then
	-- 	return (rpname or self:OldName()) .. (self:GetRPID() ~= '' and ' ['..self:GetRPID()..']' or '')
	-- end

	-- return self:OldName()

	if self:Team() == TEAM_SPECTATOR or self:Team() == TEAM_UNASSIGNED then
		return self:OldName()	
	end

	if not rpname or rpname == '' then
		return self:OldName()
	end

	-- if not HIDE_NICKS_RATINGS[rating] then
	-- 	return rpname or self:OldName()
	-- end

	-- return rpid ~= '' and tostring(rpid) or rpname


	-- return (not rpid or rpid == '') and (tostring(rpid) or self:OldName() or rpname) or rpname
	-- return tostring(rpid ~= '' and HIDE_NICKS_RATINGS[rating] and rpid or (rpname or self:OldName()))

	return rpid ~= '' and (rpid .. ' ' .. rpname) or rpname
end
pmeta.GetName = pmeta.Name
pmeta.Nick = pmeta.Name

function pmeta:GetRPID()
	local job = re.jobs[self:Team()]
	if job and job.Type == TYPE_CLONE then
		return self:GetNWString('rpid')
	end

	return ''
end

function pmeta:NameWithSteamID()
	local name = self:Name() or self:OldName()
	return name..'('..self:SteamID()..')'
end

function pmeta:GetMoney()
	return self:GetNetVar('money')
end

function pmeta:isEnoughMoney(intCount)
	return tonumber(self:GetMoney()) >= tonumber(intCount)
end

function GM:PlayerShouldTaunt(pl, actid) return true end
function GM:CanTool(pl, trace, mode) return pl:IsAdmin() end

hook.Add("ShouldCollide", "SpawnPoints_ShouldCollide", function( ent1, ent2 )
    -- print(ent1, ent2)
    if IsValid( ent1 ) and IsValid( ent2 )  then
        if (ent1:IsPlayer() and ent2:GetClass() == 'spawn_point') or (ent2:IsPlayer() and ent1:GetClass() == 'spawn_point') then
            return false
        end
        
        if ent1:GetClass() == 'prop_ragdoll' or ent2:GetClass() == 'prop_ragdoll' then
            return false
        end
    end

    -- We must call this because anything else should return true.
    return true
end)