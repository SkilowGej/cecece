local loader = {}

local include = include
local AddCSLuaFile = AddCSLuaFile
local istable = istable
local Right = string.Right
local string_find = string.find
local file_Find = file.Find
local Explode = string.Explode
local Left = string.Left

function loader.Server(path)
    if SERVER then
        return include(path)
    end
end

function loader.Client(path)
    if SERVER then
        AddCSLuaFile(path)
    else
        return include(path)
    end
end

function loader.Shared(path)
    if SERVER then
        AddCSLuaFile(path)
        return loader.Server(path)
    else
        return loader.Client(path)
    end
end

do
    function loader.ParseAuto(path, ignore)
        local parts = Explode("/", path)
        local amount = #parts
        local prefix = Left(parts[amount], 2)
    
        if prefix then
            if prefix == "sv" then
                return loader.Server(path)
            elseif prefix == "cl" then
                return loader.Client(path)
            elseif prefix == "sh" then
                return loader.Shared(path)
            end
        else
            if (not ignore) then
                error("No prefix found")
            end
        end
    end
end

do
    function loader.LoadFolder(path, recursive, ignore, fromGamemode)   
        local parsedPath = ((GM or GAMEMODE).FolderName .. "/gamemode/" .. path .. "/")
        local files, folders = file_Find(parsedPath .. "*", "LUA")

        for _, f in ipairs(files) do
            if Right(f, 4) == ".lua" and f ~= "sh_loader.lua" then
                loader.ParseAuto(parsedPath .. f, ignore)
            end
        end
    
        if recursive then
            for _, f in ipairs(folders) do
                loader.LoadFolder(path .. "/" .. f, true, ignore)
            end
        end
    end
end

luna.loader = loader