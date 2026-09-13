--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local developer = {
    ["STEAM_1:0:214405746"] = true, -- pack
}

function IsDeveloper(ply)
    if IsValid(ply) and ply.SteamID then
        return developer[ply:SteamID()]
    end
    return false
end

local admins = {
    ["founder"] = true,
    ["admin"] = true,
    -------ДОБАВЬТЕ СВОИХ
}

function IsStaff(ply)
    if IsValid(ply) and ply.GetUserGroup then
        return admins[ply:GetUserGroup()]
    end
    return false
end

function ResponsiveX(x)
	return x * (ScrW() / 1920)
end

function ResponsiveY(y)
	return y * (ScrH() / 1080)
end

function getMaterial(png)
	return Material("materials/" .. png .. ".png", "noclamp smooth")
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
