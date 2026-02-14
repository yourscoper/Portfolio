if getgenv().ScopersCMDLoaded or getgenv().ScopersCMDDebug then
    return
end

pcall(function()
    getgenv().ScopersCMDLoaded = true
end)

local Storage         = game:GetService("ReplicatedStorage");
local InputService    = game:GetService("UserInputService");
local TextChatService = game:GetService("TextChatService");
local TeleportService = game:GetService("TeleportService");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local TweenService    = game:GetService("TweenService");
local SoundService    = game:GetService("SoundService");
local HttpService     = game:GetService("HttpService");
local RunService      = game:GetService("RunService");
local Workspace       = game:GetService("Workspace");
local CoreGui         = game:GetService("CoreGui");
local Players         = game:GetService("Players");

local CurrentCamera   = Workspace.CurrentCamera
local Terrain         = Workspace.Terrain
local Camera          = Workspace.Camera

local Player          = Players.LocalPlayer
local Mouse           = Player:GetMouse();
local PlayerScripts   = Player.PlayerScripts
local PlayerModule    = PlayerScripts.PlayerModule
local CameraModule    = PlayerModule.CameraModule
local ControlModule   = PlayerModule.ControlModule
local Controls        = require(ControlModule);
local ZoomController  = CameraModule.ZoomController
local Popper          = ZoomController.Popper
local GrabExit        = Storage:WaitForChild("GrabExit");

local setcons = (debug and debug.setconstant) or setconstant
local getcons = (debug and debug.getconstants) or getconstants

local Request = request or (http and http.request) or http_request or (fluxus and fluxus.request) or (syn and syn.request)

-- Functions

local function TweenUI(UserInterface, TargetPosition, Speed)
    if not UserInterface then return end
    
    local CPos = Vector2.new(UserInterface.Position.X.Scale, UserInterface.Position.Y.Scale)
    local TPos = Vector2.new(TargetPosition.X.Scale, TargetPosition.Y.Scale)
    local CDist = (TPos - CPos).Magnitude
    local CSpeed = CDist / Speed
    local CTween = TweenService:Create(UserInterface, TweenInfo.new(
        CSpeed, 
        Enum.EasingStyle.Linear
    ), {Position = TargetPosition})
    
    CTween:Play()
end

local Scoper_s_Login        = Instance.new("ScreenGui")
local LoginMain             = Instance.new("Frame")
local LoginMainCorner       = Instance.new("UICorner")
local LoginMainTitle        = Instance.new("TextLabel")
local LoginMainKey          = Instance.new("TextBox")
local LoginMainKeyCorner    = Instance.new("UICorner")
local LoginMainButton       = Instance.new("TextButton")
local LoginMainButtonCorner = Instance.new("UICorner")

Scoper_s_Login.Name = "Scoper's Login"
Scoper_s_Login.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Scoper_s_Login.ResetOnSpawn = false
Scoper_s_Login.Parent = CoreGui

LoginMain.Name = "LoginMain"
LoginMain.AnchorPoint = Vector2.new(0.5, 0.5)
LoginMain.Position = UDim2.new(0.5, 0, -0.4, 0)
LoginMain.Size = UDim2.new(0.2, 0, 0.35, 0)
LoginMain.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
LoginMain.BackgroundTransparency = 0.5
LoginMain.BorderSizePixel = 0
LoginMain.Parent = Scoper_s_Login

LoginMainCorner.CornerRadius = UDim.new(0.025, 0)
LoginMainCorner.Parent = LoginMain

LoginMainTitle.Name = "LoginMainTitle"
LoginMainTitle.Size = UDim2.new(1, 0, 0.1, 0)
LoginMainTitle.BackgroundTransparency = 1
LoginMainTitle.TextStrokeTransparency = 0.8
LoginMainTitle.Text = "Scoper's Login"
LoginMainTitle.TextColor3 = Color3.new(1, 1, 1)
LoginMainTitle.TextSize = 14
LoginMainTitle.Font = Enum.Font.Gotham
LoginMainTitle.TextScaled = true
LoginMainTitle.TextWrapped = true
LoginMainTitle.Parent = LoginMain

LoginMainKey.Name = "LoginMainKey"
LoginMainKey.Position = UDim2.new(0.25, 0, 0.5, 0)
LoginMainKey.Size = UDim2.new(0.5, 0, 0.1, 0)
LoginMainKey.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
LoginMainKey.BackgroundTransparency = 0.5
LoginMainKey.BorderSizePixel = 0
LoginMainKey.Text = ""
LoginMainKey.TextColor3 = Color3.new(1, 1, 1)
LoginMainKey.TextSize = 18
LoginMainKey.Font = Enum.Font.Gotham
LoginMainKey.TextWrapped = true
LoginMainKey.PlaceholderText = "Enter Key..."
LoginMainKey.PlaceholderColor3 = Color3.new(0.784314, 0.784314, 0.784314)
LoginMainKey.Parent = LoginMain

LoginMainKeyCorner.CornerRadius = UDim.new(0.25, 0)
LoginMainKeyCorner.Parent = LoginMainKey

LoginMainButton.Name = "LoginMainButton"
LoginMainButton.Position = UDim2.new(0.25, 0, 0.7, 0)
LoginMainButton.Size = UDim2.new(0.5, 0, 0.1, 0)
LoginMainButton.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
LoginMainButton.BackgroundTransparency = 0.25
LoginMainButton.BorderSizePixel = 0
LoginMainButton.Text = "Authenticate"
LoginMainButton.TextColor3 = Color3.new(1, 1, 1)
LoginMainButton.TextSize = 25
LoginMainButton.Font = Enum.Font.Gotham
LoginMainButton.TextWrapped = true
LoginMainButton.Parent = LoginMain

LoginMainButtonCorner.CornerRadius = UDim.new(0.25, 0)
LoginMainButtonCorner.Parent = LoginMainButton

TweenUI(LoginMain, UDim2.new(0.5, 0, 0.5, 0), 2.5)

local GetGetWhitelistData = nil
local GetUserFingerprint = nil

local Success, Error = pcall(function()
    if not Request then
        return
    end

    local WhitelistResponse = Request({
        Url = "https://yourscoper.vercel.app/api/whitelist",
        Method = "GET",
        Headers = {["Content-Type"] = "application/json"}
    })

    local HttpBodyResponse = Request({
        Url = "https://yourscoper.vercel.app/api/get",
        Method = "GET",
        Headers = {["Content-Type"] = "application/json"}
    })

    if WhitelistResponse.StatusCode ~= 200 or HttpBodyResponse.StatusCode ~= 200 then
        return
    end

    GetWhitelistData = HttpService:JSONDecode(WhitelistResponse.Body)
    local HttpBodyData = HttpService:JSONDecode(HttpBodyResponse.Body)

    for Integer, Variant in pairs(HttpBodyData.headers or {}) do
        if Integer:lower():find("fingerprint") then
            GetUserFingerprint = Variant
            break
        end
    end
end)

if not Success or not GetWhitelistData or not GetUserFingerprint then
    Player:Kick("Authentication system failed to load. Please rejoin and try again.")
    return
end

LoginMainButton.MouseButton1Click:Connect(function()
    local InsertedKey = LoginMainKey.Text:match("^%s*(.-)%s*$")

    if InsertedKey == "" then
        LoginMainKey.TextColor3 = Color3.fromRGB(255, 220, 100)
        LoginMainKey.Text = "Please enter a key"
        task.delay(1.8, function()
            if LoginMainKey and LoginMainKey.Parent then
                LoginMainKey.TextColor3 = Color3.fromRGB(255, 255, 255)
                LoginMainKey.Text = ""
            end
        end)
        return
    end

    local GetEntry = GetWhitelistData.whitelist and GetWhitelistData.whitelist[GetUserFingerprint]
    local keyExpectance = GetEntry and GetEntry.key

    if keyExpectance and InsertedKey == keyExpectance then
        TweenService:Create(LoginMain, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {BackgroundTransparency = 1}):Play()
        
        task.delay(0.7, function()
            if Scoper_s_Login and Scoper_s_Login.Parent then
                Scoper_s_Login:Destroy()
            end

            getgenv().ScopersCMD = {
                Prefix = ";",
                Server = {},
                CommandLabels = {};
                PrefixMap = {
                    ["-"] = Enum.KeyCode.Minus,
                    ["="] = Enum.KeyCode.Equals,
                    ["["] = Enum.KeyCode.LeftBracket,
                    ["]"] = Enum.KeyCode.RightBracket,
                    ["\\"] = Enum.KeyCode.BackSlash,
                    [";"] = Enum.KeyCode.Semicolon,
                    ["'"] = Enum.KeyCode.Quote,
                    [","] = Enum.KeyCode.Comma,
                    ["."] = Enum.KeyCode.Period,
                    ["/"] = Enum.KeyCode.Slash,
                    ["`"] = Enum.KeyCode.Backquote,
                    ["1"] = Enum.KeyCode.One,
                    ["2"] = Enum.KeyCode.Two,
                    ["3"] = Enum.KeyCode.Three,
                    ["4"] = Enum.KeyCode.Four,
                    ["5"] = Enum.KeyCode.Five,
                    ["6"] = Enum.KeyCode.Six,
                    ["7"] = Enum.KeyCode.Seven,
                    ["8"] = Enum.KeyCode.Eight,
                    ["9"] = Enum.KeyCode.Nine,
                    ["0"] = Enum.KeyCode.Zero
                },

                CommandTips = {
                    ["cmds / commands"] = "Opens the commands list GUI",
                    ["p / prefix"] = "Changes the command prefix",
                    ["rj / rejoin"] = "Rejoins the current server",
                    ["hop / serverhop"] = "Joins a different server",
                    ["tpt / teletool"] = "Gives you a teleport tool",
                    ["v / view (USER)"] = "View another player's camera",
                    ["unv / unview"] = "Return camera to yourself",
                    ["stare (USER)"] = "Makes your character stare at a player",
                    ["unstare"] = "Stop staring at a player",
                    ["to / goto (USER)"] = "Teleport instantly to a player",
                    ["tg / tweengoto (USER)"] = "Tween smoothly to a player",
                    ["f / follow (USER)"] = "Follow a player continuously",
                    ["uf / unfollower"] = "Stop following a player",
                    ["scare (USER)"] = "Teleport to a player briefly to scare them",
                    ["h / hide (USER)"] = "Hide a player's character",
                    ["unh / unhide (USER)"] = "Unhide a player's character",
                    ["mvc / mute (USER)"] = "Mute a player's voice",
                    ["umvc / unmute (USER)"] = "Unmute a player's voice",
                    ["pf / platform"] = "Generate a platform under you",
                    ["unpf / unplatform"] = "Remove the platform",
                    ["mid / middle"] = "Teleport to the middle of the map",
                    ["cavein"] = "Teleport to cave entrance",
                    ["caveout"] = "Teleport outside cave",
                    ["caveunder"] = "Teleport under the cave",
                    ["fly / unfly (NUMBER)"] = "Fly like superman",
                    ["unfly"] = "Unfly",
                    ["ws / speed (NUMBER)"] = "Change the value of your speed, if 0 then disables velocity speed",
                    ["re / refresh"] = "Refreshes your character and respawns in the spot you executed the command",
                    ["noclip"] = "Turns on noclip to phase through collision based parts",
                    ["clip"] = "Turns off noclip to phase through collision based parts",
                    ["ncam / noclipcamera"] = "Toggle camera collision for view",
                    ["xray"] = "Toggle X-Ray",
                    ["fc / fcam / freecamera (NUMBER)"] = "Enables free camera movement",
                    ["unfc / unfcam / nofreecamera"] = "Disables free camera movement",
                    ["dex / darkdex"] = "Loads dark dex",
                    ["timer (NUMBER)"] = "Starts timer for a duration of minutes you want",
                    ["anf / antifollow"] = "Prevents an exploiter from following you and kills them",
                    ["creep"] = "Enables a custom creepy animation",
                    ["uncreep"] = "Disables a custom creepy animation",
                    ["bv / breakvelocity"] = "Breaks character velocity and cleans up body velocity's",
                    ["s / spin (NUMBER)"] = "Spins your character to a value you prefer",
                    ["uns / unspin"] = "Unspins your character"
                },

                CommandOffset = Vector2.new(5, 5),
                
                MapSettings = {
                    Cave = {
                        In = CFrame.new(-177.5, 4, 72175),
                        Out = CFrame.new(-200, 4, 72200),
                        Under = CFrame.new(-200, -5, 72200)
                    },

                    Main = {
                        Middle = CFrame.new(2, 4.1, -482)
                    },

                    XRay = false
                },

                PlayerSettings = {
                    Speed = {
                        Enabled = false,
                        Value = 16
                    }
                },

                FlySettings = {
                    Flying = false,
                    Speed = 1,
                    Controls = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0},
                    BodyVelocity = nil,
                    BodyGyro = nil,
                    FlySignal = nil,
                    DiedConnection = nil
                },

                FreeCameraSettings = {
                    Enabled = false,
                    Speed = 1,
                    Fast = 5,
                    Slow = 0.5,
                    Rotation = Vector2.new(0, 0),
                    Connections = {}
                },

                Animations = {
                    Tracks = {},
                    IDs = {
                        idle     = "rbxassetid://81694095869045",  -- Idle (Weird Creature Dog)
                        walk     = "rbxassetid://71303649590318",  -- Walking Animation
                        run      = "rbxassetid://128364104022657", -- Running Animation
                        fall     = "rbxassetid://70714089777566",  -- Falling Animation
                        jump     = "rbxassetid://70714089777566"  -- Jumping Animation
                    },

                    Track = nil,
                    Speed = 0,
                    IsCustomActive = false,
                    Connections = {},
                    OriginalAnimate = nil
                }
            }

            local StareLoop, TweenGotoLoop, FollowLoop, HideLoop, MuteVCLoop, ViewLoop, NoClipLoop

            function ScopersNotification(parent, titleText, descriptionText, duration)
                if parent:FindFirstChild("Notification") then
                    parent:FindFirstChild("Notification"):Destroy()
                end

                local Notification = Instance.new("Frame")
                local NotificationCorner = Instance.new("UICorner")
                local Title = Instance.new("TextLabel")
                local Description = Instance.new("TextLabel")
                local Timer = Instance.new("Frame")
                local TimerCorner = Instance.new("UICorner")

                Notification.Name = "Notification"
                Notification.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                Notification.BackgroundTransparency = 0.5
                Notification.BorderSizePixel = 0
                Notification.Position = UDim2.new(1, 0, 0.875, 0)
                Notification.Size = UDim2.new(0.15, 0, 0.1, 0)
                Notification.Parent = parent

                NotificationCorner.CornerRadius = UDim.new(0.1, 0)
                NotificationCorner.Parent = Notification

                Title.Name = "Title"
                Title.Parent = Notification
                Title.BackgroundTransparency = 1
                Title.Size = UDim2.new(1, 0, 0.15, 0)
                Title.Font = Enum.Font.Gotham
                Title.Text = titleText
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.TextScaled = true
                Title.TextWrapped = true

                Description.Name = "Description"
                Description.Parent = Notification
                Description.BackgroundTransparency = 1
                Description.Size = UDim2.new(1, 0, 0.4, 0)
                Description.Position = UDim2.new(0, 0, 0.3, 0)
                Description.Font = Enum.Font.Gotham
                Description.Text = descriptionText
                Description.TextColor3 = Color3.fromRGB(255, 255, 255)
                Description.TextSize = 22
                Description.TextWrapped = true
                
                Timer.Name = "Timer"
                Timer.Parent = Notification
                Timer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Timer.BackgroundTransparency = 0.25
                Timer.BorderSizePixel = 0
                Timer.Position = UDim2.new(0, 0, 0.95, 0)
                Timer.Size = UDim2.new(1, 0, 0.05, 0)

                TimerCorner.CornerRadius = UDim.new(1, 0)
                TimerCorner.Parent = Timer

                TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.835, 0, 0.875, 0)}):Play()

                local StartTick = tick()
                local EndTick = StartTick + duration

                local NotificationConnection
                
                NotificationConnection = RunService.RenderStepped:Connect(function()
                    local CurrentTick = tick()
                    local Progression = math.clamp((CurrentTick - StartTick) / duration, 0, 1)

                    Timer.Size = UDim2.new(1 - Progression, 0, 0.05, 0)
                    Timer.Position = UDim2.new(0, 0, 0.95, 0)

                    if CurrentTick >= EndTick then
                        NotificationConnection:Disconnect()

                        TweenService:Create(
                            Notification,
                            TweenInfo.new(0.5, Enum.EasingStyle.Linear),
                            { Position = UDim2.new(1, 0, 0.875, 0) }
                        ):Play()

                        task.delay(0.5, function()
                            Notification:Destroy()
                        end)
                    end
                end)
            end

            function ScopersTimerNotification(parent, titleText, descriptionText, duration)
                if parent:FindFirstChild("NotificationV2") then
                    parent:FindFirstChild("NotificationV2"):Destroy()
                end

                local Notification = Instance.new("Frame")
                local NotificationCorner = Instance.new("UICorner")
                local Title = Instance.new("TextLabel")
                local Description = Instance.new("TextLabel")
                local Timer = Instance.new("Frame")
                local TimerCorner = Instance.new("UICorner")

                Notification.Name = "NotificationV2"
                Notification.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                Notification.BackgroundTransparency = 0.5
                Notification.BorderSizePixel = 0
                Notification.Position = UDim2.new(1, 0, 0.875, 0)
                Notification.Size = UDim2.new(0.15, 0, 0.1, 0)
                Notification.Parent = parent

                NotificationCorner.CornerRadius = UDim.new(0.1, 0)
                NotificationCorner.Parent = Notification

                Title.Name = "Title"
                Title.Parent = Notification
                Title.BackgroundTransparency = 1
                Title.Size = UDim2.new(1, 0, 0.15, 0)
                Title.Font = Enum.Font.Gotham
                Title.Text = titleText
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.TextScaled = true
                Title.TextWrapped = true

                Description.Name = "Description"
                Description.Parent = Notification
                Description.BackgroundTransparency = 1
                Description.Size = UDim2.new(1, 0, 0.4, 0)
                Description.Position = UDim2.new(0, 0, 0.3, 0)
                Description.Font = Enum.Font.Gotham
                Description.Text = descriptionText
                Description.TextColor3 = Color3.fromRGB(255, 255, 255)
                Description.TextSize = 22
                Description.TextWrapped = true

                Timer.Name = "Timer"
                Timer.Parent = Notification
                Timer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Timer.BackgroundTransparency = 0.25
                Timer.BorderSizePixel = 0
                Timer.Position = UDim2.new(0, 0, 0.95, 0)
                Timer.Size = UDim2.new(1, 0, 0.05, 0)

                TimerCorner.CornerRadius = UDim.new(1, 0)
                TimerCorner.Parent = Timer

                TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.835, 0, 0.875, 0)}):Play()

                local StartTick = tick()
                local EndTick = StartTick + duration

                local NotificationConnection
                
                NotificationConnection = RunService.RenderStepped:Connect(function()
                    local CurrentTick = tick()
                    local Progression = math.clamp((CurrentTick - StartTick) / duration, 0, 1)

                    Timer.Size = UDim2.new(1 - Progression, 0, 0.05, 0)
                    Timer.Position = UDim2.new(0, 0, 0.95, 0)

                    local Remaining = math.max(0, EndTick - CurrentTick)
                    
                    Description.Text = string.format("Timer: %02d:%02d", math.floor(Remaining / 60), Remaining % 60)

                    if CurrentTick >= EndTick then
                        NotificationConnection:Disconnect()

                        TweenService:Create(
                            Notification,
                            TweenInfo.new(0.5, Enum.EasingStyle.Linear),
                            { Position = UDim2.new(1, 0, 0.875, 0) }
                        ):Play()

                        task.delay(0.5, function()
                            Notification:Destroy()
                        end)
                    end
                end)
            end

            local function VoiceChatTimer(timeArg)
                if not timeArg then return end

                local GetNumber, GetUnit = timeArg:match("^(%d+)([smh]?)$")
                if not GetNumber then return end

                local GetDuration = tonumber(GetNumber)
                if GetUnit == "m" then
                    GetDuration = GetDuration * 60
                elseif GetUnit == "h" then
                    GetDuration = GetDuration * 3600
                elseif GetUnit == "s" or GetUnit == "" then
                else
                    return
                end

                local function FormatTime(GetSeconds)
                    local GetMinutes = math.floor(GetSeconds / 60)
                    local ReturnSeconds = GetSeconds % 60
                    return string.format("%02d:%02d", GetMinutes, ReturnSeconds)
                end

                ScopersTimerNotification(
                    CoreGui:FindFirstChild("ScopersCommands"),
                    "Voice Chat Timer",
                    "Timer: " .. FormatTime(GetDuration),
                    GetDuration
                )

                task.spawn(function()
                    local GetRemain = GetDuration
                    while GetRemain > 0 do
                        task.wait(1)
                        GetRemain = GetRemain - 1
                    end

                    task.delay(1, function()
                        ScopersNotification(
                            CoreGui:FindFirstChild("ScopersCommands"),
                            "Voice Chat Timer",
                            "Rejoin for Voice-Chat!",
                            4
                        )
                    end)

                    -- ServerRejoin() -- Remove Comment if you want it to auto rejoin when timer is done.
                end)
            end

            function FilterCommands(Parameter)
                Parameter = Parameter:lower()

                for _, GetLabel in ipairs(getgenv().ScopersCMD.CommandLabels) do
                    if GetLabel.Text:lower():find(Parameter) then
                        GetLabel.Visible = true
                    else
                        GetLabel.Visible = false
                    end
                end
            end

            function Shorten(Parameter)
                local PlayerList = {}
                for _, Search in pairs(Players:GetPlayers()) do
                    if Search.Name:lower():sub(1, #Parameter) == Parameter:lower() or Search.DisplayName:lower():sub(1, #Parameter) == Parameter:lower() then
                        table.insert(PlayerList, Search)
                    end
                end
                return PlayerList
            end

            local function ScopersAnimationSetup()
                local function AnimateToTrack(Parameter)
                    local GetObjects = game:GetObjects(Parameter)
                    for Iter = 1, #GetObjects do
                        if GetObjects[Iter]:IsA("Animation") then
                            return GetObjects[Iter].AnimationId
                        end
                    end
                    return Parameter
                end

                function StopAnimations(Human)
                    for _, Variant in next, Human:GetPlayingAnimationTracks() do
                        Variant:Stop()
                    end
                end

                local Character = Player.Character
                if not Character then return end

                local Humanoid = Character:FindFirstChild("Humanoid")
                if not Humanoid then return end

                local Animator = Humanoid:FindFirstChild("Animator")
                if not Animator then return end

                if not getgenv().ScopersCMD.Animations.OriginalAnimate then
                    local orig = Character:FindFirstChild("Animate")
                    if orig and orig:IsA("LocalScript") then
                        getgenv().ScopersCMD.Animations.OriginalAnimate = orig:Clone()
                    end
                end

                if next(getgenv().ScopersCMD.Animations.Tracks) == nil then
                    for IntegerName, VariantId in pairs(getgenv().ScopersCMD.Animations.IDs) do
                        local BypassedId = AnimateToTrack(VariantId)
                        local ScopersAnimation = Instance.new("Animation")
                        ScopersAnimation.AnimationId = BypassedId
                        getgenv().ScopersCMD.Animations.Tracks[IntegerName] = Animator:LoadAnimation(ScopersAnimation)
                    end

                    getgenv().ScopersCMD.Animations.Tracks.idle.Priority = Enum.AnimationPriority.Idle
                    getgenv().ScopersCMD.Animations.Tracks.walk.Priority = Enum.AnimationPriority.Movement
                    getgenv().ScopersCMD.Animations.Tracks.run.Priority  = Enum.AnimationPriority.Movement
                    getgenv().ScopersCMD.Animations.Tracks.jump.Priority = Enum.AnimationPriority.Movement
                    getgenv().ScopersCMD.Animations.Tracks.fall.Priority = Enum.AnimationPriority.Movement
                end

                local function KillAnimate()
                    local AnimationScript = Character:FindFirstChild("Animate")
                    if AnimationScript then
                        AnimationScript:Destroy()
                    end
                end

                local function RestoreDefaultAnimate()
                    KillAnimate()
                    StopAnimations(Humanoid)

                    if getgenv().ScopersCMD.Animations.OriginalAnimate then
                        local clone = getgenv().ScopersCMD.Animations.OriginalAnimate:Clone()
                        clone.Parent = Character
                        clone.Disabled = false
                    end

                    for _, track in pairs(getgenv().ScopersCMD.Animations.Tracks) do
                        if track.IsPlaying then
                            track:Stop(0.2)
                        end
                    end
                    getgenv().ScopersCMD.Animations.Track = nil
                end

                local function EndureTrack(name, fadeTime)
                    fadeTime = fadeTime or 0.2
                    
                    if getgenv().ScopersCMD.Animations.Track and getgenv().ScopersCMD.Animations.Track ~= getgenv().ScopersCMD.Animations.Tracks[name] then
                        getgenv().ScopersCMD.Animations.Track:Stop(fadeTime)
                    end
                    
                    local track = getgenv().ScopersCMD.Animations.Tracks[name]
                    if track then
                        track:Play(fadeTime)
                        getgenv().ScopersCMD.Animations.Track = track
                    end
                end

                local function UpdateMovement(speed)
                    if Humanoid:GetState() == Enum.HumanoidStateType.Dead then return end
                    
                    getgenv().ScopersCMD.Animations.Speed = speed
                    
                    if speed > 0.1 then
                        if speed > 16 then
                            getgenv().ScopersCMD.Animations.Tracks.run:AdjustSpeed(7)
                            EndureTrack("run")
                        else
                            getgenv().ScopersCMD.Animations.Tracks.run:AdjustSpeed(1)
                            EndureTrack("walk")
                        end
                    else
                        if getgenv().ScopersCMD.Animations.Track ~= getgenv().ScopersCMD.Animations.Tracks.idle then
                            EndureTrack("idle")
                        end
                    end
                end

                local function EnableCustom()
                    if getgenv().ScopersCMD.Animations.IsCustomActive then return end
                    
                    KillAnimate()
                    StopAnimations(Humanoid)

                    for _, conn in ipairs(getgenv().ScopersCMD.Animations.Connections) do
                        conn:Disconnect()
                    end
                    getgenv().ScopersCMD.Animations.Connections = {}

                    table.insert(getgenv().ScopersCMD.Animations.Connections, Humanoid.Running:Connect(function(speed)
                        UpdateMovement(speed)
                    end))

                    table.insert(getgenv().ScopersCMD.Animations.Connections, Humanoid.StateChanged:Connect(function(CheckState)
                        if CheckState == Enum.HumanoidStateType.Freefall then
                            EndureTrack("fall", 0.15)
                        elseif CheckState == Enum.HumanoidStateType.Landed then
                            task.delay(0.1, function()
                                if Humanoid and Humanoid.Parent then
                                    if getgenv().ScopersCMD.PlayerSettings.Speed.Value > 0 then
                                        UpdateMovement(getgenv().ScopersCMD.PlayerSettings.Speed.Value)
                                    else
                                        UpdateMovement(Humanoid.WalkSpeed)
                                    end
                                end
                            end)
                        end
                    end))

                    task.wait(0.1)
                    EndureTrack("idle")
                    getgenv().ScopersCMD.Animations.IsCustomActive = true
                end

                local function DisableCustom()
                    if not getgenv().ScopersCMD.Animations.IsCustomActive then return end
                    
                    for _, conn in ipairs(getgenv().ScopersCMD.Animations.Connections) do
                        conn:Disconnect()
                    end
                    getgenv().ScopersCMD.Animations.Connections = {}

                    RestoreDefaultAnimate()
                    getgenv().ScopersCMD.Animations.IsCustomActive = false
                end

                getgenv().ToggleScopersCustomAnimation = function()
                    if getgenv().ScopersCMD.Animations.IsCustomActive then
                        DisableCustom()
                    else
                        EnableCustom()
                    end
                end
            end

            function ServerRejoin()
                pcall(function()
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
                end)
            end

            function ServerHop()
                pcall(function()
                    if Request then
                        local Servers = {}
                        local success, GetRequest = pcall(function()
                            return Request({
                                Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.PlaceId)
                            })
                        end)
                    
                        if success and GetRequest and GetRequest.Body then
                            local successDecode, Body = pcall(function()
                                return HttpService:JSONDecode(GetRequest.Body)
                            end)
                    
                            if successDecode and Body and Body.data then
                                for _, Variant in ipairs(Body.data) do
                                    if type(Variant) == "table" and tonumber(Variant.playing) and tonumber(Variant.maxPlayers) and Variant.playing < Variant.maxPlayers and Variant.id ~= game.JobId then
                                        table.insert(Servers, Variant.id)
                                    end
                                end
                            end
                        end
                    
                        if #Servers > 0 then
                            TeleportService:TeleportToPlaceInstance(game.PlaceId, Servers[math.random(1, #Servers)], Player)
                        else
                            return
                        end
                    end
                end)
            end

            function XRay()
                for _, Parts in next, Workspace:GetDescendants() do
                    if Parts:IsA("BasePart") and not Parts.Parent:FindFirstChildWhichIsA("Humanoid") and not Parts.Parent.Parent:FindFirstChildWhichIsA("Humanoid") then
                        Parts.LocalTransparencyModifier = getgenv().ScopersCMD.MapSettings.XRay and 0.75 or 0
                    end
                end
            end

            function StartFreeCamera()
                Player.DevEnableMouseLock = false

                if getgenv().ScopersCMD.FreeCameraSettings.Enabled then
                    return
                end
                
                getgenv().ScopersCMD.FreeCameraSettings.Enabled = true

                Controls:Disable()

                Camera.CameraType = Enum.CameraType.Scriptable
                InputService.MouseBehavior = Enum.MouseBehavior.LockCenter

                table.insert(getgenv().ScopersCMD.FreeCameraSettings.Connections, InputService.InputChanged:Connect(function(Input, GameProcessed)
                    if GameProcessed or not getgenv().ScopersCMD.FreeCameraSettings.Enabled then
                        return
                    end

                    if Input.UserInputType == Enum.UserInputType.MouseMovement then
                        getgenv().ScopersCMD.FreeCameraSettings.Rotation -= Vector2.new(Input.Delta.y, Input.Delta.x) * 0.002
                        getgenv().ScopersCMD.FreeCameraSettings.Rotation = Vector2.new(
                            math.clamp(getgenv().ScopersCMD.FreeCameraSettings.Rotation.X, -math.pi / 2, math.pi / 2),
                            getgenv().ScopersCMD.FreeCameraSettings.Rotation.Y
                        )
                    end
                end))

                table.insert(getgenv().ScopersCMD.FreeCameraSettings.Connections, RunService.RenderStepped:Connect(function(Delta)
                    if not getgenv().ScopersCMD.FreeCameraSettings.Enabled then
                        return
                    end

                    local Speed = getgenv().ScopersCMD.FreeCameraSettings.Speed

                    if InputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        Speed *= getgenv().ScopersCMD.FreeCameraSettings.Fast
                    elseif InputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                        Speed *= getgenv().ScopersCMD.FreeCameraSettings.Slow
                    end

                    local moveDir = Vector3.zero

                    if InputService:GetFocusedTextBox() then return end
                    if InputService:IsKeyDown(Enum.KeyCode.W) then moveDir += Vector3.new(0, 0, -1) end
                    if InputService:IsKeyDown(Enum.KeyCode.S) then moveDir += Vector3.new(0, 0, 1) end
                    if InputService:IsKeyDown(Enum.KeyCode.A) then moveDir += Vector3.new(-1, 0, 0) end
                    if InputService:IsKeyDown(Enum.KeyCode.D) then moveDir += Vector3.new(1, 0, 0) end
                    if InputService:IsKeyDown(Enum.KeyCode.E) then moveDir += Vector3.new(0, 1, 0) end
                    if InputService:IsKeyDown(Enum.KeyCode.Q) then moveDir += Vector3.new(0, -1, 0) end

                    if moveDir.Magnitude > 0 then
                        moveDir = moveDir.Unit
                    end

                    local CameraCFrame = CFrame.new(Camera.CFrame.Position) * CFrame.Angles(0, getgenv().ScopersCMD.FreeCameraSettings.Rotation.Y, 0) * CFrame.Angles(getgenv().ScopersCMD.FreeCameraSettings.Rotation.X, 0, 0)

                    Camera.CFrame = CameraCFrame + CameraCFrame:VectorToWorldSpace(moveDir) * Speed * 50 * Delta
                end))
            end

            function StopFreeCamera()
                Player.DevEnableMouseLock = true

                if not getgenv().ScopersCMD.FreeCameraSettings.Enabled then
                    return
                end
                
                Controls:Enable()

                getgenv().ScopersCMD.FreeCameraSettings.Enabled = false

                Camera.CameraType = Enum.CameraType.Custom
                InputService.MouseBehavior = Enum.MouseBehavior.Default

                for _, Variant in ipairs(getgenv().ScopersCMD.FreeCameraSettings.Connections) do
                    Variant:Disconnect()
                end

                table.clear(getgenv().ScopersCMD.FreeCameraSettings.Connections)
            end

            function NoClipCamera()
                for _, Variant in pairs(getgc()) do
                    if type(Variant) == "function" and getfenv(Variant).script == Popper then
                        for Integer, Value in pairs(getcons(Variant)) do
                            if tonumber(Value) == .25 then
                                setcons(Variant, Integer, 0)
                            elseif tonumber(Value) == 0 then
                                setcons(Variant, Integer, .25)
                            end
                        end
                    end
                end
            end

            function NoClip()
                for _, Limbs in next, Player.Character:GetChildren() do
                    if Player.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
                        if Limbs:IsA("BasePart") then
                            Limbs.CanCollide = false
                        end
                    elseif Player.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
                        if Limbs:IsA("BasePart") or Limbs:IsA("MeshPart") then
                            Limbs.CanCollide = false
                        end
                    end
                end
            end

            function Clip()
                if Player.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
                    Player.Character.Torso.CanCollide = true
                elseif Player.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
                    Player.Character.UpperTorso.CanCollide = true
                    Player.Character.LowerTorso.CanCollide = true
                end
            end

            function Fly()
                if getgenv().ScopersCMD.FlySettings.Flying then return end

                if getgenv().ScopersCMD.FlySettings.DiedConnection then return end

                getgenv().ScopersCMD.FlySettings.Flying = true
                Player.Character.Humanoid.PlatformStand = true

                Controls:Disable()

                getgenv().ScopersCMD.FlySettings.BodyGyro = Instance.new("BodyGyro")
                getgenv().ScopersCMD.FlySettings.BodyGyro.Name = "ScopersFlyGyro"
                getgenv().ScopersCMD.FlySettings.BodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                getgenv().ScopersCMD.FlySettings.BodyGyro.P = 7000
                getgenv().ScopersCMD.FlySettings.BodyGyro.CFrame = Player.Character.HumanoidRootPart.CFrame
                getgenv().ScopersCMD.FlySettings.BodyGyro.Parent = Player.Character.HumanoidRootPart
                
                getgenv().ScopersCMD.FlySettings.BodyVelocity = Instance.new("BodyVelocity")
                getgenv().ScopersCMD.FlySettings.BodyVelocity.Name = "ScopersFlyVelocity"
                getgenv().ScopersCMD.FlySettings.BodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                getgenv().ScopersCMD.FlySettings.BodyVelocity.Velocity = Vector3.zero
                getgenv().ScopersCMD.FlySettings.BodyVelocity.Parent = Player.Character.HumanoidRootPart

                getgenv().ScopersCMD.FlySettings.FlySignal = RunService.RenderStepped:Connect(function()
                    pcall(function()
                        local moveDir = Vector3.new(
                            getgenv().ScopersCMD.FlySettings.Controls.R - getgenv().ScopersCMD.FlySettings.Controls.L,
                            getgenv().ScopersCMD.FlySettings.Controls.E - getgenv().ScopersCMD.FlySettings.Controls.Q,
                            getgenv().ScopersCMD.FlySettings.Controls.F - getgenv().ScopersCMD.FlySettings.Controls.B
                        )

                        if moveDir.Magnitude > 0 then
                            local moveVector = (CurrentCamera.CFrame.RightVector * moveDir.X + CurrentCamera.CFrame.UpVector * moveDir.Y + CurrentCamera.CFrame.LookVector * moveDir.Z).Unit * getgenv().ScopersCMD.FlySettings.Speed * 50
                            getgenv().ScopersCMD.FlySettings.BodyVelocity.Velocity = moveVector
                        else
                            getgenv().ScopersCMD.FlySettings.BodyVelocity.Velocity = Vector3.zero
                        end

                        getgenv().ScopersCMD.FlySettings.BodyGyro.CFrame = CFrame.new(Player.Character.HumanoidRootPart.Position, Player.Character.HumanoidRootPart.Position + CurrentCamera.CFrame.LookVector)
                    end)
                end)

                getgenv().ScopersCMD.FlySettings.DiedConnection = Player.Character.Humanoid.Died:Connect(UnFly)
            end

            function UnFly()
                if getgenv().ScopersCMD.FlySettings.DiedConnection then
                    getgenv().ScopersCMD.FlySettings.DiedConnection:Disconnect()
                    getgenv().ScopersCMD.FlySettings.DiedConnection = nil
                end

                getgenv().ScopersCMD.FlySettings.Flying = false

                Player.Character.Humanoid.PlatformStand = false

                Controls:Enable()

                if getgenv().ScopersCMD.FlySettings.BodyVelocity then getgenv().ScopersCMD.FlySettings.BodyVelocity:Destroy() end
                if getgenv().ScopersCMD.FlySettings.BodyGyro then getgenv().ScopersCMD.FlySettings.BodyGyro:Destroy() end
                if getgenv().ScopersCMD.FlySettings.FlySignal then getgenv().ScopersCMD.FlySettings.FlySignal:Disconnect() end
                if getgenv().ScopersCMD.FlySettings.DiedConnection then getgenv().ScopersCMD.FlySettings.DiedConnection:Disconnect() end

                for k,_ in pairs(getgenv().ScopersCMD.FlySettings.Controls) do
                    getgenv().ScopersCMD.FlySettings.Controls[k] = 0
                end
                
                coroutine.wrap(function()
                    task.delay(0.01, function()
                        AntiRagdoll(Player)
                    end)
                end)()
            end

            function AntiRagdoll(target)
                if target.Character and target.Character:FindFirstChild("Humanoid") then
                    if target.Character:FindFirstChild("Humanoid"):GetState() == Enum.HumanoidStateType.FallingDown or target.Character:FindFirstChild("Humanoid"):GetState() == Enum.HumanoidStateType.Ragdoll or target.Character:FindFirstChild("Humanoid"):GetState() == Enum.HumanoidStateType.PlatformStanding then
                        target.Character:FindFirstChild("Humanoid").PlatformStand = false
                        target.Character:FindFirstChild("Humanoid"):ChangeState(Enum.HumanoidStateType.GettingUp)
                        BreakVelocity(Player.Character:FindFirstChild("HumanoidRootPart"))
                    end
                end
            end

            function SpinRoot(boolean, value, root)
                if not root then
                    return
                end

                if boolean then
                    if root:FindFirstChild("ScopersSpin") then
                        return
                    end
                    
                    if not value then
                        return
                    end

                    local ScopersSpin = Instance.new("BodyAngularVelocity", root)
                    
                    ScopersSpin.Name = "ScopersSpin"
                    ScopersSpin.AngularVelocity = Vector3.new(0, value, 0)
                    ScopersSpin.MaxTorque = Vector3.new(0, math.huge, 0)
                else
                    if root:FindFirstChild("ScopersSpin") then
                        root:FindFirstChild("ScopersSpin"):Destroy()
                    end
                end
            end


            function BreakVelocity(root)
                if root then
                    root.Velocity = Vector3.zero

                    AntiRagdoll(Player)
                    
                    if root:FindFirstChild("BodyVelocity") then
                        root:FindFirstChild("BodyVelocity"):Destroy()
                    else
                        return
                    end
                end
            end

            function SpeedVelocity(root, humanoid)
                if root then
                    root.Velocity = Vector3.new(humanoid.MoveDirection.X * getgenv().ScopersCMD.PlayerSettings.Speed.Value, humanoid.RootPart.Velocity.Y, humanoid.MoveDirection.Z * getgenv().ScopersCMD.PlayerSettings.Speed.Value)
                end
            end

            local function TweenTeleport(root, coordinates, speed)
                local CDist = (root.Position - coordinates).Magnitude
                local CSpeed = CDist / tonumber(speed)

                local CTween = TweenService:Create(
                    root,
                    TweenInfo.new(CSpeed, Enum.EasingStyle.Linear),
                    {CFrame = CFrame.new(
                            coordinates + Vector3.new(0, 3.1, 0),
                            coordinates + Vector3.new(0, 3.1, 0) + root.CFrame.LookVector
                        )
                    }
                )

                CTween:Play();
                CTween.Completed:Wait();
            end

            local function ClickTeleport()
                if Player.Backpack and Player.Backpack:FindFirstChild("Teleport") then
                    Player.Backpack:FindFirstChild("Teleport"):Destroy()
                elseif Player.Character and Player.Character:FindFirstChild("Teleport") then
                    Player.Character:FindFirstChild("Teleport"):Destroy()
                end

                local Teleport = Instance.new("Tool", Player.Backpack)

                Teleport.Name = "Teleport"
                Teleport.RequiresHandle = false

                Teleport.Activated:Connect(function()
                    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                        TweenTeleport(Player.Character:FindFirstChild("HumanoidRootPart"), Mouse.Hit.p, math.huge)
                    end
                end)
            end

            local function StareAt(root, targetRoot)
                pcall(function()
                    local Directive = targetRoot.Position - root.Position
                    Directive = Vector3.new(Directive.X, 0, Directive.Z)

                    root.CFrame = CFrame.lookAt(root.Position, root.Position + Directive)
                end)
            end

            local function TweenGoto(root, targetRoot, speed, rbxsignal)
                pcall(function()
                    local CDist = (root.Position - targetRoot.Position).Magnitude
                    local CSpeed = CDist /  tonumber(speed);
                    local CTween = TweenService:Create(root, TweenInfo.new(CSpeed, Enum.EasingStyle.Linear), {CFrame = targetRoot.CFrame * CFrame.new(0, 0, 1)});

                    CTween:Play();

                    if (targetRoot.Position - root.Position).Magnitude < 5 then
                        rbxsignal:Disconnect();
                    elseif targetRoot.Parent.Humanoid.Health <= 0 then
                        rbxsignal:Disconnect();
                        CTween:Cancel();
                    end
                end)
            end

            local function Goto(root, targetRoot)
                pcall(function()
                    root.Velocity = Vector3.zero
                    root.CFrame = targetRoot.CFrame * CFrame.new(0, 0, -1);
                end)
            end

            local function Scare(root, targetRoot, delay)
                pcall(function()
                    local cOld = root.CFrame

                    root.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 1);
                    task.wait(delay)
                    root.CFrame = cOld
                end)
            end

            local function Hide(target)
                if target.Character then
                    target.Character.Parent = target
                end
            end

            local function UnHide(target)
                if target then
                    target.Character.Parent = Workspace
                end
            end

            function Mute(target)
                pcall(function()
                    if target and target.Character:FindFirstChild("AudioEmitter") then
                        target.Character:FindFirstChild("AudioEmitter").Parent = target
                    end
                end)
            end

            function UnMute(target)
                pcall(function()
                    if target and target:FindFirstChild("AudioEmitter") then
                        target:FindFirstChild("AudioEmitter").Parent = target.Character
                    end
                end)
            end

            local function View(target)
                if target.Character and target.Character:FindFirstChild("Humanoid") then
                    Camera.CameraSubject = target.Character:FindFirstChild("Humanoid");
                end
            end

            local function UnView()
                if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                    Camera.CameraSubject = Player.Character:FindFirstChild("Humanoid");
                end
            end

            local function StopAnimations(target)
                if target and target.Character and target.Character:FindFirstChild("Humanoid") then
                    for _, Tracks in pairs(target.Character:FindFirstChild("Humanoid"):GetPlayingAnimationTracks()) do
                        target.Character:FindFirstChild("Humanoid"):Stop()
                    end
                end
            end

            local function RandomPlayer(Parameter)
                table.clear(getgenv().ScopersCMD.Server)

                for _, Server in ipairs(Players:GetPlayers()) do
                    if Server ~= Player then
                        table.insert(getgenv().ScopersCMD.Server, Server)
                    end
                end

                if #getgenv().ScopersCMD.Server > 0 then
                    Parameter = getgenv().ScopersCMD.Server[math.random(#getgenv().ScopersCMD.Server)]
                end

                return Parameter
            end

            local function ShortenV2(String)
                if not String then
                    return {}
                end

                String = String:lower()

                if String == "random" then
                    local randomPlayer = RandomPlayer()
                    return randomPlayer and { randomPlayer } or {}
                end

                return Shorten(String)
            end

            local function CreateCaveFloat()
                if Camera:FindFirstChild("CaveFloat") then
                    return
                end

                local CaveFloat = Instance.new("Part", Camera)

                CaveFloat.Name = "CaveFloat"
                CaveFloat.Material = "CeramicTiles"
                CaveFloat.Anchored = true
                CaveFloat.Color = Color3.fromRGB(100, 100, 100)
                CaveFloat.Size = Vector3.new(250, 1, 250)
                CaveFloat.Rotation = Vector3.new(0, 45, 0)
                CaveFloat.CFrame = CFrame.new(-177.5, -8.5, 72196.5)

                Workspace.FallenPartsDestroyHeight = tonumber("nan")

                Workspace:GetPropertyChangedSignal("FallenPartsDestroyHeight"):Connect(function()
                    Workspace.FallenPartsDestroyHeight = tonumber("nan")
                end)
            end

            CreateCaveFloat()

            TextChatService.OnIncomingMessage = function(Parameter)
                local CustomProperties = Instance.new("TextChatMessageProperties", TextChatService)

                if Parameter.TextSource and Players:GetPlayerByUserId(Parameter.TextSource.UserId) == Player then
                    local Message = Parameter.Text:lower()

                    if string.sub(Message, 1, 1) == getgenv().ScopersCMD.Prefix then
                        local Command
                        local Space = string.find(Message, " ")

                        if Space then
                            Command = string.sub(Message, 2, Space - 1)
                        else
                            Command = string.sub(Message, 2)
                        end

                        -- local String = string.sub(Message, Space + 1) -- This is used for shortening and getting your messages from commands.
                        
                        if Command == "cmds" or Command == "commands" then
                            if CoreGui:FindFirstChild("ScopersCommands") then
                                CoreGui:FindFirstChild("ScopersCommands").CommandList.Visible = true
                                task.wait(0.1)
                                TweenUI(CoreGui:FindFirstChild("ScopersCommands").CommandList, UDim2.new(0.45, 0, 0.35, 0), 10)
                            end
                        elseif Command == "p" or Command == "prefix" then
                            local String = string.sub(Message, Space + 1)
                            
                            getgenv().ScopersCMD.Prefix = String

                            ScopersNotification(
                                CoreGui:FindFirstChild("ScopersCommands"),
                                "Scoper's Commands",
                                "Prefix " .. getgenv().ScopersCMD.Prefix,
                                2
                            )
                        elseif Command == "v" or Command == "view" then
                            local String = string.sub(Message, Space + 1)

                            for _, Search in pairs(Shorten(String)) do
                                if Search ~= Player then
                                    ScopersNotification(
                                        CoreGui:FindFirstChild("ScopersCommands"),
                                        "Player Spectate",
                                        "Spectating " .. Search.Name,
                                        2
                                    )
                                end
                            end

                            ViewLoop = RunService.Heartbeat:Connect(function()
                                for _, Search in pairs(Shorten(String)) do
                                    if Search ~= Player then
                                        if Player.Character:FindFirstChild("Humanoid").Health > 0 and Search.Character:FindFirstChild("Humanoid").Health > 0 then
                                            if ViewLoop then
                                                ViewLoop:Disconnect()
                                                ViewLoop = nil
                                            end

                                            View(Search)
                                        else
                                            if ViewLoop then
                                                ViewLoop:Disconnect()
                                                ViewLoop = nil
                                            end
                                        end
                                    end
                                end
                            end)
                        elseif Command == "unv" or Command == "unview" then
                            if ViewLoop then
                                ViewLoop:Disconnect()
                                ViewLoop = nil
                            end
                            
                            UnView()
                        elseif Command == "stare" then
                            local String = string.sub(Message, Space + 1)
                            
                            for _, Search in pairs(Shorten(String)) do
                                if Search ~= Player then
                                    ScopersNotification(
                                        CoreGui:FindFirstChild("ScopersCommands"),
                                        "Stare",
                                        "Staring At " .. Search.Name,
                                        2
                                    )
                                end
                            end

                            StareLoop = RunService.Heartbeat:Connect(function()
                                for _, Search in pairs(Shorten(String)) do
                                    if Search ~= Player then
                                        if Player.Character:FindFirstChild("Humanoid").Health > 0 and Search.Character:FindFirstChild("Humanoid").Health > 0 then
                                            StareAt(Player.Character:FindFirstChild("HumanoidRootPart"), Search.Character:FindFirstChild("HumanoidRootPart"))
                                        else
                                            if StareLoop then
                                                StareLoop:Disconnect()
                                                StareLoop = nil
                                            end
                                        end
                                    end
                                end
                            end)
                        elseif Command == "unstare" then
                            if StareLoop then
                                StareLoop:Disconnect()
                                StareLoop = nil
                            end
                        elseif Command == "f" or Command == "follow" then
                            local String = string.sub(Message, Space + 1)
                            
                            for _, Search in pairs(ShortenV2(String)) do
                                if Search ~= Player then
                                    ScopersNotification(
                                        CoreGui:FindFirstChild("ScopersCommands"),
                                        "Follower",
                                        "Following " .. Search.Name,
                                        2
                                    )
                                end
                            end
                            
                            if FollowLoop then
                                FollowLoop:Disconnect()
                                FollowLoop = nil
                            end

                            FollowLoop = RunService.Heartbeat:Connect(function()
                                for _, Search in pairs(ShortenV2(String)) do
                                    if Search ~= Player then
                                        if Player.Character:FindFirstChild("Humanoid").Health > 0 and Search.Character:FindFirstChild("Humanoid").Health > 0 then
                                            Goto(Player.Character:FindFirstChild("HumanoidRootPart"), Search.Character:FindFirstChild("HumanoidRootPart"))
                                            StareAt(Player.Character:FindFirstChild("HumanoidRootPart"), Search.Character:FindFirstChild("HumanoidRootPart"))
                                        else
                                            if FollowLoop then
                                                FollowLoop:Disconnect()
                                                FollowLoop = nil
                                            end
                                        end
                                    end
                                end
                            end)
                        elseif Command == "uf" or Command == "unfollow" then
                            if FollowLoop then
                                FollowLoop:Disconnect()
                                FollowLoop = nil
                            end
                        elseif Command == "h" or Command == "hide" then
                            local String = string.sub(Message, Space + 1)
                            
                            for _, Search in pairs(Shorten(String)) do
                                if Search ~= Player then
                                    if Search.Character then
                                        ScopersNotification(
                                            CoreGui:FindFirstChild("ScopersCommands"),
                                            "Player Visibility",
                                            "Concealed " .. Search.Name,
                                            2
                                        )
                                        break
                                    end
                                end
                            end
                            
                            if HideLoop then
                                HideLoop:Disconnect()
                                HideLoop = nil
                            end

                            HideLoop = RunService.Heartbeat:Connect(function()
                                for _, Search in pairs(Shorten(String)) do
                                    if Search ~= Player then
                                        if Search.Character then
                                            Hide(Search)
                                        end
                                    end
                                end
                            end)
                        elseif Command == "unh" or Command == "unhide" then
                            local String = string.sub(Message, Space + 1)

                            if HideLoop then
                                HideLoop:Disconnect()
                                HideLoop = nil
                            end

                            for _, Search in pairs(Shorten(String)) do
                                if Search ~= Player then
                                    if Search.Character then
                                        UnHide(Search)

                                        ScopersNotification(
                                            CoreGui:FindFirstChild("ScopersCommands"),
                                            "Player Visibility",
                                            "Revealed " .. Search.Name,
                                            2
                                        )
                                        break
                                    end
                                end
                            end
                        elseif Command == "mvc" or Command == "mute" then
                            local String = string.sub(Message, Space + 1)
                            
                            for _, Search in pairs(Shorten(String)) do
                                if Search ~= Player then
                                    ScopersNotification(
                                        CoreGui:FindFirstChild("ScopersCommands"),
                                        "Voice Chat",
                                        "Muted " .. Search.Name,
                                        2
                                    )
                                    break
                                end
                            end

                            MuteVCLoop = RunService.Heartbeat:Connect(function()
                                for _, Search in pairs(Shorten(String)) do
                                    if Search ~= Player then
                                        Mute(Search)
                                    end
                                end
                            end)
                        elseif Command == "umvc" or Command == "unmute" then
                            local String = string.sub(Message, Space + 1)
                            
                            if MuteVCLoop then
                                MuteVCLoop:Disconnect()
                                MuteVCLoop = nil
                            end

                            for _, Search in pairs(Shorten(String)) do
                                if Search ~= Player then
                                    UnMute(Search)

                                    ScopersNotification(
                                        CoreGui:FindFirstChild("ScopersCommands"),
                                        "Voice Chat",
                                        "Un-Muted " .. Search.Name,
                                        2
                                    )
                                    break
                                end
                            end
                        elseif Command == "tpt" or Command == "teletool" then
                            ClickTeleport();
                        elseif Command == "creep" then
                            ScopersAnimationSetup();
                            ToggleScopersCustomAnimation();
                        elseif Command == "uncreep" then
                            ToggleScopersCustomAnimation();
                        elseif Command == "to" or Command == "goto" then
                            local String = string.sub(Message, Space + 1)

                            for _, Search in pairs(ShortenV2(String)) do
                                if Search ~= Player then
                                    if Player.Character:FindFirstChild("Humanoid").Health > 0 and Search.Character:FindFirstChild("Humanoid").Health > 0 then
                                        Goto(Player.Character:FindFirstChild("HumanoidRootPart"), Search.Character:FindFirstChild("HumanoidRootPart"))
                                        StareAt(Player.Character:FindFirstChild("HumanoidRootPart"), Search.Character:FindFirstChild("HumanoidRootPart"))
                                    end
                                end
                            end
                        elseif Command == "tg" or Command == "tweengoto" then
                            local String = string.sub(Message, Space + 1)
                            
                            TweenGotoLoop = RunService.Heartbeat:Connect(function()
                                for _, Search in pairs(Shorten(String)) do
                                    if Search ~= Player then
                                        if Player.Character:FindFirstChild("Humanoid").Health > 0 and Search.Character:FindFirstChild("Humanoid").Health > 0 then
                                            TweenGoto(Player.Character:FindFirstChild("HumanoidRootPart"), Search.Character:FindFirstChild("HumanoidRootPart"), 5000, TweenGotoLoop)
                                        else
                                            if TweenGotoLoop then
                                                TweenGotoLoop:Disconnect()
                                                TweenGotoLoop = nil
                                            end
                                        end
                                    end
                                end
                            end)
                        elseif Command == "scare" then
                            local String = string.sub(Message, Space + 1)

                            for _, Search in pairs(Shorten(String)) do
                                if Search ~= Player then
                                    if Player.Character:FindFirstChild("Humanoid").Health > 0 and Search.Character:FindFirstChild("Humanoid").Health > 0 then
                                        Scare(Player.Character:FindFirstChild("HumanoidRootPart"), Search.Character:FindFirstChild("HumanoidRootPart"), 0.25)
                                    end
                                end
                            end
                        elseif Command == "pf" or Command == "platform" then
                            Terrain:Clear();
                            Terrain:SetMaterialColor(Enum.Material.Asphalt, Color3.fromRGB(126, 191, 252));
                            Terrain:FillBlock(CFrame.new(8, -4.59, -482), Vector3.new(7000, 5, 7000), Enum.Material.Asphalt);
                        elseif Command == "unpf" or Command == "noplatform" then
                            Terrain:Clear();
                        elseif Command == "xray" then
                            getgenv().ScopersCMD.MapSettings.XRay = not getgenv().ScopersCMD.MapSettings.XRay
                            XRay()
                        elseif Command == "mid" or Command == "middle" then
                            Player.Character.HumanoidRootPart.CFrame = getgenv().ScopersCMD.MapSettings.Main.Middle
                        elseif Command == "cavein" then
                            Player.Character.HumanoidRootPart.CFrame = getgenv().ScopersCMD.MapSettings.Cave.In
                        elseif Command == "caveout" then
                            Player.Character.HumanoidRootPart.CFrame = getgenv().ScopersCMD.MapSettings.Cave.Out
                        elseif Command == "caveunder" then
                            Player.Character.HumanoidRootPart.CFrame = getgenv().ScopersCMD.MapSettings.Cave.Under
                        elseif Command == "re" or Command == "refresh" then
                            local cOld = Player.Character:WaitForChild("HumanoidRootPart").CFrame
                            
                            Player.Character:BreakJoints();
                            
                            for _, Limbs in next, Player.Character:GetChildren() do
                                if Limbs:IsA("Accessory") then
                                    Limbs.Handle.Anchored = true
                                elseif Limbs:IsA("BasePart") then
                                    Limbs.Anchored =  true
                                    Limbs:Destroy()
                                end
                            end

                            Player.CharacterAdded:Wait():WaitForChild("HumanoidRootPart").CFrame = cOld
                        elseif Command == "anf" or Command == "antifollow" then
                            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                                local cOld = Player.Character:FindFirstChild("HumanoidRootPart").CFrame

                                Player.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(0, -900, 0)
                                task.wait(0.35)
                                GrabExit:FireServer()
                                task.wait(0.1)
                                Player.Character:FindFirstChild("HumanoidRootPart").CFrame = cOld

                                coroutine.wrap(function()
                                    AntiRagdoll(Player);
                                    BreakVelocity(Player.Character:FindFirstChild("HumanoidRootPart"));
                                end)()
                            end
                        elseif Command == "dex" or Command == "darkdex" then
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))();
                        elseif Command == "fc" or Command == "fcam" or Command == "freecamera" then
                            if Space then
                                local String = string.sub(Message, Space + 1)
                                
                                getgenv().ScopersCMD.FreeCameraSettings.Speed = tonumber(String)
                            end

                            StartFreeCamera()
                        elseif Command == "unfc" or Command == "unfcam" or Command == "nofreecamera" then
                            StopFreeCamera()
                        elseif Command == "ncam" or Command == "noclipcamera" then
                            NoClipCamera()
                        elseif Command == "noclip" then
                            if NoClipLoop then
                                NoClipLoop:Disconnect()
                                NoClipLoop = nil
                            end
                            
                            NoClipLoop = RunService.RenderStepped:Connect(function()
                                coroutine.wrap(function()
                                    NoClip()
                                end)()
                            end)
                        elseif Command == "clip" then
                            if NoClipLoop then
                                NoClipLoop:Disconnect()
                                NoClipLoop = nil
                            end

                            Clip()
                        elseif Command == "fly" then
                            if Space then
                                local String = string.sub(Message, Space + 1)
                                
                                getgenv().ScopersCMD.FlySettings.Speed = tonumber(String)
                            end
                            
                            Fly()
                        elseif Command == "unfly" then
                            UnFly()
                        elseif Command == "bv" or Command == "breakvelocity" then
                            BreakVelocity(Player.Character:FindFirstChild("HumanoidRootPart"))
                        elseif Command == "s" or Command == "spin" then
                            if Space then
                                local String = string.sub(Message, Space + 1)
                                
                                SpinRoot(true, tonumber(String), Player.Character:FindFirstChild("HumanoidRootPart"))
                            end
                        elseif Command == "uns" or Command == "unspin" then
                            SpinRoot(false, nil, Player.Character:FindFirstChild("HumanoidRootPart"))
                        elseif Command == "ws" or Command == "speed" then
                            if Space then
                                local String = string.sub(Message, Space + 1)

                                getgenv().ScopersCMD.PlayerSettings.Speed.Value = tonumber(String)
                                
                                if getgenv().ScopersCMD.PlayerSettings.Speed.Value > 0 then
                                    getgenv().ScopersCMD.PlayerSettings.Speed.Enabled = true
                                else
                                    getgenv().ScopersCMD.PlayerSettings.Speed.Enabled = false
                                    
                                    coroutine.wrap(function()
                                        AntiRagdoll(Player);
                                        BreakVelocity(Player.Character:FindFirstChild("HumanoidRootPart"));
                                    end)()
                                end
                            end
                        elseif Command == "timer" then
                            if Space then
                                local String = string.sub(Message, Space + 1)
                                
                                VoiceChatTimer(String)
                            end
                        elseif Command == "rj" or Command == "rejoin" then
                            ServerRejoin();
                        elseif Command == "hop" or Command == "serverhop" then
                            ServerHop();
                        end

                        CustomProperties.PrefixText = ""
                        CustomProperties.Text = ""

                        return false
                    end
                end
                return CustomProperties
            end

            -- Command UI

            if CoreGui:FindFirstChild("ScopersCommands") then
                CoreGui:FindFirstChild("ScopersCommands"):Destroy()
            end

            local ScopersCommands = Instance.new("ScreenGui")

            -- Command Bar

            local Main = Instance.new("Frame")
            local InputBar = Instance.new("TextBox")
            local ArrowBackground = Instance.new("Frame")
            local Arrow = Instance.new("ImageLabel")
            local MainCorner = Instance.new("UICorner")
            local ArrowCorner = Instance.new("UICorner")

            -- Commands List

            local CommandList = Instance.new("Frame")
            local CommandCorner = Instance.new("UICorner")
            local CommandsListScroll = Instance.new("ScrollingFrame")
            local CommandListLayout = Instance.new("UIListLayout")
            local CommandListPadding = Instance.new("UIPadding")
            local Command1 = Instance.new("TextLabel")
            local Command2 = Instance.new("TextLabel")
            local Command3 = Instance.new("TextLabel")
            local Command4 = Instance.new("TextLabel")
            local Command5 = Instance.new("TextLabel")
            local Command6 = Instance.new("TextLabel")
            local Command7 = Instance.new("TextLabel")
            local Command8 = Instance.new("TextLabel")
            local Command9 = Instance.new("TextLabel")
            local Command10 = Instance.new("TextLabel")
            local Command11 = Instance.new("TextLabel")
            local Command12 = Instance.new("TextLabel")
            local Command13 = Instance.new("TextLabel")
            local Command14 = Instance.new("TextLabel")
            local Command15 = Instance.new("TextLabel")
            local Command16 = Instance.new("TextLabel")
            local Command17 = Instance.new("TextLabel")
            local Command18 = Instance.new("TextLabel")
            local Command19 = Instance.new("TextLabel")
            local Command20 = Instance.new("TextLabel")
            local Command21 = Instance.new("TextLabel")
            local Command22 = Instance.new("TextLabel")
            local Command23 = Instance.new("TextLabel")
            local Command24 = Instance.new("TextLabel")
            local Command25 = Instance.new("TextLabel")
            local Command26 = Instance.new("TextLabel")
            local Command27 = Instance.new("TextLabel")
            local Command28 = Instance.new("TextLabel")
            local Command29 = Instance.new("TextLabel")
            local Command30 = Instance.new("TextLabel")
            local Command31 = Instance.new("TextLabel")
            local Command32 = Instance.new("TextLabel")
            local Command33 = Instance.new("TextLabel")
            local Command34 = Instance.new("TextLabel")
            local Command35 = Instance.new("TextLabel")
            local Command36 = Instance.new("TextLabel")
            local Command37 = Instance.new("TextLabel")
            local Command38 = Instance.new("TextLabel")
            local Command39 = Instance.new("TextLabel")
            local Command40 = Instance.new("TextLabel")
            local Command41 = Instance.new("TextLabel")
            local Command42 = Instance.new("TextLabel")
            local CommandListInputBarHolder = Instance.new("Frame")
            local CommandListInputBar = Instance.new("TextBox")
            local CommandListInputBarCorner = Instance.new("UICorner")
            local CommandListCloseHolder = Instance.new("Frame")
            local CloseCorner = Instance.new("UICorner")
            local CloseButton = Instance.new("ImageButton")
            local CommandTip = Instance.new("TextLabel")
            local CommandTipCorner = Instance.new("UICorner")

            ScopersCommands.Name = "ScopersCommands"
            ScopersCommands.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            ScopersCommands.Parent = CoreGui

            Main.Name = "Main"
            Main.Position = UDim2.new(0.45, 0, 1, 0)
            Main.Size = UDim2.new(0.1, 0, 0.025, 0)
            Main.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
            Main.BackgroundTransparency = 0.5
            Main.BorderSizePixel = 0
            Main.BorderColor3 = Color3.new(0, 0, 0)
            Main.Transparency = 0.5
            Main.Parent = ScopersCommands

            InputBar.Name = "InputBar"
            InputBar.Size = UDim2.new(1, 0, 1, 0)
            InputBar.BackgroundColor3 = Color3.new(1, 1, 1)
            InputBar.BackgroundTransparency = 1
            InputBar.BorderSizePixel = 0
            InputBar.BorderColor3 = Color3.new(0, 0, 0)
            InputBar.TextTransparency = 0
            InputBar.TextStrokeTransparency = 0
            InputBar.Text = ""
            InputBar.TextColor3 = Color3.new(1, 1, 1)
            InputBar.TextSize = 22
            InputBar.TextTruncate = "AtEnd"
            InputBar.Font = "Gotham"
            InputBar.PlaceholderText = "Command Here"
            InputBar.PlaceholderColor3 = Color3.new(1, 1, 1)
            InputBar.Parent = Main
            InputBar.TextWrapped = true

            ArrowBackground.Name = "ArrowBackground"
            ArrowBackground.Position = UDim2.new(-0.15, 0, 0, 0)
            ArrowBackground.Size = UDim2.new(0.135, 0, 1, 0)
            ArrowBackground.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
            ArrowBackground.BackgroundTransparency = 0.5
            ArrowBackground.BorderSizePixel = 0
            ArrowBackground.BorderColor3 = Color3.new(0, 0, 0)
            ArrowBackground.Transparency = 0.5
            ArrowBackground.Parent = Main

            Arrow.Name = "Arrow"
            Arrow.Size = UDim2.new(0.75, 0, 0.75, 0)
            Arrow.Position = UDim2.new(0.125, 0, 0.125, 0)
            Arrow.BackgroundColor3 = Color3.new(1, 1, 1)
            Arrow.BackgroundTransparency = 1
            Arrow.BorderSizePixel = 0
            Arrow.BorderColor3 = Color3.new(0, 0, 0)
            Arrow.Transparency = 1
            Arrow.Image = "rbxassetid://10709811365"
            Arrow.Parent = ArrowBackground

            MainCorner.Name = "MainCorner"
            MainCorner.CornerRadius = UDim.new(0.25, 0)
            MainCorner.Parent = Main

            ArrowCorner.Name = "ArrowCorner"
            ArrowCorner.CornerRadius = UDim.new(0.1, 0)
            ArrowCorner.Parent = ArrowBackground

            CommandList.Name = "CommandList"
            CommandList.Parent = ScopersCommands
            CommandList.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            CommandList.BackgroundTransparency = 0.500
            CommandList.BorderColor3 = Color3.fromRGB(0, 0, 0)
            CommandList.BorderSizePixel = 0
            CommandList.Position = UDim2.new(0.45, 0, -1, 0)
            CommandList.Size = UDim2.new(0.125, 0, 0.3, 0)

            CommandCorner.CornerRadius = UDim.new(0.0250000004, 0)
            CommandCorner.Name = "CommandCorner"
            CommandCorner.Parent = CommandList

            CommandsListScroll.Name = "CommandsListScroll"
            CommandsListScroll.Parent = CommandList
            CommandsListScroll.Active = true
            CommandsListScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
            CommandsListScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CommandsListScroll.BackgroundTransparency = 1.000
            CommandsListScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
            CommandsListScroll.BorderSizePixel = 0
            CommandsListScroll.Size = UDim2.new(1, 0, 1, 0)
            CommandsListScroll.BottomImage = "rbxassetid://86927157225558"
            CommandsListScroll.MidImage = "rbxassetid://95591733073455"
            CommandsListScroll.ScrollBarThickness = 7
            CommandsListScroll.ScrollBarImageTransparency = 0.5
            CommandsListScroll.TopImage = "rbxassetid://115122166951013"

            Command1.Name = "Command1"
            Command1.Parent = CommandsListScroll
            Command1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command1.BackgroundTransparency = 1.000
            Command1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command1.BorderSizePixel = 0
            Command1.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command1.Font = Enum.Font.Gotham
            Command1.Text = "cmds / commands"
            Command1.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command1.TextSize = 14.000
            Command1.TextStrokeTransparency = 0.000

            CommandListLayout.Name = "CommandListLayout"
            CommandListLayout.Parent = CommandsListScroll
            CommandListLayout.SortOrder = Enum.SortOrder.LayoutOrder

            CommandListPadding.Name = "CommandListPadding"
            CommandListPadding.PaddingTop = UDim.new(0, 6)
            CommandListPadding.PaddingBottom = UDim.new(0, 6)
            CommandListPadding.Parent = CommandsListScroll

            Command2.Name = "Command2"
            Command2.Parent = CommandsListScroll
            Command2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command2.BackgroundTransparency = 1.000
            Command2.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command2.BorderSizePixel = 0
            Command2.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command2.Font = Enum.Font.Gotham
            Command2.Text = "p / prefix"
            Command2.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command2.TextSize = 14.000
            Command2.TextStrokeTransparency = 0.000

            Command3.Name = "Command3"
            Command3.Parent = CommandsListScroll
            Command3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command3.BackgroundTransparency = 1.000
            Command3.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command3.BorderSizePixel = 0
            Command3.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command3.Font = Enum.Font.Gotham
            Command3.Text = "rj / rejoin"
            Command3.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command3.TextSize = 14.000
            Command3.TextStrokeTransparency = 0.000

            Command4.Name = "Command4"
            Command4.Parent = CommandsListScroll
            Command4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command4.BackgroundTransparency = 1.000
            Command4.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command4.BorderSizePixel = 0
            Command4.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command4.Font = Enum.Font.Gotham
            Command4.Text = "hop / serverhop"
            Command4.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command4.TextSize = 14.000
            Command4.TextStrokeTransparency = 0.000

            Command5.Name = "Command5"
            Command5.Parent = CommandsListScroll
            Command5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command5.BackgroundTransparency = 1.000
            Command5.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command5.BorderSizePixel = 0
            Command5.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command5.Font = Enum.Font.Gotham
            Command5.Text = "tpt / teletool"
            Command5.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command5.TextSize = 14.000
            Command5.TextStrokeTransparency = 0.000

            Command6.Name = "Command6"
            Command6.Parent = CommandsListScroll
            Command6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command6.BackgroundTransparency = 1.000
            Command6.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command6.BorderSizePixel = 0
            Command6.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command6.Font = Enum.Font.Gotham
            Command6.Text = "v / view (USER)"
            Command6.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command6.TextSize = 14.000
            Command6.TextStrokeTransparency = 0.000

            Command7.Name = "Command7"
            Command7.Parent = CommandsListScroll
            Command7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command7.BackgroundTransparency = 1.000
            Command7.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command7.BorderSizePixel = 0
            Command7.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command7.Font = Enum.Font.Gotham
            Command7.Text = "unv / unview"
            Command7.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command7.TextSize = 14.000
            Command7.TextStrokeTransparency = 0.000

            Command8.Name = "Command8"
            Command8.Parent = CommandsListScroll
            Command8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command8.BackgroundTransparency = 1.000
            Command8.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command8.BorderSizePixel = 0
            Command8.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command8.Font = Enum.Font.Gotham
            Command8.Text = "stare (USER)"
            Command8.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command8.TextSize = 14.000
            Command8.TextStrokeTransparency = 0.000

            Command9.Name = "Command9"
            Command9.Parent = CommandsListScroll
            Command9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command9.BackgroundTransparency = 1.000
            Command9.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command9.BorderSizePixel = 0
            Command9.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command9.Font = Enum.Font.Gotham
            Command9.Text = "unstare"
            Command9.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command9.TextSize = 14.000
            Command9.TextStrokeTransparency = 0.000

            Command10.Name = "Command10"
            Command10.Parent = CommandsListScroll
            Command10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command10.BackgroundTransparency = 1.000
            Command10.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command10.BorderSizePixel = 0
            Command10.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command10.Font = Enum.Font.Gotham
            Command10.Text = "to / goto (USER)"
            Command10.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command10.TextSize = 14.000
            Command10.TextStrokeTransparency = 0.000

            Command11.Name = "Command11"
            Command11.Parent = CommandsListScroll
            Command11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command11.BackgroundTransparency = 1.000
            Command11.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command11.BorderSizePixel = 0
            Command11.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command11.Font = Enum.Font.Gotham
            Command11.Text = "tg / tweengoto (USER)"
            Command11.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command11.TextSize = 14.000
            Command11.TextStrokeTransparency = 0.000

            Command12.Name = "Command12"
            Command12.Parent = CommandsListScroll
            Command12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command12.BackgroundTransparency = 1.000
            Command12.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command12.BorderSizePixel = 0
            Command12.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command12.Font = Enum.Font.Gotham
            Command12.Text = "f / follow (USER)"
            Command12.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command12.TextSize = 14.000
            Command12.TextStrokeTransparency = 0.000

            Command13.Name = "Command13"
            Command13.Parent = CommandsListScroll
            Command13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command13.BackgroundTransparency = 1.000
            Command13.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command13.BorderSizePixel = 0
            Command13.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command13.Font = Enum.Font.Gotham
            Command13.Text = "uf / unfollower"
            Command13.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command13.TextSize = 14.000
            Command13.TextStrokeTransparency = 0.000

            Command14.Name = "Command14"
            Command14.Parent = CommandsListScroll
            Command14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command14.BackgroundTransparency = 1.000
            Command14.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command14.BorderSizePixel = 0
            Command14.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command14.Font = Enum.Font.Gotham
            Command14.Text = "scare (USER)"
            Command14.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command14.TextSize = 14.000
            Command14.TextStrokeTransparency = 0.000

            Command15.Name = "Command15"
            Command15.Parent = CommandsListScroll
            Command15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command15.BackgroundTransparency = 1.000
            Command15.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command15.BorderSizePixel = 0
            Command15.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command15.Font = Enum.Font.Gotham
            Command15.Text = "h / hide (USER)"
            Command15.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command15.TextSize = 14.000
            Command15.TextStrokeTransparency = 0.000

            Command16.Name = "Command16"
            Command16.Parent = CommandsListScroll
            Command16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command16.BackgroundTransparency = 1.000
            Command16.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command16.BorderSizePixel = 0
            Command16.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command16.Font = Enum.Font.Gotham
            Command16.Text = "unh / unhide (USER)"
            Command16.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command16.TextSize = 14.000
            Command16.TextStrokeTransparency = 0.000

            Command17.Name = "Command17"
            Command17.Parent = CommandsListScroll
            Command17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command17.BackgroundTransparency = 1.000
            Command17.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command17.BorderSizePixel = 0
            Command17.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command17.Font = Enum.Font.Gotham
            Command17.Text = "mvc / mute (USER)"
            Command17.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command17.TextSize = 14.000
            Command17.TextStrokeTransparency = 0.000

            Command18.Name = "Command18"
            Command18.Parent = CommandsListScroll
            Command18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command18.BackgroundTransparency = 1.000
            Command18.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command18.BorderSizePixel = 0
            Command18.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command18.Font = Enum.Font.Gotham
            Command18.Text = "umvc / unmute (USER)"
            Command18.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command18.TextSize = 14.000
            Command18.TextStrokeTransparency = 0.000

            Command19.Name = "Command19"
            Command19.Parent = CommandsListScroll
            Command19.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command19.BackgroundTransparency = 1.000
            Command19.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command19.BorderSizePixel = 0
            Command19.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command19.Font = Enum.Font.Gotham
            Command19.Text = "pf / platform"
            Command19.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command19.TextSize = 14.000
            Command19.TextStrokeTransparency = 0.000

            Command20.Name = "Command20"
            Command20.Parent = CommandsListScroll
            Command20.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command20.BackgroundTransparency = 1.000
            Command20.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command20.BorderSizePixel = 0
            Command20.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command20.Font = Enum.Font.Gotham
            Command20.Text = "unpf / unplatform"
            Command20.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command20.TextSize = 14.000
            Command20.TextStrokeTransparency = 0.000

            Command21.Name = "Command21"
            Command21.Parent = CommandsListScroll
            Command21.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command21.BackgroundTransparency = 1.000
            Command21.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command21.BorderSizePixel = 0
            Command21.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command21.Font = Enum.Font.Gotham
            Command21.Text = "mid / middle"
            Command21.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command21.TextSize = 14.000
            Command21.TextStrokeTransparency = 0.000

            Command22.Name = "Command22"
            Command22.Parent = CommandsListScroll
            Command22.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command22.BackgroundTransparency = 1.000
            Command22.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command22.BorderSizePixel = 0
            Command22.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command22.Font = Enum.Font.Gotham
            Command22.Text = "cavein"
            Command22.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command22.TextSize = 14.000
            Command22.TextStrokeTransparency = 0.000

            Command23.Name = "Command23"
            Command23.Parent = CommandsListScroll
            Command23.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command23.BackgroundTransparency = 1.000
            Command23.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command23.BorderSizePixel = 0
            Command23.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command23.Font = Enum.Font.Gotham
            Command23.Text = "caveout"
            Command23.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command23.TextSize = 14.000
            Command23.TextStrokeTransparency = 0.000

            Command24.Name = "Command24"
            Command24.Parent = CommandsListScroll
            Command24.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command24.BackgroundTransparency = 1.000
            Command24.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command24.BorderSizePixel = 0
            Command24.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command24.Font = Enum.Font.Gotham
            Command24.Text = "caveunder"
            Command24.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command24.TextSize = 14.000
            Command24.TextStrokeTransparency = 0.000

            Command25.Name = "Command25"
            Command25.Parent = CommandsListScroll
            Command25.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command25.BackgroundTransparency = 1.000
            Command25.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command25.BorderSizePixel = 0
            Command25.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command25.Font = Enum.Font.Gotham
            Command25.Text = "fly / unfly (NUMBER)"
            Command25.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command25.TextSize = 14.000
            Command25.TextStrokeTransparency = 0.000

            Command26.Name = "Command26"
            Command26.Parent = CommandsListScroll
            Command26.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command26.BackgroundTransparency = 1.000
            Command26.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command26.BorderSizePixel = 0
            Command26.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command26.Font = Enum.Font.Gotham
            Command26.Text = "unfly"
            Command26.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command26.TextSize = 14.000
            Command26.TextStrokeTransparency = 0.000

            Command27.Name = "Command27"
            Command27.Parent = CommandsListScroll
            Command27.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command27.BackgroundTransparency = 1.000
            Command27.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command27.BorderSizePixel = 0
            Command27.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command27.Font = Enum.Font.Gotham
            Command27.Text = "ws / speed (NUMBER)"
            Command27.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command27.TextSize = 14.000
            Command27.TextStrokeTransparency = 0.000

            Command28.Name = "Command28"
            Command28.Parent = CommandsListScroll
            Command28.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command28.BackgroundTransparency = 1.000
            Command28.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command28.BorderSizePixel = 0
            Command28.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command28.Font = Enum.Font.Gotham
            Command28.Text = "re / refresh"
            Command28.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command28.TextSize = 14.000
            Command28.TextStrokeTransparency = 0.000

            Command29.Name = "Command29"
            Command29.Parent = CommandsListScroll
            Command29.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command29.BackgroundTransparency = 1.000
            Command29.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command29.BorderSizePixel = 0
            Command29.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command29.Font = Enum.Font.Gotham
            Command29.Text = "noclip"
            Command29.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command29.TextSize = 14.000
            Command29.TextStrokeTransparency = 0.000

            Command30.Name = "Command30"
            Command30.Parent = CommandsListScroll
            Command30.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command30.BackgroundTransparency = 1.000
            Command30.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command30.BorderSizePixel = 0
            Command30.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command30.Font = Enum.Font.Gotham
            Command30.Text = "clip"
            Command30.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command30.TextSize = 14.000
            Command30.TextStrokeTransparency = 0.000

            Command31.Name = "Command31"
            Command31.Parent = CommandsListScroll
            Command31.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command31.BackgroundTransparency = 1.000
            Command31.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command31.BorderSizePixel = 0
            Command31.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command31.Font = Enum.Font.Gotham
            Command31.Text = "ncam / noclipcamera"
            Command31.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command31.TextSize = 14.000
            Command31.TextStrokeTransparency = 0.000

            Command32.Name = "Command32"
            Command32.Parent = CommandsListScroll
            Command32.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command32.BackgroundTransparency = 1.000
            Command32.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command32.BorderSizePixel = 0
            Command32.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command32.Font = Enum.Font.Gotham
            Command32.Text = "xray"
            Command32.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command32.TextSize = 14.000
            Command32.TextStrokeTransparency = 0.000

            Command33.Name = "Command33"
            Command33.Parent = CommandsListScroll
            Command33.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command33.BackgroundTransparency = 1.000
            Command33.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command33.BorderSizePixel = 0
            Command33.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command33.Font = Enum.Font.Gotham
            Command33.Text = "fc / fcam / freecamera (NUMBER)"
            Command33.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command33.TextSize = 14.000
            Command33.TextStrokeTransparency = 0.000

            Command34.Name = "Command34"
            Command34.Parent = CommandsListScroll
            Command34.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command34.BackgroundTransparency = 1.000
            Command34.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command34.BorderSizePixel = 0
            Command34.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command34.Font = Enum.Font.Gotham
            Command34.Text = "unfc / unfcam / nofreecamera"
            Command34.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command34.TextSize = 14.000
            Command34.TextStrokeTransparency = 0.000

            Command35.Name = "Command35"
            Command35.Parent = CommandsListScroll
            Command35.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command35.BackgroundTransparency = 1.000
            Command35.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command35.BorderSizePixel = 0
            Command35.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command35.Font = Enum.Font.Gotham
            Command35.Text = "dex / darkdex"
            Command35.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command35.TextSize = 14.000
            Command35.TextStrokeTransparency = 0.000

            Command37.Name = "Command37"
            Command37.Parent = CommandsListScroll
            Command37.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command37.BackgroundTransparency = 1.000
            Command37.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command37.BorderSizePixel = 0
            Command37.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command37.Font = Enum.Font.Gotham
            Command37.Text = "anf / antifollow"
            Command37.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command37.TextSize = 14.000
            Command37.TextStrokeTransparency = 0.000

            Command38.Name = "Command38"
            Command38.Parent = CommandsListScroll
            Command38.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command38.BackgroundTransparency = 1.000
            Command38.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command38.BorderSizePixel = 0
            Command38.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command38.Font = Enum.Font.Gotham
            Command38.Text = "creep"
            Command38.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command38.TextSize = 14.000
            Command38.TextStrokeTransparency = 0.000

            Command39.Name = "Command39"
            Command39.Parent = CommandsListScroll
            Command39.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command39.BackgroundTransparency = 1.000
            Command39.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command39.BorderSizePixel = 0
            Command39.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command39.Font = Enum.Font.Gotham
            Command39.Text = "uncreep"
            Command39.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command39.TextSize = 14.000
            Command39.TextStrokeTransparency = 0.000

            Command40.Name = "Command40"
            Command40.Parent = CommandsListScroll
            Command40.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command40.BackgroundTransparency = 1.000
            Command40.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command40.BorderSizePixel = 0
            Command40.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command40.Font = Enum.Font.Gotham
            Command40.Text = "bv / breakvelocity"
            Command40.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command40.TextSize = 14.000
            Command40.TextStrokeTransparency = 0.000

            Command41.Name = "Command41"
            Command41.Parent = CommandsListScroll
            Command41.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command41.BackgroundTransparency = 1.000
            Command41.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command41.BorderSizePixel = 0
            Command41.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command41.Font = Enum.Font.Gotham
            Command41.Text = "s / spin (NUMBER)"
            Command41.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command41.TextSize = 14.000
            Command41.TextStrokeTransparency = 0.000

            Command42.Name = "Command42"
            Command42.Parent = CommandsListScroll
            Command42.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Command42.BackgroundTransparency = 1.000
            Command42.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Command42.BorderSizePixel = 0
            Command42.Size = UDim2.new(1, 0, 0.0500000007, 0)
            Command42.Font = Enum.Font.Gotham
            Command42.Text = "uns / unspin"
            Command42.TextColor3 = Color3.fromRGB(255, 255, 255)
            Command42.TextSize = 14.000
            Command42.TextStrokeTransparency = 0.000

            CommandListInputBarHolder.Name = "CommandListInputBarHolder"
            CommandListInputBarHolder.Parent = CommandList
            CommandListInputBarHolder.Active = true
            CommandListInputBarHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            CommandListInputBarHolder.BackgroundTransparency = 0.500
            CommandListInputBarHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
            CommandListInputBarHolder.BorderSizePixel = 0
            CommandListInputBarHolder.Position = UDim2.new(0, 0, -0.100000001, 0)
            CommandListInputBarHolder.Size = UDim2.new(0.899999976, 0, 0.0700000003, 0)

            CommandListInputBar.Name = "CommandListInputBar"
            CommandListInputBar.Parent = CommandListInputBarHolder
            CommandListInputBar.Active = false
            CommandListInputBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            CommandListInputBar.BackgroundTransparency = 1.000
            CommandListInputBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
            CommandListInputBar.BorderSizePixel = 0
            CommandListInputBar.Position = UDim2.new(0, 0, -0.100000001, 0)
            CommandListInputBar.Size = UDim2.new(1, 0, 1, 0)
            CommandListInputBar.ClearTextOnFocus = false
            CommandListInputBar.Font = Enum.Font.Gotham
            CommandListInputBar.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
            CommandListInputBar.PlaceholderText = "Search"
            CommandListInputBar.Text = ""
            CommandListInputBar.TextColor3 = Color3.fromRGB(255, 255, 255)
            CommandListInputBar.TextSize = 22.000
            CommandListInputBar.TextStrokeTransparency = 0.000
            CommandListInputBar.TextWrapped = true

            CommandListInputBarCorner.CornerRadius = UDim.new(0.25, 0)
            CommandListInputBarCorner.Name = "CommandListInputBarCorner"
            CommandListInputBarCorner.Parent = CommandListInputBarHolder

            CommandListCloseHolder.Name = "CommandListCloseHolder"
            CommandListCloseHolder.Parent = CommandListInputBarHolder
            CommandListCloseHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            CommandListCloseHolder.BackgroundTransparency = 0.500
            CommandListCloseHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
            CommandListCloseHolder.BorderSizePixel = 0
            CommandListCloseHolder.Position = UDim2.new(1.00999999, 0, 0, 0)
            CommandListCloseHolder.Size = UDim2.new(0.100000001, 0, 1, 0)

            CloseCorner.CornerRadius = UDim.new(0.25, 0)
            CloseCorner.Name = "CloseCorner"
            CloseCorner.Parent = CommandListCloseHolder

            CloseButton.Name = "CloseButton"
            CloseButton.Parent = CommandListCloseHolder
            CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CloseButton.BackgroundTransparency = 1.000
            CloseButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
            CloseButton.BorderSizePixel = 0
            CloseButton.Size = UDim2.new(0.85, 0, 1, 0)
            CloseButton.Position = UDim2.new(0.1, 0, 0, 0)
            CloseButton.Image = "rbxassetid://10747384394"

            CommandTip.Name = "CommandTip"
            CommandTip.Parent = ScopersCommands
            CommandTip.Visible = false
            CommandTip.TextWrapped = true
            CommandTip.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            CommandTip.BackgroundTransparency = 0.500
            CommandTip.BorderColor3 = Color3.fromRGB(0, 0, 0)
            CommandTip.BorderSizePixel = 0
            CommandTip.Position = UDim2.new(1.07973707, 0, 0.0548340566, 0)
            CommandTip.Size = UDim2.new(0.15, 0, 0.1, 0)
            CommandTip.Font = Enum.Font.SourceSans
            CommandTip.TextColor3 = Color3.fromRGB(255, 255, 255)
            CommandTip.TextSize = 22.000
            CommandTip.Font = Enum.Font.Gotham
            CommandTip.TextStrokeTransparency = 0.000

            CommandTipCorner.CornerRadius = UDim.new(0.100000001, 0)
            CommandTipCorner.Name = "CommandTipCorner"
            CommandTipCorner.Parent = CommandTip

            InputService.InputBegan:Connect(function(Input, GameProcessed)
                if GameProcessed then return end

                if Input.KeyCode == ScopersCMD.PrefixMap[getgenv().ScopersCMD.Prefix] then
                    task.spawn(function()
                        InputBar:CaptureFocus()
                        RunService.Heartbeat:Wait()
                        InputBar.Text = ""
                    end)
                end
            end)

            InputBar.Focused:Connect(function()
                TweenUI(Main, UDim2.new(0.45, 0, 0.85, 0), 2)
            end)

            InputBar.FocusLost:Connect(function(isEnter)
                TweenUI(Main, UDim2.new(0.45, 0, 1, 0), 2)
                
                if isEnter and InputBar.Text ~= "" then
                    pcall(function()
                        TextChatService.TextChannels.RBXGeneral:SendAsync(getgenv().ScopersCMD.Prefix .. InputBar.Text)
                    end)
                end
                
                InputBar.Text = ""
            end)

            CloseButton.MouseButton1Click:Connect(function()
                TweenUI(CommandList, UDim2.new(0.45, 0, -1, 0), 10)
                task.wait(0.1)
                CommandList.Visible = false
            end)

            for _, Variant in ipairs(CommandsListScroll:GetChildren()) do
                if Variant:IsA("TextLabel") then
                    table.insert(getgenv().ScopersCMD.CommandLabels, Variant)
                end
            end

            CommandListInputBar:GetPropertyChangedSignal("Text"):Connect(function()
                local searchText = CommandListInputBar.Text
                FilterCommands(searchText)
            end)

            for _, GetLabel in ipairs(getgenv().ScopersCMD.CommandLabels) do
                GetLabel.MouseEnter:Connect(function()
                    CommandTip.Visible = true
                    CommandTip.Text = getgenv().ScopersCMD.CommandTips[GetLabel.Text] or "No Description Available"
                end)

                GetLabel.MouseLeave:Connect(function()
                    CommandTip.Visible = false
                end)
            end

            RunService.RenderStepped:Connect(function()
                if CommandTip.Visible then
                    CommandTip.Position = UDim2.new(0, Mouse.X + getgenv().ScopersCMD.CommandOffset.X, 0, Mouse.Y + getgenv().ScopersCMD.CommandOffset.Y)
                end
            end)

            InputService.InputBegan:Connect(function(Input, GameProcessed)
                if GameProcessed then
                    return
                end

                if not getgenv().ScopersCMD.FlySettings.Flying then return end
                if Input.UserInputType ~= Enum.UserInputType.Keyboard then return end
                if Input.KeyCode == Enum.KeyCode.W then getgenv().ScopersCMD.FlySettings.Controls.F = 1 end
                if Input.KeyCode == Enum.KeyCode.S then getgenv().ScopersCMD.FlySettings.Controls.B = 1 end
                if Input.KeyCode == Enum.KeyCode.A then getgenv().ScopersCMD.FlySettings.Controls.L = 1 end
                if Input.KeyCode == Enum.KeyCode.D then getgenv().ScopersCMD.FlySettings.Controls.R = 1 end
                if Input.KeyCode == Enum.KeyCode.E then getgenv().ScopersCMD.FlySettings.Controls.E = 1 end
                if Input.KeyCode == Enum.KeyCode.Q then getgenv().ScopersCMD.FlySettings.Controls.Q = 1 end
            end)

            InputService.InputEnded:Connect(function(Input, GameProcessed)
                if GameProcessed then
                    return
                end

                if not getgenv().ScopersCMD.FlySettings.Flying then return end
                if Input.UserInputType ~= Enum.UserInputType.Keyboard then return end
                if Input.KeyCode == Enum.KeyCode.W then getgenv().ScopersCMD.FlySettings.Controls.F = 0 end
                if Input.KeyCode == Enum.KeyCode.S then getgenv().ScopersCMD.FlySettings.Controls.B = 0 end
                if Input.KeyCode == Enum.KeyCode.A then getgenv().ScopersCMD.FlySettings.Controls.L = 0 end
                if Input.KeyCode == Enum.KeyCode.D then getgenv().ScopersCMD.FlySettings.Controls.R = 0 end
                if Input.KeyCode == Enum.KeyCode.E then getgenv().ScopersCMD.FlySettings.Controls.E = 0 end
                if Input.KeyCode == Enum.KeyCode.Q then getgenv().ScopersCMD.FlySettings.Controls.Q = 0 end
            end)

            RunService.Heartbeat:Connect(function()
                if getgenv().ScopersCMD.PlayerSettings.Speed.Enabled then
                    SpeedVelocity(Player.Character:FindFirstChild("HumanoidRootPart"), Player.Character:FindFirstChild("Humanoid"))
                end
            end)

            -- Welcome Message

            ScopersNotification(
                CoreGui:FindFirstChild("ScopersCommands"),
                "Scoper's Commands",
                "Welcome to Scoper's Commands, " .. Player.DisplayName .. ". Use " .. getgenv().ScopersCMD.Prefix .. " to execute commands.",
                10
            )

            if not Success then
                return
            end
        end)
        
        LoginMainKey.TextColor3 = Color3.fromRGB(100, 255, 100)
        LoginMainKey.Text = "Correct Key"
    else
        LoginMainKey.TextColor3 = Color3.fromRGB(255, 100, 100)
        LoginMainKey.Text = keyExpectance and "Incorrect Key" or "Not Whitelisted"

        task.delay(1.8, function()
            if LoginMainKey and LoginMainKey.Parent then
                LoginMainKey.TextColor3 = Color3.fromRGB(255, 255, 255)
                LoginMainKey.Text = ""
            end
        end)
    end
end)
