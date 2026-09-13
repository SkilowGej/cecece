--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


hook.Add( "AddToolMenuCategories", "SWPing", function()
	spawnmenu.AddToolCategory( "Options", "SW Ping Options", "#StarWars Ping" ) 
end )

hook.Add( "PopulateToolMenu", "SWPingSettingMenu", function()
	spawnmenu.AddToolMenuOption( "Options", "SW Ping Options", "KCMacroOptions", "#Client Settings", "", "", function( panel )
		panel:ClearControls()
		panel:CheckBox("Play the Macrobinoculars place/remove/fail sounds LOCALLY", "macroping_play_base_sounds")
        panel:CheckBox("Play the Macrobinoculars zooming sounds", "macroping_play_zoom_sounds")
		panel:CheckBox("Draw the Macrobinoculars Overlay", "macroping_draw_overlay")
		panel:CheckBox("Draw the Macrobinoculars Sci-Fi effect", "macroping_draw_scifi")
	end )

	spawnmenu.AddToolMenuOption( "Options", "SW Ping Options", "KSMacroOptions", "#Server Settings", "", "", function( panel )
		panel:ClearControls()
		panel:CheckBox("Play the Macrobinoculars place waypoint sound to everyone", "macroping_play_sounds_all")
	end )

end )




if CLIENT then
	-- surface.CreateFont("lunaMontMediumFont", {
	-- 	font = "Trebuchet MS",
	-- 	outline = true,
	-- 	size = 26
	-- })

	if not ConVarExists("macroping_play_base_sounds") then
		CreateClientConVar("macroping_play_base_sounds", "1", true, false, "Play the Macrobinoculars place/remove/fail sounds LOCALLY")
	end

	if not ConVarExists("macroping_play_zoom_sounds") then
		CreateClientConVar("macroping_play_zoom_sounds", "1", true, false, "Play the Macrobinoculars zooming sounds")
	end

	if not ConVarExists("macroping_draw_overlay") then
		CreateClientConVar("macroping_draw_overlay", "1", true, false, "Draw the binos overlay")
	end

	if not ConVarExists("macroping_draw_scifi") then
		CreateClientConVar("macroping_draw_scifi", "1", true, false, "Draw the binos sci-fi effect")
	end

	net.Receive("kaito_waypoints_sounds", function ()
		local check = GetConVar("macroping_play_base_sounds"):GetInt() -- noped if convar
		if check != 1 then return end
		sType = net.ReadString() -- getting notif type
		if (sType == "remove") then
			surface.PlaySound("kaito/macroping/waypoint_remove.mp3")
		elseif (sType == "add") then
			surface.PlaySound( "kaito/macroping/waypoint_place.mp3") 
		else
			surface.PlaySound( "kaito/macroping/waypoint_fail.mp3") -- you fuckin failure.
		end
	end)



end


hook.Add("HUDPaint", "Sparks_Macrobinoculars_DrawWaypoints", function ()

	local waypoints = ents.FindByClass("waypoint_marker")
	for k,v in ipairs(waypoints) do

		local point = v:GetPos() + v:OBBCenter() //bruh -- no u ?
		
		local opacity = (point:DistToSqr(LocalPlayer():GetPos()))^2 //cancer -- i prefer aids.
		//print(opacity)
		//print(opacity/4)
		local fade = math.Clamp(((opacity/4)/100)*125, 0, 125) //makes shit fade in/out as you get closer/further
		//print(fade)
		local wp_colors = { //this is pretty fucking bad but also i dont care because it works -- yeah i can get that
		[1] = Color(255,0,0,fade),
		[2] = Color(0,255,0,fade),
		[3] = Color(0,0,255,fade),
		[4] = Color(255,255,0,fade),
		[5] = Color(255,0,255,fade),
		["black"] = Color(0,0,0,fade)
		}

		

		//if opacity/4 > 100 then
			local scale = math.Clamp( ( (point:DistToSqr(LocalPlayer():GetPos())) / 500)^2, 15, 20) //dist2sqr is annoying
			local point2D = point:ToScreen()
			point2D.x = math.Clamp(point2D.x, 0, ScrW())
			point2D.y = math.Clamp(point2D.y, 0, ScrH())
			point2D.visible = true
			local diamond = { //fuck you clockwise ordering -- yeah i can guess 
				{x = point2D.x + 0*scale, y = point2D.y + 1*scale}, --up
				{x = point2D.x + 1*scale, y = point2D.y + 0*scale}, --right
				{x = point2D.x + 0*scale, y = point2D.y - 1*scale}, --down
				{x = point2D.x - 1*scale, y = point2D.y + 0*scale} --left -- now do a barrel roll.
			}
			local border = {
				{x = point2D.x + 0*scale, y = point2D.y + 1.2*scale}, --up
				{x = point2D.x + 1.2*scale, y = point2D.y + 0*scale}, --right
				{x = point2D.x + 0*scale, y = point2D.y - 1.2*scale}, --down
				{x = point2D.x - 1.2*scale, y = point2D.y + 0*scale} --left -- BARREL ROLL
			}

			local ping = Material('luna_ui_base/etc/position-marker.png', 'smooth noclamp')
			surface.SetDrawColor(wp_colors["black"]) -- racist.
			surface.DrawPoly(border) -- well that settles it
			surface.SetDrawColor(wp_colors[v:GetColorType()])
			surface.DrawPoly(diamond) //people having issues with this one specifically not working but i have no fucking clue why so suck my nuts
			-- surface.SetMaterial(ping)
			-- surface.SetDrawColor(wp_colors[v:GetColorType()])
			-- surface.DrawTexturedRect(0, 0, point2D.x, point2D.y + -32-(5*scale))
			draw.ShadowSimpleText(v:GetWaypointName(), "font_base_24", point2D.x, point2D.y + -16-(1*scale), Color(255,255,255,fade),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
       		local dist = LocalPlayer():GetPos():Distance(v:GetPos()) // modif : get distance from point
        	local mText = math.Round(dist / 40, 1) .. "м." // modif : get the distance in meter
			draw.ShadowSimpleText(mText,"font_base_24", point2D.x, point2D.y + -32-(1*scale), Color(255,255,255,fade),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) // modif : add the text 
			// above the marker

		end

	//end


end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
