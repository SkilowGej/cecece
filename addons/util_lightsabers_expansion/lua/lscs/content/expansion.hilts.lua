--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local hilt = {}
hilt.PrintName = "Vader Hilt"
hilt.Author = "Rubat"
hilt.id = "vaderhilt"
hilt.mdl = "models/sgg/starwars/weapons/w_vader_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Vader Hilt Reverse"
hilt.Author = "Rubat"
hilt.id = "vaderhiltr"
hilt.mdl = "models/sgg/starwars/weapons/w_vader_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, 6.5),
            ang = Angle(90, 90, 90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Obi Wan EP 1 Hilt"
hilt.Author = "Rubat"
hilt.id = "obi1"
hilt.mdl = "models/sgg/starwars/weapons/w_obiwan_ep1_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Obi Wan EP 1 Hilt Reverse"
hilt.Author = "Rubat"
hilt.id = "obi1r"
hilt.mdl = "models/sgg/starwars/weapons/w_obiwan_ep1_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, 6.5),
            ang = Angle(90, 90, 90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Anakin EP 2 Hilt"
hilt.Author = "Rubat"
hilt.id = "ani1"
hilt.mdl = "models/sgg/starwars/weapons/w_anakin_ep2_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )


local hilt = {}
hilt.PrintName = "Mauls Broken Hilt"
hilt.Author = "Rubat"
hilt.id = "maulb"
hilt.mdl = "models/sgg/starwars/weapons/w_maul_saber_half_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Mauls Broken Hilt Reverse"
hilt.Author = "Rubat"
hilt.id = "maulbr"
hilt.mdl = "models/sgg/starwars/weapons/w_maul_saber_half_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, 6.5),
            ang = Angle(90, 90, 90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Anakin EP 2 Hilt Reverse"
hilt.Author = "Rubat"
hilt.id = "ani1r"
hilt.mdl = "models/sgg/starwars/weapons/w_anakin_ep2_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, 6.5),
            ang = Angle(90, 90, 90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Anakin EP 3 Hilt"
hilt.Author = "Rubat"
hilt.id = "ani2"
hilt.mdl = "models/sgg/starwars/weapons/w_anakin_ep3_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Anakin EP 3 Hilt Reverse"
hilt.Author = "Rubat"
hilt.id = "ani2r"
hilt.mdl = "models/sgg/starwars/weapons/w_anakin_ep3_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, 6.5),
            ang = Angle(90, 90, 90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Lukes Hilt"
hilt.Author = "Rubat"
hilt.id = "luke"
hilt.mdl = "models/sgg/starwars/weapons/w_luke_ep6_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Lukes Hilt Reverse"
hilt.Author = "Rubat"
hilt.id = "luker"
hilt.mdl = "models/sgg/starwars/weapons/w_luke_ep6_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, 6.5),
            ang = Angle(90, 90, 90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Common Jedi Saber Hilt"
hilt.Author = "Rubat"
hilt.id = "common"
hilt.mdl = "models/sgg/starwars/weapons/w_common_jedi_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Common Jedi Saber Hilt Reverse"
hilt.Author = "Rubat"
hilt.id = "commonr"
hilt.mdl = "models/sgg/starwars/weapons/w_common_jedi_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, 6.5),
            ang = Angle(90, 90, 90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Mace Windu Hilt"
hilt.Author = "Rubat"
hilt.id = "mace"
hilt.mdl = "models/sgg/starwars/weapons/w_mace_windu_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Mace Windu Hilt Reverse"
hilt.Author = "Rubat"
hilt.id = "macer"
hilt.mdl = "models/sgg/starwars/weapons/w_mace_windu_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, 6.5),
            ang = Angle(90, 90, 90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Obi Wan EP 3 Hilt"
hilt.Author = "Rubat"
hilt.id = "obi2"
hilt.mdl = "models/sgg/starwars/weapons/w_obiwan_ep3_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Obi Wan EP 3 Hilt Reverse"
hilt.Author = "Rubat"
hilt.id = "obi2r"
hilt.mdl = "models/sgg/starwars/weapons/w_obiwan_ep3_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, 6.5),
            ang = Angle(90, 90, 90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Qui Gon Jins Hilt"
hilt.Author = "Rubat"
hilt.id = "qui"
hilt.mdl = "models/sgg/starwars/weapons/w_quigon_gin_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Qui Gon Jins Hilt Reverse"
hilt.Author = "Rubat"
hilt.id = "quir"
hilt.mdl = "models/sgg/starwars/weapons/w_quigon_gin_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, 6.5),
            ang = Angle(90, 90, 90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Darth Sidious's Hilt"
hilt.Author = "Rubat"
hilt.id = "sidious"
hilt.mdl = "models/sgg/starwars/weapons/w_sidious_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Darth Sidious's Hilt Reverse"
hilt.Author = "Rubat"
hilt.id = "sidiousr"
hilt.mdl = "models/sgg/starwars/weapons/w_sidious_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, 6.5),
            ang = Angle(90, 90, 90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Yoda's Hilt"
hilt.Author = "Rubat"
hilt.id = "yoda"
hilt.mdl = "models/sgg/starwars/weapons/w_yoda_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Yoda's Hilt Reverse"
hilt.Author = "Rubat"
hilt.id = "yodar"
hilt.mdl = "models/sgg/starwars/weapons/w_yoda_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, 6.5),
            ang = Angle(90, 90, 90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Dooku Hilt"
hilt.Author = "Rubat"
hilt.id = "dooku"
hilt.mdl = "models/weapons/starwars/w_dooku_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.6,-0.3) ),
                dir = ent:LocalToWorldAngles( Angle(50,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Maul Staff Hilt"
hilt.Author = "Rubat"
hilt.id = "maul"
hilt.mdl = "models/weapons/starwars/w_maul_saber_staff_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, 0),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 0),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(-12.5,-0.05,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(12.5,-0.05,0) ),
                dir = ent:LocalToWorldAngles( Angle(-90,-180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Kylo Hilt"
hilt.Author = "Rubat"
hilt.id = "kylo"
hilt.mdl = "models/weapons/starwars/w_kr_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, 0),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(-3,-0.05,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
            [2] = {
                pos = ent:LocalToWorld( Vector(-4,-0.05,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,270,0) ):Up(),
		length_multiplier = 0.15,
            },
            [3] = {
                pos = ent:LocalToWorld( Vector(-4,-0.05,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(-90,270,0) ):Up(),
		length_multiplier = 0.15,
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Kylo Hilt Reverse"
hilt.Author = "Rubat"
hilt.id = "kylor"
hilt.mdl = "models/weapons/starwars/w_kr_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3, -1.5, 0),
            ang = Angle(90, 90, 90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1.5, 0),
            ang = Angle(-90, -90, -90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(-3,-0.05,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
            [2] = {
                pos = ent:LocalToWorld( Vector(-4,-0.05,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,270,0) ):Up(),
		length_multiplier = 0.15,
            },
            [3] = {
                pos = ent:LocalToWorld( Vector(-4,-0.05,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(-90,270,0) ):Up(),
		length_multiplier = 0.15,
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR 1"
hilt.Author = "ArsenicBeast"
hilt.id = "swtor1"
hilt.mdl = "models/swtor/arsenic/lightsabers/temptedapprentice'slightsaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(-1,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR 2"
hilt.Author = "ArsenicBeast"
hilt.id = "swtor2"
hilt.mdl = "models/swtor/arsenic/lightsabers/rishi'slightsabermk-1.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(0,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR 3"
hilt.Author = "ArsenicBeast"
hilt.id = "swtor3"
hilt.mdl = "models/swtor/arsenic/lightsabers/unstablepeacemaker'slightsaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(0,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR 4"
hilt.Author = "ArsenicBeast"
hilt.id = "swtor4"
hilt.mdl = "models/swtor/arsenic/lightsabers/senyatirall'slightsaber-companion.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(0,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR 5"
hilt.Author = "ArsenicBeast"
hilt.id = "swtor5"
hilt.mdl = "models/swtor/arsenic/lightsabers/defianttechnographer'sshoto.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(0,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR 6"
hilt.Author = "ArsenicBeast"
hilt.id = "swtor6"
hilt.mdl = "models/swtor/arsenic/lightsabers/grantekf11-dlightsaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(0,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR 7"
hilt.Author = "ArsenicBeast"
hilt.id = "swtor7"
hilt.mdl = "models/swtor/arsenic/lightsabers/blademaster'sattenuatedlightsaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(0,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR 8"
hilt.Author = "ArsenicBeast"
hilt.id = "swtor8"
hilt.mdl = "models/swtor/arsenic/lightsabers/ice-jewellightsaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(0,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR 9"
hilt.Author = "ArsenicBeast"
hilt.id = "swtor9"
hilt.mdl = "models/swtor/arsenic/lightsabers/diabolistlightsaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(0,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR 10"
hilt.Author = "ArsenicBeast"
hilt.id = "swtor10"
hilt.mdl = "models/swtor/arsenic/lightsabers/revanite'smk-2lightsaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(0,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR 11"
hilt.Author = "ArsenicBeast"
hilt.id = "swtor11"
hilt.mdl = "models/swtor/arsenic/lightsabers/dauntlessavenger'slightsaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(0,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR 12"
hilt.Author = "ArsenicBeast"
hilt.id = "swtor12"
hilt.mdl = "models/swtor/arsenic/lightsabers/artusianlightsaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(0,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR 13"
hilt.Author = "ArsenicBeast"
hilt.id = "swtor13"
hilt.mdl = "models/swtor/arsenic/lightsabers/exarch'smk-1lightsaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(0,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR Staff 1"
hilt.Author = "ArsenicBeast"
hilt.id = "swtors1"
hilt.mdl = "models/swtor/arsenic/lightsabers/adascorppolesaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -12),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, 1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.5,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(25,-0.7,0) ),
                dir = ent:LocalToWorldAngles( Angle(-90,-180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR Staff 2"
hilt.Author = "ArsenicBeast"
hilt.id = "swtors2"
hilt.mdl = "models/swtor/arsenic/lightsabers/descendant'sheirloomdualsaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -12),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, 1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.5,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(32.5,-0.7,0) ),
                dir = ent:LocalToWorldAngles( Angle(-90,-180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR Staff 3"
hilt.Author = "ArsenicBeast"
hilt.id = "swtors3"
hilt.mdl = "models/swtor/arsenic/lightsabers/defianttechnographer'sdualsaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -12),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, 1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.5,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(25,-0.7,0) ),
                dir = ent:LocalToWorldAngles( Angle(-90,-180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR Staff 4"
hilt.Author = "ArsenicBeast"
hilt.id = "swtors4"
hilt.mdl = "models/swtor/arsenic/lightsabers/warmaster'sdoublebladedlightsaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -12),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, 1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.5,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(25,-0.7,0) ),
                dir = ent:LocalToWorldAngles( Angle(-90,-180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR Staff 5"
hilt.Author = "ArsenicBeast"
hilt.id = "swtors5"
hilt.mdl = "models/swtor/arsenic/lightsabers/vigorousbattlerdualsaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -12),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, 1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.5,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(32.5,-0.7,0) ),
                dir = ent:LocalToWorldAngles( Angle(-90,-180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "SWTOR Staff 6"
hilt.Author = "ArsenicBeast"
hilt.id = "swtor6"
hilt.mdl = "models/swtor/arsenic/lightsabers/rishi'smk-1polesaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -12),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, 1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.5,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(32.5,-0.7,0) ),
                dir = ent:LocalToWorldAngles( Angle(-90,-180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Jedi Academy 1"
hilt.Author = "Captain Charles"
hilt.id = "ja1"
hilt.mdl = "models/sgg/starwars/weapons/w_saber_9_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(1,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Jedi Academy 2"
hilt.Author = "Captain Charles"
hilt.id = "ja2"
hilt.mdl = "models/sgg/starwars/weapons/w_saber_7_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(1,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Jedi Academy 3"
hilt.Author = "Captain Charles"
hilt.id = "ja3"
hilt.mdl = "models/sgg/starwars/weapons/w_saber_6_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(1,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Jedi Academy 4"
hilt.Author = "Captain Charles"
hilt.id = "ja4"
hilt.mdl = "models/sgg/starwars/weapons/w_saber_5_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(1,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Jedi Academy 5"
hilt.Author = "Captain Charles"
hilt.id = "ja5"
hilt.mdl = "models/sgg/starwars/weapons/w_saber_4_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(1,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Jedi Academy 6"
hilt.Author = "Captain Charles"
hilt.id = "ja6"
hilt.mdl = "models/sgg/starwars/weapons/w_saber_3_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(1,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Jedi Academy 7"
hilt.Author = "Captain Charles"
hilt.id = "ja7"
hilt.mdl = "models/sgg/starwars/weapons/w_saber_1_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(1,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Jedi Academy 8"
hilt.Author = "Captain Charles"
hilt.id = "ja8"
hilt.mdl = "models/sgg/starwars/weapons/w_reborn_saber_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(1,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Jedi Academy 9"
hilt.Author = "Captain Charles"
hilt.id = "ja9"
hilt.mdl = "models/sgg/starwars/weapons/w_saber_2_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(1,-0.6,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Jedi Academy Staff 1"
hilt.Author = "ArsenicBeast"
hilt.id = "jas1"
hilt.mdl = "models/sgg/starwars/weapons/w_saber_dual_1_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -12),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, 1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(3,-0.5,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(25,-0.7,0) ),
                dir = ent:LocalToWorldAngles( Angle(-90,-180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Jedi Academy Staff 2"
hilt.Author = "ArsenicBeast"
hilt.id = "jas2"
hilt.mdl = "models/sgg/starwars/weapons/w_saber_dual_2_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -12),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, 1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(3,-0.5,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(25,-0.7,0) ),
                dir = ent:LocalToWorldAngles( Angle(-90,-180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Jedi Academy Staff 3"
hilt.Author = "ArsenicBeast"
hilt.id = "jas3"
hilt.mdl = "models/sgg/starwars/weapons/w_saber_dual_3_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -12),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, 1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(3,-0.5,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(25,-0.7,0) ),
                dir = ent:LocalToWorldAngles( Angle(-90,-180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Jedi Academy Staff 4"
hilt.Author = "ArsenicBeast"
hilt.id = "jas4"
hilt.mdl = "models/sgg/starwars/weapons/w_saber_dual_4_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -12),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, 1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(3,-0.5,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(25,-0.7,0) ),
                dir = ent:LocalToWorldAngles( Angle(-90,-180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Jedi Academy Staff 5"
hilt.Author = "ArsenicBeast"
hilt.id = "jas5"
hilt.mdl = "models/sgg/starwars/weapons/w_saber_dual_5_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -12),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, 1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(3,-0.5,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(25,-0.7,0) ),
                dir = ent:LocalToWorldAngles( Angle(-90,-180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 1"
hilt.Author = "ArsenicBeast"
hilt.id = "cw1"
hilt.mdl = "models/starwars/cwa/lightsabers/aaylasecura.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 2"
hilt.Author = "ArsenicBeast"
hilt.id = "cw2"
hilt.mdl = "models/starwars/cwa/lightsabers/adigalia.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 3"
hilt.Author = "ArsenicBeast"
hilt.id = "cw3"
hilt.mdl = "models/starwars/cwa/lightsabers/ahsoka.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 4"
hilt.Author = "ArsenicBeast"
hilt.id = "cw4"
hilt.mdl = "models/starwars/cwa/lightsabers/byph.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 5"
hilt.Author = "ArsenicBeast"
hilt.id = "cw5"
hilt.mdl = "models/starwars/cwa/lightsabers/compressedcrystal.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 6"
hilt.Author = "ArsenicBeast"
hilt.id = "cw6"
hilt.mdl = "models/starwars/cwa/lightsabers/darkforcephase1.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 7"
hilt.Author = "ArsenicBeast"
hilt.id = "cw7"
hilt.mdl = "models/starwars/cwa/lightsabers/darkforcephase2.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 8"
hilt.Author = "ArsenicBeast"
hilt.id = "cw8"
hilt.mdl = "models/starwars/cwa/lightsabers/darkknight1.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 9"
hilt.Author = "ArsenicBeast"
hilt.id = "cw9"
hilt.mdl = "models/starwars/cwa/lightsabers/darkknight2.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 10"
hilt.Author = "ArsenicBeast"
hilt.id = "cw10"
hilt.mdl = "models/starwars/cwa/lightsabers/darksaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3, -1.5, -8),
            ang = Angle(-90, -110, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 9.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 11"
hilt.Author = "ArsenicBeast"
hilt.id = "cw11"
hilt.mdl = "models/starwars/cwa/lightsabers/darthmaul.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 12"
hilt.Author = "ArsenicBeast"
hilt.id = "cw12"
hilt.mdl = "models/starwars/cwa/lightsabers/forked.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 13"
hilt.Author = "ArsenicBeast"
hilt.id = "cw13"
hilt.mdl = "models/starwars/cwa/lightsabers/ganodi.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 14"
hilt.Author = "ArsenicBeast"
hilt.id = "cw14"
hilt.mdl = "models/starwars/cwa/lightsabers/gungan.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 15"
hilt.Author = "ArsenicBeast"
hilt.id = "cw15"
hilt.mdl = "models/starwars/cwa/lightsabers/gungi.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 16"
hilt.Author = "ArsenicBeast"
hilt.id = "cw16"
hilt.mdl = "models/starwars/cwa/lightsabers/jocastanu.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 17"
hilt.Author = "ArsenicBeast"
hilt.id = "cw17"
hilt.mdl = "models/starwars/cwa/lightsabers/kashyyyk.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 18"
hilt.Author = "ArsenicBeast"
hilt.id = "cw18"
hilt.mdl = "models/starwars/cwa/lightsabers/katooni.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 19"
hilt.Author = "ArsenicBeast"
hilt.id = "cw19"
hilt.mdl = "models/starwars/cwa/lightsabers/kitfisto.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 20"
hilt.Author = "ArsenicBeast"
hilt.id = "cw20"
hilt.mdl = "models/starwars/cwa/lightsabers/luminara.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 21"
hilt.Author = "ArsenicBeast"
hilt.id = "cw21"
hilt.mdl = "models/starwars/cwa/lightsabers/petro.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 22"
hilt.Author = "ArsenicBeast"
hilt.id = "cw22"
hilt.mdl = "models/starwars/cwa/lightsabers/pulsating.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 23"
hilt.Author = "ArsenicBeast"
hilt.id = "cw23"
hilt.mdl = "models/starwars/cwa/lightsabers/pulsatingblue.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 24"
hilt.Author = "ArsenicBeast"
hilt.id = "cw24"
hilt.mdl = "models/starwars/cwa/lightsabers/reverseahsoka.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 25"
hilt.Author = "ArsenicBeast"
hilt.id = "cw25"
hilt.mdl = "models/starwars/cwa/lightsabers/saeseetiin.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 26"
hilt.Author = "ArsenicBeast"
hilt.id = "cw26"
hilt.mdl = "models/starwars/cwa/lightsabers/training.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 27"
hilt.Author = "ArsenicBeast"
hilt.id = "cw27"
hilt.mdl = "models/starwars/cwa/lightsabers/talz.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 28"
hilt.Author = "ArsenicBeast"
hilt.id = "cw28"
hilt.mdl = "models/starwars/cwa/lightsabers/spiralling.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 29"
hilt.Author = "ArsenicBeast"
hilt.id = "cw29"
hilt.mdl = "models/starwars/cwa/lightsabers/sparklingcrystal.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Clone Wars Saber 30"
hilt.Author = "ArsenicBeast"
hilt.id = "cw30"
hilt.mdl = "models/starwars/cwa/lightsabers/shaakti.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Zhroms saber 1"
hilt.Author = "Zhrom"
hilt.id = "zhrom"
hilt.mdl = "models/days/days.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(0,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Zhroms saber 2"
hilt.Author = "Zhrom"
hilt.id = "zhrom2"
hilt.mdl = "models/the knowledge seeker/the knowledge seeker.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Zhroms saber 3"
hilt.Author = "Zhrom"
hilt.id = "zhrom3"
hilt.mdl = "models/unknown/unknown.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(0,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Zhroms saber 4"
hilt.Author = "Zhrom"
hilt.id = "zhrom4"
hilt.mdl = "models/lightsaber3/lightsaber3.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(3,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Zhroms saber 5"
hilt.Author = "Zhrom"
hilt.id = "zhrom5"
hilt.mdl = "models/lightsaber/lightsaber.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(2,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Zhroms saber 6"
hilt.Author = "Zhrom"
hilt.id = "zhrom6"
hilt.mdl = "models/lightsaber2/lightsaber2.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -6.5),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(0,-0.4,-0.1) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Zhrom Pike 1"
hilt.Author = "ArsenicBeast"
hilt.id = "zhrompike1	"
hilt.mdl = "models/snake/snake.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -12),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, 1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(-20.50,-2,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(-20.50,-2.5,2.5) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Zhrom Pike 2"
hilt.Author = "ArsenicBeast"
hilt.id = "zhrompike2"
hilt.mdl = "models/snake2/snake2.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -12),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, 1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(-20.50,-2.5,1.5) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Zhrom Pike 3"
hilt.Author = "ArsenicBeast"
hilt.id = "zhrompike3"
hilt.mdl = "models/pike/pike.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -12),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, 1, 6.5),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(-15.75,-2,1) ),
                dir = ent:LocalToWorldAngles( Angle(87,185,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "F Saber 1"
hilt.Author = "Octavius"
hilt.id = "fsaber1"
hilt.mdl = "models/wos/lct/weapons/lightsabers/dwarf_saber_duel_slim_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -15),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 15),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(-5,-0.05,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(32.5,-0.05,0) ),
                dir = ent:LocalToWorldAngles( Angle(-90,-180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "F Saber 2"
hilt.Author = "Octavius"
hilt.id = "fsaber2"
hilt.mdl = "models/wos/lct/weapons/lightsabers/dwarf_saber_duel_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -15),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 15),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(-5,-0.05,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(32.5,-0.05,0) ),
                dir = ent:LocalToWorldAngles( Angle(-90,-180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "F Saber 3"
hilt.Author = "Octavius"
hilt.id = "fsaber3"
hilt.mdl = "models/wos/lct/weapons/lightsabers/gold_snake_duel_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -15),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 15),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(-9,-0.05,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(27.5,-0.05,0) ),
                dir = ent:LocalToWorldAngles( Angle(-90,-180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "F Saber 4"
hilt.Author = "Octavius"
hilt.id = "fsaber4"
hilt.mdl = "models/wos/lct/weapons/lightsabers/dragon_saber_duel_hilt.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, -15),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 15),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(-5,-0.05,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(32.5,-0.05,0) ),
                dir = ent:LocalToWorldAngles( Angle(-90,-180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "F Saber 5"
hilt.Author = "Octavius"
hilt.id = "fsaber5"
hilt.mdl = "models/wos/lct/weapons/lightsabers/old_saber_duel.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(3.75, -1.5, 0),
            ang = Angle(-90, -90, -90),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(3.75, -1, 0),
            ang = Angle(90, 90, 90),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(-10,-0.05,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
	   [2] = {
                pos = ent:LocalToWorld( Vector(10,-0.05,0) ),
                dir = ent:LocalToWorldAngles( Angle(-90,-180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

local hilt = {}
hilt.PrintName = "Vibrosword"
hilt.Author = "MA2"
hilt.id = "vibro"
hilt.mdl = "models/mynewfpackk/bxdroid_vibroswordd.mdl"
hilt.info = {
    ParentData = {
        ["RH"] = {
            bone = "ValveBiped.Bip01_R_Hand",
            pos = Vector(12, -8, -60),
            ang = Angle(0,0,0),
        },
        ["LH"] = {
            bone = "ValveBiped.Bip01_L_Hand",
            pos = Vector(12, -8, -60),
            ang = Angle(-180, -180, -180),
        },
    },
    GetBladePos = function( ent ) 
        local blades = {
            [1] = {
                pos = ent:LocalToWorld( Vector(-10,-0.05,0) ),
                dir = ent:LocalToWorldAngles( Angle(90,180,0) ):Up(),
            },
        }

        return blades
    end,
}
LSCS:RegisterHilt( hilt )

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
