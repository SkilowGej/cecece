--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
include('shared.lua')
function ENT:Initialize()
	self:SetModel( "models/starwars_bomb/starwars_bomb.mdl" )
	self:SetSkin(1)
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetUseType(SIMPLE_USE)

	self.phys = self:GetPhysicsObject()
	self.phys:EnableMotion(false)
	if (self.phys:IsValid()) then
		self.phys:Wake()
	end
	
	self.cables = {}
	self:SpawnCables()
	self:SetBodygroup(1, 1)
	self:SetBodygroup(2, 1)
	self:SetBodygroup(3, 1)
end

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 10
	local SpawnAng = ply:EyeAngles()
	SpawnAng.p = 0
	SpawnAng.y = SpawnAng.y - 20
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:SetAngles( SpawnAng )
	ent:Spawn()
	ent:Activate()

	return ent
	
end

function ENT:SpawnCables()
	local tbl = table.Random(Joes_Bomb.codes)
	for number,data in pairs(tbl) do
		local ent = ents.Create("joe_cable")
		ent:SetPos(self:LocalToWorld(data.pos))
		ent:SetAngles(self:GetAngles() - data.ang)
		ent:SetColor(data.col)
		ent.data = {pos = data.pos, ang = data.ang}
		ent.cut = data.cut
		ent.bomb = self
		ent:Spawn()
		ent:Activate()
		self.cables[ent] = true
		constraint.NoCollide(self, ent, 0, 0)
	end
	self.ready = true
end

function ENT:CableCut(cable)
	timer.Simple(0.5, function()
		if not IsValid(self) then return end
		if not self.ready then return end
		if cable.cut == false then
			self:Explode()
		else
			if isnumber(cable.cut) then
				self.curexpected = self.curexpected or 1
				if cable.cut == self.curexpected then
					for v,_ in pairs(self.cables) do
						if not v.cut or not isnumber(v.cut) then continue end
						if v.cut > self.curexpected then
							self.curexpected = self.curexpected + 1
							return
						end
					end
					self:Defuse()
				else
					self:Explode()
				end
			else
				self:Defuse()
			end
		end
	end)
end

function ENT:Defuse()
	if not self.ready then return end
	self.ready = false
	self:EmitSound("weapons/slam/mine_mode.wav")
	for v,_ in pairs(self.cables) do
		if not IsValid(v) then continue end
		v:Remove()
	end
	self:Reset()
end

function ENT:Explode()
	if not self.ready then return end
	self.ready = false
	local effectdata = EffectData()
	effectdata:SetOrigin( self:GetPos() )
	util.Effect( "HelicopterMegaBomb", effectdata )
	util.ScreenShake( self:GetPos(), 50, 50, 2, 50 )
	self:EmitSound("ambient/explosions/explode_1.wav")
	self:Reset()
end

function ENT:Reset()
	if not IsValid(self) then return end
	for v,_ in pairs(self.cables) do
		if not IsValid(v) then continue end
		v:Remove()
	end
	self.curexpected = nil
	self.cables = {}
	self.ready = false
	timer.Simple(1.5, function()
		self:SpawnCables()
	end)
end

function ENT:OnRemove()
	for v,_ in pairs(self.cables) do
		if not IsValid(v) then continue end
		v:Remove()
	end
end

function ENT:Think()
	for v,_ in pairs(self.cables) do
		v:SetPos(self:LocalToWorld(v.data.pos))
		v:SetAngles(self:GetAngles() - v.data.ang)
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
