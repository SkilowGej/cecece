--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ENT.Type = "anim";
ENT.Base = "base_anim";
ENT.PrintName = "heart_turbolaser";
ENT.Author = "drunken hearted";

ENT.Spawnable = false;

function ENT:SetupDataTables()
	self:NetworkVar( "String", "0", "ColR" );
	self:NetworkVar( "String", "1", "ColG" );
	self:NetworkVar( "String", "2", "ColB" );

	self:NetworkVar("Float", "0", "Scale");
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
