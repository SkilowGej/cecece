if not SERVER then return end

Roster = Roster or {}
Roster.Permissions = Roster.Permissions or {}

local Permissions = Roster.Permissions


-- =========================================================
-- DEBUG
-- =========================================================

local function Debug(...)
    if Roster.Config and Roster.Config.Debug then
        print("[ROSTER][PERMISSIONS]", ...)
    end
end


-- =========================================================
-- POBIERANIE POSTACI
-- =========================================================

function Permissions.GetCharacter(ply)
    if not IsValid(ply) then
        return nil
    end

    -- Helix przechowuje aktualną postać jako Character.
    if not ply.GetCharacter then
        return nil
    end

    local character = ply:GetCharacter()

    if not character then
        return nil
    end

    return character
end


-- =========================================================
-- CHAR ID
-- =========================================================

function Permissions.GetCharacterID(ply)
    local character = Permissions.GetCharacter(ply)

    if not character then
        return nil
    end

    if not character.GetID then
        return nil
    end

    return character:GetID()
end


-- =========================================================
-- PLAYER ID
-- =========================================================

function Permissions.GetPlayerID(ply)
    if not IsValid(ply) then
        return nil
    end

    /*
        Na razie używamy SteamID jako identyfikatora gracza.

        Później dopasujemy to dokładnie do player_id
        używanego przez Twoją bazę re_characters.
    */

    return ply:SteamID()
end


-- =========================================================
-- RATING
-- =========================================================

function Permissions.GetRating(ply)
    local character = Permissions.GetCharacter(ply)

    if not character then
        return nil
    end

    /*
        Docelowo pobierzemy rating bezpośrednio z
        re_characters.

        Na razie sprawdzamy również standardowy
        atrybut Helixa, jeśli istnieje.
    */

    if character.GetData then
        local rating = character:GetData("rating", nil)

        if rating then
            return rating
        end
    end

    return nil
end


-- =========================================================
-- TEAM ID
-- =========================================================

function Permissions.GetTeamID(ply)
    local character = Permissions.GetCharacter(ply)

    if not character then
        return nil
    end

    if character.GetFaction then
        -- Na tym etapie NIE zakładamy jeszcze,
        -- że faction == team_id.
    end

    /*
        Job/team zostanie podłączony do właściwego
        systemu używanego przez Twój gamemode.

        Nie zgadujemy tutaj wartości.
    */

    return nil
end


-- =========================================================
-- HIERARCHIA RANG
-- =========================================================

/*
    Tutaj później umieścimy rzeczywistą hierarchię
    ratingów Twojego serwera.

    Na razie funkcja nie zakłada kolejności rang.
*/

function Permissions.GetRatingLevel(rating)
    if not rating then
        return 0
    end

    return 0
end


-- =========================================================
-- SPRAWDZENIE RANGI
-- =========================================================

function Permissions.HasMinimumRating(ply, requiredRating)
    if not IsValid(ply) then
        return false
    end

    if not requiredRating then
        return false
    end

    local rating = Permissions.GetRating(ply)

    if not rating then
        return false
    end

    local playerLevel = Permissions.GetRatingLevel(rating)
    local requiredLevel = Permissions.GetRatingLevel(requiredRating)

    return playerLevel >= requiredLevel
end


-- =========================================================
-- PODGLĄD ROSTERA
-- =========================================================

function Permissions.CanViewRoster(ply)
    if not IsValid(ply) then
        return false
    end

    local requiredRating = Roster.Config.ViewMinimumRating

    return Permissions.HasMinimumRating(ply, requiredRating)
end


-- =========================================================
-- PANEL OFICERA
-- =========================================================

function Permissions.CanUseOfficerPanel(ply)
    if not IsValid(ply) then
        return false
    end

    local requiredRating = Roster.Config.OfficerMinimumRating

    return Permissions.HasMinimumRating(ply, requiredRating)
end


-- =========================================================
-- DEBUGOWANIE UPRAWNIEŃ
-- =========================================================

concommand.Add("roster_debug_permissions", function(ply)
    if not IsValid(ply) then
        return
    end

    local character = Permissions.GetCharacter(ply)
    local charID = Permissions.GetCharacterID(ply)
    local playerID = Permissions.GetPlayerID(ply)
    local rating = Permissions.GetRating(ply)
    local teamID = Permissions.GetTeamID(ply)

    print("")
    print("==========================================")
    print("[ROSTER] PERMISSIONS DEBUG")
    print("==========================================")

    print("Player:")
    print("  Name:", ply:Nick())
    print("  SteamID:", playerID or "nil")

    print("Character:")
    print("  Character:", character and "OK" or "nil")
    print("  Character ID:", charID or "nil")

    print("Roster data:")
    print("  Rating:", rating or "nil")
    print("  Team ID:", teamID or "nil")

    print("Permissions:")
    print("  Can View:", Permissions.CanViewRoster(ply))
    print("  Officer:", Permissions.CanUseOfficerPanel(ply))

    print("==========================================")
    print("")
end)