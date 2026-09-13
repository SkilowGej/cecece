ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Usable = true
ENT.Action = "Wyposaż"
ENT.PrintName = "Wkłady (30)"
ENT.Author = "Acklay"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "Piwnica Granie • Rzeczy"

function ENT:SetupDataTables()
	self:NetworkVar( "Float", 0, "Uses" )

    if SERVER then
		self:SetUses( 15 )
    end
end