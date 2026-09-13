function scale(y)
    local scrW, scrH = ScrW(), ScrH()

    return math.Round(y * math.min(scrW, scrH) / 1080)
end

surface.CreateFont( 'gm.1', {
	font = 'Mont Bold';
	size = scale(24);
	antialias = true;
	extended = true;
	weight = 350;
} )

surface.CreateFont( 'gm.2', {
	font = 'Mont Light';
	size = scale(32);
	antialias = true;
	extended = true;
	weight = 350;
} )

surface.CreateFont( 'gm.3', {
	font = 'Mont Heavy';
	size = scale(32);
	antialias = true;
	extended = true;
	weight = 350;
} )

surface.CreateFont( 'gm.4', {
	font = 'Mont Black';
	size = scale(128);
	antialias = true;
	extended = true;
	weight = 350;
} )

surface.CreateFont( 'gm.5', {
	font = 'Mont Bold';
	size = scale(32);
	antialias = true;
	extended = true;
	weight = 350;
} )

surface.CreateFont( 'gm.6', {
	font = 'Mont Black';
	size = scale(32);
	antialias = true;
	extended = true;
	weight = 350;
} )


function draw.NewRect( x, y, w, h, color )
    surface.SetDrawColor( color )
    surface.DrawRect( x, y, w, h )
end

function draw.Image( x, y, w, h, mat, color )
    surface.SetDrawColor( color )
    surface.SetMaterial( mat )
    surface.DrawTexturedRect( x, y, w, h )
end

function LerpColor(t, from, to)
	return Color(
		(1 - t) * from.r + t * to.r,
		(1 - t) * from.g + t * to.g,
		(1 - t) * from.b + t * to.b,
		(1 - t) * from.a + t * to.a
	)
end