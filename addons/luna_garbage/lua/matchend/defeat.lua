--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local DEFEAT = {}

DEFEAT.Name = "PORAZKA"
DEFEAT.Description = "Outcome when players lose an event."
DEFEAT.Font = "gm.matchend"
DEFEAT.Sound = Sound("luna_sound_effects/win_or_lose/defeat.mp3")
DEFEAT.Blur = true
DEFEAT.Freeze = true
DEFEAT.FreezeAdmin = true
DEFEAT.Color = Color(175, 48, 48)

function DEFEAT:Initialize()
	if CLIENT then
		surface.PlaySound(self.Sound)
	end

	self.BaseClass:Initialize()
end

-- if CLIENT then
-- 	-- Default resources
-- 	surface.CreateFont("matchend.battlefront", {
-- 		size = ScreenScale(30),
-- 		font = "Assassin$",
-- 		antialias = true
-- 	})
-- end

-- if SERVER then
-- 	-- Default Resources
-- 	resource.AddFile("resource/fonts/Assassin.ttf")
-- 	resource.AddFile("sound/battlefrontend/defeat.wav")
-- end

matchend.Register("defeat", DEFEAT, "default")


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
