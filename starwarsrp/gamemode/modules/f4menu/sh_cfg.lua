GameMenu = GameMenu or {}

GameMenu.cfg = {
    mats = {
        back = Material( 'luna_ui_base/fon.png' );
        gr = Material( 'luna_ui_base/luna-ui_gradient-corner_2k.png' );
        logo = Material( 'luna_sup_brand/sup_logo_var1.png', 'smooth mips' );
        logo2 = Material( 'luna_sup_brand/luna-core.png', 'smooth mips' );
        close = Material( 'luna_ui_base/close.png', 'smooth mips' );
        sets = Material( 'luna_ui_base/settings.png', 'smooth mips' );
        circle = Material( 'luna_ui_base/elements/luna-ui_circle.png', 'smooth mips' );
        big_circle = Material( 'luna_ui_base/circle-element1.png', 'smooth mips' );
        user = Material( 'luna_ui_base/etc/recycle.png', 'smooth mips' );
    };

    colors = {
        black = Color( 0, 0, 0, 150 );
        white = Color( 255, 255, 255, 255 );
        white_hover = Color( 150, 150, 150, 150 );
        white2 = Color( 255, 255, 255, 5 );
        gr = Color( 99, 109, 168, 150 );
        link = Color( 46, 52, 65 );
        blue = Color( 56, 126, 255, 255 );
        gray = Color( 198, 198, 198, 198 );
        green = Color( 66, 192, 62 );
        notify = Color( 56, 126, 255, 150 );
    };

    -- Ссылки
    links = {
        {
            image = Material( 'luna_menus/esc/steam.png', 'smooth mips' );
            link = 'https://steamcommunity.com/sharedfiles/filedetails/?id=3604236668';
        };
        {
            image = Material( 'luna_menus/esc/discord.png', 'smooth mips' );
            link = 'https://discord.gg/vjXyAYMhUg';
        };
    };

    -- Статистика
    stats = {
        {
            name = 'Czas w grze:';
            image = Material( 'luna_menus/f4/time.png', 'smooth mips' );
            check = function() 
                local data, currentTime = GetPlayerTrackingData( LocalPlayer() ), os.time()
                local timeOnServer = data.TotalTime + (currentTime - data.JoinTime)
                return NewFormatTime(timeOnServer) 
            end;
        };

        {
            name = 'Pierwsze wejście:';
            image = Material( 'luna_menus/f4/first.png', 'smooth mips' );
            check = function() 
                local data = GetPlayerTrackingData( LocalPlayer() )
                return os.date( '%d.%m.%Y', data.FirstJoinTime )
            end;
        };

        {
            name = 'Zabójstw:';
            image = Material( 'luna_menus/f4/target.png', 'smooth mips' );
            check = function()
                local data = GetPlayerTrackingData( LocalPlayer() )
                return data.KillCount
            end;
        };

        {
            name = 'Śmierci:';
            image = Material( 'luna_menus/f4/skull.png', 'smooth mips' );
            check = function() 
                local data = GetPlayerTrackingData( LocalPlayer() )
                return data.DeathCount
            end;
        };

        {
            name = 'Zarobiono:';
            image = Material( 'luna_menus/f4/money.png', 'smooth mips' );
            check = function() 
                local data = GetPlayerTrackingData( LocalPlayer() )
                return (string.Comma( data.MoneyEarned ).. ' KR')
            end;
        };

        {
            name = 'Wydano:';
            image = Material( 'luna_menus/f4/hand.png', 'smooth mips' );
            check = function() 
                local data = GetPlayerTrackingData( LocalPlayer() )
                return (string.Comma( data.MoneySpent ).. ' KR')
            end;
        };

        {
            name = 'Zwycięstwa w mini-grach:';
            image = Material( 'luna_menus/f4/games.png', 'smooth mips' );
            check = function() 

                return '0' 
            end;
        };

        {
            name = 'Wykonane zadania:';
            image = Material( 'luna_menus/f4/quest.png', 'smooth mips' );
            check = function() 
                local data = LocalPlayer():GetMetadata( 'dutyStats', 0 )
                return data
            end;
        };
    };
}

-- Легионы
GameMenu.legions = {
    {
        name = '1. DYWIZJA',
        desc = [[Dywizja składa się z kilku batalionów, z których każdy specjalizuje się
w określonych rodzajach operacji bojowych: szturmowych, rozpoznawczych, inżynieryjnych itp.
Każdy oddział dywizji jest przeszkolony do działania w zespole, zgodnie z precyzyjnie opracowanymi schematami taktycznymi.

Dzięki swojej dyscyplinie, zgraniu i profesjonalizmowi 1. Dywizja Piechoty
jest uważana za jeden z kluczowych elementów sił zbrojnych Republiki w
walce z separatystami i innymi zagrożeniami dla Republiki.]],
               categories = {
            {
                title = 'Żołnierze',
                jobs = { [TEAM_UN] = true, [TEAM_CADET] = true },
                ranks = { ["RCT"] = true, ["PVT"] = true, ["PSC"] = true, ["PFC"] = true, ["SPC"] = true, ["CPL"] = true }
            },
            {
                title = 'Sierżanci',
                jobs = { [TEAM_UN] = true },
                ranks = { ["MSG"] = true, ["SGT"] = true, ["SSG"] = true, ["SFC"] = true, ["SGM"] = true, ["CSM"] = true }
            },
            {
                title = 'Oficerowie',
                jobs = { [TEAM_UN] = true },
                ranks = { ["JLT"] = true, ["LT"] = true, ["1LT"] = true, ["HLT"] = true, ["CPT"] = true }
            },
            {
                title = 'Sztab',
                jobs = { [TEAM_UN] = true },
                ranks = { ["MJR"] = true, ["LTC"] = true, ["COL"] = true, ["CC"] = true, ["SCC"] = true, ["MC"] = true }
            }
        }
    },
    {
        name = '187. LEGION',
        desc = [[ Znany również jako Batalion Uderzeniowy Mace'a Windu, był legionem elitarnych żołnierzy-klonów, którzy służyli pod dowództwem Najwyższego Generała Jedi Mace'a Windu i Komandora Bacary. Wyróżniały ich fioletowe znaki na zbrojach, które kolorystycznie pasowały do kryształu miecza świetlnego Mace'a Windu.]],
categories = {
            {
                title = 'Żołnierze',
                jobs = { [TEAM_187] = true },
                ranks = { ["RCT"] = true, ["PVT"] = true, ["PSC"] = true, ["PFC"] = true, ["SPC"] = true, ["CPL"] = true }
            },
            {
                title = 'Sierżanci',
                jobs = { [TEAM_187] = true },
                ranks = { ["MSG"] = true, ["SGT"] = true, ["SSG"] = true, ["SFC"] = true, ["SGM"] = true, ["CSM"] = true }
            },
            {
                title = 'Oficerowie',
                jobs = { [TEAM_187] = true },
                ranks = { ["JLT"] = true, ["LT"] = true, ["1LT"] = true, ["HLT"] = true, ["CPT"] = true }
            },
            {
                title = 'Sztab',
                jobs = { [TEAM_187] = true },
                ranks = { ["MJR"] = true, ["LTC"] = true, ["COL"] = true, ["CC"] = true, ["SCC"] = true, ["MC"] = true }
            }
        }
    },
    {
        name = '212. BATALION',
        desc = [[Batalion wojskowy Wielkiej Armii Republiki, składający się z żołnierzy-klonów,
stworzonych dla Galaktycznej Republiki. Na jego czele stał generał-jedi Obi-Wan Kenobi
i jego zastępca, komandor-klon CC-2224 Cody.. 
]],
        categories = {
            {
                title = 'Żołnierze',
                jobs = { [TEAM_212] = true },
                ranks = { ["RCT"] = true, ["PVT"] = true, ["PSC"] = true, ["PFC"] = true, ["SPC"] = true, ["CPL"] = true }
            },
            {
                title = 'Sierżanci',
                jobs = { [TEAM_212] = true },
                ranks = { ["MSG"] = true, ["SGT"] = true, ["SSG"] = true, ["SFC"] = true, ["SGM"] = true, ["CSM"] = true }
            },
            {
                title = 'Oficerowie',
                jobs = { [TEAM_212] = true },
                ranks = { ["JLT"] = true, ["LT"] = true, ["1LT"] = true, ["HLT"] = true, ["CPT"] = true }
            },
            {
                title = 'Sztab',
                jobs = { [TEAM_212] = true },
                ranks = { ["MJR"] = true, ["LTC"] = true, ["COL"] = true, ["CC"] = true, ["SCC"] = true, ["MC"] = true }
            }
        }
    },
    {
        name = '501. LEGION',
        desc = [[Legion był znany ze swoich wysokich zdolności bojowych i
oddania, a także z tego, że jego żołnierze nosili unikalną zbroję z charakterystycznymi znakami.

Dowódcą 501. Legionu został kapitan Rex, który wyróżniał się swoją odwagą i strategicznym myśleniem.]],
        categories = {
            {
                title = 'Żołnierze',
                jobs = { [TEAM_501] = true },
                ranks = { ["RCT"] = true, ["PVT"] = true, ["PSC"] = true, ["PFC"] = true, ["SPC"] = true, ["CPL"] = true }
            },
            {
                title = 'Sierżanci',
                jobs = { [TEAM_501] = true },
                ranks = { ["MSG"] = true, ["SGT"] = true, ["SSG"] = true, ["SFC"] = true, ["SGM"] = true, ["CSM"] = true }
            },
            {
                title = 'Oficerowie',
                jobs = { [TEAM_501] = true },
                ranks = { ["JLT"] = true, ["LT"] = true, ["1LT"] = true, ["HLT"] = true, ["CPT"] = true }
            },
            {
                title = 'Sztab',
                jobs = { [TEAM_501] = true },
                ranks = { ["MJR"] = true, ["LTC"] = true, ["COL"] = true, ["CC"] = true, ["SCC"] = true, ["MC"] = true }
            }
        }
    },
    {
        name = '104. BATALION',
        desc = [[znany również jako batalion „Wilcza sfora” — oddział wojskowy
Wielkiej Armii Republiki podczas Wojny Klonów. Każdy żołnierz-klon z „Wilczej sfory”
miał na hełmie rysunek przedstawiający drapieżnego zwierzęcia podobnego do wilka.]],
        categories = {
            {
                title = 'Żołnierze',
                jobs = { [TEAM_104] = true },
                ranks = { ["RCT"] = true, ["PVT"] = true, ["PSC"] = true, ["PFC"] = true, ["SPC"] = true, ["CPL"] = true }
            },
            {
                title = 'Sierżanci',
                jobs = { [TEAM_104] = true },
                ranks = { ["MSG"] = true, ["SGT"] = true, ["SSG"] = true, ["SFC"] = true, ["SGM"] = true, ["CSM"] = true }
            },
            {
                title = 'Oficerowie',
                jobs = { [TEAM_104] = true },
                ranks = { ["JLT"] = true, ["LT"] = true, ["1LT"] = true, ["HLT"] = true, ["CPT"] = true }
            },
            {
                title = 'Sztab',
                jobs = { [TEAM_104] = true },
                ranks = { ["MJR"] = true, ["LTC"] = true, ["COL"] = true, ["CC"] = true, ["SCC"] = true, ["MC"] = true }
            }
        }
    },
    {
        name = '327. KORPUS',
        desc = [[Swoją nazwę „gwiezdny” 327. korpus otrzymał, służąc jako awangarda
sił Republiki na Zewnętrznych Rubieżach, przemieszczając się od systemu do systemu opanowanego przez
separatystów, nigdy nie trafiając na Coruscant.]],
        categories = {
            {
                title = 'Żołnierze',
                jobs = { [TEAM_327] = true },
                ranks = { ["RCT"] = true, ["PVT"] = true, ["PSC"] = true, ["PFC"] = true, ["SPC"] = true, ["CPL"] = true }
            },
            {
                title = 'Sierżanci',
                jobs = { [TEAM_327] = true },
                ranks = { ["MSG"] = true, ["SGT"] = true, ["SSG"] = true, ["SFC"] = true, ["SGM"] = true, ["CSM"] = true }
            },
            {
                title = 'Oficerowie',
                jobs = { [TEAM_327] = true },
                ranks = { ["JLT"] = true, ["LT"] = true, ["1LT"] = true, ["HLT"] = true, ["CPT"] = true }
            },
            {
                title = 'Sztab',
                jobs = { [TEAM_327] = true },
                ranks = { ["MJR"] = true, ["LTC"] = true, ["COL"] = true, ["CC"] = true, ["SCC"] = true, ["MC"] = true }
            }
        }
    },
    {
        name = 'Gwardia Coruscant',
        desc = [[testtesttest]],
        categories = {
            {
                title = 'Żołnierze',
                jobs = { [TEAM_CG] = true },
                ranks = { ["RCT"] = true, ["PVT"] = true, ["PSC"] = true, ["PFC"] = true, ["SPC"] = true, ["CPL"] = true }
            },
            {
                title = 'Sierżanci',
                jobs = { [TEAM_CG] = true },
                ranks = { ["MSG"] = true, ["SGT"] = true, ["SSG"] = true, ["SFC"] = true, ["SGM"] = true, ["CSM"] = true }
            },
            {
                title = 'Oficerowie',
                jobs = { [TEAM_CG] = true },
                ranks = { ["JLT"] = true, ["LT"] = true, ["1LT"] = true, ["HLT"] = true, ["CPT"] = true }
            },
            {
                title = 'Sztab',
                jobs = { [TEAM_CG] = true },
                ranks = { ["MJR"] = true, ["LTC"] = true, ["COL"] = true, ["CC"] = true, ["SCC"] = true, ["MC"] = true }
            }
        }
    },
    {
        name = '15. BATALION',
        desc = [[Klon-medycy — rodzaj żołnierzy-klonów Wielkiej Armii Republiki, służących jako
lekarze polowi, udzielający pierwszej pomocy na polu bitwy. Klony te zostały wyhodowane
specjalnie w celu leczenia rannych towarzyszy broni. Na Kamino wyposażono ich w
specjalistyczny sprzęt, a mieszkańcy Kamino nauczyli ich sztuki lekarskiej.]],
        categories = {
            {
                title = 'Żołnierze',
                jobs = { [TEAM_15] = true },
                ranks = { ["RCT"] = true, ["PVT"] = true, ["PSC"] = true, ["PFC"] = true, ["SPC"] = true, ["CPL"] = true }
            },
            {
                title = 'Sierżanci',
                jobs = { [TEAM_15] = true },
                ranks = { ["MSG"] = true, ["SGT"] = true, ["SSG"] = true, ["SFC"] = true, ["SGM"] = true, ["CSM"] = true }
            },
            {
                title = 'Oficerowie',
                jobs = { [TEAM_15] = true },
                ranks = { ["JLT"] = true, ["LT"] = true, ["1LT"] = true, ["HLT"] = true, ["CPT"] = true }
            },
            {
                title = 'Sztab',
                jobs = { [TEAM_15] = true },
                ranks = { ["MJR"] = true, ["LTC"] = true, ["COL"] = true, ["CC"] = true, ["SCC"] = true, ["MC"] = true }
            }
        }
    },
    {
        name = '8. BATALION',
        desc = [[Grupa dyplomatyczna, której członkowie towarzyszyli
senatorom i innym ważnym przedstawicielom Republiki podróżującym poza granice
planety. Gwardia Coruscant pełniła również funkcje pokojowe, pomagając
cywilnej policji stolicy, siłom bezpieczeństwa Coruscant (CFS) ]],
        categories = {
            {
                title = 'Żołnierze',
                jobs = { [TEAM_8] = true },
                ranks = { ["RCT"] = true, ["PVT"] = true, ["PSC"] = true, ["PFC"] = true, ["SPC"] = true, ["CPL"] = true }
            },
            {
                title = 'Sierżanci',
                jobs = { [TEAM_8] = true },
                ranks = { ["MSG"] = true, ["SGT"] = true, ["SSG"] = true, ["SFC"] = true, ["SGM"] = true, ["CSM"] = true }
            },
            {
                title = 'Oficerowie',
                jobs = { [TEAM_8] = true },
                ranks = { ["JLT"] = true, ["LT"] = true, ["1LT"] = true, ["HLT"] = true, ["CPT"] = true }
            },
            {
                title = 'Sztab',
                jobs = { [TEAM_8] = true },
                ranks = { ["MJR"] = true, ["LTC"] = true, ["COL"] = true, ["CC"] = true, ["SCC"] = true, ["MC"] = true }
            }
        }
    },
    {
        name = '75. ROTA',
        desc = [[Specjalna jednostka Wielkiej Armii Republiki.
Ich wyposażenie praktycznie nie różniło się od wyposażenia zwykłych żołnierzy-klonów (z wyjątkiem hełmu).
Byli poddawani bardziej intensywnemu szkoleniu niż inni żołnierze. Najczęściej wykorzystywano ich
jako kierowców pojazdów kroczących AT-RT, osłonę dla pozostałych członków oddziału, zwiadowców itp.]],
       categories = {
            {
                title = 'Żołnierze',
                jobs = { [TEAM_ARF] = true },
                ranks = { ["RCT"] = true, ["PVT"] = true, ["PSC"] = true, ["PFC"] = true, ["SPC"] = true, ["CPL"] = true }
            },
            {
                title = 'Sierżanci',
                jobs = { [TEAM_ARF] = true },
                ranks = { ["MSG"] = true, ["SGT"] = true, ["SSG"] = true, ["SFC"] = true, ["SGM"] = true, ["CSM"] = true }
            },
            {
                title = 'Oficerowie',
                jobs = { [TEAM_ARF] = true },
                ranks = { ["JLT"] = true, ["LT"] = true, ["1LT"] = true, ["HLT"] = true, ["CPT"] = true }
            },
            {
                title = 'Sztab',
                jobs = { [TEAM_ARF] = true },
                ranks = { ["MJR"] = true, ["LTC"] = true, ["COL"] = true, ["CC"] = true, ["SCC"] = true, ["MC"] = true }
            }
        }
    },
    {
        name = '24. BRYGADA',
        desc = [[Elitarne typy żołnierzy-klonów Galaktycznej Republiki. Wybrani spośród szeregów
Wielkiej Armii Republiki, rangę żołnierzy ARC otrzymywały klony, które służyły z honorem na polu
bitwy, tacy jak Echo i Fives. ]],
       categories = {
            {
                title = 'Żołnierze',
                jobs = { [TEAM_ARC] = true },
                ranks = { ["RCT"] = true, ["PVT"] = true, ["PSC"] = true, ["PFC"] = true, ["SPC"] = true, ["CPL"] = true }
            },
            {
                title = 'Sierżanci',
                jobs = { [TEAM_ARC] = true },
                ranks = { ["MSG"] = true, ["SGT"] = true, ["SSG"] = true, ["SFC"] = true, ["SGM"] = true, ["CSM"] = true }
            },
            {
                title = 'Oficerowie',
                jobs = { [TEAM_ARC] = true },
                ranks = { ["JLT"] = true, ["LT"] = true, ["1LT"] = true, ["HLT"] = true, ["CPT"] = true }
            },
            {
                title = 'Sztab',
                jobs = { [TEAM_ARC] = true },
                ranks = { ["MJR"] = true, ["LTC"] = true, ["COL"] = true, ["CC"] = true, ["SCC"] = true, ["MC"] = true }
            }
        }
    },
    {
        name = '3. BRYGADA',
        desc = [[Żołnierze-klony Wielkiej Armii Republiki, wyszkoleni do prowadzenia operacji specjalnych.
W czteroosobowych grupach komandosi trenowali według specjalnego, wzmocnionego programu, aby
wykonywać specyficzne zadania, zbyt skomplikowane dla zwykłych żołnierzy. Zazwyczaj zadania te
obejmowały potajemne wkroczenie na teren obiektu, rozpoznanie, likwidację konkretnych obiektów i
dywersję. Najbardziej znanymi oddziałami komandosów są Oddział „Delta” i Oddział „Omega”.]],
       categories = {
            {
                title = 'Żołnierze',
                jobs = { [TEAM_COMMANDO] = true },
                ranks = { ["RCT"] = true, ["PVT"] = true, ["PSC"] = true, ["PFC"] = true, ["SPC"] = true, ["CPL"] = true }
            },
            {
                title = 'Sierżanci',
                jobs = { [TEAM_COMMANDO] = true },
                ranks = { ["MSG"] = true, ["SGT"] = true, ["SSG"] = true, ["SFC"] = true, ["SGM"] = true, ["CSM"] = true }
            },
            {
                title = 'Oficerowie',
                jobs = { [TEAM_COMMANDO] = true },
                ranks = { ["JLT"] = true, ["LT"] = true, ["1LT"] = true, ["HLT"] = true, ["CPT"] = true }
            },
            {
                title = 'Sztab',
                jobs = { [TEAM_COMMANDO] = true },
                ranks = { ["MJR"] = true, ["LTC"] = true, ["COL"] = true, ["CC"] = true, ["SCC"] = true, ["MC"] = true }
            }
        }
    },
--     {
--         name = '1-АЯ ДИВИЗИЯ',
--         desc = [[Дивизия состоит из нескольких батальонов, каждый из которых специализируется
-- на определенных типах боевых операций: штурмовые, разведывательные, инженерные и т.д.
-- Каждый клон в дивизии обучен действовать в команде, следуя четко отработанным тактическим схемам.

-- Благодаря своей дисциплине, слаженности и профессионализму, 1-я пехотная дивизия
-- считается одним из ключевых элементов вооруженных сил Республики в
-- борьбе против сепаратистов и других угроз Республике.]],
--         categories = {
--             {
--                 title = 'Кадеты',
--                 jobs = { [TEAM_CADET] = true }
--             },
--             {
--                 title = 'Руководящий состав',
--                 jobs = { [TEAM_CADET] = true }
--             }
--         }
--     },
--     {
--         name = '1-АЯ ДИВИЗИЯ',
--         desc = [[Дивизия состоит из нескольких батальонов, каждый из которых специализируется
-- на определенных типах боевых операций: штурмовые, разведывательные, инженерные и т.д.
-- Каждый клон в дивизии обучен действовать в команде, следуя четко отработанным тактическим схемам.

-- Благодаря своей дисциплине, слаженности и профессионализму, 1-я пехотная дивизия
-- считается одним из ключевых элементов вооруженных сил Республики в
-- борьбе против сепаратистов и других угроз Республике.]],
--         categories = {
--             {
--                 title = 'Кадеты',
--                 jobs = { [TEAM_CADET] = true }
--             },
--             {
--                 title = 'Руководящий состав',
--                 jobs = { [TEAM_CADET] = true }
--             }
--         }
--     },
    {
        name = 'ZAKON JEDI',
        desc = [[Zakon Jedi — starożytna organizacja duchowo-rycerska, zjednoczona
zasadami i poglądami na temat Mocy. Jedi byli obrońcami pokoju i sprawiedliwości w
Galaktycznej Republice i stali się najbardziej znaną ze wszystkich grup związanych z Mocą.
Na czele z Radą Jedi, Zakon rozrastał się przez tysiąclecia,
pomimo licznych prób, z których większość była związana z konfrontacją z Sithami, nosicielami ciemnej strony Mocy.]],
        categories = {
            {
                title = 'Postacie fabularne',
                jobs = { [TEAM_JEDI] = true }
            },
            {
                title = 'Młodziki',
                jobs = { [TEAM_JEDI1] = true }
            },
            {
                title = 'Przedstawiciele Zakonu',
                jobs = { [TEAM_JEDI2] = true, [TEAM_JEDI7] = true }
            }
        }
    },
    -- {
    --     name = '212 БАТАЛЬОН',
    --     desc = [[]],
    --     categories = {
    --         {
    --             title = 'Кадеты',
    --             jobs = { [TEAM_CADET] = true }
    --         },
    --         {
    --             title = 'Руководящий состав',
    --             jobs = { [TEAM_CADET] = true, [TEAM_UN] = true }
    --         }
    --     }
    -- }
 }