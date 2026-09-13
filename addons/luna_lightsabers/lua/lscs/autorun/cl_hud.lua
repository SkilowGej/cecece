--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


LSCS_HUD_POINTS_FORCE = 1
LSCS_HUD_POINTS_BLOCK = 2
LSCS_HUD_POINTS_ADVANTAGE = 3
LSCS_HUD_STANCE = 4

function LSCS:HUDShouldHide( LSCS_HUD )
	local ShouldDraw = hook.Run( "LSCS:HUDShouldDraw", LSCS_HUD )

	if ShouldDraw == false then return true end

	-- if ShouldDraw == true then return false end -- should the hook overpower client settings? i dont know.. If you have this edgecase please make a github issue and i will change this.

	return not LSCS.DrawHud
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
