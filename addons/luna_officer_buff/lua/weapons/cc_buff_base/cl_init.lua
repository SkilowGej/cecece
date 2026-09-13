--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
	return
end

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

	if self:GetNextPrimaryFire() < CurTime() then
		draw.RoundedBox(0, 375, H - height - 21, wide, height, color_grayDarkner)
	else
		draw.RoundedBox(0, 375, H - height - 21, wide, _barHeight, color_grayDarkner)
	end

	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(self.Buff_icon)
	surface.DrawTexturedRect(375, H - height - 21, wide, height)

	local ply = LocalPlayer()

    local x, y = ScrW()-1505, ScrH()-40

    draw.ShadowSimpleText("LPM - Użyj Aury.", "lunaMontMini", x, y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
    draw.ShadowSimpleText("Przerwa między użyciami: 30 sek.", "lunaMontMini", x, y+20, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
end

function SWEP:DrawHalos()
	local _haloTarget = {}

	for k, v in pairs(ents.FindInSphere(LocalPlayer():GetPos(), self.Buff_Radius)) do
		if IsValid(v) and v:IsPlayer() and v ~= LocalPlayer() then
			table.insert(_haloTarget, v)
		end
	end

	return _haloTarget
end

hook.Add( "PreDrawHalos", "CC_BuffBase_TargetHalos", function()
if (!IsValid(LocalPlayer()) || !LocalPlayer():Alive()) then return end;
local _activeWeapon = LocalPlayer():GetActiveWeapon();
local _validWeapon = IsValid(_activeWeapon) and weapons.IsBasedOn(_activeWeapon:GetClass(), "cc_buff_base") or false;
if (!_validWeapon) then return end;
halo.Add(_activeWeapon:DrawHalos(), color_yellow, 2, 2, 1, true, false );
end)
local _intensity = 0
local _vig = Material("summe/officer_boost/vignette_w")

local function DrawHUDStuff(color, time)
	local _endTime = CurTime() + time
	local x, y = ScrW(), ScrH()
	local ply = LocalPlayer()

	hook.Add("HUDPaint", "CC_BuffBase_HUDPainting", function()
		if _endTime < CurTime() then
			hook.Remove("HUDPaint", "CC_BuffBase_HUDPainting")

			return
		end

		local FT = FrameTime()
		if not ply:Alive() then return end
		_intensity = math.Approach(_intensity, 2, FT * 3)
		surface.SetMaterial(_vig)
		surface.SetDrawColor(ColorAlpha(color, (50 * _intensity) * 0.3):Unpack())
		surface.DrawTexturedRect(0, 0, x, y)
	end)
end

net.Receive("CC_BuffBase_SetHUDEffect", function(len)
	DrawHUDStuff(net.ReadColor(false), net.ReadFloat())

	if net.ReadBool() then
		surface.PlaySound("luna_sound_effects/aura/start/aura_start_" .. math.random(1,5) .. ".mp3")
	end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
