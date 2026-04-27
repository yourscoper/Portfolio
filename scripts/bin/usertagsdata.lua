return {
    TagOrder = {
        "OWNER",
        "ADMIN",
        "UNICORN MAN",
        "papi angel"
    },
  
    RankData = {
        ["OWNER"] = {
            primary     = Color3.fromRGB(255, 255, 255),
            useimage    = true,
            accent      = ColorSequence.new{
                ColorSequenceKeypoint.new(0,    Color3.fromRGB(80, 115, 255)),
                ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1,    Color3.fromRGB(255, 115, 115)),
            },
            image       = "http://www.roblox.com/asset/?id=7487018714"
        },

        ["ADMIN"] = {
            primary     = Color3.fromRGB(255, 255, 255),
            useimage    = true,
            accent      = ColorSequence.new{
                ColorSequenceKeypoint.new(0,    Color3.fromRGB(250, 95, 92)),
                ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(145, 56, 54)),
                ColorSequenceKeypoint.new(1,    Color3.fromRGB(0, 0, 0)),
            },
            image       = "http://www.roblox.com/asset/?id=18565602368"
        },

        ["UNICORN MAN"] = {
            primary     = Color3.fromRGB(255, 255, 255),
            useimage    = true,
            accent      = ColorSequence.new{
                ColorSequenceKeypoint.new(0,    Color3.fromRGB(255, 30, 255)),
                ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(135, 22, 135)),
                ColorSequenceKeypoint.new(1,    Color3.fromRGB(0, 0, 0)),
            },
            image       = "http://www.roblox.com/asset/?id=90144296400082"
        },

        ["papi angel"] = {
            primary     = Color3.fromRGB(255, 255, 255),
            useimage    = true,
            accent      = ColorSequence.new{
                ColorSequenceKeypoint.new(0,    Color3.fromRGB(207, 29, 70)),
                ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(112, 29, 207)),
                ColorSequenceKeypoint.new(1,    Color3.fromRGB(29, 207, 195)),
            },
            image       = "http://www.roblox.com/asset/?id=92567337549662"
        },
    }
}
