--!strict

-- Clean up previous instance
if _G.a then
    local v1, v2, v3 = pairs(_G.a)
    while true do
        local v4
        v3, v4 = v1(v2, v3)
        if v3 == nil then
            break
        end
        v4:Disconnect()
    end
    _G.a = nil
end

repeat
    task.wait()
until game.Players.LocalPlayer

local Pl = game:GetService("Players")
local Ui = game:GetService("UserInputService")
local Rs = game:GetService("RunService")
local Ts = game:GetService("TweenService")
local Cg = game:GetService("CoreGui")

local Lp = Pl.LocalPlayer
local _LocalPlayer = Lp

local function rS()
    local cs = {}
    for i = 1, math.random(10, 20) do
        cs[i] = string.char(math.random(32, 126))
    end
    return table.concat(cs)
end

local Sg = Instance.new("ScreenGui")
Sg.Name = rS()
Sg.ResetOnSpawn = false

if get_hidden_gui or gethui then
    Sg.Parent = (get_hidden_gui or gethui)()
elseif syn and syn.protect_gui then
    syn.protect_gui(Sg)
    Sg.Parent = Cg
else
    Sg.Parent = Cg
end

local Mf = Instance.new("Frame")
Mf.Name = rS()
Mf.Parent = Sg
Mf.Active = true
Mf.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Mf.BackgroundTransparency = 0.7
Mf.BorderSizePixel = 0
Mf.Position = UDim2.new(0.5, -100, 0.5, -50)
Mf.Size = UDim2.new(0, 200, 0, 100)
Mf.ZIndex = 10

local Cr = Instance.new("UICorner")
Cr.CornerRadius = UDim.new(0, 8)
Cr.Parent = Mf

local Ak = Instance.new("TextLabel")
Ak.Name = "AKAdmin"
Ak.Parent = Mf
Ak.BackgroundTransparency = 1
Ak.Position = UDim2.new(0, 5, 0, 5)
Ak.Size = UDim2.new(0, 60, 0, 20)
Ak.Font = Enum.Font.SourceSansBold
Ak.Text = "AK ADMIN"
Ak.TextColor3 = Color3.new(1, 1, 1)
Ak.TextSize = 10
Ak.TextXAlignment = Enum.TextXAlignment.Left
Ak.ZIndex = 11

local Ti = Instance.new("TextLabel")
Ti.Name = "Title"
Ti.Parent = Mf
Ti.BackgroundTransparency = 1
Ti.Position = UDim2.new(0, 30, 0, 5)
Ti.Size = UDim2.new(1, -70, 0, 20)
Ti.Font = Enum.Font.SourceSansBold
Ti.Text = "Invisible"
Ti.TextColor3 = Color3.new(1, 1, 1)
Ti.TextSize = 16
Ti.TextXAlignment = Enum.TextXAlignment.Center
Ti.ZIndex = 11

local Cb = Instance.new("TextButton")
Cb.Name = "CloseButton"
Cb.Parent = Mf
Cb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Cb.BackgroundTransparency = 0.5
Cb.BorderSizePixel = 0
Cb.Position = UDim2.new(1, -25, 0, 5)
Cb.Size = UDim2.new(0, 18, 0, 18)
Cb.Font = Enum.Font.SourceSans
Cb.Text = "X"
Cb.TextColor3 = Color3.new(1, 1, 1)
Cb.TextSize = 10
Cb.ZIndex = 11

local Cc = Instance.new("UICorner")
Cc.CornerRadius = UDim.new(0, 4)
Cc.Parent = Cb

local Mb = Instance.new("TextButton")
Mb.Name = "MinimizeButton"
Mb.Parent = Mf
Mb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Mb.BackgroundTransparency = 0.5
Mb.BorderSizePixel = 0
Mb.Position = UDim2.new(1, -50, 0, 5)
Mb.Size = UDim2.new(0, 18, 0, 18)
Mb.Font = Enum.Font.SourceSansBold
Mb.Text = "−"
Mb.TextColor3 = Color3.new(1, 1, 1)
Mb.TextSize = 12
Mb.ZIndex = 11

local Mc = Instance.new("UICorner")
Mc.CornerRadius = UDim.new(0, 4)
Mc.Parent = Mb

local Tb = Instance.new("TextButton")
Tb.Name = "ToggleButton"
Tb.Parent = Mf
Tb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Tb.BackgroundTransparency = 0.5
Tb.BorderSizePixel = 0
Tb.Position = UDim2.new(0, 10, 0, 35)
Tb.Size = UDim2.new(0, 120, 0, 30)
Tb.Font = Enum.Font.SourceSans
Tb.Text = "Make Invisible"
Tb.TextColor3 = Color3.new(1, 1, 1)
Tb.TextSize = 12
Tb.ZIndex = 11

local Tc = Instance.new("UICorner")
Tc.CornerRadius = UDim.new(0, 6)
Tc.Parent = Tb

local Kl = Instance.new("TextLabel")
Kl.Name = "KeybindLabel"
Kl.Parent = Mf
Kl.BackgroundTransparency = 1
Kl.Position = UDim2.new(0, 135, 0, 25)
Kl.Size = UDim2.new(0, 55, 0, 10)
Kl.Font = Enum.Font.SourceSans
Kl.Text = "Keybind"
Kl.TextColor3 = Color3.new(1, 1, 1)
Kl.TextSize = 9
Kl.TextXAlignment = Enum.TextXAlignment.Center
Kl.ZIndex = 11

local Kb = Instance.new("TextButton")
Kb.Name = "KeybindButton"
Kb.Parent = Mf
Kb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Kb.BackgroundTransparency = 0.5
Kb.BorderSizePixel = 0
Kb.Position = UDim2.new(0, 135, 0, 35)
Kb.Size = UDim2.new(0, 55, 0, 30)
Kb.Font = Enum.Font.SourceSans
Kb.Text = "G"
Kb.TextColor3 = Color3.new(1, 1, 1)
Kb.TextSize = 10
Kb.ZIndex = 11

local Kc = Instance.new("UICorner")
Kc.CornerRadius = UDim.new(0, 4)
Kc.Parent = Kb

local function mD(gi)
    local dg = false
    local di = nil
    local ds = nil
    local sp = nil

    local function up(ip)
        local dt = ip.Position - ds
        local np = UDim2.new(sp.X.Scale, sp.X.Offset + dt.X, sp.Y.Scale, sp.Y.Offset + dt.Y)
        Ts:Create(gi, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = np}):Play()
    end

    gi.InputBegan:Connect(function(ip)
        if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
            dg = true
            ds = ip.Position
            sp = gi.Position
            
            ip.Changed:Connect(function()
                if ip.UserInputState == Enum.UserInputState.End then
                    dg = false
                end
            end)
        end
    end)

    gi.InputChanged:Connect(function(ip)
        if ip.UserInputType == Enum.UserInputType.MouseMovement or ip.UserInputType == Enum.UserInputType.Touch then
            di = ip
        end
    end)

    Ui.InputChanged:Connect(function(ip)
        if ip == di and dg then
            up(ip)
        end
    end)
end

mD(Mf)

local iM = false
local oS = UDim2.new(0, 200, 0, 100)

local function tM()
    if iM then
        Ts:Create(Mf, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = oS}):Play()
        Mb.Text = "−"
        Tb.Visible = true
        Kb.Visible = true
        Kl.Visible = true
        iM = false
    else
        Ts:Create(Mf, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 200, 0, 30)}):Play()
        Mb.Text = "+"
        Tb.Visible = false
        Kb.Visible = false
        Kl.Visible = false
        iM = true
    end
end

local cK = Enum.KeyCode.G
local iB = false

local function sK(ky)
    cK = ky
    Kb.Text = ky.Name
    Kb.TextColor3 = Color3.new(1, 1, 1)
end

-- Second script's invisibility variables and functions
local u6 = nil
local u7 = nil
local u8 = nil
local u9 = false
local u10 = {}

local function u16()
    u6 = _LocalPlayer.Character or _LocalPlayer.CharacterAdded:Wait()
    u7 = u6:WaitForChild('Humanoid')
    u8 = u6:WaitForChild('HumanoidRootPart')
    u10 = {}
    local v11 = u6
    local v12, v13, v14 = pairs(v11:GetDescendants())
    while true do
        local v15
        v14, v15 = v12(v13, v14)
        if v14 == nil then
            break
        end
        if v15:IsA('BasePart') and v15.Transparency == 0 then
            u10[#u10 + 1] = v15
        end
    end
end

u16()

local function toggleInvis()
    u9 = not u9
    local v26, v27, v28 = pairs(u10)
    while true do
        local v29
        v28, v29 = v26(v27, v28)
        if v28 == nil then
            break
        end
        v29.Transparency = v29.Transparency == 0 and 0.5 or 0
    end
    
    if u9 then
        Tb.Text = "Make Visible"
        Tb.BackgroundTransparency = 0.3
    else
        Tb.Text = "Make Invisible"
        Tb.BackgroundTransparency = 0.5
    end
end

Tb.MouseButton1Click:Connect(toggleInvis)

Cb.MouseButton1Click:Connect(function()
    if u9 then
        u9 = false
        local v26, v27, v28 = pairs(u10)
        while true do
            local v29
            v28, v29 = v26(v27, v28)
            if v28 == nil then
                break
            end
            v29.Transparency = 0
        end
    end
    Sg:Destroy()
end)

Mb.MouseButton1Click:Connect(tM)

Kb.MouseButton1Click:Connect(function()
    if iB then return end
    iB = true
    Kb.Text = "..."
    Kb.TextColor3 = Color3.new(1, 1, 0)
    
    local cn
    cn = Ui.InputBegan:Connect(function(ip, gP)
        if not gP and ip.UserInputType == Enum.UserInputType.Keyboard then
            sK(ip.KeyCode)
            iB = false
            cn:Disconnect()
        end
    end)
end)

-- Keybind connection
local v31 = {nil, nil}
local v32 = _LocalPlayer
v31[1] = _LocalPlayer:GetMouse().KeyDown:Connect(function(p33)
    if p33 == 'g' then
        u9 = not u9
        local v34, v35, v36 = pairs(u10)
        while true do
            local v37
            v36, v37 = v34(v35, v36)
            if v36 == nil then
                break
            end
            v37.Transparency = v37.Transparency == 0 and 0.5 or 0
        end
        
        if u9 then
            Tb.Text = "Make Visible"
            Tb.BackgroundTransparency = 0.3
        else
            Tb.Text = "Make Invisible"
            Tb.BackgroundTransparency = 0.5
        end
    end
end)

-- Heartbeat connection for invisibility
v31[2] = Rs.Heartbeat:Connect(function()
    if u9 then
        local _CFrame = u8.CFrame
        local _CameraOffset = u7.CameraOffset
        local v40 = _CFrame * CFrame.new(0, -200, 0)
        local v41 = u7
        local v42 = u8
        local _Position = v40:ToObjectSpace(CFrame.new(_CFrame.Position)).Position
        v42.CFrame = v40
        v41.CameraOffset = _Position
        Rs.RenderStepped:Wait()
        local v44 = u7
        u8.CFrame = _CFrame
        v44.CameraOffset = _CameraOffset
    end
end)

_LocalPlayer.CharacterAdded:Connect(function()
    u9 = false
    Tb.Text = "Make Invisible"
    Tb.BackgroundTransparency = 0.5
    u16()
end)

Sg.AncestryChanged:Connect(function()
    if not Sg.Parent then
        if u9 then
            u9 = false
            local v26, v27, v28 = pairs(u10)
            while true do
                local v29
                v28, v29 = v26(v27, v28)
                if v28 == nil then
                    break
                end
                v29.Transparency = 0
            end
        end
    end
end)

_G.a = v31
