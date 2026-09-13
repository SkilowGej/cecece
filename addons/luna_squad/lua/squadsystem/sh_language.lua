--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--[[
   _____                       _  _____           _                 
  / ____|                     | |/ ____|         | |                
 | (___   __ _ _   _  __ _  __| | (___  _   _ ___| |_ ___ _ __ ___  
  \___ \ / _` | | | |/ _` |/ _` |\___ \| | | / __| __/ _ \ '_ ` _ \ 
  ____) | (_| | |_| | (_| | (_| |____) | |_| \__ \ ||  __/ | | | | |
 |_____/ \__, |\__,_|\__,_|\__,_|_____/ \__, |___/\__\___|_| |_| |_|
            | |                          __/ |                      
            |_|                         |___/                       

	Created by Summe: https://steamcommunity.com/id/DerSumme/ 
    Purchased content: https://discord.gg/k6YdMwj9w2
]]--

SquadSystem.Languages = {}

/* -------------------------------------------------------------------------- */
/*                 Function to get the correct language string                */
/* -------------------------------------------------------------------------- */

function SquadSystem:L(key)
    return SquadSystem.Languages[SquadSystem.Config.Language][key] or "ERROR"
end

/* -------------------------------------------------------------------------- */
/*                                Language data                               */
/* -------------------------------------------------------------------------- */

SquadSystem.Languages["en"] = {
    CREATOR_Title = "CREATE NEW SQUAD",
    CREATOR_Placeholder = "Squad name",
    CREATOR_Hint = "You can then invite members via the squad action wheel by looking at them and opening the wheel, or using the command !invitesquad <NAME>!",
    CREATOR_Success = "Your squad has been successfully created.",
    CREATOR_PublicSquad = "Public Squad",
    INVITE_Title = "NEW SQUAD INVITATION",
    INVITE_SubTitle = "JOIN",
    INVITE_Err_AlreadyOpenInvitation = " already has an open invite and not decided yet!",
    INVITE_SuccessfullyJoined = "You have joined the squad ",
    INVITE_Successfull = " has been successfully invited.",
    ADMINISTRATION_KickPlayer = "Kick out of squad",
    ADMINISTRATION_ChangePos = "Change position",
    ACTIONWHEEL_Leave = "Leave squad",
    ACTIONWHEEL_Comms = "Communications",
    ACTIONWHEEL_Cmds = "Commands",
    ACTIONWHEEL_ToggleNametags = "Toggle nametags",
    ACTIONWHEEL_Invite = "Invite targeted player",
    PING_Normal = "PING",
    PING_Enemy = "ENEMY",
    BROADCASTS_PlayerJoined = " has joined the squad.",
    BROADCASTS_PlayerLeft = " has left the squad.",
    BROADCASTS_PositionChange = " is now a ",
    BROADCASTS_SquadRemoved = "Your squad has been removed.",
    BROADCASTS_XPReward = "You got XP for being a member of a squad.",
    ERROR_PlayerNotFound = "Player not found!",
    ERROR_AlreadyInSquad = "You are already part of this Squad.",
    ERROR_AlreadyInASquad = "You are already part of an active Squad. In order to join a new Squad, please leave the current one.",
    PUBLIC_Title = "PUBLIC SQUADS",

}

SquadSystem.Languages["de"] = {
    CREATOR_Title = "SQUAD ERSTELLEN",
    CREATOR_Placeholder = "Squad Name",
    CREATOR_Hint = "Du kannst Mitglieder über das Squadaktionsrad hinzufügen indem du auf die Personen guckst oder den Command !invitesquad <NAME> verwendest!",
    CREATOR_Success = "Dein Squad wurde erfolgreich erstellt.",
    CREATOR_PublicSquad = "Öffentlicher Squad",
    INVITE_Title = "NEUE SQUAD EINLADUNG",
    INVITE_SubTitle = "BEITRETEN",
    INVITE_Err_AlreadyOpenInvitation = " hat bereits eine offene Einladung und sich noch nicht entschieden!",
    INVITE_SuccessfullyJoined = "Du bist dem Squad beigetreten: ",
    INVITE_Successfull = " wurde erfolgreich eingeladen.",
    ADMINISTRATION_KickPlayer = "Aus dem Squad werfen",
    ADMINISTRATION_ChangePos = "Position ändern",
    ACTIONWHEEL_Leave = "Squad verlassen",
    ACTIONWHEEL_Comms = "Kommunikation",
    ACTIONWHEEL_Cmds = "Befehle",
    ACTIONWHEEL_ToggleNametags = "Nametags umschalten",
    ACTIONWHEEL_Invite = "Einladen des makierten Ziels",
    PING_Normal = "PING",
    PING_Enemy = "GEGNER",
    BROADCASTS_PlayerJoined = " ist dem Squad beigetreten.",
    BROADCASTS_PlayerLeft = " hat den Squad verlassen.",
    BROADCASTS_PositionChange = " ist jetzt ein ",
    BROADCASTS_SquadRemoved = "Dein Squad wurde gelöscht.",
    BROADCASTS_XPReward = "Du hast XP dafür bekommen, dass du Mitglied eines Squads bist.",
    ERROR_PlayerNotFound = "Spieler nicht gefunden!",
    ERROR_AlreadyInSquad = "Du bist bereits Teil dieses Squads.",
    ERROR_AlreadyInASquad = "Du bist bereits Teil eines aktiven Squads. Um einem neuen Squad beizutreten, verlasse bitte den aktuellen Squad.",
    PUBLIC_Title = "ÖFFENTLICHE SQUADS",
}

SquadSystem.Languages["ru"] = {
    CREATOR_Title = "СОЗДАТЬ НОВЫЙ ОТРЯД",
    CREATOR_Placeholder = "Название отряда",
    CREATOR_Hint = "Вы можете пригласить участников через колесо взаимодействия отряда, смотря на них и открывая колесо или используя комманду !invitesquad <НАЗВАНИЕ>!",
    CREATOR_Success = "Ваш отряд был успешно создан.",
    CREATOR_PublicSquad = "Публичный отряд",
    INVITE_Title = "НОВОЕ ПРИГЛАШЕНИЕ В ОТРЯД",
    INVITE_SubTitle = "ВСТУПИТЬ",
    INVITE_Err_AlreadyOpenInvitation = " меню вступления игрока открыто, он принимает решение!",
    INVITE_SuccessfullyJoined = "Вы вступили в отряд ",
    INVITE_Successfull = " был успешно приглашен.",
    ADMINISTRATION_KickPlayer = "Исключить из отряда",
    ADMINISTRATION_ChangePos = "Поменять позицию",
    ACTIONWHEEL_Leave = "Покинуть отряд",
    ACTIONWHEEL_Comms = "Связь",
    ACTIONWHEEL_Cmds = "Команды",
    ACTIONWHEEL_ToggleNametags = "Отображение ников",
    ACTIONWHEEL_Invite = "Пригласить выбранного игрока",
    PING_Normal = "ПИНГ",
    PING_Enemy = "ВРАГ",
    BROADCASTS_PlayerJoined = " вступил в отряд.",
    BROADCASTS_PlayerLeft = " покинул отряд.",
    BROADCASTS_PositionChange = " теперь",
    BROADCASTS_SquadRemoved = "Ваш отряд был удален.",
    BROADCASTS_XPReward = "You got XP for being a member of a squad.",
    ERROR_PlayerNotFound = "Игрок не найден!",
    ERROR_AlreadyInSquad = "Вы уже состоите в этом отряде",
    ERROR_AlreadyInASquad = "Вы уже состоите в активном отряде. Чтобы вступить в новый отряд, пожалуйста, покиньте текущий.",
    PUBLIC_Title = "Список отрядов",
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
