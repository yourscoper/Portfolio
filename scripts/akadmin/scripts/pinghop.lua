local h1 = game:GetService('HttpService')
local t1 = game:GetService('TeleportService')
local p1 = game:GetService('Players')
local tw = game:GetService('TweenService')

local lp = p1.LocalPlayer
local pi = game.PlaceId
local ji = game.JobId

local sg = Instance.new('ScreenGui')
sg.Name = 'ServerHopperGui'
sg.ResetOnSpawn = false
sg.Parent = lp:WaitForChild('PlayerGui')

local mf = Instance.new('Frame')
mf.Size = UDim2.new(0, 220, 0, 320)
mf.Position = UDim2.new(0.5, -110, 0.5, -160)
mf.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mf.BackgroundTransparency = 0.85
mf.BorderSizePixel = 0
mf.Active = true
mf.Draggable = true
mf.Parent = sg

local mc = Instance.new('UICorner')
mc.CornerRadius = UDim.new(0, 8)
mc.Parent = mf

local ak = Instance.new('TextLabel')
ak.Size = UDim2.new(0, 80, 0, 30)
ak.Position = UDim2.new(0, 5, 0, 0)
ak.BackgroundTransparency = 1
ak.Text = 'AK ADMIN'
ak.Font = Enum.Font.SourceSans
ak.TextSize = 10
ak.TextColor3 = Color3.new(1, 1, 1)
ak.TextXAlignment = Enum.TextXAlignment.Left
ak.Parent = mf

local mn = Instance.new('TextButton')
mn.Size = UDim2.new(0, 25, 0, 25)
mn.Position = UDim2.new(1, -60, 0, 3)
mn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mn.BackgroundTransparency = 0.7
mn.Text = '-'
mn.Font = Enum.Font.SourceSansBold
mn.TextColor3 = Color3.new(1, 1, 1)
mn.TextSize = 20
mn.Parent = mf

local m1 = Instance.new('UICorner')
m1.CornerRadius = UDim.new(0, 6)
m1.Parent = mn

local cb = Instance.new('TextButton')
cb.Size = UDim2.new(0, 25, 0, 25)
cb.Position = UDim2.new(1, -30, 0, 3)
cb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
cb.BackgroundTransparency = 0.7
cb.Text = 'X'
cb.Font = Enum.Font.SourceSansBold
cb.TextColor3 = Color3.new(1, 1, 1)
cb.TextSize = 16
cb.Parent = mf

local c1 = Instance.new('UICorner')
c1.CornerRadius = UDim.new(0, 6)
c1.Parent = cb

local tt = Instance.new('TextLabel')
tt.Size = UDim2.new(1, -90, 0, 30)
tt.Position = UDim2.new(0, 45, 0, 0)
tt.BackgroundTransparency = 1
tt.Text = 'PING HOPPER'
tt.Font = Enum.Font.SourceSansBold
tt.TextSize = 20
tt.TextColor3 = Color3.new(1, 1, 1)
tt.Parent = mf

local ff = Instance.new('Frame')
ff.Size = UDim2.new(1, -20, 0, 28)
ff.Position = UDim2.new(0, 10, 0, 35)
ff.BackgroundTransparency = 1
ff.Parent = mf

local cs = 'low'

local lb = Instance.new('TextButton')
lb.Size = UDim2.new(0, 90, 0, 23)
lb.Position = UDim2.new(0, 0, 0, 0)
lb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
lb.BackgroundTransparency = 0.5
lb.Text = 'Low Ping'
lb.Font = Enum.Font.SourceSans
lb.TextSize = 13
lb.TextColor3 = Color3.new(1, 1, 1)
lb.Parent = ff

local l1 = Instance.new('UICorner')
l1.CornerRadius = UDim.new(0, 6)
l1.Parent = lb

local hb = Instance.new('TextButton')
hb.Size = UDim2.new(0, 90, 0, 23)
hb.Position = UDim2.new(0, 100, 0, 0)
hb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
hb.BackgroundTransparency = 0.75
hb.Text = 'High Ping'
hb.Font = Enum.Font.SourceSans
hb.TextSize = 13
hb.TextColor3 = Color3.new(1, 1, 1)
hb.Parent = ff

local h2 = Instance.new('UICorner')
h2.CornerRadius = UDim.new(0, 6)
h2.Parent = hb

local rb = Instance.new('TextButton')
rb.Size = UDim2.new(0, 60, 0, 23)
rb.Position = UDim2.new(1, -70, 0, 68)
rb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
rb.BackgroundTransparency = 0.7
rb.Text = 'Refresh'
rb.Font = Enum.Font.SourceSansBold
rb.TextSize = 13
rb.TextColor3 = Color3.new(1, 1, 1)
rb.Parent = mf

local r1 = Instance.new('UICorner')
r1.CornerRadius = UDim.new(0, 6)
r1.Parent = rb

local sl = Instance.new('TextLabel')
sl.Size = UDim2.new(1, -80, 0, 23)
sl.Position = UDim2.new(0, 10, 0, 68)
sl.BackgroundTransparency = 1
sl.Text = 'Loading...'
sl.Font = Enum.Font.SourceSans
sl.TextSize = 13
sl.TextColor3 = Color3.new(1, 1, 1)
sl.TextXAlignment = Enum.TextXAlignment.Left
sl.Parent = mf

local sf = Instance.new('ScrollingFrame')
sf.Size = UDim2.new(1, -20, 1, -105)
sf.Position = UDim2.new(0, 10, 0, 95)
sf.BackgroundTransparency = 0.9
sf.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
sf.BorderSizePixel = 0
sf.CanvasSize = UDim2.new(0, 0, 0, 0)
sf.ScrollBarThickness = 5
sf.Parent = mf

local ll = Instance.new('UIListLayout')
ll.Parent = sf
ll.SortOrder = Enum.SortOrder.LayoutOrder
ll.Padding = UDim.new(0, 3)

local s1 = Instance.new('UICorner')
s1.CornerRadius = UDim.new(0, 6)
s1.Parent = sf

local function ls()
    sl.Text = 'Loading...'
    
    for _, ch in ipairs(sf:GetChildren()) do
        if ch:IsA('Frame') then
            ch:Destroy()
        end
    end
    
    local ok, sv = pcall(function()
        local ul = string.format('https://games.roblox.com/v1/games/%d/servers/Public?limit=100&excludeFullGames=true', pi)
        local rs = h1:JSONDecode(game:HttpGet(ul))
        return rs.data
    end)
    
    if not ok then
        sl.Text = 'Failed to load'
        return
    end
    
    if cs == 'low' then
        table.sort(sv, function(a, b)
            return (a.ping or 999) < (b.ping or 999)
        end)
    elseif cs == 'high' then
        table.sort(sv, function(a, b)
            return (a.ping or 0) > (b.ping or 0)
        end)
    end
    
    for ix, sr in ipairs(sv) do
        if sr.id ~= ji then
            local fr = Instance.new('Frame')
            fr.Size = UDim2.new(1, -8, 0, 28)
            fr.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            fr.BackgroundTransparency = 0.8
            fr.BorderSizePixel = 0
            fr.Parent = sf
            
            local f1 = Instance.new('UICorner')
            f1.CornerRadius = UDim.new(0, 4)
            f1.Parent = fr
            
            local fl = Instance.new('UIListLayout', fr)
            fl.FillDirection = Enum.FillDirection.Horizontal
            fl.HorizontalAlignment = Enum.HorizontalAlignment.Left
            fl.SortOrder = Enum.SortOrder.LayoutOrder
            fl.Padding = UDim.new(0, 2)
            
            local il = Instance.new('TextLabel')
            il.Size = UDim2.new(0, 25, 1, 0)
            il.BackgroundTransparency = 1
            il.Text = tostring(ix)
            il.Font = Enum.Font.SourceSans
            il.TextSize = 12
            il.TextColor3 = Color3.new(1, 1, 1)
            il.Parent = fr
            
            local pl = Instance.new('TextLabel')
            pl.Size = UDim2.new(0, 45, 1, 0)
            pl.BackgroundTransparency = 1
            pl.Text = string.format('%d/%d', sr.playing, sr.maxPlayers)
            pl.Font = Enum.Font.SourceSans
            pl.TextSize = 12
            pl.TextColor3 = Color3.new(1, 1, 1)
            pl.Parent = fr
            
            local pg = Instance.new('TextLabel')
            pg.Size = UDim2.new(0, 50, 1, 0)
            pg.BackgroundTransparency = 1
            pg.Text = tostring(sr.ping or 'N/A') .. 'ms'
            pg.Font = Enum.Font.SourceSans
            pg.TextSize = 12
            pg.TextColor3 = Color3.new(1, 1, 1)
            pg.Parent = fr
            
            local jb = Instance.new('TextButton')
            jb.Size = UDim2.new(0, 45, 0, 22)
            jb.Position = UDim2.new(0, 0, 0.5, -11)
            jb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            jb.BackgroundTransparency = 0.6
            jb.Text = 'Join'
            jb.Font = Enum.Font.SourceSansBold
            jb.TextSize = 12
            jb.TextColor3 = Color3.new(1, 1, 1)
            jb.Parent = fr
            
            local j1 = Instance.new('UICorner')
            j1.CornerRadius = UDim.new(0, 4)
            j1.Parent = jb
            
            jb.MouseButton1Click:Connect(function()
                sl.Text = 'Teleporting...'
                jb.Text = '...'
                
                pcall(function()
                    t1:TeleportToPlaceInstance(pi, sr.id, lp)
                end)
            end)
        end
    end
    
    sf.CanvasSize = UDim2.new(0, 0, 0, ll.AbsoluteContentSize.Y + 10)
    sl.Text = 'Loaded ' .. #sv .. ' servers'
end

local function uf(sd)
    cs = sd
    lb.BackgroundTransparency = sd == 'low' and 0.5 or 0.75
    hb.BackgroundTransparency = sd == 'high' and 0.5 or 0.75
    ls()
end

lb.MouseButton1Click:Connect(function()
    uf('low')
end)

hb.MouseButton1Click:Connect(function()
    uf('high')
end)

rb.MouseButton1Click:Connect(function()
    ls()
end)

local mi = false
local os = mf.Size

mn.MouseButton1Click:Connect(function()
    mi = not mi
    if mi then
        local t2 = tw:Create(mf, TweenInfo.new(0.3), {Size = UDim2.new(0, 220, 0, 30)})
        t2:Play()
        mn.Text = '+'
        ff.Visible = false
        rb.Visible = false
        sl.Visible = false
        sf.Visible = false
    else
        local t3 = tw:Create(mf, TweenInfo.new(0.3), {Size = os})
        t3:Play()
        mn.Text = '-'
        ff.Visible = true
        rb.Visible = true
        sl.Visible = true
        sf.Visible = true
    end
end)

cb.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

wait(0.5)
ls()
