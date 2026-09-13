--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

-- "addons\\server_content\\lua\\effects\\clone_tracer.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
EFFECT.Mat = Material( "particles/swcw/blue_blaster_tracer" )
EFFECT.Mat2 = Material( "particles/swcw/blue_blaster_galo" )

function EFFECT:Init( data )
	local ent = data:GetEntity()
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()

	self.Attachment = data:GetAttachment()

	if IsValid(self.WeaponEnt) and self.WeaponEnt.GetMuzzleAttachment then
		self.Attachment = self.WeaponEnt:GetMuzzleAttachment()
	end

	self.StartPos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	self.EndPos = data:GetOrigin()

	local vm

	if ent:IsWeapon() and ent.Owner == LocalPlayer() then
		vm = ent.Owner:GetViewModel()
	end
	

	
	local speed = 8000
	self.Dir = self.EndPos - self.StartPos

	self:SetRenderBoundsWS( self.StartPos, self.EndPos )
	self.Length = math.Rand( 0.1, 0.15 )
	
	-- Die when it reaches its target
	
	self.SmoothPath = 0
	self.PathStart = SysTime()
	self.Path = self.StartPos:Distance(self.EndPos)+180
	self.Speed = speed / self.Path 
	self.TracerTime = 1 / self.Speed
	self.DieTime = CurTime() + self.TracerTime

end

function EFFECT:Think()

	if ( CurTime() > self.DieTime ) then

		-- Awesome End Sparks
	--	local effectdata = EffectData()
	--	effectdata:SetOrigin( self.EndPos + self.Dir:GetNormalized() * -2 )
	--	effectdata:SetNormal( self.Dir:GetNormalized() * -3 )
	--	effectdata:SetMagnitude( 1 )
	--	effectdata:SetScale( 1 )
	--	effectdata:SetRadius( 6 )
	--	util.Effect( "Sparks", effectdata )

		return false
	end
	
	self.SmoothPath = Lerp( (SysTime() - self.PathStart)*self.Speed, 0, self.Path )
	
	--for i, ply in ipairs( player.GetAll() ) do
	--ply:ChatPrint( SysTime() - self.PathStart )
	--end
	
	return true

end

function EFFECT:Render()

	local startpos, endpos = self.StartPos+(self.Dir:GetNormalized()*self.SmoothPath)-(self.Dir:GetNormalized()*math.min(self.SmoothPath,180)), self.StartPos+self.Dir:GetNormalized()*math.min(self.SmoothPath,self.Path-180)

	render.SetMaterial( self.Mat )

	render.DrawBeam( startpos, endpos , 70, 1, 0, Color( 255, 255, 255, 255 ) )
	
	render.SetMaterial( self.Mat2 )
	
	render.DrawSprite( LerpVector( 0.5, startpos, endpos ) , 200, 150, Color( 255, 255, 255, 100 ) )

end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
