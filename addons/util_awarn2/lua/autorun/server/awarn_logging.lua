--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

awarn_logfile = nil

if !file.Exists( "awarn2/logs", "DATA" ) then
	file.CreateDir( "awarn2/logs" )
end

function awarn_CheckLogFile()
	awarn_logfile = os.date( "awarn2/logs/" .. "%m-%d-%y" .. ".txt" )
	if !file.Exists( awarn_logfile, "DATA" ) then
		file.Write( awarn_logfile, "" )
	end
end

function awarn_log( str )
	awarn_CheckLogFile()
	local date = os.date( "*t" )
	local dlog = string.format( "[%02i:%02i:%02i] ", date.hour, date.min, date.sec )
	file.Append( awarn_logfile, dlog .. str .. "\n" )
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
