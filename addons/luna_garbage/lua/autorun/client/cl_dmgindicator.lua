--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local indicatorRadius = ScrH() * 0.135 -- how big is the invisible ring that the indicators rotate around?
local indicators = {} -- store all info about damage indicators here

net.Receive("DamageIndicator", function(len)
	local origin = net.ReadVector()
	local amount = net.ReadUInt(16)

	table.insert(indicators, {
		origin = origin,
		startTime = CurTime(),
		lifeTime = 1.45,
		magnitude = math.Clamp((amount / LocalPlayer():GetMaxHealth()) * indicatorRadius, indicatorRadius / 5, indicatorRadius)
	})
end)

do
	local function outBack(t, b, c, d, s)
		if not s then
			s = 1.70158
		end

		t = t / d - 1

		return c * (t * t * ((s + 1) * t + s) + 1) + b
	end

	local gradient = Material("materials/ttt_dmgdirect/indicator.png")
	gradient:SetInt("$flags", 16 + 32 + 128)
	local animTime = 0.25

	hook.Add("HUDPaint", "DamageIndicators.HUDPaint", function()
		local curTime = CurTime()
		local localPlayer = LocalPlayer()
		local localPlayerPos = localPlayer:GetPos()
		local zeroPos = Vector(localPlayerPos.x, localPlayerPos.y, 0)
		local localYaw = localPlayer:EyeAngles().y
		local yawAngle = Angle(0, localYaw, 0)

		surface.SetMaterial(gradient)

		for k, info in pairs(indicators) do
			local elapsed = curTime - info.startTime

			-- If it's past its lifetime, kill it and don't draw it anymore
			if (elapsed > info.lifeTime) then
				indicators[k] = nil
				continue
			end

			local size = info.magnitude
			local localPos = WorldToLocal(info.origin, angle_zero, zeroPos, yawAngle)
			local relativeYaw = -localPos:Angle().y
			local animAdd = elapsed <= animTime and outBack(elapsed, 1, -1, animTime, 2.5) or 0
			local targetX = ScrW() / 2 + math.cos(math.rad(relativeYaw - 90)) * (indicatorRadius - (size / 2) + animAdd * 50)
			local targetY = ScrH() / 2 + math.sin(math.rad(relativeYaw - 90)) * (indicatorRadius - (size / 2) + animAdd * 50)

			surface.SetDrawColor(255, 0, 0, math.sqrt(1 - (elapsed / info.lifeTime)) * 255)
			surface.DrawTexturedRectRotated(targetX, targetY, math.Clamp(size * 0.8, 20, 35), size, -relativeYaw)
		end
	end)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
