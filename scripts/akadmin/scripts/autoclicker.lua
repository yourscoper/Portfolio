local pl = game:GetService("Players").LocalPlayer
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local vim = game:GetService("VirtualInputManager")
local ts = game:GetService("TweenService")

local sg = Instance.new("ScreenGui")
sg.Name = "AC"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = pl:WaitForChild("PlayerGui")

local mf = Instance.new("Frame")
mf.Size = UDim2.new(0, 220, 0, 120)
mf.Position = UDim2.new(0.5, -110, 0.3, -60)
mf.BackgroundColor3 = Color3.new(0, 0, 0)
mf.BackgroundTransparency = 0.8
mf.BorderSizePixel = 0
mf.Parent = sg

local mc = Instance.new("UICorner")
mc.CornerRadius = UDim.new(0, 12)
mc.Parent = mf

local tb = Instance.new("Frame")
tb.Size = UDim2.new(1, 0, 0, 30)
tb.Position = UDim2.new(0, 0, 0, 0)
tb.BackgroundTransparency = 1
tb.Parent = mf

local tl = Instance.new("TextLabel")
tl.Size = UDim2.new(1, -60, 1, 0)
tl.Position = UDim2.new(0, 30, 0, 0)
tl.BackgroundTransparency = 1
tl.Text = "Auto Clicker"
tl.TextColor3 = Color3.new(1, 1, 1)
tl.TextSize = 14
tl.Font = Enum.Font.GothamBold
tl.Parent = tb

local cb = Instance.new("TextButton")
cb.Size = UDim2.new(0, 20, 0, 20)
cb.Position = UDim2.new(1, -25, 0, 5)
cb.BackgroundColor3 = Color3.new(0, 0, 0)
cb.BackgroundTransparency = 0.6
cb.BorderSizePixel = 0
cb.Text = "X"
cb.TextColor3 = Color3.new(1, 1, 1)
cb.TextSize = 12
cb.Font = Enum.Font.GothamBold
cb.Parent = tb

local cc = Instance.new("UICorner")
cc.CornerRadius = UDim.new(0, 6)
cc.Parent = cb

local mb = Instance.new("TextButton")
mb.Size = UDim2.new(0, 20, 0, 20)
mb.Position = UDim2.new(1, -50, 0, 5)
mb.BackgroundColor3 = Color3.new(0, 0, 0)
mb.BackgroundTransparency = 0.6
mb.BorderSizePixel = 0
mb.Text = "-"
mb.TextColor3 = Color3.new(1, 1, 1)
mb.TextSize = 14
mb.Font = Enum.Font.GothamBold
mb.Parent = tb

local mn = Instance.new("UICorner")
mn.CornerRadius = UDim.new(0, 6)
mn.Parent = mb

local al = Instance.new("TextLabel")
al.Size = UDim2.new(0, 70, 0, 15)
al.Position = UDim2.new(0, 8, 0, 8)
al.BackgroundTransparency = 1
al.Text = "AK ADMIN"
al.TextColor3 = Color3.new(1, 1, 1)
al.TextSize = 10
al.Font = Enum.Font.Gotham
al.TextXAlignment = Enum.TextXAlignment.Left
al.Parent = mf

local ct = Instance.new("Frame")
ct.Name = "CT"
ct.Size = UDim2.new(1, 0, 1, -30)
ct.Position = UDim2.new(0, 0, 0, 30)
ct.BackgroundTransparency = 1
ct.Parent = mf

local sl = Instance.new("TextLabel")
sl.Size = UDim2.new(0, 80, 0, 15)
sl.Position = UDim2.new(0, 10, 0, 10)
sl.BackgroundTransparency = 1
sl.Text = "Speed (ms)"
sl.TextColor3 = Color3.new(1, 1, 1)
sl.TextSize = 11
sl.Font = Enum.Font.Gotham
sl.TextXAlignment = Enum.TextXAlignment.Left
sl.Parent = ct

local vl = Instance.new("TextLabel")
vl.Size = UDim2.new(0, 40, 0, 15)
vl.Position = UDim2.new(1, -50, 0, 10)
vl.BackgroundTransparency = 1
vl.Text = "1"
vl.TextColor3 = Color3.new(1, 1, 1)
vl.TextSize = 11
vl.Font = Enum.Font.GothamBold
vl.Parent = ct

local sb = Instance.new("Frame")
sb.Size = UDim2.new(0, 180, 0, 4)
sb.Position = UDim2.new(0, 20, 0, 33)
sb.BackgroundColor3 = Color3.new(0, 0, 0)
sb.BackgroundTransparency = 0.5
sb.BorderSizePixel = 0
sb.Parent = ct

local sr = Instance.new("UICorner")
sr.CornerRadius = UDim.new(1, 0)
sr.Parent = sb

local sd = Instance.new("Frame")
sd.Size = UDim2.new(0, 16, 0, 16)
sd.Position = UDim2.new(0, -8, 0.5, -8)
sd.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
sd.BackgroundTransparency = 0.2
sd.BorderSizePixel = 0
sd.Parent = sb

local sc = Instance.new("UICorner")
sc.CornerRadius = UDim.new(1, 0)
sc.Parent = sd

local tg = Instance.new("TextButton")
tg.Size = UDim2.new(0, 100, 0, 28)
tg.Position = UDim2.new(0.5, -50, 0, 55)
tg.BackgroundColor3 = Color3.new(0, 0, 0)
tg.BackgroundTransparency = 0.5
tg.BorderSizePixel = 0
tg.Text = "OFF"
tg.TextColor3 = Color3.new(0.9, 0.9, 0.9)
tg.TextSize = 13
tg.Font = Enum.Font.GothamBold
tg.Parent = ct

local tc = Instance.new("UICorner")
tc.CornerRadius = UDim.new(0, 8)
tc.Parent = tg

local pf = Instance.new("Frame")
pf.Size = UDim2.new(0, 96, 0, 30)
pf.Position = UDim2.new(0.5, -48, 0.6, -15)
pf.BackgroundTransparency = 1
pf.ZIndex = 10
pf.Parent = sg

local im = Instance.new("ImageLabel")
im.Size = UDim2.new(0, 96, 0, 96)
im.Position = UDim2.new(0, 0, 0, 0)
im.BackgroundTransparency = 1
im.Image = "rbxasset://textures/Cursors/KeyboardMouse/ArrowFarCursor.png"
im.Active = false
im.Parent = pf

local ms = 1
local en = false
local mi = false

local function dr(fr, hd)
    local dg = false
    local ix, iy
    local ox, oy
    
    hd.InputBegan:Connect(function(ip)
        if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
            dg = true
            ix = ip.Position.X
            iy = ip.Position.Y
            ox = fr.Position.X.Offset
            oy = fr.Position.Y.Offset
            
            ip.Changed:Connect(function()
                if ip.UserInputState == Enum.UserInputState.End then
                    dg = false
                end
            end)
        end
    end)
    
    uis.InputChanged:Connect(function(ip)
        if dg and (ip.UserInputType == Enum.UserInputType.MouseMovement or ip.UserInputType == Enum.UserInputType.Touch) then
            local dx = ip.Position.X - ix
            local dy = ip.Position.Y - iy
            fr.Position = UDim2.new(fr.Position.X.Scale, ox + dx, fr.Position.Y.Scale, oy + dy)
        end
    end)
end

dr(mf, tb)
dr(pf, pf)

local dx = false

sd.InputBegan:Connect(function(ip)
    if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
        dx = true
    end
end)

uis.InputEnded:Connect(function(ip)
    if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
        dx = false
    end
end)

uis.InputChanged:Connect(function(ip)
    if dx and (ip.UserInputType == Enum.UserInputType.MouseMovement or ip.UserInputType == Enum.UserInputType.Touch) then
        local ps = (ip.Position.X - sb.AbsolutePosition.X) / sb.AbsoluteSize.X
        ps = math.clamp(ps, 0, 1)
        sd.Position = UDim2.new(ps, -8, 0.5, -8)
        ms = math.floor(1 + (ps * 99))
        vl.Text = tostring(ms)
    end
end)

tg.MouseButton1Click:Connect(function()
    en = not en
    if en then
        tg.Text = "ON"
        tg.TextColor3 = Color3.new(1, 1, 1)
    else
        tg.Text = "OFF"
        tg.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    end
end)

cb.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

mb.MouseButton1Click:Connect(function()
    mi = not mi
    local ti = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    if mi then
        ct.Visible = false
        local tw = ts:Create(mf, ti, {Size = UDim2.new(0, 220, 0, 30)})
        tw:Play()
        mb.Text = "+"
    else
        ct.Visible = true
        local tw = ts:Create(mf, ti, {Size = UDim2.new(0, 220, 0, 120)})
        tw:Play()
        mb.Text = "-"
    end
end)

local lt = 0
rs.RenderStepped:Connect(function()
    if en then
        local cu = tick()
        if cu - lt >= ms / 1000 then
            lt = cu
            local px = im.AbsolutePosition.X + 42
            local py = im.AbsolutePosition.Y + 80
            vim:SendMouseButtonEvent(px, py, 0, true, game, 0)
            task.wait(0.01)
            vim:SendMouseButtonEvent(px, py, 0, false, game, 0)
        end
    end
end)
