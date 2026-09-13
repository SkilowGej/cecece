--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if CLIENT then return end

hook.Add( "PlayerGiveSWEP", "ArcCW_YearLimiter", function( ply, class, swep )
    local wep = weapons.Get(class)

    if !ArcCW:WithinYearLimit(wep) then
        ply:ChatPrint( wep.PrintName .. " is outside the year limit!")
        return false
    end
end )

function ArcCW:WithinYearLimit(wep)
    if !wep then return true end
    if !wep.ArcCW then return true end

    if !ArcCW.ConVars["limityear_enable"]:GetBool() then return true end

    local year = ArcCW.ConVars["limityear"]:GetInt()

    if !wep.Trivia_Year then return true end
    if !isnumber(wep.Trivia_Year) then return true end

    if wep.Trivia_Year > year then return false end

    return true
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
