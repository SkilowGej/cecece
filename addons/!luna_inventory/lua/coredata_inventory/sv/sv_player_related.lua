--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local meta = FindMetaTable('Player')
local metagive = meta.GiveAmmo
local metawep = meta.Give
hook.Add('OnEntityCreated', 'ArcCW_DefaultClipOVERRIDE', function(ent)
    if not ent.ArcCW then return end
    ent.Primary.DefaultClip = 0
end)

function meta:Give(class, noammo, direct)
    if not direct then
        metawep(self, class, noammo)
        return
    end

    self:GetInventory():Add(sup_inv.GetByName(class))
end

function meta:GiveAmmo(amount, type, hidePopup, direct)
    if not direct then
        metagive(self, amount, type, hidePopup)
        return
    end

    self:GetInventory():Add(sup_inv.GetByName(type), amount)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
