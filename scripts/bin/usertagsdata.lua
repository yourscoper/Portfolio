return {
    TagOrder = {
        "OWNER",
        "ADMIN",
        "UNICORN MAN",
        "papi angel",
        "that nigger gon"
    },

    RankData = {

        ["OWNER"] = {
            primary            = Color3.fromRGB(255, 255, 255),
            useimage           = true,
            image              = "http://www.roblox.com/asset/?id=10086464520",
            
            accent             = ColorSequence.new{
                ColorSequenceKeypoint.new(0,   Color3.fromRGB(0,   0,   0  )),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(145, 138, 102)),
                ColorSequenceKeypoint.new(1,   Color3.fromRGB(240, 210, 60 )),
            },
            outerglowgradient  = ColorSequence.new{
                ColorSequenceKeypoint.new(0,   Color3.fromRGB(240, 200, 0  )),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 240, 120)),
                ColorSequenceKeypoint.new(1,   Color3.fromRGB(180, 140, 0  )),
            },
            bordergradient     = ColorSequence.new{
                ColorSequenceKeypoint.new(0,    Color3.fromRGB(240, 200, 0  )),
                ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 255, 200)),
                ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(200, 160, 0  )),
                ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 240, 120)),
                ColorSequenceKeypoint.new(1,    Color3.fromRGB(240, 200, 0  )),
            },
            avatargradient     = ColorSequence.new{
                ColorSequenceKeypoint.new(0,    Color3.fromRGB(240, 200, 0  )),
                ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 180)),
                ColorSequenceKeypoint.new(0.66, Color3.fromRGB(200, 160, 0  )),
                ColorSequenceKeypoint.new(1,    Color3.fromRGB(240, 200, 0  )),
            },
            avatarglowcolor    = Color3.fromRGB(220, 180, 0),
            bgGradient         = ColorSequence.new{
                ColorSequenceKeypoint.new(0,   Color3.fromRGB(18, 14, 4 )),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(26, 22, 8 )),
                ColorSequenceKeypoint.new(1,   Color3.fromRGB(12, 10, 2 )),
            },
            tageffects         = true,
            nameeffects        = false,
            glitchedname       = true,
            typewritename      = false,
            tagcolor           = Color3.fromRGB(255, 215, 60),
            crownicon          = true,
            showuserid         = false,
        },

        ["ADMIN"] = {
            primary            = Color3.fromRGB(255, 255, 255),
            useimage           = true,
            image              = "http://www.roblox.com/asset/?id=18565602368",
            accent             = ColorSequence.new{
                ColorSequenceKeypoint.new(0,   Color3.fromRGB(250, 95,  92 )),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(145, 56,  54 )),
                ColorSequenceKeypoint.new(1,   Color3.fromRGB(0,   0,   0  )),
            },
            outerglowgradient  = ColorSequence.new{
                ColorSequenceKeypoint.new(0,   Color3.fromRGB(255, 80,  80 )),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 200, 220)),
                ColorSequenceKeypoint.new(1,   Color3.fromRGB(255, 80,  80 )),
            },
            bordergradient     = ColorSequence.new{
                ColorSequenceKeypoint.new(0,    Color3.fromRGB(255, 80,  80 )),
                ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 200, 200)),
                ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(200, 40,  40 )),
                ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 160, 160)),
                ColorSequenceKeypoint.new(1,    Color3.fromRGB(255, 80,  80 )),
            },
            avatargradient     = ColorSequence.new{
                ColorSequenceKeypoint.new(0,    Color3.fromRGB(255, 80,  80 )),
                ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 200, 200)),
                ColorSequenceKeypoint.new(0.66, Color3.fromRGB(180, 40,  40 )),
                ColorSequenceKeypoint.new(1,    Color3.fromRGB(255, 80,  80 )),
            },
            avatarglowcolor    = Color3.fromRGB(220, 60, 60),
            bgGradient         = ColorSequence.new{
                ColorSequenceKeypoint.new(0,   Color3.fromRGB(18, 8,  8 )),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(26, 12, 12)),
                ColorSequenceKeypoint.new(1,   Color3.fromRGB(12, 4,  4 )),
            },
            tageffects         = true,
            nameeffects        = true,
            glitchedname       = false,
            typewritename      = false,
            tagcolor           = Color3.fromRGB(255, 100, 100),
            crownicon          = false,
            showuserid         = false,
        },

        ["UNICORN MAN"] = {
            -- core
            primary            = Color3.fromRGB(255, 255, 255),
            useimage           = true,
            image              = "http://www.roblox.com/asset/?id=90144296400082",
            accent             = ColorSequence.new{
                ColorSequenceKeypoint.new(0,   Color3.fromRGB(255, 30,  255)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(135, 22,  135)),
                ColorSequenceKeypoint.new(1,   Color3.fromRGB(0,   0,   0  )),
            },
            outerglowgradient  = ColorSequence.new{
                ColorSequenceKeypoint.new(0,   Color3.fromRGB(255, 100, 255)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 200, 255)),
                ColorSequenceKeypoint.new(1,   Color3.fromRGB(255, 100, 255)),
            },
            bordergradient     = ColorSequence.new{
                ColorSequenceKeypoint.new(0,    Color3.fromRGB(255, 100, 255)),
                ColorSequenceKeypoint.new(0.25, Color3.fromRGB(100, 200, 255)),
                ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(200, 100, 255)),
                ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 200, 100)),
                ColorSequenceKeypoint.new(1,    Color3.fromRGB(255, 100, 255)),
            },
            avatargradient     = ColorSequence.new{
                ColorSequenceKeypoint.new(0,    Color3.fromRGB(255, 100, 255)),
                ColorSequenceKeypoint.new(0.33, Color3.fromRGB(100, 200, 255)),
                ColorSequenceKeypoint.new(0.66, Color3.fromRGB(200, 255, 100)),
                ColorSequenceKeypoint.new(1,    Color3.fromRGB(255, 100, 255)),
            },
            avatarglowcolor    = Color3.fromRGB(200, 80, 200),
            bgGradient         = ColorSequence.new{
                ColorSequenceKeypoint.new(0,   Color3.fromRGB(14, 4,  18)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 8,  28)),
                ColorSequenceKeypoint.new(1,   Color3.fromRGB(10, 2,  14)),
            },
            tageffects         = true,
            nameeffects        = true,
            glitchedname       = false,
            typewritename      = true,
            tagcolor           = Color3.fromRGB(255, 100, 255),
            crownicon          = false,
            showuserid         = false,
        },

        ["papi angel"] = {
            -- core
            primary            = Color3.fromRGB(255, 255, 255),
            useimage           = true,
            image              = "http://www.roblox.com/asset/?id=115020167372123",
            accent             = ColorSequence.new{
                ColorSequenceKeypoint.new(0,   Color3.fromRGB(0,   0,   0  )),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1,   Color3.fromRGB(0,   0,   0  )),
            },
            outerglowgradient  = ColorSequence.new{
                ColorSequenceKeypoint.new(0,   Color3.fromRGB(180, 180, 255)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1,   Color3.fromRGB(180, 255, 220)),
            },
            bordergradient     = ColorSequence.new{
                ColorSequenceKeypoint.new(0,    Color3.fromRGB(150, 150, 255)),
                ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(150, 255, 200)),
                ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 200, 255)),
                ColorSequenceKeypoint.new(1,    Color3.fromRGB(150, 150, 255)),
            },
            avatargradient     = ColorSequence.new{
                ColorSequenceKeypoint.new(0,    Color3.fromRGB(180, 180, 255)),
                ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.66, Color3.fromRGB(180, 255, 220)),
                ColorSequenceKeypoint.new(1,    Color3.fromRGB(255, 180, 255)),
            },
            avatarglowcolor    = Color3.fromRGB(180, 180, 255),
            bgGradient         = ColorSequence.new{
                ColorSequenceKeypoint.new(0,   Color3.fromRGB(15, 15, 22)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(22, 22, 35)),
                ColorSequenceKeypoint.new(1,   Color3.fromRGB(10, 10, 18)),
            },
            tageffects         = false,
            nameeffects        = false,
            glitchedname       = false,
            typewritename      = true,
            tagcolor           = Color3.fromRGB(255, 255, 255),
            crownicon          = false,
            showuserid         = false,
        },

        ["that nigger gon"] = {
            primary            = Color3.fromRGB(255, 255, 255),
            useimage           = true,
            image              = "http://www.roblox.com/asset/?id=132854398900146"
            accent      = ColorSequence.new{
                ColorSequenceKeypoint.new(0,    Color3.fromRGB(58, 2, 61)),
                ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(68, 43, 69)),
                ColorSequenceKeypoint.new(1,    Color3.fromRGB(130, 121, 130)),
            },
            outerglowgradient  = ColorSequence.new{
                ColorSequenceKeypoint.new(0,   Color3.fromRGB(180, 180, 255)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1,   Color3.fromRGB(180, 255, 220)),
            },
            bordergradient     = ColorSequence.new{
                ColorSequenceKeypoint.new(0,    Color3.fromRGB(150, 150, 255)),
                ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(150, 255, 200)),
                ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 200, 255)),
                ColorSequenceKeypoint.new(1,    Color3.fromRGB(150, 150, 255)),
            },
            avatargradient     = ColorSequence.new{
                ColorSequenceKeypoint.new(0,    Color3.fromRGB(180, 180, 255)),
                ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.66, Color3.fromRGB(180, 255, 220)),
                ColorSequenceKeypoint.new(1,    Color3.fromRGB(255, 180, 255)),
            },
            avatarglowcolor    = Color3.fromRGB(180, 180, 255),
            bgGradient         = ColorSequence.new{
                ColorSequenceKeypoint.new(0,   Color3.fromRGB(15, 15, 22)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(22, 22, 35)),
                ColorSequenceKeypoint.new(1,   Color3.fromRGB(10, 10, 18)),
            },
            tageffects         = false,
            nameeffects        = false,
            glitchedname       = false,
            typewritename      = true,
            tagcolor           = Color3.fromRGB(255, 255, 255),
            crownicon          = false,
            showuserid         = false,
        }

    }
}
