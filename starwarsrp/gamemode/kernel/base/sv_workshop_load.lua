-- -- ????
-- resource.AddWorkshop("1251088550")
-- resource.AddWorkshop("1841418570")
-- resource.AddWorkshop("946190478")
-- venator content ^

-- resource.AddWorkshop("1598263759")
-- resource.AddWorkshop("1518614446")
-- resource.AddWorkshop("1841418570")
-- resource.AddWorkshop("2860897197")
-- resource.AddWorkshop("2144176587")
-- resource.AddWorkshop("946190478")
-- resource.AddWorkshop("1987994709")
-- resource.AddWorkshop("1206775008")
-- male event content (deathstar and fondor) ^

resource.AddWorkshop('2131057232')
--resource.AddWorkshop('2993307607')

-- resource.AddWorkshop("3241648659") -- SUP.content • Materials & Sounds 
-- resource.AddWorkshop("3242103100") -- SUP.content • Bad Guys & Smugglers
-- resource.AddWorkshop("3242142027") -- SUP.content • Galaxy Species
-- resource.AddWorkshop("3242141365") -- SUP.content • Republic Army
-- resource.AddWorkshop("3291830259") -- SUP.content • Jedi Order
-- resource.AddWorkshop("3242508350") -- SUP.content • Galactic Weapons
-- resource.AddWorkshop("3251503341") -- SUP.content • LVS Vehicles
-- resource.AddWorkshop("3300837422") -- SUP.content • Cosmetics
-- resource.AddWorkshop("3242363797") -- SUP.content • Props #01
-- resource.AddWorkshop("3242380768") -- SUP.content • Props #02
-- resource.AddWorkshop("3242403750") -- SUP.content • Props #03
-- resource.AddWorkshop("3242451926") -- SUP.content • Props #04
-- resource.AddWorkshop("3310742641") -- SUP.content • Props #05
-- resource.AddWorkshop("3242424067") -- SUP.content • Scripts Content #01
-- resource.AddWorkshop("3242497967") -- SUP.content • Scripts Content #02
-- resource.AddWorkshop("3242500478") -- SUP.content • Scripts Content #03
-- resource.AddWorkshop("2332782456") -- Star Wars Clone Wars Ships Prop Pack
-- -- для красоты
-- resource.AddWorkshop("1551310214") -- Placeable Particle Effects
-- -- доп контент
-- resource.AddWorkshop("1251088550") -- SW Modelpack : Venator
-- resource.AddWorkshop("1841418570") -- SW Modelpack : Miscellaneous
-- resource.AddWorkshop("946190478") -- Star Wars - Rogue One Prop Pack
-- resource.AddWorkshop("1257128301") -- SW Map : Venator

local map = string.lower(game.GetMap())
local mapid = re.maplist[map]
	
if mapid then
	resource.AddWorkshop(mapid)
	luna.library.Print(false, "Added workshop download for %s (%s)", re.maplist[map], mapid)
else
	luna.library.Print(false, "No map found to add in content, skipping")
end