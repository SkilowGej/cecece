if not CLIENT then return end
AddCSLuaFile()

net.Receive("ConnectionMsg", function(len)
	local CM_Data = net.ReadTable()
	chat.AddText(Color(255, 255, 255), "● ", unpack(CM_Data))
end)

local re_knopka = Material("luna_ui_base/etc/key_cap_icon.png")
module("re_info", package.seeall)

tbl = {
	["itemstore_bank"] = {
		{
			key = "E",
			info = "Użyj"
		}
	},
	["bodyman_closet"] = {
		{
			key = "E",
			info = "Zmień wygląd"
		}
	},
	["npc_permweapons"] = {
		{
			key = "E",
			info = "Otwórz sklep"
		}
	},
	["raychamp_perk"] = {
		{
			key = "E",
			info = "Otwórz menu ulepszeń"
		}
	},
	["or_gun_platform_artillery"] = {
		{
			key = "E",
			info = "Zajmij miejsce artylerii"
		}
	},
	["zay_artillery_unlimited"] = {
		{
			key = "E",
			info = "Nastaw artylerię"
		}
	},
	["zay_artillery"] = {
		{
			key = "E",
			info = "Навести Артиллерию"
		}
	},
	["lfs_fb_laatigunship"] = {
		{
			key = "E",
			info = "Zajmij miejsce w LAAT"
		}
	},
	["ammobox"] = {
		{
			key = "E",
			info = "Uzupełnij amunicję"
		}
	},
	["supreme_arsenal"] = {
		{
			key = "E",
			info = "Weź broń"
		}
	},
	["itemstore_shop"] = {
		{
			key = "E",
			info = "Użyj"
		}
	},
	["prop_door_rotating"] = {
		{
			key = "E",
			info = "Otwórz / Zamknij"
		},
	},
	["func_door"] = {
		{
			key = "E",
			info = "Otwórz / Zamknij"
		},
	},
	-- ["spawned_weapon"] = {
	-- 	{
	-- 		key = "E",
	-- 		info = "Использовать"
	-- 	},
	-- },
	["spawned_food"] = {
		{
			key = "E",
			info = "Użyj"
		},
	},
	["spawned_shipment"] = {
		{
			key = "E",
			info = "Weź"
		},
	},
	["spawned_ammo"] = {
		{
			key = "E",
			info = "Weź"
		}
	},
	["mediaplayer_tv"] = {
		{
			key = "E",
			info = "Włącz / Wyłącz"
		}
	},
	["mortar"] = {
		{
			key = "E",
			info = "Użyj moździerza"
		}
	},
	["joefort_ressource_250"] = {
		{
			key = "E",
			info = "Uzupełnij zasoby"
		}
	},
	["joefort_ressource_1000"] = {
		{
			key = "E",
			info = "Uzupełnij zasoby"
		}
	},
	["joefort_ressource_100"] = {
		{
			key = "E",
			info = "Uzupełnij zasoby"
		}
	},
	["sent_40k_fieldcannon"] = {
		{
			key = "E",
			info = "Zajmij działo"
		}
	},
	["npc_igs"] = {
		{
			key = "E",
			info = "Pomóż w rozwoju serwera"
		}
	},
	["gum_command"] = {
		{
			key = "E",
			info = "Zajmij Tren. Salę"
		}
	},
	["rpid_changer"] = {
		{
			key = "E",
			info = "Zmień ID"
		}
	},
	["vehicles_sales"] = {
		{
			key = "E",
			info = "Poproś o pojazd"
		}
	},
	["armor_take"] = {
		{
			key = "E",
			info = "Weź broń"
		}
	},
	["npc_pointshop"] = {
		{
			key = "E",
			info = "Odwiedź Rynek"
		}
	},
	["ammoboxinf"] = {
		{
			key = "E",
			info = "Uzupełnij amunicję"
		}
	},
	["ar2_blasters"] = {
		{
			key = "E",
			info = "Uzupełnij amunicję"
		}
	},
	["rpg_grenades"] = {
		{
			key = "E",
			info = "Uzupełnij amunicję"
		}
	},
	["smg_snipers"] = {
		{
			key = "E",
			info = "Uzupełnij amunicję"
		}
	},
	["func_button"] = {
		{
			key = "E",
			info = "Aktywuj / Dezaktywuj"
		},
	},
	["joe_bomb"] = {
		{
			key = "E",
			info = "Rozpocznij rozbrajanie"
		},
	},
	["cupboard_take"] = {
		{
			key = "E",
			info = "Zmień wygląd"
		}
	},
	["kote_scrap"] = {
		{
			key = "E",
			info = "Zbierz materiał"
		}
	}
}

-- tbl.halos = {
-- 	["ar2_blasters"] = {
-- 		re_halo = true
-- 	},
-- 	["rpg_grenades"] = {
-- 		re_halo = true
-- 	},
-- 	["smg_snipers"] = {
-- 		re_halo = true
-- 	},
-- 	["joefort_ressource_1000"] = {
-- 		re_halo = true
-- 	},
-- 	["joefort_ressource_100"] = {
-- 		re_halo = true
-- 	},
-- 	["joefort_ressource_250"] = {
-- 		re_halo = true
-- 	}
-- }

local function build(keys, info, amount)
	surface.SetFont(luna.MontBase24)
	local boxsizew, boxsizeh = 36, 36
	local infosizew, _ = surface.GetTextSize(info)
	local padding = -25
	local down = 300
	local w, h = ScrW(), ScrH()
	draw.ShadowSimpleText(info, luna.MontBase24, w / 2 + boxsizew / 2, h / 2 + down + (amount / 0.025), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0))

	local w_center = w / 2
	-- фикс
	for i, key in pairs(keys) do
		local left = ((i-1) * (boxsizew + 30))

		surface.SetMaterial(re_knopka)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(w / 2 - boxsizew / 2 - (infosizew + boxsizew + padding) / 2 - left, h / 2 - boxsizeh / 2 + down + (amount / 0.025), boxsizew, boxsizeh)
		draw.SimpleText(key, luna.MontBase24, w / 2 - (infosizew + boxsizew + padding) / 2 - left, h / 2 + down + (amount / 0.025), Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		if i-1 ~= 0 then
			draw.ShadowSimpleText("+", luna.MontBase30, w / 2 - boxsizew / 2 - (infosizew + boxsizew + padding) / 2 - left + 50, h / 2 + down + (amount / 0.025), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0))
		end
	end
end

local dis = 200

hook.Add("HUDPaint", "re_info_hp", function()
	--фиксговна
	local te = LocalPlayer():GetEyeTrace().Entity
	if not IsValid(te) then return end
	if LocalPlayer():InVehicle() then return end
	if LocalPlayer():GetPos():DistToSqr(te:GetPos()) > (dis * dis) then return end

	-- local itemTypeInfo = re.inv.GetItemTypeInfo(te:GetClass())
	-- if IsValid(te) and itemTypeInfo and ply:GetPos():DistToSqr(te:GetPos()) <= re.inv.CONFIG.PickupDistance then
	-- 	build({"Alt", "E"}, "Положить в инвентарь", 0)

	-- 	if itemTypeInfo.CanUse() then
	-- 		build({"E"}, "Использовать", 1)
	-- 	end
	-- end

	if tbl[te:GetClass()] then
		for k, v in pairs(tbl[te:GetClass()]) do
			build({v.key}, v.info, k)

			-- if input.WasKeyPressed(KEY_T) then
			-- 	print("a")
			-- end
		end
	end
end)

-- hook.Add("PreDrawHalos", "re_info_halo", function()
-- 	local tr = LocalPlayer():GetEyeTrace()

-- 	if tr.Entity and tr.HitNonWorld and IsValid(tr.Entity) and tbl.halos[tr.Entity:GetClass()] and tbl.halos[tr.Entity:GetClass()].re_halo and LocalPlayer():GetPos():DistToSqr(tr.Entity:GetPos()) <= (dis * dis) then
-- 		halo.Add({tr.Entity}, Color(255, 255, 255))
-- 	end
-- end)