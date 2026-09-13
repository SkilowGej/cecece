--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local function addmenu()
    if !vrmod then return end

    vrmod.AddInGameMenuItem("ArcCW Customize", 3, 1, function()
        local wep = LocalPlayer():GetActiveWeapon()

        if !IsValid(wep) or !wep.ArcCW then return end

        wep:ToggleCustomizeHUD(!IsValid(ArcCW.InvHUD))
    end)
end

hook.Add("VRMod_Start", "ArcCW", addmenu)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
