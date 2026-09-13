--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

util.PrecacheSound("npc/attack_helicopter/aheli_mine_drop1.wav")
util.PrecacheSound("buttons/combine_button_locked.wav")
util.PrecacheSound("npc/scanner/combat_scan5.wav")
game.AddParticles("vortigaunt_fx.pcf")

local aug_forceshield_Vmanip_compatible = false

-- timer.Simple(5, function()
--     local file1Exists = file.Exists("vmanip/anims/vmanip_baseanims.lua", "LUA")
--     local file2Exists = file.Exists("vmanip/autorun/server/sv_vmanip.lua", "LUA")
--     local file3Exists = file.Exists("vmanip/autorun/client/cl_vmanip.lua", "LUA")
--     if file1Exists or file2Exists or file3Exists then
--         aug_forceshield_Vmanip_compatible = true
--     end
-- end)

local function forceShieldDeploy(ply)
    ply.active_aug1_cooldown = ply.active_aug1_cooldown or CurTime()
    ply.emitSoundCooldown = ply.emitSoundCooldown or CurTime()
    local augJustFired = false

    if CurTime() >= ply.active_aug1_cooldown then
        augJustFired = true
        timer.Simple(0.1, function()
            augJustFired = false
        end)

        -- Check if the player has the required weapon
        local hasDeployableForceShieldAugmentWep = ply:HasWeapon("deployable_force_shield_augment_wep")

        if hasDeployableForceShieldAugmentWep then
            ply.active_aug1_cooldown = CurTime() + 33
            timer.Simple(33, function()
                ply:EmitSound("npc/scanner/combat_scan5.wav", 40)
            end)
            ply:EmitSound("npc/attack_helicopter/aheli_mine_drop1.wav", 35)

            if SERVER then
                local shieldDeployer = ents.Create("shield_deployer")
                local _shieldDeployAngleYaw = ply:GetEyeTrace().Normal:Angle().yaw
                shieldDeployer.shieldDeployAngleYaw = _shieldDeployAngleYaw
                shieldDeployer:SetPos(ply:GetPos() + Vector(0, 0, 48))
                shieldDeployer:SetAngles(ply:GetAngles())
                shieldDeployer:Spawn()
                local shieldDeployerPhys = shieldDeployer.phys
                shieldDeployer:Activate()

                if shieldDeployer:GetPhysicsObject():IsValid() and ply:IsValid() then
                    shieldDeployerPhys:SetVelocityInstantaneous(ply:EyeAngles():Forward() * 500)
                end
            end

            if aug_forceshield_Vmanip_compatible then
                net.Start("VManip_SimplePlay")
                net.WriteString("use")
                net.Send(ply)
            end

            ply:ViewPunch(Angle(-4, 0, 0))
        else
            -- Player doesn't have the required weapon, play a different sound or handle it as needed
            ply:EmitSound("garrysmod/ui_click.wav", 35)
        end
    end

    if not augJustFired and CurTime() >= ply.emitSoundCooldown then
        ply.emitSoundCooldown = CurTime() + 2.5
        ply:EmitSound("buttons/combine_button_locked.wav", 35)
    end
end

concommand.Add("deploy_force_shield", forceShieldDeploy)

hook.Add("PlayerInitialSpawn", "ClearShieldCoolDown", function(ply, transition)
    if transition then
        ply.active_aug1_cooldown = 0
        ply.emitSoundCooldown = 0
    end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
