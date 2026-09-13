re.cmd.data = re.cmd.data or {}

function re.cmd.callback(pPlayer, cmd, args, str)
	if not args[1] or args == {} then
		print("This is a basic command for re gamemode.")
	end

	if table.HasValue(table.GetKeys(re.cmd.data), args[1]) then
		local com = args[1]
		-- table.remove(args, 1);
		re.cmd.data[com](pPlayer, cmd, args)
	elseif args[1] or args == {} then
		print("Errors of the argument!")
	end
end

function re.cmd.autoComplete(commandName, args)
	local return_table = {}

	for _, name in pairs(table.GetKeys(re.cmd.data)) do
		table.insert(return_table, string.format("re %s", name))
	end

	return return_table
end

function re.cmd.add(arg, callback)
	re.cmd.data[arg] = callback
end

function CharacterChange(pPlayer, cmd, args)
	pPlayer:RequestCharacters(function(characters, player_data)
		netstream.Start(pPlayer, "OpenCharacterMenu", {
			characters = characters
		})
	end)
end

re.cmd.add("char", CharacterChange)

function Whitelist(pPlayer, cmd, args)
	netstream.Start(pPlayer, "OpenWhitelistMenu")
end

hook.Add("ShowTeam", "OpenWhitelistMenu", function(pPlayer)
	if not IsValid(pPlayer) or not pPlayer:Alive() then return end
	OpenWhitelist(pPlayer)
end)

re.cmd.add("whitelist", Whitelist)
re.cmd.add("w", Whitelist)

function JoinCombat(pPlayer, cmd, args)
	if not pPlayer:Alive() then return end
	if pPlayer:GetNWBool("IsHandcuffed") or pPlayer.GetPlayerKidnapper then return end

	if not re.combat.Get() then
		ChatAddText(pPlayer, Color(240, 65, 17), "RE.arena • ", Color(255, 255, 255), "Obecnie nie ma Areny")

		return
	end

	if table.Count(re.combat.CombatPlayers()) >= re.combat.Get():GetMaxPlayers() then
		ChatAddText(pPlayer, Color(240, 65, 17), "RE.arena • ", Color(255, 255, 255), "Osiągnięto maksymalną liczbę graczy na Arenie")

		return
	end

	if re.combat.Get().isStart then
		ChatAddText(pPlayer, Color(240, 65, 17), "RE.arena • ", Color(255, 255, 255), "Nie można wejść podczas gry")

		return
	end

	if pPlayer:Team() == TEAM_OVERWATCH then
		ChatAddText(pPlayer, Color(240, 65, 17), "RE.arena • ", Color(255, 255, 255), "Nie możesz wejść za tę profesję")

		return
	end

	ChatAddText(pPlayer, Color(17, 148, 240), "RE.arena • ", Color(255, 255, 255), "Zarejestrowałeś się na udział w Arenie")
	pPlayer:JoinCombat()
end

re.cmd.add("join", JoinCombat)
re.cmd.add("combat", JoinCombat)

function LeaveCombat(pPlayer, cmd, args)
	if re.combat.Get().isStart then
		ChatAddText(pPlayer, Color(240, 65, 17), "RE.arena • ", Color(255, 255, 255), "Nie można wyjść podczas gry")

		return
	end

	if not pPlayer:GetNWBool("inCombat") then
		ChatAddText(pPlayer, Color(240, 65, 17), "RE.arena • ", Color(255, 255, 255), "Nie jesteś na Arenie")

		return
	end

	pPlayer:SetNWBool("inCombat", false)
	ChatAddText(pPlayer, Color(65, 240, 17), "RE.arena • ", Color(255, 255, 255), "Opuszczasz Arenę")
end

re.cmd.add("leave", LeaveCombat)

-- For some reason gives an error - Tried to look up command thirdperson as if it were a variable.
function ThirdPersonToggle(pPlayer, cmd, args)
    if IsValid(pPlayer) and pPlayer:IsPlayer() then
        netstream.Start(pPlayer, "thirdperson_toggle")
    end
end

re.cmd.add("thirdperson", ThirdPersonToggle)

if SERVER then
	concommand.Add("reg", re.cmd.callback, re.cmd.autoComplete, "This is a basic command for re gamemode.")

	netstream.Hook("re.command.SendCommandsToServer", function(pPlayer, data)
		re.cmd.callback(pPlayer, data.cmd, data.args)
	end)

	hook.Add("PlayerSay", "re.command.PlayerSay", function(pPlayer, strMsg)
		strMsg = string.Explode(" ", strMsg)

		for k, v in pairs(re.cmd.data) do
			if "/" .. k == strMsg[1] then
				strMsg[1] = string.gsub(strMsg[1], "/", "")
				v(pPlayer, "reg", strMsg)

				return ""
			end
		end
	end)
else
	concommand.Add("reg", function(pPlayer, cmd, args)
		netstream.Start("re.command.SendCommandsToServer", {
			args = args,
			cmd = cmd
		})
	end, re.cmd.autoComplete, "This is a basic command for re gamemode.")

	netstream.Hook("PlayerPosition", function(arrayData)
		CL_UNSECURE_PLAYER_MARKERS = arrayData
	end)
	netstream.Hook("ChatMassage", function(data)
		pCaller = data.pPlayer

		if pCaller and pCaller:IsPlayer() then
			color, pre = data.color, data.pre
			postcolor = data.postcolor == false and "" or Color(255, 255, 255)
			postname = data.postcolor == false and " " or ": "
			local text_color = data.text_color or Color(255, 255, 255)
			local name = data.drawname and data.drawname or pCaller:Name()

			groupData = GROUP_ICONS[pCaller:GetUserGroup()]

			-- TODO: Не отображаются иконки юзергрупп (_Dubrovski_, 19.08.2024)
			--if groupData.chat_prefix then
			--	chat.AddText(color, pre, groupData.col, ":" .. pCaller:GetUserGroup() .. ": ", team.GetColor(pCaller:Team()), name, postcolor, postname, text_color, data.text)
			--else
				chat.AddText(color, pre, team.GetColor(pCaller:Team()), name, postcolor, postname, text_color, data.text)
			--end
		end
	end)

	netstream.Hook("RPCommands", function(...)
		chat.AddText(...)
	end)
end

re.cmd.data = re.cmd.data or {}

function re.cmd.callback(pPlayer, cmd, args, str)
	if not args[1] or args == {} then
		print("This is a basic command for re gamemode.")
	end

	if table.HasValue(table.GetKeys(re.cmd.data), args[1]) then
		local com = args[1]
		-- table.remove(args, 1);
		re.cmd.data[com](pPlayer, cmd, args)
	elseif args[1] or args == {} then
		print("Errors of the argument!")
	end
end

function re.cmd.autoComplete(commandName, args)
	local return_table = {}

	for _, name in pairs(table.GetKeys(re.cmd.data)) do
		table.insert(return_table, string.format("re %s", name))
	end

	return return_table
end

function re.cmd.add(arg, callback)
	re.cmd.data[arg] = callback
end

function OOCMassage(pPlayer, cmd, args)
	table.remove(args, 1)
	local strMsg = string.Implode(" ", args)

	netstream.Start(player.GetAll(), "ChatMassage", {
		pPlayer = pPlayer,
		pre = "OOC",
		color = Color(238, 50, 57),
		text = strMsg
	})
end

re.cmd.add("ooc", OOCMassage)
re.cmd.add("c", OOCMassage)
re.cmd.add("/", OOCMassage)

-- re.cmd.add("w",Whitelist)
function EventRoom(pPlayer, cmd, args)
	if not pPlayer:IsAdmin() then return end
	netstream.Start(pPlayer, "OpenEventroomMenu")
end

re.cmd.add("eventroom", EventRoom)

function Event(pPlayer, cmd, args)
	if not pPlayer:IsAdmin() then return end
	table.remove(args, 1)
	local message = string.Implode(" ", args)
	netstream.Start(player.GetAll(), "EventMessage", string.Implode(" ", args))
end

re.cmd.add("event", Event)

-- function DropMoney( pPlayer, cmd, args )
-- 	local moneyCount
-- 	if (args and args[2]) then
-- 		moneyCount = tonumber(args[2])
-- 		if pPlayer:isEnoughMoney(moneyCount) then
-- 			pPlayer:AddMoney(-moneyCount)
-- 			local trace = {}
-- 			trace.start = pPlayer:EyePos()
-- 			trace.endpos = trace.start + pPlayer:GetAimVector() * 85
-- 			trace.filter = pPlayer
-- 			local tr = util.TraceLine(trace)
-- 			CreateMoneyBag(tr.HitPos,moneyCount)
-- 		end
-- 	end
-- end
-- re.cmd.add("dropmoney",DropMoney)
-- function AddMoney( pPlayer, cmd, args )
-- 	local moneyCount
-- 	if (args and args[2]) then
-- 		moneyCount = tonumber(args[2])
-- 		if pPlayer:isEnoughMoney(moneyCount) then
--             local trace = pPlayer:GetEyeTrace()
--             local target = trace.Entity
--             if target and IsValid(target) and target:IsPlayer() then
--                 pPlayer:AddMoney(-moneyCount)
--                 target:AddMoney(moneyCount)
--             end
-- 		end
-- 	end
-- end

-- re.cmd.add("addmoney",AddMoney)
-- function DropWeapon(pPlayer, cmd, args)
-- 	pPlayer:DropWeapon(pPlayer:GetActiveWeapon())
-- end

-- re.cmd.add("dropweapon", DropWeapon)
-- re.cmd.add("drop", DropWeapon)

function AdvertMassage(pPlayer, cmd, args)
	table.remove(args, 1)
	local strMsg = string.Implode(" ", args)

	if pPlayer:GetNetVar("features")["oficc"] then
		netstream.Start(player.GetAll(), "ChatMassage", {
			pPlayer = pPlayer,
			pre = "COMM2",
			color = Color(85, 153, 0),
			text = strMsg,
			text_color = Color(255, 238, 0)
		})
	else
		netstream.Start({pPlayer}, "ChatMassage", {
			pPlayer = pPlayer,
			pre = "UWAGA, ",
			text = "Jesteś w bazie, używaj standardowej łączności bazowej przez /comm",
			color = Color(255,238,0),
			text_color = Color(228,129,17)
		})

		local adminsAndDroids = {}
		for _, v in pairs(player.GetAll()) do
			local job = FindJob(v:Team())
			if job and (job.Type == TYPE_ADMIN or job.control == CONTROL_CIS) then
				table.insert(adminsAndDroids, v)
			end

		end
		table.insert(SV_UNSECURE_PLAYER_MARKERS, {
			pPlayer = pPlayer,
			TTL = CurTime() + 300
		})
		netstream.Start(adminsAndDroids, 'PlayerPosition', SV_UNSECURE_PLAYER_MARKERS)

		netstream.Start(player.GetAll(), 'ChatMassage', {
			pPlayer = pPlayer,
			pre = "COMM3",
			color = Color(39, 147, 232),
			text = strMsg,
			text_color = Color(255, 238, 0)
		})
	end
end

re.cmd.add("advert", AdvertMassage)
re.cmd.add("ad", AdvertMassage)

function RP1Massage(pPlayer, cmd, args)
	table.remove(args, 1)
	local strMsg = string.Implode(" ", args)

	netstream.Start(player.GetAll(), "ChatMassage", {
		pPlayer = pPlayer,
		pre = "RP",
		color = Color(39, 147, 232),
		text = strMsg,
		text_color = Color(69, 136, 237)
	})
end

re.cmd.add("rp", RP1Massage)

function Advert2Massage(pPlayer, cmd, args)
	table.remove(args, 1)
	local strMsg = string.Implode(" ", args)

	netstream.Start(player.GetAll(), "ChatMassage", {
		pPlayer = pPlayer,
		-- drawname = "",
		pre = "COMM1",
		color = Color(8, 219, 114),
		text = strMsg,
		text_color = Color(255, 238, 0)
	})
end

re.cmd.add("comm", Advert2Massage)

function AdvertCISMassage(pPlayer, cmd, args)
	if not pPlayer:IsAdmin() then return end
	table.remove(args, 1)
	local strMsg = string.Implode(" ", args)

	netstream.Start(player.GetAll(), "ChatMassage", {
		pPlayer = pPlayer,
		-- drawname = "",
		pre = "CIS",
		color = Color(33, 155, 255),
		text = strMsg,
		text_color = Color(2, 255, 242)
	})
end

re.cmd.add("cis", AdvertCISMassage)

function AdvertRANDOMMassage(pPlayer, cmd, args)
	if not pPlayer:IsAdmin() then return end
	table.remove(args, 1)
	local strMsg = string.Implode(" ", args)

	netstream.Start(player.GetAll(), "ChatMassage", {
		pPlayer = pPlayer,
		drawname = "",
		pre = "WHO",
		color = Color(33, 155, 255),
		text = strMsg,
		text_color = Color(2, 255, 242)
	})
end

re.cmd.add("silent", AdvertRANDOMMassage)

function MeMassage(pPlayer, cmd, args)
	table.remove(args, 1)
	local tblPlayers = {}

	for _, v in pairs(ents.FindInSphere(pPlayer:GetPos(), 300)) do
		table.insert(tblPlayers, v)
	end

	netstream.Start(tblPlayers, "ChatMassage", {
		pPlayer = pPlayer,
		pre = "",
		color = team.GetColor(pPlayer:Team()),
		text = string.Implode(" ", args),
		postcolor = false,
		text_color = team.GetColor(pPlayer:Team())
	})
end

re.cmd.add("me", MeMassage)

function NoRPMassage(pPlayer, cmd, args)
	table.remove(args, 1)
	local tblPlayers = {}
	local strMsg = string.Implode(" ", args)

	for _, v in pairs(ents.FindInSphere(pPlayer:GetPos(), 300)) do
		table.insert(tblPlayers, v)
	end

	netstream.Start(tblPlayers, "ChatMassage", {
		pPlayer = pPlayer,
		pre = "LOOC",
		color = Color(17, 148, 240),
		text = strMsg
	})
end

re.cmd.add("l", NoRPMassage)
re.cmd.add("looc", NoRPMassage)

function YellMassage(pPlayer, cmd, args)
	table.remove(args, 1)
	local tblPlayers = {}
	local strMsg = string.Implode(" ", args)

	for _, v in pairs(ents.FindInSphere(pPlayer:GetPos(), 650)) do
		table.insert(tblPlayers, v)
	end

	netstream.Start(tblPlayers, "ChatMassage", {
		pPlayer = pPlayer,
		pre = "YELL",
		color = Color(17, 148, 240),
		text = strMsg
	})
end

re.cmd.add("y", YellMassage)

function WhisperMassage(pPlayer, cmd, args)
	table.remove(args, 1)
	local tblPlayers = {}
	local strMsg = string.Implode(" ", args)

	for _, v in pairs(ents.FindInSphere(pPlayer:GetPos(), 50)) do
		table.insert(tblPlayers, v)
	end

	netstream.Start(tblPlayers, "ChatMassage", {
		pPlayer = pPlayer,
		pre = "TSH",
		color = Color(17, 148, 240),
		text = strMsg
	})
end

re.cmd.add("w", WhisperMassage)

function DoMassage(pPlayer, cmd, args)
	table.remove(args, 1)
	local tblPlayers = {}

	for _, v in pairs(ents.FindInSphere(pPlayer:GetPos(), 300)) do
		table.insert(tblPlayers, v)
	end

	local rand = tostring(math.random(1, 100))
	netstream.Start(tblPlayers, "RPCommands", team.GetColor(pPlayer:Team()), string.Implode(" ", args), " (( " .. pPlayer:Name() .. " ))")
end

re.cmd.add("do", DoMassage)

function RollMassage(pPlayer, cmd, args)
	table.remove(args, 1)
	local tblPlayers = {}

	for _, v in pairs(ents.FindInSphere(pPlayer:GetPos(), 300)) do
		table.insert(tblPlayers, v)
	end

	local rand = tostring(math.random(1, 100))
	netstream.Start(tblPlayers, "RPCommands", pPlayer, Color(255, 255, 255, 255), " rzucił kostką i wypadło mu ", Color(17, 148, 240), rand, Color(255, 255, 255, 255), ".")
end

re.cmd.add("roll", RollMassage)

function TryMassage(pPlayer, cmd, args)
	table.remove(args, 1)
	local tblPlayers = {}

	for _, v in pairs(ents.FindInSphere(pPlayer:GetPos(), 300)) do
		table.insert(tblPlayers, v)
	end

	local try = math.random(0, 6) % 2 == 1 and "niepowodzenie" or "sukces"
	netstream.Start(tblPlayers, "RPCommands", team.GetColor(pPlayer:Team()), pPlayer, Color(255, 255, 255, 255), " ", string.Implode(" ", args), ", ", Color(17, 148, 240, 255), try, Color(255, 255, 255, 255), ".")
end

re.cmd.add("try", TryMassage)