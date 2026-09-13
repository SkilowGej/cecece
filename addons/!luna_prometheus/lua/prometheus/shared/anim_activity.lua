--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

-- disable
do return end

local DISTANCE = prometheus.cfg.playerAnimationCalculateDistance ^ 2

local zeroFn = function() end
local injectGM = (GM or GAMEMODE) and function(_, _, fn) fn() end or hook.Add

local shouldHide do
    if (CLIENT) then
        local ENTITY = FindMetaTable('Entity')
        local VECTOR = FindMetaTable('Vector')
        local GetPos = ENTITY.GetPos
        local DistToSqr = VECTOR.DistToSqr
        function shouldHide(object)
            local client = LocalPlayer()
            if (client == object) then return false end

            local clientPos = GetPos(client)
            local objectPos = GetPos(object)
            return (DistToSqr(clientPos, objectPos) > DISTANCE)
        end
    end
end

local function overrideAnimationEvents()
    local GM = GAMEMODE

    if (SERVER) then
        GM.MouthMoveAnimation = zeroFn
        GM.GrabEarAnimation = zeroFn
    else
        prometheus.GamemodeCalcMainActivity = prometheus.GamemodeCalcMainActivity or GM.CalcMainActivity
        prometheus.GamemodeUpdateAnimation = prometheus.GamemodeUpdateAnimation or GM.UpdateAnimation
        prometheus.GamemodeTranslateActivity = prometheus.GamemodeTranslateActivity or GM.TranslateActivity

        local CalcMainActivity = prometheus.GamemodeCalcMainActivity
        local UpdateAnimation = prometheus.GamemodeUpdateAnimation
        local TranslateActivity = prometheus.GamemodeTranslateActivity
        local ACT_HL2MP_IDLE = ACT_HL2MP_IDLE

        function GM:CalcMainActivity(pl, a, b, c, d, e, f)
            if (shouldHide(pl)) then return pl.CalcIdeal, pl.CalcSeqOverride end
            return CalcMainActivity(self, pl, a, b, c, d, e, f)
        end

        function GM:UpdateAnimation(pl, a, b, c, d, e, f)
            if (shouldHide(pl)) then return end
            return UpdateAnimation(self, pl, a, b, c, d, e, f)
        end

        function GM:TranslateActivity(pl, a, b, c, d, e, f)
            if (shouldHide(pl)) then return ACT_HL2MP_IDLE end
            return TranslateActivity(self, pl, a, b, c, d, e, f)
        end
    end
end
-- injectGM('PostGamemodeLoaded', 'prometheus.Override', overrideAnimationEvents)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
