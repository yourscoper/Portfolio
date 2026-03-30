local pl = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")
local sg = game:GetService("StarterGui")
local uis = game:GetService("UserInputService")
local ts = game:GetService("TweenService")
local lp = pl.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

local ev = rs:WaitForChild("event_generation")
local ed = rs:WaitForChild("event_done_generation")

local sz = 200
local hh = 0
local zm = 0
local fi = false
local dr = false
local dp = Vector2.new()
local dp2 = UDim2.new()

local function nt(tt, bx)
	pcall(function()
		sg:SetCore("SendNotification", { Title = tt, Text = bx, Duration = 4 })
	end)
end

local function stzm(v)
	zm = v
	lp.CameraMaxZoomDistance = v == 0 and 400 or v * 100
end

local function mksl(pa, yo, lbtxt, maxv, initv, cb)
	local pct = initv / maxv

	local lb = Instance.new("TextLabel")
	lb.Size = UDim2.new(1, -16, 0, 12)
	lb.Position = UDim2.new(0, 8, 0, yo)
	lb.BackgroundTransparency = 1
	lb.Text = lbtxt .. "  " .. initv
	lb.TextColor3 = Color3.fromRGB(255, 255, 255)
	lb.TextTransparency = 0.4
	lb.TextSize = 9
	lb.Font = Enum.Font.GothamBold
	lb.TextXAlignment = Enum.TextXAlignment.Left
	lb.Parent = pa

	local tr = Instance.new("Frame")
	tr.Size = UDim2.new(1, -16, 0, 4)
	tr.Position = UDim2.new(0, 8, 0, yo + 14)
	tr.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	tr.BackgroundTransparency = 0.85
	tr.BorderSizePixel = 0
	tr.Parent = pa
	local tc = Instance.new("UICorner", tr)
	tc.CornerRadius = UDim.new(0, 2)

	local fl = Instance.new("Frame")
	fl.Size = UDim2.new(pct, 0, 1, 0)
	fl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	fl.BackgroundTransparency = 0.45
	fl.BorderSizePixel = 0
	fl.Parent = tr
	local fc = Instance.new("UICorner", fl)
	fc.CornerRadius = UDim.new(0, 2)

	local hd2 = Instance.new("Frame")
	hd2.Size = UDim2.new(0, 11, 0, 11)
	hd2.Position = UDim2.new(pct, -5, 0.5, -5)
	hd2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	hd2.BackgroundTransparency = 0.1
	hd2.BorderSizePixel = 0
	hd2.Parent = tr
	local hc = Instance.new("UICorner", hd2)
	hc.CornerRadius = UDim.new(0, 6)

	local ac = false

	local function upd(xpos)
		local ap = tr.AbsolutePosition
		local aw = tr.AbsoluteSize.X
		local rx = math.clamp((xpos - ap.X) / aw, 0, 1)
		local nv = math.floor(rx * maxv)
		fl.Size = UDim2.new(rx, 0, 1, 0)
		hd2.Position = UDim2.new(rx, -6, 0.5, -6)
		lb.Text = lbtxt .. "  " .. nv
		cb(nv)
	end

	tr.InputBegan:Connect(function(i1)
		if i1.UserInputType == Enum.UserInputType.MouseButton1 or i1.UserInputType == Enum.UserInputType.Touch then
			ac = true
			upd(i1.Position.X)
		end
	end)
	hd2.InputBegan:Connect(function(i1)
		if i1.UserInputType == Enum.UserInputType.MouseButton1 or i1.UserInputType == Enum.UserInputType.Touch then
			ac = true
		end
	end)
	uis.InputEnded:Connect(function(i1)
		if i1.UserInputType == Enum.UserInputType.MouseButton1 or i1.UserInputType == Enum.UserInputType.Touch then
			ac = false
		end
	end)
	uis.InputChanged:Connect(function(i1)
		if not ac then return end
		if i1.UserInputType ~= Enum.UserInputType.MouseMovement and i1.UserInputType ~= Enum.UserInputType.Touch then return end
		upd(i1.Position.X)
	end)
end

local g1 = Instance.new("ScreenGui")
g1.Name = "ak_ui"
g1.ResetOnSpawn = false
g1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
g1.Parent = pg

local f1 = Instance.new("Frame")
f1.Name = "MainFrame"
f1.Size = UDim2.new(0, 200, 0, 240)
f1.Position = UDim2.new(0.5, 0, 0.5, 0)
f1.AnchorPoint = Vector2.new(0.5, 0.5)
f1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
f1.BackgroundTransparency = 0.7
f1.BorderSizePixel = 0
f1.ClipsDescendants = true
f1.Parent = g1
local u1 = Instance.new("UICorner", f1)
u1.CornerRadius = UDim.new(0, 8)

local t1 = Instance.new("Frame")
t1.Name = "Titlebar"
t1.Size = UDim2.new(1, 0, 0, 25)
t1.BackgroundTransparency = 1
t1.Parent = f1

local a1 = Instance.new("TextLabel")
a1.Size = UDim2.new(0, 60, 1, 0)
a1.Position = UDim2.new(0, 5, 0, 0)
a1.BackgroundTransparency = 1
a1.Text = "AK ADMIN"
a1.TextColor3 = Color3.fromRGB(255, 255, 255)
a1.TextSize = 10
a1.Font = Enum.Font.GothamBold
a1.TextXAlignment = Enum.TextXAlignment.Left
a1.Parent = t1

local t2 = Instance.new("TextLabel")
t2.Size = UDim2.new(1, -80, 1, 0)
t2.Position = UDim2.new(0, 40, 0, 0)
t2.BackgroundTransparency = 1
t2.Text = "AI TOOLS"
t2.TextColor3 = Color3.fromRGB(255, 255, 255)
t2.TextSize = 12
t2.Font = Enum.Font.GothamBold
t2.Parent = t1

local m1 = Instance.new("TextButton")
m1.Size = UDim2.new(0, 20, 0, 20)
m1.Position = UDim2.new(1, -45, 0, 2.5)
m1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
m1.BackgroundTransparency = 0.7
m1.Text = "_"
m1.TextColor3 = Color3.fromRGB(255, 255, 255)
m1.TextSize = 14
m1.Font = Enum.Font.GothamBold
m1.BorderSizePixel = 0
m1.AutoButtonColor = false
m1.Parent = t1
local u2 = Instance.new("UICorner", m1)
u2.CornerRadius = UDim.new(0, 4)

local c4 = Instance.new("TextButton")
c4.Size = UDim2.new(0, 20, 0, 20)
c4.Position = UDim2.new(1, -22, 0, 2.5)
c4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
c4.BackgroundTransparency = 0.7
c4.Text = "X"
c4.TextColor3 = Color3.fromRGB(255, 255, 255)
c4.TextSize = 12
c4.Font = Enum.Font.GothamBold
c4.BorderSizePixel = 0
c4.AutoButtonColor = false
c4.Parent = t1
local u3 = Instance.new("UICorner", c4)
u3.CornerRadius = UDim.new(0, 4)

local c5 = Instance.new("Frame")
c5.Name = "Content"
c5.Size = UDim2.new(1, 0, 1, -25)
c5.Position = UDim2.new(0, 0, 0, 25)
c5.BackgroundTransparency = 1
c5.Parent = f1

local lb1 = Instance.new("TextLabel")
lb1.Size = UDim2.new(1, -16, 0, 12)
lb1.Position = UDim2.new(0, 8, 0, 4)
lb1.BackgroundTransparency = 1
lb1.Text = "INPUT PROMPT"
lb1.TextColor3 = Color3.fromRGB(255, 255, 255)
lb1.TextTransparency = 0.4
lb1.TextSize = 9
lb1.Font = Enum.Font.GothamBold
lb1.TextXAlignment = Enum.TextXAlignment.Left
lb1.Parent = c5

local tx = Instance.new("TextBox")
tx.Size = UDim2.new(1, -16, 0, 26)
tx.Position = UDim2.new(0, 8, 0, 18)
tx.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
tx.BackgroundTransparency = 0.5
tx.TextColor3 = Color3.fromRGB(255, 255, 255)
tx.Text = ""
tx.PlaceholderText = "Enter prompt..."
tx.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
tx.TextTransparency = 0
tx.TextSize = 11
tx.Font = Enum.Font.Gotham
tx.ClearTextOnFocus = false
tx.BorderSizePixel = 0
tx.TextXAlignment = Enum.TextXAlignment.Left
tx.Parent = c5
local c1 = Instance.new("UICorner", tx)
c1.CornerRadius = UDim.new(0, 5)
local p1 = Instance.new("UIPadding", tx)
p1.PaddingLeft = UDim.new(0, 6)
p1.PaddingRight = UDim.new(0, 6)

-- SIZE slider: y=50, label 12px + gap 2 = track at y=64
mksl(c5, 50, "SIZE", 300, sz, function(v) sz = v end)

-- HIP HEIGHT slider: y=80, no gap, tight
mksl(c5, 80, "HIP HEIGHT", 100, hh, function(v)
	hh = v
	local ch = lp.Character
	if ch then
		local hm = ch:FindFirstChildWhichIsA("Humanoid")
		if hm then hm.HipHeight = hh end
	end
end)

-- ZOOM slider: y=110
mksl(c5, 110, "ZOOM", 100, zm, function(v)
	stzm(v)
end)

local fb = Instance.new("TextButton")
fb.Size = UDim2.new(1, -16, 0, 22)
fb.Position = UDim2.new(0, 8, 0, 144)
fb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
fb.BackgroundTransparency = 0.5
fb.Text = "FIRE"
fb.TextColor3 = Color3.fromRGB(255, 255, 255)
fb.TextSize = 11
fb.Font = Enum.Font.GothamBold
fb.BorderSizePixel = 0
fb.AutoButtonColor = false
fb.Parent = c5
local c7 = Instance.new("UICorner", fb)
c7.CornerRadius = UDim.new(0, 6)

fb.MouseEnter:Connect(function()
	ts:Create(fb, TweenInfo.new(0.1), { BackgroundTransparency = 0.3 }):Play()
end)
fb.MouseLeave:Connect(function()
	ts:Create(fb, TweenInfo.new(0.1), { BackgroundTransparency = 0.5 }):Play()
end)

local function fire()
	if tx.Text == "" or fi then return end
	fi = true
	nt("Loading", "Firing request...")
	local ok, er = pcall(function()
		ev:FireServer(tx.Text, Vector3.new(sz, sz, sz))
	end)
	if not ok then
		fi = false
		nt("Error", tostring(er))
	end
end

tx.FocusLost:Connect(function(ep)
	if ep then fire() end
end)

fb.MouseButton1Click:Connect(fire)

t1.InputBegan:Connect(function(i1)
	if i1.UserInputType ~= Enum.UserInputType.MouseButton1 and i1.UserInputType ~= Enum.UserInputType.Touch then return end
	dr = true
	dp = i1.Position
	dp2 = f1.Position
	local ch
	ch = i1.Changed:Connect(function()
		if i1.UserInputState == Enum.UserInputState.End then
			dr = false
			ch:Disconnect()
		end
	end)
end)

uis.InputChanged:Connect(function(i1)
	if not dr then return end
	if i1.UserInputType ~= Enum.UserInputType.MouseMovement and i1.UserInputType ~= Enum.UserInputType.Touch then return end
	local d5 = i1.Position - dp
	f1.Position = UDim2.new(dp2.X.Scale, dp2.X.Offset + d5.X, dp2.Y.Scale, dp2.Y.Offset + d5.Y)
end)

local mm = true
m1.MouseButton1Click:Connect(function()
	mm = not mm
	if mm then
		f1:TweenSize(UDim2.new(0, 200, 0, 240), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
		c5.Visible = true
	else
		f1:TweenSize(UDim2.new(0, 200, 0, 25), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
		task.wait(0.2)
		c5.Visible = false
	end
end)

c4.MouseButton1Click:Connect(function()
	g1:Destroy()
end)

ed.OnClientEvent:Connect(function(ok, er)
	fi = false
	if ok then
		nt("Success", "Tool generated successfully.")
	else
		nt("Error", er ~= nil and tostring(er) ~= "" and tostring(er) or "Generation failed.")
	end
end)
