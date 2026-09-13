--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

rsgenconfig = rsgenconfig or {} -- Don't touch this

-- Simply add `["class_name"] = true,` to add a new entity that can damage the laser generator
-- WARNING: This is only configured to work for SENTs (vehicles for example), not weapons
-- Some projectiles may work, but you'd need to find the entity name of the projectile, not the weapon
rsgenconfig.laserEntities = {
    ["lvs_protontorpedo"] = true,
    ["lvs_walker_atte"] = true,
    ["lvs_fakehover_iftx"] = true,
    ["lvs_repulsorlift_gunship"] = true
}

-- If you have downloaded this addon to configure the settings, you will need to upload the materials folder as
-- a separate addon, so your users are able to see the default rayshield generator material.
-- If you need help with how to do this, feel free to add me on Steam and ask.

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
