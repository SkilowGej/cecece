--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

-- "addons\\server_content\\lua\\effects\\droid_tracer.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
EFFECT.Mat = Material( "particles/swcw/red_blaster_tracer" )
EFFECT.Mat2 = Material( "particles/swcw/red_blaster_galo" )

function EFFECT:Init( data )
    self.StartPos = data:GetStart()
    self.EndPos = data:GetOrigin()

    local ent = data:GetEntity()
    local att = data:GetAttachment()

    if IsValid(ent) and IsValid(ent.Owner) then
        if ent.Owner == LocalPlayer() and ent:IsWeapon() and ent.Owner:GetViewEntity() == ent.Owner then
            local vm = ent.Owner:GetViewModel()
            if IsValid(vm) then
                local attachment = vm:GetAttachment(vm:LookupAttachment("muzzle"))
                if attachment then
                    self.StartPos = attachment.Pos
                end
            end
        else
            local attachment = ent:GetAttachment(1)
            if attachment then
                self.StartPos = attachment.Pos
            end
        end
    end

    local speed = 8000
    self.Dir = self.EndPos - self.StartPos

    self:SetRenderBoundsWS( self.StartPos, self.EndPos )
    self.Length = math.Rand( 0.1, 0.15 )

    self.SmoothPath = 0
    self.PathStart = SysTime()
    self.Path = self.StartPos:Distance(self.EndPos) + 180
    self.Speed = speed / self.Path 
    self.TracerTime = 1 / self.Speed
    self.DieTime = CurTime() + self.TracerTime
end

function EFFECT:Think()

	if self.DieTime and CurTime() > self.DieTime then

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
	
	self.SmoothPath = Lerp( (SysTime() - self.PathStart) * self.Speed, 0, self.Path )
	
	--for i, ply in ipairs( player.GetAll() ) do
	--ply:ChatPrint( SysTime() - self.PathStart )
	--end
	
	return true

end

function EFFECT:Render()
    if not self.Dir then return end

    local startpos = self.StartPos + (self.Dir:GetNormalized() * self.SmoothPath) - (self.Dir:GetNormalized() * math.min(self.SmoothPath, 180))
    local endpos = self.StartPos + self.Dir:GetNormalized() * math.min(self.SmoothPath, self.Path - 180)

    render.SetMaterial( self.Mat )
    render.DrawBeam( startpos, endpos, 70, 1, 0, Color( 255, 255, 255, 255 ) )

    render.SetMaterial( self.Mat2 )
    render.DrawSprite( LerpVector( 0.5, startpos, endpos ), 200, 150, Color( 255, 255, 255, 100 ) )
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
