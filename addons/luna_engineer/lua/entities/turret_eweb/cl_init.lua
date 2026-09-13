--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


include("shared.lua")

function ENT:Initialize()
	self.MuzzleAttachment=self:LookupAttachment("muzzle")
	self.shootPos=self:GetShootPos()--GetDTEntity(1)
	
end
--[[
ENT.HiddenShooter=false
function ENT:Think()
	if not self.HiddenShooter and IsValid(self.shootPos) then
		self.shootPos:SetRenderMode(RENDERMODE_TRANSCOLOR)
		self.shootPos:SetColor(Color(255,255,255,1))
		self.HiddenShooter=true
	end
	
end]]

local color_lightwhite = Color(250,250,250)
local color_outline = Color(25,25,25,100)
local color_green = Color(39, 174, 96)

function ENT:Draw()
	
	self:DrawModel()

	if (self:GetTurretBase()) and (IsValid(self:GetTurretBase())) then

		local Ang = self:GetTurretBase():GetAngles()
		local Pos = self:GetTurretBase():GetPos()

		local ammo = self:GetTAmmo()
		local perc = math.ceil((ammo*100)/500)

		-- Ang:RotateAroundAxis(self:GetAngles():Forward(), 90)
		Ang:RotateAroundAxis(self:GetTurretBase():GetAngles():Up(), 180)
		
		
		cam.Start3D2D(Pos + Ang:Up() * 20.8 + Ang:Forward()*-15.51 + Ang:Right()*77.8, Ang, 0.07 )

			surface.SetDrawColor(color_black)
			surface.DrawRect(0,0, -95, -95)

			surface.SetDrawColor(color_green)
			surface.DrawRect(0,0, -95, -95 * (perc / 100))

			draw.SimpleTextOutlined(perc.."%", "DermaLarge", -47.5, -47.5,  color_lightwhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_outline )

		cam.End3D2D()

	end
	
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
