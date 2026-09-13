--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"

CLGAMEMODESUBMENU.priority = 0
CLGAMEMODESUBMENU.title = "ArcCW"

local TTTPanel = {
    { type = "h", text = "#arccw.ttt_clienthelp" },
    { type = "b", text = "#arccw.cvar.ttt_inforoundstart", var = "arccw_ttt_rolecrosshair"},
    { type = "b", text = "#arccw.cvar.ttt_rolecrosshair", var = "arccw_ttt_inforoundstart"},
}

local clientpanels = {
    "ArcCW_Options_Client",
    "ArcCW_Options_Crosshair",
    "ArcCW_Options_HUD",
    "ArcCW_Options_Viewmodel",
    "ArcCW_Options_Perf",
    --"ArcCW_Options_Binds",
}

function CLGAMEMODESUBMENU:Populate(parent)
    ArcCW.TTT2_PopulateSettings(parent, "arccw.menus.ttt_client", TTTPanel)
    for _, pnlname in pairs(clientpanels) do
        local pnl = ArcCW.ClientMenus[pnlname]
        ArcCW.TTT2_PopulateSettings(parent, pnl.text, pnl.tbl)
    end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
