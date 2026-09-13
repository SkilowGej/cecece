local function Declare_Value(listener, speaker)
	local isindist = listener:EyePos():DistToSqr(speaker:EyePos()) < DEFAULT_VOICE_DISTANCE
	return isindist, isindist
end

local hear_table = {}

local function CalcVoice(client, players)
	for i = 1, #players do
		local speaker = players[i]
		if ( hear_table[client][speaker] == nil and client != speaker ) then
		    local canhearspeaker, canhearlistener = Declare_Value(client, speaker)
		    hear_table[client][speaker] = canhearspeaker
		    hear_table[speaker][client] = canhearlistener
		end
	end
end

local function CalcVoiceTable()
	local clients = {}
	local players = player.GetAll()

	for i = 1, #players do
		local speaker = players[i]
		clients[#clients + 1] = speaker
		hear_table[speaker] = {}
	end

	for j = 1, #clients do
		CalcVoice(clients[j], clients)
	end
end

timer.Create("CalcVoice", 0.5, 0, function()
	CalcVoiceTable()
end)

function GM:PlayerCanHearPlayersVoice(listener, talker)
	if ( talker:Health() <= 0 or listener:Health() <= 0 or not talker:Alive() or not listener:Alive() ) then 
		return false 
	end

	if ( not listener:Alive() ) then 
		return false 
	end

	return hear_table[listener] and hear_table[listener][talker], true
end

function GM:PlayerCanSeePlayersChat(text, teamOnly, listener, talker)
	if ( talker:Health() <= 0 or listener:Health() <= 0 or not talker:Alive() or not listener:Alive() ) then 
		return false 
	end

	if ( teamOnly and speaker:Team() != listener:Team() ) then
		return false
	end

	return true
end
