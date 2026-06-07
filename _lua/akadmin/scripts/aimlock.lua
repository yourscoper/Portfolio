local rs = game:GetService("RunService")
local ui = game:GetService("UserInputService")
local ws = game:GetService("Workspace")
local hs = game:GetService("HttpService")
local ps = game:GetService("Players")
local vi = game:GetService("VirtualInputManager")
local cg = game:GetService("CoreGui")
local ts = game:GetService("TweenService")
local lp = ps.LocalPlayer
local cm = ws.CurrentCamera
local sp = 16
local fc = Color3.fromRGB(0, 0, 0)
local oc = Color3.fromRGB(255, 255, 255)
local al = false
local as = false
local cf = false
local tc = ui.TouchEnabled
local mm = false
local te = false

local function gd()
  return hs:GenerateGUID(false)
end

local sg = Instance.new("ScreenGui")
sg.Name = gd()
sg.Parent = cg

local mf = Instance.new("Frame")
mf.Name = gd()
mf.Size = UDim2.new(0, 220, 0, 285)
mf.Position = UDim2.new(0.5, -110, 0.5, -142)
mf.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mf.BackgroundTransparency = 0.85
mf.BorderSizePixel = 0
mf.ClipsDescendants = true
mf.Parent = sg

local mc = Instance.new("UICorner")
mc.CornerRadius = UDim.new(0, 8)
mc.Parent = mf

local tb = Instance.new("Frame")
tb.Name = gd()
tb.Size = UDim2.new(1, 0, 0, 28)
tb.Position = UDim2.new(0, 0, 0, 0)
tb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
tb.BackgroundTransparency = 1
tb.BorderSizePixel = 0
tb.Parent = mf

local ak = Instance.new("TextLabel")
ak.Name = gd()
ak.Size = UDim2.new(0, 70, 0, 16)
ak.Position = UDim2.new(0, 5, 0, 4)
ak.BackgroundTransparency = 1
ak.Text = "AK ADMIN"
ak.TextColor3 = Color3.fromRGB(255, 255, 255)
ak.TextSize = 9
ak.Font = Enum.Font.GothamBold
ak.TextXAlignment = Enum.TextXAlignment.Left
ak.Parent = tb

local tl = Instance.new("TextLabel")
tl.Name = gd()
tl.Size = UDim2.new(1, -100, 0, 24)
tl.Position = UDim2.new(0, 50, 0, 2)
tl.BackgroundTransparency = 1
tl.Text = "Aim Lock"
tl.TextColor3 = Color3.fromRGB(255, 255, 255)
tl.TextSize = 14
tl.Font = Enum.Font.GothamBold
tl.Parent = tb

local mn = Instance.new("TextButton")
mn.Name = gd()
mn.Size = UDim2.new(0, 20, 0, 20)
mn.Position = UDim2.new(1, -44, 0, 4)
mn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mn.BackgroundTransparency = 0.7
mn.Text = "_"
mn.TextColor3 = Color3.fromRGB(255, 255, 255)
mn.TextSize = 16
mn.Font = Enum.Font.GothamBold
mn.Parent = tb

local mc2 = Instance.new("UICorner")
mc2.CornerRadius = UDim.new(0, 4)
mc2.Parent = mn

local cl = Instance.new("TextButton")
cl.Name = gd()
cl.Size = UDim2.new(0, 20, 0, 20)
cl.Position = UDim2.new(1, -20, 0, 4)
cl.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
cl.BackgroundTransparency = 0.7
cl.Text = "X"
cl.TextColor3 = Color3.fromRGB(255, 255, 255)
cl.TextSize = 12
cl.Font = Enum.Font.GothamBold
cl.Parent = tb

local cc = Instance.new("UICorner")
cc.CornerRadius = UDim.new(0, 4)
cc.Parent = cl

local ct = Instance.new("Frame")
ct.Name = gd()
ct.Size = UDim2.new(1, 0, 1, -28)
ct.Position = UDim2.new(0, 0, 0, 28)
ct.BackgroundTransparency = 1
ct.BorderSizePixel = 0
ct.Parent = mf

local b1 = Instance.new("TextButton")
b1.Name = gd()
b1.Size = UDim2.new(0, 190, 0, 38)
b1.Position = UDim2.new(0.5, -95, 0, 10)
b1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
b1.BackgroundTransparency = 0.7
b1.Text = "Aim Lock: OFF"
b1.TextColor3 = Color3.fromRGB(255, 255, 255)
b1.TextSize = 15
b1.Font = Enum.Font.GothamBold
b1.Parent = ct

local c1 = Instance.new("UICorner")
c1.CornerRadius = UDim.new(0, 8)
c1.Parent = b1

local b2 = Instance.new("TextButton")
b2.Name = gd()
b2.Size = UDim2.new(0, 190, 0, 38)
b2.Position = UDim2.new(0.5, -95, 0, 56)
b2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
b2.BackgroundTransparency = 0.7
b2.Text = "Auto Shoot: OFF"
b2.TextColor3 = Color3.fromRGB(255, 255, 255)
b2.TextSize = 15
b2.Font = Enum.Font.GothamBold
b2.Parent = ct

local c2 = Instance.new("UICorner")
c2.CornerRadius = UDim.new(0, 8)
c2.Parent = b2

local b3 = Instance.new("TextButton")
b3.Name = gd()
b3.Size = UDim2.new(0, 190, 0, 38)
b3.Position = UDim2.new(0.5, -95, 0, 102)
b3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
b3.BackgroundTransparency = 0.7
b3.Text = "Rapid Fire: OFF"
b3.TextColor3 = Color3.fromRGB(255, 255, 255)
b3.TextSize = 15
b3.Font = Enum.Font.GothamBold
b3.Parent = ct

local c3 = Instance.new("UICorner")
c3.CornerRadius = UDim.new(0, 8)
c3.Parent = b3

local b4 = Instance.new("TextButton")
b4.Name = gd()
b4.Size = UDim2.new(0, 190, 0, 38)
b4.Position = UDim2.new(0.5, -95, 0, 148)
b4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
b4.BackgroundTransparency = 0.7
b4.Text = "Team Check: OFF"
b4.TextColor3 = Color3.fromRGB(255, 255, 255)
b4.TextSize = 15
b4.Font = Enum.Font.GothamBold
b4.Parent = ct

local c4 = Instance.new("UICorner")
c4.CornerRadius = UDim.new(0, 8)
c4.Parent = b4

local sl = Instance.new("TextLabel")
sl.Name = gd()
sl.Size = UDim2.new(0, 190, 0, 16)
sl.Position = UDim2.new(0.5, -95, 0, 194)
sl.BackgroundTransparency = 1
sl.Text = "Speed: 16"
sl.TextColor3 = Color3.fromRGB(255, 255, 255)
sl.TextSize = 12
sl.Font = Enum.Font.GothamBold
sl.Parent = ct

local sf = Instance.new("Frame")
sf.Name = gd()
sf.Size = UDim2.new(0, 150, 0, 6)
sf.Position = UDim2.new(0.5, -95, 0, 217)
sf.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
sf.BackgroundTransparency = 0.5
sf.BorderSizePixel = 0
sf.Parent = ct

local sc = Instance.new("UICorner")
sc.CornerRadius = UDim.new(1, 0)
sc.Parent = sf

local sk = Instance.new("Frame")
sk.Name = gd()
sk.Size = UDim2.new(0, 12, 0, 12)
sk.Position = UDim2.new(0.5, -6, 0.5, -6)
sk.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sk.BorderSizePixel = 0
sk.Parent = sf

local sc2 = Instance.new("UICorner")
sc2.CornerRadius = UDim.new(1, 0)
sc2.Parent = sk

local rs = Instance.new("TextButton")
rs.Name = gd()
rs.Size = UDim2.new(0, 30, 0, 22)
rs.Position = UDim2.new(0.5, 60, 0, 208)
rs.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
rs.BackgroundTransparency = 0.7
rs.Text = "R"
rs.TextColor3 = Color3.fromRGB(255, 255, 255)
rs.TextSize = 12
rs.Font = Enum.Font.GothamBold
rs.Parent = ct

local rc = Instance.new("UICorner")
rc.CornerRadius = UDim.new(0, 6)
rc.Parent = rs

local dg = false
local sd = false
local ip = nil
local mp = nil
local op = nil
local h1 = false
local h2 = false
local h3 = false
local h4 = false

local function us(vl)
  sp = math.clamp(vl, 1, 100)
  sl.Text = "Speed: " .. math.floor(sp)
  local pc = (sp - 1) / 99
  sk.Position = UDim2.new(pc, -6, 0.5, -6)
end

tb.InputBegan:Connect(function(io)
  if io.UserInputType == Enum.UserInputType.MouseButton1 or io.UserInputType == Enum.UserInputType.Touch then
    dg = true
    mp = io.Position
    op = mf.Position
    io.Changed:Connect(function()
      if io.UserInputState == Enum.UserInputState.End then
        dg = false
      end
    end)
  end
end)

tb.InputChanged:Connect(function(io)
  if io.UserInputType == Enum.UserInputType.MouseMovement or io.UserInputType == Enum.UserInputType.Touch then
    ip = io
  end
end)

ui.InputChanged:Connect(function(io)
  if io == ip and dg then
    local dt = io.Position - mp
    mf.Position = UDim2.new(op.X.Scale, op.X.Offset + dt.X, op.Y.Scale, op.Y.Offset + dt.Y)
  end
end)

sf.InputBegan:Connect(function(io)
  if io.UserInputType == Enum.UserInputType.MouseButton1 or io.UserInputType == Enum.UserInputType.Touch then
    sd = true
    local mx = io.Position.X - sf.AbsolutePosition.X
    local pc = math.clamp(mx / sf.AbsoluteSize.X, 0, 1)
    us(1 + pc * 99)
  end
end)

sf.InputEnded:Connect(function(io)
  if io.UserInputType == Enum.UserInputType.MouseButton1 or io.UserInputType == Enum.UserInputType.Touch then
    sd = false
  end
end)

ui.InputChanged:Connect(function(io)
  if sd and (io.UserInputType == Enum.UserInputType.MouseMovement or io.UserInputType == Enum.UserInputType.Touch) then
    local mx = io.Position.X - sf.AbsolutePosition.X
    local pc = math.clamp(mx / sf.AbsoluteSize.X, 0, 1)
    us(1 + pc * 99)
  end
end)

b1.MouseEnter:Connect(function()
  h1 = true
end)

b1.MouseLeave:Connect(function()
  h1 = false
end)

b2.MouseEnter:Connect(function()
  h2 = true
end)

b2.MouseLeave:Connect(function()
  h2 = false
end)

b3.MouseEnter:Connect(function()
  h3 = true
end)

b3.MouseLeave:Connect(function()
  h3 = false
end)

b4.MouseEnter:Connect(function()
  h4 = true
end)

b4.MouseLeave:Connect(function()
  h4 = false
end)

b1.MouseButton1Click:Connect(function()
  al = not al
  if al then
    b1.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    b1.Text = "Aim Lock: ON"
  else
    b1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    b1.Text = "Aim Lock: OFF"
  end
end)

b2.MouseButton1Click:Connect(function()
  as = not as
  if as then
    b2.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    b2.Text = "Auto Shoot: ON"
  else
    b2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    b2.Text = "Auto Shoot: OFF"
  end
end)

b3.MouseButton1Click:Connect(function()
  cf = not cf
  if cf then
    b3.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    b3.Text = "Rapid Fire: ON"
  else
    b3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    b3.Text = "Rapid Fire: OFF"
  end
end)

b4.MouseButton1Click:Connect(function()
  te = not te
  if te then
    b4.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    b4.Text = "Team Check: ON"
  else
    b4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    b4.Text = "Team Check: OFF"
  end
end)

rs.MouseButton1Click:Connect(function()
  us(16)
end)

mn.MouseButton1Click:Connect(function()
  mm = not mm
  local ti = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
  if mm then
    local tw = ts:Create(mf, ti, {Size = UDim2.new(0, 220, 0, 28)})
    tw:Play()
  else
    local tw = ts:Create(mf, ti, {Size = UDim2.new(0, 220, 0, 285)})
    tw:Play()
  end
end)

cl.MouseButton1Click:Connect(function()
  sg:Destroy()
end)

local fd = Instance.new("Folder")
fd.Name = gd()
fd.Parent = ws

local hl = {}
local tg = nil

local function fp(md)
  if not md or not md:IsA("Model") then
    return nil
  end
  if md:FindFirstChildOfClass("ForceField") then
    return nil
  end
  local hm = md:FindFirstChildOfClass("Humanoid")
  if not hm or hm.Health <= 0 then
    return nil
  end
  if te then
    local ep = ps:GetPlayerFromCharacter(md)
    if ep and ep.Team and lp.Team and ep.Team == lp.Team then
      return nil
    end
  end
  for _, pt in ipairs(md:GetChildren()) do
    if pt:IsA("BasePart") then
      local nm = pt.Name:lower()
      if nm == "hb" or nm == "hitbox" then
        return pt
      end
    end
  end
  return md:FindFirstChild("Head") or md:FindFirstChild("HumanoidRootPart")
end

local function lc(pt)
  local cp = cm.CFrame.Position
  local dr = pt.Position - cp
  local rp = RaycastParams.new()
  rp.FilterDescendantsInstances = {lp.Character, fd}
  rp.FilterType = Enum.RaycastFilterType.Exclude
  local rr = ws:Raycast(cp, dr, rp)
  if rr and rr.Instance:IsDescendantOf(pt.Parent) then
    return true
  end
  return rr == nil
end

local function ch(md)
  local hg = Instance.new("Highlight")
  hg.Name = gd()
  hg.FillColor = fc
  hg.OutlineColor = oc
  hg.FillTransparency = 0.5
  hg.OutlineTransparency = 0
  hg.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
  hg.Adornee = md
  hg.Parent = fd
  return hg
end

game:GetService("RunService").RenderStepped:Connect(function()
  if not al then
    if next(hl) then
      for md, hg in pairs(hl) do
        hg:Destroy()
        hl[md] = nil
      end
    end
    return
  end
  local vl = {}
  for _, md in ipairs(ws:GetChildren()) do
    if md ~= lp.Character then
      local pt = fp(md)
      if pt then
        vl[md] = true
        if not hl[md] or not hl[md].Parent or hl[md].Adornee ~= md then
          if hl[md] then
            hl[md]:Destroy()
          end
          hl[md] = ch(md)
        end
      end
    end
  end
  for md, hg in pairs(hl) do
    if not vl[md] then
      hg:Destroy()
      hl[md] = nil
    end
  end
end)

game:GetService("RunService"):BindToRenderStep("AimLogic", 2000, function()
  if not al then
    tg = nil
    return
  end
  if tg and tg.Parent and tg.Parent.Parent then
    local hm = tg.Parent:FindFirstChildOfClass("Humanoid")
    if not hm or hm.Health <= 0 or not lc(tg) or tg.Parent:FindFirstChildOfClass("ForceField") then
      tg = nil
    end
    if te and tg then
      local ep = ps:GetPlayerFromCharacter(tg.Parent)
      if ep and ep.Team and lp.Team and ep.Team == lp.Team then
        tg = nil
      end
    end
  else
    tg = nil
    local bp = nil
    local ds = math.huge
    local ml
    if tc then
      ml = cm.ViewportSize / 2
    else
      ml = ui:GetMouseLocation()
    end
    for md, _ in pairs(hl) do
      local pt = fp(md)
      if pt and lc(pt) then
        local vp, vs = cm:WorldToViewportPoint(pt.Position)
        local mg = (Vector2.new(vp.X, vp.Y) - ml).Magnitude
        if mg < ds then
          bp = pt
          ds = mg
        end
      end
    end
    tg = bp
  end
  if tg then
    cm.CFrame = CFrame.new(cm.CFrame.Position, tg.Position)
    if as and not h1 and not h2 and not h3 and not h4 then
      vi:SendMouseButtonEvent(0, 0, 0, true, nil, 0)
      task.delay(0.05, function()
        vi:SendMouseButtonEvent(0, 0, 0, false, nil, 0)
      end)
    end
  end
end)

local lt = 0
local hd = false
game:GetService("RunService").RenderStepped:Connect(function()
  if cf and tg and not h1 and not h2 and not h3 and not h4 then
    if not hd then
      vi:SendMouseButtonEvent(0, 0, 0, true, nil, 0)
      hd = true
    end
  else
    if hd then
      vi:SendMouseButtonEvent(0, 0, 0, false, nil, 0)
      hd = false
    end
  end
end)

game:GetService("RunService").Heartbeat:Connect(function(dt)
  local ch = lp.Character
  local hm = ch and ch:FindFirstChild("Humanoid")
  if ch and hm and hm.Parent then
    hm.WalkSpeed = sp
  end
end)
