if SERVER then AddCSLuaFile() return end

do
    local msgPrefix = "Holonet"
    local msgIndex = 1
    local msgTable = {
        "Aby wezwać administratora, użyj: @ odpowiedni i, co najważniejsze, krótki powód wezwania.",
        "Szanujcie swoich współpracowników i braci broni! Są oni waszym wsparciem i niezawodnymi sojusznikami w walce.",
        "Nie zawiedź graczy i administracji! Nie bądź NON-RP-erem.",
        "Uważaj przy strzelaniu! Nie zabijaj swojego!",
        "Pamiętaj, że droidy CIS to nie są głupie figurki z bronią, ale groźne maszyny do zabijania. Bądź ostrożny...",
        "Nie łamiąc regulaminu i zasad serwera, unikniesz blokad i pobytu w karcerze!",
        "Dziękujemy, że grasz na Piwnica Granie • Wojna Klonów! Staramy się dla was!",
        "Wiesz, że Piwnica Granie • Wojna Klonów to najlepszy SWRP ( ͡° ͜ʖ ͡°)",
        "Będąc na serwerze w oddziale (Nieokreśleni Żołnierze Klony się nie liczą) musisz być na Discordzie!",
        "Gadasz bez sensu w Interkom? Zapraszamy do karceru!",
        "Nie naciskaj przycisków w dyspozytorni bez powodu - zostaniesz aresztowany!",
        "Używaj /advert i /comm z rozwagą! Gaduła to łakomy kąsek dla szpiega CIS",
        "Oznaką kulturalnego żołnierza jest brak przekleństw w jego mowie!",
        "W bloku medycznym alkohol jest dobrze ukryty, nawet nie próbuj go kraść",
        "Czy wiesz, że defektów-klonów nie ma? To wskazówka, żebyś nie robił głupot, młody klonie...",
        "Razem z wami umocnimy status najlepszego serwera SWRP!",
        "Jeśli znalazłeś błąd/eksploit - skontaktuj się z Kierownictwem projektu lub zostaw zgłoszenie na Discordzie: https://discord.gg/NavP36Sxcm",
        "Nasz Discord: https://discord.gg/NavP36Sxcm",
        "Jeśli chcesz wesprzeć projekt finansowo: https://discord.gg/NavP36Sxcm",
        "Na serwerze jest lokalny czat NonRP - /l",
        "Aby włączyć widok z trzeciej osoby, naciśnij F1!",
        "Dzięki waszemu wsparciu finansowemu możemy dalej rozwijać wasz ulubiony Piwnica Granie • Wojna Klonów!",
        "Nasza społeczność regularnie potrzebuje nowych administratorów. Być może to właśnie TY jesteś nam potrzebny! Nie krępuj się pisać, rozpatrujemy wszystkie zgłoszenia. Zostaw swoją aplikację na Discordzie!",
    }

    timer.Create("AutoChatMessages", 480, 0, function()
        local msgText = msgTable[msgIndex]

        chat.AddText(Color(17, 148, 240), msgPrefix, color_white, " ", msgText)

        if msgIndex >= #msgTable then
            msgIndex = 0
        end

        msgIndex = msgIndex + 1
    end)
end