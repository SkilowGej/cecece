-- Refactored by DuLL_FoX, old code is below

local WALKIE_TALKIE_GROUP_RATINGS = WALKIE_TALKIE_GROUP_RATINGS or {}
local RADIO_MIN_CHANNEL = 0
local RADIO_MAX_CHANNEL = 100

local function PlayRadioSound(ply, toggle)
    local soundFile = toggle and "radio/voip_end_transmit_beep_01.wav" or string.format("radio/voip_end_transmit_beep_0%d.wav", math.random(2, 4))
    ply:EmitSound(soundFile, 60, 100, 0.1, CHAN_AUTO)
end

local function NotifyPlayer(ply, color, message)
    re.util.Notify(color, ply, message)
end

netstream.Hook("WalkieTalkie.SpeakerToggle", function(ply)
    local speaker = not ply:GetNetVar("speaker")
    ply:SetNetVar("speaker", speaker)
    
    if not speaker then 
        ply:SetNetVar("micro", false) 
    end
    
    local action = speaker and "włączony" or "wyłączony"
    NotifyPlayer(ply, "yellow", "Ty " .. action .. " krótkofalówka.")
    PlayRadioSound(ply, speaker)
end)

netstream.Hook("WalkieTalkie.MicroToggle", function(ply)
    local toggle = ply:GetNetVar("micro")
    PlayRadioSound(ply, toggle == 0)

    if toggle == 1 then
        toggle = WALKIE_TALKIE_GROUP_RATINGS[ply:GetNWString("rating")] and 2 or 0
    elseif toggle == 2 then
        toggle = 0
    else
        toggle = 1
    end

    ply:SetNetVar("micro", toggle)
    
    local action
    if toggle == 1 then
        action = "włączony"
    elseif toggle == 2 then
        action = "przełączony w tryb nadawania"
    else
        action = "wyłączony"
    end
    
    NotifyPlayer(ply, "yellow", "Ty " .. action .. " mikrofon krótkofalówki.")
end)

netstream.Hook("WalkieTalkie.ChangeChannel", function(ply, data)
    local channel = tonumber(data.channel)
    
    if not channel or channel < RADIO_MIN_CHANNEL or channel > RADIO_MAX_CHANNEL then
        NotifyPlayer(ply, "red", string.format("Kanał krótkofalówki nie może być wyższy niż %d i niższy niż %d.", RADIO_MAX_CHANNEL, RADIO_MIN_CHANNEL))
        return
    end

    ply:SetNetVar("radio", channel, NETWORK_PROTOCOL_PUBLIC)
    NotifyPlayer(ply, "yellow", "Ty zmieniłeś kanał krótkofalówki na " .. channel .. ".")
end)

hook.Add("PlayerInitialSpawn", "WalkieTalkie_PlayerInitialSpawn", function(ply)
    ply.walkie_talkie = ply.walkie_talkie or {}
    ply:SetNetVar("speaker", false)
    ply:SetNetVar("micro", false) -- 0
end)

hook.Add("PlayerCanHearPlayersVoice", "WalkieTalkie_PlayerCanHearPlayersVoice", function(listener, talker)
    if not IsValid(talker) or not IsValid(listener) or talker.isScanner then return end
    if not talker.walkie_talkie or not listener.walkie_talkie then return end
    
    local channel_l, channel_t = listener:GetNetVar("radio"), talker:GetNetVar("radio")
    local listener_s, listener_m = listener:GetNetVar("speaker"), listener:GetNetVar("micro")
    local talker_s, talker_m = talker:GetNetVar("speaker"), talker:GetNetVar("micro")
    local listener_job = re.jobs[listener:Team()]
    
    if talker_m == 2 and listener_job and listener_job.Type == TYPE_CLONE then
        return true
    end
    
    if talker_m == 1 and talker_s and listener_s and channel_l and channel_t and channel_l == channel_t then
        return true
    end
end)

local function FindPlayersInRadio(radio)
    local players = {}
    for _, v in ipairs(player.GetAll()) do
        if v:GetNetVar("radio") == radio then
            table.insert(players, v)
        end
    end
    return players
end

local function SendGroupMessage(ply, radio, text)
    if not radio then
        NotifyPlayer(ply, "red", "Nie możesz korzystać z czatu grupowego.")
        return
    end

    text = text:gsub("^/g%s*", "")
    local players = FindPlayersInRadio(radio)
    for _, player in pairs(players) do
        ChatAddText({player}, Color(0, 112, 60), "Krótkofalówka ", ply, color_white, ": ", text)
    end
end

hook.Add("PlayerSay", "WalkieTalkie_PlayerSay", function(ply, text, teamonly)
    local radio = ply:GetNetVar("radio")

    if text:match("^/g") or teamonly then
        SendGroupMessage(ply, radio, text)
        return ""
    end
end)

hook.Add( 'PlayerChangedTeam', 'Walkie-Talkie:SetupChannel', function( ply, oldT, newT )
    local job = re.jobs[newT]
    local radioChannel = job.radio
    if radioChannel then
        ply:SetNetVar( "radio", radioChannel, NETWORK_PROTOCOL_PUBLIC )
    end
end )

-- На рассмотрение, на будущее.
-- VoiceBox FX Integration
-- local function voiceboxCanHear(listener, speaker)
--     local listenerRadio = listener:GetNetVar("radio")
--     local speakerRadio = speaker:GetNetVar("radio")

--     local listenerSpeaker = listener:GetNetVar("speaker")
--     local speakerMicro = speaker:GetNetVar("micro")

--     -- if listenerRadio == speakerRadio then
--     if listenerRadio and speakerRadio and listenerRadio == speakerRadio and listenerSpeaker and speakerMicro then
--         VoiceBox.FX.IsRadioComm(listener:EntIndex(), speaker:EntIndex(), true)
--         return true
--     end

--     VoiceBox.FX.IsRadioComm(listener:EntIndex(), speaker:EntIndex(), false)
-- end

-- if VoiceBox and VoiceBox.FX then
--     hook.Add("PlayerCanHearPlayersVoice", "WalkieTalkie_PlayerCanHearPlayersVoice", voiceboxCanHear)
-- else
--     hook.Add("VoiceBox.FX", "WalkieTalkie_PlayerCanHearPlayersVoice", function()
--         VoiceBox.FX.SetRadioStaticEnabled(true) -- Enable VoiceBox FX's radio static
--         hook.Add("PlayerCanHearPlayersVoice", "WalkieTalkie_PlayerCanHearPlayersVoice", voiceboxCanHear)
--     end)
-- end