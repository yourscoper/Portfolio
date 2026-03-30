local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function pressKey(keyName, needsShift)
    needsShift = needsShift or false
    
    local keyCode = Enum.KeyCode[keyName]
    if keyCode then
        if needsShift then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
            wait(0.05)
        end
        
        VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
        wait(0.1)
        VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
        
        if needsShift then
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
        end
        
        return keyName
    end
    return nil
end

-- Function to press multiple keys simultaneously (for chords)
local function pressChord(keys)
    -- Press all keys down
    for _, keyName in ipairs(keys) do
        local keyCode = Enum.KeyCode[keyName]
        if keyCode then
            VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
        end
    end
    
    wait(0.1)
    
    -- Release all keys
    for _, keyName in ipairs(keys) do
        local keyCode = Enum.KeyCode[keyName]
        if keyCode then
            VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
        end
    end
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PianoAutoPlayer2025"
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 280)
mainFrame.Position = UDim2.new(0.5, -150, 0, 50)
mainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
mainFrame.BackgroundTransparency = 0.8
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.new(0.2, 0.2, 0.2)
stroke.Transparency = 0.5
stroke.Thickness = 1
stroke.Parent = mainFrame

-- Invisible title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundTransparency = 1
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Piano Auto-Player 2025"
titleLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.Position = UDim2.new(0, 0, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Ready"
statusLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

local songs = {
    ["Never Meant to Belong - Bleach (I Hate the Rain)"] = {
        keys = {
            -- Opening phrase - slow chords (measures 1-4)
            {"Six", "R", "T", "U"}, {"R", "T", "U"}, {"E", "T", "U"}, {"E", "T", "U"},
            {"Five", "R", "T", "U"}, {"R", "T", "U"}, {"E", "T", "U"}, {"E", "T", "U"},
            {"Four", "R", "T", "U"}, {"R", "T", "U"}, {"E", "T", "U"}, {"E", "T", "U"},
            {"Three", "E", "R", "U"}, {"E", "R", "U"}, {"R", "U"}, "W",
            
            -- High melody section (measures 5-8)
            "K", "L", "X", "Z", "Six", "Six", "Five", "Five",
            "K", "L", "X", "Z", "Four", "Four", "Three", "Three",
            "K", "L", "V", "X", "Six", {"Z", "X"}, "Six", {"Z", "Five", "X"},
            {"Z", "X"}, "Five", "C", {"Four", "X"}, "Z", "L", "K", "Four",
            "J", "H", {"Three", "G"}, "G", "F", "Three",
            
            -- Main melody (measures 9-16)
            "U", "P", "A", "H", {"Six", "F"}, "D", "F", "Six", "D",
            {"Five", "F"}, "L", "K", {"Five", "H"}, "J", "A",
            {"Four", "S"}, "A", "S", "Four", "D",
            {"Three", "S"}, "I", {"Three", "U"}, "F", "D",
            {"Six", "S"}, "A", "S", "D", "S", "Six", "A",
            {"Five", "S"}, "A", {"Five", "S"}, "L", "K", "H", "J", "A",
            {"Four", "S"}, "A", "P", "Four", "Three", "A", "O",
            
            -- Bridge/emotional section (measures 17-20)
            {"At", "R"}, {"Nine", "T"}, "E", "R", "T", {"T", "W"},
            "Y", {"Q", "U"}, "I", {"Zero", "I"}, "O", "P", "Zero", "O",
            {"Six", "P"}, {"Five", "P"}, "I", "O",
            {"Dollar", "U"}, "O", "P", "A", "P", "O", "P", "A",
            {"Four", "S"}, "O", "I", "Y", {"Seven", "U"}, "O",
            {"Three", "I"}, {"Three", "U"},
            
            -- Repeat opening (measures 21-24)
            {"Six", "R", "T", "U"}, {"R", "T", "U"}, {"E", "T", "U"}, {"E", "T", "U"},
            {"Five", "R", "T", "U"}, {"R", "T", "U"}, {"E", "T", "U"}, {"E", "T", "U"},
            {"Four", "R", "T", "U"}, {"R", "T", "U"}, {"E", "T", "U"}, {"E", "T", "U"},
            {"Three", "E", "R", "U"}, {"E", "R", "U"}, {"R", "U"}, "W",
            
            -- Final section (measures 25-32)
            "K", "L", "X", "Z", "Six", "Six", "Five", "Five",
            "K", "L", "X", "Z", "Four", "Four", "Three", "Three",
            "K", "L", "V", "X", "Six", {"Z", "Six", "X"}, {"Z", "Five", "X"},
            {"Z", "X"}, "Five", "C", {"Four", "X"}, "Z", "L", "K", "Four",
            "J", "H", {"Three", "G"}, "G", "F", "Three",
            "U", "P", "A", "H", {"Six", "F"}, "D", "F", "Six", "D",
            {"Five", "F"}, "L", "K", {"Five", "H"}, "J", "A",
            {"Four", "S"}, "A", "S", "Four", "D",
            {"Three", "S"}, "I", {"Three", "U"}, "F", "D",
            {"Six", "S"}, "A", "S", "D", "S", "Six", "A",
            {"Five", "S"}, "A", "S", "Five", "L", "K", "H", "J", "A",
            {"Four", "S"}, "A", "P", "Four", "Three", "A", "O",
            {"At", "R"}, {"Nine", "T"}, "E", "R", "T", {"T", "W"},
            "Y", {"Q", "U"}, "I", {"Zero", "I"}, "O", "P", "Zero", "O",
            {"Six", "P"}, {"Five", "P"}, "I", "O",
            {"Dollar", "U"}, "O", "P", "A", "P", "O", "P", "A",
            {"Four", "S"}, "O", "I", "Y", {"Seven", "U"}, "O",
            {"Three", "I"}, {"Three", "U"}
        },
        timings = {
            -- Opening chords - BPM 64 = 0.9375s per beat (slow, emotional)
            1.0, 0.9, 0.9, 1.8,  -- measure 1: whole note chord
            1.0, 0.9, 0.9, 1.8,  -- measure 2
            1.0, 0.9, 0.9, 1.8,  -- measure 3
            1.0, 0.9, 0.9, 2.5,  -- measure 4: long pause
            
            -- High melody - eighth notes and quarter notes
            0.4, 0.4, 0.4, 0.9, 0.9, 0.9, 0.9, 1.8,  -- measure 5-6
            0.4, 0.4, 0.4, 0.9, 0.9, 0.9, 0.9, 1.8,  -- measure 7-8
            0.4, 0.4, 0.4, 0.9, 0.9, 0.4, 0.9, 0.4,  -- measure 9-10
            0.4, 0.9, 0.9, 0.4, 0.4, 0.4, 0.4, 0.9,  -- measure 11
            0.4, 0.4, 0.4, 0.4, 0.4, 1.8,             -- measure 12
            
            -- Main melody - quarter notes mostly
            0.4, 0.4, 0.4, 0.9, 0.4, 0.4, 0.4, 0.9, 0.9,  -- measure 13-14
            0.4, 0.4, 0.4, 0.4, 0.4, 0.9,                  -- measure 15
            0.4, 0.4, 0.4, 0.9, 0.9,                       -- measure 16
            0.4, 0.4, 0.4, 0.4, 0.9,                       -- measure 17
            0.4, 0.4, 0.4, 0.4, 0.4, 0.9, 0.9,             -- measure 18
            0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.9,   -- measure 19
            0.4, 0.4, 0.9, 0.9, 0.9, 0.9, 0.9,             -- measure 20
            
            -- Bridge - sustained notes
            0.9, 0.9, 0.4, 0.4, 0.9, 0.9,         -- measure 21
            0.9, 0.9, 0.9, 0.9, 0.4, 0.9, 0.9, 0.9,  -- measure 22
            0.9, 0.9, 0.4, 0.9,                      -- measure 23
            0.9, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.9,  -- measure 24
            0.9, 0.4, 0.4, 0.9, 0.9, 0.9,            -- measure 25
            0.9, 1.8,                                 -- measure 26
            
            -- Repeat chords
            1.0, 0.9, 0.9, 1.8,  -- measure 27
            1.0, 0.9, 0.9, 1.8,  -- measure 28
            1.0, 0.9, 0.9, 1.8,  -- measure 29
            1.0, 0.9, 0.9, 2.5,  -- measure 30
            
            -- Final melody repeat
            0.4, 0.4, 0.4, 0.9, 0.9, 0.9, 0.9, 1.8,
            0.4, 0.4, 0.4, 0.9, 0.9, 0.9, 0.9, 1.8,
            0.4, 0.4, 0.4, 0.9, 0.9, 0.4, 0.4,
            0.4, 0.9, 0.9, 0.4, 0.4, 0.4, 0.4, 0.9,
            0.4, 0.4, 0.4, 0.4, 0.4, 1.8,
            0.4, 0.4, 0.4, 0.9, 0.4, 0.4, 0.4, 0.9, 0.9,
            0.4, 0.4, 0.4, 0.4, 0.4, 0.9,
            0.4, 0.4, 0.4, 0.9, 0.9,
            0.4, 0.4, 0.4, 0.4, 0.9,
            0.4, 0.4, 0.4, 0.4, 0.4, 0.9, 0.9,
            0.4, 0.4, 0.4, 0.9, 0.4, 0.4, 0.4, 0.4, 0.9,
            0.4, 0.4, 0.9, 0.9, 0.9, 0.9, 0.9,
            0.9, 0.9, 0.4, 0.4, 0.9, 0.9,
            0.9, 0.9, 0.9, 0.9, 0.4, 0.9, 0.9, 0.9,
            0.9, 0.9, 0.4, 0.9,
            0.9, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.9,
            0.9, 0.4, 0.4, 0.9, 0.9, 0.9,
            0.9, 2.0  -- final note held longer
        }
    },
    ["Blue Bird - Naruto"] = {
        keys = {"F", "J", "K", "L", "K", "J", "F", "J", "K", "L", "Z", "L", "Z", "X", "F", "J", "K", "L", "K", "J", "J", "X", "Z", "J", "X", "Z", "H", "H", "J", "J", "F", "J", "K", "L", "F", "L", "K", "J", "H", "J", "S", "D", "F", "F", "F", "G", "H", "J", "H", "H", "H", "H", "J", "K", "L", "K", "F", "J", "K", "L", "F", "L", "K", "J", "H", "J", "S", "D", "F", "F", "F", "G", "L", "K", "J", "H", "H", "J", "F", "J", "K", "L", "L", "K", "L", "K", "F", "K", "L", "Z", "Z", "L", "K", "J", "J", "L", "Z", "X", "J", "L", "Z", "X", "X", "V", "C", "X", "X", "F", "J", "K", "L", "K", "J", "F", "J", "K", "L", "Z", "L", "Z", "X", "F", "J", "K", "L", "K", "J", "J", "X", "Z", "J", "X", "Z", "H", "H", "J", "J", "F", "J", "K", "L", "K", "J", "F", "J", "K", "L", "Z", "L", "Z", "X", "F", "J", "K", "L", "K", "J", "J", "X", "Z", "J", "X", "Z", "H", "H", "J", "J", "J", "X", "Z", "J", "X", "Z", "H", "H", "J", "J", "J", "X", "Z", "J", "X", "Z", "H", "H", "J", "J"},
        timings = {0.3, 0.3, 0.3, 0.3, 0.2, 0.3, 0.4, 0.3, 0.3, 0.3, 0.3, 0.2, 0.3, 0.3, 0.4, 0.3, 0.3, 0.3, 0.3, 0.2, 0.3, 0.4, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.6, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.4, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.4, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.2, 0.4, 0.3, 0.3, 0.3, 0.3, 0.2, 0.3, 0.4, 0.3, 0.3, 0.3, 0.3, 0.2, 0.3, 0.3, 0.4, 0.3, 0.3, 0.3, 0.3, 0.2, 0.3, 0.4, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.6, 0.3, 0.3, 0.3, 0.3, 0.2, 0.3, 0.4, 0.3, 0.3, 0.3, 0.3, 0.2, 0.3, 0.3, 0.4, 0.3, 0.3, 0.3, 0.3, 0.2, 0.3, 0.4, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.6, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.6, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.6}
    },
    ["Naruto - Alone"] = {
        keys = {"F", "Q", "W", "T", "D", "Nine", "W", "R", "F", "S", "Zero", "E", "R", "T", "E", "W", "R", "Q", "J", "Eight", "E", "T", "W", "H", "Nine", "W", "R", "J", "F", "E", "Zero", "E", "R", "T", "E", "Zero", "Eight", "T", "F", "W", "T", "U", "D", "Seven", "Nine", "W", "H", "Nine", "S", "Six", "Zero", "E", "R", "T", "E", "U", "R", "Q", "J", "Eight", "E", "T", "W", "K", "Nine", "R", "H", "Nine", "J", "E", "Zero", "E", "R", "T", "S", "Q", "J", "Eight", "E", "Q", "T", "Q", "L", "I", "G", "Q", "W", "K", "D", "Nine", "W", "R", "O", "Nine", "W", "H", "A", "Nine", "S", "Q", "J", "Eight", "E", "Q", "T", "Q", "L", "I", "G", "Q", "W", "K", "D", "Nine", "W", "R", "O", "Nine", "W", "Nine", "S", "Q", "J", "Eight", "E", "Q", "T", "Q", "L", "I", "G", "Q", "W", "K", "D", "Nine", "W", "R", "O", "R", "K", "W", "L", "Z", "Q", "L", "J", "G", "Eight", "E", "T", "I", "Q", "L", "Z", "E", "X", "Q", "W", "H", "Z", "R", "Y", "V", "O", "T", "S", "F", "W", "T", "U", "W", "D", "A", "Nine", "W", "Y", "F", "S", "P", "Six", "Zero", "E", "R", "T", "E", "W", "R", "Q", "J", "G", "Eight", "E", "T", "W", "H", "D", "Nine", "W", "R", "J", "S", "F", "E", "Zero", "E", "R", "T", "Zero", "U", "Zero", "S", "F", "Eight", "W", "T", "U", "D", "A", "Seven", "Nine", "W", "R", "H", "S", "P", "Six", "Zero", "E", "R", "T", "E", "W", "R", "Q", "J", "G", "Eight", "E", "T", "W", "K", "H", "Nine", "R", "H", "Nine", "J", "F", "E", "Zero", "E", "R", "T", "E", "Zero", "Six", "Q", "J", "G", "Eight", "E", "Q", "W", "K", "H", "Nine", "W", "R", "H", "J", "F", "E", "Zero", "E", "R", "T", "Zero", "U", "Zero", "Q", "J", "G", "Eight", "E", "Q", "W", "K", "H", "Nine", "W", "R", "H", "S", "J", "F", "Six", "Zero", "E", "Zero", "T", "Zero", "E", "Zero", "F", "E", "T", "J", "U", "L"},
        timings = {0.5, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.6, 0.5, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.5, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.6, 0.5, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3}
    },
    ["Ocean Eyes - Billie Eilish"] = {
        keys = {"Eight", "F", "Nine", "D", "Zero", "A", "Eight", "F", "Nine", "D", "Zero", "A", "Eight", "F", "Nine", "D", "Zero", "A", "W", "A", "Nine", "D", "Zero", "U", "Eight", "F", "Nine", "D", "Zero", "A", "P", "O", "Eight", "F", "Nine", "D", "Zero", "A", "Eight", "F", "Nine", "D", "Zero", "A", "P", "O", "P", "W", "A", "Zero", "D", "Zero", "U", "Eight", "F", "Nine", "D", "Zero", "A", "P", "O", "Eight", "F", "Nine", "D", "Zero", "S", "A", "Eight", "F", "Nine", "D", "Zero", "A", "P", "O", "P", "W", "A", "Nine", "D", "Zero", "U", "A", "O", "Eight", "Nine", "Zero", "P", "O", "Eight", "P", "O", "Nine", "Zero", "U", "U", "Eight", "A", "A", "A", "Nine", "P", "P", "P", "O", "Zero", "U", "U", "O", "O", "P", "W", "A", "Nine", "D", "Zero", "A", "A", "O", "Eight", "Nine", "Zero", "P", "O", "Eight", "P", "O", "Nine", "Zero", "U", "U", "Eight", "A", "A", "A", "Nine", "P", "P", "O", "Zero", "U", "U", "O", "O", "P", "W", "A", "Nine", "D", "Zero", "A", "P", "W", "A", "Nine", "D", "Zero", "F"},
        timings = {0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.8, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.8, 0.3, 0.3, 0.5, 0.5, 0.5, 0.5, 0.5, 0.8, 0.5, 0.5, 0.5, 0.5, 0.5, 0.8, 0.3, 0.3, 0.3, 0.5, 0.5, 0.5, 0.5, 0.5, 0.8, 0.5, 0.5, 0.5, 0.5, 0.5, 0.8, 0.3, 0.3, 0.5, 0.5, 0.5, 0.5, 0.5, 0.3, 0.3, 0.5, 0.5, 0.5, 0.5, 0.5, 0.8, 0.3, 0.3, 0.3, 0.5, 0.5, 0.5, 0.5, 0.5, 0.8, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.5, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.5, 0.5, 0.5, 0.5, 0.5, 0.8, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.5, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.5, 0.5, 0.5, 0.5, 0.5, 0.8, 0.3, 0.5, 0.5, 0.5, 0.5, 0.5}
    },
    ["Ylang Ylang - FKJ"] = {
        keys = {"F", "J", "F", "L", "J", "F", "D", "L", "F", "J", "L", "L", "G", "D", "L", "G", "D", "F", "L", "D", "J", "C", "G", "C", "L", "G", "J", "G", "J", "K", "D", "C", "G", "D", "C", "G", "K", "D", "J", "C", "L", "G", "L", "D", "L", "J", "F", "J", "F", "L", "J", "F", "D", "L", "F", "J", "K", "G", "D", "L", "D", "J", "C", "G", "C", "L", "G", "J", "G", "J", "K", "D", "C", "G", "D", "C", "G", "K", "D", "J", "C", "L", "G", "G", "L", "F", "L", "J", "L", "G", "D", "G", "L", "F", "L", "J", "L", "K", "G", "F", "D", "C", "D", "J", "G", "L", "G", "J", "D", "J", "G", "L", "G", "J", "C", "D", "J", "G", "L", "G", "J", "D", "J", "G", "L", "G", "J", "C", "D", "J", "G", "L", "G", "J", "C"},
        timings = {0.5, 0.3, 0.3, 0.3, 0.5, 0.5, 0.3, 0.3, 0.5, 0.5, 0.8, 0.3, 0.3, 0.5, 0.3, 0.3, 0.5, 0.3, 0.3, 0.5, 0.5, 0.3, 0.3, 0.5, 0.3, 0.3, 0.3, 0.3, 0.3, 0.5, 0.3, 0.3, 0.3, 0.5, 0.3, 0.3, 0.3, 0.5, 0.3, 0.3, 0.3, 0.3, 0.8, 0.8, 0.3, 0.3, 0.3, 0.5, 0.3, 0.3, 0.3, 0.5, 0.3, 0.3, 0.5, 0.5, 0.8, 0.3, 0.3, 0.5, 0.3, 0.3, 0.5, 0.3, 0.3, 0.5, 0.3, 0.3, 0.3, 0.3, 0.3, 0.5, 0.3, 0.3, 0.3, 0.5, 0.3, 0.3, 0.3, 0.5, 0.3, 0.3, 0.3, 0.8, 0.8, 0.3, 0.3, 0.3, 0.8, 0.3, 0.3, 0.3, 0.8, 0.3, 0.3, 0.3, 0.8, 0.3, 0.3, 0.5, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3}
    }
}
local isPlaying = false
local currentSong = nil

local function playSong(songName)
    if isPlaying then 
        statusLabel.Text = "Already playing..."
        return 
    end
    
    local song = songs[songName]
    if not song then
        statusLabel.Text = "Song not found"
        return
    end
    
    isPlaying = true
    currentSong = songName
    statusLabel.Text = "Playing: " .. songName
    
    spawn(function()
        for i = 1, #song.keys do
            if not isPlaying then break end
            
            local key = song.keys[i]
            local timing = song.timings[i] or 0.5
            
            statusLabel.Text = songName .. " - " .. i .. "/" .. #song.keys
            
            -- Check if it's a chord (table) or single key (string)
            if type(key) == "table" then
                pressChord(key)
            else
                pressKey(key)
            end
            
            wait(timing)
        end
        
        if isPlaying then
            statusLabel.Text = songName .. " finished"
            wait(2)
            statusLabel.Text = "Ready"
        end
        
        isPlaying = false
        currentSong = nil
    end)
end

local function stopSong()
    if isPlaying then
        isPlaying = false
        statusLabel.Text = "Stopped"
        wait(1)
        statusLabel.Text = "Ready"
    end
end

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -110)
scrollFrame.Position = UDim2.new(0, 10, 0, 65)
scrollFrame.BackgroundColor3 = Color3.new(0, 0, 0)
scrollFrame.BackgroundTransparency = 0.9
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.new(0.3, 0.3, 0.3)
scrollFrame.ScrollBarImageTransparency = 0.7
scrollFrame.Parent = mainFrame

local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 5)
scrollCorner.Parent = scrollFrame

local songNames = {}
for songName, _ in pairs(songs) do
    table.insert(songNames, songName)
end
table.sort(songNames)

local buttonHeight = 20
local buttonSpacing = 25
local contentHeight = (#songNames * buttonSpacing) + 50

scrollFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight)

for i, songName in ipairs(songNames) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, buttonHeight)
    button.Position = UDim2.new(0, 5, 0, (i-1) * buttonSpacing + 5)
    button.BackgroundColor3 = Color3.new(0, 0, 0)
    button.BackgroundTransparency = 0.8
    button.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    button.Text = songName
    button.TextSize = 10
    button.Font = Enum.Font.Gotham
    button.BorderSizePixel = 0
    button.Parent = scrollFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 5)
    buttonCorner.Parent = button
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.new(0.3, 0.3, 0.3)
    buttonStroke.Transparency = 0.8
    buttonStroke.Thickness = 1
    buttonStroke.Parent = button
    
    button.MouseButton1Click:Connect(function()
        playSong(songName)
    end)
    
    button.MouseEnter:Connect(function()
        button.BackgroundTransparency = 0.6
        button.TextColor3 = Color3.new(1, 1, 1)
        buttonStroke.Transparency = 0.4
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundTransparency = 0.8
        button.TextColor3 = Color3.new(0.7, 0.7, 0.7)
        buttonStroke.Transparency = 0.8
    end)
end

local controlFrame = Instance.new("Frame")
controlFrame.Size = UDim2.new(1, -20, 0, 25)
controlFrame.Position = UDim2.new(0, 10, 1, -35)
controlFrame.BackgroundTransparency = 1
controlFrame.Parent = mainFrame

local stopButton = Instance.new("TextButton")
stopButton.Size = UDim2.new(0.48, 0, 1, 0)
stopButton.Position = UDim2.new(0, 0, 0, 0)
stopButton.BackgroundColor3 = Color3.new(0, 0, 0)
stopButton.BackgroundTransparency = 0.7
stopButton.TextColor3 = Color3.new(0.8, 0.5, 0.5)
stopButton.Text = "Stop"
stopButton.TextSize = 10
stopButton.Font = Enum.Font.Gotham
stopButton.BorderSizePixel = 0
stopButton.Parent = controlFrame

local stopCorner = Instance.new("UICorner")
stopCorner.CornerRadius = UDim.new(0, 5)
stopCorner.Parent = stopButton

local stopStroke = Instance.new("UIStroke")
stopStroke.Color = Color3.new(0.4, 0.2, 0.2)
stopStroke.Transparency = 0.7
stopStroke.Thickness = 1
stopStroke.Parent = stopButton

stopButton.MouseButton1Click:Connect(function()
    stopSong()
end)

stopButton.MouseEnter:Connect(function()
    stopButton.BackgroundTransparency = 0.5
    stopButton.TextColor3 = Color3.new(1, 0.7, 0.7)
    stopStroke.Transparency = 0.3
end)

stopButton.MouseLeave:Connect(function()
    stopButton.BackgroundTransparency = 0.7
    stopButton.TextColor3 = Color3.new(0.8, 0.5, 0.5)
    stopStroke.Transparency = 0.7
end)

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.48, 0, 1, 0)
closeButton.Position = UDim2.new(0.52, 0, 0, 0)
closeButton.BackgroundColor3 = Color3.new(0, 0, 0)
closeButton.BackgroundTransparency = 0.7
closeButton.TextColor3 = Color3.new(0.7, 0.7, 0.7)
closeButton.Text = "Close"
closeButton.TextSize = 10
closeButton.Font = Enum.Font.Gotham
closeButton.BorderSizePixel = 0
closeButton.Parent = controlFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5)
closeCorner.Parent = closeButton

local closeStroke = Instance.new("UIStroke")
closeStroke.Color = Color3.new(0.3, 0.3, 0.3)
closeStroke.Transparency = 0.7
closeStroke.Thickness = 1
closeStroke.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    if isPlaying then
        isPlaying = false
    end
    screenGui:Destroy()
end)

closeButton.MouseEnter:Connect(function()
    closeButton.BackgroundTransparency = 0.5
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeStroke.Transparency = 0.3
end)

closeButton.MouseLeave:Connect(function()
    closeButton.BackgroundTransparency = 0.7
    closeButton.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    closeStroke.Transparency = 0.7
end)
