--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName		= "AV-7"
ENT.Category 		= "Arta"

ENT.Spawnable 	= true
ENT.AdminOnly 	= false

function ENT:SetupDataTables()
    self:NetworkVar( "Float", 0, "X" )
    self:NetworkVar( "Float", 1, "Y" )
    self:NetworkVar( "Int", 0, "Delay" )

	if SERVER then
		self:SetX( 0 )
        self:SetY( 0 )
        self:SetDelay( 0 )
	end
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
