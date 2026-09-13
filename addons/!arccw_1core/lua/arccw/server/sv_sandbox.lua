--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if CLIENT then return end

-- We have to do a timer because there is no "PlayerGivenSWEP" or similar
hook.Add("PlayerGiveSWEP", "ArcCW_Autoload", function(ply, class, tbl)
    local weptbl = weapons.Get(class)
    if not weptbl or not weptbl.ArcCW then return end

    -- Mark the player's next weapon to get ammo restore
    ply.ArcCW_Sandbox_FirstSpawn = true
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
