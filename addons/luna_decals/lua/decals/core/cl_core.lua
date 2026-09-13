--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

function Decals.Update()
    local ent = net.ReadEntity()

    if not ent or not IsValid(ent) then return end

    ent:SetDecal( Material("icon16/error.png") )
    ent:SetLoaded( false )
end
net.Receive( "Decals.Update", Decals.Update )

function Decals.Open( len, ent )
    if Decals.Menu then return end

    if !ent then
        ent = net.ReadEntity()
    end

    local pos = ent:GetPos():ToScreen()

    local x = pos.x + pos.x / 4

    if x > ScrW() then
        x = x - pos.x / 2
    end

    local frame = vgui.Create "Decals.Menu"
    frame:SetSize( 320, 475 )
    frame:SetPos( x, 0 )
    frame:CenterVertical()
    frame:SetEnt( ent )
    frame:Setup()
    frame:MakePopup()

    Decals.Menu = frame
end
net.Receive( "Decals.Edit", Decals.Open )


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
