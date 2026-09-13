--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("sh_configs_defusablebombs.lua")
AddCSLuaFile("sh_configs_defusablebombs.lua")
util.AddNetworkString("bomb_defusable_menu")

game.AddParticles( "particles/explosion_bomb.pcf" )
PrecacheParticleSystem( "Test" )

net.Receive("bomb_defusable_menu", function(_,ply)
    if not IsValid(ply.lastdefbomb) then return end
    local typ = net.ReadInt(3)
    if typ < 1 or typ > 2 then return end
    local time = net.ReadInt(32) or nil
    ply.lastdefbomb:HandleActivation(ply,typ,time)
end)

util.AddNetworkString("bomb_defusable_sound")
function Joes_Bomb:MakeBombSound(pos)
    net.Start("bomb_defusable_sound")
    net.WriteVector(pos)
    net.Broadcast()
end

/*
{
    [1] = {
        [1] = {
            col = Color(255,0,0),
            pos = Vector(0,0,0),
            ang = Angle(0,0,0),
            cut = true or 1/2/3
        },
    },
}
*/

Joes_Bomb.codes = {}

function Joes_Bomb:AddCombination(tbl)
    table.insert(Joes_Bomb.codes, tbl)
end
/*
if there is one yellow wire and atleast 1 blue wire and no black wire, cut the red and then the blue one.
if there are two yellow ones and a green wire, cut the left yellow one and the black one.
if there are two yellow ones and a blue wire, cut the orange and then the blue wire.
if there is no green wire and one red wire, cut the blue wire.
if there is one yellow and one black wire, cut the green wire, then the black and then the yellow wire.
if there is a red wire, a yellow and a white wire and cut the red one.
*/
Joes_Bomb:AddCombination({
    [1] = {
        col = Color(100,100,0), -- yellow
        pos = Vector(-11,-5,19),
        ang = Angle(10,30,-40),
        cut = false
    },
    [2] = {
        col = Color(0,0,100), -- blue
        pos = Vector(-16,0,16),
        ang = Angle(-50,190,0),
        cut = 2
    },
    [3] = {
        col = Color(0,100,0), -- green
        pos = Vector(-15,0,16),
        ang = Angle(0,-110,30),
        cut = false
    },
    [4] = {
        col = Color(100,0,0), -- red
        pos = Vector(-9,-7,18),
        ang = Angle(0,-290,-40),
        cut = 1
    },
})

Joes_Bomb:AddCombination({
    [1] = {
        col = Color(0,0,100), -- blue
        pos = Vector(-11,-5,19),
        ang = Angle(10,30,-40),
        cut = 2
    },
    [2] = {
        col = Color(100,100,0), -- yellow
        pos = Vector(-16,0,16),
        ang = Angle(-50,190,0),
        cut = false
    },
    [3] = {
        col = Color(100,50,0), -- orange
        pos = Vector(-15,0,16),
        ang = Angle(0,-110,30),
        cut = 1
    },
    [4] = {
        col = Color(100,100,0), -- yellow
        pos = Vector(-9,-7,18),
        ang = Angle(0,-290,-40),
        cut = false
    },
})

Joes_Bomb:AddCombination({
    [1] = {
        col = Color(100,100,0), -- yellow
        pos = Vector(-11,-5,19),
        ang = Angle(10,30,-40),
        cut = false
    },
    [2] = {
        col = Color(0,100,0), -- green
        pos = Vector(-16,0,16),
        ang = Angle(-50,190,0),
        cut = false
    },
    [3] = {
        col = Color(100,100,0), -- yellow
        pos = Vector(-15,0,16),
        ang = Angle(0,-110,30),
        cut = 1
    },
    [4] = {
        col = Color(0,0,0), -- black
        pos = Vector(-9,-7,18),
        ang = Angle(0,-290,-40),
        cut = 2
    },
})

Joes_Bomb:AddCombination({
    [1] = {
        col = Color(100,0,0), -- red
        pos = Vector(-11,-5,19),
        ang = Angle(10,30,-40),
        cut = false
    },
    [2] = {
        col = Color(100,100,100), -- white 
        pos = Vector(-16,0,16),
        ang = Angle(-50,190,0),
        cut = false
    },
    [3] = {
        col = Color(0,0,100), -- blue
        pos = Vector(-15,0,16),
        ang = Angle(0,-110,30),
        cut = true
    },
    [4] = {
        col = Color(0,0,0), -- black
        pos = Vector(-9,-7,18),
        ang = Angle(0,-290,-40),
        cut = false
    },
})


Joes_Bomb:AddCombination({
    [1] = {
        col = Color(0,0,0), -- black
        pos = Vector(-11,-5,19),
        ang = Angle(10,30,-40),
        cut = 2
    },
    [2] = {
        col = Color(0,100,0), -- green
        pos = Vector(-16,0,16),
        ang = Angle(-50,190,0),
        cut = 1
    },
    [3] = {
        col = Color(100,50,0), -- orange
        pos = Vector(-15,0,16),
        ang = Angle(0,-110,30),
        cut = false
    },
    [4] = {
        col = Color(100,100,0), -- yellow
        pos = Vector(-9,-7,18),
        ang = Angle(0,-290,-40),
        cut = 3
    },
})


Joes_Bomb:AddCombination({
    [1] = {
        col = Color(100,0,0), -- red
        pos = Vector(-11,-5,19),
        ang = Angle(10,30,-40),
        cut = true
    },
    [2] = {
        col = Color(0, 100, 0), -- green
        pos = Vector(-16,0,16),
        ang = Angle(-50,190,0),
        cut = false
    },
    [3] = {
        col = Color(100,100,0), -- yellow
        pos = Vector(-15,0,16),
        ang = Angle(0,-110,30),
        cut = false
    },
    [4] = {
        col = Color(100,100,100), -- white
        pos = Vector(-9,-7,18),
        ang = Angle(0,-290,-40),
        cut = true
    },
})


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
