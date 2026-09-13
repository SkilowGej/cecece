--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

SWEP.PrintName = "Głośnik"
SWEP.Author = "Dannelor"
SWEP.Purpose = "Amplifies the distance a players voice can be heard."
SWEP.Instructions = "Select swep and change settings"

SWEP.BobScale = 0
SWEP.SwayScale = 0
SWEP.BounceWeaponIcon = false

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.slot = 5

local color_grayDarkner = Color(31, 31, 31)
local color_gray = Color(75, 75, 75)
local color_grayLighter = Color(92, 92, 92)
local color_yellow = Color(255, 255, 0)

function SWEP:DrawHUD()
	local W, H = ScrW(), ScrH()
	local wide, height = 33, 33
	local _remap = math.Remap((self:GetNextPrimaryFire() - CurTime()) / 10, 0, 1, 1, 0)
	local _barHeight = math.min(height * _remap, height)
	draw.RoundedBox(0, 375 - 2, H - height - 21 - 2, wide + 4, height + 4, color_grayLighter)
	draw.RoundedBox(0, 375, H - height - 21, wide, height, color_gray)

	--if self:GetNextPrimaryFire() < CurTime() then
		draw.RoundedBox(0, 375, H - height - 21, wide, height, color_grayDarkner)
	-- else
		draw.RoundedBox(0, 375, H - height - 21, wide, _barHeight, color_grayDarkner)
	--end

	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(self.Announce_icon)
	surface.DrawTexturedRect(377, H - height - 20, 30, 30)

  local ply = LocalPlayer()

  local x, y = ScrW()-1505, ScrH()-40

  draw.ShadowSimpleText("R - Zmiana głosu (Na całą mapę / Lokalny)", luna.LunaMontMini, x, y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
  draw.ShadowSimpleText("LKM / PKM - Odległość promienia głosu", luna.LunaMontMini, x, y+20, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
end

function SWEP:PostDrawViewModel(vm,wep,ply)
  cam.Start3D()
    local dis = math.sqrt(self:GetDistance())
    local AllTalk = self:GetAllTalk()
    render.SetColorMaterial()
    render.DrawSphere(ply:GetPos(),AllTalk and -200 or -dis,20,20,AllTalk and Color(255,0,0,40) or Color(0,255,0,40))
  cam.End3D()
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
