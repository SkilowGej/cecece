local plys = {}
local dropped = {}

local string_lower = string.lower
local net_ReadHeader = net.ReadHeader
local util_NetworkIDToString = util.NetworkIDToString

local LIMIT = 300

local function drop(client)
	dropped[client] = true
	
	local i = net_ReadHeader()
	local strName = util_NetworkIDToString(i)
	
	local log = string.format('%s FLOOD: %s <%s> %s', os.date('[%d.%m.%y - %H:%M]'), client:GetName(), client:SteamID(), strName and ('"' .. strName .. '"') or '')
	file.Append('net_logs.txt', log .. '\n')
	print(log)
	client:Kick('GG')
end

local function error_handler(err)
	print(debug.traceback(err))
end

function net.Incoming(len, client)
	if dropped[client] then return end
	
	local id = client:UserID()
	plys[id] = plys[id] or {}
	
	if plys[id][1] then 
		if SysTime() - plys[id][1] >= 1 then
			plys[id] = {}
		else
			plys[id][2] = plys[id][2] + 1
			
			if plys[id][2] >= LIMIT then 
				drop(client)
				plys[id] = {}
				return
			end
		end
	elseif plys[id][3] and plys[id][3] > 5 then
		drop(client)
		plys[id] = {}
		return
	else
		plys[id] = {SysTime(), 1}
	end
	
	local i = net_ReadHeader()
	local strName = util_NetworkIDToString(i)
		
	if not strName then 
		return 
	end
		
	local func = net.Receivers[string_lower(strName)]
	
	if not func then 
		return 
	end
	
	len = len - 16
	
	if not xpcall(func, error_handler, len, client) then 
		plys[id][3] = (plys[id][3] or 0) + 1
	end
end