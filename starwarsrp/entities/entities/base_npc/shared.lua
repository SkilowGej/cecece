ENT.Base = "base_anim" 
ENT.Type = "anim"
ENT.PrintName = "Base NPC"
ENT.Instructions = "Base entity"
ENT.Author = "Vend"
ENT.Spawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "JobName")
	self:NetworkVar("String", 1, "Dialogue")
end

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end