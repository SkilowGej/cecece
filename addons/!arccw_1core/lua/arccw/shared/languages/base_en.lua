--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

L = {}
STL = {}

-- not a translate string, but in case a language needs its own font
L["default_font"] = "Mont Bold"

-- Attachment Slots
L["attslot.optic"] = "Optyka"
L["attslot.bkoptic"] = "Rezerwowa Optyka"
L["attslot.muzzle"] = "Dło"
L["attslot.barrel"] = "Lufa"
L["attslot.choke"] = "Kompensator"
L["attslot.underbarrel"] = "Podlufowy"
L["attslot.tactical"] = "Taktyczny"
L["attslot.grip"] = "Uchwyt"
L["attslot.stock"] = "Kolba"
L["attslot.fcg"] = "Grupa ognia"
L["attslot.ammo"] = "Typ amunicji"
L["attslot.perk"] = "Perk"
L["attslot.charm"] = "Charms"
L["attslot.skin"] = "Skórka"
L["attslot.noatt"] = "Brak dodatku"
L["attslot.optic.default"] = "Muszka i szczerbinka"
L["attslot.muzzle.default"] = "Standardowa lufa"
L["attslot.barrel.default"] = "Standardowa lufa"
L["attslot.choke.default"] = "Standardowy kompensator"
L["attslot.grip.default"] = "Standardowy uchwyt"
L["attslot.stock.default"] = "Standardowa kolba"
L["attslot.stock.none"] = "Bez kolby"
L["attslot.fcg.default"] = "Standardowa grupa ognia"

-- Trivia
L['trivia.class'] = 'Klasa'
L['trivia.year'] = 'Rok'
L['trivia.mechanism'] = 'Mechanizm'
L['trivia.calibre'] = 'Kaliber'
L['trivia.ammo'] = 'Typ amunicji'
L['trivia.country'] = 'Kraj'
L['trivia.manufacturer'] = 'Producent'
L['trivia.clipsize'] = 'Pojemność magazynka'
L['trivia.precision'] = 'Dokładność'
L['trivia.noise'] = 'Hałas'
L['trivia.recoil'] = 'Pionowy odrzut'
L['trivia.penetration'] = 'Penetracja'
L['trivia.firerate'] = 'Szybkostrzelność'
L['trivia.firerate_burst'] = 'Szybkostrzelność'
L['trivia.fusetime'] = 'Czas zapłonu'

-- Class
L['class.pistol'] = 'Pistolet'
L['class.revolver'] = 'Rewolwer'
L['class.machinepistol'] = 'Pistolet-maszynowy'
L['class.smg'] = 'Pistolet-maszynowy'
L['class.pdw'] = 'Broń indywidualnej ochrony'
L['class.shotgun'] = 'Strzelba'
L['class.assaultcarbine'] = 'Karabin szturmowy'
L['class.carbine'] = 'Karabin'
L['class.assaultrifle'] = 'Karabin szturmowy'
L['class.rifle'] = 'Karabin'
L['class.battlerifle'] = 'Karabin bojowy'
L['class.dmr'] = 'DMR'
L['class.sniperrifle'] = 'Karabin snajperski'
L['class.antimaterielrifle'] = 'Karabin pancerny'
L['class.rocketlauncher'] = 'Wyrzutnia rakiet'
L['class.grenade'] = 'Granat ręczny'
L['class.melee'] = 'Broń biała'

-- UI
L['ui.savepreset'] = 'Zapisz preset'
L['ui.loadpreset'] = 'Wczytaj preset'
L['ui.stats'] = 'Statystyka'
L['ui.trivia'] = 'Drobiazgi'
L['ui.tttequip'] = 'Wyposażenie'
L['ui.tttchat'] = 'Szybki czat'
L['ui.position'] = 'POZYCJA'
L['ui.positives'] = 'ZALETY:'
L['ui.negatives'] = 'WADY:'
L['ui.information'] = 'INFORMACJE:'

-- Stats
L['stat.stat'] = 'Stat' -- Используется в первой строке страницы статистики
L['stat.original'] = 'Original'
L['stat.current'] = 'Aktualny'
L['stat.damage'] = 'Obrażenia z bliskiej odległości'
L['stat.damage.tooltip'] = 'Ile obrażeń zadaje ta broń z bliskiej odległości.'
L['stat.damagemin'] = 'Obrażenia z dalekiej odległości'
L['stat.damagemin.tooltip'] = 'Ile obrażeń zadaje ta broń poza swoim zasięgiem.'
L['stat.range'] = 'Zasięg'
L['stat.range.tooltip'] = 'Odległość, na której obrażenia z bliskiej odległości zmieniają się na obrażenia z dalekiej odległości, w metrach.'
L['stat.firerate'] = 'Szybkostrzelność'
L['stat.firerate.tooltip'] = 'Szybkość, z jaką broń strzela, w strzałach na minutę.'
L['stat.firerate.manual'] = 'RĘCZNY' -- Pokazywane zamiast RPM, jeśli broń jest ręczna.
L['stat.capacity'] = 'Pojemność'
L['stat.capacity.tooltip'] = 'Ile nabojów mieści ta broń.'
L['stat.precision'] = 'Precyzja'
L['stat.precision.tooltip'] = 'Precyzja broni w stanie nieruchomym i podczas celowania, w minutach łuku.'
L['stat.hipdisp'] = 'Rozrzut od biodra'
L['stat.hipdisp.tooltip'] = 'Ile niedokładności dodaje się, gdy broń strzela od biodra.'
L['stat.movedisp'] = 'Precyzja podczas ruchu'
L['stat.movedisp.tooltip'] = 'Ile niedokładności dodaje się podczas używania broni w ruchu.'
L['stat.recoil'] = 'Odrzut'
L['stat.recoil.tooltip'] = 'Wielkość odrzutu przy każdym strzale.'
L['stat.recoilside'] = 'Boczny odrzut'
L['stat.recoilside.tooltip'] = 'Wielkość poziomego odrzutu przy każdym strzale.'
L['stat.sighttime'] = 'Czas celowania'
L['stat.sighttime.tooltip'] = 'Ile czasu zajmuje przejście od lub do sprintu i celowania z tą bronią.'
L['stat.speedmult'] = 'Prędkość poruszania się'
L['stat.speedmult.tooltip'] = 'Prędkość, z jaką poruszasz się z bronią, w procentach oryginalnej prędkości.'
L['stat.sightspeed'] = 'Prędkość celowania'
L['stat.sightspeed.tooltip'] = 'Dodatkowe spowolnienie stosowane, gdy poruszasz się z opuszczonym celownikiem.'
L['stat.meleedamage'] = 'Obrażenia od ciosów'
L['stat.meleedamage.tooltip'] = 'Ilość obrażeń zadawanych ciosem w walce wręcz.'
L['stat.meleetime'] = 'Czas ciosu'
L['stat.meleetime.tooltip'] = 'Czas potrzebny na wykonanie ciosu w walce wręcz.'
L['stat.shootvol'] = 'Głośność strzału'
L['stat.shootvol.tooltip'] = 'Jak głośno strzela broń, w decybelach. Głośniejsza broń jest słyszalna z większej odległości.'
L['stat.barrellen'] = 'Długość broni'
L['stat.barrellen.tooltip'] = 'Długość broni, w jednostkach Hammer / calach. Długie lufy łatwiej blokują ściany.'
L['stat.pen'] = 'Przenikanie'
L['stat.pen.tooltip'] = 'Ile materiału może przebić ta broń.'

-- Autostats
L['autostat.bipodrecoil'] = 'Odrzut podczas strzelania z dwójnogu'
L['autostat.bipoddisp'] = 'Rozrzut na dwójnogu.'
L['autostat.damage'] = 'Obrażenia z bliskiej odległości'
L['autostat.damagemin'] = 'Obrażenia z dalekiej odległości'
L['autostat.damageboth'] = 'Obrażenia' -- Когда урон и damagemin имеют одинаковое значение
L['autostat.range'] = 'Zasięg'
L['autostat.penetration'] = 'Przenikanie'
L['autostat.muzzlevel'] = 'Prędkość wylotowa'
L['autostat.meleetime'] = 'Czas ciosu'
L['autostat.meleedamage'] = 'Obrażenia od ciosów'
L['autostat.meleerange'] = 'Zasięg ciosu'
L['autostat.recoil'] = 'Odrzut'
L['autostat.recoilside'] = 'Boczny odrzut'
L['autostat.firerate'] = 'Szybkostrzelność'
L['autostat.precision'] = 'Precyzja'
L['autostat.hipdisp'] = 'Rozrzut od biodra'
L['autostat.sightdisp'] = 'Rozrzut podczas celowania'
L['autostat.movedisp'] = 'Rozrzut podczas ruchu'
L['autostat.jumpdisp'] = 'Rozrzut w powietrzu'
L['autostat.barrellength'] = 'Długość broni'
L['autostat.shootvol'] = 'Głośność strzału'
L['autostat.speedmult'] = 'Prędkość poruszania się'
L['autostat.sightspeed'] = 'Prędkość celowania'
L['autostat.shootspeed'] = 'Prędkość strzelania'
L['autostat.reloadtime'] = 'Czas przeładowania'
L['autostat.drawtime'] = 'Czas wyciągania broni'
L['autostat.sighttime'] = 'Czas celowania'
L['autostat.cycletime'] = 'Czas cyklu'
L['autostat.magextender'] = 'Zwiększony rozmiar magazynka'
L['autostat.magreducer'] = 'Zmniejszony rozmiar magazynka'
L['autostat.bipod'] = 'Możliwość użycia dwójnogu'
L['autostat.holosight'] = 'Dokładny obraz celownika'
L['autostat.zoom'] = 'Powiększenie'
L['autostat.glint'] = 'Widoczny odblask celownika'
L['autostat.thermal'] = 'Wizja termiczna'
L['autostat.silencer'] = 'Tłumik dźwięku strzału'
L['autostat.norandspr'] = 'Brak losowego rozrzutu'
L['autostat.sway'] = 'Kołysanie celownika'
L['autostat.heatcap'] = 'Pojemność cieplna'
L['autostat.heatfix'] = 'Czas naprawy przegrzania'
L['autostat.heatdelay'] = 'Opóźnienie regeneracji ciepła'
L['autostat.heatdrain'] = 'Szybkość odzyskiwania ciepła'

-- TTT
L["ttt.roundinfo"] = "ArcCW Configuration"
L["ttt.roundinfo.replace"] = "Auto-replace TTT weapons"
L["ttt.roundinfo.cmode"] = "Customize Mode:"
L["ttt.roundinfo.cmode0"] = "No Restrictions"
L["ttt.roundinfo.cmode1"] = "Restricted"
L["ttt.roundinfo.cmode2"] = "Pre-game only"
L["ttt.roundinfo.cmode3"] = "T/D only"

L["ttt.roundinfo.attmode"] = "Attachment Mode:"
L["ttt.roundinfo.free"] = "Free"
L["ttt.roundinfo.locking"] = "Locking"
L["ttt.roundinfo.inv"] = "Inventory"
L["ttt.roundinfo.persist"] = "Persistent"
L["ttt.roundinfo.drop"] = "Drop on death"
L["ttt.roundinfo.inv"] = "Inventory"
L["ttt.roundinfo.pickx"] = "Pick"

L["ttt.roundinfo.bmode"] = "Attachment Info on Body:"
L["ttt.roundinfo.bmode0"] = "Unavailable"
L["ttt.roundinfo.bmode1"] = "Detectives Only"
L["ttt.roundinfo.bmode2"] = "Available"

L["ttt.roundinfo.amode"] = "Ammo Explosion:"
L["ttt.roundinfo.amode-1"] = "Disabled"
L["ttt.roundinfo.amode0"] = "Simple"
L["ttt.roundinfo.amode1"] = "Frag"
L["ttt.roundinfo.amode2"] = "Full"
L["ttt.roundinfo.achain"] = "Chain explosions"

L["ttt.bodyatt.found"] = "You think the murder weapon"
L["ttt.bodyatt.founddet"] = "With your detective skills, you deduce the murder weapon"
L["ttt.bodyatt.att1"] = " had {att} installed."
L["ttt.bodyatt.att2"] = " had {att1} and {att2} installed."
L["ttt.bodyatt.att3"] = " had these attachments: "

L["ttt.attachments"] = " Attachment(s): " -- Used in TTT2 TargetID
L["ttt.ammo"] = "Ammo: " -- Used in TTT2 TargetID

-- Shit that used to be in CS+ why
L['info.togglesight'] = 'Naciśnij dwukrotnie +USE, aby przełączyć celownik.'
L['info.toggleubgl'] = 'Podwójne naciśnięcie +ZOOM, aby przełączyć broń podlufową' -- устарело
L['pro.ubgl'] = 'Wybierana podlufowa wyrzutnia' -- исключено
L['pro.ubsg'] = 'Wybierany podlufowy strzelba' -- исправлено
L['con.obstruction'] = 'Może przeszkadzać celownikom'
L['autostat.underwater'] = 'Strzelanie pod wodą'
L['autostat.sprintshoot'] = 'Strzelanie podczas sprintu'
L['con.beam'] = 'Widoczna wiązka lasera'
L['con.light'] = 'Widoczna wiązka latarki'
L['con.noscope'] = 'Brak punktu celowania.'
L['pro.invistracers'] = 'Niewidoczne ślady pocisków'

-- Incompatibility Menu
L['incompatible.title'] = 'ArcCW: NIEKOMPATYBILNE DODATKI'
L['incompatible.line1'] = 'Masz niektóre dodatki, które są znane z tego, że nie działają z ArcCW.'
L['incompatible.line2'] = 'Wyłącz je lub oczekuj błędnego zachowania!'
L['incompatible.confirm'] = 'Potwierdzam.'
L['incompatible.wait'] = 'Proszę czekać {czas}s.'
L['incompatible.never'] = 'Nigdy więcej nie ostrzegać'
L['incompatible.never.hover'] = 'Czy na pewno rozumiesz konsekwencje?'
L['incompatible.never.confirm'] = 'Zdecydowałeś się nigdy więcej nie pokazywać ostrzeżeń o niekompatybilności. Jeśli napotkasz błędy lub nieprawidłowe działanie, odpowiedzialność za to spoczywa na Tobie.'

-- 2020-12-11
L['hud.hp'] = 'HP: ' -- Используется в HUD по умолчанию
L['fcg.safe'] = 'Bezpieczeństwo'
L['fcg.semi'] = 'Półautomat'
L['fcg.auto'] = 'Automatyczny'
L['fcg.burst'] = '%d-round burst'
L['fcg.ubgl'] = 'UBGL'

-- 2021-01-14
L['ui.toggle'] = 'TOGGLE'
L['ui.whenmode'] = 'Kiedy %s'
L['ui.modex'] = 'Tryb %s'

-- 2021-01-25
L["attslot.magazine"] = "Sklep"

-- 2021-03-13
L['trivia.damage'] = 'Obrażenia'
L['trivia.range'] = 'Zasięg'
L['trivia.attackspersecond'] = 'Ataki na sekundę'
L['trivia.description'] = 'Opis'
L['trivia.meleedamagetype'] = 'Typ obrażeń'
-- Units
L["unit.rpm"] = "RPM"
L["unit.moa"] = "MOA"
L["unit.mm"] = "mm"
L["unit.db"] = "dB"
L["unit.bce"] = "BC"
L["unit.aps"] = "APS"

-- melee damage types
L['dmg.generic'] = 'Bez broni'
L['dmg.bullet'] = 'Penetrujący'
L['dmg.slash'] = 'Cięcie'
L['dmg.club'] = 'Obuch'
L['dmg.shock'] = 'Wstrząs'

L['ui.presets'] = 'Ustawienia wstępne'
L['ui.customize'] = 'Dostosuj'
L['ui.inventory'] = 'Ekwipunek'

-- 2021-05-05
L['ui.gamemode_buttons'] = 'Komendy specyficzne dla trybu gry'
L['ui.gamemode_usehint'] = 'Możesz przytrzymać USE, aby uzyskać dostęp do oryginalnych powiązań klawiszy.'
L['ui.darkrpdrop'] = 'Upuść broń.'
L['ui.noatts'] = 'Nie masz żadnych dodatków.'
L['ui.noatts_slot'] = 'Nie masz dodatków do tego slotu'
L['ui.lockinv'] = 'Te dodatki są odblokowane dla całej broni.'
L['autostat.ammotype'] = 'Zmienia typ amunicji broni na %s'

-- 2021-05-08
L['autostat.rangemin'] = 'Minimalny zasięg'
-- 2021-05-13
L['autostat.malfunctionmean'] = 'Niezawodność'
L['ui.heat'] = 'HEAT'
L['ui.jammed'] = 'JAMMED'

-- 2021-05-15
L['trivia.muzzlevel'] = 'Prędkość wylotowa'
L['unit.mps'] = 'm/s'
L['unit.lbfps'] = 'ft/lbs'
L['trivia.recoilside'] = 'Odrzut poziomy'

--2021-05-27
L['ui.pickx'] = 'Załączniki: %d/%d'
L['ui.ballistics'] = 'Balistyka'

L['ammo.pistol'] = 'Amunicja do pistoletu'
L['ammo.357'] = 'Amunicja do magnuma'
L['ammo.smg1'] = 'Amunicja do karabinu'
L['ammo.ar2'] = 'Amunicja do karabinu szturmowego'
L['ammo.buckshot'] = 'Amunicja do strzelby'
L['ammo.sniperpenetratedround'] = 'Amunicja do karabinu snajperskiego'
L['ammo.smg1_grenade'] = 'Granaty do karabinu'

--2021-05-31
L['ui.nodata'] = 'Brak danych'
L['ui.createpreset'] = 'Utwórz'
L['ui.deletepreset'] = 'Usuń'

--2021-06-09 dobry
L['autostat.clipsize'] = 'Pojemność magazynka na %d naboi'

--2021-06-30
L['autostat.bipod2'] = 'Pozwala używać dwójnogu (-%d%% rozrzutu, -%d%% odrzutu)'
L['autostat.nobipod'] = 'Wyłącza dwójnóg'

--2021-07-01
L['fcg.safe2'] = 'Obniżony'
L['fcg.dact'] = 'Podwójne działanie'
L['fcg.sact'] = 'Pojedyncze działanie'
L['fcg.bolt'] = 'Działanie zamka'
L['fcg.pump'] = 'Działanie pompowe'
L['fcg.lever'] = 'Działanie dźwigniowe'
L['fcg.manual'] = 'Działanie ręczne'
L['fcg.break'] = 'Działanie rozdzielne'
L['fcg.sngl'] = 'Pojedynczy'
L['fcg.both'] = 'Oba'

--2021-08-11
L['autostat.clipsize.mod'] = 'Pojemność magazynka' -- используется для Add_ClipSize и Mult_ClipSize
--2021-08-22
L['trivia.recoilscore'] = 'Wskaźnik wydajności (im mniejszy, tym lepszy)'
L['fcg.safe.abbrev'] = 'SAFE'
L['fcg.semi.abbrev'] = 'SEMI'
L['fcg.auto.abbrev'] = 'AUTO'
L['fcg.burst.abbrev'] = '%d-BST'
L['fcg.ubgl.abbrev'] = 'UBGL'
L['fcg.safe2.abbrev'] = 'LOW'
L['fcg.dact.abbrev'] = 'DACT'
L['fcg.sact.abbrev'] = 'SACT'
L['fcg.bolt.abbrev'] = 'BOLT'
L['fcg.pump.abbrev'] = 'PUMP'
L['fcg.lever.abbrev'] = 'LEVER'
L['fcg.manual.abbrev'] = 'MANUAL'
L['fcg.break.abbrev'] = 'BREAK'
L['fcg.sngl.abbrev'] = 'SNGL'
L['fcg.both.abbrev'] = 'BOTH'

-- 2021-10-10
STL["lowered"] = "fcg.safe2"
STL["double-action"] = "fcg.dact"
STL["single-action"] = "fcg.sact"
STL["bolt-action"] = "fcg.bolt"
STL["pump-action"] = "fcg.pump"
STL["lever-action"] = "fcg.lever"
STL["manual-action"] = "fcg.manual"
STL["break-action"] = "fcg.break"
--STL["single"] = "fcg.sngl"
--STL["both"] = "fcg.both"

-- 2021-11-27
L['ui.hitgroup'] = 'Grupa uderzeń'
L['ui.shotstokill'] = 'Wystrzały na zabicie'
L['ui.hitgroup.head'] = 'Głowa'
L['ui.hitgroup.torso'] = 'Tułów' -- klatka piersiowa+brzuch, jeśli są takie same
L['ui.hitgroup.chest'] = 'Klatka piersiowa'
L['ui.hitgroup.stomach'] = 'Brzuch'
L['ui.hitgroup.arms'] = 'Ręce'
L['ui.hitgroup.legs'] = 'Nogi'
L['ui.nonum'] = 'Aby zabijać ludzi, potrzebne są kule, głuptasie.' -- num równe 0

-- 2022-05-23
L['fcg.nade'] = 'Granat'
L['fcg.nade.abbrev'] = 'NADE'

-- 2022-08-03
L['attslot.magazine'] = 'Magazynek'
L['attslot.magazine.default'] = 'Standardowy magazynek'

-- 2022-08-17
L['autostat.ubgl'] = 'Wybieralna broń podlufowa'
L['autostat.ubgl2'] = 'Aby aktywować broń podlufową, naciśnij klawisz USE i RELOAD razem'
L['autostat.ammotypeubgl'] = 'Broń podlufowa używa %s'

-- 2023-09-09
L['autostat.triggerdelay'] = 'Opóźnienie spustu'

--[[]
You can translate the trivia of any arbitrary weapon or attachment by adding the phrase ["desc.class_name"]
Similarly, you can translate attachment and weapon names with ["name.class_name"]
When translating weapon names, append .true for truename, like ["name.arccw_p228.true"]
Example:
 L["desc.fcg_auto"] = "blah blah blah automatic firemode"
 L["name.fcg_auto"] = "Auto But Cooler"
You can also translate custom firemodes with "fcg.FIREMODE_NAME"
]]

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
