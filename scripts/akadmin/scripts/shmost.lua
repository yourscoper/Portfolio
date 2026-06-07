local ts=game:GetService("TeleportService")
local hs=game:GetService("HttpService")
local ps=game:GetService("Players")
local tw=game:GetService("TweenService")
local lp=ps.LocalPlayer

local vf="VisitedServers_"..game.PlaceId..".json"
local mn=8
local mx=math.floor(ps.MaxPlayers*0.95)
local ms=1
local mr=15
local sp=8
local sb={}

local as=0.6
local es=Enum.EasingStyle.Quart
local ed=Enum.EasingDirection.Out

local sg=Instance.new("ScreenGui")
sg.Name="TeleportStatusGui"
sg.ResetOnSpawn=false
sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
sg.Parent=game:GetService("CoreGui")

local bf=Instance.new("Frame")
bf.Name="BackdropFrame"
bf.Size=UDim2.new(0,280,0,110)
bf.Position=UDim2.new(0.5,-140,0.05,0)
bf.BackgroundColor3=Color3.fromRGB(0,0,0)
bf.BackgroundTransparency=0.7
bf.BorderSizePixel=0
bf.Parent=sg

local bc=Instance.new("UICorner")
bc.CornerRadius=UDim.new(0,12)
bc.Parent=bf

local cf=Instance.new("Frame")
cf.Name="ContentFrame"
cf.Size=UDim2.new(1,-16,1,-16)
cf.Position=UDim2.new(0,8,0,8)
cf.BackgroundTransparency=1
cf.Parent=bf

local at=Instance.new("TextLabel")
at.Name="AdminText"
at.Size=UDim2.new(0,80,0,12)
at.Position=UDim2.new(0,0,0,0)
at.BackgroundTransparency=1
at.Text="AK ADMIN"
at.TextColor3=Color3.fromRGB(255,255,255)
at.TextSize=10
at.Font=Enum.Font.GothamBold
at.TextXAlignment=Enum.TextXAlignment.Left
at.TextTransparency=0.3
at.Parent=cf

local tt=Instance.new("TextLabel")
tt.Name="TitleText"
tt.Size=UDim2.new(1,-80,0,18)
tt.Position=UDim2.new(0,0,0,14)
tt.BackgroundTransparency=1
tt.Text="Serverhop Most"
tt.TextColor3=Color3.fromRGB(255,255,255)
tt.TextSize=14
tt.Font=Enum.Font.GothamBold
tt.TextXAlignment=Enum.TextXAlignment.Left
tt.TextTransparency=0.2
tt.Parent=cf

local st=Instance.new("TextLabel")
st.Name="StatusText"
st.Size=UDim2.new(1,0,0,24)
st.Position=UDim2.new(0,0,0,34)
st.BackgroundTransparency=1
st.Text="Initializing..."
st.TextColor3=Color3.fromRGB(200,200,200)
st.TextSize=11
st.Font=Enum.Font.Gotham
st.TextWrapped=true
st.TextYAlignment=Enum.TextYAlignment.Top
st.TextXAlignment=Enum.TextXAlignment.Left
st.TextTransparency=0.3
st.Parent=cf

local pc=Instance.new("Frame")
pc.Name="ProgressContainer"
pc.Size=UDim2.new(1,0,0,4)
pc.Position=UDim2.new(0,0,0,62)
pc.BackgroundColor3=Color3.fromRGB(0,0,0)
pc.BackgroundTransparency=0.8
pc.BorderSizePixel=0
pc.Parent=cf

local p1=Instance.new("UICorner")
p1.CornerRadius=UDim.new(1,0)
p1.Parent=pc

local pb=Instance.new("Frame")
pb.Name="ProgressBar"
pb.Size=UDim2.new(0,0,1,0)
pb.BackgroundColor3=Color3.fromRGB(255,255,255)
pb.BackgroundTransparency=0.6
pb.BorderSizePixel=0
pb.Parent=pc

local p2=Instance.new("UICorner")
p2.CornerRadius=UDim.new(1,0)
p2.Parent=pb

local cb=Instance.new("TextButton")
cb.Name="CloseButton"
cb.Size=UDim2.new(0,18,0,18)
cb.Position=UDim2.new(1,-18,0,0)
cb.BackgroundColor3=Color3.fromRGB(0,0,0)
cb.BackgroundTransparency=0.7
cb.BorderSizePixel=0
cb.Text="×"
cb.TextColor3=Color3.fromRGB(255,255,255)
cb.TextSize=14
cb.Font=Enum.Font.GothamBold
cb.TextTransparency=0.3
cb.Parent=cf

local c1=Instance.new("UICorner")
c1.CornerRadius=UDim.new(1,0)
c1.Parent=cb

cb.MouseEnter:Connect(function()
tw:Create(cb,TweenInfo.new(0.2,es,ed),{BackgroundTransparency=0.4}):Play()
end)

cb.MouseLeave:Connect(function()
tw:Create(cb,TweenInfo.new(0.2,es,ed),{BackgroundTransparency=0.7}):Play()
end)

cb.MouseButton1Click:Connect(function()
local fo=tw:Create(bf,TweenInfo.new(0.3,es,ed),{BackgroundTransparency=1})
fo:Play()
fo.Completed:Connect(function()
sg:Destroy()
end)
end)

local rb=Instance.new("TextButton")
rb.Name="RetryButton"
rb.Size=UDim2.new(0,90,0,22)
rb.Position=UDim2.new(0.5,-45,1,-28)
rb.BackgroundColor3=Color3.fromRGB(0,0,0)
rb.BackgroundTransparency=0.7
rb.BorderSizePixel=0
rb.Text="Search Again"
rb.TextColor3=Color3.fromRGB(255,255,255)
rb.TextSize=10
rb.Font=Enum.Font.GothamSemibold
rb.TextTransparency=0.3
rb.Parent=cf

local r1=Instance.new("UICorner")
r1.CornerRadius=UDim.new(0,6)
r1.Parent=rb

rb.MouseEnter:Connect(function()
tw:Create(rb,TweenInfo.new(0.2,es,ed),{BackgroundTransparency=0.5}):Play()
end)

rb.MouseLeave:Connect(function()
tw:Create(rb,TweenInfo.new(0.2,es,ed),{BackgroundTransparency=0.7}):Play()
end)

local function an(m,p)
local tf=tw:Create(st,TweenInfo.new(0.2,es,ed),{TextTransparency=0.8})
tf:Play()
tf.Completed:Connect(function()
st.Text=m
tw:Create(st,TweenInfo.new(0.2,es,ed),{TextTransparency=0.3}):Play()
end)
local pt=tw:Create(pb,TweenInfo.new(as,es,ed),{Size=UDim2.new(math.max(0.02,p),0,1,0)})
pt:Play()
end

local function lv()
local s,r=pcall(function()
if not isfolder("ServerHistory")then
makefolder("ServerHistory")
end
local fp="ServerHistory/"..vf
if isfile(fp)then
return hs:JSONDecode(readfile(fp))
else
return{}
end
end)
return s and r or{}
end

local function sv(vs)
pcall(function()
if not isfolder("ServerHistory")then
makefolder("ServerHistory")
end
local fp="ServerHistory/"..vf
writefile(fp,hs:JSONEncode(vs))
end)
end

local function ac(vs)
local cg=game.JobId
if cg~=""then
vs[cg]={timestamp=os.time(),playerCount=#ps:GetPlayers()}
sv(vs)
end
end

local function ga()
local al={}
local cr=""
local pg=0
local ma=3
repeat
local s,r=false,nil
local rc=0
repeat
rc=rc+1
s,r=pcall(function()
local u="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"
if cr~=""then
u=u.."&cursor="..cr
end
return hs:JSONDecode(game:HttpGet(u))
end)
if not s then
wait(rc*0.5)
end
until s or rc>=ma
if s and r and r.data then
for _,sv in ipairs(r.data)do
if sv.id and sv.playing and sv.maxPlayers then
table.insert(al,sv)
end
end
cr=r.nextPageCursor or""
pg=pg+1
an("Fetching page "..pg.."/"..sp,0.1+(pg/sp)*0.3)
wait(0.1)
else
cr=""
end
until cr=="" or pg>=sp
return al
end

local function fh(sl,vs,ex)
ex=ex or{}
local bs=nil
local hp=0
local sc=0
local cd={}
for _,sv in pairs(sl)do
sc=sc+1
if ex[sv.id]or sb[sv.id]or sv.id==game.JobId then
continue
end
local pc=sv.playing or 0
local mp=sv.maxPlayers or ps.MaxPlayers
local sa=mp-pc
if pc<mn or sa<ms then
continue
end
if pc>mx then
continue
end
if pc>hp then
hp=pc
end
local pr=pc*100
if vs[sv.id]then
local ta=os.time()-vs[sv.id].timestamp
if ta<1800 then
pr=pr-500
elseif ta<3600 then
pr=pr-200
end
else
pr=pr+100
end
local io=mp*0.7
if math.abs(pc-io)<mp*0.2 then
pr=pr+50
end
table.insert(cd,{server=sv,priority=pr,playerCount=pc})
end
table.sort(cd,function(a,b)
return a.priority>b.priority
end)
if #cd>0 then
bs=cd[1].server
return bs,cd[1].priority,hp
end
return nil,0,hp
end

local ft={}
local tg=nil
local rc=0

ts.TeleportInitFailed:Connect(function(pl,tr,em)
if pl==lp then
local fr=tr.Name
if fr=="GameEnded"or fr=="GameFull"or fr=="Unauthorized"then
if rc<mr then
rc=rc+1
an("Finding alternative... ("..rc.."/"..mr..")",0.4)
if tg and tg.id then
ft[tg.id]=true
end
spawn(function()
wait(1)
th()
end)
else
an("No server found after "..mr.." attempts.",1)
end
else
an("Teleport failed: "..fr,1)
end
end
end)

function th()
an("Initializing search...",0.05)
local vs=lv()
ac(vs)
an("Fetching server list...",0.1)
local al=ga()
if #al==0 then
an("No servers available.",1)
return
end
an("Analyzing "..#al.." servers...",0.4)
local tg,sp,hf=fh(al,vs,ft)
local at=0
while not tg and at<3 do
at=at+1
an("Expanding search... ("..at.."/3)",0.6)
if at>=2 then
vs={}
end
local om=mn
mn=math.max(1,mn-(at*3))
tg,sp,hf=fh(al,vs,ft)
mn=om
end
if tg then
local pc=tg.playing
local sa=(tg.maxPlayers or ps.MaxPlayers)-pc
an("Found server: "..pc.." players",0.9)
wait(0.8)
an("Joining server...",1)
local s,e=pcall(function()
ts:TeleportToPlaceInstance(game.PlaceId,tg.id,lp)
end)
if not s and rc<mr then
rc=rc+1
ft[tg.id]=true
an("Connection failed. Retrying...",0.5)
spawn(function()
wait(1)
th()
end)
end
else
an("No suitable servers found.",1)
end
end

rb.MouseButton1Click:Connect(function()
rc=0
ft={}
an("Restarting search...",0.05)
spawn(th)
end)

bf.Size=UDim2.new(0,240,0,90)
bf.Position=UDim2.new(0.5,-120,0.05,10)
bf.BackgroundTransparency=1

local ea=tw:Create(bf,TweenInfo.new(0.8,es,ed),{Size=UDim2.new(0,280,0,110),Position=UDim2.new(0.5,-140,0.05,0),BackgroundTransparency=0.7})
ea:Play()

spawn(function()
wait(0.5)
th()
end)
