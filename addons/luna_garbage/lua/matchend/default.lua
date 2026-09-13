--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local DEFAULT = {}

DEFAULT.Name = "REMIS"
DEFAULT.Description = "Default description."
DEFAULT.Font = "gm.matchend"
DEFAULT.Sound = Sound("luna_sound_effects/win_or_lose/neutral_alt.mp3")
DEFAULT.Blur = true
DEFAULT.Freeze = true
DEFAULT.FreezeAdmin = true
DEFAULT.Color = Color(228, 121, 33)

function DEFAULT:Initialize()

end

function DEFAULT:Think()
end

function DEFAULT:HUDPaint()
	if self.Blur then
		matchend.draw_blur(2, 6)
		DrawBloom(0.7, 0.8, 4, 4, 4, 0, 1, 1, 1)
	end

	surface.SetFont(self.Font)

	local w, h = surface.GetTextSize(self.Name)
	surface.SetTextPos(ScrW() * 0.5 - w * 0.5, ScrH() * 0.5 - h * 0.5)
	surface.SetTextColor(self.Color)
	surface.DrawText(self.Name)

	surface.SetDrawColor(self.Color)
	surface.DrawLine(ScrW() * 0.5 - w * 0.5, ScrH() * 0.5 + h * 0.4, ScrW() * 0.5 + w * 0.5, ScrH() * 0.5 + h * 0.4)
	surface.DrawLine(ScrW() * 0.5 - w * 0.5, ScrH() * 0.5 - h * 0.4, ScrW() * 0.5 + w * 0.5, ScrH() * 0.5 - h * 0.4)
end

matchend.Register("default", DEFAULT)


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
