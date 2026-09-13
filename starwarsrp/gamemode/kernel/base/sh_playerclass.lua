local PLAYER_CLASS = {}

PLAYER_CLASS.DisplayName = "SUP Player Class" -- Value of -1 = set to config value, if a corresponding setting exists
PLAYER_CLASS.AvoidPlayers = false
PLAYER_CLASS.TeammateNoCollide = false

PLAYER_CLASS.WalkSpeed = 100 -- How fast to move when not running
PLAYER_CLASS.RunSpeed = 225 -- How fast to move when running
PLAYER_CLASS.CrouchedWalkSpeed = 25 -- Multiply move speed by this when crouching
PLAYER_CLASS.DuckSpeed = 0.3 -- How fast to go from not ducking, to ducking
PLAYER_CLASS.UnDuckSpeed = 0.3 -- How fast to go from ducking, to not ducking
PLAYER_CLASS.JumpPower = 160 -- How powerful our jump should be
PLAYER_CLASS.CanUseFlashlight = true -- Can we use the flashlight
PLAYER_CLASS.MaxHealth = 100 -- Max health we can have
PLAYER_CLASS.StartHealth = 100 -- How much health we start with
PLAYER_CLASS.StartArmor = 0 -- How much armour we start with
PLAYER_CLASS.DropWeaponOnDie = false -- Do we drop our weapon when we die
PLAYER_CLASS.UseVMHands = true -- Uses viewmodel hands

PLAYER_CLASS.GetHandsModel = function(self)
    local name = player_manager.TranslateToPlayerModelName(self.Player:GetModel())
    return player_manager.TranslatePlayerHands(name)
end

--PLAYER_CLASS.Spawn = function(self)
    --local ply = self.Player
    --ply:SetPlayerColor(Vector(ply:GetInfo("cl_playercolor")))
    --ply:SetWeaponColor(Vector(ply:GetInfo("cl_weaponcolor")))
--end

player_manager.RegisterClass("rc_player", PLAYER_CLASS, "player_default")