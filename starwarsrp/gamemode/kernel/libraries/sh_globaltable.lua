-- Networking

_GLOBAL = _GLOBAL or {}

if SERVER then
	util.AddNetworkString( "SUPSetGlobalTable" )
	util.AddNetworkString( "SUPGetGlobalTables" )
end

function GetGlobalTable(key, value)
	return _GLOBAL[key] or value or {}
end

function SetGlobalTable(key, value)
	if type(key) == "string" and type( value) == "table" then
		_GLOBAL[key] = value
		if SERVER then
			net.Start( "SUPSetGlobalTable" )
				net.WriteString(key)
				net.WriteTable( value)
			net.Broadcast()
		end
	else
		Msg(Color(255, 0, 0), ">>> SetGlobalTable FAILED", key, value)
	end
end

if SERVER then
	net.Receive( "SUPGetGlobalTables", function(len, ply)
		for key, value in pairs(_GLOBAL) do
			net.Start( "SUPSetGlobalTable" )
				net.WriteString(key)
				net.WriteTable( value)
			net.Send(ply)
		end
	end)
end

if CLIENT then
	net.Receive( "SUPSetGlobalTable", function(len)
		local key = net.ReadString()
		local tab = net.ReadTable()

		SetGlobalTable(key, tab)
	end)

	hook.Add( "PostGamemodeLoaded", "SUP_PostGamemodeLoaded_GlobalTable", function()
		timer.Simple(0.1, function()
			net.Start( "SUPGetGlobalTables" )
			net.SendToServer()
		end)
	end)
end