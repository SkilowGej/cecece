--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

ENT.Type            = "anim"

ENT.PrintName = "Droid z amunicją"
ENT.Author = "Luna"
ENT.Information = "Repairs Vehicles"
ENT.Category = "[LVS]"

ENT.Spawnable		= true
ENT.AdminOnly		= false

if SERVER then
    function ENT:SpawnFunction(ply, tr, ClassName)
        if not tr.Hit then return end

        local ent = ents.Create(ClassName)
        ent:SetPos(tr.HitPos + tr.HitNormal)
        ent:Spawn()
        ent:Activate()

        return ent
    end

    function ENT:OnTakeDamage(dmginfo)
    end

    function ENT:Initialize()
        self:SetModel("models/battleground/droids/gonk_droid.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:DrawShadow(false)
        self:SetTrigger(true)
        self:SetCollisionGroup(COLLISION_GROUP_WORLD)

        -- Таймер для периодической выдачи патронов
        self.nextArmorTime = 0
    end

	function ENT:ArmorPlayer(player)
		if not IsValid(player) then return end
	
		-- Проверяем, является ли объект игроком
		if not player:IsPlayer() then return end
	
		local maxArmor = 250
	
		if player:Armor() < maxArmor then
			player:SetArmor(math.min(player:Armor() + 250, maxArmor))
			player:EmitSound("battleground/droids/gonk_droid_supply_1.wav")
		end
	end
	
	function ENT:StartTouch(entity)
		-- Проверяем, что это игрок
		if entity:IsPlayer() then
			self:ArmorPlayer(entity)
		end
	end
	
	function ENT:EndTouch(entity)
		-- Проверяем, что это игрок
		if entity:IsPlayer() then
			self:ArmorPlayer(entity)
		end
	end
	
	function ENT:Think()
		-- Устанавливаем таймер на каждые 1 секунду
		--if CurTime() >= self.nextArmorTime then
			--self.nextArmorTime = CurTime() + 2
	
			-- Ищем игроков в радиусе 200 единиц
			for _, entity in ipairs(ents.FindInSphere(self:GetPos(), 120)) do
				if entity:IsPlayer() and entity:Armor() < 250 then  -- Используем новое значение постоянно
					self:ArmorPlayer(entity)
				end
			end
		--end
	
		self:NextThink(CurTime())
		return true
	end
end

if CLIENT then
	local WhiteList = {
		["weapon_physgun"] = true,
		["weapon_physcannon"] = true,
		["gmod_tool"] = true,
	}

	local mat = Material( "models/wireframe" )
	local FrameMat = Material( "lvs/3d2dmats/frame.png" )
	local AmmoMat = Material( "luna_icons/kevlar-vest.png" )
	function ENT:Draw()
		local ply = LocalPlayer()
		local Small = false

		if IsValid( ply ) and not IsValid( ply:lvsGetVehicle() ) then
			self:DrawModel()

			Small = true

			if GetConVarNumber( "cl_draweffectrings" ) == 0 then return end

			local ply = LocalPlayer()
			local wep = ply:GetActiveWeapon()

			if not IsValid( wep ) then return end

			local weapon_name = wep:GetClass()

			-- if not WhiteList[ weapon_name ] then
			-- 	return
			-- end
		end

		local Pos = self:GetPos()

		for i = 0, 180, 180 do
			cam.Start3D2D( self:LocalToWorld( Vector(0,0, self:OBBMins().z + 2 ) ), self:LocalToWorldAngles( Angle(i,90,0) ), 0.25 )
				surface.SetDrawColor( 27, 98, 179, 255 )

				surface.SetMaterial( FrameMat )
				surface.DrawTexturedRect( -512, -512, 1024, 1024 )

				surface.SetMaterial( AmmoMat )
				if Small then
					surface.DrawTexturedRect( -103, 185, 210, 210 )
				else
					surface.DrawTexturedRect( -512, -512, 1024, 1024 )
				end
			cam.End3D2D()
		end
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
