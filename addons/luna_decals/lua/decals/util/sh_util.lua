--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

function Decals.Authed( ply )
    return Decals.cfg.Allowed[ ply:SteamID() ] or Decals.cfg.Allowed[ ply:SteamID64() ] or Decals.cfg.Allowed[ ply:GetUserGroup() ]
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
