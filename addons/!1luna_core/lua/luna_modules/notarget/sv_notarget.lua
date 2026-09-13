--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local find = function(playa, criteria)
    criteria = criteria:Trim()
    if criteria == '^' then return playa end
    for _, ply in pairs(player.GetAll()) do
        if ply:Nick():lower():find(criteria:lower()) then return ply end
        if ply:SteamID() == criteria then return ply end
        if ply:SteamID64() == criteria then return ply end
    end
end

hook.Add('PlayerSay', 'rp.notarget', function(ply, text)
    local args = string.Explode(' ', text)
    if string.lower(args[1]) == '!npctarget' then
        if #args < 2 then
            re.util.Notify('yellow', ply, 'Musisz podać imię lub SteamID gracza.')
            return ''
        end

        local arg = table.concat(args, ' ', 2)
        local playa = find(ply, arg)
        if not playa then
            re.util.Notify('yellow', ply, 'Gracz nie znaleziony.')
            return ''
        end

        local stat = playa:IsFlagSet(FL_NOTARGET)
        playa:SetNoTarget(not stat)
        re.util.Notify('yellow', ply, Format('Pomyślnie %s notarget graczowi %s(%s)', stat and 'ustawiłeś' or 'usunąłeś', playa:Nick(), playa:SteamID()))
        return ''
    end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
