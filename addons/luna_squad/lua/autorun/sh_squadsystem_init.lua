--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

SquadSystem = {}

timer.Simple(0, function()
    SummeLibrary:Register({
        class = "squadsystem",
        name = "SquadSystem",
        color = Color(255,0,0),
        version = "1.3.1",
    })
end)

hook.Add("SquadSystem.Registered", "34343", function()
    local rootDir = "squadsystem"

    local function AddFile(File, dir)
        --print(File, dir)

        local fileSide = string.lower(string.Left(File , 3))

        if SERVER and fileSide == "sv_" then
            include(dir..File)
            --SummeLibrary:Print("squadsystem", "> "..dir..File)
        elseif fileSide == "sh_" then
            if SERVER then 
                AddCSLuaFile(dir..File)
            end
            include(dir..File)
            --SummeLibrary:Print("squadsystem", "> "..dir..File)
        elseif fileSide == "cl_" then
            if SERVER then 
                AddCSLuaFile(dir..File)
            elseif CLIENT then
                include(dir..File)
                --SummeLibrary:Print("squadsystem", "> "..dir..File)
            end
        end
    end

    local function IncludeDir(dir)
        dir = dir .. "/"
        local File, Directory = file.Find(dir.."*", "LUA")

        for k, v in ipairs(File) do
            if string.EndsWith(v, ".lua") then
                if v == "sh_config.lua" then continue end
                if v == "sh_language.lua" then continue end
                AddFile(v, dir)
            end
        end
        
        for k, v in ipairs(Directory) do
            IncludeDir(dir..v)
        end

        hook.Run("SquadSystem.Loaded")

    end

    AddFile("sh_config.lua", "squadsystem/")
    AddFile("sh_language.lua", "squadsystem/")

    IncludeDir(rootDir)
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
