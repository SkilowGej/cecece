--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

ENT.Base = "lvs_missile"

ENT.Type            = "anim"

ENT.PrintName = "Custom Missile"
ENT.Author = "Tic"
ENT.Information = "Big Boom"
ENT.Category = "[LVS]"

ENT.Spawnable		= false
ENT.AdminOnly		= false

ENT.ExplosionEffect = "lvs_proton_explosion_large"
ENT.GlowColor = Color( 0, 127, 255, 255 )

if SERVER then
	function ENT:GetDamage() return
		(self._dmg or 4000)
	end

	function ENT:GetRadius() 
		return (self._radius or 1000)
	end

	return
end

ENT.GlowMat = Material( "sprites/light_glow02_add" )

function ENT:Enable()	
	if self.IsEnabled then return end

	self.IsEnabled = true
	 self.snd = CreateSound(self, "npc/combine_gunship/gunship_crashing1.wav")
	self.snd:SetSoundLevel( 95 )
	self.snd:Play()

	local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() )
		effectdata:SetEntity( self )
	util.Effect( "lvs_proton_trail_large", effectdata )
end

function ENT:Draw()
	if not self:GetActive() then return end

	self:DrawModel()

	render.SetMaterial( self.GlowMat )

	local pos = self:GetPos()
	local dir = self:GetForward()

	for i = 0, 30 do
		local Size = ((60 - i) / 20) ^ 2 * 128

		render.DrawSprite( pos - dir * i * 7, Size, Size, self.GlowColor )
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
