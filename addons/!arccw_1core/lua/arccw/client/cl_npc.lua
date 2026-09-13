--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

hook.Add("PopulateMenuBar", "ArcCW_NPCWeaponMenu", function (menubar)
    local menu = menubar:AddOrGetMenu("ArcCW NPC Weapons")

    menu:AddCVar("None", "gmod_npcweapon", "none")
    menu:AddSpacer()

    local weaponlist = weapons.GetList()

    table.SortByMember(weaponlist, "PrintName", true)

    local cats = {}

    for _, k in pairs(weaponlist) do
        if weapons.IsBasedOn(k.ClassName, "arccw_base") and !k.NotForNPCs and !k.PrimaryBash and k.Spawnable then
            local cat = k.Category or "Other"

            if !cats[cat] then cats[cat] = menu:AddSubMenu(cat) end

            cats[cat]:SetDeleteSelf(false)
            cats[cat]:AddCVar(k.PrintName, "gmod_npcweapon", k.ClassName)
        end
    end
end)

net.Receive("arccw_npcgiverequest", function(len, ply)
    local class = GetConVar("gmod_npcweapon"):GetString()

    net.Start("arccw_npcgivereturn")
    net.WriteString(class)
    net.SendToServer()
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
