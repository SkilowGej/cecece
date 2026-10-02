Roster = Roster or {}
Roster.Config = Roster.Config or {}

-- =========================================================
-- ROSTER - KONFIGURACJA
-- =========================================================

-- Minimalna ranga wymagana do zwykłego podglądu rostera.
--
-- Na tym etapie jest ustawione PVT zgodnie z założeniem:
-- PVT+ = podgląd
Roster.Config.ViewMinimumRating = "PVT"

-- Minimalna ranga wymagana do panelu oficera.
--
-- UWAGA:
-- Jeżeli VLT nie jest używane przez Twój serwer,
-- później ustawimy tutaj właściwą rangę.
Roster.Config.OfficerMinimumRating = "JLT"


-- =========================================================
-- USTAWIENIA AKTYWNOŚCI
-- =========================================================

-- Co ile sekund aktualizować ostatnią aktywność
-- żołnierza na właściwym jobie.
Roster.Config.ActivityUpdateInterval = 60


-- =========================================================
-- DEBUG
-- =========================================================

-- Na razie zostawiamy true.
-- Dzięki temu podczas pierwszych testów będziemy mogli
-- łatwo zobaczyć, jakie dane roster wykrywa.
Roster.Config.Debug = true


-- =========================================================
-- NAZWY TABEL MYSQL
-- =========================================================

Roster.Config.Database = {
    Platoons = "re_roster_platoons",
    Units = "re_roster_units",
    Members = "re_roster_members"
}


-- =========================================================
-- POMOCNICZE FUNKCJE
-- =========================================================

-- Sprawdza, czy Roster jest poprawnie załadowany.
function Roster.IsLoaded()
    return true
end