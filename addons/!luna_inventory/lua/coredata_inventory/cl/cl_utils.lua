--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local function scale(y)
    local scrW, scrH = ScrW(), ScrH()
    return math.Round(y * math.min(scrW, scrH) / 1080)
end

surface.CreateFont('sup_inv.2', {
    font = 'Montserrat',
    size = scale(32),
    antialias = true,
    extended = true,
    weight = 150,
})

surface.CreateFont('sup_inv.name', {
    font = 'Montserrat',
    size = scale(15),
    antialias = true,
    extended = true,
    weight = 150,
})

surface.CreateFont('sup_inv.selectorr', {
    font = 'Montserrat',
    size = scale(16),
    antialias = true,
    extended = true,
    weight = 150,
})

surface.CreateFont('sup_inv.desc', {
    font = 'Montserrat',
    size = scale(18),
    antialias = true,
    extended = true,
    weight = 600,
})

surface.CreateFont('sup_inv.kg_title', {
    font = 'Montserrat',
    size = scale(40),
    antialias = true,
    extended = true,
    weight = 1500,
})

surface.CreateFont('sup_inv.maininv', {
    font = 'Montserrat-Bold',
    size = scale(40),
    antialias = true,
    extended = true,
    weight = 1500,
})

surface.CreateFont('sup_inv.kg_desc', {
    font = 'Montserrat',
    size = scale(30),
    antialias = true,
    extended = true,
    weight = 900,
})

surface.CreateFont('sup_inv.kg_small', {
    font = 'Montserrat',
    size = scale(24),
    antialias = true,
    extended = true,
    weight = 900,
})

function LerpColor(t, from, to)
    return Color((1 - t) * from.r + t * to.r, (1 - t) * from.g + t * to.g, (1 - t) * from.b + t * to.b, (1 - t) * from.a + t * to.a)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
