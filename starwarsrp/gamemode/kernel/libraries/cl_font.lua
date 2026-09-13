luna.fonts = {}
local string_Explode = string.Explode
local util_CRC = util.CRC
local math_ceil = math.ceil
local surface_CreateFont = surface.CreateFont
local tonumber = tonumber
local function scale(y)
    local scrW, scrH = ScrW(), ScrH()
    return math.Round(y * math.min(scrW, scrH) / 1080)
end

local function createFont(font, size, parameters, initialSize)
    local name = 'luna.' .. util_CRC(font .. size .. (parameters or ''))
    if luna.fonts[name] then return name end
    local data = {
        font = font,
        size = size,
        extended = true,
        initialSize = initialSize
    }

    if parameters then
        local tblParameters = string_Explode(';', parameters)
        for _, str in ipairs(tblParameters) do
            local parts = string_Explode(':', str)
            local key, val = parts[1], parts[2]
            if tonumber(val) then
                data[key] = tonumber(val)
            else
                if val == 'true' then
                    data[key] = true
                else
                    data[key] = false
                end
            end
        end
    end

    luna.fonts[name] = data
    surface_CreateFont(name, data)
    return name
end

local fetchFont
do
    local aliases = {}
    function fetchFont(family)
        return aliases[family] or family
    end
end

function luna.Font(pattern, parameters)
    local parts = string_Explode('@', pattern)
    local family, size = fetchFont(parts[1]), tonumber(parts[2])
    local scaledSize = scale(size)
    -- local scaledSize = math_ceil(size / 900 * ScrH())
    return createFont(family, scaledSize, parameters, size)
end

function luna.FontNoScale(pattern, size, parameters)
    local family
    if size then
        family = fetchFont(pattern)
    else
        local parts = string_Explode('@', pattern)
        family, size = fetchFont(parts[1]), tonumber(parts[2])
    end
    return createFont(family, size, parameters)
end

hook.Add('OnScreenSizeChanged', 'luna.font.Recreate', function()
    for name, data in pairs(luna.fonts) do
        if data.initialSize then
            -- data.size = math_ceil(data.initialSize / 900 * ScrH())
            data.size = scale(data.initialSize)
            surface_CreateFont(name, data)
        end
        -- if data.initialSize then
        -- data.size = data.initialSize
        -- surface_CreateFont(name, data)
        -- end
    end
end)