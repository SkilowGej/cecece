--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

SWEP.Base = "weapon_base"
SWEP.Category = "SUP • Wyposażenie"

SWEP.PrintName = "Lornetka Wskaźnik"
SWEP.Author = "Ace, refactored by DuLL_FoX"
SWEP.Contact = "github.com/hiisuuii/waypointsystem-swep"
SWEP.Instructions = "R to change color, LMB to place/remove, RMB to zoom"

SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/ace/sw/w_macrobinoculars.mdl"

SWEP.AutoSwitchFrom = false
SWEP.AutoSwitchTo = false
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.Weight = 1 
SWEP.DrawAmmo = false
SWEP.DrawWeaponInfoBox = true
SWEP.DrawCrosshair = true

SWEP.Primary = {
    Delay = 1,
    Ammo = "none",
    ClipSize = -1,
    DefaultClip = -1,
    Automatic = false
}

SWEP.Secondary = {
    Ammo = "none",
    ClipSize = -1,
    DefaultClip = -1,
    Automatic = false
}

local COLORS = {
    [1] = "Czerwony",
    [2] = "Zielony",
    [3] = "Niebieski",
    [4] = "Żółty",
    [5] = "Fioletowy"
}

local SOUNDS = {
    place = "kaito/macroping/waypoint_place.mp3",
    remove = "kaito/macroping/waypoint_remove.mp3",
    fail = "kaito/macroping/waypoint_fail.mp3",
    zoom = "kaito/macroping/swep_zoom.mp3",
    change_color = "kaito/macroping/swep_change_color.mp3"
}

if SERVER then
    util.AddNetworkString("wpname")
    util.AddNetworkString("kaito_waypoints_sounds")
end

function SWEP:Initialize()
    self:SetHoldType("camera")
    self.waypointColor = 1
    self.WaypointName = ""
    self.lastReload = -1
    self.zoomed = false
end

function SWEP:ShouldDrawViewModel()
	return false
end

function SWEP:Precache()
    for _, sound in pairs(SOUNDS) do
        util.PrecacheSound(sound)
    end
end

function SWEP:Reload()
    if self.lastReload < CurTime() then 
        self.waypointColor = (self.waypointColor % 5) + 1
        if CLIENT then
            self:EmitSound(SOUNDS.change_color, 35, 100, 1, CHAN_WEAPON)
            self.Owner:ChatPrint("Kolor oznaczenia: " .. COLORS[self.waypointColor])
        end
        self.lastReload = CurTime() + 0.5
    end
end

function SWEP:Deploy()
    self.zoomed = false
end

function SWEP:PrimaryAttack()
    if SERVER then
        if self.Owner:KeyDown(IN_SPEED) and self.Owner:IsAdmin() then
            self:ClearAllWaypoints()
            return 
        end

        local hitPos = self.Owner:GetEyeTrace().HitPos
        local existingWaypoint = self:FindNearbyWaypoint(hitPos)

        if existingWaypoint then
            self:HandleExistingWaypoint(existingWaypoint)
        else
            self:CreateNewWaypoint(hitPos)
        end
    end
end

function SWEP:SecondaryAttack()
    if self.Owner:KeyDown(IN_SPEED) then
        if IsFirstTimePredicted() then
            self:DermaPanel()
            self.zoomed = false
        end
    else
        self:ToggleZoom()
    end
end

function SWEP:DrawHUD()
    self:DrawOverlays()
end

function SWEP:AdjustMouseSensitivity()
    return self.zoomed and 0.2 or 1
end

function SWEP:ClearAllWaypoints()
    for _, v in ipairs(ents.FindByClass("waypoint_marker")) do
        v:Remove()
    end
    self.Owner:ChatPrint("Wszystkie oznaczenia zostały usunięte")
end

function SWEP:FindNearbyWaypoint(pos)
    for _, v in ipairs(ents.FindInSphere(pos, 320)) do
        if v:GetClass() == "waypoint_marker" then
            return v
        end
    end
    return nil
end

function SWEP:HandleExistingWaypoint(waypoint)
    if waypoint:GetWPOwner() == self.Owner or self.Owner:IsAdmin() then
        self:PlaySound("remove")
        waypoint:Remove()
    else
        self.Owner:ChatPrint("To nie jest Twoje oznaczenie! Właściciel: " .. waypoint:GetWPOwner():GetName())
        self:PlaySound("fail")
    end
end

function SWEP:CreateNewWaypoint(pos)
    local ent = ents.Create("waypoint_marker")
    ent:SetPos(pos)
    ent:SetColorType(self.waypointColor)
    ent:SetWPOwner(self.Owner)
    ent:Spawn()
    self:PlaySound("add")
end

function SWEP:PlaySound(soundType)
    local sendCheck = GetConVar("macroping_play_sounds_all"):GetInt()
    net.Start("kaito_waypoints_sounds")
    net.WriteString(soundType)
    if sendCheck == 0 then
        net.Send(self.Owner)
    else
        net.Broadcast()
    end
end

function SWEP:ToggleZoom()
    if IsFirstTimePredicted() then
        self.zoomed = not self.zoomed
        if IsValid(self.Owner) then
            self.Owner:SetFOV(self.zoomed and 20 or 0, 0.3)
            if CLIENT and GetConVar("macroping_play_zoom_sounds"):GetInt() != 0 then
                self:EmitSound(SOUNDS.zoom, 40, 100, 1, CHAN_WEAPON)
            end
        end
    end
end


function SWEP:DrawOverlays()
    if GetConVar("macroping_draw_overlay"):GetInt() != 0 then
        local binOverlay = Material("kaito/bino_overlay.png")
        surface.SetDrawColor(0, 0, 0, 255)
        surface.SetMaterial(binOverlay)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    end
end

function SWEP:DermaPanel()
    if CLIENT then
        local Frame = vgui.Create("DFrame")
        local frameW = ScrW() * 300 / 1920
        local frameH = ScrH() * 75 / 1080
        Frame:SetPos(ScrW() / 2 - frameW / 2, ScrH() / 2 - frameH / 2)
        Frame:SetSize(frameW, frameH + 25)
        Frame:SetTitle("Podaj nazwę dla oznaczenia")
        Frame:SetVisible(true)
        Frame:SetDraggable(true)
        Frame:ShowCloseButton(true)
        Frame:MakePopup()

        local NameEntry = vgui.Create("DTextEntry", Frame)
        NameEntry:SetPos(10, 40)
        NameEntry:SetSize(frameW - (ScrW() * 20 / 1920), 25)
        NameEntry:SetText("Nazwa oznaczenia")
        NameEntry:SetUpdateOnType(true)
        NameEntry.OnValueChange = function()
            self.WaypointName = NameEntry:GetValue()
        end
        NameEntry.OnEnter = function()
            self.WaypointName = NameEntry:GetValue()
            net.Start("wpname")
            net.WriteString(self.WaypointName)
            net.SendToServer()
        end

        local desc = vgui.Create("DLabel", Frame)
        desc:SetPos(10, 70)
        desc:SetSize(frameW - (ScrW() * 20 / 1920), 25)
        desc:SetText("ENTER dla potwierdzenia")
    end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
