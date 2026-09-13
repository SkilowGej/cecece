--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--[[
   _____                       _  _____           _                 
  / ____|                     | |/ ____|         | |                
 | (___   __ _ _   _  __ _  __| | (___  _   _ ___| |_ ___ _ __ ___  
  \___ \ / _` | | | |/ _` |/ _` |\___ \| | | / __| __/ _ \ '_ ` _ \ 
  ____) | (_| | |_| | (_| | (_| |____) | |_| \__ \ ||  __/ | | | | |
 |_____/ \__, |\__,_|\__,_|\__,_|_____/ \__, |___/\__\___|_| |_| |_|
            | |                          __/ |                      
            |_|                         |___/                       

	Created by Summe: https://steamcommunity.com/id/DerSumme/ 
    Purchased content: https://discord.gg/k6YdMwj9w2
]]--

/* -------------------------------------------------------------------------- */
/*                       Kicks a player out of the squad                      */
/* -------------------------------------------------------------------------- */

function SquadSystem:RequestSquadKick(target)
    if not LocalPlayer():IsSquadLeader() then return end

    net.Start("SquadSystem.RequestSquadKick")
    net.WriteEntity(target)
    net.SendToServer()
end

/* -------------------------------------------------------------------------- */
/*                   Changes the squad position of a player                   */
/* -------------------------------------------------------------------------- */

function SquadSystem:RequestPositionChange(target, pos)
    if not LocalPlayer():IsSquadLeader() then return end

    net.Start("SquadSystem.RequestPositionChange")
    net.WriteEntity(target)
    net.WriteInt(pos, 8)
    net.SendToServer()
end

/* -------------------------------------------------------------------------- */
/*                        Invites a player to the squad                       */
/* -------------------------------------------------------------------------- */

function SquadSystem:RequestInvitation(ply)
    net.Start("SquadSystem.InvitePlayer")
    net.WriteEntity(ply)
    net.SendToServer()
end

/* -------------------------------------------------------------------------- */
/*                               Leaves a squad                               */
/* -------------------------------------------------------------------------- */

function SquadSystem:RequestLeave()
    net.Start("SquadSystem.RequestLeave")
    net.SendToServer()
end

/* -------------------------------------------------------------------------- */
/*                     Starts communication (action wheel)                    */
/* -------------------------------------------------------------------------- */

function SquadSystem:RequestCommunication(index)
    net.Start("SquadSystem.RequestCommunication")
    net.WriteString(index)
    net.SendToServer()
end

/* -------------------------------------------------------------------------- */
/*                        Starts command (action wheel)                       */
/* -------------------------------------------------------------------------- */

function SquadSystem:RequestCommand(index)
    net.Start("SquadSystem.RequestCommand")
    net.WriteString(index)
    net.SendToServer()
end

/* -------------------------------------------------------------------------- */
/*                        Tries to join a public squad                        */
/* -------------------------------------------------------------------------- */

function SquadSystem:RequestJoinPublic(id)
    net.Start("SquadSystem.RequestJoinPublic")
    net.WriteUInt(id, 6)
    net.SendToServer()
end

/* -------------------------------------------------------------------------- */
/*                      Draws the squadmembers in the HUD                     */
/* -------------------------------------------------------------------------- */

local drawMemberCooldown = CurTime() + 5
local squadMembers = {}

hook.Add("HUDPaint", "SquadSystem.DrawMembers", function()
    if not SquadSystem:NametagsEnabled() then return end
    local squad = LocalPlayer():GetSquad()
    if not squad then return end

    if drawMemberCooldown <= CurTime() then
        squadMembers = squad:GetMembers()
        drawMemberCooldown = CurTime() + 5
    end

    for k, ply in pairs(squadMembers) do
        if not IsValid(ply) then continue end
        if ply == LocalPlayer() then continue end
        if not ply:Alive() then continue end
        local pos = ply:GetPos() +  Vector(0, 0, 30)
        pos = pos:ToScreen()
        SummeLibrary:GetImgurMaterial(SquadSystem.Config.Positions[ply:GetSquadPosition()].imgur, function(material)
            draw.DrawText(ply:Name(), "SquadSystem.PingSmall", pos.x, pos.y - 20, color_white, TEXT_ALIGN_CENTER)
            surface.SetDrawColor(color_white)
            surface.SetMaterial(material)
            surface.DrawTexturedRect(pos.x - 6.5, pos.y, 15, 15)
        end)
    end
end)

/* -------------------------------------------------------------------------- */
/*                Returns whether squadmembers should be drawn                */
/* -------------------------------------------------------------------------- */

function SquadSystem:NametagsEnabled()
    return tobool(cookie.GetNumber("SquadSystem.Nametags", false))
end

/* -------------------------------------------------------------------------- */
/*                Toggles whether squadmembers should be drawn                */
/* -------------------------------------------------------------------------- */

function SquadSystem:ToggleNametags()
    if SquadSystem:NametagsEnabled() then
        cookie.Set("SquadSystem.Nametags", "0")
    else
        cookie.Set("SquadSystem.Nametags", "1")
    end
end

/* -------------------------------------------------------------------------- */
/*                    Requests all squads on initialization                   */
/* -------------------------------------------------------------------------- */

hook.Add("InitPostEntity", "SquadSystem.OnLoad", function()
    net.Start("SquadSystem.RequestSquads")
    net.SendToServer()
end)

/* -------------------------------------------------------------------------- */
/*                  Draws the communication of a squadmember                  */
/* -------------------------------------------------------------------------- */

local mat = Material("particle/particle_ring_wave_addnofog")
local col = Color(255, 255, 255, 5)

function SquadSystem:DoComms(index, ply)
    local data = SquadSystem.Config.Communications[index]
    if not data then return end

    surface.SetFont("SquadSystem.OverHead")
    local w = surface.GetTextSize(data.overheadMsg)

    local hookName = "SquadSystem.Communications."..tostring(ply:SteamID64() or "BOT")
    local removeTime = CurTime() + 10

    surface.PlaySound("summe/squadsystem/comms.mp3")

    SummeLibrary:GetImgurMaterial(data.imgur, function(material)
        hook.Add("PostDrawTranslucentRenderables", hookName, function()
            if removeTime <= CurTime() then
                hook.Remove("PostDrawTranslucentRenderables", hookName)
            end

            if not IsValid(ply) then return end

            local p = ply:GetPos()

            local ang = ply:GetAngles()
            ang:RotateAroundAxis( ang:Forward(), 90 )
            ang:RotateAroundAxis( ang:Up(), 90 )
            ang.y = LocalPlayer():EyeAngles().y - 90

            local t =  math.sin(CurTime() * 3)

            local intPol = math.abs(math.cos(CurTime())) * 255

            local dist = LocalPlayer():GetPos():DistToSqr(p)
            dist = dist / 100000
            dist = math.Clamp(dist, .15, .5)

            cam.Start3D2D(p + Vector( 0, 0, 80 ), Angle( 0, ang.y, 90 ), dist)
                draw.RoundedBox(8, 90, 65, w + 42, 35, Color(0, 0, 0, 150))

                --draw.RoundedBox(0, 30, -7, 3 + w, 1, ColorAlpha(color_white, 50))

                --draw.RoundedBox(0, 30, 17, 3 + w, 1, ColorAlpha(color_white, 50))

                surface.SetDrawColor(ColorAlpha(data.color, intPol))
                surface.SetMaterial(material)
                surface.DrawTexturedRect(95, 70, 25, 25)

                draw.DrawText(data.overheadMsg, "SquadSystem.OverHead", 128, 72, ColorAlpha(Color(255,255,255), intPol), TEXT_ALIGN_LEFT)
            cam.End3D2D()
        end)
    end)
end

/* -------------------------------------------------------------------------- */
/*                      Registers the action wheel hotkey                     */
/* -------------------------------------------------------------------------- */

hook.Add("SquadSystem.Loaded", "SquadSystem.RegisterKeyBinds", function()
    SummeLibrary:RegisterBind({
        name = "SquadSystem - Main",
        key = SquadSystem.Config.Key,
        func = function()
            if not IsValid(SquadSystem.Sideboard) then return end
            if SquadSystem.Sideboard.IsFocused then return end
            SquadSystem.Sideboard:Open()
        end,
    })
end)

/* -------------------------------------------------------------------------- */
/*                                Random stuff                                */
/* -------------------------------------------------------------------------- */

hook.Add("SquadSystem.PostCommand", "adadad", function(index, data, ply)
    if index == "Obrona okrężna!" or index == "Защищать позицию!" then
        local rand = math.random(1, 12)
        surface.PlaySound(string.format("summe/squadsystem/immersive/commands/defend/variant (%s).mp3", rand))
        return
    end

    if index == "Wszyscy żołnierze, atak!" then
        local rand = math.random(1, 8)
        surface.PlaySound(string.format("summe/squadsystem/immersive/commands/attack/variant (%s).mp3", rand))
        return
    end

    if index == "Przerwać ogień!" or index == "Wszyscy do schronu!" then
        local rand = math.random(1, 4)
        surface.PlaySound(string.format("summe/squadsystem/immersive/commands/hold/variant (%s).mp3", rand))
        return
    end

    if index == "Rozproszyć się!" then
        local rand = math.random(1, 3)
        surface.PlaySound(string.format("summe/squadsystem/immersive/commands/spread_out/variant (%s).mp3", rand))
        return
    end

    if index == "Zbiórka!" then
        surface.PlaySound("summe/squadsystem/immersive/commands/other/assemble.mp3")
        return
    end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
