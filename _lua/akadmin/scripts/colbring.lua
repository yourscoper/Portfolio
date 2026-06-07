
local pl=game:FindFirstChildOfClass("Players")
local lp=pl.LocalPlayer
local ws=game:FindFirstChildOfClass("Workspace")
local ui=game:FindFirstChildOfClass("UserInputService")
local rs=game:FindFirstChildOfClass("RunService")
local hb=rs.Heartbeat
local rt=rs.RenderStepped
local an=CFrame.Angles
local cf=CFrame.new
local v3=Vector3.new
local v0=v3(0,1,0)
local vz=v3(0,0,0)
local oc=os.clock
local tw=task.wait
local sl=string.lower
local ss=string.sub

local sp=32
local ms=75
local of=an(-1.5707963267948966,0,0)

local function gp(p,n,cl)
	if typeof(p)=="Instance" then
		local c=p:GetChildren()
		for i=1,#c do
			local v=c[i]
			if (v.Name==n) and v:IsA(cl) then
				return v
			end
		end
	end
	return nil
end

local ni=Instance.new 
local v2=Vector2.new 
local c3=Color3.new 
local u2=UDim2.new 
local sc,mr=string.char,math.random 
local function rn(l) 
	l=l or mr(8,15) 
	local s="" 
	for i=1,l do 
		if mr(1,2)==1 then 
			s=s..sc(mr(65,90)) 
		else 
			s=s..sc(mr(97,122)) 
		end 
	end 
	return s 
end 
local en=Enum 

local sg=ni("ScreenGui") 
local mf=ni("Frame") 
local tb=ni("Frame") 
local tl=ni("TextLabel") 
local ak=ni("TextLabel") 
local mn=ni("TextButton") 
local cl=ni("TextButton") 
local ct=ni("Frame") 
local sb=ni("TextBox")
local sf=ni("ScrollingFrame")
local bt=ni("TextButton") 

sg.ZIndexBehavior=en.ZIndexBehavior.Sibling
sg.Name=rn() 

mf.AnchorPoint=v2(0.5,0) 
mf.BackgroundColor3=c3(0,0,0) 
mf.BackgroundTransparency=0.7
mf.BorderSizePixel=0 
mf.Position=u2(0.5,0,0.5,-160) 
mf.Size=u2(0,220,0,320) 
mf.Name=rn() 
mf.Parent=sg 
local mc=ni("UICorner")
mc.CornerRadius=UDim.new(0,12)
mc.Parent=mf

tb.BackgroundTransparency=1
tb.BorderSizePixel=0 
tb.Size=u2(1,0,0,35) 
tb.Name=rn() 
tb.Parent=mf 

tl.Font=en.Font.GothamBold
tl.Text="Collision Bring" 
tl.TextColor3=c3(1,1,1) 
tl.TextSize=15 
tl.BackgroundTransparency=1 
tl.BorderSizePixel=0 
tl.AnchorPoint=v2(0.5,0.5)
tl.Position=u2(0.5,0,0.5,0)
tl.Size=u2(0,150,1,0) 
tl.Name=rn() 
tl.Parent=tb 

ak.Font=en.Font.GothamBold
ak.Text="AK ADMIN" 
ak.TextColor3=c3(0.7,0.7,0.7) 
ak.TextSize=9 
ak.BackgroundTransparency=1 
ak.BorderSizePixel=0 
ak.Position=u2(0,8,0,4)
ak.Size=u2(0,80,0,15) 
ak.TextXAlignment=en.TextXAlignment.Left
ak.Name=rn() 
ak.Parent=tb 

mn.BackgroundColor3=c3(0.15,0.15,0.15) 
mn.BackgroundTransparency=0.3
mn.BorderSizePixel=0 
mn.AnchorPoint=v2(1,0)
mn.Position=u2(1,-32,0,6) 
mn.Size=u2(0,20,0,20) 
mn.Font=en.Font.GothamBold
mn.Text="-" 
mn.TextColor3=c3(1,1,1) 
mn.TextSize=18 
mn.Name=rn() 
mn.Parent=tb 
local nc=ni("UICorner")
nc.CornerRadius=UDim.new(0,5)
nc.Parent=mn

cl.BackgroundColor3=c3(0.15,0.15,0.15) 
cl.BackgroundTransparency=0.3
cl.BorderSizePixel=0 
cl.AnchorPoint=v2(1,0)
cl.Position=u2(1,-6,0,6) 
cl.Size=u2(0,20,0,20) 
cl.Font=en.Font.GothamBold
cl.Text="X" 
cl.TextColor3=c3(1,0.3,0.3) 
cl.TextSize=14 
cl.Name=rn() 
cl.Parent=tb 
local cc=ni("UICorner")
cc.CornerRadius=UDim.new(0,5)
cc.Parent=cl

ct.BackgroundTransparency=1
ct.BorderSizePixel=0 
ct.Position=u2(0,10,0,40) 
ct.Size=u2(1,-20,1,-50) 
ct.Name=rn() 
ct.Parent=mf 

sb.Font=en.Font.Gotham
sb.PlaceholderColor3=c3(0.5,0.5,0.5) 
sb.PlaceholderText="Search..." 
sb.Text="" 
sb.TextColor3=c3(1,1,1) 
sb.TextSize=13 
sb.BackgroundColor3=c3(0.1,0.1,0.1) 
sb.BackgroundTransparency=0.5
sb.BorderSizePixel=0 
sb.Position=u2(0,0,0,0) 
sb.Size=u2(1,0,0,28) 
sb.Name=rn() 
sb.Parent=ct 
local xc=ni("UICorner")
xc.CornerRadius=UDim.new(0,7)
xc.Parent=sb

sf.BackgroundColor3=c3(0.05,0.05,0.05)
sf.BackgroundTransparency=0.6
sf.BorderSizePixel=0
sf.Position=u2(0,0,0,35)
sf.Size=u2(1,0,1,-73)
sf.ScrollBarThickness=4
sf.CanvasSize=u2(0,0,0,0)
sf.Name=rn()
sf.Parent=ct
local sc=ni("UICorner")
sc.CornerRadius=UDim.new(0,7)
sc.Parent=sf
local ul=ni("UIListLayout")
ul.Padding=UDim.new(0,3)
ul.Parent=sf

bt.BackgroundColor3=c3(0.2,0.2,0.2) 
bt.BackgroundTransparency=0.3
bt.BorderSizePixel=0 
bt.Position=u2(0,0,1,-33) 
bt.Size=u2(1,0,0,33) 
bt.Font=en.Font.GothamBold
bt.Text="BRING" 
bt.TextColor3=c3(0.5,0.5,0.5) 
bt.TextSize=16 
bt.Name=rn() 
bt.Parent=ct 
local bc=ni("UICorner")
bc.CornerRadius=UDim.new(0,7)
bc.Parent=bt

local function dr(wn,ob)
	local m1=en.UserInputType.MouseButton1
	local tc=en.UserInputType.Touch
	ob=ob or wn
	local ae=0
	local ms=nil
	local ds=nil
	local ib=nil
	local rc=nil
	local ie=nil
	local function ief(a)
		a=a.UserInputType
		if (a==m1) or (a==tc) then
			rc:Disconnect()
			ie:Disconnect()
		end
	end
	local function rcf()
		local of=ui:GetMouseLocation()-ms
		wn.Position=ds+u2(0,of.X,0,of.Y)
	end
	local function ibf(a)
		a=a.UserInputType
		if ((a==m1) or (a==tc)) and (ae==0) and not ui:GetFocusedTextBox() then
			ms=ui:GetMouseLocation()
			ds=wn.Position
			if rc then rc:Disconnect() end
			rc=rt:Connect(rcf)
			if ie then ie:Disconnect() end
			ie=ui.InputEnded:Connect(ief)
		end
	end
	ob.MouseEnter:Connect(function()
		if ib then ib:Disconnect() end
		ib=ui.InputBegan:Connect(ibf)
	end)
	ob.MouseLeave:Connect(function()
		ib:Disconnect()
	end)
	local function od(d)
		if d:IsA("GuiObject") then
			local te=false
			local ta=false
			local c0=d.MouseEnter:Connect(function()
				te=true
				if (not ta) and d.Active then
					ae=ae+1
					ta=true
				end
			end)
			local c1=d.MouseLeave:Connect(function()
				te=false
				if ta then
					ae=ae-1
					ta=false
				end
			end)
			local c2=d:GetPropertyChangedSignal("Active"):Connect(function()
				if te then
					if ta and not d.Active then
						ae=ae-1
						ta=false
					elseif d.Active and not ta then
						ae=ae+1
						ta=true
					end
				end
			end)
			local c3=nil
			c3=d.AncestryChanged:Connect(function()
				if not d:IsDescendantOf(wn) then
					if te then
						ae=ae-1
					end
					c0:Disconnect()
					c1:Disconnect()
					c2:Disconnect()
					c3:Disconnect()
				end
			end)
		end
	end
	wn.DescendantAdded:Connect(od)
	local de=wn:GetDescendants()
	for i=1,#de do 
		od(de[i])
	end
end
dr(mf,tb)

local tg=nil
local pf={}

local function cp(pr)
	local fr=ni("Frame")
	fr.BackgroundColor3=c3(0.12,0.12,0.12)
	fr.BackgroundTransparency=0.4
	fr.BorderSizePixel=0
	fr.Size=u2(1,0,0,42)
	fr.Name=rn()
	local fc=ni("UICorner")
	fc.CornerRadius=UDim.new(0,6)
	fc.Parent=fr
	
	local im=ni("ImageLabel")
	im.BackgroundTransparency=1
	im.BorderSizePixel=0
	im.Position=u2(0,4,0,4)
	im.Size=u2(0,34,0,34)
	im.Image="rbxthumb://type=AvatarHeadShot&id="..pr.UserId.."&w=150&h=150"
	im.Name=rn()
	im.Parent=fr
	local ic=ni("UICorner")
	ic.CornerRadius=UDim.new(1,0)
	ic.Parent=im
	
	local dn=ni("TextLabel")
	dn.Font=en.Font.GothamBold
	dn.Text=pr.DisplayName
	dn.TextColor3=c3(1,1,1)
	dn.TextSize=11
	dn.TextXAlignment=en.TextXAlignment.Left
	dn.BackgroundTransparency=1
	dn.BorderSizePixel=0
	dn.Position=u2(0,42,0,6)
	dn.Size=u2(1,-46,0,13)
	dn.TextTruncate=en.TextTruncate.AtEnd
	dn.Name=rn()
	dn.Parent=fr
	
	local un=ni("TextLabel")
	un.Font=en.Font.Gotham
	un.Text="@"..pr.Name
	un.TextColor3=c3(0.7,0.7,0.7)
	un.TextSize=9
	un.TextXAlignment=en.TextXAlignment.Left
	un.BackgroundTransparency=1
	un.BorderSizePixel=0
	un.Position=u2(0,42,0,23)
	un.Size=u2(1,-46,0,13)
	un.TextTruncate=en.TextTruncate.AtEnd
	un.Name=rn()
	un.Parent=fr
	
	local bn=ni("TextButton")
	bn.BackgroundTransparency=1
	bn.BorderSizePixel=0
	bn.Size=u2(1,0,1,0)
	bn.Text=""
	bn.Name=rn()
	bn.Parent=fr
	
	bn.MouseButton1Click:Connect(function()
		tg=pr
		for _,v in pairs(pf) do
			v.BackgroundColor3=c3(0.12,0.12,0.12)
		end
		fr.BackgroundColor3=c3(0.2,0.4,0.2)
		bt.TextColor3=c3(0.3,1,0)
	end)
	
	pf[pr]=fr
	fr.Parent=sf
	return fr
end

local function up()
	local st=sl(sb.Text)
	local cn=0
	for pr,fr in pairs(pf) do
		if pr and pr.Parent then
			local nm=sl(pr.Name)
			local dm=sl(pr.DisplayName)
			if st=="" or nm:find(st,1,true) or dm:find(st,1,true) then
				fr.Visible=true
				cn=cn+1
			else
				fr.Visible=false
			end
		end
	end
	sf.CanvasSize=u2(0,0,0,cn*45)
end

for _,pr in pairs(pl:GetPlayers()) do
	if pr~=lp then
		cp(pr)
	end
end

pl.PlayerAdded:Connect(function(pr)
	cp(pr)
	up()
end)

pl.PlayerRemoving:Connect(function(pr)
	if pf[pr] then
		pf[pr]:Destroy()
		pf[pr]=nil
	end
	if pr==tg then
		tg=nil
		bt.TextColor3=c3(0.5,0.5,0.5)
	end
	up()
end)

sb:GetPropertyChangedSignal("Text"):Connect(up)
up()

local br=false
bt.MouseButton1Click:Connect(function()
	if br then
		br=false
		bt.Text="BRING"
		return
	end
	if not tg then
		return
	end
	local c=lp.Character
	local c1=tg.Character
	if not (c and c1) then
		return
	end
	if not (c:IsDescendantOf(ws) and c1:IsDescendantOf(ws)) then
		return
	end
	local hr=gp(c,"HumanoidRootPart","BasePart")
	local h1=gp(c1,"HumanoidRootPart","BasePart")
	if not (hr and h1) then
		return
	end
	br=true
	bt.Text="bringing" 
	local fm=h1.CFrame
	local fp=fm.Position
	local to=hr.CFrame
	local tp=to.Position
	local mg=(fp-tp).Magnitude-3
	local lv=cf(fp,tp).LookVector
	local vl=0
	local ps=fm.Position-v0*2
	tp=tp-v0*2

	local sn=oc()
	local ls=sn
	local wy=0
	local rm=false
	while br and c:IsDescendantOf(ws) and c1:IsDescendantOf(ws) do
		sn=oc()
		local dt=sn-ls
		ls=sn
		if rm then
			if mg-wy<rm then
				vl=vl-dt*sp
				if vl<0 then
					break
				end
			end
		else
			if wy>mg/2 then
				vl=vl-dt*sp
				if vl<0 then
					break
				end
			else
				vl=vl+dt*sp
				if vl>ms then
					rm=wy
					vl=ms
				end
			end
		end
		wy=wy+vl*dt
		if not hr:IsGrounded() then
			hr.CFrame=cf(ps+lv*wy,tp)*of
			hr.Velocity=lv*(vl+1)
			hr.RotVelocity=vz
		end
		tw()
	end
	local hm=gp(c,"Humanoid","Humanoid")
	if hm then
		hm:ChangeState(en.HumanoidStateType.Running)
	end
	hr.CFrame=to
	hr.Velocity=vz
	hr.RotVelocity=vz
	hr.AssemblyLinearVelocity=vz
	hr.AssemblyAngularVelocity=vz
	br=false
	bt.Text="BRING"
end)

local mi=false
local fs=u2(0,220,0,320)
local ms=u2(0,220,0,35)
mn.MouseButton1Click:Connect(function()
	mi=not mi
	if mi then
		ct.Visible=false
		mf:TweenSize(ms,en.EasingDirection.Out,en.EasingStyle.Quad,0.2,true)
	else
		mf:TweenSize(fs,en.EasingDirection.Out,en.EasingStyle.Quad,0.2,true)
		tw(0.1)
		ct.Visible=true
	end
end)

cl.MouseButton1Click:Connect(function()
	sg:Destroy()
end)

local ic,_=pcall(function()
	sg.Parent=game:FindFirstChildOfClass("CoreGui")
end)
if not ic then
	sg.Parent=lp:FindFirstChildOfClass("PlayerGui")
end
