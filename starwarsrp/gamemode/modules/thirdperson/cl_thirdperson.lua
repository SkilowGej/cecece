thirdperson_enabled = thirdperson_enabled or false
local dist = dist or 0
local freecam_ang = nil
local view = {}
thirdperson = thirdperson or {}

thirdperson.x = CreateClientConVar("thirdperson_x", "60", true, false)
thirdperson.y = CreateClientConVar("thirdperson_y", "60", true, false)
thirdperson.z = CreateClientConVar("thirdperson_z", "40", true, false)
local savedAngles = nil

local smoothPos = Vector(0, 0, 0)
local smoothAng = Angle(0, 0, 0)

hook.Add("CreateMove", "Thirdperson_CreateMove", function(cmd)
    if input.IsKeyDown(KEY_LALT) then return end

    return false
end)

hook.Add("Think", "Thirdperson_Think", function()
    if not input.IsKeyDown(KEY_LALT) then
        if savedAngles then
            LocalPlayer().camera_ang = savedAngles
        end

        savedAngles = nil

        return
    end

    savedAngles = savedAngles or LocalPlayer():EyeAngles()
    LocalPlayer():SetEyeAngles(savedAngles)
end)

hook.Add("InputMouseApply", "Thirdperson:Calc", function(cmd, x, y, ang)
    if not input.IsKeyDown(KEY_LALT) then return end
    local ply = LocalPlayer()

    if not ply.camera_ang then
        ply.camera_ang = Angle(0, 0, 0)
    end

    ply.camera_ang.p = math.NormalizeAngle(ply.camera_ang.p + y / 50)
    ply.camera_ang.y = math.NormalizeAngle(ply.camera_ang.y - x / 50)

    if not thirdperson_enabled then
        local eyeY = ply:EyeAngles().y
        local eyeX = ply:EyeAngles().x
        local norm_y = math.NormalizeAngle(ply.camera_ang.y - eyeY)
        local norm_p = math.NormalizeAngle(ply.camera_ang.p - eyeX)

        if norm_y > 75 then
            ply.camera_ang.y = eyeY + 75
        elseif norm_y < -75 then
            ply.camera_ang.y = eyeY - 75
        end

        if norm_p > 35 then
            ply.camera_ang.p = eyeX + 35
        elseif ply.camera_ang.p < -90 then
            ply.camera_ang.p = -90
        end

        return true
    end

    if ply.camera_ang.p > 90 then
        ply.camera_ang.p = 90
    elseif ply.camera_ang.p < -90 then
        ply.camera_ang.p = -90
    end

    return true
end)

hook.Add('CalcView', 'ThirdpersonSupreme', function(ply, pos, ang, fov, nearz, farz)
    local altIsDown = input.IsKeyDown(KEY_LALT)
    local wep = ply:GetActiveWeapon()
    local thirdperson_enabled = thirdperson_enabled

    if IsValid(wep) and wep.IsLightsaber then
        thirdperson_enabled = true
    end

    if not altIsDown then
        ply.camera_ang = ply:EyeAngles()
    elseif not thirdperson_enabled then
        view.origin = w_pos
        view.fov = fov
        view.angles = ply.camera_ang
        view.drawviewer = false

        return view
    end

    if (thirdperson_enabled or dist > 0) or LocalPlayer().sup_act then
        local x = thirdperson.x:GetFloat()
        local y = thirdperson.y:GetFloat()
        local z = thirdperson.z:GetFloat()
        y = y < .5 and (y - .5) / 2 or y - .5
        y = y * dist * 100
        z = z < .5 and (z - .5) / 2 or z - .5
        z = z * dist * -120
        x = x * dist

        if thirdperson_enabled then
            dist = math.min(dist + (1 - dist) * FrameTime() * 6, 1)
            if dist > .99 then
                dist = 1
            end
        else
            dist = math.max(dist - dist * FrameTime() * 6, 0)
            if dist < .1 then
                dist = 0
            end
        end

        local index = ply:LookupAttachment("eyes")

        if index then
            local data = ply:GetAttachment(index)

            if data then
                pos = data.Pos
            end
        end

        pos = pos + (ply.camera_ang:Forward() * (-x)) + (ply.camera_ang:Right() * y) + (ply.camera_ang:Up() * z)
        shotpos = ply:GetShootPos()

        local hulltr = util.TraceHull({
            start = shotpos,
            endpos = pos,
            filter = player.GetAll(),
            mask = MASK_SHOT_HULL,
            mins = Vector(-10, -10, -10),
            maxs = Vector(10, 10, 10)
        })

        if hulltr.Hit then
            pos = hulltr.HitPos + (shotpos - hulltr.HitPos):GetNormal() * 10
        end

        -- Интерполируем позицию и угол камеры
        smoothPos = LerpVector(FrameTime() * 15, smoothPos, pos)
        smoothAng = LerpAngle(FrameTime() * 15, smoothAng, ply.camera_ang)

        view.origin = smoothPos
        view.fov = fov
        view.angles = smoothAng
        view.drawviewer = true

        return view
    else
        if view and view.drawviewer then
            view.drawviewer = false
            return view
        end
    end
end)

hook.Add("ShouldDrawLocalPlayer", "Thirdperson_ShouldDrawPlayer", function(pPlayer)
    return thirdperson_enabled
end)

netstream.Hook("thirdperson_toggle", function(data)
    if not (LocalPlayer():Team() == TEAM_SPECTATOR or LocalPlayer():Team() == TEAM_UNASSIGNED) then
        thirdperson_enabled = not thirdperson_enabled
    end
end)
