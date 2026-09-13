--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

hook.Add("OnEntityCreated", "prometheus.DeleteEntities", function(ent)
    if prometheus.cfg.deleteMapEntities[ent:GetClass()] then
        ent:Remove()
    end
end)

hook.Add( "InitPostEntity", "prometheus.Phys", function()
	local phys_settings = physenv.GetPerformanceSettings()

	phys_settings.LookAheadTimeObjectsVsObject = 0
	phys_settings.LookAheadTimeObjectsVsWorld = 0.1
	phys_settings.MaxAngularVelocity = 3600
	phys_settings.MaxCollisionChecksPerTimestep = 1
	phys_settings.MaxCollisionsPerObjectPerTimestep = 1
	phys_settings.MaxFrictionMass = 2500
	phys_settings.MaxVelocity = 768
	phys_settings.MinFrictionMass = 100

	physenv.SetPerformanceSettings( phys_settings )
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
