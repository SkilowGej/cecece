--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

database = database or {}

local dbconfig = {
    ["server"] = {
        ip = "194.69.160.11",
        username = "u11658_fnVcZWSnlP",
        password = "PqXAooUT+3J5.3wykCN.Ozn3",
        tbl = "s11658_luna",
    },

    ["local"] = {
        ip = "localhost",
        username = "root",
        password = "",
        tbl = "cwrp",
    }
}

function DatabaseLoad()
    local gameip = game.GetIPAddress()
    local servertype = "local"

    if gameip:find("27015") then
        servertype = "server"
    end

    local config = dbconfig[servertype]

    if config then
        luna.library.Print(false, "Loading database config: " .. servertype)

        database = {
            ip = config.ip,
            username = config.username,
            password = config.password,
            tbl = config.tbl,
            port = 3306
        }
    else
        luna.library.Print(false, "Can't recognize server database config, falling back to 'local'")
    end
end

DatabaseLoad()

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
