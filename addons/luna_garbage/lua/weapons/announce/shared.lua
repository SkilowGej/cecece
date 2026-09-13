--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

SWEP.ViewModel = "models/ace/sw/w_macrobinoculars.mdl"
SWEP.WorldModel = "models/ace/sw/w_macrobinoculars.mdl"
SWEP.HoldType = "normal"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Category 				= "SUP • Różne"

--SWEP.Grenade_Coldown = 30
SWEP.Announce_icon = Material("luna_ui_base/etc/speaker.png", "noclamp smooth")

function SWEP:SetupDataTables()
  self:NetworkVar("Bool",0,"AllTalk")
  self:NetworkVar("Int",0,"Distance")

  if SERVER then
    self:SetAllTalk(false)
    self:SetDistance(302500)
  end
end

-- list.Add( "NPCUsableWeapons", { class = "announce",	title = "Amplifier" } )

-- if CLIENT then
-- 	function SWEP:DrawHUD()
-- 		local ply = LocalPlayer()

-- 		local x, y = ScrW()-350, ScrH()-50

-- 		draw.ShadowSimpleText("R - Смена Голоса (На всю карту / Локальный)", "lunaMontMini", x, y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
-- 		draw.ShadowSimpleText("ЛКМ / ПКМ - Отдаление Радиуса Голоса", "lunaMontMini", x, y+20, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
-- 	end
-- end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
