VoiceChatMeter = {}

VoiceChatMeter.IsTTT = false // SET THIS TO TRUE IF YOU ARE RUNNING A TTT SERVER!
// This will put the voice backgrounds in the top left.
// You could also customize it as much as you want below:

VoiceChatMeter.DarkRPSelfSquare = false // Do you want the voice chat indicator to show when you yourself talk (for DarkRP)

VoiceChatMeter.SizeX = 235 // The width for voice chat
VoiceChatMeter.SizeY = 40 // The height for voice chat
VoiceChatMeter.FontSize = 17 // The font size for player names on the voice chat
VoiceChatMeter.Radius = 4 // How round you want the voice chat square to be (0 = square)
VoiceChatMeter.FadeAm = .1 // How fast the voice chat square fades in and out. 1 = Instant, .01 = fade in really slow
VoiceChatMeter.SlideOut = true // Should the chat meter do a "slide out" animation
VoiceChatMeter.SlideTime = .1 // How much time it takes for voice chat box to "slide out" (if above is on)

// A bit more advanced options
VoiceChatMeter.PosX = 1 // The position based on your screen width for voice chat box. Choose between 0 and 1
VoiceChatMeter.PosY = .85 // The position based on screen height for the voice chat box. Choose between 0 and 1
VoiceChatMeter.Align = 0 // How should the voice chat align? For align right, choose 0. For align left, choose 1
VoiceChatMeter.StackUp = true // If more people up, should the voice chat boxes go upwards?

VoiceChatMeter.UseTags = false // Should we use tags? This will put [SA] or [A] infront of superadmins/admins. Remember commas!
VoiceChatMeter.Tags = {
	["founder"] = "F |",
	["moderator"] = "M |",
	["serverstaff"] = "S |",
	["apollo"] = "A |",
	["thaumiel"] = "T |",
	["afina"] = "T |",
	["sponsor"] = "T |",
	["premium"] = "T |",
	["vip"] = "T |",
}

// Autoset positioning if IsTTT is true. Don't edit this unless you really need to.
if (VoiceChatMeter.IsTTT) then
	VoiceChatMeter.SizeX = 220
	VoiceChatMeter.SizeY = 40
	VoiceChatMeter.PosX = .02
	VoiceChatMeter.PosY = .03
	VoiceChatMeter.Align = 1
	VoiceChatMeter.StackUp = false
end


surface.CreateFont("Jack_VoiceFont", {
	font = "Play",
	size = VoiceChatMeter.FontSize or 17,
	weight = 550,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = true
})

--[[---------------------------------------------------------------------------
		   DarkRP хуйня
---------------------------------------------------------------------------]]
surface.CreateFont("DarkRPHUD1", {
	font = "Play",
	size = 100,
	extended = true,
})

local receivers
local currentChatText = {}

local receiverConfigs = {
	[""] = {
		text = "talk",
		hearFunc = function(ply)
			if GAMEMODE.Config.alltalk then return nil end

			return LocalPlayer():GetPos():Distance(ply:GetPos()) < 250
		end
	} -- The default config decides who can hear you when you speak normally
	
}

local currentConfig = receiverConfigs[""] -- Default config is normal talk

local function AddChatReceiver(prefix, text, hearFunc)
	receiverConfigs[prefix] = {
		text = text,
		hearFunc = hearFunc
	}
end

AddChatReceiver("speak", "speak", function(ply)
	if not LocalPlayer().DRPIsTalking then return nil end
	if LocalPlayer():GetPos():Distance(ply:GetPos()) > 550 then return false end

	return not GAMEMODE.Config.dynamicvoice or ((ply.IsInRoom and ply:IsInRoom()) or (ply.isInRoom and ply:isInRoom()))
end)

local function drawChatReceivers()
	if not receivers then return end
	local x, y = chat.GetChatBoxPos()
	y = y - 21

	-- No one hears you
	if #receivers == 0 then
		draw.WordBox(2, x, y, "Noone can hear you speak", "DarkRPHUD1", Color(0, 0, 0, 160), Color(255, 0, 0, 255))
		-- Everyone hears you

		return
	elseif #receivers == #player.GetAll() - 1 then
		draw.WordBox(2, x, y, "Everyone can hear you speak", "DarkRPHUD1", Color(0, 0, 0, 160), Color(0, 255, 0, 255))

		return
	end

	draw.WordBox(2, x, y - (#receivers * 21), "Players who can hear you speak:", "DarkRPHUD1", Color(0, 0, 0, 160), Color(0, 255, 0, 255))

	for i = 1, #receivers do
		if not IsValid(receivers[i]) then
			receivers[i] = receivers[#receivers]
			receivers[#receivers] = nil
			continue
		end

		draw.WordBox(2, x, y - (i - 1) * 21, receivers[i]:Nick(), "DarkRPHUD1", Color(0, 0, 0, 160), Color(255, 255, 255, 255))
	end
end

local function chatGetRecipients()
	if not currentConfig then return end
	receivers = {}

	for _, ply in pairs(player.GetAll()) do
		if not IsValid(ply) or ply == LocalPlayer() then continue end
		local val = currentConfig.hearFunc(ply, currentChatText)

		-- Return nil to disable the chat recipients temporarily.
		if val == nil then
			receivers = nil

			return
		elseif val == true then
			table.insert(receivers, ply)
		end
	end
end

--[[---------------------------------------------------------------------------
			Конец DarkRP хуйни
---------------------------------------------------------------------------]]
Jack = Jack or { Talking = {} }

for k, v in pairs(Jack.Talking) do
	v:Remove()
end

--local mat_gradient1 = Material("luna_menus/hud/gradient1.png", "smooth noclamp")
local mat_gradient1 = Material("luna_menus/hud/donate/gradient1.png", "smooth noclamp")
local mat_walkietalkie = Material("luna_menus/hud/walkie-talkie.png", "smooth noclamp")
local mat_waveformlines = Material("luna_menus/hud/wave.png", "smooth noclamp")

function Jack.StartVoice(ply)
	if not ply:IsValid() or not ply.Team then return end

	for k, v in pairs(Jack.Talking) do
		if v.Owner == ply then
			v:Remove()
			Jack.Talking[k] = nil
			break
		end
	end

	if DarkRP and ply == LocalPlayer() then
		ply.DRPIsTalking = true
		currentConfig = receiverConfigs["speak"]
		hook.Add("Think", "DarkRP_chatRecipients", chatGetRecipients)
		hook.Add("HUDPaint", "DarkRP_DrawChatReceivers", drawChatReceivers)
		if not VoiceChatMeter.DarkRPSelfSquare then return end -- No squares for yourself in DarkRP
	end

	local CurID = 1
	local W, H = VoiceChatMeter.SizeX or 250, VoiceChatMeter.SizeY or 40
	local TeamClr, CurName = team.GetColor(ply:Team()), ply:Name()

	-- The name panel itself
	local ToAdd = 0

	if #Jack.Talking ~= 0 then
		for i = 1, #Jack.Talking + 3 do
			if not Jack.Talking[i] or not Jack.Talking[i]:IsValid() then
				ToAdd = -(i - 1) * (H + 4)
				CurID = i
				break
			end
		end
	end

	if not VoiceChatMeter.StackUp then
		ToAdd = -ToAdd
	end

	local NameStr = ply:Name()

	local NameBar, Fade, Go = vgui.Create("DPanel"), 0, 1
	NameBar:SetSize(W, H)
	local StartPos = (VoiceChatMeter.SlideOut and ((VoiceChatMeter.PosX < .5 and -W) or ScrW())) or (ScrW() * VoiceChatMeter.PosX - (VoiceChatMeter.Align == 1 and 0 or W))
	NameBar:SetPos(StartPos, ScrH() * VoiceChatMeter.PosY + ToAdd)

	if VoiceChatMeter.SlideOut then
		NameBar:MoveTo(ScrW() * VoiceChatMeter.PosX - (VoiceChatMeter.Align == 1 and 0 or W) - 10, ScrH() * VoiceChatMeter.PosY + ToAdd, VoiceChatMeter.SlideTime)
	end

	surface.SetFont(luna.MontBase22)
	local wt, _ = surface.GetTextSize(NameStr)

	NameBar.Paint = function(s, w, h)
		-- draw.RoundedBox(0, 2, 2, w - 4, h - 4, Color(TeamClr.r, TeamClr.g, TeamClr.b, 220 * Fade))
		draw.Icon(0,0,w-h-4,h,mat_gradient1,COLOR_WHITE)

		local micro = ply:GetNetVar("micro")
		local channel_l = LocalPlayer():GetNetVar("radio")
		local channel_t = ply:GetNetVar("radio")

		if (micro and micro >= 1) and channel_l and channel_t and channel_l == channel_t then
			local wm = micro == 1 and 26 or 26
			draw.Icon(w-54-wt-wm,h/2-13,wm,26,micro == 1 and mat_walkietalkie or mat_waveformlines,COLOR_WHITE)
		end
	end

	-- draw.RoundedBox(0,2,2,w-4,h-4,Color(0,0,0,180*Fade))
	NameBar.Owner = ply
	-- Initialize stuff for this think function
	local NameTxt, Av = vgui.Create("DLabel", NameBar), vgui.Create("AvatarImage", NameBar)

	-- How the voice volume meters work
	function NameBar:Think()
		if not ply:IsValid() then
			NameBar:Remove()
			Jack.Talking[CurID] = nil

			return false
		end

		if not Jack.Talking[CurID] then
			NameBar:Remove()

			return false
		end

		if self.Next and CurTime() - self.Next < .02 then return false end

		if Jack.Talking[CurID].fade then
			if Go ~= 0 then
				Go = 0
			end

			if Fade <= 0 then
				Jack.Talking[CurID]:Remove()
				Jack.Talking[CurID] = nil
			end
		end

		if Fade < Go and Fade ~= 1 then
			Fade = Fade + VoiceChatMeter.FadeAm
			NameTxt:SetAlpha(Fade * 255)
			Av:SetAlpha(Fade * 255)
			NameBar:SetAlpha(Fade * 255)
		elseif Fade > Go and Go ~= 1 then
			Fade = Fade - VoiceChatMeter.FadeAm
			NameTxt:SetAlpha(Fade * 255)
			Av:SetAlpha(Fade * 255)
			NameBar:SetAlpha(Fade * 255)
		end

		self.Next = CurTime()
		local CurVol = ply:VoiceVolume() * 1.05
		local VolBar, Clr = vgui.Create("DPanel", NameBar), Color(255 * CurVol, 255 * (1 - CurVol), 0, 190)
		VolBar:SetSize(4, (self:GetTall() - 6) * CurVol)
		VolBar:SetPos(self:GetTall() - 6, (self:GetTall() - 6) * (1 - CurVol) + 3)

		VolBar.Think = function(sel)
			if sel.Next and CurTime() - sel.Next < .02 then return false end
			sel.Next = CurTime()
			local X, Y = sel:GetPos()

			if X > NameBar:GetWide() - 54 then
				sel:Remove()

				return
			end

			sel:SetPos(X + 6, Y)
		end

		VolBar.Paint = function(s, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(Clr.r, Clr.g, Clr.b, Clr.a * Fade))
		end

		VolBar:MoveToBack()
		VolBar:SetZPos(5)
	end

	-- The player's avatar
	Av:Dock(RIGHT)
	Av:SetSize(NameBar:GetTall(), NameBar:GetTall())
	Av:SetPlayer(ply)
	-- Admin tags and the such


	if VoiceChatMeter.UseTags then
		local Is

		for k, v in pairs(VoiceChatMeter.Tags) do
			if ply:IsUserGroup(k) then
				Is = v
			end
		end

		if not Is and ply:IsSuperAdmin() then
			Is = "[SA]"
		elseif not Is and ply:IsAdmin() then
			Is = "[A]"
		end

		if Is then
			NameStr = Is .. " " .. NameStr
		end
	end

	-- The player's name
	NameTxt:SetAlpha(0)
	NameTxt:SetFont(luna.MontBase22)
	NameTxt:SetText(NameStr)

	surface.SetFont(luna.MontBase22)
	local wt, _ = surface.GetTextSize(NameStr)
	NameTxt:SetSize(wt, 20)
	NameTxt:SetPos(NameBar:GetWide() - NameBar:GetTall() - wt - 10, H * .25)
	NameTxt:SetColor(Color(255, 255, 255, 240))
	NameTxt:SetZPos(8)
	NameTxt:MoveToFront()
	NameBar:MoveToBack()

	-- Hand up-to-face animation
	if VOICE and (not (ply:IsActiveTraitor() and (not ply.traitor_gvoice))) then
		ply:AnimPerformGesture(ACT_GMOD_IN_CHAT)
	end

	Jack.Talking[CurID] = NameBar

	return false
end

hook.Add("PlayerStartVoice", "Jack's Voice Meter Addon Start", Jack.StartVoice)

function Jack.EndVoice(ply)
	for k, v in pairs(Jack.Talking) do
		if v.Owner == ply then
			Jack.Talking[k].fade = true
			break
		end
	end

	if DarkRP and ply == LocalPlayer() then
		hook.Remove("Think", "DarkRP_chatRecipients")
		hook.Remove("HUDPaint", "DarkRP_DrawChatReceivers")
		ply.DRPIsTalking = false
	end

	-- More TTT specific stuff
	if VOICE and VOICE.SetStatus then
		if IsValid(ply) and not no_reset then
			ply.traitor_gvoice = false
		end

		if ply == LocalPlayer() then
			VOICE.SetSpeaking(false)
		end
	end
end

hook.Add("PlayerEndVoice", "Jack's Voice Meter Addon End", Jack.EndVoice)

hook.Add("HUDShouldDraw", "Remove old voice cards", function(elem)
	if elem == "CHudVoiceStatus" or elem == "CHudVoiceSelfStatus" then return false end
end)