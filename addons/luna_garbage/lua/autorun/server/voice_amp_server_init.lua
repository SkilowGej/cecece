--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

hook.Add("PlayerCanHearPlayersVoice","VoiceAmplifierCanHearVoice",function(lis,tal)
  if lis == tal then return end
  local wep = tal:GetActiveWeapon()
  if not (IsValid(wep) and wep:GetClass() == "announce") then return end
  if tal:GetPos():DistToSqr(lis:GetPos()) < wep:GetDistance() or (wep:GetAllTalk() and tal:IsAdmin()) then return true,false end
end)


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
