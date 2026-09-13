local function aComplete( p, id )
    if not IsValid( p ) then return end
    if not p or not id then return end
    if not p:IsPlayer() then return end

	local tbl = Achievements.Table[id]
	local REWARD_NAME, uID, TITLE = tbl.reward.name, tbl.check[1], tbl.name

    local isWeapon, classWeapon = tbl.reward.isWeapon, tbl.reward.class
	
	if IsValid(p) then
		local DATA = p:GetMetadata( 'Achievements:Task', {} )

		if DATA[uID] then return end

    --[[
        -- Кто лез в код? Функции "GetCharacter" не существует в системе персов.
        local char = p:GetCharacter() 
        if isWeapon then
            local inventory = char:GetInventory()
            inventory:Add( classWeapon )
        else
            local existMoney = char:GetMoney()
            char:SetMoney( existMoney + tbl.money )
        end
    --]]

		DATA[uID] = true
		p:SetMetadata( 'Achievements:Task', DATA )
		p:ChatPrint( '[#] Zdobyłeś osiągnięcie "'.. TITLE.. '" i otrzymałeś '.. REWARD_NAME )
	end

	return
end

function aSetTask( p, id, num )
    if not IsValid( p ) then return end
    if not p or not id then return end

	num = num or 1

    local tbl = Achievements.Table[id]

    local NEED, uID = tbl.check[2], tbl.check[1]
    local DATA, CURRENT_ACHIEVEMENT = p:GetMetadata( 'Achievements:Task', {} ), p:GetMetadata( 'Achievements:'.. uID, 0 )

    if not DATA[uID] then
        p:SetMetadata( 'Achievements:'.. uID, CURRENT_ACHIEVEMENT + num )
    end

    if CURRENT_ACHIEVEMENT >= NEED then
        aComplete( p, id )
        p:SetMetadata( 'Achievements:'.. uID, nil )
    end

	return
end

