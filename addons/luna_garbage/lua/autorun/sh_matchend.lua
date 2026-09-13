--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

----------------------
-- matchend Library --
----------------------

local AdminHide = CreateConVar("matchend_hide", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Should admins and superadmins have their HUD hidden too?")

matchend = matchend or {}
matchend.Outcomes = {}
matchend.Indexes = {}
matchend.Active = false
matchend.Current = nil

function matchend.Register(name, tbl, base)
  if name == "stop" then error("matchend.Register - cannot register outcome with name '" .. name "'! Stop is reserved internally.") end

  matchend.Outcomes[name] = tbl

  local i = 0
  if name ~= "default" then
    i = table.insert(matchend.Indexes, name)
  else
    matchend.Indexes[0] = name
  end

  if base then
    if not matchend.Outcomes[base] then ErrorNoHalt( "matchend.Register - deriving " .. name .. " from unknown outcome " .. base .. "!\n" ) end
    setmetatable(matchend.Outcomes[name], {__index = matchend.Outcomes[base]})
    matchend.Outcomes[name].BaseClass = matchend.Outcomes[base]
  end

  if SERVER then
    util.AddNetworkString(name)
  end

  baseclass.Set(name, matchend.Outcomes[name])

  return i
end

function matchend.IsActive()
  return matchend.Active
end

function matchend.GetByName(name)
  return matchend.Outcomes[name]
end

function matchend.GetByIndex(index)
  return matchend.Outcomes[matchend.Indexes[index]]
end

function matchend.GetAllOutcomes()
  return matchend.Outcomes
end

local blur = Material("pp/blurscreen")

function matchend.draw_blur(a, d)
  if not CLIENT then return end

  local X, Y = 0, 0

  surface.SetDrawColor(255,255,255)
  surface.SetMaterial(blur)

  for i = 1, 5 do
    blur:SetFloat("$blur", (i / d) * a)
    blur:Recompute()

    render.UpdateScreenEffectTexture()

    render.SetScissorRect(X, Y, X + ScrW(), Y + ScrH(), true)
      surface.DrawTexturedRect(X * -1, Y * -1, ScrW(), ScrH())
    render.SetScissorRect(0, 0, 0, 0, false)
  end
end

---------------------
-- OUTCOME LOADING --
---------------------

if SERVER then
  AddCSLuaFile()

  AddCSLuaFile("matchend/default.lua")
  include("matchend/default.lua")

  local files, _ = file.Find("matchend/*", "LUA")
  for _, f in SortedPairs(files) do
    if f == "default.lua" then continue end

    AddCSLuaFile("matchend/" .. f)
    include("matchend/" .. f)
  end
end

if CLIENT then
  include("matchend/default.lua")

  local files, _ = file.Find("matchend/*", "LUA")
  for _, f in SortedPairs(files) do
    if f == "default.lua" then continue end

    include("matchend/" .. f)
  end
end

--------------------
-- INTERNAL SETUP --
--------------------

if SERVER then
  util.AddNetworkString("matchend.update")
  util.AddNetworkString("matchend.start")

  -- Receive client console command
  net.Receive("matchend.update", function(len, ply)
    if not (ply:IsAdmin() or ply:IsSuperAdmin()) then
      return
    end

    local option = net.ReadInt(8)
    local time = net.ReadUInt(32)
    local custom = net.ReadBool()

    local custom_table = nil
    if custom then
      custom_table = net.ReadTable()
    end

    local tbl = player.GetAll()

    if option == -1 then
      matchend.Active = false

      for k, v in pairs(tbl) do
        v:Freeze(false)
      end
    end

    local outcome

    if not custom and option ~= -1 then
      outcome = matchend.GetByIndex(option)
    else
      outcome = custom_table
    end

    net.Start("matchend.start")
      net.WriteInt(option, 8)

      if custom then
        net.WriteTable(outcome)
      end
    net.Send(tbl)

    if option == -1 then hook.Run("matchend.Stop") return end

    hook.Run("matchend.Start", outcome)

    matchend.Active = true

    -- Freeze all players (and optionally admins)
    for k, v in pairs(tbl) do
      if not outcome.Freeze then break end
      if not outcome.FreezeAdmin and (v:IsAdmin() or v:IsSuperAdmin()) then continue end
      v:Freeze(true)
    end

    -- Timer to stop outcome on an option delay
    if matchend.IsActive() and time > 0 then
      timer.Simple(time, function()
        if not matchend.IsActive() then return end

        tbl = player.GetAll()

        net.Start("matchend.start")
          net.WriteInt(-1, 8)
        net.Send(tbl)

        for k, v in pairs(tbl) do
          v:Freeze(false)
        end

        hook.Run("matchend.Stop")
      end)
    end
  end)
end

if CLIENT then
  net.Receive("matchend.start", function()
    local option = net.ReadInt(8)

    -- Remove old hooks before starting/stopping outcome sequence
    hook.Remove("HUDPaint", "matchend.HUDPaint")
    hook.Remove("Think", "matchend.Think")

    if option == -1 then
      matchend.Active = false
      return
    end

    matchend.Active = true

    local outcome
    if option ~= 0 then
      outcome = matchend.GetByIndex(option)
    else
      outcome = net.ReadTable()
    end

    if option ~= 0 then
      outcome:Initialize()

      hook.Add("HUDPaint", "matchend.HUDPaint", function()
        outcome:HUDPaint()
      end)

      hook.Add("Think", "matchend.Think", function()
        outcome:Think()
      end)
    else
      if string.len(outcome.Sound) > 0 then
        surface.PlaySound(outcome.Sound)
      end

      hook.Add("HUDPaint", "matchend.HUDPaint", function()
        if outcome.Blur then
          matchend.draw_blur(2, 6)
          DrawBloom(0.7, 0.8, 4, 4, 4, 0, 1, 1, 1)
        end

        surface.SetFont(outcome.Font or "Default")

        local w, h = surface.GetTextSize(outcome.Name or "Custom Name")
        surface.SetTextPos(ScrW() * 0.5 - w * 0.5, ScrH() * 0.5 - h * 0.5)
        surface.SetTextColor(outcome.Color or Color(255, 255, 255))
        surface.DrawText(outcome.Name or "Custom Name")

        surface.SetDrawColor(outcome.Color or Color(255, 255, 255))
        surface.DrawLine(ScrW() * 0.5 - w * 0.5, ScrH() * 0.5 + h * 0.4, ScrW() * 0.5 + w * 0.5, ScrH() * 0.5 + h * 0.4)
        surface.DrawLine(ScrW() * 0.5 - w * 0.5, ScrH() * 0.5 - h * 0.4, ScrW() * 0.5 + w * 0.5, ScrH() * 0.5 - h * 0.4)
      end)
    end
  end)

  -- Internal matchend command, can still be used if desired.
  concommand.Add("_matchend", function(ply, cmd, args)
    if not (ply:IsAdmin() or ply:IsSuperAdmin()) then
      return
    end

    if not args[1] then
      print("Please enter a valid argument!")

      return
    end

    local stop = string.lower(args[1]) == "stop"
    local option = matchend.Outcomes[args[1]]

    if option == nil and not stop then
      print("Please enter a valid argument!")

      return
    end

    local time = math.abs(tonumber(args[2] or 0))

    net.Start("matchend.update")
      net.WriteInt(not stop and table.KeyFromValue(matchend.Indexes, args[1]) or -1, 8)
      net.WriteUInt(time, 32)
      net.WriteBool(false)
    net.SendToServer()
  end, nil, "Start or stop a Battlefront 2 (2005) style end screen.")

  -- Stop command is hard coded in.
  concommand.Add("matchend_stop", function(ply, cmd, args)
    RunConsoleCommand("_matchend", "stop")
  end)

  concommand.Add("matchend_custom", function(ply, cmd, args)
    if not (ply:IsAdmin() or ply:IsSuperAdmin()) then
      return
    end

    local outcome = {
      Name = cvars.String("matchend_custom_name", "Custom Name"),
      Time = cvars.Number("matchend_custom_time", 0),
      Freeze = cvars.Bool("matchend_custom_freeze", true),
      FreezeAdmin = cvars.Bool("matchend_custom_freezeadmin", true),
      Blur = cvars.Bool("matchend_custom_blur", false),
      Font = cvars.String("matchend_custom_font", "Default") or "Default",
      Sound = cvars.String("matchend_custom_sound", ""),
      Color = Color(
        cvars.Number("matchend_custom_color_r", 255) or 255,
        cvars.Number("matchend_custom_color_g", 255) or 255,
        cvars.Number("matchend_custom_color_b", 255) or 255,
        cvars.Number("matchend_custom_color_a", 255) or 255
      )
    }

    net.Start("matchend.update")
      net.WriteInt(0, 8)
      net.WriteUInt(cvars.Number("matchend_custom_time", 0), 32)
      net.WriteBool(true)
      net.WriteTable(outcome)
    net.SendToServer()
  end)

  --------------------
  -- GAMEMODE HOOKS --
  --------------------

  -- Dynamically create a command for every outcome
  hook.Add("Initialize", "matchend.Initialize", function()
    for name, outcome in pairs(matchend.Outcomes) do
      if name == "default" then continue end
      concommand.Add("matchend_" .. name, function(ply, cmd, args)
        if not (ply:IsAdmin() or ply:IsSuperAdmin()) then return end
        RunConsoleCommand("_matchend", name, args[1])
      end, nil, outcome.Description)
    end
  end)

  -- Stop drawing the scoreboard during an actively playing outcome
  hook.Add("ScoreboardShow", "matchend.ScoreboardShow", function()
    if matchend.IsActive() and ((not AdminHide:GetBool() and not LocalPlayer():IsAdmin() or not LocalPlayer():IsSuperAdmin()) or AdminHide:GetBool()) then return false end
  end)

  -- Stop drawing most HUD elements during an actively playing outcome
  local hud = { ["CHudGMod"] = true, ["NetGraph"] = true, ["CHudMenu"] = true, ["CHudChat"] = true }
  hook.Add("HUDShouldDraw", "matchend.HUDShouldDraw", function(name)
    if matchend.IsActive() and ((not AdminHide:GetBool() and not LocalPlayer():IsAdmin() or not LocalPlayer():IsSuperAdmin()) or AdminHide:GetBool()) and not hud[name] then return false end
  end)

  ------------------------
  -- SPAWNMENU SETTINGS --
  ------------------------

  hook.Add("AddToolMenuCategories", "matchend.AddToolMenuCategories", function()
    spawnmenu.AddToolCategory("Utilities", "Match End", "Match End")
  end)

  local MATCHEND_DEFAULTS = {
    matchend_hide = "1",
    matchend_custom_name = "Custom",
    matchend_custom_color_r = "255",
    matchend_custom_color_g = "255",
    matchend_custom_color_b = "255",
    matchend_custom_color_a = "255",
    matchend_custom_freeze = "1",
    matchend_custom_freezeadmin = "1",
    matchend_custom_font = "Default",
    matchend_custom_blur = "0",
    matchend_custom_sound = "",
    matchend_custom_time = 5
  }

  CreateClientConVar("matchend_custom_name", "Custom", true, true, "Custom name for custom Match End.")
  CreateClientConVar("matchend_custom_color_r", "255", true, true, "Custom color (R) for custom Match End.")
  CreateClientConVar("matchend_custom_color_g", "255", true, true, "Custom color (G) for custom Match End.")
  CreateClientConVar("matchend_custom_color_b", "255", true, true, "Custom color (B) for custom Match End.")
  CreateClientConVar("matchend_custom_color_a", "255", true, true, "Custom color (A) for custom Match End.")
  CreateClientConVar("matchend_custom_freeze", "1", true, true, "Freeze players for custom Match End.")
  CreateClientConVar("matchend_custom_freezeadmin", "1", true, true, "Freeze admins for custom Match End.")
  CreateClientConVar("matchend_custom_font", "Default", true, true, "Custom font for custom Match End.")
  CreateClientConVar("matchend_custom_blur", "0", true, false, "Use blur for custom Match End.")
  CreateClientConVar("matchend_custom_sound", "", true, true, "Custom sound for custom Match End.")
  CreateClientConVar("matchend_custom_time", "5", true, true, "Custom time for custom Match End.")

  hook.Add("PopulateToolMenu", "matchend.PopulateToolMenu", function()
    spawnmenu.AddToolMenuOption("Utilities", "Match End", "matchend", "Settings", "", "", function(panel)
      panel:Help("Match End Settings")

      panel:AddControl("ComboBox", {
        MenuButton = 1,
        Folder = "util_matchend",
        Options = {
          ["#preset.default"] = MATCHEND_DEFAULTS
        },
        CVars = table.GetKeys(MATCHEND_DEFAULTS)
      })

      panel:Help("Preset Endings")

      panel:ControlHelp("Custom Lua endings will appear here.")

      for name, ending in pairs(matchend.Outcomes) do
        if name == "default" then continue end

        panel:Button(string.upper(ending.Name), "matchend_" .. name, 5)
      end

      panel:Help("")

      panel:Button("STOP", "matchend_stop")

      panel:Help("Admin Settings")

      panel:CheckBox("Admin Hide", "matchend_hide")

      panel:ControlHelp("Should admins and superadmins have their HUD hidden too?")

      panel:Help("Custom Match Ending")

      panel:ControlHelp("Create a custom ending and execute it.")

      panel:TextEntry("Name:", "matchend_custom_name")

      panel:NumSlider("Time:", "matchend_custom_time", 0, 60, 1)

      panel:CheckBox("Freeze Players", "matchend_custom_freeze")
      panel:CheckBox("Freeze Admins", "matchend_custom_freezeadmin")
      panel:CheckBox("Blur Screen", "matchend_custom_blur")

      panel:AddControl("Color", { Label = "Color:", Red = "matchend_custom_color_r", Green = "matchend_custom_color_g", Blue = "matchend_custom_color_b", Alpha = "matchend_custom_color_a" })

      panel:TextEntry("Font:", "matchend_custom_font")
      panel:TextEntry("Sound:", "matchend_custom_sound")

      panel:Button("Run Custom Ending", "matchend_custom")
    end)
  end)
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
