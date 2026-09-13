ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Pudełko z Zbroją"
ENT.Author = "Acklay"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "Piwnica Granie • Rzeczy"

function ENT:SetupDataTables()
	self:NetworkVar( "Float", 0, "Uses" )

    if SERVER then
		self:SetUses( 10 )
    end
end