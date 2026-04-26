return {
    TagOrder = {
        "OWNER",
        "ADMIN",
        "UNICORN MAN",
    },
  
    RankData = {
        ["OWNER"] = {
            primary = Color3.fromRGB(255, 255, 255),
            useimage = true,
            accent = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(173, 55, 55)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(252, 183, 119)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 230, 70)),
            },
            image = "http://www.roblox.com/asset/?id=7487018714"
        },

        ["ADMIN"] = {
            primary = Color3.fromRGB(255, 255, 255),
            useimage = true,
            accent = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(250, 95, 92)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(145, 56, 54)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
            },
            image = "http://www.roblox.com/asset/?id=7487018714"
        },

        ["UNICORN MAN"] = {
            primary = Color3.fromRGB(255, 255, 255),
            useimage = true,
            accent = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 30, 255)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(135, 22, 135)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
            },
            image = "http://www.roblox.com/asset/?id=81949972333091"
        },
    }
}
