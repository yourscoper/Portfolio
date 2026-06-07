local tc=game:GetService("TextChatService")
local ts=game:GetService("TweenService")
local ui=game:GetService("UserInputService")
local bc=tc:FindFirstChild("BubbleChatConfiguration")
if not bc then bc=Instance.new("BubbleChatConfiguration")bc.Parent=tc end
bc.BackgroundColor3=Color3.fromRGB(0,0,0)
bc.BackgroundTransparency=0.45
bc.TextColor3=Color3.fromRGB(255,255,255)
bc.FontFace=Font.new("rbxasset://fonts/families/GothamSSm.json")
bc.TextSize=14
local function rf(fn)
local sc,dt=pcall(function()return readfile(fn)end)
return sc and dt or nil
end
local function wf(fn,dt)
pcall(function()writefile(fn,dt)end)
end
local sv=rf("chatcolors.txt")
if sv then
local pt={}
for ln in sv:gmatch("[^\r\n]+")do
local ky,vl=ln:match("([^:]+):([^:]+)")
if ky and vl then pt[ky]=vl end
end
if pt.bg then
local r,g,b=pt.bg:match("(%d+),(%d+),(%d+)")
if r then bc.BackgroundColor3=Color3.fromRGB(tonumber(r),tonumber(g),tonumber(b))end
end
if pt.tx then
local r,g,b=pt.tx:match("(%d+),(%d+),(%d+)")
if r then bc.TextColor3=Color3.fromRGB(tonumber(r),tonumber(g),tonumber(b))end
end
end

local sg=Instance.new("ScreenGui")
sg.Name="ChatColorPickerGui"
sg.ResetOnSpawn=false
sg.Parent=game.Players.LocalPlayer:WaitForChild("PlayerGui")

local mf=Instance.new("Frame")
mf.Name="MainFrame"
mf.Size=UDim2.new(0,240,0,280)
mf.Position=UDim2.new(0.5,-120,0.5,-140)
mf.BackgroundColor3=Color3.fromRGB(0,0,0)
mf.BackgroundTransparency=0.7
mf.BorderSizePixel=0
mf.ClipsDescendants=false
mf.Parent=sg

local cr=Instance.new("UICorner")
cr.CornerRadius=UDim.new(0,10)
cr.Parent=mf

local tb=Instance.new("Frame")
tb.Name="TitleBar"
tb.Size=UDim2.new(1,0,0,30)
tb.BackgroundTransparency=1
tb.Parent=mf

local al=Instance.new("TextLabel")
al.Size=UDim2.new(0,70,0,12)
al.Position=UDim2.new(0,6,0,2)
al.BackgroundTransparency=1
al.Text="AK ADMIN"
al.TextColor3=Color3.fromRGB(255,255,255)
al.TextSize=8
al.Font=Enum.Font.GothamBold
al.TextXAlignment=Enum.TextXAlignment.Left
al.Parent=tb

local tl=Instance.new("TextLabel")
tl.Size=UDim2.new(1,-80,0,30)
tl.Position=UDim2.new(0,40,0,0)
tl.BackgroundTransparency=1
tl.Text="CHAT COLORPICKER"
tl.TextColor3=Color3.fromRGB(255,255,255)
tl.TextSize=11
tl.Font=Enum.Font.GothamBold
tl.Parent=tb

local mb=Instance.new("TextButton")
mb.Name="MinMaxButton"
mb.Size=UDim2.new(0,22,0,22)
mb.Position=UDim2.new(1,-52,0,4)
mb.BackgroundColor3=Color3.fromRGB(0,0,0)
mb.BackgroundTransparency=0.7
mb.Text="–"
mb.TextColor3=Color3.fromRGB(255,255,255)
mb.TextSize=15
mb.Font=Enum.Font.GothamBold
mb.BorderSizePixel=0
mb.Parent=tb

local nc=Instance.new("UICorner")
nc.CornerRadius=UDim.new(0,4)
nc.Parent=mb

local cb=Instance.new("TextButton")
cb.Name="CloseButton"
cb.Size=UDim2.new(0,22,0,22)
cb.Position=UDim2.new(1,-26,0,4)
cb.BackgroundColor3=Color3.fromRGB(0,0,0)
cb.BackgroundTransparency=0.7
cb.Text="X"
cb.TextColor3=Color3.fromRGB(255,255,255)
cb.TextSize=12
cb.Font=Enum.Font.GothamBold
cb.BorderSizePixel=0
cb.Parent=tb

local cc=Instance.new("UICorner")
cc.CornerRadius=UDim.new(0,4)
cc.Parent=cb

local cf=Instance.new("Frame")
cf.Name="ContentFrame"
cf.Size=UDim2.new(1,-14,1,-38)
cf.Position=UDim2.new(0,7,0,34)
cf.BackgroundTransparency=1
cf.Parent=mf

local b1=Instance.new("TextButton")
b1.Size=UDim2.new(0,105,0,24)
b1.Position=UDim2.new(0,3,0,0)
b1.BackgroundColor3=bc.BackgroundColor3
b1.BackgroundTransparency=0
b1.Text="BACKGROUND"
b1.TextColor3=Color3.fromRGB(255,255,255)
b1.TextSize=9
b1.Font=Enum.Font.GothamBold
b1.BorderSizePixel=0
b1.Parent=cf

local x1=Instance.new("UICorner")
x1.CornerRadius=UDim.new(0,5)
x1.Parent=b1

local b2=Instance.new("TextButton")
b2.Size=UDim2.new(0,105,0,24)
b2.Position=UDim2.new(1,-108,0,0)
b2.BackgroundColor3=bc.TextColor3
b2.BackgroundTransparency=0
b2.Text="TEXT"
b2.TextColor3=Color3.fromRGB(0,0,0)
b2.TextSize=9
b2.Font=Enum.Font.GothamBold
b2.BorderSizePixel=0
b2.Parent=cf

local x2=Instance.new("UICorner")
x2.CornerRadius=UDim.new(0,5)
x2.Parent=b2

local wh=Instance.new("Frame")
wh.Name="HueBar"
wh.Size=UDim2.new(1,-6,0,20)
wh.Position=UDim2.new(0,3,0,30)
wh.BackgroundColor3=Color3.fromRGB(255,255,255)
wh.BorderSizePixel=0
wh.Parent=cf

local gh=Instance.new("UIGradient")
gh.Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,0,0)),
ColorSequenceKeypoint.new(0.17,Color3.fromRGB(255,255,0)),
ColorSequenceKeypoint.new(0.33,Color3.fromRGB(0,255,0)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(0,255,255)),
ColorSequenceKeypoint.new(0.67,Color3.fromRGB(0,0,255)),
ColorSequenceKeypoint.new(0.83,Color3.fromRGB(255,0,255)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(255,0,0))
}
gh.Parent=wh

local hc=Instance.new("UICorner")
hc.CornerRadius=UDim.new(0,4)
hc.Parent=wh

local hk=Instance.new("Frame")
hk.Size=UDim2.new(0,4,1,4)
hk.Position=UDim2.new(0,-2,0,-2)
hk.BackgroundColor3=Color3.fromRGB(255,255,255)
hk.BorderColor3=Color3.fromRGB(0,0,0)
hk.BorderSizePixel=2
hk.Parent=wh

local ws=Instance.new("Frame")
ws.Name="SatBar"
ws.Size=UDim2.new(1,-6,0,20)
ws.Position=UDim2.new(0,3,0,56)
ws.BackgroundColor3=Color3.fromRGB(255,0,0)
ws.BorderSizePixel=0
ws.Parent=cf

local gs=Instance.new("UIGradient")
gs.Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(255,0,0))
}
gs.Parent=ws

local sc=Instance.new("UICorner")
sc.CornerRadius=UDim.new(0,4)
sc.Parent=ws

local sk=Instance.new("Frame")
sk.Size=UDim2.new(0,4,1,4)
sk.Position=UDim2.new(1,-2,0,-2)
sk.BackgroundColor3=Color3.fromRGB(255,255,255)
sk.BorderColor3=Color3.fromRGB(0,0,0)
sk.BorderSizePixel=2
sk.Parent=ws

local wv=Instance.new("Frame")
wv.Name="ValBar"
wv.Size=UDim2.new(1,-6,0,20)
wv.Position=UDim2.new(0,3,0,82)
wv.BackgroundColor3=Color3.fromRGB(255,0,0)
wv.BorderSizePixel=0
wv.Parent=cf

local gv=Instance.new("UIGradient")
gv.Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.fromRGB(0,0,0)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(255,0,0))
}
gv.Parent=wv

local vc=Instance.new("UICorner")
vc.CornerRadius=UDim.new(0,4)
vc.Parent=wv

local vk=Instance.new("Frame")
vk.Size=UDim2.new(0,4,1,4)
vk.Position=UDim2.new(1,-2,0,-2)
vk.BackgroundColor3=Color3.fromRGB(255,255,255)
vk.BorderColor3=Color3.fromRGB(0,0,0)
vk.BorderSizePixel=2
vk.Parent=wv

local pv=Instance.new("Frame")
pv.Size=UDim2.new(1,-6,0,50)
pv.Position=UDim2.new(0,3,0,108)
pv.BackgroundColor3=bc.BackgroundColor3
pv.BorderSizePixel=0
pv.Parent=cf

local pk=Instance.new("UICorner")
pk.CornerRadius=UDim.new(0,6)
pk.Parent=pv

local sb=Instance.new("TextButton")
sb.Size=UDim2.new(0,65,0,24)
sb.Position=UDim2.new(0.5,-32.5,1,-28)
sb.BackgroundColor3=Color3.fromRGB(0,0,0)
sb.BackgroundTransparency=0.7
sb.Text="SAVE"
sb.TextColor3=Color3.fromRGB(255,255,255)
sb.TextSize=9
sb.Font=Enum.Font.GothamBold
sb.BorderSizePixel=0
sb.Parent=cf

local s2=Instance.new("UICorner")
s2.CornerRadius=UDim.new(0,5)
s2.Parent=sb

local md=1
local hu=0
local sa=1
local va=1
local bg=bc.BackgroundColor3
local tx=bc.TextColor3
local dt=false
local dh=false
local ds=false
local dv=false
local dp=nil
local sp=nil

local function ud(ip)
local dl=ip.Position-dp
mf.Position=UDim2.new(sp.X.Scale,sp.X.Offset+dl.X,sp.Y.Scale,sp.Y.Offset+dl.Y)
end

local function uh(pc)
hu=pc
hk.Position=UDim2.new(pc,-2,0,-2)
local cl=Color3.fromHSV(hu,1,1)
ws.BackgroundColor3=cl
gs.Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,cl)
}
wv.BackgroundColor3=Color3.fromHSV(hu,sa,1)
gv.Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.fromRGB(0,0,0)),
ColorSequenceKeypoint.new(1,Color3.fromHSV(hu,sa,1))
}
local fc=Color3.fromHSV(hu,sa,va)
pv.BackgroundColor3=fc
if md==1 then
bg=fc
b1.BackgroundColor3=fc
bc.BackgroundColor3=fc
else
tx=fc
b2.BackgroundColor3=fc
bc.TextColor3=fc
end
end

local function us(pc)
sa=pc
sk.Position=UDim2.new(pc,-2,0,-2)
wv.BackgroundColor3=Color3.fromHSV(hu,sa,1)
gv.Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.fromRGB(0,0,0)),
ColorSequenceKeypoint.new(1,Color3.fromHSV(hu,sa,1))
}
local fc=Color3.fromHSV(hu,sa,va)
pv.BackgroundColor3=fc
if md==1 then
bg=fc
b1.BackgroundColor3=fc
bc.BackgroundColor3=fc
else
tx=fc
b2.BackgroundColor3=fc
bc.TextColor3=fc
end
end

local function uv(pc)
va=pc
vk.Position=UDim2.new(pc,-2,0,-2)
local fc=Color3.fromHSV(hu,sa,va)
pv.BackgroundColor3=fc
if md==1 then
bg=fc
b1.BackgroundColor3=fc
bc.BackgroundColor3=fc
else
tx=fc
b2.BackgroundColor3=fc
bc.TextColor3=fc
end
end

local function ed(g,hdl)
local dr,di,dst,stp

local function upd(inp)
local d=inp.Position-dst
local np=UDim2.new(stp.X.Scale,stp.X.Offset+d.X,stp.Y.Scale,stp.Y.Offset+d.Y)
g.Position=np
end

hdl.InputBegan:Connect(function(inp)
if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
dr=true
dst=inp.Position
stp=g.Position

inp.Changed:Connect(function()
if inp.UserInputState==Enum.UserInputState.End then
dr=false
end
end)
end
end)

hdl.InputChanged:Connect(function(inp)
if inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch then
di=inp
end
end)

ui.InputChanged:Connect(function(inp)
if inp==di and dr then
upd(inp)
end
end)
end

ed(mf,tb)

wh.InputBegan:Connect(function(ip)
if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then
dh=true
local px=ip.Position.X
local bx=wh.AbsolutePosition.X
local bw=wh.AbsoluteSize.X
local pc=math.clamp((px-bx)/bw,0,1)
uh(pc)
end
end)

ws.InputBegan:Connect(function(ip)
if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then
ds=true
local px=ip.Position.X
local bx=ws.AbsolutePosition.X
local bw=ws.AbsoluteSize.X
local pc=math.clamp((px-bx)/bw,0,1)
us(pc)
end
end)

wv.InputBegan:Connect(function(ip)
if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then
dv=true
local px=ip.Position.X
local bx=wv.AbsolutePosition.X
local bw=wv.AbsoluteSize.X
local pc=math.clamp((px-bx)/bw,0,1)
uv(pc)
end
end)

ui.InputChanged:Connect(function(ip)
if dh and(ip.UserInputType==Enum.UserInputType.MouseMovement or ip.UserInputType==Enum.UserInputType.Touch)then
local px=ip.Position.X
local bx=wh.AbsolutePosition.X
local bw=wh.AbsoluteSize.X
local pc=math.clamp((px-bx)/bw,0,1)
uh(pc)
elseif ds and(ip.UserInputType==Enum.UserInputType.MouseMovement or ip.UserInputType==Enum.UserInputType.Touch)then
local px=ip.Position.X
local bx=ws.AbsolutePosition.X
local bw=ws.AbsoluteSize.X
local pc=math.clamp((px-bx)/bw,0,1)
us(pc)
elseif dv and(ip.UserInputType==Enum.UserInputType.MouseMovement or ip.UserInputType==Enum.UserInputType.Touch)then
local px=ip.Position.X
local bx=wv.AbsolutePosition.X
local bw=wv.AbsoluteSize.X
local pc=math.clamp((px-bx)/bw,0,1)
uv(pc)
end
end)

ui.InputEnded:Connect(function(ip)
if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then
dh=false
ds=false
dv=false
end
end)

local m=false
mb.MouseButton1Click:Connect(function()
m=not m
local target=m and UDim2.new(0,240,0,30) or UDim2.new(0,240,0,280)
mb.Text=m and "+" or "–"
ts:Create(mf,TweenInfo.new(0.3,Enum.EasingStyle.Quad),{Size=target}):Play()
cf.Visible=not m
end)

mb.MouseEnter:Connect(function()
ts:Create(mb,TweenInfo.new(0.2),{BackgroundTransparency=0.5}):Play()
end)

mb.MouseLeave:Connect(function()
ts:Create(mb,TweenInfo.new(0.2),{BackgroundTransparency=0.7}):Play()
end)

cb.MouseEnter:Connect(function()
ts:Create(cb,TweenInfo.new(0.2),{BackgroundTransparency=0.5}):Play()
end)

cb.MouseLeave:Connect(function()
ts:Create(cb,TweenInfo.new(0.2),{BackgroundTransparency=0.7}):Play()
end)

cb.MouseButton1Click:Connect(function()
sg:Destroy()
end)

b1.MouseButton1Click:Connect(function()
md=1
local h,s,v=bg:ToHSV()
hu,sa,va=h,s,v
uh(hu)
us(sa)
uv(va)
end)

b2.MouseButton1Click:Connect(function()
md=2
local h,s,v=tx:ToHSV()
hu,sa,va=h,s,v
uh(hu)
us(sa)
uv(va)
end)

sb.MouseButton1Click:Connect(function()
local r1,g1,b1=math.floor(bg.R*255),math.floor(bg.G*255),math.floor(bg.B*255)
local r2,g2,b2=math.floor(tx.R*255),math.floor(tx.G*255),math.floor(tx.B*255)
local dt="bg:"..r1..","..g1..","..b1.."\ntx:"..r2..","..g2..","..b2
wf("chatcolors.txt",dt)
sb.Text="SAVED!"
wait(1)
sb.Text="SAVE"
end)

sb.MouseEnter:Connect(function()
ts:Create(sb,TweenInfo.new(0.2),{BackgroundTransparency=0.5}):Play()
end)

sb.MouseLeave:Connect(function()
ts:Create(sb,TweenInfo.new(0.2),{BackgroundTransparency=0.7}):Play()
end)
