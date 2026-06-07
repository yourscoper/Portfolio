local ps = game:GetService("Players")
local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")
local ui = game:GetService("UserInputService")
local ws = game:GetService("Workspace")
local lp = ps.LocalPlayer

local sg = Instance.new("ScreenGui")
local mf = Instance.new("Frame")
local tb = Instance.new("Frame")
local dt = Instance.new("Frame")
local tl = Instance.new("TextLabel")
local ak = Instance.new("TextLabel")
local mb = Instance.new("TextButton")
local cb = Instance.new("TextButton")
local cf = Instance.new("Frame")
local sf = Instance.new("ScrollingFrame")
local ul = Instance.new("UIListLayout")
local sb = Instance.new("TextBox")
local t1 = Instance.new("TextButton")
local t2 = Instance.new("TextButton")
local t3 = Instance.new("TextButton")
local t4 = Instance.new("TextButton")

sg.Name = "AK"
sg.Parent = gethui()
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.ResetOnSpawn = false

mf.Name = "MF"
mf.Parent = sg
mf.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mf.BackgroundTransparency = 0.75
mf.BorderSizePixel = 0
mf.Position = UDim2.new(0.35, 0, 0.25, 0)
mf.Size = UDim2.new(0, 280, 0, 340)
mf.ClipsDescendants = true
mf.Active = true

local mc = Instance.new("UICorner")
mc.CornerRadius = UDim.new(0, 12)
mc.Parent = mf

tb.Name = "TB"
tb.Parent = mf
tb.BackgroundTransparency = 1
tb.Size = UDim2.new(1, 0, 0, 35)
tb.Active = true

dt.Name = "DT"
dt.Parent = mf
dt.BackgroundTransparency = 1
dt.Position = UDim2.new(0, 0, 0, 0)
dt.Size = UDim2.new(1, -80, 0, 35)
dt.Active = true
dt.ZIndex = 1

tl.Name = "TL"
tl.Parent = tb
tl.BackgroundTransparency = 1
tl.Position = UDim2.new(0, 0, 0, 0)
tl.Size = UDim2.new(1, 0, 1, 0)
tl.Font = Enum.Font.GothamBold
tl.Text = "Unanchor Fling"
tl.TextColor3 = Color3.fromRGB(255, 255, 255)
tl.TextSize = 14
tl.TextXAlignment = Enum.TextXAlignment.Center

ak.Name = "AK"
ak.Parent = tb
ak.BackgroundTransparency = 1
ak.Position = UDim2.new(0, 10, 0, 0)
ak.Size = UDim2.new(0, 100, 1, 0)
ak.Font = Enum.Font.GothamBold
ak.Text = "AK ADMIN"
ak.TextColor3 = Color3.fromRGB(255, 255, 255)
ak.TextSize = 10
ak.TextXAlignment = Enum.TextXAlignment.Left

cb.Name = "CB"
cb.Parent = tb
cb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
cb.BackgroundTransparency = 0.6
cb.BorderSizePixel = 0
cb.Position = UDim2.new(1, -30, 0.5, -10)
cb.Size = UDim2.new(0, 20, 0, 20)
cb.Font = Enum.Font.GothamBold
cb.Text = "×"
cb.TextColor3 = Color3.fromRGB(255, 255, 255)
cb.TextSize = 18
cb.ZIndex = 2

local cc = Instance.new("UICorner")
cc.CornerRadius = UDim.new(0, 6)
cc.Parent = cb

mb.Name = "MB"
mb.Parent = tb
mb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mb.BackgroundTransparency = 0.6
mb.BorderSizePixel = 0
mb.Position = UDim2.new(1, -55, 0.5, -10)
mb.Size = UDim2.new(0, 20, 0, 20)
mb.Font = Enum.Font.GothamBold
mb.Text = "—"
mb.TextColor3 = Color3.fromRGB(255, 255, 255)
mb.TextSize = 14
mb.ZIndex = 2

local nc = Instance.new("UICorner")
nc.CornerRadius = UDim.new(0, 6)
nc.Parent = mb

cf.Name = "CF"
cf.Parent = mf
cf.BackgroundTransparency = 1
cf.Position = UDim2.new(0, 0, 0, 35)
cf.Size = UDim2.new(1, 0, 1, -35)

sb.Name = "SB"
sb.Parent = cf
sb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
sb.BackgroundTransparency = 0.65
sb.BorderSizePixel = 0
sb.Position = UDim2.new(0.05, 0, 0.02, 0)
sb.Size = UDim2.new(0.9, 0, 0, 28)
sb.Font = Enum.Font.Gotham
sb.PlaceholderText = "Search players..."
sb.Text = ""
sb.TextColor3 = Color3.fromRGB(255, 255, 255)
sb.TextSize = 11
sb.ClearTextOnFocus = false

local sc = Instance.new("UICorner")
sc.CornerRadius = UDim.new(0, 6)
sc.Parent = sb

sf.Name = "SF"
sf.Parent = cf
sf.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
sf.BackgroundTransparency = 0.8
sf.BorderSizePixel = 0
sf.Position = UDim2.new(0.05, 0, 0.12, 0)
sf.Size = UDim2.new(0.9, 0, 0, 130)
sf.ScrollBarThickness = 6
sf.CanvasSize = UDim2.new(0, 0, 0, 0)

local fc = Instance.new("UICorner")
fc.CornerRadius = UDim.new(0, 6)
fc.Parent = sf

ul.Parent = sf
ul.SortOrder = Enum.SortOrder.LayoutOrder
ul.Padding = UDim.new(0, 4)

t1.Name = "T1"
t1.Parent = cf
t1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
t1.BackgroundTransparency = 0.65
t1.BorderSizePixel = 0
t1.Position = UDim2.new(0.05, 0, 0.55, 0)
t1.Size = UDim2.new(0.9, 0, 0, 32)
t1.Font = Enum.Font.GothamBold
t1.Text = "Target Self | Off"
t1.TextColor3 = Color3.fromRGB(255, 255, 255)
t1.TextSize = 11

local c1 = Instance.new("UICorner")
c1.CornerRadius = UDim.new(0, 6)
c1.Parent = t1

t2.Name = "T2"
t2.Parent = cf
t2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
t2.BackgroundTransparency = 0.65
t2.BorderSizePixel = 0
t2.Position = UDim2.new(0.05, 0, 0.66, 0)
t2.Size = UDim2.new(0.9, 0, 0, 32)
t2.Font = Enum.Font.GothamBold
t2.Text = "Click Fling | Off"
t2.TextColor3 = Color3.fromRGB(255, 255, 255)
t2.TextSize = 11

local c2 = Instance.new("UICorner")
c2.CornerRadius = UDim.new(0, 6)
c2.Parent = t2

t3.Name = "T3"
t3.Parent = cf
t3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
t3.BackgroundTransparency = 0.65
t3.BorderSizePixel = 0
t3.Position = UDim2.new(0.05, 0, 0.77, 0)
t3.Size = UDim2.new(0.9, 0, 0, 32)
t3.Font = Enum.Font.GothamBold
t3.Text = "Show Parts | Off"
t3.TextColor3 = Color3.fromRGB(255, 255, 255)
t3.TextSize = 11

local c3 = Instance.new("UICorner")
c3.CornerRadius = UDim.new(0, 6)
c3.Parent = t3

t4.Name = "T4"
t4.Parent = cf
t4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
t4.BackgroundTransparency = 0.65
t4.BorderSizePixel = 0
t4.Position = UDim2.new(0.05, 0, 0.88, 0)
t4.Size = UDim2.new(0.9, 0, 0, 32)
t4.Font = Enum.Font.GothamBold
t4.Text = "View Target | Off"
t4.TextColor3 = Color3.fromRGB(255, 255, 255)
t4.TextSize = 11

local c4 = Instance.new("UICorner")
c4.CornerRadius = UDim.new(0, 6)
c4.Parent = t4

local im = false
local os = mf.Size
local ms = UDim2.new(0, 280, 0, 35)

if not getgenv().Network then
    getgenv().Network = {
        bp = {},
        vl = Vector3.new(25, 25, 25),
        fc = 999999
    }

    Network.RetainPart = function(pt)
        if pt:IsA("BasePart") and pt:IsDescendantOf(ws) then
            table.insert(Network.bp, pt)
            pt.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
            pt.CanCollide = false
        end
    end

    local function ep()
        lp.ReplicationFocus = ws
        rs.Heartbeat:Connect(function()
            sethiddenproperty(lp, "SimulationRadius", math.huge)
            sethiddenproperty(lp, "MaxSimulationRadius", math.huge)
            for _, pt in pairs(Network.bp) do
                if pt:IsDescendantOf(ws) then
                    pt.Velocity = Network.vl
                end
            end
        end)
    end

    ep()
end

local fd = Instance.new("Folder", ws)
local pt = Instance.new("Part", fd)
local a1 = Instance.new("Attachment", pt)
pt.Anchored = true
pt.CanCollide = false
pt.Transparency = 1

local ba = false
local dc = nil
local hr = nil
local sm = false
local sp = false
local vw = false
local cf = false
local cm = ws.CurrentCamera
local tp = nil
local ph = nil
local hs = {}
local tg = {}
local rl = nil
local pb = {}

local function ic(v)
    if not v:IsA("BasePart") then
        return false
    end
    if v.Anchored then
        return false
    end
    if v:IsDescendantOf(lp.Character) then
        return false
    end
    if v:FindFirstAncestorOfClass("Tool") then
        return false
    end
    local pm = v:FindFirstAncestorOfClass("Model")
    if pm and (pm:FindFirstChildOfClass("Humanoid") or pm:FindFirstChild("Head")) then
        return false
    end
    if v:FindFirstChild("TouchInterest") or v.CanTouch then
        return true
    end
    return true
end

local function fp(v)
    if ic(v) then
        for _, x in ipairs(v:GetChildren()) do
            if x:IsA("BodyMover") or x:IsA("RocketPropulsion") then
                x:Destroy()
            end
        end
        if v:FindFirstChild("Attachment") then
            v:FindFirstChild("Attachment"):Destroy()
        end
        if v:FindFirstChild("AlignPosition") then
            v:FindFirstChild("AlignPosition"):Destroy()
        end
        if v:FindFirstChild("Torque") then
            v:FindFirstChild("Torque"):Destroy()
        end
        v.CanCollide = false
        Network.RetainPart(v)
        local tq = Instance.new("Torque", v)
        tq.Torque = Vector3.new(200000, 200000, 200000)
        local ap = Instance.new("AlignPosition", v)
        local a2 = Instance.new("Attachment", v)
        tq.Attachment0 = a2
        ap.MaxForce = math.huge
        ap.MaxVelocity = math.huge
        ap.Responsiveness = 500
        ap.Attachment0 = a2
        ap.Attachment1 = a1
        
        if sp and not hs[v] then
            local hg = Instance.new("Highlight")
            hg.Parent = v
            hg.FillColor = Color3.fromRGB(0, 255, 0)
            hg.OutlineColor = Color3.fromRGB(255, 255, 255)
            hg.FillTransparency = 0.5
            hg.OutlineTransparency = 0
            hs[v] = hg
        end
    end
end

local function st()
    ba = false
    if dc then
        dc:Disconnect()
        dc = nil
    end
    if rl then
        rl:Disconnect()
        rl = nil
    end
    for k, v in pairs(hs) do
        if v then
            v:Destroy()
        end
    end
    hs = {}
    Network.vl = Vector3.new(0, 0, 0)
    for _, pt in pairs(Network.bp) do
        if pt and pt:IsDescendantOf(ws) then
            pt.Velocity = Vector3.new(0, 0, 0)
        end
    end
end

local function tb()
    ba = not ba
    if ba then
        Network.vl = Vector3.new(25, 25, 25)
        for _, v in ipairs(ws:GetDescendants()) do
            fp(v)
        end

        dc = ws.DescendantAdded:Connect(function(v)
            if ba then
                fp(v)
            end
        end)

        rl = rs.RenderStepped:Connect(function()
            if ba then
                if sm and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                    a1.WorldCFrame = lp.Character.HumanoidRootPart.CFrame
                elseif hr then
                    a1.WorldCFrame = hr.CFrame
                end
            end
        end)
    else
        st()
    end
end

local function fl(pl)
    if pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
        local oh = hr
        local os = sm
        
        hr = pl.Character.HumanoidRootPart
        sm = false
        tp = pl
        
        if ph then
            ph:Destroy()
        end
        
        ph = Instance.new("Highlight")
        ph.Parent = pl.Character
        ph.FillColor = Color3.fromRGB(255, 0, 0)
        ph.OutlineColor = Color3.fromRGB(255, 255, 255)
        ph.FillTransparency = 0.5
        ph.OutlineTransparency = 0
        
        if not ba then
            tb()
        end
        
        task.delay(0.5, function()
            if ph then
                ph:Destroy()
                ph = nil
            end
            
            if os then
                sm = true
                if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                    hr = lp.Character.HumanoidRootPart
                    tp = lp
                end
            else
                local wt = false
                for k, v in pairs(tg) do
                    if v then
                        wt = true
                        break
                    end
                end
                
                if wt then
                    hr = oh
                else
                    st()
                    hr = nil
                    tp = nil
                end
            end
        end)
    end
end

local function cp(pf, pl)
    if pb[pf] then
        for k, v in pairs(pb[pf]) do
            if v then
                v:Destroy()
            end
        end
        pb[pf] = nil
    end
    
    local co = Instance.new("UICorner")
    co.CornerRadius = UDim.new(0, 6)
    co.Parent = pf
    
    local pi = Instance.new("ImageLabel")
    pi.Name = "PI"
    pi.Parent = pf
    pi.BackgroundTransparency = 1
    pi.Position = UDim2.new(0, 6, 0, 6)
    pi.Size = UDim2.new(0, 38, 0, 38)
    
    local ic = Instance.new("UICorner")
    ic.CornerRadius = UDim.new(1, 0)
    ic.Parent = pi
    
    local un = Instance.new("TextLabel")
    un.Name = "UN"
    un.Parent = pf
    un.BackgroundTransparency = 1
    un.Position = UDim2.new(0, 50, 0, 4)
    un.Size = UDim2.new(0.42, 0, 0, 16)
    un.Font = Enum.Font.GothamBold
    un.Text = pl.Name
    un.TextColor3 = Color3.fromRGB(255, 255, 255)
    un.TextSize = 10
    un.TextXAlignment = Enum.TextXAlignment.Left
    un.TextTruncate = Enum.TextTruncate.AtEnd
    
    local dn = Instance.new("TextLabel")
    dn.Name = "DN"
    dn.Parent = pf
    dn.BackgroundTransparency = 1
    dn.Position = UDim2.new(0, 50, 0, 20)
    dn.Size = UDim2.new(0.42, 0, 0, 14)
    dn.Font = Enum.Font.Gotham
    dn.Text = "@" .. pl.DisplayName
    dn.TextColor3 = Color3.fromRGB(180, 180, 180)
    dn.TextSize = 8
    dn.TextXAlignment = Enum.TextXAlignment.Left
    dn.TextTruncate = Enum.TextTruncate.AtEnd
    
    local fb = Instance.new("TextButton")
    fb.Name = "FB"
    fb.Parent = pf
    fb.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    fb.BackgroundTransparency = 0.5
    fb.BorderSizePixel = 0
    fb.Position = UDim2.new(1, -52, 0, 8)
    fb.Size = UDim2.new(0, 45, 0, 18)
    fb.Font = Enum.Font.GothamBold
    fb.Text = "Fling"
    fb.TextColor3 = Color3.fromRGB(255, 255, 255)
    fb.TextSize = 9
    
    local f1 = Instance.new("UICorner")
    f1.CornerRadius = UDim.new(0, 4)
    f1.Parent = fb
    
    local gb = Instance.new("TextButton")
    gb.Name = "GB"
    gb.Parent = pf
    gb.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    gb.BackgroundTransparency = 0.5
    gb.BorderSizePixel = 0
    gb.Position = UDim2.new(1, -52, 0, 28)
    gb.Size = UDim2.new(0, 45, 0, 18)
    gb.Font = Enum.Font.GothamBold
    gb.Text = "Target | Off"
    gb.TextColor3 = Color3.fromRGB(255, 255, 255)
    gb.TextSize = 8
    
    local t2 = Instance.new("UICorner")
    t2.CornerRadius = UDim.new(0, 4)
    t2.Parent = gb
    
    task.spawn(function()
        local ok, im = pcall(function()
            return ps:GetUserThumbnailAsync(pl.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
        end)
        if ok and pi.Parent then
            pi.Image = im
        end
    end)
    
    fb.MouseButton1Click:Connect(function()
        fl(pl)
    end)
    
    if tg[pl] then
        gb.Text = "Target | On"
        gb.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
    end
    
    gb.MouseButton1Click:Connect(function()
        if tg[pl] then
            tg[pl] = false
            gb.Text = "Target | Off"
            gb.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        else
            tg[pl] = true
            gb.Text = "Target | On"
            gb.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
            
            if pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                hr = pl.Character.HumanoidRootPart
                sm = false
                tp = pl
                
                if not ba then
                    tb()
                end
            end
        end
    end)
    
    pb[pf] = {co, pi, ic, un, dn, fb, f1, gb, t2}
end

local function up()
    local st = string.lower(sb.Text)
    local ex = {}
    
    for _, v in ipairs(sf:GetChildren()) do
        if v:IsA("Frame") then
            ex[v.Name] = v
        end
    end
    
    local pc = 0
    local pl = ps:GetPlayers()
    
    for _, p in ipairs(pl) do
        if st == "" or string.find(string.lower(p.Name), st) or string.find(string.lower(p.DisplayName), st) then
            local pf = ex[p.Name]
            
            if not pf then
                pf = Instance.new("Frame")
                pf.Name = p.Name
                pf.Parent = sf
                pf.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                pf.BackgroundTransparency = 0.65
                pf.BorderSizePixel = 0
                pf.Size = UDim2.new(1, -8, 0, 50)
                
                cp(pf, p)
            else
                ex[p.Name] = nil
            end
            
            pc = pc + 1
        end
    end
    
    for k, v in pairs(ex) do
        if pb[v] then
            for _, o in pairs(pb[v]) do
                if o then
                    o:Destroy()
                end
            end
            pb[v] = nil
        end
        v:Destroy()
    end
    
    sf.CanvasSize = UDim2.new(0, 0, 0, pc * 54)
end

sb.Changed:Connect(function(pr)
    if pr == "Text" then
        up()
    end
end)

ps.PlayerAdded:Connect(up)
ps.PlayerRemoving:Connect(up)
up()

t1.MouseButton1Click:Connect(function()
    sm = not sm
    if sm then
        t1.Text = "Target Self | On"
        t1.BackgroundTransparency = 0.45
        if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            hr = lp.Character.HumanoidRootPart
        end
        if not ba then
            tb()
        end
    else
        t1.Text = "Target Self | Off"
        t1.BackgroundTransparency = 0.65
        st()
    end
end)

t2.MouseButton1Click:Connect(function()
    cf = not cf
    if cf then
        t2.Text = "Click Fling | On"
        t2.BackgroundTransparency = 0.45
    else
        t2.Text = "Click Fling | Off"
        t2.BackgroundTransparency = 0.65
    end
end)

t3.MouseButton1Click:Connect(function()
    sp = not sp
    if sp then
        t3.Text = "Show Parts | On"
        t3.BackgroundTransparency = 0.45
        for _, v in ipairs(ws:GetDescendants()) do
            if ic(v) and not hs[v] then
                local hg = Instance.new("Highlight")
                hg.Parent = v
                hg.FillColor = Color3.fromRGB(0, 255, 0)
                hg.OutlineColor = Color3.fromRGB(255, 255, 255)
                hg.FillTransparency = 0.5
                hg.OutlineTransparency = 0
                hs[v] = hg
            end
        end
    else
        t3.Text = "Show Parts | Off"
        t3.BackgroundTransparency = 0.65
        for k, v in pairs(hs) do
            if v then
                v:Destroy()
            end
        end
        hs = {}
    end
end)

t4.MouseButton1Click:Connect(function()
    vw = not vw
    if vw then
        t4.Text = "View Target | On"
        t4.BackgroundTransparency = 0.45
        if tp and tp.Character and tp.Character:FindFirstChild("Humanoid") then
            cm.CameraSubject = tp.Character.Humanoid
        end
    else
        t4.Text = "View Target | Off"
        t4.BackgroundTransparency = 0.65
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            cm.CameraSubject = lp.Character.Humanoid
        end
    end
end)

ui.InputBegan:Connect(function(ip, gp)
    if not gp then
        if ip.KeyCode == Enum.KeyCode.RightControl then
            mf.Visible = not mf.Visible
        elseif cf and (ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch) then
            local ml = ui:GetMouseLocation()
            local ry = cm:ViewportPointToRay(ml.X, ml.Y)
            local rc = RaycastParams.new()
            rc.FilterType = Enum.RaycastFilterType.Exclude
            rc.FilterDescendantsInstances = {lp.Character}
            
            local rt = ws:Raycast(ry.Origin, ry.Direction * 1000, rc)
            
            if rt and rt.Instance then
                local ch = rt.Instance:FindFirstAncestorOfClass("Model")
                if ch and ch:FindFirstChild("Humanoid") then
                    local pl = ps:GetPlayerFromCharacter(ch)
                    if pl then
                        fl(pl)
                    end
                end
            end
        end
    end
end)

mb.MouseButton1Click:Connect(function()
    im = not im
    local ti = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    if im then
        local tw = ts:Create(mf, ti, {Size = ms})
        tw:Play()
        mb.Text = "+"
        cf.Visible = false
    else
        local tw = ts:Create(mf, ti, {Size = os})
        tw:Play()
        mb.Text = "—"
        cf.Visible = true
    end
end)

cb.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

local dg = false
local ds
local p2

dt.InputBegan:Connect(function(ip)
    if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
        dg = true
        ds = ip.Position
        p2 = mf.Position
    end
end)

ui.InputEnded:Connect(function(ip)
    if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
        dg = false
    end
end)

ui.InputChanged:Connect(function(ip)
    if dg and (ip.UserInputType == Enum.UserInputType.MouseMovement or ip.UserInputType == Enum.UserInputType.Touch) then
        local dl = Vector2.new(ip.Position.X - ds.X, ip.Position.Y - ds.Y)
        mf.Position = UDim2.new(p2.X.Scale, p2.X.Offset + dl.X, p2.Y.Scale, p2.Y.Offset + dl.Y)
    end
end)
