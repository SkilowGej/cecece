--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

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

	--if self:GetNextPrimaryFire() < CurTime() then
		draw.RoundedBox(0, 375, H - height - 21, wide, height, color_grayDarkner)
	-- else
		draw.RoundedBox(0, 375, H - height - 21, wide, _barHeight, color_grayDarkner)
	--end

	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(self.Hook_icon)
	surface.DrawTexturedRect(377, H - height - 20, 30, 30)
    --
    local ChargeBarCol = { White = Color(255,255,255), DefCol1 = Color(40, 116, 237), DefCol2 = Color(40, 116, 237) }
    --local Gradient = Material( "gui/gradient" )
    local function DrawChargeBar( xpos, ypos, width, height, charge, col1, col2 )
	draw.NoTexture()
	
	surface.SetDrawColor( ChargeBarCol.White )
	surface.DrawOutlinedRect( xpos, ypos, width, height )
	
	charge = math.Clamp( charge or 50, 0, 100)
	barLen = (width-2)*(charge/100)
	render.SetScissorRect( xpos+1, ypos+1, xpos+1+barLen, (ypos+height)-1, true )
    surface.SetDrawColor( col2 or ChargeBarCol.DefCol2 )
    surface.DrawRect( xpos+1, ypos+1, width-1, height-2 )
		
    --surface.SetMaterial( Gradient )
    surface.SetDrawColor( col1 or ChargeBarCol.DefCol1 )
    surface.DrawTexturedRect( xpos+1, ypos+1, width-1, height-2 )
	render.SetScissorRect( xpos+1, ypos+1, xpos+1+barLen, (ypos+height)-1, false )
	
	draw.NoTexture()
end

    if IsValid( self:GetHook() ) and self:GetHook():GetHasHit() then
		draw.ShadowSimpleText( "Długość: "..tostring(self:GetHook():GetDist()), luna.LunaMontMini, ScrW()/2-30, ScrH()/2+40 )
		draw.ShadowSimpleText( (input.LookupBinding("+attack") or "[LPM]"):upper() .. " - Zmniejsz", luna.LunaMontMini, ScrW()/2-60, ScrH()/2+70 )
		draw.ShadowSimpleText( (input.LookupBinding("+attack2") or "[PPM]"):upper() .. " - Rozciągnij", luna.LunaMontMini, ScrW()/2-60, ScrH()/2+85 )
		draw.ShadowSimpleText( (input.LookupBinding("+reload") or "[PRZEŁADOWANIE]"):upper() .. " - Zerwij", luna.LunaMontMini, ScrW()/2-60, ScrH()/2+100 )
		
		if IsValid( self:GetHook():GetTargetEnt() ) and self:GetHook():GetTargetEnt():IsPlayer() then
			DrawChargeBar( (ScrW()/2-60)-70, (ScrH()/2)+20, 140, 15, self:GetHook():GetDurability() )
		else
			draw.ShadowSimpleText( (input.LookupBinding("+use") or "[E]"):upper() .. " - Skok", luna.LunaMontMini, ScrW()/2-60, ScrH()/2+115 )
		end
	elseif self:GetCooldown()>0 then
		DrawChargeBar( (ScrW()/2)-70, (ScrH()/2)+20, 140, 15, self:GetCooldown() )
	end
	
	if self:Clip1()>=0 then
		draw.ShadowSimpleText( "Resztki liny: " .. tostring(self:Clip1()), luna.LunaMontMini, ScrW()/2, ScrH()-50 )
	end

    local ply = LocalPlayer()

    local x, y = ScrW()-1505, ScrH()-40
  
    draw.ShadowSimpleText("LPM / PPM - Rzuć hak", luna.LunaMontMini, x, y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
    draw.ShadowSimpleText("R - Anuluj przyczepienie", luna.LunaMontMini, x, y+20, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
	
	--return self.BaseClass.DrawHUD( self ) // TTT Crosshair is drawn here, we have to call it
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
