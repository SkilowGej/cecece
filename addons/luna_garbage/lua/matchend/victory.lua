--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local VICTORY = {}

VICTORY.Name = "ZWYCIĘSTWO"
VICTORY.Description = "Outcome when players win an event."
VICTORY.Font = "gm.matchend"
VICTORY.Sound = Sound("luna_sound_effects/win_or_lose/win.mp3")
VICTORY.Blur = true
VICTORY.Freeze = true
VICTORY.FreezeAdmin = true
VICTORY.Color = Color(45, 110, 250)

function VICTORY:Initialize()
	if CLIENT then
		surface.PlaySound(self.Sound)
	end

	self.BaseClass:Initialize()
end

-- if CLIENT then
-- 	-- Default resources
-- 	surface.CreateFont("gm.4", {
-- 		size = ScreenScale(30),
-- 		font = "Assassin$",
-- 		antialias = true
-- 	})
-- end

-- if SERVER then
-- 	-- Default Resources
-- 	resource.AddFile("resource/fonts/Assassin.ttf")
-- 	resource.AddFile("sound/battlefrontend/win.mp3")
-- end

matchend.Register("victory", VICTORY, "default")


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
