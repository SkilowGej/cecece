--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName	= "Ammunition"
ENT.Category		= "SUP • Drop"

ENT.Spawnable			= true
ENT.AdminSpawnable	= true
ENT.AdminOnly = false
ENT.DoNotDuplicate = true
ENT.MineAmmo = 5

function ENT:SetupDataTables()
	self:DTVar("Int", 0, "MineAmmoNum")
	self:NetworkVar( "Float", 0, "Uses" )

    if SERVER then
		self:SetUses( 300 )
    end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
