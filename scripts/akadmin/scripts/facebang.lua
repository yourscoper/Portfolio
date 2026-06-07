local function sv(nm) return cloneref and cloneref(game:GetService(nm)) or game:GetService(nm) end

  local pl = sv("Players")
  local rs = sv("RunService")
  local ui = sv("UserInputService")
  local ts = sv("TweenService")

  local lp = pl.LocalPlayer
  local pg = lp:WaitForChild("PlayerGui")
  local ch = lp.Character or lp.CharacterAdded:Wait()
  local rp = ch:WaitForChild("HumanoidRootPart")
  local th = nil
  local tp = nil

  local fd = -0.7
  local ho = 0.8
  local ms = 0.8
  local sp = 0.8
  local td = 1.9

  local ft = 0.1
  local bt = 0.1

  getgenv().facefuckactive = false
  getgenv().currentKeybind = Enum.KeyCode.Z

  local function da(cr)
    if not cr then return end
    
    local an = cr:FindFirstChild("Animate")
    if an then
      an.Disabled = true
    end
    
    local hm = cr:FindFirstChild("Humanoid")
    if hm then
      for _, tr in ipairs(hm:GetPlayingAnimationTracks()) do
        tr:Stop()
        tr:Destroy()
      end
      hm.PlatformStand = true
      hm.AutoRotate = false
      hm:ChangeState(Enum.HumanoidStateType.Physics)
    end
    
    workspace.Gravity = 0
  end

  local function ea(cr)
    if not cr then return end
    
    local an = cr:FindFirstChild("Animate")
    if an then
      an.Disabled = false
    end
    
    local hm = cr:FindFirstChild("Humanoid")
    if hm then
      hm.PlatformStand = false
      hm.AutoRotate = true
      hm:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
    
    workspace.Gravity = 192.2
  end

  local function sc()
    lp.CharacterAdded:Connect(function(nc)
      ch = nc
      rp = nc:WaitForChild("HumanoidRootPart")
      
      if getgenv().facefuckactive then
        da(nc)
        th = fn()
        if th then
          task.spawn(function()
            fb(th)
          end)
        end
      end
    end)
  end

  local function fn()
    if tp and tp.Character and tp.Character:FindFirstChild("Head") then
      return tp.Character.Head
    end

    local np = nil
    local sd = math.huge

    for _, pr in ipairs(pl:GetPlayers()) do
      if pr ~= lp and pr.Character and pr.Character:FindFirstChild("Humanoid") and pr.Character.Humanoid.Health > 0 then
        local hd = pr.Character:FindFirstChild("Head")
        if hd then
          local ds = (rp.Position - hd.Position).Magnitude
          if ds < sd then
            sd = ds
            np = hd
            tp = pr
          end
        end
      end
    end

    if tp then
      tp.CharacterAdded:Connect(function(nc)
        if getgenv().facefuckactive then
          local hd = nc:WaitForChild("Head")
          th = hd
          fb(hd)
        end
      end)
    end

    return np
  end

  local function sa()
    rs.Heartbeat:Connect(function()
      if getgenv().facefuckactive and lp.Character then
        local hm = lp.Character:FindFirstChild("Humanoid")
        if hm then
          for _, tr in ipairs(hm:GetPlayingAnimationTracks()) do
            tr:Stop()
          end
          hm.PlatformStand = true
          hm:ChangeState(Enum.HumanoidStateType.Physics)
        end
      end
    end)
  end

  local function ei(t)
    return -(math.cos(math.pi * t) - 1) / 2
  end

  local function sl(st, tg, al, ef)
    local ea = ef(al)
    return st:Lerp(tg, ea)
  end

  local function fb(hd)
    while getgenv().facefuckactive do
      if not hd or not hd:IsDescendantOf(workspace) then
        if tp and tp.Character then
          hd = tp.Character:WaitForChild("Head")
          th = hd
        else
          hd = fn()
          if not hd then
            task.wait(1)
            continue
          end
        end
      end

      da(lp.Character)

      local dt = (hd.Position - rp.Position).Magnitude
      local tf = dt > 10
      
      if tf then
        local ac = hd.CFrame * CFrame.new(0, ho, fd + 1) * CFrame.Angles(0, math.rad(180), 0)
        rp.CFrame = ac
        rs.RenderStepped:Wait()
        continue
      end
      
      local bp = hd.CFrame * CFrame.new(0, ho, fd) * CFrame.Angles(0, math.rad(180), 0)
      local tp = hd.CFrame * CFrame.new(0, ho, fd - td) * CFrame.Angles(0, math.rad(180), 0)
      
      local ts = tick()
      local dr = ft
      while (tick() - ts) < dr and getgenv().facefuckactive do
        bp = hd.CFrame * CFrame.new(0, ho, fd) * CFrame.Angles(0, math.rad(180), 0)
        tp = hd.CFrame * CFrame.new(0, ho, fd - td) * CFrame.Angles(0, math.rad(180), 0)
        
        local pg = math.min((tick() - ts) / dr, 1)
        local ct = sl(bp, tp, pg, ei)
        rp.CFrame = ct
        
        rs.RenderStepped:Wait()
      end
      
      local rt = tick()
      local rd = bt
      while (tick() - rt) < rd and getgenv().facefuckactive do
        bp = hd.CFrame * CFrame.new(0, ho, fd) * CFrame.Angles(0, math.rad(180), 0)
        tp = hd.CFrame * CFrame.new(0, ho, fd - td) * CFrame.Angles(0, math.rad(180), 0)
        
        local pg = math.min((tick() - rt) / rd, 1)
        local cr = sl(tp, bp, pg, ei)
        rp.CFrame = cr
        
        rs.RenderStepped:Wait()
      end
    end

    ea(lp.Character)
  end

  local function tm()
    if not getgenv().facefuckactive then
      tp = nil
      th = fn()
      
      if th then
        getgenv().facefuckactive = true
        da(lp.Character)
        task.spawn(function()
          fb(th)
        end)
      end
    else
      getgenv().facefuckactive = false
      tp = nil
      th = nil
      ea(lp.Character)
    end
  end

  local function cg()
    if pg:FindFirstChild("FaceBangGui") then
      pg.FaceBangGui:Destroy()
    end

    local sg = Instance.new("ScreenGui")
    sg.Name = "FaceBangGui"
    sg.ResetOnSpawn = false
    sg.Parent = pg

    local mf = Instance.new("Frame")
    mf.Name = "MainFrame"
    mf.Size = UDim2.new(0, 200, 0, 180)
    mf.Position = UDim2.new(0.5, -100, 0.5, -90)
    mf.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mf.BackgroundTransparency = 0.6
    mf.BorderSizePixel = 0
    mf.Parent = sg

    local mc = Instance.new("UICorner")
    mc.CornerRadius = UDim.new(0, 8)
    mc.Parent = mf

    local tb = Instance.new("Frame")
    tb.Name = "TitleBar"
    tb.Size = UDim2.new(1, 0, 0, 25)
    tb.Position = UDim2.new(0, 0, 0, 0)
    tb.BackgroundTransparency = 1
    tb.BorderSizePixel = 0
    tb.Parent = mf

    local al = Instance.new("TextLabel")
    al.Name = "AKAdminLabel"
    al.Size = UDim2.new(0, 80, 0, 15)
    al.Position = UDim2.new(0, 8, 0, 5)
    al.BackgroundTransparency = 1
    al.TextColor3 = Color3.fromRGB(255, 255, 255)
    al.Text = "AK ADMIN"
    al.TextSize = 9
    al.Font = Enum.Font.GothamBold
    al.TextXAlignment = Enum.TextXAlignment.Left
    al.Parent = mf

    local mb = Instance.new("TextButton")
    mb.Name = "MinimizeButton"
    mb.Size = UDim2.new(0, 18, 0, 18)
    mb.Position = UDim2.new(1, -42, 0, 5)
    mb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mb.BackgroundTransparency = 0.6
    mb.BorderSizePixel = 0
    mb.TextColor3 = Color3.fromRGB(255, 255, 255)
    mb.Text = "-"
    mb.TextSize = 14
    mb.Font = Enum.Font.GothamBold
    mb.Parent = mf

    local nc = Instance.new("UICorner")
    nc.CornerRadius = UDim.new(0, 4)
    nc.Parent = mb

    local cb = Instance.new("TextButton")
    cb.Name = "CloseButton"
    cb.Size = UDim2.new(0, 18, 0, 18)
    cb.Position = UDim2.new(1, -20, 0, 5)
    cb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    cb.BackgroundTransparency = 0.6
    cb.BorderSizePixel = 0
    cb.TextColor3 = Color3.fromRGB(255, 255, 255)
    cb.Text = "X"
    cb.TextSize = 12
    cb.Font = Enum.Font.GothamBold
    cb.Parent = mf

    local cc = Instance.new("UICorner")
    cc.CornerRadius = UDim.new(0, 4)
    cc.Parent = cb

    local tl = Instance.new("TextLabel")
    tl.Name = "TitleLabel"
    tl.Size = UDim2.new(0, 150, 0, 20)
    tl.Position = UDim2.new(0.5, -75, 0, 25)
    tl.BackgroundTransparency = 1
    tl.TextColor3 = Color3.fromRGB(255, 255, 255)
    tl.Text = "Face Bang"
    tl.TextSize = 16
    tl.Font = Enum.Font.GothamBold
    tl.TextXAlignment = Enum.TextXAlignment.Center
    tl.Parent = mf

    local sl = Instance.new("TextLabel")
    sl.Name = "SpeedLabel"
    sl.Size = UDim2.new(0, 100, 0, 15)
    sl.Position = UDim2.new(0, 10, 0, 50)
    sl.BackgroundTransparency = 1
    sl.TextColor3 = Color3.fromRGB(220, 220, 220)
    sl.Text = "Speed: 0.10"
    sl.TextSize = 10
    sl.Font = Enum.Font.GothamBold
    sl.TextXAlignment = Enum.TextXAlignment.Left
    sl.Parent = mf

    local ss = Instance.new("Frame")
    ss.Name = "SpeedSlider"
    ss.Size = UDim2.new(0, 180, 0, 6)
    ss.Position = UDim2.new(0, 10, 0, 70)
    ss.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ss.BackgroundTransparency = 0.6
    ss.BorderSizePixel = 0
    ss.Parent = mf

    local sc = Instance.new("UICorner")
    sc.CornerRadius = UDim.new(0, 3)
    sc.Parent = ss

    local sh = Instance.new("TextButton")
    sh.Name = "SpeedHandle"
    sh.Size = UDim2.new(0, 14, 0, 14)
    sh.Position = UDim2.new(0, 0, 0, -4)
    sh.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sh.BorderSizePixel = 0
    sh.Text = ""
    sh.Parent = ss

    local hc = Instance.new("UICorner")
    hc.CornerRadius = UDim.new(1, 0)
    hc.Parent = sh

    local dl = Instance.new("TextLabel")
    dl.Name = "DistanceLabel"
    dl.Size = UDim2.new(0, 100, 0, 15)
    dl.Position = UDim2.new(0, 10, 0, 85)
    dl.BackgroundTransparency = 1
    dl.TextColor3 = Color3.fromRGB(220, 220, 220)
    dl.Text = "Distance: 1.9"
    dl.TextSize = 10
    dl.Font = Enum.Font.GothamBold
    dl.TextXAlignment = Enum.TextXAlignment.Left
    dl.Parent = mf

    local ds = Instance.new("Frame")
    ds.Name = "DistanceSlider"
    ds.Size = UDim2.new(0, 180, 0, 6)
    ds.Position = UDim2.new(0, 10, 0, 105)
    ds.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ds.BackgroundTransparency = 0.6
    ds.BorderSizePixel = 0
    ds.Parent = mf

    local dc = Instance.new("UICorner")
    dc.CornerRadius = UDim.new(0, 3)
    dc.Parent = ds

    local dh = Instance.new("TextButton")
    dh.Name = "DistanceHandle"
    dh.Size = UDim2.new(0, 14, 0, 14)
    dh.Position = UDim2.new(0, 0, 0, -4)
    dh.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dh.BorderSizePixel = 0
    dh.Text = ""
    dh.Parent = ds

    local dn = Instance.new("UICorner")
    dn.CornerRadius = UDim.new(1, 0)
    dn.Parent = dh

    local tg = Instance.new("TextButton")
    tg.Name = "ToggleButton"
    tg.Size = UDim2.new(0, 85, 0, 28)
    tg.Position = UDim2.new(0, 10, 0, 130)
    tg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    tg.BackgroundTransparency = 0.6
    tg.BorderSizePixel = 0
    tg.TextColor3 = Color3.fromRGB(255, 255, 255)
    tg.Text = "OFF"
    tg.TextSize = 12
    tg.Font = Enum.Font.GothamBold
    tg.Parent = mf

    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(0, 6)
    tc.Parent = tg

    local kb = Instance.new("TextButton")
    kb.Name = "KeybindButton"
    kb.Size = UDim2.new(0, 85, 0, 28)
    kb.Position = UDim2.new(0, 105, 0, 130)
    kb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    kb.BackgroundTransparency = 0.6
    kb.BorderSizePixel = 0
    kb.TextColor3 = Color3.fromRGB(255, 255, 255)
    kb.Text = "Key: Z"
    kb.TextSize = 12
    kb.Font = Enum.Font.GothamBold
    kb.Parent = mf

    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(0, 6)
    kc.Parent = kb

    local mi = Instance.new("Frame")
    mi.Name = "MinimizedFrame"
    mi.Size = UDim2.new(0, 95, 0, 35)
    mi.Position = mf.Position
    mi.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mi.BackgroundTransparency = 0.6
    mi.BorderSizePixel = 0
    mi.Visible = false
    mi.Parent = sg

    local mn = Instance.new("UICorner")
    mn.CornerRadius = UDim.new(0, 8)
    mn.Parent = mi

    local mt = Instance.new("TextButton")
    mt.Name = "MinimizedToggle"
    mt.Size = UDim2.new(0, 50, 0, 25)
    mt.Position = UDim2.new(0, 5, 0, 5)
    mt.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mt.BackgroundTransparency = 0.6
    mt.BorderSizePixel = 0
    mt.TextColor3 = Color3.fromRGB(255, 255, 255)
    mt.Text = "OFF"
    mt.TextSize = 11
    mt.Font = Enum.Font.GothamBold
    mt.Parent = mi

    local mv = Instance.new("UICorner")
    mv.CornerRadius = UDim.new(0, 5)
    mv.Parent = mt

    local mx = Instance.new("TextButton")
    mx.Name = "MaximizeButton"
    mx.Size = UDim2.new(0, 30, 0, 25)
    mx.Position = UDim2.new(0, 60, 0, 5)
    mx.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mx.BackgroundTransparency = 0.6
    mx.BorderSizePixel = 0
    mx.TextColor3 = Color3.fromRGB(255, 255, 255)
    mx.Text = "+"
    mx.TextSize = 16
    mx.Font = Enum.Font.GothamBold
    mx.Parent = mi

    local mz = Instance.new("UICorner")
    mz.CornerRadius = UDim.new(0, 5)
    mz.Parent = mx

    local function us(sr, hn, vl, mn, mx)
      local pc = (vl - mn) / (mx - mn)
      local np = math.clamp(pc * (sr.AbsoluteSize.X - hn.AbsoluteSize.X), 0, sr.AbsoluteSize.X - hn.AbsoluteSize.X)
      hn.Position = UDim2.new(0, np, 0, -4)
    end

    local function sp(sr, hn, mn, mx, iv, cb)
      local dg = false
      
      hn.InputBegan:Connect(function(ip)
        if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
          dg = true
        end
      end)
      
      ui.InputEnded:Connect(function(ip)
        if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
          dg = false
        end
      end)
      
      ui.InputChanged:Connect(function(ip)
        if dg and (ip.UserInputType == Enum.UserInputType.MouseMovement or ip.UserInputType == Enum.UserInputType.Touch) then
          local rx = ip.Position.X - sr.AbsolutePosition.X
          local pc = math.clamp(rx / sr.AbsoluteSize.X, 0, 1)
          local vl = mn + (mx - mn) * pc
          
          us(sr, hn, vl, mn, mx)
          cb(vl)
        end
      end)
      
      us(sr, hn, iv, mn, mx)
    end

    sp(ss, sh, 0.01, 0.5, ft, function(vl)
      ft = vl
      bt = vl
      sl.Text = "Speed: " .. string.format("%.2f", vl)
    end)

    sp(ds, dh, 0.5, 5.0, td, function(vl)
      td = vl
      dl.Text = "Distance: " .. string.format("%.1f", vl)
    end)

    local function ub()
      if getgenv().facefuckactive then
        tg.Text = "ON"
        tg.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        tg.BackgroundTransparency = 0.4
        mt.Text = "ON"
        mt.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        mt.BackgroundTransparency = 0.4
      else
        tg.Text = "OFF"
        tg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        tg.BackgroundTransparency = 0.6
        mt.Text = "OFF"
        mt.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        mt.BackgroundTransparency = 0.6
      end
    end

    tg.MouseButton1Click:Connect(function()
      tm()
      ub()
    end)

    mt.MouseButton1Click:Connect(function()
      tm()
      ub()
    end)

    mb.MouseButton1Click:Connect(function()
      mf.Visible = false
      mi.Visible = true
      mi.Position = mf.Position
    end)

    mx.MouseButton1Click:Connect(function()
      mf.Position = mi.Position
      mf.Visible = true
      mi.Visible = false
    end)

    mi.InputBegan:Connect(function(ip)
      if ip.UserInputType == Enum.UserInputType.MouseButton1 then
        local mp = ip.Position
        local fp = mi.AbsolutePosition
        local fs = mi.AbsoluteSize
        
        if mp.X < fp.X or mp.X > fp.X + fs.X or
           mp.Y < fp.Y or mp.Y > fp.Y + fs.Y then
          return
        end
      end
    end)

    local wk = false
    kb.MouseButton1Click:Connect(function()
      if not wk then
        wk = true
        kb.Text = "Press..."
        kb.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
        kb.BackgroundTransparency = 0.4
        
        local cn
        cn = ui.InputBegan:Connect(function(ip, gp)
          if not gp and ip.UserInputType == Enum.UserInputType.Keyboard then
            getgenv().currentKeybind = ip.KeyCode
            kb.Text = "Key: " .. ip.KeyCode.Name
            kb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            kb.BackgroundTransparency = 0.6
            wk = false
            cn:Disconnect()
          end
        end)
      end
    end)

    cb.MouseButton1Click:Connect(function()
      if getgenv().facefuckactive then
        tm()
      end
      sg:Destroy()
    end)

    local ds
    local sp
    local dg = false
    
    tb.InputBegan:Connect(function(ip)
      if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
        dg = true
        ds = ip.Position
        sp = mf.Position
      end
    end)
    
    ui.InputEnded:Connect(function(ip)
      if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
        dg = false
      end
    end)
    
    ui.InputChanged:Connect(function(ip)
      if dg and (ip.UserInputType == Enum.UserInputType.MouseMovement or ip.UserInputType == Enum.UserInputType.Touch) then
        local dt = ip.Position - ds
        mf.Position = UDim2.new(
          sp.X.Scale, 
          sp.X.Offset + dt.X,
          sp.Y.Scale,
          sp.Y.Offset + dt.Y
        )
      end
    end)

    local dm
    local sm
    local dn = false
    
    mi.InputBegan:Connect(function(ip)
      if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
        dn = true
        dm = ip.Position
        sm = mi.Position
      end
    end)
    
    ui.InputEnded:Connect(function(ip)
      if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
        dn = false
      end
    end)
    
    ui.InputChanged:Connect(function(ip)
      if dn and (ip.UserInputType == Enum.UserInputType.MouseMovement or ip.UserInputType == Enum.UserInputType.Touch) then
        local dt = ip.Position - dm
        mi.Position = UDim2.new(
          sm.X.Scale, 
          sm.X.Offset + dt.X,
          sm.Y.Scale,
          sm.Y.Offset + dt.Y
        )
      end
    end)
  end

  ui.InputBegan:Connect(function(ip, gp)
    if not gp and ip.KeyCode == getgenv().currentKeybind then
      tm()
      
      local gu = pg:FindFirstChild("FaceBangGui")
      if gu then
        if gu:FindFirstChild("MainFrame") and gu.MainFrame.Visible then
          local tg = gu.MainFrame.ToggleButton
          if getgenv().facefuckactive then
            tg.Text = "ON"
            tg.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            tg.BackgroundTransparency = 0.4
          else
            tg.Text = "OFF"
            tg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            tg.BackgroundTransparency = 0.6
          end
        end
        if gu:FindFirstChild("MinimizedFrame") and gu.MinimizedFrame.Visible then
          local mt = gu.MinimizedFrame.MinimizedToggle
          if getgenv().facefuckactive then
            mt.Text = "ON"
            mt.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            mt.BackgroundTransparency = 0.4
          else
            mt.Text = "OFF"
            mt.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            mt.BackgroundTransparency = 0.6
          end
        end
      end
    end
  end)

  sc()
  sa()
  cg()
