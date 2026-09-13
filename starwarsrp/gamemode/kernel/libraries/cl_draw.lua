local matrix = Matrix()
local matrixAngle = Angle(0, 0, 0)
local matrixScale = Vector(0, 0, 0)
local matrixTranslation = Vector(0, 0, 0)
local surface = surface
local draw = draw

function util.textWrap(text, font, maxWidth)
	local totalWidth = 0
	surface.SetFont(font)
	local spaceWidth = surface.GetTextSize(' ')

	text = text:gsub("(%s?[%S]+)", function(word)
		local char = string.sub(word, 1, 1)

		if char == "\n" or char == "\t" then
			totalWidth = 0
		end

		local wordlen = surface.GetTextSize(word)
		totalWidth = totalWidth + wordlen

		-- Wrap around when the max width is reached
		-- Split the word if the word is too big
		if wordlen >= maxWidth then
			local splitWord, splitPoint = draw.charwrap(word, maxWidth - (totalWidth - wordlen), maxWidth)
			totalWidth = splitPoint

			return splitWord
		elseif totalWidth < maxWidth then
			return word
		end

		-- Split before the word
		if char == ' ' then
			totalWidth = wordlen - spaceWidth

			return '\n' .. string.sub(word, 2)
		end

		totalWidth = wordlen

		return '\n' .. word
	end)

	return text
end

function draw.DrawArc(iPosX, iPosY, iRadius, iStartAngle, iEndAngle, bCache)
	iPosX = iPosX or 0
	iPosY = iPosY or 0
	iRadius = iRadius or 100
	iStartAngle = iStartAngle or 0
	iEndAngle = iEndAngle or 360
	iEndAngle = iEndAngle - 90
	iStartAngle = iStartAngle - 90

	local circle = {
		{
			x = iPosX,
			y = iPosY
		}
	}

	local i = 1

	for ang = iStartAngle, iEndAngle do
		i = i + 1

		circle[i] = {
			x = iPosX + math.cos(math.rad(ang)) * iRadius,
			y = iPosY + math.sin(math.rad(ang)) * iRadius,
		}
	end

	if bCache then return circle end
	surface.DrawPoly(circle)
end

function surface.DrawArc( center, startang, endang, radius, roughness, thickness, color )
	draw.NoTexture()
	surface.SetDrawColor( color.r, color.g, color.b, color.a )
	local segs, p = roughness, {}
	for i2 = 0, segs do
		p[i2] = -i2 / segs * (math.pi/180) * endang - (startang/57.3)
	end
	for i2 = 1, segs do
		if endang <= 90 then
			segs = segs/2
		elseif endang <= 180 then
			segs = segs/4
		elseif endang <= 270 then
			segs = segs/6
		else
			segs = segs
		end
		local r1, r2 = radius, math.max(radius - thickness, 0)
		local v1, v2 = p[i2 - 1], p[i2]
		local c1, c2 = math.cos( v1 ), math.cos( v2 )
		local s1, s2 = math.sin( v1 ), math.sin( v2 )
		surface.DrawPoly{
			{ x = center.x + c1 * r2, y = center.y - s1 * r2 },
			{ x = center.x + c1 * r1, y = center.y - s1 * r1 },
			{ x = center.x + c2 * r1, y = center.y - s2 * r1 },
			{ x = center.x + c2 * r2, y = center.y - s2 * r2 },
		}
	end
end

function draw.DrawRing(iPosX, iPosY, iRadius, iThickness, iStartAngle, iEndAngle, tCachedCircle, tCachedRing)
	local tCircle
	local tRing

	if istable(iPosX) and istable(iPosY) then
		if not tCircle then
			tCircle = iPosX
		end

		if not tRing then
			tRing = iPosY
		end
	end

	if not tCircle then
		if tCachedCircle then
			tCircle = tCachedCircle
		else
			tCircle = draw.DrawCircle(iPosX, iPosY, iRadius - iThickness, nil, true)
		end
	end

	render.SetStencilWriteMask(0xFF)
	render.SetStencilTestMask(0xFF)
	render.SetStencilReferenceValue(0)
	render.SetStencilCompareFunction(STENCIL_ALWAYS)
	render.SetStencilPassOperation(STENCIL_KEEP)
	render.SetStencilFailOperation(STENCIL_KEEP)
	render.SetStencilZFailOperation(STENCIL_KEEP)
	render.ClearStencil()
	render.SetStencilEnable(true)
	render.SetStencilReferenceValue(1)
	render.SetStencilFailOperation(STENCIL_REPLACE)
	render.SetStencilCompareFunction(STENCIL_NEVER)
	surface.DrawPoly(tCircle)
	render.SetStencilCompareFunction(STENCIL_NOTEQUAL)

	if tRing then
		surface.DrawPoly(tRing)
	elseif iStartAngle and iStartAngle ~= 0 or iEndAngle and iEndAngle ~= 0 then
		draw.DrawArc(iPosX, iPosY, iRadius, iStartAngle, iEndAngle)
	else
		draw.DrawCircle(iPosX, iPosY, iRadius)
	end

	render.SetStencilEnable(false)
end

function draw.DrawCircle(iPosX, iPosY, iRadius, iVertices, bCache)
	iPosX = iPosX or 0
	iPosY = iPosY or 0
	iRadius = iRadius or 100
	iVertices = iVertices or 200
	local circle = {}
	local i = 0

	for ang = 1, 360, 360 / iVertices do
		i = i + 1

		circle[i] = {
			x = iPosX + math.cos(math.rad(ang)) * iRadius,
			y = iPosY + math.sin(math.rad(ang)) * iRadius,
		}
	end

	if bCache then return circle end
	surface.DrawPoly(circle)
end

local color_outline = Color(20, 20, 20, 100)

function draw.DrawProgressBar(iPosX, iPosY, iWidth, iHeight, tColor, flRatio, tOutlineCol, bOutline)
	iPosX = iPosX or 0
	iPosY = iPosY or 0
	iWidth = iWidth or 100
	iHeight = iHeight or 100
	tColor = tColor or color_white
	flRatio = flRatio or 1
	tOutlineCol = tOutlineCol or color_outline
	surface.SetDrawColor(tColor)
	surface.DrawRect(iPosX, iPosY, iWidth * flRatio, iHeight)

	if bOutline then
		surface.SetDrawColor(tOutlineCol)
		surface.DrawOutlinedRect(iPosX, iPosY, iWidth, iHeight)
	end
end

function draw.DrawCircleProgressBar(iPosX, iPosY, iRadius, flProgress, tColor, iThickness)
	iPosX = iPosX or 0
	iPosY = iPosY or 0
	iRadius = iRadius or 100
	flProgress = flProgress or 1
	tColor = tColor or color_white
	iThickness = iThickness or 10
	local endAngle = 360 * flProgress
	surface.SetDrawColor(tColor)
	draw.DrawRing(iPosX, iPosY, iRadius, iThickness, 0, endAngle)
end

function draw.DrawOutlinedRect(x, y, width, height, color)
	surface.SetDrawColor(color)
	surface.DrawOutlinedRect(x, y, width, height)
end

function draw.charwrap(text, remainingWidth, maxWidth)
	local totalWidth = 0

	text = text:gsub('.', function(char)
		totalWidth = totalWidth + surface.GetTextSize(char)

		if totalWidth >= remainingWidth then
			totalWidth = surface.GetTextSize(char)
			remainingWidth = maxWidth

			return '\n' .. char
		end

		return char
	end)

	return text, totalWidth
end

function scaleY(y)
	return math.Round(y * math.min(ScrW(), ScrH()) / 1080)
end

function scaleX(n)
	if not n then return 0 end

	return ScreenScale(n) / 3
end

function draw.textwrap(text, font, maxWidth)
	local totalWidth = 0
	surface.SetFont(font)
	local spaceWidth = surface.GetTextSize(' ')

	text = text:gsub('(%s?[%S]+)', function(word)
		local char = string.sub(word, 1, 1)

		if char == '\n' or char == '\t' then
			totalWidth = 0
		end

		local wordlen = surface.GetTextSize(word)
		totalWidth = totalWidth + wordlen

		if wordlen >= maxWidth then
			local splitWord, splitPoint = draw.charwrap(word, maxWidth - (totalWidth - wordlen), maxWidth)
			totalWidth = splitPoint

			return splitWord
		elseif totalWidth < maxWidth then
			return word
		end

		if char == ' ' then
			totalWidth = wordlen - spaceWidth

			return '\n' .. string.sub(word, 2)
		end

		totalWidth = wordlen

		return '\n' .. word
	end)

	return text
end

function string.Wrap(font, text, width)
	surface.SetFont(font)
	local sw = surface.GetTextSize(" ")
	local ret = {}
	local w = 0
	local s = ""
	local t = string.Explode("\n", text)

	for i = 1, #t do
		local t2 = string.Explode(" ", t[i], false)

		for i2 = 1, #t2 do
			local neww = surface.GetTextSize(t2[i2])

			if w + neww >= width then
				ret[#ret + 1] = s
				w = neww + sw
				s = t2[i2] .. " "
			else
				s = s .. t2[i2] .. " "
				w = w + neww + sw
			end
		end

		ret[#ret + 1] = s
		w = 0
		s = ""
	end

	if s ~= "" then
		ret[#ret + 1] = s
	end

	return ret
end

function draw.TextRotated(text, font, x, y, xScale, yScale, angle, color, bshadow)
	render.PushFilterMag(TEXFILTER.LINEAR)
	render.PushFilterMin(TEXFILTER.LINEAR)
	matrix:SetTranslation(Vector(x, y))
	matrix:SetAngles(Angle(0, angle, 0))
	surface.SetFont(font)

	if bshadow then
		surface.SetTextColor(Color(0, 0, 0, 90))
		matrixScale.x = xScale
		matrixScale.y = yScale
		matrix:Scale(matrixScale)
		surface.SetTextPos(1, 1)
		cam.PushModelMatrix(matrix)
		surface.DrawText(text)
		cam.PopModelMatrix()
	end

	surface.SetTextColor(color)
	surface.SetTextPos(0, 0)
	cam.PushModelMatrix(matrix)
	surface.DrawText(text)
	cam.PopModelMatrix()
	render.PopFilterMag()
	render.PopFilterMin()
end

local color_shadow = ColorAlpha(color_black, 200)

function draw.ShadowSimpleText(text, font, x, y, color, alignment_x, alignment_y, shadow_distance)
	shadow_distance = shadow_distance or 1
	draw.SimpleText(text, font, x, y + shadow_distance, color_shadow, alignment_x, alignment_y)

	return draw.SimpleText(text, font, x, y, color, alignment_x, alignment_y)
end

function draw.DrawPolyLine(tblVectors, tblColor)
	surface.SetDrawColor(tblColor)
	draw.NoTexture()
	surface.DrawPoly(tblVectors)
end

function draw.Icon(x, y, w, h, Mat, tblColor)
	surface.SetMaterial(Mat)
	surface.SetDrawColor(tblColor or Color(255, 255, 255, 255))
	surface.DrawTexturedRect(x, y, w, h)
end

local blur = Material("pp/blurscreen", "noclamp")

function draw.DrawBlur(x, y, w, h, amount)
	render.ClearStencil()
	render.SetStencilEnable(true)
	render.SetStencilReferenceValue(1)
	render.SetStencilTestMask(1)
	render.SetStencilWriteMask(1)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
	render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawRect(x, y, w, h)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilPassOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
	surface.SetMaterial(blur)
	surface.SetDrawColor(255, 255, 255, 255)

	for i = 0, 1, 0.33 do
		blur:SetFloat('$blur', i * (amount or 0.2))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
	end

	render.SetStencilEnable(false)
end

function draw.StencilBlur(panel, w, h)
	render.ClearStencil()
	render.SetStencilEnable(true)
	render.SetStencilReferenceValue(1)
	render.SetStencilTestMask(1)
	render.SetStencilWriteMask(1)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
	render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawRect(0, 0, w, h)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilPassOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
	surface.SetMaterial(blur)
	surface.SetDrawColor(255, 255, 255, 255)

	for i = 0, 1, 0.33 do
		blur:SetFloat('$blur', 5 * i)
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		local x, y = panel:GetPos()
		surface.DrawTexturedRect(-x, -y, ScrW(), ScrH())
	end

	render.SetStencilEnable(false)
end

-- function draw.Circle( center, radius, segs, color )
-- 	local cir = {}
-- 	local x, y = center.x, center.y
-- 	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
-- 	for i = 0, segs do
-- 		local a = math.rad( ( i / segs ) * -360 )
-- 		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
-- 	end
-- 	local a = math.rad( 0 ) -- This is needed for non absolute segment counts
-- 	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
-- 	surface.SetDrawColor( color.r, color.g, color.b, color.a )
-- 	surface.DrawPoly( cir )
-- end
function draw.Arc(center, startang, endang, radius, roughness, thickness, color)
	draw.NoTexture()
	surface.SetDrawColor(color.r, color.g, color.b, color.a)
	local segs, p = roughness, {}

	for i2 = 0, segs do
		p[i2] = -i2 / segs * math.pi / 180 * endang - startang / 57.3
	end

	for i2 = 1, segs do
		if endang <= 90 then
			segs = segs / 2
		elseif endang <= 180 then
			segs = segs / 4
		elseif endang <= 270 then
			segs = segs / 6
		else
			segs = segs
		end

		local r1, r2 = radius, math.max(radius - thickness, 0)
		local v1, v2 = p[i2 - 1], p[i2]
		local c1, c2 = math.cos(v1), math.cos(v2)
		local s1, s2 = math.sin(v1), math.sin(v2)

		surface.DrawPoly{
			{
				x = center.x + c1 * r2,
				y = center.y - s1 * r2
			},
			{
				x = center.x + c1 * r1,
				y = center.y - s1 * r1
			},
			{
				x = center.x + c2 * r1,
				y = center.y - s2 * r1
			},
			{
				x = center.x + c2 * r2,
				y = center.y - s2 * r2
			},
		}
	end
end

function surface.GetTextWidth(text, font)
	surface.SetFont(font)

	return surface.GetTextSize(text)
end

function surface.DrawShadowTexts(text, font, posX, posY, textColor, shadowColor, align, shadowOffsetX, shadowOffsetY)
	draw.DrawText(text, font, posX + (shadowOffsetY or 1), posY + (shadowOffsetX or 1), shadowColor, align or TEXT_ALIGN_LEFT)
	draw.DrawText(text, font, posX, posY, textColor, align)
end

local color_shadow = ColorAlpha(color_black, 200)

function surface.DrawShadowText(text, font, x, y, color, alignment_x, alignment_y, shadow_distance)
	shadow_distance = shadow_distance or 1
	draw.SimpleText(text, font, x, y + shadow_distance, color_shadow, alignment_x, alignment_y)

	return draw.SimpleText(text, font, x, y, color, alignment_x, alignment_y)
end