re.selected_spawnpoint = re.selected_spawnpoint or false
re.selected_clientmodel = re.selected_clientmodel or false
re.selected_spawnmodel = re.selected_spawnmodel or ""
local alpha_lerp, alpha = 0, 0

netstream.Hook("Driver_OpenMenu", function(data)
	if IsValid(Menu) then
		Menu:Remove()
	end

	local draw_blur = true
	local alpha_lerp, alpha = 0, 0
	local select_team = 1
	alpha = 160
	Menu = vgui.Create("DFrame")
	Menu:SetSize(ScrW(), ScrH())
	Menu:Center()
	Menu:MakePopup()
	Menu:SetTitle("")
	Menu:ShowCloseButton(false)

	Menu.Paint = function(self, w, h)
		if not draw_blur then return end
		alpha_lerp = Lerp(FrameTime() * 6, alpha_lerp or 0, alpha or 0) or 0
		local x, y = self:GetPos()
		draw.DrawBlur(x, y, self:GetWide(), self:GetTall(), alpha_lerp / 100)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, alpha_lerp))
	end

	local Close = vgui.Create("DButton", Menu)
	Close:SetSize(30, 30)
	Close:SetText("")
	Close:SetPos(Menu:GetWide() - Close:GetWide() - 10, 10)

	Close.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(191, 67, 57))
		draw.SimpleText("X", luna.MontBase22, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
	end

	Close.DoClick = function(self)
		Menu:Remove()
	end

	local scrollpanel = vgui.Create("DScrollPanel", Menu)
	scrollpanel:SetSize(400, 600)
	scrollpanel:SetPos(Menu:GetWide() * .5 - scrollpanel:GetWide() * .5, Menu:GetTall() * .5 - scrollpanel:GetTall() * .5)
	scrollpanel.Paint = function(self, w, h) end
	local vehicles = vgui.Create("DListLayout", scrollpanel)
	vehicles:Dock(FILL)

	-- vehicles:SetSize( 100, 100 )
	-- vehicles:SetPos( 20, 50 )
	--Draw a background so we can see what it"s doing
	-- vehicles:SetPaintBackground( true )
	-- vehicles:SetBackgroundColor( Color( 0, 100, 100 ) )
	-- vehicles:MakeDroppable( "unique_name" ) -- Allows us to rearrange children
	for feature, data in pairs(VEHICLES_FEATURES) do
		for class, veh in pairs(data) do
			if game.GetMap() ~= DEFAULT_MAP and not GMap.Vehicles[class] then continue end

			local tbl = LocalPlayer():GetNetVar("vehicles")
			local nextbuy = vgui.Create("DButton")
			nextbuy:SetSize(400, 20)
			nextbuy:SetText("")
			local duble = false

			for k, e in pairs(ents.FindByClass(class)) do
				if e:GetNWEntity("VehicleSalesPlayer") == LocalPlayer() then
					-- print(e:GetNWEntity("VehicleSalesPlayer"))
					duble = true
				end
			end

			nextbuy.Paint = function(self, w, h)
				local col = self:IsHovered() and Color(255, 255, 255, 30) or Color(255, 255, 255, 20)
				draw.RoundedBox(0, 0, 0, w, h, col)
				draw.Icon(2, 2, h - 4, h - 4, veh.icon, color_white)
				draw.SimpleText(veh.name, luna.MontBase18, 24, h / 2, Color(255, 255, 255, 255), 0, 1)

				if duble then
					draw.SimpleText("Zwróć", luna.MontBase18, w - 2, h / 2, Color(255, 161, 71, 255), 2, 1)
				else
					if game.GetMap() == DEFAULT_MAP and veh.price > 0 and not tbl[class] then
						draw.SimpleText( formatMoney(veh.price), luna.MontBase18, w - 2, h / 2, Color(140, 179, 62, 255), 2, 1)
					end
				end
			end

			nextbuy.DoClick = function(self)
				if duble then
					netstream.Start("Driver_ReturnVehicle", {
						class = class
					})

					Menu:Remove()
				else
					if veh.price > 0 and not tbl[class] then
						netstream.Start("Driver_BuyVehicle", {
							class = class
						})

						Menu:Remove()
					else
						-- netstream.Start("Driver_SpawnVehicle", { class = class })
						re.selected_spawnpoint = 1
						re.selected_spawnmodel = baseclass.Get(class).MDL
						thirdperson_enabled = false
						scrollpanel:Remove()
						draw_blur = false
						local VEHICLES_SPAWNPOINT = VEHICLES_SPAWNPOINT
						local ent_spawns = ents.FindByClass("vehicles_spawn")

						if #ent_spawns ~= 0 then
							VEHICLES_SPAWNPOINT = {}

							for _, e in ipairs(ent_spawns) do
								table.insert(VEHICLES_SPAWNPOINT, e:GetPos())
							end
						end

						local Spawn = vgui.Create("DButton", Menu)
						Spawn:SetSize(200, 30)
						Spawn:SetText("")
						Spawn:SetPos(Menu:GetWide() * .5 - Spawn:GetWide() * .5, Menu:GetTall() * .7)

						Spawn.Paint = function(self, w, h)
							draw.RoundedBox(0, 0, 0, w, h, Color(141, 105, 199))
							draw.SimpleText("Spawn", luna.MontBase22, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
						end

						local left_btn = vgui.Create("DButton", Menu)
						left_btn:SetSize(30, 30)
						left_btn:SetText("")
						left_btn:SetPos(Menu:GetWide() * .5 - left_btn:GetWide() - Spawn:GetWide() * .5, Menu:GetTall() * .7)

						left_btn.Paint = function(self, w, h)
							draw.RoundedBox(0, 0, 0, w, h, Color(89, 138, 198, 190))
							draw.SimpleText("<", luna.MontBase22, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
						end

						left_btn.DoClick = function(self)
							if VEHICLES_SPAWNPOINT[re.selected_spawnpoint - 1] then
								re.selected_spawnpoint = re.selected_spawnpoint - 1
							end
						end

						local right_btn = vgui.Create("DButton", Menu)
						right_btn:SetSize(30, 30)
						right_btn:SetText("")
						right_btn:SetPos(Menu:GetWide() * .5 + Spawn:GetWide() * .5, Menu:GetTall() * .7)

						right_btn.Paint = function(self, w, h)
							draw.RoundedBox(0, 0, 0, w, h, Color(89, 138, 198, 190))
							draw.SimpleText(">", luna.MontBase22, w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
						end

						right_btn.DoClick = function(self)
							if VEHICLES_SPAWNPOINT[re.selected_spawnpoint + 1] then
								re.selected_spawnpoint = re.selected_spawnpoint + 1
							end
						end

						local function RemoveHolo()
							if re.selected_clientmodel and IsValid(re.selected_clientmodel) then
								re.selected_clientmodel:Remove()
							end

							re.selected_spawnpoint = false
							re.selected_clientmodel = false
							re.selected_spawnmodel = ""
						end

						Spawn.DoClick = function(self)
							netstream.Start("Driver_SpawnVehicle", {
								class = class,
								point = re.selected_spawnpoint
							})

							RemoveHolo()
							Menu:Remove()
						end

						Close.DoClick = function(self)
							RemoveHolo()
							Menu:Remove()
						end
					end
				end
			end

			vehicles:Add(nextbuy)
		end
	end
end)

local function VehSales_CalcView(ply, pos, angles, fov)
	if not re.selected_spawnpoint then return end
	local view = {}
	if not ply or ply:InVehicle() then return end
	if wOS and wOS.CraftingMenu and wOS.CraftingMenu:IsVisible() then return end
	local VEHICLES_SPAWNPOINT = VEHICLES_SPAWNPOINT
	local ent_spawns = ents.FindByClass("vehicles_spawn")

	if #ent_spawns ~= 0 then
		VEHICLES_SPAWNPOINT = {}

		for _, e in ipairs(ent_spawns) do
			table.insert(VEHICLES_SPAWNPOINT, e:GetPos())
		end
	end

	if isnumber(re.selected_spawnpoint) and VEHICLES_SPAWNPOINT[re.selected_spawnpoint] then
		thirdperson_enabled = false
		local new_pos = VEHICLES_SPAWNPOINT[re.selected_spawnpoint]

		if not re.selected_clientmodel then
			re.selected_clientmodel = ClientsideModel(re.selected_spawnmodel, RENDERGROUP_OPAQUE)
		end

		re.selected_clientmodel:SetPos(new_pos)
		re.selected_clientmodel:SetAngles(Angle(0, 0, 0))
		re.selected_clientmodel:SetMaterial("models/wireframe")
		view.angles = Angle(30, -135, 0)
		view.origin = new_pos + Vector(200, 200, 200)
	else
		view.origin = pos
		view.angles = angles
	end

	view.fov = fov
	view.drawviewer = false

	return view
end

hook.Add("CalcView", "VehSales_CalcView", VehSales_CalcView)