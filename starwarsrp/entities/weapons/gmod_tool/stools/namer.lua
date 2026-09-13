TOOL.Category = "Renaissance Tools"
TOOL.Name = "Namer"
TOOL.Command = nil
TOOL.ConfigName = ""

if CLIENT then
	language.Add("tool.namer.name", "Namer")
	language.Add("tool.namer.0", "ЛКМ - назвать объект, ПКМ - Убрать название")
	language.Add("tool.namer.desc", "Используется чтобы помечать объекты")
end

TOOL.ClientConVar["printName"] = "Beatufil Name"
TOOL.ClientConVar["color_r"] = 255
TOOL.ClientConVar["color_g"] = 255
TOOL.ClientConVar["color_b"] = 255
TOOL.ClientConVar["color_a"] = 255
TOOL._nextUse = nil

function TOOL:LeftClick(trace)
	if CLIENT then return end
	if (self._nextUse or 0) >= CurTime() then return end
	self._nextUse = CurTime() + .1
	local pl, ent = self:GetOwner(), trace.Entity
	if not pl:IsAdmin() then return end
	if not IsValid(ent) then return end
	ent:SetNWString("namer", pl:GetInfo("namer_printName"))
	ent:SetNWString("namer_color", tostring(Color(pl:GetInfo("namer_color_r"), pl:GetInfo("namer_color_g"), pl:GetInfo("namer_color_b"), pl:GetInfo("namer_color_a"))))

	return true
end

function TOOL:RightClick(trace)
	if CLIENT then return end
	if (self._nextUse or 0) >= CurTime() then return end
	self._nextUse = CurTime() + .1
	if not self:GetOwner():IsAdmin() then return end
	if not IsValid(ent) then return end
	ent:SetNWString("namer", "")
	ent:SetNWString("namer_color", "")

	return true
end

function TOOL:Deploy()
end

function TOOL.BuildCPanel(CPanel)
	CPanel:AddControl("TextBox", {
		Label = "Name",
		Command = "namer_printName",
		MaxLength = "30"
	})

	CPanel:AddControl("Color", {
		Label = "Text Color",
		Red = "namer_color_r",
		Green = "namer_color_g",
		Blue = "namer_color_b",
		ShowAlpha = "0",
		ShowHSV = "1",
		ShowRGB = "1"
	})
end

local shows = {}

hook.Add("HUDPaint", "Namer", function()
	local trace = LocalPlayer():GetEyeTrace()
	local ent = trace.Entity
	
	if not IsValid(ent) then
		return
	end

	if not ent:GetNWString("namer") then
		return
	end

	if not shows[ent] and ent:GetNWString("namer") != "" then
		shows[ent] = {
			name = ent:GetNWString("namer"),
			time = CurTime() + 5
		}
	end

	for e, show in pairs(shows) do
		if CurTime() >= show.time then
			if e == ent then
				show.time = CurTime() + 5
			else
				shows[e] = nil
				continue
			end
		end

		if e and IsValid(e) then
			local maxs = e:OBBMaxs()
			local center = e:OBBCenter()
			local pos = e:LocalToWorld(center)
			local scr = pos:ToScreen()
			draw.ShadowSimpleText(e:GetNWString("namer"), luna.MontBase24, scr.x, scr.y, string.ToColor(e:GetNWString("namer_color")), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end)