local pl = game:GetService("Players")
local ts = game:GetService("TweenService")
local hs = game:GetService("HttpService")
local lp = pl.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

local sg = Instance.new("ScreenGui")
sg.Name = "PositionSaver"
sg.ResetOnSpawn = false
sg.Parent = pg

local mf = Instance.new("Frame")
mf.Size = UDim2.new(0, 280, 0, 320)
mf.Position = UDim2.new(0.5, -140, 0.5, -160)
mf.BackgroundColor3 = Color3.new(0, 0, 0)
mf.BackgroundTransparency = 0.7
mf.BorderSizePixel = 0
mf.Parent = sg

local cr = Instance.new("UICorner")
cr.CornerRadius = UDim.new(0, 12)
cr.Parent = mf

local tb = Instance.new("Frame")
tb.Size = UDim2.new(1, 0, 0, 30)
tb.Position = UDim2.new(0, 0, 0, 0)
tb.BackgroundTransparency = 1
tb.Parent = mf

local t1 = Instance.new("TextLabel")
t1.Size = UDim2.new(0, 100, 0, 25)
t1.Position = UDim2.new(0, 8, 0, 3)
t1.BackgroundTransparency = 1
t1.Text = "AK ADMIN"
t1.TextColor3 = Color3.new(1, 1, 1)
t1.TextSize = 10
t1.Font = Enum.Font.GothamBold
t1.TextXAlignment = Enum.TextXAlignment.Left
t1.Parent = tb

local t2 = Instance.new("TextLabel")
t2.Size = UDim2.new(1, -40, 0, 25)
t2.Position = UDim2.new(0, 20, 0, 3)
t2.BackgroundTransparency = 1
t2.Text = "POSITION SAVER"
t2.TextColor3 = Color3.new(1, 1, 1)
t2.TextSize = 14
t2.Font = Enum.Font.GothamBold
t2.Parent = tb

local cb = Instance.new("TextButton")
cb.Size = UDim2.new(0, 24, 0, 24)
cb.Position = UDim2.new(1, -27, 0, 3)
cb.BackgroundColor3 = Color3.new(0, 0, 0)
cb.BackgroundTransparency = 0.5
cb.Text = "X"
cb.TextColor3 = Color3.new(1, 1, 1)
cb.TextSize = 14
cb.Font = Enum.Font.GothamBold
cb.Parent = tb

local cc = Instance.new("UICorner")
cc.CornerRadius = UDim.new(0, 6)
cc.Parent = cb

local mb = Instance.new("TextButton")
mb.Size = UDim2.new(0, 24, 0, 24)
mb.Position = UDim2.new(1, -54, 0, 3)
mb.BackgroundColor3 = Color3.new(0, 0, 0)
mb.BackgroundTransparency = 0.5
mb.Text = "-"
mb.TextColor3 = Color3.new(1, 1, 1)
mb.TextSize = 16
mb.Font = Enum.Font.GothamBold
mb.Parent = tb

local mc = Instance.new("UICorner")
mc.CornerRadius = UDim.new(0, 6)
mc.Parent = mb

local sf = Instance.new("ScrollingFrame")
sf.Size = UDim2.new(1, -16, 1, -94)
sf.Position = UDim2.new(0, 8, 0, 35)
sf.BackgroundTransparency = 1
sf.ScrollBarThickness = 4
sf.BorderSizePixel = 0
sf.Visible = true
sf.Parent = mf

local ul = Instance.new("UIListLayout")
ul.Padding = UDim.new(0, 6)
ul.SortOrder = Enum.SortOrder.LayoutOrder
ul.Parent = sf

local nt = Instance.new("TextLabel")
nt.Size = UDim2.new(1, -16, 0, 24)
nt.Position = UDim2.new(0, 8, 1, -59)
nt.BackgroundTransparency = 1
nt.Text = "Your positions are saved for every game. They won't get deleted."
nt.TextColor3 = Color3.new(1, 1, 1)
nt.TextSize = 8
nt.Font = Enum.Font.Gotham
nt.TextWrapped = true
nt.TextXAlignment = Enum.TextXAlignment.Center
nt.Visible = true
nt.Parent = mf

local sb = Instance.new("TextButton")
sb.Size = UDim2.new(1, -16, 0, 30)
sb.Position = UDim2.new(0, 8, 1, -35)
sb.BackgroundColor3 = Color3.new(0, 0, 0)
sb.BackgroundTransparency = 0.5
sb.Text = "SAVE POSITION"
sb.TextColor3 = Color3.new(1, 1, 1)
sb.TextSize = 12
sb.Font = Enum.Font.GothamBold
sb.Visible = true
sb.Parent = mf

local sc = Instance.new("UICorner")
sc.CornerRadius = UDim.new(0, 6)
sc.Parent = sb

local dr = false
local ds, dp

tb.InputBegan:Connect(function(ip)
    if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
        dr = true
        ds = ip.Position
        dp = mf.Position
        ip.Changed:Connect(function()
            if ip.UserInputState == Enum.UserInputState.End then
                dr = false
            end
        end)
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(ip)
    if dr and (ip.UserInputType == Enum.UserInputType.MouseMovement or ip.UserInputType == Enum.UserInputType.Touch) then
        local dl = ip.Position - ds
        mf.Position = UDim2.new(dp.X.Scale, dp.X.Offset + dl.X, dp.Y.Scale, dp.Y.Offset + dl.Y)
    end
end)

cb.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

local mn = false
mb.MouseButton1Click:Connect(function()
    mn = not mn
    local sz = mn and UDim2.new(0, 280, 0, 30) or UDim2.new(0, 280, 0, 320)
    sf.Visible = not mn
    sb.Visible = not mn
    nt.Visible = not mn
    ts:Create(mf, TweenInfo.new(0.3), {Size = sz}):Play()
end)

local fn = "positions_" .. game.PlaceId .. ".json"
local gm = game.PlaceId

local function ld()
    if isfile(fn) then
        local dt = readfile(fn)
        return hs:JSONDecode(dt)
    end
    return {}
end

local function sv(dt)
    writefile(fn, hs:JSONEncode(dt))
end

local function cr_fr(nm, gn, ps, gi)
    local fr = Instance.new("Frame")
    fr.Size = UDim2.new(1, 0, 0, 60)
    fr.BackgroundColor3 = Color3.new(0, 0, 0)
    fr.BackgroundTransparency = 0.6
    fr.BorderSizePixel = 0
    fr.Parent = sf
    
    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(0, 6)
    fc.Parent = fr
    
    local im = Instance.new("ImageLabel")
    im.Size = UDim2.new(0, 45, 0, 45)
    im.Position = UDim2.new(0, 8, 0, 8)
    im.BackgroundTransparency = 1
    im.Image = "rbxthumb://type=Asset&id=" .. gi .. "&w=150&h=150"
    im.Parent = fr
    
    local ic = Instance.new("UICorner")
    ic.CornerRadius = UDim.new(0, 4)
    ic.Parent = im
    
    local tl = Instance.new("TextLabel")
    tl.Size = UDim2.new(1, -115, 0, 20)
    tl.Position = UDim2.new(0, 60, 0, 8)
    tl.BackgroundTransparency = 1
    tl.Text = nm
    tl.TextColor3 = Color3.new(1, 1, 1)
    tl.TextSize = 11
    tl.Font = Enum.Font.GothamBold
    tl.TextXAlignment = Enum.TextXAlignment.Left
    tl.TextTruncate = Enum.TextTruncate.AtEnd
    tl.Parent = fr
    
    local gl = Instance.new("TextLabel")
    gl.Size = UDim2.new(1, -115, 0, 16)
    gl.Position = UDim2.new(0, 60, 0, 28)
    gl.BackgroundTransparency = 1
    gl.Text = gn
    gl.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    gl.TextSize = 9
    gl.Font = Enum.Font.Gotham
    gl.TextXAlignment = Enum.TextXAlignment.Left
    gl.TextTruncate = Enum.TextTruncate.AtEnd
    gl.Parent = fr
    
    local tp = Instance.new("TextButton")
    tp.Size = UDim2.new(0, 45, 0, 20)
    tp.Position = UDim2.new(1, -52, 0, 8)
    tp.BackgroundColor3 = Color3.new(0, 0, 0)
    tp.BackgroundTransparency = 0.4
    tp.Text = "TP"
    tp.TextColor3 = Color3.new(1, 1, 1)
    tp.TextSize = 10
    tp.Font = Enum.Font.GothamBold
    tp.Parent = fr
    
    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(0, 4)
    tc.Parent = tp
    
    local dl = Instance.new("TextButton")
    dl.Size = UDim2.new(0, 45, 0, 20)
    dl.Position = UDim2.new(1, -52, 0, 32)
    dl.BackgroundColor3 = Color3.new(0, 0, 0)
    dl.BackgroundTransparency = 0.4
    dl.Text = "DEL"
    dl.TextColor3 = Color3.new(1, 1, 1)
    dl.TextSize = 10
    dl.Font = Enum.Font.GothamBold
    dl.Parent = fr
    
    local dc = Instance.new("UICorner")
    dc.CornerRadius = UDim.new(0, 4)
    dc.Parent = dl
    
    tp.MouseButton1Click:Connect(function()
        if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            lp.Character.HumanoidRootPart.CFrame = CFrame.new(ps.X, ps.Y, ps.Z)
        end
    end)
    
    dl.MouseButton1Click:Connect(function()
        local dt = ld()
        for i, v in ipairs(dt) do
            if v.nm == nm and v.ps.X == ps.X and v.ps.Y == ps.Y and v.ps.Z == ps.Z then
                table.remove(dt, i)
                break
            end
        end
        sv(dt)
        fr:Destroy()
    end)
    
    sf.CanvasSize = UDim2.new(0, 0, 0, ul.AbsoluteContentSize.Y)
end

local function ld_ps()
    for _, ch in ipairs(sf:GetChildren()) do
        if ch:IsA("Frame") then
            ch:Destroy()
        end
    end
    
    local dt = ld()
    for _, ps in ipairs(dt) do
        cr_fr(ps.nm, ps.gn, ps.ps, ps.gi)
    end
end

sb.MouseButton1Click:Connect(function()
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local ip = Instance.new("ScreenGui")
    ip.Name = "InputPrompt"
    ip.Parent = pg
    
    local bf = Instance.new("Frame")
    bf.Size = UDim2.new(1, 0, 1, 0)
    bf.BackgroundColor3 = Color3.new(0, 0, 0)
    bf.BackgroundTransparency = 0.5
    bf.BorderSizePixel = 0
    bf.Parent = ip
    
    local pf = Instance.new("Frame")
    pf.Size = UDim2.new(0, 240, 0, 100)
    pf.Position = UDim2.new(0.5, -120, 0.5, -50)
    pf.BackgroundColor3 = Color3.new(0, 0, 0)
    pf.BackgroundTransparency = 0.3
    pf.BorderSizePixel = 0
    pf.Parent = ip
    
    local pc = Instance.new("UICorner")
    pc.CornerRadius = UDim.new(0, 8)
    pc.Parent = pf
    
    local pt = Instance.new("TextLabel")
    pt.Size = UDim2.new(1, -16, 0, 24)
    pt.Position = UDim2.new(0, 8, 0, 8)
    pt.BackgroundTransparency = 1
    pt.Text = "Enter Position Name:"
    pt.TextColor3 = Color3.new(1, 1, 1)
    pt.TextSize = 11
    pt.Font = Enum.Font.GothamBold
    pt.TextXAlignment = Enum.TextXAlignment.Left
    pt.Parent = pf
    
    local tb = Instance.new("TextBox")
    tb.Size = UDim2.new(1, -16, 0, 26)
    tb.Position = UDim2.new(0, 8, 0, 36)
    tb.BackgroundColor3 = Color3.new(0, 0, 0)
    tb.BackgroundTransparency = 0.5
    tb.Text = ""
    tb.PlaceholderText = "Position name..."
    tb.TextColor3 = Color3.new(1, 1, 1)
    tb.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
    tb.TextSize = 11
    tb.Font = Enum.Font.Gotham
    tb.ClearTextOnFocus = false
    tb.Parent = pf
    
    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(0, 5)
    tc.Parent = tb
    
    local sv_b = Instance.new("TextButton")
    sv_b.Size = UDim2.new(0, 105, 0, 22)
    sv_b.Position = UDim2.new(0, 8, 0, 70)
    sv_b.BackgroundColor3 = Color3.new(0, 0, 0)
    sv_b.BackgroundTransparency = 0.4
    sv_b.Text = "SAVE"
    sv_b.TextColor3 = Color3.new(1, 1, 1)
    sv_b.TextSize = 11
    sv_b.Font = Enum.Font.GothamBold
    sv_b.Parent = pf
    
    local sc_b = Instance.new("UICorner")
    sc_b.CornerRadius = UDim.new(0, 5)
    sc_b.Parent = sv_b
    
    local cn_b = Instance.new("TextButton")
    cn_b.Size = UDim2.new(0, 105, 0, 22)
    cn_b.Position = UDim2.new(1, -113, 0, 70)
    cn_b.BackgroundColor3 = Color3.new(0, 0, 0)
    cn_b.BackgroundTransparency = 0.4
    cn_b.Text = "CANCEL"
    cn_b.TextColor3 = Color3.new(1, 1, 1)
    cn_b.TextSize = 11
    cn_b.Font = Enum.Font.GothamBold
    cn_b.Parent = pf
    
    local cc_b = Instance.new("UICorner")
    cc_b.CornerRadius = UDim.new(0, 5)
    cc_b.Parent = cn_b
    
    sv_b.MouseButton1Click:Connect(function()
        local nm = tb.Text
        if nm ~= "" then
            local ps = lp.Character.HumanoidRootPart.Position
            local gi = game.PlaceId
            local gn = game:GetService("MarketplaceService"):GetProductInfo(gi).Name
            
            local dt = ld()
            table.insert(dt, {
                nm = nm,
                gn = gn,
                ps = {X = ps.X, Y = ps.Y, Z = ps.Z},
                gi = gi,
                gm = gm
            })
            sv(dt)
            
            cr_fr(nm, gn, ps, gi)
        end
        ip:Destroy()
    end)
    
    cn_b.MouseButton1Click:Connect(function()
        ip:Destroy()
    end)
end)

ld_ps()
