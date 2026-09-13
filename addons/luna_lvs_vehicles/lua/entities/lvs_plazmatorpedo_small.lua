--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

ENT.Base = "lvs_missile"

ENT.Type            = "anim"

ENT.PrintName = "Plazma Torpedo Small"
ENT.Author = "Lustick2K"
ENT.Information = "geht ab wie'n z�pfchen"
ENT.Category = "[LVS]"

ENT.Spawnable		= true
ENT.AdminOnly		= true

ENT.ExplosionEffect = "lvs_plazma_explosion"
ENT.GlowColor = Color( 0, 127, 255, 255 )

if SERVER then
	function ENT:GetDamage() return
		(self._dmg or 300)
	end

	function ENT:GetRadius() 
		return (self._radius or 200)
	end

	return
end

ENT.GlowMat = Material( "sprites/plasmaember" )

function ENT:Enable()	
	if self.IsEnabled then return end

	self.IsEnabled = true

	self.snd = CreateSound(self, "plasma_gun_04.mp3")
	self.snd:SetSoundLevel( 80 )
	self.snd:Play()

	local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() )
		effectdata:SetEntity( self )
	util.Effect( "lvs_plazma_trail", effectdata )
end

function ENT:Draw()
	if not self:GetActive() then return end

	self:DrawModel()

	render.SetMaterial( self.GlowMat )

	local pos = self:GetPos()
	local dir = self:GetForward()

	for i = 35, 55 do
		local Size = ((25 - i) / 30) ^ 2 * 128

		render.DrawSprite( pos - dir * i * 0, Size, Size, self.GlowColor )
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
