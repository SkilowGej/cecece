ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "GUM Command"
ENT.Spawnable = true
ENT.Category = "Piwnica Granie • Trening"

function ENT:SetupDataTables()
	self:NetworkVar( "Float", 0, "GUM" );
end
