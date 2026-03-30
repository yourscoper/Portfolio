local p1=game:GetService("Players")
local p2=game:GetService("UserInputService")
local p3=p1.LocalPlayer
local c1,h1,r1
local c2=workspace.CurrentCamera
local v1=false
local e1=true
local l1=0

local function c3()
local g1=Instance.new("ScreenGui")
g1.Name="AntiBangGUI"
g1.ResetOnSpawn=false
g1.ZIndexBehavior=Enum.ZIndexBehavior.Sibling

local f1=Instance.new("Frame")
f1.Name="MainFrame"
f1.Size=UDim2.new(0,220,0,65)
f1.Position=UDim2.new(0.5,0,0.5,0)
f1.AnchorPoint=Vector2.new(0.5,0.5)
f1.BackgroundColor3=Color3.fromRGB(0,0,0)
f1.BackgroundTransparency=0.7
f1.BorderSizePixel=0
f1.ClipsDescendants=true
f1.Parent=g1

local u1=Instance.new("UICorner")
u1.CornerRadius=UDim.new(0,8)
u1.Parent=f1

local t1=Instance.new("Frame")
t1.Name="Titlebar"
t1.Size=UDim2.new(1,0,0,25)
t1.BackgroundTransparency=1
t1.Parent=f1

local a1=Instance.new("TextLabel")
a1.Name="AKLabel"
a1.Size=UDim2.new(0,65,1,0)
a1.Position=UDim2.new(0,5,0,0)
a1.BackgroundTransparency=1
a1.Text="AK ADMIN"
a1.TextColor3=Color3.fromRGB(255,255,255)
a1.TextSize=10
a1.Font=Enum.Font.GothamBold
a1.TextXAlignment=Enum.TextXAlignment.Left
a1.Parent=t1

local t2=Instance.new("TextLabel")
t2.Name="Title"
t2.Size=UDim2.new(1,-120,1,0)
t2.Position=UDim2.new(0,60,0,0)
t2.BackgroundTransparency=1
t2.Text="ANTI HEADSIT"
t2.TextColor3=Color3.fromRGB(255,255,255)
t2.TextSize=12
t2.Font=Enum.Font.GothamBold
t2.Parent=t1

local m1=Instance.new("TextButton")
m1.Name="MinBtn"
m1.Size=UDim2.new(0,20,0,20)
m1.Position=UDim2.new(1,-45,0,2.5)
m1.BackgroundColor3=Color3.fromRGB(0,0,0)
m1.BackgroundTransparency=0.7
m1.Text="_"
m1.TextColor3=Color3.fromRGB(255,255,255)
m1.TextSize=14
m1.Font=Enum.Font.GothamBold
m1.Parent=t1

local u2=Instance.new("UICorner")
u2.CornerRadius=UDim.new(0,4)
u2.Parent=m1

local c4=Instance.new("TextButton")
c4.Name="CloseBtn"
c4.Size=UDim2.new(0,20,0,20)
c4.Position=UDim2.new(1,-22,0,2.5)
c4.BackgroundColor3=Color3.fromRGB(0,0,0)
c4.BackgroundTransparency=0.7
c4.Text="X"
c4.TextColor3=Color3.fromRGB(255,255,255)
c4.TextSize=12
c4.Font=Enum.Font.GothamBold
c4.Parent=t1

local u3=Instance.new("UICorner")
u3.CornerRadius=UDim.new(0,4)
u3.Parent=c4

local c5=Instance.new("Frame")
c5.Name="Content"
c5.Size=UDim2.new(1,0,1,-25)
c5.Position=UDim2.new(0,0,0,25)
c5.BackgroundTransparency=1
c5.Parent=f1

local b1=Instance.new("TextButton")
b1.Name="ToggleBtn"
b1.Size=UDim2.new(0,80,0,25)
b1.Position=UDim2.new(0.5,0,0,10)
b1.AnchorPoint=Vector2.new(0.5,0)
b1.BackgroundColor3=Color3.fromRGB(0,0,0)
b1.BackgroundTransparency=0.5
b1.Text="ON"
b1.TextColor3=Color3.fromRGB(255,255,255)
b1.TextSize=11
b1.Font=Enum.Font.GothamBold
b1.Parent=c5

local u4=Instance.new("UICorner")
u4.CornerRadius=UDim.new(0,6)
u4.Parent=b1

g1.Parent=p3:WaitForChild("PlayerGui")

local d1=false
local d2,d3,d4

local function u6(i1)
d1=true
d2=i1.Position
d3=f1.Position
local u7
u7=i1.Changed:Connect(function()
if i1.UserInputState==Enum.UserInputState.End then
d1=false
u7:Disconnect()
end
end)
end

local function u8(i1)
if d1 then
local d5=i1.Position-d2
f1.Position=UDim2.new(d3.X.Scale,d3.X.Offset+d5.X,d3.Y.Scale,d3.Y.Offset+d5.Y)
end
end

t1.InputBegan:Connect(function(i1)
if i1.UserInputType==Enum.UserInputType.MouseButton1 or i1.UserInputType==Enum.UserInputType.Touch then
u6(i1)
end
end)

p2.InputChanged:Connect(function(i1)
if i1.UserInputType==Enum.UserInputType.MouseMovement or i1.UserInputType==Enum.UserInputType.Touch then
u8(i1)
end
end)

b1.MouseButton1Click:Connect(function()
e1=not e1
b1.Text=e1 and "ON" or "OFF"
end)

c4.MouseButton1Click:Connect(function()
g1:Destroy()
end)

local m2=true
m1.MouseButton1Click:Connect(function()
m2=not m2
if m2 then
f1:TweenSize(UDim2.new(0,220,0,65),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2,true)
c5.Visible=true
else
f1:TweenSize(UDim2.new(0,220,0,25),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2,true)
task.wait(0.2)
c5.Visible=false
end
end)

return b1
end

local function i3()
if r1 and c1 then
for _,o1 in ipairs(p1:GetPlayers()) do
if o1~=p3 then
local o2=o1.Character
if not o2 then continue end
local o3=o2:FindFirstChildWhichIsA("Humanoid")
if not o3 then continue end
if o3:GetState()~=Enum.HumanoidStateType.Seated then continue end
local o4=o2:FindFirstChild("HumanoidRootPart")
if not o4 then continue end
for _,p4 in ipairs(c1:GetChildren()) do
if p4:IsA("BasePart") then
if (p4.Position-o4.Position).Magnitude<3 then
return o1
end
end
end
end
end
end
return nil
end

workspace.FallenPartsDestroyHeight=0/0

local function v2()
workspace.Camera.CameraType=Enum.CameraType.Fixed
local h2=p3.Character.Humanoid.RootPart
local p4=h2.CFrame
h2.CFrame=p4+Vector3.new(0,-1e3,0)
task.wait(0.1)
h2.CFrame=p4
workspace.Camera.CameraType=Enum.CameraType.Custom
end

local b3=c3()

p2.InputBegan:Connect(function(i1,g2)
if not g2 and i1.KeyCode==Enum.KeyCode.N then
e1=not e1
b3.Text=e1 and "ON" or "OFF"
end
end)

while true do
if e1 then
c1=p3.Character
if c1 then
h1=c1:FindFirstChildWhichIsA("Humanoid")
r1=c1:FindFirstChild("HumanoidRootPart")
local b2=i3()
if b2 and not v1 then
local t4=tick()
if t4-l1>=0.5 then
v1=true
l1=t4
v2()
v1=false
end
end
end
end
task.wait(0.1)
end
