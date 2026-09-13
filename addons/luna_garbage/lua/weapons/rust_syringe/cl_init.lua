--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

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
	surface.SetMaterial(self.Medic_icon)
	surface.DrawTexturedRect(377, H - height - 20, 30, 30)

  local ply = LocalPlayer()

  local x, y = ScrW()-1505, ScrH()-40

  draw.ShadowSimpleText("R - Zmiana głosu (na całej mapie / lokalnie)", luna.LunaMontMini, x, y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
  draw.ShadowSimpleText("LPM / PPM - Odległość promienia głosu", luna.LunaMontMini, x, y+20, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
