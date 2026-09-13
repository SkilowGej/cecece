local function CreateFont(name, size, options)
    options = options or {}
    surface.CreateFont(name, {
        font = options.font or "Mont Bold",
        size = size,
        weight = options.weight or 0,
        blursize = options.blursize or 0,
        antialias = options.antialias ~= false,
        additive = options.additive or false,
        extended = options.extended ~= false,
    })
end

function scale(y)
    local scrW, scrH = ScrW(), ScrH()

    return math.Round(y * math.min(scrW, scrH) / 1080)
end

-- Additional fonts
CreateFont("font_base", 31)
CreateFont("aurebesh", 18, {font = "Aurebesh"})
CreateFont("font_base_big", 81, {weight = 500})
CreateFont("font_base_rotate", 38)
CreateFont("font_mont_black_38", 38, {font = "Mont Black"})
CreateFont("font_mont_black_28", 28, {font = "Mont Black"})
CreateFont("font_mont_black_50", 60, {font = "Mont Black"})
CreateFont("font_big_black", 38, {font = "Mont Black"})
CreateFont("font_base_normal", 56)
CreateFont("font_base_24", 23)
CreateFont("font_base_22", 21, {weight = 500})
CreateFont("hubfont_90", 91, {weight = 500})
CreateFont("hubfont_60", 61, {weight = 500})
CreateFont("font_base_title", 38)
CreateFont("font_base_18", 17, {weight = 500})
CreateFont("font_base_small", 14, {weight = 300})
CreateFont("font_base_12", 11)
CreateFont("font_base_hud", 26)
CreateFont("lunaMontMini", 16)
CreateFont("font_base_84_normal", 84)
CreateFont("font_base_84", 84)
CreateFont("font_base_small_84", 84)
CreateFont("font_base_54", 53)
CreateFont("font_base_30", 30)
CreateFont("font_base_544", 50)
CreateFont("font_base_warning", 20)
CreateFont("font_notify", 18, {weight = 500})
CreateFont("font_base_45", 45, {weight = 100})

-- Roboto fonts
CreateFont("font_roboto_24", 24, {weight = 100})
CreateFont("font_roboto_15", 15, {weight = 100})
CreateFont("font_roboto_21", 21, {weight = 100})

-- NPC fonts
CreateFont("font_npc1hit", 60, {weight = 100})
CreateFont("font_npc1", 60, {weight = 100, font = "Mont Black"})
CreateFont("font_npc1neon", 60, {weight = 100, font = "Mont Black", blursize = 6})
CreateFont("font_npc2", 46, {weight = 100})
CreateFont("font_npc2hit", 46, {weight = 100})

-- Special fonts
CreateFont("font_base_big_s", 81, {weight = 500, blursize = 5})
CreateFont("font_base_large", 100, {weight = 500})
CreateFont("font_base_largeS", ScreenScale(50), {weight = 500})

-- Wadik fonts
-- CreateFont("font_base_24_wadik", 24, {weight = 500, font = "Wadik"})
-- CreateFont("font_base_34_wadik", 34, {weight = 500, font = "Wadik"})

-- Squad System fonts
CreateFont("SquadSystem.Ping", 15, {antialias = true, additive = false})
CreateFont("SquadSystem.PingSmall", 12, {antialias = true, additive = false})
CreateFont("lunaMontMenuMiniFont", math.max(ScreenScale(4), 18), {weight = 300})
CreateFont("lunaMontNoticeFont", math.max(ScreenScale(8), 18), {weight = 100, antialias = true})
CreateFont("SquadSystem.OverHead", ScrH() * .02)
CreateFont("SquadSystem.Sideboard.Title", ScrH() * .035)
CreateFont("SquadSystem.Sideboard.PlayerName", ScrH() * .02)
CreateFont("SquadSystem.Sideboard.PlayerDetails", ScrH() * .015)
CreateFont("SquadSystem.Sideboard.Context", ScrH() * .018)
CreateFont("SquadSystem.Invite.Title", ScrH() * .07, {font = "Mont Black"})
CreateFont("SquadSystem.Invite.Text", ScrH() * .06)
CreateFont("SquadSystem.Create.Hint", ScrH() * .02)
CreateFont("SquadSystem.Commands.Title", ScrH() * .06, {font = "Mont Black"})
CreateFont("SquadSystem.Commands.SubTitle", ScrH() * .02)
CreateFont("SquadSystem.List.SQTitle", ScrH() * .025)
CreateFont("SquadSystem.List.Details", ScrH() * .02)

-- Death Screen fonts
CreateFont("header", 36, {font = "Mont Black"})
CreateFont("text", 16)
CreateFont("header_large", 48, {font = "Mont Black", weight = 500})
CreateFont("text_medium", 24)
CreateFont("text_small", 12)

-- F4 Menu fonts
CreateFont("gm.1", scale(24), {font = "Mont Bold", weight = 350})
CreateFont("gm.2", scale(32), {font = "Mont Light", weight = 350})
CreateFont("gm.3", scale(32), {font = "Mont Heavy", weight = 350})
CreateFont("gm.4", scale(128), {font = "Mont Black", weight = 350})
CreateFont("gm.matchend", scale(248), {font = "Mont Black", weight = 350})
CreateFont("gm.5", scale(32), {font = "Mont Bold", weight = 350})
CreateFont("gm.6", scale(32), {font = "Mont Black", weight = 350})