--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if game.SinglePlayer() then
	return
end

if not pcall( require, "stringtable" ) or (stringtable == nil) then
    MsgN( "Please install binnary module: https://github.com/danielga/gm_stringtable" )
    return
end

local function downloadables()
    return stringtable.Find( "downloadables" )
end

function resource.GetAll()
    local data = downloadables()
    if (data ~= nil) then
        return data:GetStrings()
    end
end

function resource.HasFile( path )
    local strings = resource.GetAll()
    for num = 0, #strings do
        if (strings[ num ] == path) then
            return true
        end
    end

    return false
end

function resource.HasWorkshop( wsid )
    local searchable = wsid .. ".gma"
    local strings = resource.GetAll()
    for num = 0, #strings do
        if (strings[ num ] == searchable) then
            return true
        end
    end

    return false
end

function resource.Clear()
    local data = downloadables()
    if (data ~= nil) then
        data:Lock( true )
        data:DeleteAllStrings()
        data:Lock( false )
    end
end

do

    local isstring = isstring
    function resource.RemoveWorkshop( wsid )
        if isstring( wsid ) then
            local searchable = wsid .. ".gma"
            local data = downloadables()
            if (data ~= nil) then
                local strings = data:GetStrings()
                data:Lock( true )
                data:DeleteAllStrings()

                for num = 0, #strings do
                    local str = strings[ num ]
                    if (str == nil) then continue end
                    if (str == searchable) then continue end
                    data:AddString( true, str )
                end

                data:Lock( false )
            end
        end

        if istable( wsid ) then
            local searchable = {}
            for num, workshopid in ipairs( wsid ) do
                table.insert( searchable, workshopid .. ".gma" )
            end

            local data = downloadables()
            if (data ~= nil) then
                local strings = data:GetStrings()
                data:Lock( true )
                data:DeleteAllStrings()

                for num = 0, #strings do
                    local str = strings[ num ]
                    if (str == nil) then continue end

                    local remove = false
                    for num, path in ipairs( searchable ) do
                        if (str == path) then
                            remove = true
                            break
                        end
                    end

                    if (remove) then continue end

                    data:AddString( true, str )
                end

                data:Lock( false )
            end
        end
    end

    function resource.RemoveFile( path )
        if isstring( path ) then
            local data = downloadables()
            if (data ~= nil) then
                local strings = data:GetStrings()
                data:Lock( true )
                data:DeleteAllStrings()

                for num = 0, #strings do
                    local str = strings[ num ]
                    if (str == nil) then continue end
                    if (str == path) then continue end
                    data:AddString( true, str )
                end

                data:Lock( false )
            end
        end

        if istable( path ) then
            local data = downloadables()
            if (data ~= nil) then
                local strings = data:GetStrings()
                data:Lock( true )
                data:DeleteAllStrings()

                for num = 0, #strings do
                    local str = strings[ num ]
                    if (str == nil) then continue end

                    local remove = false
                    for num, file_path in ipairs( path ) do
                        if (str == file_path) then
                            remove = true
                            break
                        end
                    end

                    if (remove) then continue end

                    data:AddString( true, str )
                end

                data:Lock( false )
            end
        end
    end

end

function resource.GetWorkshop()
    local workshop = {}

    for num, path in ipairs( resource.GetAll() ) do
        if (path:sub( #path - 3, #path ) == ".gma") then
            local file_name = string.GetFileFromFilename( path )
            table.insert( workshop, file_name:sub( 1, #file_name - 4 ) )
        end
    end

    return workshop
end

do

    resource.CAddWorkshop = resource.CAddWorkshop or resource.AddWorkshop

    function resource.AddWorkshop( workshopid )
        for num, wsid in ipairs( resource.GetWorkshop() ) do
            if (wsid == "") then
                resource.RemoveWorkshop( wsid )
            end

            if (wsid == workshopid) then return end
        end

        timer.Simple(0, function()
            local result = hook.Run( "OnWorkshopAdded", workshopid )
            if (result == nil) or (result == true) then
                resource.CAddWorkshop( workshopid )
            end
        end)
    end

end

local lower, Split, StartsWith, GetExtensionFromFilename
local Exists, Find

do
    local _obj_0 = string
	lower, Split, StartsWith, GetExtensionFromFilename = _obj_0.lower, _obj_0.Split, _obj_0.StartsWith, _obj_0.GetExtensionFromFilename

	_obj_0 = file
	Exists, Find = _obj_0.Exists, _obj_0.Find
end

local resource = resource
local ipairs = ipairs
local workshopDL = resource.AWDL

if not istable(workshopDL) then
	workshopDL = { }
	resource.AWDL = workshopDL
end

local resourceExtensions = {
	["mdl"] = true,
	["vtx"] = true,
	["phy"] = true,
	["ani"] = true,
	["vvd"] = true,
	["wav"] = true,
	["mp3"] = true,
	["ogg"] = true,
	["vmt"] = true,
	["vtf"] = true,
	["png"] = true,
	["jpg"] = true,
	["jpeg"] = true,
	["raw"] = true,
	["ttf"] = true,
	["ani"] = true,
	["pcf"] = true,
	["vcd"] = true,
	["properties"] = true
}

local getTag = nil

do
	local tagNames = {
		["gamemode"] = "Gamemode",
		["map"] = "Map",
		["weapon"] = "Weapon",
		["vehicle"] = "Vehicle",
		["npc"] = "NPC",
		["entity"] = "Entity",
		["tool"] = "Tool",
		["effects"] = "Effect",
		["model"] = "Model",
		["servercontent"] = "Server Content"
	}
	getTag = function(addon)
		for _, tag in ipairs(Split(addon.tags, ",")) do
			tag = tagNames[lower(tag)]
			if tag ~= nil then
				return tag
			end
		end
		return "Addon"
	end
end

local addons = engine.GetAddons()
local addonsCount = #addons
local addWorkshop = nil

do
	local AddWorkshop = resource.AddWorkshop
	local MsgC = MsgC
	local color0 = Color(200, 200, 200)
	local color1 = Color(180, 180, 180)
	local color2 = Color(20, 150, 240)
	addWorkshop = function(wsid)
		if workshopDL[wsid] then
			return
		end
		workshopDL[wsid] = true
		AddWorkshop(wsid)
		workshopDL[#workshopDL + 1] = wsid
		for index = 1, addonsCount do
			if addons[index].wsid == wsid then
				luna.library.Print(false, "" .. getTag(addons[index]) .. ": ", color2, addons[index].title, color1, " ( ", color0, wsid, color1, " )")
				return
			end
		end
		return luna.library.Print(false, "" .. color0, "Addon: ", color2, "unknown", color1, " ( ", color0, wsid, color1, " )\n")
	end
end

local scanAddon
scanAddon = function(gamePath, folderPath, result, length)
	if folderPath == nil then
		result, length = { }, 0
		local files, folders = Find("*", gamePath)

		for _, fileName in ipairs(files) do
			length = length + 1
			result[length] = fileName
		end

		for _, folderName in ipairs(folders) do
			scanAddon(gamePath, folderName, result, length)
		end

		return result
	end

	local files, folders = Find(folderPath .. "/*", gamePath)

	for _, fileName in ipairs(files) do
		length = length + 1
		result[length] = folderPath .. "/" .. fileName
	end

	for _, folderName in ipairs(folders) do
		scanAddon(gamePath, folderPath .. "/" .. folderName, result, length)
	end

	return result
end

local ignoreOtherMaps = CreateConVar("awdl_ignore_maps", "1", bit.bor(FCVAR_ARCHIVE, FCVAR_DONTRECORD, FCVAR_NOTIFY), "If enabled, AWDL will ignore all maps except the current map.")
local mapName = game.GetMap()

for i = 1, addonsCount do
	local addon = addons[i]
	if not (addon.downloaded and addon.mounted) then
		goto _continue_0
	end
	if mapName ~= nil and Exists("maps/" .. mapName .. ".bsp", addon.title) then
		addWorkshop(addon.wsid)
		mapName = nil
		goto _continue_0
	end
	if ignoreOtherMaps:GetBool() and getTag(addon) == "Map" then
		goto _continue_0
	end
	if addon.models > 0 then
		addWorkshop(addon.wsid)
		goto _continue_0
	end
	for _, filePath in ipairs(scanAddon(addon.title)) do
		if StartsWith(filePath, "data_static/") or resourceExtensions[GetExtensionFromFilename(filePath)] then
			addWorkshop(addon.wsid)
			break
		end
	end
	::_continue_0::
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
