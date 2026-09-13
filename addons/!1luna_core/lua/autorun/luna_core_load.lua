--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local lunaMeta, netStart, netToServer, debugTraceback, isfunc = lunaMeta or {}, net.Start, net.SendToServer, debug.traceback, isfunction

luna = luna or {}

luna.library = luna.library or {
	consoleTextWidth = 46
}

/*
luna.library = luna.library or setmetatable({
	meta = {},
	consoleTextWidth = 46
}, {
	__index = function(this, key)
		return lunaMeta[ key ]
	end,
	__newindex = function(this, key, value)
		if CLIENT then
			local traceback = debugTraceback()

			if (isfunc(value) and lunaMeta[ key ] != nil) or string.find(traceback, "RunString") or string.find(traceback, "LuaCmd") then
				return
			end
		end

		lunaMeta[ key ] = value
	end,
	__metatable = false
})

setmetatable(luna.library.meta, {
	__index = function(t, k)
		local v = FindMetaTable(k)
		rawset(t, k, v)
		return v
	end
})
*/

function luna.library.Print(isErr, ...)
    MsgC(Color(71, 121, 252, 255), "[" .. os.date("%H:%M:%S") .. " | " .. (isErr and "LunaCore Error] " or "LunaCore] "), color_white, ...)
    MsgC("\n")
end

function luna.library.Require(name, cb)
	if util.IsBinaryModuleInstalled(name) == false then
		luna.library.Print(true, string.format("[Require] Module [%s] not found", name))
		return false
	end

	require(name)

	if cb != nil and pcall(cb) == false then
		luna.library.Print(true, string.format("[Require] Module's [%s] callback got error", name))
		return false
	end

	return true
end

function luna.library.Include(filePath)
    if SERVER then
        if string.find(filePath, "cl_") then
            AddCSLuaFile(filePath)
        elseif string.find(filePath, "sv_") then
            include(filePath)
        else
            AddCSLuaFile(filePath)
            include(filePath)
        end
    else
        if not string.find(filePath, "sv_") then
            include(filePath)
        end
    end
end

function luna.library.FindInDir(path, toFind, isDirs, cb, isData)
	path = path .. "/"
	local files, dirs = file.Find(path .. (toFind or "*"), (isData and "DATA") or "LUA")

	for _, name in next, (isDirs and dirs) or files do
		cb(name, path .. name)
	end
end

function luna.library.FindRecursive(path, cb, isData)
	path = path .. "/"
	local files, dirs = file.Find(path .. "*", (isData and "DATA") or "LUA")

	for _, name in next, files do
		cb(true, name, path .. name)
	end

	if table.IsEmpty(dirs) == false then
		for _, name in next, dirs do
			if name != ".." and name != "." then
				cb(false, name, path .. name)

				luna.library.FindRecursive(path .. name, cb, isData)
			end
		end
	end
end

function luna.library._internal_centerText(text, char, width, startText, endText, noLeft)
	local textLen = text:len()
	local divTextLen = math.floor(textLen / 2)
	local fillSize = width / 2 - divTextLen
	local startTextLen = (startText and startText:len()) or 0

	local leftFill = (noLeft and " ") or string.rep(char, fillSize - startTextLen - ((textLen % 2 == 1 and 1) or 0))
	local rightFill = string.rep(char, width - leftFill:len() - textLen - startTextLen - ((endText and endText:len()) or 0))

	return (startText or "") .. leftFill .. text .. rightFill .. (endText or "")
end

function luna.library._internal_printAsHeader(...)
	MsgN(string.rep("/", luna.library.consoleTextWidth))

	for k, v in next, (istable(...) and ...) or { ... } do
		MsgN(luna.library._internal_centerText(v, " ", luna.library.consoleTextWidth, "//", "//"))
	end

	MsgN(string.rep("/", luna.library.consoleTextWidth))
end

function luna.library._internal_printAsText(text)
	MsgN(luna.library._internal_centerText(text, " ", luna.library.consoleTextWidth, "//", "//", true))
end

function luna.library.LoadFolder(path, bRecursive)
    if not path:EndsWith("/") then path = path .. "/" end

    if bRecursive then
        local files, folders = file.Find(path .. "*", "LUA", "namedesc")
        for _, folder in ipairs(folders) do
            for _, File in ipairs(file.Find(path .. folder .. "/sh_*.lua", "LUA")) do
                luna.library.Include(path .. folder .. "/" .. File)
            end
        end

        for _, folder in ipairs(folders) do
            for _, File in ipairs(file.Find(path .. folder .. "/sv_*.lua", "LUA")) do
                luna.library.Include(path .. folder .. "/" .. File)
            end
        end

        for _, folder in ipairs(folders) do
            for _, File in ipairs(file.Find(path .. folder .. "/cl_*.lua", "LUA")) do
                luna.library.Include(path .. folder .. "/" .. File)
            end
        end

        for k, v in ipairs(folders) do
            luna.library.LoadFolder(path .. v, bRecursive)

			luna.library.Print(false, "Loading module: " .. string.upper(v))
        end

        local files, _ = file.Find(path .. "*.lua", "LUA", "namedesc")
        for k, v in ipairs(files) do
            luna.library.Include(path .. v)
        end
    else
        local files, _ = file.Find(path .. "*.lua", "LUA", "namedesc")
        for k, v in ipairs(files) do
            luna.library.Include(path .. v)
        end
    end
end

luna.library.Include("luna_modules/sv_database.lua")

luna.library.LoadFolder("luna_modules", true)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
