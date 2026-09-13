--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

TOOL.Category = "SUP • tools"
TOOL.Name = "Spawner NPC"
TOOL.Command = nil
TOOL.ConfigName = ""
TOOL.CurrentPoints = {}
AddCSLuaFile("includes/modules/pon.lua")
require("pon")
local WEAPON_PROFICIENCY_RANDOM = 5
local ToolData = {
	preset = "Standard",
	keyValues = {},
	relationships = {},
	-- Serverside Data
	server = {
		spawners = {},
		data = {},
		conVars = {}
	}
}

local t_npcflags = {{256, "Zwiększony zasięg"}, {2, "Cicho w spoczynku"}, {16, "Pasywność"}, {1024, "Zawsze aktywny"}}
if CLIENT then
	--if (LocalPlayer():IsAdmin() or LocalPlayer():IsSuperAdmin()) then return end
	--------------------------------------CLIENT----------------------------------------
	TOOL.Information = {
		{
			name = "desc"
		},
		{
			name = "left"
		},
		{
			name = "right"
		}
	}

	TOOL.ClientConVar["tooltype"] = "1"
	TOOL.ClientConVar["npcgivehealth"] = "100"
	TOOL.ClientConVar["npcgivedamage"] = "20"
	TOOL.ClientConVar["npcscale"] = 1
	for k, v in ipairs(t_npcflags) do
		TOOL.ClientConVar["SF_" .. v[1]] = 0
	end

	------------------ПАТРУЛЬ РОТЫ------------------------------------------------------------------------
	TOOL.ClientConVar["show"] = 1
	TOOL.ClientConVar["showchance"] = 0
	TOOL.ClientConVar["autolink"] = 1
	TOOL.ClientConVar["walk"] = 0
	TOOL.ClientConVar["type"] = 0
	TOOL.ClientConVar["undirected"] = 0
	TOOL.ClientConVar["strict"] = 0
	TOOL.ClientConVar["wait"] = 0
	TOOL.ClientConVar["chance"] = 1
	TOOL.ClientConVar["initnode"] = 1
	TOOL.ClientConVar["aarange"] = 100
	TOOL.ClientConVar["aafilter"] = "npc_citizen,npc_combine_s"
	TOOL.ClientConVar["toolmode"] = "npc"
	local PatrolPoints = {}
	local PatrolLinks = {}
	local PointEffects = {}
	local selected = -1
	-- ###################################################### --
	-- #################### FUNCTIONS ####################### --
	-- ###################################################### --
	local function CreatePatrolPointEffect(pos)
		local new = patrolPoint()
		if not new then return end
		new:SetOrigin(pos)
		return new
	end

	local function GetTraceEffect()
		local pl = LocalPlayer()
		local pos = pl:GetShootPos()
		local dir = pl:GetAimVector()
		local eClosest
		local distClosest = math.huge
		for _, e in ipairs(PointEffects) do
			local hit, norm = util.IntersectRayWithOBB(pos, dir * 32768, e:GetPos(), Angle(0, 0, 0), e:GetRenderBounds())
			if hit then
				local d = e:GetPos():Distance(pos)
				if d < distClosest then
					distClosest = d
					eClosest = _
				end
			end
		end
		return PointEffects[eClosest], eClosest
	end

	local mat = Material("trails/physbeam")
	local function ShowPatrolPoints(b)
		hook.Remove("RenderScreenspaceEffects", "kotenpctool_npctool_renderpoints")
		for _, ent in ipairs(PointEffects) do
			ent.pr_remove = true
		end

		table.Empty(PointEffects)
		--print(b)
		if not b then return end
		for k, point in ipairs(PatrolPoints) do
			PointEffects[k] = CreatePatrolPointEffect(point[1])
			if PointEffects[k] and PointEffects[k]:IsValid() then
				PointEffects[k]:SetID(k)
				PointEffects[k]:SetWait(point[2])
			end
		end

		local offset = Vector(0, 0, 0)
		local colDefault = Color(255, 255, 255, 255)
		local colHighlighted = Color(0, 255, 0, 255)
		local colSelected = Color(255, 0, 0, 255)
		hook.Add("RenderScreenspaceEffects", "kotenpctool_npctool_renderpoints", function()
			if #PointEffects == 0 and #PatrolLinks == 0 then return end
			cam.Start3D(EyePos(), EyeAngles())
			render.SetMaterial(mat)
			local num = #PatrolLinks
			local effect = GetTraceEffect()
			for i = 1, num do
				local p = PointEffects[PatrolLinks[i][2]]
				local pPrev = PointEffects[PatrolLinks[i][1]]
				local distance = pPrev:GetPos():Distance(p:GetPos())
				if pPrev == effect then
					render.DrawBeam(pPrev:GetPos() + offset, p:GetPos() + offset, 5, CurTime() + 2 * distance / 75, CurTime(), colHighlighted)
				else
					render.DrawBeam(pPrev:GetPos() + offset, p:GetPos() + offset, 5, CurTime() + 2 * distance / 75, CurTime(), colDefault)
				end
			end

			if GetConVarNumber("kotenpctool_npctool_showchance") ~= 0 then
				for i = 1, num do
					local p = PointEffects[PatrolLinks[i][2]]
					local pPrev = PointEffects[PatrolLinks[i][1]]
					local ang = LocalPlayer():EyeAngles()
					local pos = (pPrev:GetPos() + p:GetPos()) / 2 + Vector(0, 0, 20)
					ang:RotateAroundAxis(ang:Forward(), 90)
					ang:RotateAroundAxis(ang:Right(), 90)
					cam.Start3D2D(pos, Angle(0, ang.y, 90), 0.5)
					if pPrev == effect then
						draw.DrawText("Chance: " .. PatrolLinks[i][3], "default", 2, 2, colHighlighted, TEXT_ALIGN_CENTER)
					else
						draw.DrawText("Chance: " .. PatrolLinks[i][3], "default", 2, 2, colDefault, TEXT_ALIGN_CENTER)
					end

					cam.End3D2D()
				end
			end

			cam.End3D()
			for k, v in pairs(PointEffects) do
				if k == selected then
					v:SetColor(colSelected)
				elseif v == effect then
					v:SetColor(colHighlighted)
				else
					v:SetColor(colDefault)
				end
			end
		end)
	end

	local pointsvisible = false
	-- This check is probably extremelly inefficient, but I had to do it because TOOL:Deploy() and TOOL:Holster() are extremely buggy:
	-- Both TOOL:Deploy() and TOOL:Holster() are executed more than once when you do one of those actions
	-- Also, when you do LocalPlayer():GetActiveWeapon() inside those functions, it returns the weapon you"re switching to in singleplayer,
	-- but in multiplayer it returns the weapon you"re switching from!
	-- I had to completely remove the deploy and holster event.
	hook.Add("Think", "kotenpctool_npctool_checkvisibility", function()
		if pointsvisible == true then
			if GetConVarNumber("kotenpctool_npctool_show") == 0 or not IsValid(LocalPlayer()) or not LocalPlayer():Alive() or not IsValid(LocalPlayer():GetActiveWeapon()) or LocalPlayer():GetActiveWeapon():GetClass() ~= "gmod_tool" or LocalPlayer():GetActiveWeapon():GetMode() ~= "kotenpctool_npctool" then
				pointsvisible = false
				ShowPatrolPoints(false)
			end
		else
			if GetConVarNumber("kotenpctool_npctool_show") ~= 0 and IsValid(LocalPlayer()) and LocalPlayer():Alive() and IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() == "gmod_tool" and LocalPlayer():GetActiveWeapon():GetMode() == "kotenpctool_npctool" then
				pointsvisible = true
				ShowPatrolPoints(true)
			end
		end
	end)

	local function CreatePatrolPoint(pos, wait, chance)
		if GetConVarNumber("kotenpctool_npctool_show") ~= 0 then
			local e = CreatePatrolPointEffect(pos)
			if e then
				e:SetID(table.insert(PointEffects, e))
				e:SetWait(wait)
			end
		end

		local point = table.insert(PatrolPoints, {pos, wait})
		if GetConVarNumber("kotenpctool_npctool_autolink") ~= 0 and point ~= 1 and chance > 0 then table.insert(PatrolLinks, {point - 1, point, chance}) end
		net.Start("sv_kotenpctool_npctool_createundo")
		net.SendToServer()
	end

	cvars.AddChangeCallback("kotenpctool_npctool_show", function(cvar, old, new) ShowPatrolPoints(tobool(new)) end)
	-- What about this?
	--local cvPPointSelected = CreateClientConVar("kotenpctool_npctool_ppoints_select",0,true)
	-- This is useless
	--[[concommand.Add("kotenpctool_npctool_ppoints_add",function(pl,cmd,args)
		local tr = util.TraceLine(util.GetPlayerTrace(pl))
		CreatePatrolPoint(tr.HitPos,GetConVarNumber("kotenpctool_npctool_patrolwait"))
	end)]]
	--
	local function RemovePatrolPoint(ID)
		if not PatrolPoints[ID] then return end
		table.remove(PatrolPoints, ID)
		for i = #PatrolLinks, 1, -1 do
			if PatrolLinks[i][1] == ID or PatrolLinks[i][2] == ID then
				table.remove(PatrolLinks, i)
			else
				if PatrolLinks[i][1] > ID then PatrolLinks[i][1] = PatrolLinks[i][1] - 1 end
				if PatrolLinks[i][2] > ID then PatrolLinks[i][2] = PatrolLinks[i][2] - 1 end
			end
		end

		local ent = PointEffects[ID]
		if ent and ent:IsValid() then
			ent.pr_remove = true
			table.remove(PointEffects, ID)
		end

		for i = ID, #PatrolPoints do
			local e = PointEffects[i]
			e:SetID(i)
		end
	end

	--local function ClearPatrolPoints()
	function kotenpctool_npctool_clear()
		for _, ent in ipairs(PointEffects) do
			if ent:IsValid() then ent.pr_remove = true end
		end

		table.Empty(PatrolPoints)
		table.Empty(PointEffects)
		table.Empty(PatrolLinks)
		net.Start("kotenpctool_npctool_clearundo")
		net.SendToServer()
	end

	-- #################################################### --
	-- #################### NET CLIENT #################### --
	-- #################################################### --
	net.Receive("cl_kotenpctool_npctool_clear", function() kotenpctool_npctool_clear() end)
	net.Receive("cl_kotenpctool_npctool_removelastpoint", function(len) RemovePatrolPoint(#PatrolPoints) end)
	net.Receive("cl_kotenpctool_npctool_createpoint", function(len)
		local effect, effectID = GetTraceEffect()
		if effect then
			if LocalPlayer():KeyDown(IN_USE) then
				if selected == -1 then
					selected = effectID
					hook.Add("Think", "CheckUnselect", function()
						if not LocalPlayer():KeyDown(IN_USE) then
							selected = -1
							hook.Remove("Think", "CheckUnselect")
						end
					end)
				elseif selected == effectID then
					for i = #PatrolLinks, 1, -1 do
						if PatrolLinks[i][1] == effectID or PatrolLinks[i][2] == effectID then table.remove(PatrolLinks, i) end
					end
				elseif selected ~= effectID then
					local found = false
					for k, v in pairs(PatrolLinks) do
						if found == false then
							if v[2] == effectID and v[1] == selected then
								found = true
								table.remove(PatrolLinks, k)
							elseif v[1] == effectID and v[2] == selected then
								found = true
								notification.AddLegacy("Two way links are not permitted", NOTIFY_ERROR, 3)
								surface.PlaySound("buttons/button10.wav")
							end
						end
					end

					if found == false then table.insert(PatrolLinks, {selected, effectID, GetConVarNumber("kotenpctool_npctool_chance")}) end
				end
			else
				RemovePatrolPoint(effectID)
				return
			end
		else
			if not LocalPlayer():KeyDown(IN_USE) then
				local pos = net.ReadVector()
				local wait = GetConVarNumber("kotenpctool_npctool_wait")
				local chance = GetConVarNumber("kotenpctool_npctool_chance")
				CreatePatrolPoint(pos, wait, chance)
			end
		end
	end)

	net.Receive("cl_kotenpctool_npctool_createautoassigner", function(len)
		if not LocalPlayer():KeyDown(IN_USE) then
			if GetConVarString("kotenpctool_npctool_toolmode") == "auto" or GetConVarString("kotenpctool_npctool_toolmode") == "wire" then
				local pos = net.ReadVector()
				--local range = GetConVarNumber("kotenpctool_npctool_aarange")
				--local controller = CreateAutoassigner(pos)
				--if !IsValid(controller) then return end
				net.Start("sv_kotenpctool_npctool_createautoassigner")
				net.WriteVector(pos, 12)
				net.WriteUInt(GetConVarNumber("kotenpctool_npctool_walk"), 1)
				net.WriteUInt(GetConVarNumber("kotenpctool_npctool_type"), 2)
				net.WriteUInt(GetConVarNumber("kotenpctool_npctool_undirected"), 2)
				net.WriteUInt(GetConVarNumber("kotenpctool_npctool_strict"), 1)
				net.WriteUInt(GetConVarNumber("kotenpctool_npctool_initnode"), 12)
				net.WriteUInt(GetConVarNumber("kotenpctool_npctool_aarange"), 12)
				net.WriteString(GetConVarString("kotenpctool_npctool_aafilter"))
				net.WriteString(GetConVarString("kotenpctool_npctool_toolmode"))
				local numPPoints = #PatrolPoints
				net.WriteUInt(numPPoints, 12)
				for i = 1, numPPoints do
					net.WriteVector(PatrolPoints[i][1])
					net.WriteFloat(PatrolPoints[i][2])
				end

				local numPLinks = #PatrolLinks
				net.WriteUInt(numPLinks, 12)
				for i = 1, numPLinks do
					net.WriteUInt(PatrolLinks[i][1], 12)
					net.WriteUInt(PatrolLinks[i][2], 12)
					net.WriteUInt(PatrolLinks[i][3], 12)
				end

				net.SendToServer()
			end
		end
	end)

	net.Receive("cl_kotenpctool_npctool_recoverpoints", function(len)
		local numPPoints = net.ReadUInt(12)
		kotenpctool_npctool_clear()
		if not numPPoints then return end
		for i = 1, numPPoints do
			local node = net.ReadVector()
			local wait = net.ReadFloat()
			CreatePatrolPoint(node, wait, -1)
		end

		for i = 1, numPPoints do
			local numLinks = net.ReadUInt(12)
			for j = 1, numLinks do
				local next = net.ReadUInt(12)
				local chance = net.ReadUInt(12)
				table.insert(PatrolLinks, {i, next, chance})
			end
		end
	end)

	net.Receive("cl_kotenpctool_npctool_recoverpoints2", function(len)
		local numPPoints = net.ReadUInt(12)
		kotenpctool_npctool_clear()
		if not numPPoints then return end
		for i = 1, numPPoints do
			local node = net.ReadVector()
			local wait = net.ReadFloat()
			CreatePatrolPoint(node, wait, -1)
		end

		local numLinks = net.ReadUInt(12)
		for i = 1, numLinks do
			local prev = net.ReadUInt(12)
			local next = net.ReadUInt(12)
			local chance = net.ReadUInt(12)
			table.insert(PatrolLinks, {prev, next, chance})
		end
	end)

	net.Receive("cl_kotenpctool_npctool_npcpatrol", function(len)
		local ent = net.ReadEntity()
		if LocalPlayer():KeyDown(IN_USE) then
			net.Start("sv_kotenpctool_npctool_recoverpoints")
			net.WriteEntity(ent)
			net.SendToServer()
		else
			if GetConVarString("kotenpctool_npctool_toolmode") == "npc" and ent:IsNPC() then
				net.Start("sv_kotenpctool_npctool_npcpatrol")
				net.WriteEntity(ent)
				net.WriteUInt(GetConVarNumber("kotenpctool_npctool_walk"), 1)
				net.WriteUInt(GetConVarNumber("kotenpctool_npctool_type"), 2)
				net.WriteUInt(GetConVarNumber("kotenpctool_npctool_undirected"), 2)
				net.WriteUInt(GetConVarNumber("kotenpctool_npctool_strict"), 1)
				net.WriteUInt(GetConVarNumber("kotenpctool_npctool_initnode"), 12)
				local numPPoints = #PatrolPoints
				net.WriteUInt(numPPoints, 12)
				for i = 1, numPPoints do
					net.WriteVector(PatrolPoints[i][1])
					net.WriteFloat(PatrolPoints[i][2])
				end

				local numPLinks = #PatrolLinks
				net.WriteUInt(numPLinks, 12)
				for i = 1, numPLinks do
					net.WriteUInt(PatrolLinks[i][1], 12)
					net.WriteUInt(PatrolLinks[i][2], 12)
					net.WriteUInt(PatrolLinks[i][3], 12)
				end

				net.SendToServer()
			elseif ent:GetClass() == "ent_prautoassigner" or ent:GetClass() == "ent_prwireassigner" then
				net.Start("sv_kotenpctool_npctool_updateautoassigner")
				net.WriteEntity(ent)
				net.WriteUInt(GetConVarNumber("kotenpctool_npctool_walk"), 1)
				net.WriteUInt(GetConVarNumber("kotenpctool_npctool_type"), 2)
				net.WriteUInt(GetConVarNumber("kotenpctool_npctool_undirected"), 2)
				net.WriteUInt(GetConVarNumber("kotenpctool_npctool_strict"), 1)
				net.WriteUInt(GetConVarNumber("kotenpctool_npctool_initnode"), 12)
				net.WriteUInt(GetConVarNumber("kotenpctool_npctool_aarange"), 12)
				net.WriteString(GetConVarString("kotenpctool_npctool_aafilter"))
				net.WriteString(GetConVarString("kotenpctool_npctool_toolmode"))
				local numPPoints = #PatrolPoints
				net.WriteUInt(numPPoints, 12)
				for i = 1, numPPoints do
					net.WriteVector(PatrolPoints[i][1])
					net.WriteFloat(PatrolPoints[i][2])
				end

				local numPLinks = #PatrolLinks
				net.WriteUInt(numPLinks, 12)
				for i = 1, numPLinks do
					net.WriteUInt(PatrolLinks[i][1], 12)
					net.WriteUInt(PatrolLinks[i][2], 12)
					net.WriteUInt(PatrolLinks[i][3], 12)
				end

				net.SendToServer()
				notification.AddLegacy("Route and settings updated", NOTIFY_HINT, 3)
			end
			--elseif (GetConVarString("kotenpctool_npctool_toolmode") == "auto" and ent:GetClass() == "ent_prautoassigner") then
			--	net.Start("sv_kotenpctool_npctool_removeautoassigner")
			--		net.WriteEntity(ent)
			--	net.SendToServer()
		end
	end)

	--[[
	net.Receive("kotenpctool_npctool_deploy",function(len)
		if(GetConVarNumber("kotenpctool_npctool_show") != 0) then ShowPatrolPoints(true) end
	end)
	
	net.Receive("kotenpctool_npctool_holster",function(len)
		local pl = LocalPlayer()
		local wep = pl:GetActiveWeapon()
		print(wep:GetClass().."/"..wep:GetMode())
		if(wep:IsValid() && wep:GetClass() == "gmod_tool" && wep:GetMode() == "kotenpctool_npctool") then
			if(GetConVarNumber("kotenpctool_npctool_show") != 0) then ShowPatrolPoints(true) end
			return
		end
		ShowPatrolPoints(false)
	end)
	]]
	--
	-- ##################################################### --
	-- #################### PANEL BUILD #################### --
	-- ##################################################### --
	------------------ПАТРУЛЬ РОТЫ------------------------------------------------------------------------
	------------------NPCСПАВНЕР------------------------------------------------------------------------
	local REL_HATE = 1
	local REL_FEAR = 2
	local REL_LIKE = 3
	local REL_NEUT = 4
	--[[local flags =
{
	{1        ,"Czekaj, aż zobaczy"},
	{2        ,"Wycisz"},
	{4        ,"Padnij na ziemię"},
	{8        ,"Upuść apteczkę"},
	{16       ,"Efektywność"},
	{32       ,"N/A Nie usuwać!"},
	{64       ,"N/A Nie usuwać!"},
	{128      ,"Czekaj na skrypt"},
	{256      ,"Zwiększony zasięg"},
	{512     ,"Usuwaj zwłoki"},
	{1024    ,"Myśl poza widokiem"},
	{2048    ,"Szablon NPC"},
	{4096    ,"Alternatywna kolizja NPC"},
	{8192    ,"Nie upuszczaj broni"},
	{16384   ,"Ignoruj graczy"},
	{65536   ,"Podążaj za graczem"},
	{131072  ,"Medyk"},
	{262144  ,"Losowa głowa"},
	{524288  ,"Uzupełnianie amunicji"},
	{1048576 ,"Brak dowodzenia"},
	{2097152 ,"Nie używaj semaforów"},
	{4194304 ,"losowa głowa męska"},
	{8388608 ,"losowa głowa żeńska"},
	{16777216,"Użyj renderbox"}
}]]
	TOOL.ClientConVar["class"] = "npc_zombie"
	TOOL.ClientConVar["squad"] = ""
	--[[for k,v in ipairs(flags) do
	TOOL.ClientConVar["flag"..k] = 0
end]]
	TOOL.ClientConVar["equipment"] = ""
	TOOL.ClientConVar["delay"] = 4
	TOOL.ClientConVar["max"] = 4
	TOOL.ClientConVar["total"] = 0
	TOOL.ClientConVar["turnon"] = ""
	TOOL.ClientConVar["turnoff"] = ""
	TOOL.ClientConVar["starton"] = 1
	TOOL.ClientConVar["startburrowed"] = 1
	TOOL.ClientConVar["deleteonremove"] = 1
	TOOL.ClientConVar["fadetime"] = 3
	TOOL.ClientConVar["starthealth"] = 0
	TOOL.ClientConVar["maxhealth"] = 0
	TOOL.ClientConVar["npcspawnergivedamage"] = 0
	TOOL.ClientConVar["showeffects"] = 0
	TOOL.ClientConVar["proficiency"] = WEAPON_PROFICIENCY_AVERAGE
	TOOL.ClientConVar["xp"] = 10
	TOOL.preset = "Standard"
	local ConVarsDefault = TOOL:BuildConVarList()
	local function CreateSaveDialog(title, func)
		local Panel = vgui.Create("DFrame")
		Panel:SetSize(220, 110)
		Panel:Center()
		Panel:MakePopup()
		Panel:ShowCloseButton(true)
		Panel:SetTitle(title)
		local NameLabel = vgui.Create("DLabel", Panel)
		NameLabel:SetText("Nazwa:")
		NameLabel:SetPos(20, 40)
		NameLabel:SizeToContents()
		local TextEntry = vgui.Create("DTextEntry", Panel)
		TextEntry:SetSize(146, 16)
		TextEntry:SetPos(55, 42)
		local ButtonSave = vgui.Create("DButton", Panel)
		ButtonSave:SetText("Save")
		ButtonSave:SetSize(180, 21)
		ButtonSave:SetPos(20, 70)
		ButtonSave.DoClick = function()
			Panel:Close()
			if TextEntry:GetValue() == "" then return end
			func(TextEntry:GetValue())
		end

		TextEntry.OnEnter = ButtonSave.DoClick
	end

	------------------NPCСПАВНЕР------------------------------------------------------------------------
	function TOOL:DrawToolScreen(width, height)
		draw.SimpleText("Spawner", "DermaLarge", width / 2, height / 2 - 50, Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText("NPC", "DermaLarge", width / 2, height / 2 - 20, Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		if self:GetClientNumber("tooltype") == 1 then
			draw.SimpleText("USTAWIANIE HP", "DermaLarge", width / 2, height / 2 + 10, Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		elseif self:GetClientNumber("tooltype") == 2 then
			draw.SimpleText("USTAWIANIE STATYSTYK", "DermaLarge", width / 2, height / 2 + 10, Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		elseif self:GetClientNumber("tooltype") == 3 then
			draw.SimpleText("USTAWIANIE FLAG", "DermaLarge", width / 2, height / 2 + 10, Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		elseif self:GetClientNumber("tooltype") == 4 then
			draw.SimpleText("SPAWNER NPC", "DermaLarge", width / 2, height / 2 + 10, Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		elseif self:GetClientNumber("tooltype") == 6 then
			draw.SimpleText("PATROLE", "DermaLarge", width / 2, height / 2 + 10, Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end

	language.Add("tool.kotenpctool_npctool.name", "Spawner NPC")
	language.Add("tool.kotenpctool_npctool.desc", "Wszystkie instrukcje użycia znajdują się w panelu narzędzi")
	language.Add("tool.kotenpctool_npctool.left", "Coś LPM")
	language.Add("tool.kotenpctool_npctool.right", "Coś PPM")
	function TOOL.BuildCPanel(pnl)
		pnl:AddControl("Header", {
			Text = "Spawner NPC",
			Description = [[Duży zestaw przydatnych narzędzi do różnorodnych wydarzeń lub działań NPC]]
		})

		pnl:AddControl("ComboBox", {
			Label = "Typ narzędzia",
			Options = {
				["Ustawianie HP"] = {
					kotenpctool_npctool_tooltype = "1"
				},
				["Ustawianie statystyk"] = {
					kotenpctool_npctool_tooltype = "2"
				},
				["Ustawianie flag"] = {
					kotenpctool_npctool_tooltype = "3"
				},
				["Spawner NPC"] = {
					kotenpctool_npctool_tooltype = "4"
				},
				["Patrole"] = {
					kotenpctool_npctool_tooltype = "6"
				},
			}
		})

		--ВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХП
		local kotenpctoolshppanel = vgui.Create("DForm", pnl)
		pnl:AddItem(form_flags)
		kotenpctoolshppanel:SetExpanded(false)
		kotenpctoolshppanel:SetName("Ustawianie HP")
		kotenpctoolshppanel:Dock(TOP)
		kotenpctoolshppanel:DockMargin(10, 10, 10, 0)
		kotenpctoolshppanel:NumSlider("Ilość HP", "kotenpctool_npctool_npcgivehealth", 0, 9999, 0)
		pnl:AddControl("Header", {
			Text = "Ustawianie HP",
			Description = [[Jeśli wybrano odpowiednie narzędzie, wystarczy dostosować ustawienia i użyć narzędzia, celując w postać niezależną (NPC). Aktywacja (LPM)]]
		})

		--ВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХПВЫДАЧАХП
		--ВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧ
		local kotenpctoolshppanel = vgui.Create("DForm", pnl)
		pnl:AddItem(form_flags)
		kotenpctoolshppanel:SetExpanded(false)
		kotenpctoolshppanel:SetName("Ustawianie statystyk")
		kotenpctoolshppanel:Dock(TOP)
		kotenpctoolshppanel:DockMargin(10, 10, 10, 0)
		kotenpctoolshppanel:NumSlider("Ilość obrażeń", "kotenpctool_npctool_npcgivedamage", 0, 9999, 0)
		kotenpctoolshppanel:NumSlider("Mnożnik rozmiaru", "kotenpctool_npctool_npcscale", 0, 6, 2)
		pnl:AddControl("Header", {
			Text = "Ustawianie statystyk",
			Description = [[Jeśli wybrano odpowiednie narzędzie, wystarczy dostosować ustawienia i użyć narzędzia, celując w postać niezależną (NPC). Aktywacja (LPM)]]})

		--ВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧАУРОНАВЫДАЧ
		--ФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛ
		local kotenpctoolshppanel = vgui.Create("DForm", pnl)
		pnl:AddItem(form_flags)
		kotenpctoolshppanel:SetExpanded(false)
		kotenpctoolshppanel:SetName("Ustawianie flag")
		kotenpctoolshppanel:Dock(TOP)
		kotenpctoolshppanel:DockMargin(10, 10, 10, 0)
		for k, v in ipairs(t_npcflags) do
			kotenpctoolshppanel:CheckBox(v[2], "kotenpctool_npctool_SF_" .. v[1])
		end

		pnl:AddControl("Header", {
			Text = "Ustawianie flag",
			Description = [[Jeśli wybrano odpowiednie narzędzie, wystarczy dostosować ustawienia i użyć narzędzia, celując w postać niezależną (NPC). Aktywacja (LPM)]]
		})

		--ФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛАГИФЛ
		--СПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССП
		local kotenpctoolshppanel = vgui.Create("DForm", pnl)
		pnl:AddItem(form_flags)
		kotenpctoolshppanel:SetExpanded(false)
		kotenpctoolshppanel:SetName("Spawner NPC")
		kotenpctoolshppanel:Dock(TOP)
		kotenpctoolshppanel:DockMargin(10, 10, 10, 0)
		------------------NPCСПАВНЕР------------------------------------------------------------------------------------------NPCСПАВНЕР------------------------------------------------------------------------
		ToolData.PresetComboBox = kotenpctoolshppanel:ComboBox("Preset:")
		ToolData.SavePresetButton = kotenpctoolshppanel:Button("Zapisz preset")
		ToolData.NpcClassSearchBox = kotenpctoolshppanel:TextEntry("Szukaj NPC:")
		ToolData.NpcClassList = vgui.Create("DListView", kotenpctoolshppanel)
		ToolData.NpcClassList:SetHeight(150)
		kotenpctoolshppanel:AddItem(ToolData.NpcClassList)
		--ToolData.CollapsibleFlag = vgui.Create("DForm",kotenpctoolshppanel)
		--kotenpctoolshppanel:AddItem(ToolData.CollapsibleFlag)
		ToolData.Equipment = kotenpctoolshppanel:ComboBox("Wyposażenie", "kotenpctool_npctool_equipment")
		ToolData.Proficiency = kotenpctoolshppanel:ComboBox("Inteligencja", "kotenpctool_npctool_proficiency")
		ToolData.SpawnDelay = kotenpctoolshppanel:NumSlider("Odstęp spawnu", "kotenpctool_npctool_delay", 1, 180, 1)
		ToolData.MaxAliveNPCs = kotenpctoolshppanel:NumSlider("Maksimum NPC", "kotenpctool_npctool_max", 1, 50, 0)
		ToolData.TotalNPCAmount = kotenpctoolshppanel:NumSlider("Łącznie NPC", "kotenpctool_npctool_total", 0, 250, 0)
		ToolData.FadeTime = kotenpctoolshppanel:NumSlider("Znikaj po (sek)", "kotenpctool_npctool_fadetime", 0, 360, 1)
		pnl:ControlHelp("Działa tylko z włączonym zachowywaniem zwłok.")
		ToolData.Inputs = pnl:AddControl("Numpad", {
			Label = "#Włącz",
			Label2 = "#Wyłącz",
			Command = "kotenpctool_npctool_turnon",
			Command2 = "kotenpctool_npctool_turnoff",
			ButtonSize = 16
		})

		ToolData.StartHealth = kotenpctoolshppanel:NumSlider("Zdrowie", "kotenpctool_npctool_starthealth", 0, 1000, 0)
		ToolData.MaxHealth = kotenpctoolshppanel:NumSlider("Maksymalne zdrowie", "kotenpctool_npctool_maxhealth", 0, 1000, 0)
		kotenpctoolshppanel:NumSlider("Ilość obrażeń", "kotenpctool_npctool_npcspawnergivedamage", 0, 9999, 0)
		ToolData.CollapsibleKeyVal = vgui.Create("DForm", kotenpctoolshppanel)
		kotenpctoolshppanel:AddItem(ToolData.CollapsibleKeyVal)
		ToolData.CollapsibleRel = vgui.Create("DForm", kotenpctoolshppanel)
		kotenpctoolshppanel:AddItem(ToolData.CollapsibleRel)
		---- PresetComboBox
		ToolData.PresetComboBox:SetSortItems(false)
		ToolData.PresetComboBox.UpdateData = function()
			ToolData.PresetComboBox:Clear()
			ToolData.PresetComboBox.OnSelect = function() end
			ToolData.PresetComboBox:AddChoice("Standard", true)
			local IDSelected = 1
			for _, f in ipairs(file.Find("npcspawner2/*.txt", "DATA")) do
				local n = string.sub(f, 1, -5)
				local i = ToolData.PresetComboBox:AddChoice(n)
				if n == ToolData.preset then IDSelected = i end
			end

			ToolData.PresetComboBox:ChooseOptionID(IDSelected)
			ToolData.PresetComboBox.OnSelect = function(_, __, val)
				ToolData.preset = val
				ToolData.keyValues = {}
				ToolData.relationships = {}
				if val == "Standard" then
					for k, v in pairs(ConVarsDefault) do
						RunConsoleCommand(k, v)
					end
				else
					local content = file.Read("npcspawner2/" .. val .. ".txt", "DATA")
					if not content then return end
					local data = util.JSONToTable(content)
					if data.keyValues then ToolData.keyValues = data.keyValues end
					if data.relationships then ToolData.relationships = data.relationships end
					for k, v in pairs(ConVarsDefault) do
						if k:StartWith("kotenpctool_npctool_") and data.cvars[k:sub(("kotenpctool_npctool_"):len() + 1)] then RunConsoleCommand(k, data.cvars[k:sub(("kotenpctool_npctool_"):len() + 1)]) end
					end
				end

				ToolData.NpcClassSearchBox:SetValue("")
				for k, v in pairs(ToolData) do
					if type(v) == "Panel" and v.UpdateDataUI and type(v.UpdateDataUI) == "function" then v:UpdateDataUI() end
				end
			end
		end

		ToolData.PresetComboBox:UpdateData()
		---- PresetComboBox End
		---- SavePresetButton
		ToolData.SavePresetButton.DoClick = function()
			CreateSaveDialog("Ustawienia spawnera NPC", function(name)
				if string.Right(name, 4) ~= ".txt" then name = name .. ".txt" end
				local data = {}
				data.cvars = {}
				for k, v in pairs(ConVarsDefault) do
					if k:StartWith("kotenpctool_npctool_") then data.cvars[k:sub(("kotenpctool_npctool_"):len() + 1)] = GetConVarString(k) end
				end

				data.keyValues = ToolData.keyValues
				data.relationships = ToolData.relationships
				file.CreateDir("npcspawner2")
				file.Write("npcspawner2/" .. name, util.TableToJSON(data))
				ToolData.PresetComboBox:UpdateData()
			end)
		end

		---- SavePresetButton End
		---- NpcClassList
		ToolData.NpcClassList:SetMultiSelect(false)
		ToolData.NpcClassList:AddColumn("Imię")
		ToolData.NpcClassList:AddColumn("Podklasa")
		ToolData.NpcClassList:AddColumn("NazwaKodowa")
		ToolData.NpcClassList.UpdateData = function()
			ToolData.NpcClassList:Clear()
			local filter = ToolData.NpcClassSearchBox:GetValue():lower()
			local NpcList = {}
			for k, v in pairs(list.Get("NPC")) do
				if filter == "" or v.Name:lower():find(filter, 1, true) ~= nil or v.Class:lower():find(filter, 1, true) ~= nil or k:lower():find(filter, 1, true) ~= nil then table.insert(NpcList, {v.Name, v.Class, k}) end
			end

			table.sort(NpcList, function(a, b) return a[1]:lower() < b[1]:lower() end)
			-- Disable sending commands right now
			ToolData.NpcClassList.OnRowSelected = function() end
			local selectedLine
			local currentClass = GetConVarString("kotenpctool_npctool_class") or ConVarsDefault["kotenpctool_npctool_class"]
			for k, v in ipairs(NpcList) do
				local currentLine = ToolData.NpcClassList:AddLine(v[1], v[2], v[3])
				currentLine:SetSortValue(1, v[1]:lower())
				currentLine:SetSortValue(2, v[2]:lower())
				currentLine:SetSortValue(3, v[3]:lower())
				if currentClass:lower() == v[3]:lower() then selectedLine = currentLine end
			end

			-- Allow sending commands
			ToolData.NpcClassList.OnRowSelected = function(_, __, row) if row and row.GetColumnText and row:GetColumnText(3) then RunConsoleCommand("kotenpctool_npctool_class", row:GetColumnText(3)) end end
			if selectedLine then ToolData.NpcClassList:SelectItem(selectedLine) end
		end

		ToolData.NpcClassList.UpdateDataUI = ToolData.NpcClassList.UpdateData
		ToolData.NpcClassList:UpdateData()
		ToolData.NpcClassSearchBox:SetUpdateOnType(true)
		ToolData.NpcClassSearchBox.OnValueChange = function() ToolData.NpcClassList:UpdateData() end
		---- NpcClassList End
		---- CollapsibleFlag
		--[[ToolData.CollapsibleFlag:SetExpanded(false)
	ToolData.CollapsibleFlag:SetName("Flagi spawnu")
	ToolData.CollapsibleFlag:ControlHelp("Działa tylko z niektórymi podklasami.")
	
	for k,v in ipairs(flags) do
		ToolData["Flag"..k] = ToolData.CollapsibleFlag:CheckBox(""..v[1]..": "..v[2],"kotenpctool_npctool_flag"..k)
		ToolData["Flag"..k].UpdateData = function(this)
			local conVar = GetConVar("kotenpctool_npctool_flag"..k)
			if conVar then
				this:SetValue(conVar:GetBool())
			else
				this:SetValue(ConVarsDefault["kotenpctool_npctool_flag"..k] or false)
			end
		end
		ToolData["Flag"..k].UpdateDataUI = ToolData["Flag"..k].UpdateData
		ToolData["Flag"..k]:UpdateData()
	end]]
		---- CollapsibleFlag End
		---- Equipment
		ToolData.Equipment:SetSortItems(false)
		ToolData.Equipment.UpdateData = function()
			ToolData.Equipment:Clear()
			ToolData.Equipment:AddChoice("Standard", "_default_weapon")
			ToolData.Equipment:AddChoice("Bezbronny", "")
			ToolData.Equipment:ChooseOptionID(1)
			local currentEquipment = GetConVarString("kotenpctool_npctool_equipment") or ConVarsDefault["kotenpctool_npctool_equipment"]
			local filter = {}
			for k, data in ipairs(list.Get("NPCUsableWeapons")) do
				local showDefault = false
				if currentEquipment == data.class then showDefault = true end
				ToolData.Equipment:AddChoice(data.title, data.class, showDefault)
				filter[k] = true
			end

			for k, data in pairs(list.Get("NPCUsableWeapons")) do
				if not filter[k] then
					local showDefault = false
					if currentEquipment == data.class then showDefault = true end
					ToolData.Equipment:AddChoice(data.title, data.class, showDefault)
				end
			end
		end

		ToolData.Equipment.UpdateDataUI = ToolData.Equipment.UpdateData
		ToolData.Equipment:UpdateData()
		---- Equipment End
		---- Proficiency
		ToolData.Proficiency:SetSortItems(false)
		local choiceTable = {{"Puszek 1", WEAPON_PROFICIENCY_POOR}, {"Zajączek 2", WEAPON_PROFICIENCY_AVERAGE}, {"Królik 3", WEAPON_PROFICIENCY_GOOD}, {"Kot 4", WEAPON_PROFICIENCY_VERY_GOOD}, {"Pies 5", WEAPON_PROFICIENCY_PERFECT}, {"Wilk 6", 5}, {"Losowo", WEAPON_PROFICIENCY_RANDOM}}
		ToolData.Proficiency.UpdateData = function()
			ToolData.Proficiency:Clear()
			local currentProficiency = GetConVarString("kotenpctool_npctool_proficiency") or ConVarsDefault["kotenpctool_npctool_proficiency"]
			for k, v in ipairs(choiceTable) do
				local showDefault = false
				if currentProficiency == v[2] then showDefault = true end
				ToolData.Proficiency:AddChoice(v[1], v[2], showDefault)
			end
		end

		ToolData.Proficiency.UpdateDataUI = ToolData.Proficiency.UpdateData
		ToolData.Proficiency:UpdateData()
		---- Proficiency End
		---- CollapsibleKeyVal
		ToolData.CollapsibleKeyVal:SetExpanded(false)
		ToolData.CollapsibleKeyVal:SetName("Wartości kluczowe")
		ToolData.KeyValList = vgui.Create("DListView", ToolData.CollapsibleKeyVal)
		ToolData.KeyValList:SetHeight(150)
		ToolData.CollapsibleKeyVal:AddItem(ToolData.KeyValList)
		ToolData.KeyValList:AddColumn("Klucz")
		ToolData.KeyValList:AddColumn("Wartość")
		ToolData.KeyValList.UpdateData = function(KVList)
			KVList:Clear()
			local keyValList = {}
			for k, v in pairs(ToolData.keyValues) do
				table.insert(keyValList, {k, v})
			end

			table.sort(keyValList, function(a, b) return a[1]:lower() < b[1]:lower() end)
			for k, v in ipairs(keyValList) do
				local currentLine = KVList:AddLine(v[1], v[2])
				currentLine:SetSortValue(1, v[1]:lower())
				currentLine:SetSortValue(2, v[2]:lower())
			end
		end

		ToolData.KeyValList.UpdateDataUI = ToolData.KeyValList.UpdateData
		ToolData.KeyValList:UpdateData()
		ToolData.AddKeyValue = ToolData.CollapsibleKeyVal:Button("Dodaj wartość kluczową")
		ToolData.RemoveKeyValue = ToolData.CollapsibleKeyVal:Button("Usuń wartość kluczową")
		ToolData.ClearKeyValues = ToolData.CollapsibleKeyVal:Button("Wyczyść wartości kluczowe")
		ToolData.AddKeyValue.DoClick = function()
			local x, y = gui.MousePos()
			local Panel = vgui.Create("DFrame")
			Panel:SetSize(192, 113)
			Panel:SetPos(x - 96, y - 56)
			Panel:MakePopup()
			Panel:ShowCloseButton(true)
			Panel:SetTitle("Dodaj wartość")
			local KeyLabel = vgui.Create("DLabel", Panel)
			KeyLabel:SetText("Klucz:")
			KeyLabel:SetPos(12, 35)
			KeyLabel:SizeToContents()
			local KeyTextEntry = vgui.Create("DTextEntry", Panel)
			KeyTextEntry:SetSize(100, 16)
			KeyTextEntry:SetPos(80, 35)
			local ValueLabel = vgui.Create("DLabel", Panel)
			ValueLabel:SetText("Wartość:")
			ValueLabel:SetPos(12, 60)
			ValueLabel:SizeToContents()
			local ValueTextEntry = vgui.Create("DTextEntry", Panel)
			ValueTextEntry:SetSize(100, 16)
			ValueTextEntry:SetPos(80, 60)
			local OkButton = vgui.Create("DButton", Panel)
			OkButton:SetText("OK")
			OkButton:SetSize(168, 16)
			OkButton:SetPos(12, 85)
			OkButton.DoClick = function()
				Panel:Close()
				if KeyTextEntry:GetValue() == "" then return end
				ToolData.keyValues[KeyTextEntry:GetValue()] = ValueTextEntry:GetValue()
				ToolData.KeyValList:UpdateData()
			end
		end

		ToolData.RemoveKeyValue.DoClick = function()
			local selection = ToolData.KeyValList:GetSelected()
			for k, v in ipairs(selection) do
				ToolData.keyValues[v:GetColumnText(1)] = nil
			end

			ToolData.KeyValList:UpdateData()
		end

		ToolData.ClearKeyValues.DoClick = function()
			ToolData.keyValues = {}
			ToolData.KeyValList:UpdateData()
		end

		---- CollapsibleKeyVal End
		---- CollapsibleRel
		ToolData.CollapsibleRel:SetExpanded(false)
		ToolData.CollapsibleRel:SetName("Relacje")
		ToolData.RelationshipList = vgui.Create("DListView", ToolData.CollapsibleRel)
		ToolData.RelationshipList:SetHeight(150)
		ToolData.CollapsibleRel:AddItem(ToolData.RelationshipList)
		ToolData.RelationshipList:AddColumn("Relacja")
		ToolData.RelationshipList:SetHideHeaders(true)
		ToolData.RelationshipList.UpdateData = function(RelList)
			RelList:Clear()
			for k, v in pairs(ToolData.relationships) do
				local strText
				if v == REL_HATE then
					strText = "Nienawidzi "
				elseif v == REL_FEAR then
					strText = "Boi się "
				elseif v == REL_LIKE then
					strText = "Lubi "
				elseif v == REL_NEUT then
					strText = "Neutralny wobec "
				else
					strText = "Błąd relacji (puste)"
				end

				local name = language.GetPhrase("#" .. k)
				if name[1] == "#" then name = k end
				local currentLine = ToolData.RelationshipList:AddLine(strText .. k)
				currentLine:SetSortValue((strText .. k):lower())
				currentLine.internalKey = k
			end
		end

		ToolData.RelationshipList.UpdateDataUI = ToolData.RelationshipList.UpdateData
		ToolData.RelationshipList:UpdateData()
		ToolData.AddRelationship = ToolData.CollapsibleRel:Button("Dodaj relację")
		ToolData.RemoveRelationship = ToolData.CollapsibleRel:Button("Usuń relację")
		ToolData.ClearRelationships = ToolData.CollapsibleRel:Button("wyczyść relacje")
		ToolData.AddRelationship.DoClick = function()
			local x, y = gui.MousePos()
			local Panel = vgui.Create("DFrame")
			Panel:SetSize(300, 113)
			Panel:SetPos(x - 96, y - 56)
			Panel:MakePopup()
			Panel:ShowCloseButton(true)
			Panel:SetTitle("Dodaj relację")
			local TargetLabel = vgui.Create("DLabel", Panel)
			TargetLabel:SetText("Obiekt:")
			TargetLabel:SetPos(12, 35)
			TargetLabel:SizeToContents()
			local TargetComboBox = vgui.Create("DComboBox", Panel)
			TargetComboBox:SetSize(208, 16)
			TargetComboBox:SetPos(80, 35)
			TargetComboBox:SetSortItems(false)
			local choices = {}
			for _, npc in pairs(list.Get("NPC")) do
				table.insert(choices, {npc.Name, npc.Class})
			end

			table.sort(choices, function(a, b) return a[1]:lower() < b[1]:lower() end)
			TargetComboBox:AddChoice("Gracz", "Player", true)
			local sortedTeamTable = {}
			for k, v in pairs(team.GetAllTeams()) do
				-- Team 0 -> Joining/Connecting
				if k ~= 0 or v.Joinable then table.insert(sortedTeamTable, {k, v}) end
			end

			table.sort(sortedTeamTable, function(a, b) return a[1] < b[1] end)
			for k, v in ipairs(sortedTeamTable) do
				TargetComboBox:AddChoice("Gracz: Drużyna " .. v[2].Name, "Player.team[" .. v[1] .. "]")
			end

			for k, v in ipairs(choices) do
				TargetComboBox:AddChoice(v[1], v[2])
			end

			local RelLabel = vgui.Create("DLabel", Panel)
			RelLabel:SetText("Relacja:")
			RelLabel:SetPos(12, 60)
			RelLabel:SizeToContents()
			local RelComboBox = vgui.Create("DComboBox", Panel)
			RelComboBox:SetSize(208, 16)
			RelComboBox:SetPos(80, 60)
			RelComboBox:SetSortItems(false)
			RelComboBox:AddChoice("Nienawiść", REL_HATE, true)
			RelComboBox:AddChoice("Strach", REL_FEAR)
			RelComboBox:AddChoice("Neutralność", REL_NEUT)
			RelComboBox:AddChoice("Miłość", REL_LIKE)
			local OkButton = vgui.Create("DButton", Panel)
			OkButton:SetText("OK")
			OkButton:SetSize(276, 16)
			OkButton:SetPos(12, 85)
			OkButton.DoClick = function()
				Panel:Close()
				local __, NPC = TargetComboBox:GetSelected()
				local _, Rel = RelComboBox:GetSelected()
				if NPC and Rel then ToolData.relationships[NPC] = Rel end
				ToolData.RelationshipList:UpdateData()
			end
		end

		ToolData.RemoveRelationship.DoClick = function()
			local selection = ToolData.RelationshipList:GetSelected()
			for k, v in ipairs(selection) do
				ToolData.relationships[v.internalKey] = nil
			end

			ToolData.RelationshipList:UpdateData()
		end

		ToolData.ClearRelationships.DoClick = function()
			ToolData.relationships = {}
			ToolData.RelationshipList:UpdateData()
		end

		---- CollapsibleRel End
		---- NumSliders
		ToolData.SpawnDelay.Scratch:SetDecimals(1)
		ToolData.MaxAliveNPCs.Scratch:SetDecimals(0)
		ToolData.TotalNPCAmount.Scratch:SetDecimals(0)
		ToolData.FadeTime.Scratch:SetDecimals(1)
		ToolData.StartHealth.Scratch:SetDecimals(0)
		ToolData.MaxHealth.Scratch:SetDecimals(0)
		if ToolData.Experience then ToolData.Experience.Scratch:SetDecimals(0) end
		---- NumSliders end
		------------------NPCСПАВНЕР------------------------------------------------------------------------------------------NPCСПАВНЕР------------------------------------------------------------------------
		pnl:AddControl("Header", {
			Text = "Spawner NPC",
			Description = [[Jeśli wybrano odpowiednie narzędzie, najedź kursorem na punkt, w którym chcesz utworzyć generator NPC. Aktywuj (LPM) Usuń (PPM)]]
		})

		--СПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССПАВНЕРНПССП
		--ПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТ
		local kotenpctoolshppanel = vgui.Create("DForm", pnl)
		pnl:AddItem(form_flags)
		kotenpctoolshppanel:SetExpanded(false)
		kotenpctoolshppanel:SetName("Patrole")
		kotenpctoolshppanel:Dock(TOP)
		kotenpctoolshppanel:DockMargin(10, 10, 10, 0)
		-----------------------ПАТРУЛЬРОТЫ-------------------------------
		local combobox = kotenpctoolshppanel:ComboBox("Tryb", "kotenpctool_npctool_toolmode")
		combobox:AddChoice("npc")
		combobox:AddChoice("auto")
		combobox:AddChoice("wire")
		kotenpctoolshppanel:CheckBox("Pokaż punkty", "kotenpctool_npctool_show")
		kotenpctoolshppanel:CheckBox("Pokaż szanse", "kotenpctool_npctool_showchance")
		kotenpctoolshppanel:CheckBox("Autowiązanie", "kotenpctool_npctool_autolink")
		kotenpctoolshppanel:CheckBox("Pieszo", "kotenpctool_npctool_walk")
		kotenpctoolshppanel:CheckBox("Ściśle", "kotenpctool_npctool_strict")
		kotenpctoolshppanel:CheckBox("Patrol", "kotenpctool_npctool_type")
		kotenpctoolshppanel:CheckBox("Niezamierzone wiązania", "kotenpctool_npctool_undirected")
		kotenpctoolshppanel:NumSlider("Oczekiwanie", "kotenpctool_npctool_wait", 0, 100, 0)
		kotenpctoolshppanel:NumSlider("Szansa", "kotenpctool_npctool_chance", 0, 100, 0)
		kotenpctoolshppanel:NumSlider("Sześcian startowy", "kotenpctool_npctool_initnode", 0, 100, 0)
		kotenpctoolshppanel:NumSlider("Zasięg autowiązania", "kotenpctool_npctool_aarange", 0, 500, 0)
		kotenpctoolshppanel:TextEntry("Filtr autowiązania", "kotenpctool_npctool_aafilter")
		local function reloadlist(List, prefix)
			if file.Exists("kotenpctool_npctool", "DATA") and file.IsDir("kotenpctool_npctool", "DATA") then
				local files = file.Find("kotenpctool_npctool/*.txt", "DATA")
				List:Clear()
				for k, v in pairs(files) do
					local data = string.Explode("(-)", v)
					if data[1] == prefix and data[2] == game.GetMap() then List:AddLine(string.Explode(".txt", data[3])[1]) end
				end
			else
				file.CreateDir("kotenpctool_npctool")
			end
		end

		local RouteList = vgui.Create("DListView")
		RouteList:SetMultiSelect(false)
		RouteList:AddColumn("Name")
		RouteList:SetMultiSelect(false)
		RouteList:SetTall(100)
		reloadlist(RouteList, "route")
		kotenpctoolshppanel:AddItem(RouteList)
		local Button = kotenpctoolshppanel:Button("Odśwież listę", "")
		Button.DoClick = function() reloadlist(RouteList, "route") end
		Button:SetTall(20)
		local Button = kotenpctoolshppanel:Button("Załaduj", "")
		Button.DoClick = function()
			if RouteList:GetSelected() ~= nil then
				local data = "kotenpctool_npctool/route(-)" .. game.GetMap() .. "(-)" .. RouteList:GetSelected()[1]:GetValue(1) .. ".txt"
				if file.Exists(data, "DATA") and not file.IsDir(data, "DATA") then
					local contents = string.Explode("(_-_)", file.Read(data, "DATA"))
					kotenpctool_npctool_clear()
					local points = pon.decode(contents[1])
					for k, v in pairs(points) do
						CreatePatrolPoint(points[k][1], points[k][2], -1)
					end

					PatrolLinks = pon.decode(contents[2])
				end
			end
		end

		Button:SetTall(20)
		local Button = kotenpctoolshppanel:Button("Usuń", "")
		Button.DoClick = function()
			if RouteList:GetSelected() ~= nil then
				local data = "kotenpctool_npctool/route(-)" .. game.GetMap() .. "(-)" .. RouteList:GetSelected()[1]:GetValue(1) .. ".txt"
				if file.Exists(data, "DATA") and not file.IsDir(data, "DATA") then
					file.Delete(data)
					reloadlist(RouteList, "route")
				end
			end
		end

		Button:SetTall(20)
		local RouteName = kotenpctoolshppanel:TextEntry("Nazwa", "")
		local Button = kotenpctoolshppanel:Button("Zapisz", "")
		Button.DoClick = function()
			if RouteName:GetValue() ~= "" then
				file.Write("kotenpctool_npctool/route(-)" .. game.GetMap() .. "(-)" .. RouteName:GetValue() .. ".txt", pon.encode(PatrolPoints) .. "(_-_)" .. pon.encode(PatrolLinks))
				reloadlist(RouteList, "route")
			end
		end

		Button:SetTall(20)
		-----------------------ПАТРУЛЬРОТЫ-------------------------------
		pnl:AddControl("Header", {
			Text = "Patrole",
			Description = [[Jeśli wybierzesz odpowiednie narzędzie, po prostu dostosuj ustawienia i używaj narzędzia, celując w NPC lub powierzchnię.]]
		})

		pnl:AddControl("Header", {
			Text = "Patrole",
			Description = [[Aktywacja (LPM - dodaj/usuń ścieżkę)]]
		})

		pnl:AddControl("Header", {
			Text = "Patrole",
			Description = [[((E+LPM spowoduje wybranie ścieżki) (E+PPM spowoduje anulowanie zadania)]]
		})

		pnl:AddControl("Header", {
			Text = "Patrole",
			Description = [[(PPM - Przydziela NPC zadanie ukończenia ścieżki)]]
		})

		pnl:AddControl("Header", {
			Text = "Patrole",
			Description = [[(R - Usuń wszystko)]]
		})
		--ПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТРУЛИПАТ
	end

	------------------NPCСПАВНЕР-----------------------------------
	net.Receive("kotenpctool_npctool_requestspawn", function(len, pl)
		if not (LocalPlayer():IsAdmin() or LocalPlayer():IsSuperAdmin()) then return end
		local HitPos = net.ReadVector()
		local SelEntity = LocalPlayer():GetVar("obj_npcroute_selected")
		net.Start("kotenpctool_npctool_spawn")
		net.WriteTable(ToolData.keyValues)
		net.WriteTable(ToolData.relationships)
		net.WriteVector(HitPos)
		net.WriteEntity(SelEntity)
		net.SendToServer()
	end)

	net.Receive("kotenpctool_npctool_requestunspawn", function(len, pl)
		if not (LocalPlayer():IsAdmin() or LocalPlayer():IsSuperAdmin()) then return end
		local HitPos = net.ReadVector()
		net.Start("kotenpctool_npctool_unspawn")
		net.WriteVector(HitPos)
		net.SendToServer()
	end)

	------------------NPCСПАВНЕР-----------------------------------
	net.Receive("kotenpctool_notify_sendtoclient", function()
		local nmsg = net.ReadString()
		notification.AddLegacy("[KOTENPCTOOL] " .. nmsg, 3, 5)
	end)

	function TOOL:LeftClick(tr)
		return true
	end
	--------------------------------------CLIENT----------------------------------------
end

if SERVER then
	--------------------------------------SERVER----------------------------------------
	local debuglogallow = false
	local function debuglog(text)
		if debuglogallow then print("[KOTENPCTOOL] " .. text) end
	end

	function TOOL:LeftClick(tr)
		if not (self:GetOwner():IsAdmin() or self:GetOwner():IsSuperAdmin()) then
			print('не суперадмин ващ пне ропходит')
			return
		end

		if self:GetClientNumber("tooltype") == 1 then
			----------------------------ХПХПХПХПХПХПХППХПХПХПХПХПХПХПХ----------------------------
			debuglog("Użyto ustawiania HP dla NPC")
			kotenpctoolgivehealthtool(tr, self:GetClientNumber("npcgivehealth"), self:GetOwner())
			----------------------------ХПХПХПХПХПХПХППХПХПХПХПХПХПХПХ----------------------------
			----------------------------УРОНУРОНУРОНУРОНУРОНУРОНУРОНУР----------------------------
			return true
		elseif self:GetClientNumber("tooltype") == 2 then
			debuglog("Użyto ustawiania statystyk dla NPC")
			kotenpctoolgivedamagetool(tr, self:GetClientNumber("npcgivedamage"), self:GetClientNumber("npcscale"), self:GetOwner())
			return true
		elseif self:GetClientNumber("tooltype") == 3 then
			----------------------------УРОНУРОНУРОНУРОНУРОНУРОНУРОНУР----------------------------
			debuglog("Użyto ustawiania flag dla NPC")
			local flags = 0
			for k, v in ipairs(t_npcflags) do
				if self:GetClientNumber("SF_" .. v[1], 0) ~= 0 then flags = bit.bor(flags, v[1]) end
			end

			kotenpctoolgiveflagstool(tr, flags, self:GetOwner())
			return true
		elseif self:GetClientNumber("tooltype") == 4 then
			debuglog("Użyto spawnera NPC")
			util.AddNetworkString("kotenpctool_npctool_requestspawn")
			util.AddNetworkString("kotenpctool_npctool_spawn")
			util.AddNetworkString("kotenpctool_npctool_requestunspawn")
			util.AddNetworkString("kotenpctool_npctool_unspawn")
			------------------NPCСПАВНЕР------------------------------------------------------------------------------------------NPCСПАВНЕР------------------------------------------------------------------------
			net.Start("kotenpctool_npctool_requestspawn")
			net.WriteVector(tr.HitPos)
			net.Send(self:GetOwner())
			------------------NPCСПАВНЕР------------------------------------------------------------------------------------------NPCСПАВНЕР------------------------------------------------------------------------
			local RequiredConVars = {"class", "squad", "flag1", "flag2", "flag3", "flag4", "flag5", "flag6", "flag7", "flag8", "flag9", "flag10", "flag11", "flag12", "flag13", "flag14", "flag15", "flag16", "flag17", "flag18", "flag19", "flag20", "flag21", "flag22", "flag23", "flag24", "flag25", "equipment", "delay", "max", "total", "turnon", "turnoff", "starton", "startburrowed", "deleteonremove", "showeffects", "proficiency", "xp", "fadetime", "starthealth", "maxhealth"}
			local function RequestSpawn(keyValues, relationships, spawnPos, ply, startEnt)
				if not (ply:IsAdmin() or ply:IsSuperAdmin()) then return end
				ToolData.server.data.keyValues = keyValues
				ToolData.server.data.relationships = relationships
				ToolData.server.data.spawnPos = spawnPos
				ToolData.server.data.spawnAngle = ply:GetAimVector():Angle().y
				for k, v in ipairs(RequiredConVars) do
					ToolData.server.conVars[v] = ply:GetInfo("kotenpctool_npctool_" .. v)
				end

				local NPCData = list.Get("NPC")[ToolData.server.conVars.class]
				if not NPCData then
					ErrorNoHalt("[KOTENPCTOOL]: Nieprawidłowy typ NPC" .. ToolData.server.conVars.class)
					return
				end

				local NPCClass = NPCData.Class
				if not NPCClass then
					ErrorNoHalt("[KOTENPCTOOL]: Typ NPC " .. ToolData.server.conVars.class .. " jest nieprawidłowy.")
					return
				end

				local NPCSpawner = ents.Create("obj_npcspawner")
				if not IsValid(NPCSpawner) then
					MsgN("[KOTENPCTOOL]: Nie można utworzyć entity (obj_npcspawner).")
					return
				end

				NPCSpawner:SetPos(ToolData.server.data.spawnPos)
				NPCSpawner:SetAngles(Angle(0, ToolData.server.data.spawnAngle, 0))
				NPCSpawner:SetNPCClass(NPCClass)
				NPCSpawner:SetNPCData(NPCData)
				NPCSpawner:SetNPCBurrowed(ToolData.server.conVars.startburrowed)
				NPCSpawner:SetNPCKeyValues(ToolData.server.data.keyValues)
				if ToolData.server.conVars.equipment ~= "" then NPCSpawner:SetNPCEquipment(ToolData.server.conVars.equipment) end
				local flagInt = 0
				local baseFlag = "flag"
				local currentFlag = 1
				local currentFlagValue = 1
				while ToolData.server.conVars[baseFlag .. currentFlag] ~= nil do
					if tonumber(ToolData.server.conVars[baseFlag .. currentFlag]) == 1 then flagInt = flagInt + currentFlagValue end
					currentFlagValue = currentFlagValue * 2
					currentFlag = currentFlag + 1
				end

				NPCSpawner:SetNPCSpawnflags(256 + 512 + 8192)
				NPCSpawner:SetNPCProficiency(ToolData.server.conVars.proficiency)
				NPCSpawner:SetEntityOwner(ply)
				NPCSpawner:SetKeyTurnOn(ToolData.server.conVars.turnon)
				NPCSpawner:SetKeyTurnOff(ToolData.server.conVars.turnoff)
				NPCSpawner:SetSpawnDelay(ToolData.server.conVars.delay)
				NPCSpawner:SetMaxNPCs(ToolData.server.conVars.max)
				NPCSpawner:SetTotalNPCs(ToolData.server.conVars.total)
				NPCSpawner:SetStartOn(ToolData.server.conVars.starton)
				NPCSpawner:SetDeleteOnRemove(ToolData.server.conVars.deleteonremove)
				if NPCSpawner.SetXP then NPCSpawner:SetXP(ToolData.server.conVars.xp or 10) end
				NPCSpawner:SetStartEntity(startEnt)
				NPCSpawner:SetFadeTime(ToolData.server.conVars.fadetime)
				NPCSpawner:SetScrNPCHealth(ToolData.server.conVars.starthealth)
				NPCSpawner:SetScrNPCMaxHealth(ToolData.server.conVars.maxhealth)
				for k, v in pairs(ToolData.server.data.relationships) do
					NPCSpawner:SetDisposition(k, v)
				end

				NPCSpawner:SetPatrolPointsDisabled(true)
				NPCSpawner:Spawn()
				NPCSpawner:SetNW2Int("kotenpctooladddamage", tonumber(self:GetClientNumber("npcspawnergivedamage")))
				NPCSpawner:Activate()
				NPCSpawner:ShowEffects(tonumber(ToolData.server.conVars.showeffects) ~= 0)
				cleanup.Add(ply, "npcs", NPCSpawner)
				undo.Create("SENT")
				undo.AddEntity(NPCSpawner)
				undo.SetPlayer(ply)
				undo.SetCustomUndoText("Usunięto spawner NPC")
				undo.Finish("[KOTENPCTOOL]: Entity skryptowe (Spawner NPC)")
			end

			net.Receive("kotenpctool_npctool_spawn", function(len, ply)
				if not (ply:IsAdmin() or ply:IsSuperAdmin()) then return end
				local wep = ply:GetActiveWeapon()
				if wep:IsValid() and wep:GetClass() == "gmod_tool" and wep:GetMode() == "kotenpctool_npctool" then
					local keyValues = net.ReadTable()
					local relationships = net.ReadTable()
					local spawnPos = net.ReadVector()
					local selEntity = net.ReadEntity()
					PrintTable(keyValues)
					RequestSpawn(keyValues, relationships, spawnPos, ply, selEntity)
				end
			end)
			------------------NPCСПАВНЕР------------------------------------------------------------------------------------------NPCСПАВНЕР------------------------------------------------------------------------
			return true
		elseif self:GetClientNumber("tooltype") == 6 then
			------------------NPCСПАВНЕР------------------------------------------------------------------------------------------NPCСПАВНЕР------------------------------------------------------------------------
			debuglog("Użyto patroli dla NPC")
			util.AddNetworkString("cl_kotenpctool_npctool_createpoint")
			util.AddNetworkString("sv_kotenpctool_npctool_createpoint")
			-- Modified --
			util.AddNetworkString("cl_kotenpctool_npctool_npcpatrol")
			util.AddNetworkString("sv_kotenpctool_npctool_npcpatrol")
			util.AddNetworkString("cl_kotenpctool_npctool_createautoassigner")
			util.AddNetworkString("sv_kotenpctool_npctool_createautoassigner")
			util.AddNetworkString("sv_kotenpctool_npctool_updateautoassigner")
			util.AddNetworkString("sv_kotenpctool_npctool_removeautoassigner")
			-- -- -- -- --
			util.AddNetworkString("kotenpctool_npctool_clearundo")
			--util.AddNetworkString("kotenpctool_npctool_holster")
			--util.AddNetworkString("kotenpctool_npctool_deploy")
			util.AddNetworkString("cl_kotenpctool_npctool_clear")
			util.AddNetworkString("sv_kotenpctool_npctool_createundo")
			util.AddNetworkString("cl_kotenpctool_npctool_removelastpoint")
			util.AddNetworkString("cl_kotenpctool_npctool_recoverpoints")
			util.AddNetworkString("cl_kotenpctool_npctool_recoverpoints2")
			util.AddNetworkString("sv_kotenpctool_npctool_recoverpoints")
			net.Start("cl_kotenpctool_npctool_createpoint")
			net.WriteVector(tr.HitPos + tr.HitNormal * 6)
			net.Send(self:GetOwner())
			-----------------------------------------------PATROLING--------------------------------------------
			-- #################################################### --
			-- #################### NET SERVER #################### --
			-- #################################################### --
			net.Receive("kotenpctool_npctool_clearundo", function(len, pl)
				for _, undo in pairs(undo.GetTable()) do
					for i = #undo, 1, -1 do
						local data = undo[i]
						if data.Name == "PatrolPoint" and data.Owner == pl then table.remove(undo, i) end
					end
				end
			end)

			net.Receive("sv_kotenpctool_npctool_createundo", function(len, pl)
				undo.Create("PatrolPoint")
				undo.AddFunction(function()
					net.Start("cl_kotenpctool_npctool_removelastpoint")
					net.Send(pl)
				end)

				undo.SetPlayer(pl)
				undo.SetCustomUndoText("Undone Patrol Point")
				undo.Finish("Patrol Point")
			end)

			net.Receive("sv_kotenpctool_npctool_recoverpoints", function(len, pl)
				if not (pl:IsAdmin() or pl:IsSuperAdmin()) then return end
				local ent = net.ReadEntity()
				if ent:IsNPC() then
					if not ent.pr_prcontroller or not IsValid(ent.pr_prcontroller) then return end
					net.Start("cl_kotenpctool_npctool_recoverpoints")
					local numPPoints = #ent.pr_prcontroller.pr_nodes
					net.WriteUInt(numPPoints, 12)
					for i = 1, numPPoints do
						net.WriteVector(ent.pr_prcontroller.pr_nodes[i][1])
						net.WriteFloat(ent.pr_prcontroller.pr_nodes[i][2])
					end

					for i = 1, numPPoints do
						local numLinks = #ent.pr_prcontroller.pr_links[i][1]
						net.WriteUInt(numLinks, 12)
						for j = 1, numLinks do
							net.WriteUInt(ent.pr_prcontroller.pr_links[i][1][j][1], 12)
							net.WriteUInt(ent.pr_prcontroller.pr_links[i][1][j][2], 12)
						end
					end

					net.Send(pl)
				elseif ent:GetClass() == "ent_prautoassigner" then
					net.Start("cl_kotenpctool_npctool_recoverpoints2")
					local numPPoints = #ent.pr_nodes
					net.WriteUInt(numPPoints, 12)
					for i = 1, numPPoints do
						net.WriteVector(ent.pr_nodes[i][1])
						net.WriteFloat(ent.pr_nodes[i][2])
					end

					local numLinks = #ent.pr_links
					net.WriteUInt(numLinks, 12)
					for i = 1, numLinks do
						net.WriteUInt(ent.pr_links[i][1], 12)
						net.WriteUInt(ent.pr_links[i][2], 12)
						net.WriteUInt(ent.pr_links[i][3], 12)
					end

					net.Send(pl)
				end
			end)

			net.Receive("sv_kotenpctool_npctool_npcpatrol", function(len, pl)
				if not (pl:IsAdmin() or pl:IsSuperAdmin()) then return end
				local npc = net.ReadEntity()
				local patrolwalk = net.ReadUInt(1)
				local patroltype = net.ReadUInt(2)
				local patrolundirected = net.ReadUInt(2)
				local patrolstrict = net.ReadUInt(1)
				local patrolstart = net.ReadUInt(12)
				local numPPoints = net.ReadUInt(12)
				if IsValid(npc.pr_prcontroller) then npc.pr_prcontroller:Remove() end
				if numPPoints > 0 then
					controller = ents.Create("ent_prcontroller")
					controller:Spawn()
					controller:Activate()
					if not IsValid(controller) then return end
					npc:DeleteOnRemove(controller)
					for i = 1, numPPoints do
						local pos = net.ReadVector()
						local wait = net.ReadFloat()
						controller:AddNode({pos, wait})
					end

					local numPLinks = net.ReadUInt(12)
					for i = 1, numPLinks do
						local a = net.ReadUInt(12)
						local b = net.ReadUInt(12)
						local chance = net.ReadUInt(12)
						controller:AddLink({a, b, chance})
					end

					controller:SetWalk(patrolwalk)
					controller:SetType(patroltype)
					controller:SetUndirected(patrolundirected)
					controller:SetStrictMovement(patrolstrict)
					controller:SetStart(math.Clamp(patrolstart, 1, numPPoints))
					npc.pr_prcontroller = controller
					--npc.pr_prcontroller:SetParent(npc)
					npc.pr_prcontroller:AddNPC(npc)
				else
					npc.pr_prcontroller = nil
				end
			end)

			net.Receive("sv_kotenpctool_npctool_updateautoassigner", function(len, pl)
				if not (pl:IsAdmin() or pl:IsSuperAdmin()) then return end
				local ent = net.ReadEntity()
				local patrolwalk = net.ReadUInt(1)
				local patroltype = net.ReadUInt(2)
				local patrolundirected = net.ReadUInt(2)
				local patrolstrict = net.ReadUInt(1)
				local patrolstart = net.ReadUInt(12)
				local range = net.ReadUInt(12)
				local filter = net.ReadString()
				local mode = net.ReadString()
				local numPPoints = net.ReadUInt(12)
				--if IsValid(ent.pr_prcontroller) then ent.pr_prcontroller:Remove() end
				ent:RemoveRoute()
				if numPPoints > 0 then
					for i = 1, numPPoints do
						local pos = net.ReadVector()
						local wait = net.ReadFloat()
						ent:AddNode({pos, wait})
					end

					local numPLinks = net.ReadUInt(12)
					for i = 1, numPLinks do
						local a = net.ReadUInt(12)
						local b = net.ReadUInt(12)
						local chance = net.ReadUInt(12)
						ent:AddLink({a, b, chance})
					end

					ent:SetWalk(patrolwalk)
					ent:SetType(patroltype)
					ent:SetUndirected(patrolundirected)
					ent:SetStrictMovement(patrolstrict)
					ent:SetStart(math.Clamp(patrolstart, 1, numPPoints))
					if mode == "auto" then
						ent:SetRange(range)
						ent:SetFilter(filter)
						ent:SetNWInt("Range", range)
					end
					--npc.pr_prent = ent
					--npc.pr_prent:SetParent(npc)
					--npc.pr_prent:AddNPC(npc)
					--else
					--npc.pr_prent = nil
					-- Undo
				end
			end)

			net.Receive("sv_kotenpctool_npctool_createautoassigner", function(len, pl)
				if not (pl:IsAdmin() or pl:IsSuperAdmin()) then return end
				local entpos = net.ReadVector()
				--local npc = net.ReadEntity()
				local patrolwalk = net.ReadUInt(1)
				local patroltype = net.ReadUInt(2)
				local patrolundirected = net.ReadUInt(2)
				local patrolstrict = net.ReadUInt(1)
				local patrolstart = net.ReadUInt(12)
				local range = net.ReadUInt(12)
				local filter = net.ReadString()
				local mode = net.ReadString()
				local numPPoints = net.ReadUInt(12)
				if numPPoints > 0 then
					local controller = nil
					if mode == "auto" then
						controller = ents.Create("ent_prautoassigner")
					elseif mode == "wire" then
						if WireAddon == nil then return end
						controller = ents.Create("ent_prwireassigner")
					else
						return
					end

					controller:Spawn()
					controller:Activate()
					controller:SetPos(entpos)
					--if !IsValid(controller) then return end
					--npc:DeleteOnRemove(controller)
					for i = 1, numPPoints do
						local pos = net.ReadVector()
						local wait = net.ReadFloat()
						controller:AddNode({pos, wait})
					end

					local numPLinks = net.ReadUInt(12)
					for i = 1, numPLinks do
						local a = net.ReadUInt(12)
						local b = net.ReadUInt(12)
						local chance = net.ReadUInt(12)
						controller:AddLink({a, b, chance})
					end

					controller:SetWalk(patrolwalk)
					controller:SetType(patroltype)
					controller:SetUndirected(patrolundirected)
					controller:SetStrictMovement(patrolstrict)
					controller:SetStart(math.Clamp(patrolstart, 1, numPPoints))
					if mode == "auto" then
						controller:SetRange(range)
						controller:SetFilter(filter)
						controller:SetNWInt("Range", range)
					end

					--npc.pr_prcontroller = controller
					--npc.pr_prcontroller:SetParent(npc)
					--npc.pr_prcontroller:AddNPC(npc)
					--else
					--npc.pr_prcontroller = nil
					-- Undo
					undo.Create("Autoassigner")
					undo.AddEntity(controller)
					undo.SetPlayer(pl)
					if mode == "auto" then
						undo.SetCustomUndoText("Undone Autoassigner")
					else
						undo.SetCustomUndoText("Undone Wire Assigner")
					end

					undo.Finish("Autoassigner")
				end
			end)

			net.Receive("sv_kotenpctool_npctool_removeautoassigner", function(len, pl)
				local ent = net.ReadEntity()
				if IsValid(pl) and pl:IsPlayer() and IsValid(ent) and ent:GetClass() == "ent_prautoassigner" then ent:Remove() end
			end)
			return true
		end
		-----------------------------------------------PATROLING--------------------------------------------
	end

	------------------NPCСПАВНЕР--------------------
	local function FindNearbySpawner(pos, range)
		local entities = ents.FindInSphere(pos, range)
		local nearest = {}
		for k, v in ipairs(entities) do
			if v:GetClass() == "obj_npcspawner" then
				local entDistance = pos:Distance(v:GetPos())
				if nearest[1] == nil or nearest[1] < entDistance then
					nearest[1] = entDistance
					nearest[2] = v
				end
			end
		end
		return nearest[2]
	end

	function TOOL:RequestUnspawn(hitPos, ply)
		local selSpawner = FindNearbySpawner(hitPos, 64)
		if IsValid(selSpawner) then
			selSpawner:Remove()
			return true
		end
		return false
	end

	function TOOL:RightClick(tr)
		if not (self:GetOwner():IsAdmin() or self:GetOwner():IsSuperAdmin()) then return end
		if self:GetClientNumber("tooltype") == 4 then
			return self:RequestUnspawn(tr.HitPos, self:GetOwner())
		elseif self:GetClientNumber("tooltype") == 6 then
			if tr.Entity:IsValid() and (tr.Entity:IsNPC() or tr.Entity:GetClass() == "ent_prautoassigner" or tr.Entity:GetClass() == "ent_prwireassigner") then
				net.Start("cl_kotenpctool_npctool_npcpatrol")
				net.WriteEntity(tr.Entity)
				net.Send(self:GetOwner())
				return true
			else
				net.Start("cl_kotenpctool_npctool_createautoassigner")
				net.WriteVector(tr.HitPos + tr.HitNormal * 6)
				net.Send(self:GetOwner())
				return true
			end
		end
	end

	function TOOL:Reload(tr)
		if self:GetClientNumber("tooltype") == 6 then
			net.Start("cl_kotenpctool_npctool_clear")
			net.Send(self:GetOwner())
			return true
		end
	end
	------------------NPCСПАВНЕР--------------------
	--------------------------------------SERVER----------------------------------------
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
