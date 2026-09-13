local cfg = GameMenu.cfg

local PANEL = {}

function PANEL:Init()
    self:DockPadding( 0, scale(140), 0, 0 )

    self.techSide = self:Add('DLabel')
    self.techSide:Dock(TOP)
    self.techSide:SetTall( scale(70) )
    self.techSide:SetFont( 'gm.1' )
    self.techSide:SetTextColor( cfg.colors.gray )
    self.techSide:SetText( [[Wszystkie statystyki opierają się na Twoim doświadczeniu w grze, a nie na pojedynczej
postaci! Zostało to zrobione w celu optymalizacji, dziękujemy
za uwagę.]] )
    self.techSide:SetWrap(true)
    self.techSide:SetContentAlignment( 7 )

    self.aboutRP = self:Add('DLabel')
    self.aboutRP:Dock(TOP)
    self.aboutRP:SetTall( scale(140) )
    self.aboutRP:DockMargin( 0, scale(60), 0, 0 )
    self.aboutRP:SetFont( 'gm.1' )
    self.aboutRP:SetTextColor( cfg.colors.gray )
    self.aboutRP:SetText( [[Aby zapewnić przyjemny pobyt na serwerze, przeprojektowaliśmy i dopracowaliśmy
wiele elementów składowych RP. Gracze na naszym serwerze całkowicie
zanurzają się w atmosferze odległej galaktyki, a administratorzy
dbają o to, aby naruszenia zasad były szybko karane i nie powodowały
dyskomfortu podczas odgrywania swojej postaci. Wszystkie dodatki wybrane
na serwerze zostały zebrane specjalnie w celu uzupełnienia atmosfery Gwiezdnych Wojen.]] )
    self.aboutRP:SetWrap(true)
    self.aboutRP:SetContentAlignment( 7 )

    self.aboutTeam = self:Add('DLabel')
    self.aboutTeam:Dock(TOP)
    self.aboutTeam:SetTall( scale(90) )
    self.aboutTeam:DockMargin( 0, scale(50), 0, 0 )
    self.aboutTeam:SetFont( 'gm.1' )
    self.aboutTeam:SetTextColor( cfg.colors.gray )
    self.aboutTeam:SetText( [[Nasz zespół składa się z pracowników, którzy nie po raz pierwszy tworzą
serwery. Dokładnie przeanalizowaliśmy doświadczenia naszych poprzednich
serwerów, dzięki czemu stopniowo opracowujemy coraz doskonalszą
formułę projektu, w którym gra będzie przyjemnością.]] )
    self.aboutTeam:SetWrap(true)
    self.aboutTeam:SetContentAlignment( 7 )

    self.aboutPersonal = self:Add('DLabel')
    self.aboutPersonal:Dock(TOP)
    self.aboutPersonal:SetTall( scale(140) )
    self.aboutPersonal:DockMargin( 0, scale(60), 0, 0 )
    self.aboutPersonal:SetFont( 'gm.1' )
    self.aboutPersonal:SetTextColor( cfg.colors.gray )
    self.aboutPersonal:SetText( [[Personel naszego serwera doskonale zna wszystkie zasady i nie traktuje
graczy jak ludzi drugiej kategorii, ponieważ oni również są
graczami, którzy grają na naszym serwerze. Sam personel przechodzi
rygorystyczną selekcję przeprowadzaną przez zespół najwyższej administracji. Przy
rekrutacji personelu serwera kierujemy się całkowicie i w pełni zasadą „Liczy się jakość, a nie ilość”.]] )
    self.aboutPersonal:SetWrap(true)
    self.aboutPersonal:SetContentAlignment( 7 )
end

function PANEL:Paint( w, h )
    draw.SimpleText( 'O PROJEKCIE:', 'gm.4', 0, 0, cfg.colors.white, 0, 3 )
    draw.SimpleText( 'Część techniczna', 'gm.6', 0, scale(110), cfg.colors.white, 0, 3 )
    draw.SimpleText( 'Składnik RP', 'gm.6', 0, scale(240), cfg.colors.white, 0, 3 )
    draw.SimpleText( 'Zespół projektu', 'gm.6', 0, scale(430), cfg.colors.white, 0, 3 )
    draw.SimpleText( 'Praca personelu projektu', 'gm.6', 0, scale(580), cfg.colors.white, 0, 3 )

end

vgui.Register( 'gm.tab.info', PANEL, 'EditablePanel' )
