--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

-- surface.CreateFont('Jetted',{font='Trebuchet MS',size=48,weight=400})

local function DrawRect(col,x,y,w,h)
	x, y = math.Round(x), math.Round(y)
	w, h = math.Round(w), math.Round(h)
	surface.SetDrawColor(col.r,col.g,col.b,col.a)
	surface.DrawRect(x,y,w,h)
end

local function DrawText(...)
	local aye = {...}
	surface.SetFont(aye[1])
	local oldx, oldy = 0, 0
	for i = 4, #aye do
		if istable(aye[i]) then
			surface.SetTextColor(aye[i])
		else
			surface.SetTextPos(aye[2]+oldx,aye[3])
			surface.DrawText(tostring(aye[i]))
			local _ox, _oy = surface.GetTextSize(tostring(aye[i]))
			oldx, oldy = oldx+_ox, oldy+_oy
		end
	end
end

local function GetTextSize(...)
	local aye = {...}
	surface.SetFont(aye[1])
	local legx, legy = 0, 0
	for i = 2, #aye do
		if isstring(aye[i]) then
			local xd, yd = surface.GetTextSize(tostring(aye[i]))
			legx = legx + xd
			legy = legy > yd and legy or yd
		end
	end
	return legx, legy
end

local MSW, MSH = ScrW(), ScrH()
local fuelbarwidth, fuelbarheigth = 256, 48
local col_bg = Color(0,0,0,192)
local col_fuel = Color(255,128,0,255)
local col_txt = Color(255,255,255)
local jet, cf, mf = NULL, 100, 100
local color_grayDarkner = Color(31, 31, 31)
local color_gray = Color(75, 75, 75)
local color_grayLighter = Color(92, 92, 92)
local color_yellow = Color(255, 255, 0)
local jet_icon = Material("luna_icons/jetpack.png", "noclamp smooth")

hook.Add('Tick','Jetted',function()
    local p = LocalPlayer()
    if IsValid( p ) then    
        jet = p:GetNWEntity('Jetted')
        if !IsValid(jet) then return end
        cf, mf = jet:GetFuel(), jet:GetMaxFuel()
    end
end)

-- hook.Add('HUDPaint','jetted',function()
-- 	if !IsValid(jet) then return end
-- 	local percent = math.floor(cf/mf*100)
-- 	-- DrawRect(col_bg,MSW/4-fuelbarwidth/2,MSH-fuelbarheigth*1.4,fuelbarwidth,fuelbarheigth)
-- 	-- DrawRect(col_fuel,MSW/4-fuelbarwidth/2+4,MSH-fuelbarheigth*1.4+4,(fuelbarwidth-8)*percent/100,fuelbarheigth-8)
-- 	DrawText('font_base_22',MSW/2-fuelbarwidth/5,MSH-fuelbarheigth*3,col_txt,'Заряд: '..percent..'%')
-- end)

hook.Add('HUDPaint','jetted',function()
	if !IsValid(jet) then return end
    local percent = math.floor(cf/mf*100)
	local W, H = ScrW(), ScrH()
	local wide, height = 33, 33
	local _remap = math.Remap(20 / 10, 0, 1, 1, 0)
	local _barHeight = math.min(height * _remap, height)
	draw.RoundedBox(0, 375 - 2, H - height - 21 - 2, wide + 4, height + 4, color_grayLighter)
	draw.RoundedBox(0, 375, H - height - 21, wide, height, color_gray)
	-- 	-- DrawRect(col_bg,MSW/4-fuelbarwidth/2,MSH-fuelbarheigth*1.4,fuelbarwidth,fuelbarheigth)
-- 	-- DrawRect(col_fuel,MSW/4-fuelbarwidth/2+4,MSH-fuelbarheigth*1.4+4,(fuelbarwidth-8)*percent/100,fuelbarheigth-8)

	--if self:GetNextPrimaryFire() < CurTime() then
		draw.RoundedBox(0, 375, H - height - 21, wide, height, color_grayDarkner)
	-- else
		draw.RoundedBox(0, 375, H - height - 21, wide, _barHeight, color_grayDarkner)
	--end

	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(jet_icon)
	surface.DrawTexturedRect(377, H - height - 20, 30, 30)

  local ply = LocalPlayer()

  local x, y = ScrW()-1505, ScrH()-40

  draw.ShadowSimpleText("LPM - Dezaktywacja Jetpacka", luna.LunaMontMini, x, y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
  --DrawText('luna.LunaMontMini',MSW/2-fuelbarwidth/5,MSH-fuelbarheigth*3,col_txt,'Заряд: '..percent..'%')
  draw.ShadowSimpleText('Paliwo: '..percent..'%', luna.LunaMontMini, x, y+20, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
end)


















--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
