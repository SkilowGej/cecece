--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if CLIENT then return end

hook.Add("OnEntityCreated", "CheckAARange", function(ent)
	local filters = nil

	if ent:IsNPC() then
		timer.Simple(.1, function()
			if not IsValid(ent) then return end
			aaents = ents.FindByClass("ent_prautoassigner")

			if aaents and #aaents > 0 then
				for k, v in pairs(aaents) do
					if ent:GetPos():Distance(v:GetPos()) < v:GetRange() then
						if v:GetFilter() == "" then
							v:CreateRoute(ent)
							break
						else
							filters = string.Split(v:GetFilter(), ",")

							if table.HasValue(filters, ent:GetClass()) then
								v:CreateRoute(ent)
								break
							end
						end
					end
				end
			end
		end)
	end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
