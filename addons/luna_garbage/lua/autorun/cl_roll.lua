--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local curPitch = 0
local deg = 0
local inRoll = false

local function rollTo()

	deg = net.ReadInt(16)
	inRoll = true
	curPitch = deg-360

end
net.Receive("ClimbRoll", rollTo)

hook.Add("CalcView", "ClimbRollEffect", function(ply, pos, ang, fov)
	
	if (!inRoll) then return; end
	
	local view = GAMEMODE:CalcView(ply, pos, ang, fov)
	curPitch = math.Approach(curPitch, deg, FrameTime() * 625)
	if curPitch == deg then inRoll = false; end
	view.angles.p = curPitch
	return view
	
end)



--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
