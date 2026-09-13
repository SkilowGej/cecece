--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")
include("animations.lua")

SWEP.Category			= "SUP • Wyposażenie"

SWEP.UseHands = true
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true
SWEP.ViewModelFOV = 60

SWEP.Slot = 5
SWEP.SlotPos = 3

SWEP.ShowWorldModel = true
SWEP.ShowViewModel = false

SWEP.WCustom = true
SWEP.WBone = "ValveBiped.Bip01_R_Hand"
SWEP.WPos = Vector(4,2,3)
SWEP.WAng = Angle(180,-90-45,15)

local function draw_DrawCircle( x, y, radius, segs, color )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, segs do
		local a = math.rad( ( i / segs ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is needed for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	-- surface.SetDrawColor( color.r, color.g, color.b, color.a )
	surface.DrawPoly( cir )
end

local transparent_white = Color( 255, 255, 255, 1 )
local color_faded_black = Color( 225, 225, 225, 2 )
local color_red = Color( 255, 0, 0, 255 )
local primary_used_delay = 0
local secondary_used_delay = 0
--local AREmb = Material( "celestia/cwrp/hud/heart.png", "Health Emblem" )
local AREmb = Material( "luna_ui_base/etc/pokecog.png", "Health Emblem" )

local color_grayDarkner = Color(31, 31, 31)
local color_gray = Color(75, 75, 75)
local color_grayLighter = Color(92, 92, 92)
local color_yellow = Color(255, 255, 0)

function SWEP:DrawHUD()

	local W, H = ScrW(), ScrH()
	local wide, height = 33, 33
	local _remap = math.Remap((self:GetNextPrimaryFire() - CurTime()) / 10, 0, 1, 1, 0)
	local _barHeight = math.min(height * _remap, height)
	draw.RoundedBox(0, 375 - 2, H - height - 21 - 2, wide + 4, height + 4, color_grayLighter)
	draw.RoundedBox(0, 375, H - height - 21, wide, height, color_gray)

	if self:GetNextPrimaryFire() < CurTime() then
		draw.RoundedBox(0, 375, H - height - 21, wide, height, color_grayDarkner)
	else
		draw.RoundedBox(0, 375, H - height - 21, wide, _barHeight, color_grayDarkner)
	end

	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(self.Armor_icon)
	surface.DrawTexturedRect(376, H - height - 20, 30, 30)

	local ply = LocalPlayer()

    local x, y = ScrW()-1505, ScrH()-40

    draw.ShadowSimpleText("LPM - Napraw pancerz sojusznika", "lunaMontMini", x, y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
    draw.ShadowSimpleText("PPM - Napraw własny pancerz", "lunaMontMini", x, y+20, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

	local ent = LocalPlayer():GetEyeTrace().Entity

	if not ent:IsPlayer() then return end

	local x,y = ScrW() / 2, ScrH() / 2
	local center = Vector( x, y, 0 ) -- Vector Center of the Screen
	local rangeToEnt = self.Owner:GetPos():DistToSqr(ent:GetPos()) -- Distance from player to Entity
	local I = (500 / rangeToEnt) * 750

	local hp_percent = ent:Armor() / 255
	local percent = math.Clamp(hp_percent * 360, 0, 360)
	if hp_percent == 1 then return end
	local cur_color = { math.Clamp(255 * hp_percent, 125, 150), math.Clamp(255 * hp_percent, 10, 255), 0 }

	surface.SetDrawColor( color_faded_black )

	draw.NoTexture()
	draw_DrawCircle( x, y, I, 20, 360 )

	surface.SetDrawColor( cur_color[1], cur_color[2], 0, 75 )

	draw.NoTexture()
	draw_DrawCircle( x, y, I, 360, percent )

	surface.SetDrawColor( 255, 255, 255, 190 )

	surface.SetMaterial(AREmb)
	surface.DrawTexturedRect( ( center.x - (I / 2) ), ( center.y - (I / 2) ), I, I)

	surface.SetDrawColor( cur_color[1], cur_color[2], 0, 255 )
	surface.DrawCircle( x, y, I * 1.001 )
end

SWEP.VElements = {
	["v_element"] = { type = "Model", model = "models/workshop/player/ghoto/medic/dec19_pocketmedes/dec19_pocketmedes.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.068, 2, 8.198), angle = Angle(220, -60, 110), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 3, bodygroup = {} }
}

-- SWEP.WElements = {
-- 	["w_element"] = { type = "Model", model = "models/sterling/w_enhanced_metaldetector.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(16.501, -0.511, -0.77), angle = Angle(0, -90, 220), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 3, bodygroup = {} }
-- }


function SWEP:OnRemove()
	self:Anim_OnRemove()
end

function SWEP:ViewModelDrawn()
	self:Anim_ViewModelDrawn()
end

function SWEP:PreDrawViewModel(vm)
	if self.ShowViewModel == false then
		render.SetBlend(0)
	end
end

function SWEP:PostDrawViewModel(vm)
	if self.ShowViewModel == false then
		render.SetBlend(1)
	end
end

function SWEP:DrawWorldModel()
	self:Anim_DrawWorldModel()
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
