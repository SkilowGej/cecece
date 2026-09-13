local indexnum = 1
function re.util.addjob(strName, tblTeam)
    indexnum = indexnum + 1

    team.SetUp( indexnum, strName, tblTeam.Color )
    -- print(strName..' - '..indexnum)
    -- print(team.GetName(indexnum))
	tblTeam['index'] = indexnum
	tblTeam.Name = strName or ''
	table.insert( re.jobs, indexnum,  tblTeam )

	local models = tblTeam.WorldModel

	if SERVER and models then
		if istable(models) then
			for k,v in pairs(models) do
				util.PrecacheModel(v)
			end
		else
			util.PrecacheModel(models)
		end
	end

	return indexnum
end

function FindJob(index)
	return re.jobs[index] or false
end

function FindJobByID(strID)
	for _, tblJob in pairs(re.jobs) do
		if tblJob.jobID == strID then
			return tblJob
		end
	end
end

function isMaxPlayers(index)
	local maxPlayers = FindJob(index).maxPlayers or 0
	if maxPlayers and (maxPlayers == 0 or maxPlayers == nil)  then
		return true
	end
	return maxPlayers > #team.GetPlayers(index)
end