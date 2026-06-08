local _Players = game:GetService('Players')
local _Workspace = game:GetService('Workspace')
local _UserInputService = game:GetService('UserInputService')
local _RunService = game:GetService('RunService')
local _ReplicatedStorage = game:GetService('ReplicatedStorage')
local _TweenService = game:GetService('TweenService')
local _LocalPlayer = _Players.LocalPlayer
local u8 = nil
local _HttpService = game:GetService('HttpService')
local u10 = false
local u11 = nil
local u12 = nil
local u13 = nil
local u14 = nil
local u15 = nil
local u16 = nil
local u17 = {}
local u18 = {}
local u19 = {}
local u20 = {}
local u21 = {
    idle = nil,
    walking = nil,
    jumping = nil,
}
local u22 = 'ak/state_animations.json'
local u23 = {}
local u24 = {
    'Head',
    'UpperTorso',
    'LowerTorso',
    'LeftUpperArm',
    'LeftLowerArm',
    'LeftHand',
    'RightUpperArm',
    'RightLowerArm',
    'RightHand',
    'LeftUpperLeg',
    'LeftLowerLeg',
    'LeftFoot',
    'RightUpperLeg',
    'RightLowerLeg',
    'RightFoot',
    'Torso',
    'Left Arm',
    'Right Arm',
    'Left Leg',
    'Right Leg',
}
local u25 = {
    isRunning = false,
    currentId = nil,
    keyframes = nil,
    totalDuration = 0,
    elapsedTime = 0,
    speed = 1,
    connection = nil,
}
local u26 = {}
local u27 = {}
local u28 = false

(function()
    local function v33(p29)
        if u8 then
            local _HumanoidRootPart = p29:WaitForChild('HumanoidRootPart', 5)

            if _HumanoidRootPart then
                _HumanoidRootPart.CFrame = u8
            end

            u8 = nil
        end

        local _Humanoid = p29:FindFirstChildOfClass('Humanoid')

        if _Humanoid then
            _Humanoid.Died:Connect(function()
                local _HumanoidRootPart2 = p29:FindFirstChild('HumanoidRootPart')

                if _HumanoidRootPart2 then
                    u8 = _HumanoidRootPart2.CFrame
                end
            end)
        end
    end

    if _LocalPlayer.Character then
        v33(_LocalPlayer.Character)
    end

    _LocalPlayer.CharacterAdded:Connect(v33)
end)();
(function()
    if u28 then
        return
    else
        u28 = true

        local v34 = 'https://yourscoper.pages.dev/animlist.lua'
        local v35, v36 = pcall(game.HttpGet, game, v34, true)

        if v35 then
            local v37, v38 = pcall(loadstring(v36))

            if v37 and type(v38) == 'table' then
                u26 = {}

                local v39, v40, v41 = pairs(v38)

                while true do
                    local v42

                    v41, v42 = v39(v40, v41)

                    if v41 == nil then
                        break
                    end

                    u26[v41] = v42
                end
            else
                warn('Failed to load or parse animation list. Content might be invalid. Error:', v38)
            end
        else
            warn('Failed to fetch animation list from URL:', v34, 'Error:', v36)

            return
        end
    end
end)()

local u43 = {}
local u44 = {}
local u45 = {}
local u46 = 'ak/custom_animations.json'
local u47 = 'ak/speed_keybinds.json'
local u48 = {
    SlowMarker = {
        ratio = 0.2,
        key = '',
    },
    FastMarker = {
        ratio = 0.8,
        key = '',
    },
}
local u49 = {}

local function u50()
    if not isfolder('ak') then
        makefolder('ak')
    end
end
local function u58()
    u50()

    local v51, v52, v53 = pairs(u43)
    local v54 = {}

    while true do
        local v55

        v53, v55 = v51(v52, v53)

        if v53 == nil then
            break
        end

        v54[v53] = tostring(v55)
    end

    local v56, u57 = pcall(_HttpService.JSONEncode, _HttpService, v54)

    if v56 then
        pcall(function()
            writefile('ak/favorite_animations.json', u57)
        end)
    end
end
local function u67()
    u50()

    local v59, v60 = pcall(readfile, 'ak/favorite_animations.json')

    if v59 then
        local v61, v62 = pcall(_HttpService.JSONDecode, _HttpService, v60)

        if v61 and typeof(v62) == 'table' then
            u43 = {}

            local v63, v64, v65 = pairs(v62)

            while true do
                local v66

                v65, v66 = v63(v64, v65)

                if v65 == nil then
                    break
                end

                u43[v65] = v66

                if not u26[v65] then
                    u26[v65] = v66

                    if not table.find(u27, v65) then
                        table.insert(u27, v65)
                    end
                end
            end
        else
            u43 = {}
        end
    else
        u43 = {}
    end
end
local function u75()
    u50()

    local v68, v69, v70 = pairs(u44)
    local v71 = {}

    while true do
        local v72

        v70, v72 = v68(v69, v70)

        if v70 == nil then
            break
        end

        v71[v70] = v72.Name
    end

    local v73, u74 = pcall(_HttpService.JSONEncode, _HttpService, v71)

    if v73 then
        pcall(function()
            writefile('ak/animation_keybinds.json', u74)
        end)
    end
end
local function u85()
    u50()

    local v76, v77 = pcall(readfile, 'ak/animation_keybinds.json')

    if v76 then
        local v78, v79 = pcall(_HttpService.JSONDecode, _HttpService, v77)

        if v78 and typeof(v79) == 'table' then
            u44 = {}

            local v80, v81, v82 = pairs(v79)

            while true do
                local v83

                v82, v83 = v80(v81, v82)

                if v82 == nil then
                    break
                end

                local v84 = Enum.KeyCode[v83]

                if v84 then
                    u44[v82] = v84
                end
            end
        else
            u44 = {}
        end
    else
        u44 = {}
    end
end
local function u89()
    u50()

    local v86 = {
        SlowMarker = u48.SlowMarker,
        FastMarker = u48.FastMarker,
    }
    local v87, u88 = pcall(_HttpService.JSONEncode, _HttpService, v86)

    if v87 then
        pcall(function()
            writefile(u47, u88)
        end)
    end
end
local function u94()
    u50()

    local v90, v91 = pcall(readfile, u47)

    if v90 then
        local v92, v93 = pcall(_HttpService.JSONDecode, _HttpService, v91)

        if v92 and (typeof(v93) == 'table' and (v93.SlowMarker and (type(v93.SlowMarker.ratio) == 'number' and (type(v93.SlowMarker.key) == 'string' and (v93.FastMarker and (type(v93.FastMarker.ratio) == 'number' and type(v93.FastMarker.key) == 'string')))))) then
            u48 = v93
        end
    end
end
local function u98()
    u50()

    local v95 = {
        idle = u21.idle,
        walking = u21.walking,
        jumping = u21.jumping,
    }
    local v96, u97 = pcall(_HttpService.JSONEncode, _HttpService, v95)

    if v96 then
        pcall(function()
            writefile(u22, u97)
        end)
    end
end
local function u103()
    u50()

    local v99, v100 = pcall(readfile, u22)

    if v99 then
        local v101, v102 = pcall(_HttpService.JSONDecode, _HttpService, v100)

        if v101 and typeof(v102) == 'table' then
            u21.idle = v102.idle
            u21.walking = v102.walking
            u21.jumping = v102.jumping
        end
    end
end
local function u111()
    u50()

    local v104, v105, v106 = pairs(u45)
    local v107 = {}

    while true do
        local v108

        v106, v108 = v104(v105, v106)

        if v106 == nil then
            break
        end

        v107[v106] = v108
    end

    local v109, u110 = pcall(_HttpService.JSONEncode, _HttpService, v107)

    if v109 then
        pcall(function()
            writefile(u46, u110)
        end)
    end
end
local function u120()
    u50()

    local v112, v113 = pcall(readfile, u46)

    if v112 then
        local v114, v115 = pcall(_HttpService.JSONDecode, _HttpService, v113)

        if v114 and typeof(v115) == 'table' then
            u45 = {}

            local v116, v117, v118 = pairs(v115)

            while true do
                local v119

                v118, v119 = v116(v117, v118)

                if v118 == nil then
                    break
                end

                u45[v118] = v119

                if not u26[v118] then
                    u26[v118] = v119

                    if not table.find(u27, v118) then
                        table.insert(u27, v118)
                    end
                end
            end
        else
            u45 = {}
        end
    else
        u45 = {}
    end
end
local function u133(p121)
    local v122, v123, v124 = pairs(p121)

    while true do
        local u125

        v124, u125 = v122(v123, v124)

        if v124 == nil then
            break
        end
        if not u19[u125] then
            local v126 = nil
            local v127 = nil
            local v128

            if tostring(u125):match('^http') then
                local v129, u130 = pcall(function()
                    return game:HttpGet(u125)
                end)

                if v129 then
                    local v131

                    v131, v128 = pcall(function()
                        return loadstring(u130)()
                    end)

                    if v131 and type(v128) == 'table' then
                        v126 = true
                    else
                        v128 = v127
                    end
                else
                    v128 = v127
                end
            elseif tonumber(u125) then
                v126, v128 = pcall(function()
                    return game:GetObjects('rbxassetid://' .. u125)[1]
                end)
            else
                local v132

                v132, v128 = pcall(function()
                    return loadstring(u125)()
                end)

                if v132 and type(v128) == 'table' then
                    v126 = true
                else
                    v128 = v127
                end
            end
            if v126 and v128 then
                u19[u125] = v128
            end
        end
    end
end
local function u140()
    u85()
    u67()
    u120()
    u103()

    local v134, v135, v136 = pairs(u43)
    local v137 = {}
    local v138 = 0

    while true do
        local v139

        v136, v139 = v134(v135, v136)

        if v136 == nil then
            break
        end

        v137[v136] = v139
        v138 = v138 + 1

        if v138 >= 10 then
            break
        end
    end

    u133(v137)
end

local u141 = {}

local function u147()
    local _PlayerGui = _LocalPlayer:FindFirstChildWhichIsA('PlayerGui')

    if _PlayerGui then
        local v143, v144, v145 = ipairs(_PlayerGui:GetChildren())

        while true do
            local v146

            v145, v146 = v143(v144, v145)

            if v145 == nil then
                break
            end
            if v146:IsA('ScreenGui') and v146.ResetOnSpawn then
                table.insert(u141, v146)

                v146.ResetOnSpawn = false
            end
        end
    end
end
local function u152()
    local v148, v149, v150 = ipairs(u141)

    while true do
        local v151

        v150, v151 = v148(v149, v150)

        if v150 == nil then
            break
        end

        v151.ResetOnSpawn = true
    end

    table.clear(u141)
end
local function u163()
    if u12 then
        local v153 = u12
        local v154, v155, v156 = pairs(v153:GetDescendants())

        while true do
            local v157

            v156, v157 = v154(v155, v156)

            if v156 == nil then
                break
            end
            if v157:IsA('BasePart') then
                v157.Transparency = 1
            end
        end

        local _Head = u12:FindFirstChild('Head')

        if _Head then
            local v159, v160, v161 = ipairs(_Head:GetChildren())

            while true do
                local v162

                v161, v162 = v159(v160, v161)

                if v161 == nil then
                    break
                end
                if v162:IsA('Decal') then
                    v162.Transparency = 1
                end
            end
        end
    end
end
local function u170()
    if u10 and (u11 and u12) then
        local v164, v165, v166 = ipairs(u24)

        while true do
            local v167

            v166, v167 = v164(v165, v166)

            if v166 == nil then
                break
            end

            local v168 = u11:FindFirstChild(v167)
            local v169 = u12:FindFirstChild(v167)

            if v168 and v169 then
                v168.CFrame = v169.CFrame
                v168.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                v168.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            end
        end
    end
end
local function u173()
    pcall(function()
        local _VirtuallyNad = _Workspace:FindFirstChild('VirtuallyNad')

        if _VirtuallyNad then
            local _HeadMovement = _VirtuallyNad:FindFirstChild('HeadMovement')

            if _HeadMovement and _HeadMovement:IsA('LocalScript') then
                _HeadMovement.Disabled = true
            end
        end

        _LocalPlayer:SetAttribute('TurnHead', false)
    end)
end
local function u176()
    pcall(function()
        local _VirtuallyNad2 = _Workspace:FindFirstChild('VirtuallyNad')

        if _VirtuallyNad2 then
            local _HeadMovement2 = _VirtuallyNad2:FindFirstChild('HeadMovement')

            if _HeadMovement2 and _HeadMovement2:IsA('LocalScript') then
                _HeadMovement2.Disabled = false
            end
        end
    end)
end

local u177 = nil

local function u217(p178)
    u10 = p178

    local _event_rag = game:GetService('ReplicatedStorage'):FindFirstChild('event_rag')
    local _Ragdoll = game:GetService('ReplicatedStorage'):FindFirstChild('Ragdoll')
    local _Unragdoll = game:GetService('ReplicatedStorage'):FindFirstChild('Unragdoll')
    local u182 = nil

    if not (_event_rag or _Ragdoll) then
        local v185, v186 = pcall(function()
            local _LocalModules = _ReplicatedStorage:FindFirstChild('LocalModules', true)
            local v184 = _LocalModules and _LocalModules:FindFirstChild('Backend')

            if v184 then
                local _ = require
                local _ = v184.FindFirstChild
            end
        end)

        u182 = v185 and v186 and v186 or u182
    end
    if u10 then
        local _Character = _LocalPlayer.Character

        if not _Character then
            return
        end

        local _Humanoid2 = _Character:FindFirstChildOfClass('Humanoid')
        local _HumanoidRootPart3 = _Character:FindFirstChild('HumanoidRootPart')

        if not (_Humanoid2 and _HumanoidRootPart3) then
            return
        end

        u11 = _Character
        u13 = _HumanoidRootPart3.CFrame
        _Character.Archivable = true
        u12 = _Character:Clone()
        _Character.Archivable = false

        local _Name = u11.Name

        u12.Name = _Name .. 'Celeste'

        local _Humanoid3 = u12:FindFirstChildWhichIsA('Humanoid')

        if _Humanoid3 then
            _Humanoid3.DisplayName = _Name .. 'Celeste'
            u16 = _Humanoid3.HipHeight
            _Humanoid3.WalkSpeed = _Humanoid2.WalkSpeed
            _Humanoid3.JumpPower = _Humanoid2.JumpPower
        end

        local v192 = not u12.PrimaryPart and u12:FindFirstChild('HumanoidRootPart')

        if v192 then
            u12.PrimaryPart = v192
        end

        u163()

        u17 = {}
        u18 = {}

        local v193 = u12
        local v194, v195, v196 = ipairs(v193:GetDescendants())

        while true do
            local v197

            v196, v197 = v194(v195, v196)

            if v196 == nil then
                break
            end
            if v197:IsA('BasePart') then
                u17[v197] = v197.Size
            elseif v197:IsA('Motor6D') then
                u18[v197] = {
                    C0 = v197.C0,
                    C1 = v197.C1,
                }
            end
        end

        local _Animate = u11:FindFirstChild('Animate')

        if _Animate then
            u14 = _Animate:Clone()
            u14.Parent = u12
            u14.Disabled = true
        end

        u147()

        u12.Parent = _Workspace
        _LocalPlayer.Character = u12

        if _Humanoid3 then
            _Workspace.CurrentCamera.CameraSubject = _Humanoid3
        end

        u152()
        task.delay(0.1, function()
            if u10 and u12 then
                if u14 then
                    u14.Disabled = false
                end
                if _Humanoid3 then
                    _Humanoid3:ChangeState(Enum.HumanoidStateType.Running)
                end
            end
        end)
        task.delay(0, function()
            if u10 then
                if _event_rag then
                    pcall(function()
                        local _event_rag2 = game:GetService('ReplicatedStorage'):FindFirstChild('event_rag')

                        if _event_rag2 then
                            local v200 = u11 and (u11:FindFirstChildOfClass('Humanoid') and u11:FindFirstChildOfClass('Humanoid'))

                            if v200 then
                                game.Players.LocalPlayer.Character.Humanoid.HipHeight = v200.HipHeight
                            end

                            _event_rag2:FireServer(unpack({
                                'Hinge',
                            }))
                        end
                    end)
                elseif _Ragdoll then
                    pcall(function()
                        local _Ragdoll2 = game:GetService('ReplicatedStorage'):FindFirstChild('Ragdoll')

                        if _Ragdoll2 then
                            _Ragdoll2:FireServer(unpack({
                                'Ball',
                            }))
                        end
                    end)
                elseif u182 then
                    pcall(function()
                        u182.Ragdoll:Fire(true)
                        u173()
                    end)
                end

                task.delay(0, function()
                    if u10 then
                        if u15 then
                            u15:Disconnect()
                        end

                        u15 = _RunService.Heartbeat:Connect(u170)
                    end
                end)
            end
        end)
    else
        local v202, v203, v204 = pairs(u23)

        while true do
            local v205

            v204, v205 = v202(v203, v204)

            if v204 == nil then
                break
            end
            if v205 then
                v205:Disconnect()
            end
        end

        u23 = {}

        if u15 then
            u15:Disconnect()

            u15 = nil
        end
        if u25.connection then
            u25.connection:Disconnect()

            u25.connection = nil
        end
        if not (u11 and u12) then
            return
        end

        for _ = 1, 3 do
            pcall(function()
                if _event_rag then
                    local _event_rag3 = game:GetService('ReplicatedStorage'):FindFirstChild('event_rag')

                    if _event_rag3 then
                        _event_rag3:FireServer(unpack({
                            'Hinge',
                        }))
                    end
                elseif _Unragdoll then
                    local _Unragdoll2 = game:GetService('ReplicatedStorage'):FindFirstChild('Unragdoll')

                    if _Unragdoll2 then
                        _Unragdoll2:FireServer()
                    end
                elseif u182 then
                    u182.Ragdoll:Fire(false)
                    u176()
                end
            end)
            task.wait(0.1)
        end

        local _HumanoidRootPart4 = u11:FindFirstChild('HumanoidRootPart')
        local _HumanoidRootPart5 = u12:FindFirstChild('HumanoidRootPart')
        local v210 = _HumanoidRootPart5 and _HumanoidRootPart5.CFrame or u13
        local _Animate2 = u12:FindFirstChild('Animate')

        if _Animate2 then
            _Animate2.Parent = u11
            _Animate2.Disabled = true
        end

        u12:Destroy()

        local v212, v213, v214 = pairs(u20)

        while true do
            local v215

            v214, v215 = v212(v213, v214)

            if v214 == nil then
                break
            end
            if v215 then
                v215:Destroy()
            end
        end

        table.clear(u20)

        if _HumanoidRootPart4 then
            _HumanoidRootPart4.CFrame = v210
        end

        local _Humanoid4 = u11:FindFirstChildWhichIsA('Humanoid')

        u147()

        _LocalPlayer.Character = u11

        if _Humanoid4 then
            _Workspace.CurrentCamera.CameraSubject = _Humanoid4
        end

        u152()

        if _Animate2 then
            task.wait(0.1)

            _Animate2.Disabled = false
        end

        u177 = nil
    end
end

local u218 = {}

local function u232()
    u25.isRunning = false

    if u12 then
        local v219, v220, v221 = pairs(u18)

        while true do
            local v222

            v221, v222 = v219(v220, v221)

            if v221 == nil then
                break
            end
            if v221 and v221:IsA('Motor6D') then
                v221.C0 = v222.C0
            end
        end

        local v223 = u12
        local v224, v225, v226 = pairs(v223:GetChildren())

        while true do
            local v227

            v226, v227 = v224(v225, v226)

            if v226 == nil then
                break
            end
            if v227:IsA('LocalScript') and (not v227.Enabled and v227 ~= u14) then
                v227.Enabled = true
            end
        end

        if u14 then
            u14.Disabled = false
        end
    end
    if u25.connection then
        u25.connection:Disconnect()

        u25.connection = nil
    end

    local v228, v229, v230 = pairs(u218)

    while true do
        local v231

        v230, v231 = v228(v229, v230)

        if v230 == nil then
            break
        end

        v231.NameButton.BackgroundColor3 = Color3.new(0, 0, 0)
    end
end
local function u323(p233)
    if not u12 then
        warn('Reanimate first!')

        return
    end
    if p233 == '' then
        return
    end

    local _Humanoid5 = u12:FindFirstChildWhichIsA('Humanoid')

    if not _Humanoid5 then
        return
    end

    local v235 = u12:FindFirstChild('LowerTorso') ~= nil

    if not (v235 and u12:FindFirstChild('LowerTorso') or u12:FindFirstChild('Torso')) then
        return
    end
    if u25.isRunning and u25.currentId == p233 then
        u232()

        u25.currentId = nil

        return
    end

    local v236, v237, v238 = pairs(u218)

    while true do
        local v239

        v238, v239 = v236(v237, v238)

        if v238 == nil then
            break
        end

        v239.NameButton.BackgroundColor3 = Color3.new(0, 0, 0)
    end

    local v240 = {u26, u43}
    local v241, v242, v243 = pairs(v240)
    local v244 = nil

    while true do
        local v245

        v243, v245 = v241(v242, v243)

        if v243 == nil then
            v248 = v244
        end

        local v246, v247, v248 = pairs(v245)

        while true do
            local v249

            v248, v249 = v246(v247, v248)

            if v248 == nil then
                v248 = v244

                break
            end
            if tostring(v249) == p233 then
                break
            end
        end

        if v248 then
            break
        end

        v244 = v248
    end

    if v248 and u218[v248] then
        u218[v248].NameButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end
    if u14 and (_Humanoid5.MoveDirection.Magnitude > 0 or _Humanoid5:GetState() == Enum.HumanoidStateType.Running) then
        u14.Disabled = true

        local v250, v251, v252 = pairs(_Humanoid5:GetPlayingAnimationTracks())

        while true do
            local v253

            v252, v253 = v250(v251, v252)

            if v252 == nil then
                break
            end

            v253:Stop()
        end
    end

    local v254 = u19[p233]

    if not v254 then
        local v255 = nil
        local v256 = nil

        if tostring(p233):match('^http') then
            local v257, u258 = pcall(function()
                return game:HttpGet(p233)
            end)

            if v257 then
                local v259

                v259, v254 = pcall(function()
                    return loadstring(u258)()
                end)

                if v259 and type(v254) == 'table' then
                    v255 = true
                else
                    v254 = v256
                end
            else
                v254 = v256
            end
        elseif tonumber(p233) then
            v255, v254 = pcall(function()
                return game:GetObjects('rbxassetid://' .. p233)[1]
            end)
        else
            local v260

            v260, v254 = pcall(function()
                return loadstring(p233)()
            end)

            if v260 and type(v254) == 'table' then
                v255 = true
            else
                v254 = v256
            end
        end
        if not (v255 and v254) then
            return
        end

        u19[p233] = v254
    end
    if type(v254) ~= 'table' then
        v254.Priority = Enum.AnimationPriority.Action
        u25.keyframes = v254:GetKeyframes()

        if not u25.keyframes or #u25.keyframes == 0 then
            return
        end

        u25.totalDuration = u25.keyframes[#u25.keyframes].Time
    else
        local v261 = next(v254)

        if not v261 then
            return
        end

        u25.keyframes = v254[v261]

        if not u25.keyframes or #u25.keyframes == 0 then
            return
        end

        u25.totalDuration = u25.keyframes[#u25.keyframes].Time
    end

    u25.currentId = p233
    u25.elapsedTime = 0
    u25.isRunning = true

    local v262 = u12
    local v263

    if v235 then
        local _HumanoidRootPart6 = v262:FindFirstChild('HumanoidRootPart')
        local _Head2 = v262:FindFirstChild('Head')
        local _LeftUpperArm = v262:FindFirstChild('LeftUpperArm')
        local _RightUpperArm = v262:FindFirstChild('RightUpperArm')
        local _LeftUpperLeg = v262:FindFirstChild('LeftUpperLeg')
        local _RightUpperLeg = v262:FindFirstChild('RightUpperLeg')
        local _LeftFoot = v262:FindFirstChild('LeftFoot')
        local _RightFoot = v262:FindFirstChild('RightFoot')
        local _LeftHand = v262:FindFirstChild('LeftHand')
        local _RightHand = v262:FindFirstChild('RightHand')
        local _LeftLowerArm = v262:FindFirstChild('LeftLowerArm')
        local _RightLowerArm = v262:FindFirstChild('RightLowerArm')
        local _LeftLowerLeg = v262:FindFirstChild('LeftLowerLeg')
        local _RightLowerLeg = v262:FindFirstChild('RightLowerLeg')
        local _LowerTorso = v262:FindFirstChild('LowerTorso')
        local _UpperTorso = v262:FindFirstChild('UpperTorso')

        v263 = {}

        if _HumanoidRootPart6 then
            _HumanoidRootPart6 = _HumanoidRootPart6:FindFirstChild('RootJoint')
        end

        v263.Torso = _HumanoidRootPart6

        if _Head2 then
            _Head2 = _Head2:FindFirstChild('Neck')
        end

        v263.Head = _Head2

        if _LeftUpperArm then
            _LeftUpperArm = _LeftUpperArm:FindFirstChild('LeftShoulder')
        end

        v263.LeftUpperArm = _LeftUpperArm

        if _RightUpperArm then
            _RightUpperArm = _RightUpperArm:FindFirstChild('RightShoulder')
        end

        v263.RightUpperArm = _RightUpperArm

        if _LeftUpperLeg then
            _LeftUpperLeg = _LeftUpperLeg:FindFirstChild('LeftHip')
        end

        v263.LeftUpperLeg = _LeftUpperLeg

        if _RightUpperLeg then
            _RightUpperLeg = _RightUpperLeg:FindFirstChild('RightHip')
        end

        v263.RightUpperLeg = _RightUpperLeg

        if _LeftFoot then
            _LeftFoot = _LeftFoot:FindFirstChild('LeftAnkle')
        end

        v263.LeftFoot = _LeftFoot

        if _RightFoot then
            _RightFoot = _RightFoot:FindFirstChild('RightAnkle')
        end

        v263.RightFoot = _RightFoot

        if _LeftHand then
            _LeftHand = _LeftHand:FindFirstChild('LeftWrist')
        end

        v263.LeftHand = _LeftHand

        if _RightHand then
            _RightHand = _RightHand:FindFirstChild('RightWrist')
        end

        v263.RightHand = _RightHand

        if _LeftLowerArm then
            _LeftLowerArm = _LeftLowerArm:FindFirstChild('LeftElbow')
        end

        v263.LeftLowerArm = _LeftLowerArm

        if _RightLowerArm then
            _RightLowerArm = _RightLowerArm:FindFirstChild('RightElbow')
        end

        v263.RightLowerArm = _RightLowerArm

        if _LeftLowerLeg then
            _LeftLowerLeg = _LeftLowerLeg:FindFirstChild('LeftKnee')
        end

        v263.LeftLowerLeg = _LeftLowerLeg

        if _RightLowerLeg then
            _RightLowerLeg = _RightLowerLeg:FindFirstChild('RightKnee')
        end

        v263.RightLowerLeg = _RightLowerLeg

        if _LowerTorso then
            _LowerTorso = _LowerTorso:FindFirstChild('Root')
        end

        v263.LowerTorso = _LowerTorso

        if _UpperTorso then
            _UpperTorso = _UpperTorso:FindFirstChild('Waist')
        end

        v263.UpperTorso = _UpperTorso
    else
        v263 = (function(p280)
            local v281, v282, v283 = pairs(p280:GetChildren())
            local v284 = {}

            while true do
                local v285

                v283, v285 = v281(v282, v283)

                if v283 == nil then
                    break
                end
                if v285:IsA('BasePart') then
                    local v286, v287, v288 = pairs(v285:GetChildren())

                    while true do
                        local v289

                        v288, v289 = v286(v287, v288)

                        if v288 == nil then
                            break
                        end
                        if v289:IsA('Motor6D') and (v289.Part1 and v289.Part1.Parent == p280) then
                            local _Name2 = v289.Part1.Name

                            v284[_Name2] = v289

                            if _Name2 == 'Left Arm' then
                                v284.LeftArm = v289
                            elseif _Name2 == 'Right Arm' then
                                v284.RightArm = v289
                            elseif _Name2 == 'Left Leg' then
                                v284.LeftLeg = v289
                            elseif _Name2 == 'Right Leg' then
                                v284.RightLeg = v289
                            elseif _Name2 == 'Head' then
                                v284.Head = v289
                            elseif _Name2 == 'HumanoidRootPart' then
                                v284.Torso = v289
                            end
                        end
                    end
                end
            end

            return v284
        end)(v262)
    end

    local u291 = {}

    if not u18 then
        u18 = {}
    end

    local v292, v293, v294 = pairs(v263)

    while true do
        local v295

        v294, v295 = v292(v293, v294)

        if v294 == nil then
            break
        end
        if v295 and v295:IsA('Motor6D') then
            u291[v294] = v295

            if not u18[v295] then
                u18[v295] = {
                    C0 = v295.C0,
                    C1 = v295.C1,
                }
            end
        end
    end

    if not u25.connection then
        local v296 = u12
        local v297, v298, v299 = pairs(v296:GetChildren())

        while true do
            local v300

            v299, v300 = v297(v298, v299)

            if v299 == nil then
                break
            end
            if v300:IsA('LocalScript') and (v300.Enabled and v300 ~= u14) then
                v300.Enabled = false
            end
        end

        u25.connection = _RunService.Heartbeat:Connect(function(p301)
            if not (u25.isRunning and u12) then
                u232()

                return
            end
            if not u25.keyframes then
                return
            end

            u25.elapsedTime = u25.elapsedTime + p301 * u25.speed

            if u25.totalDuration > 0 then
                u25.elapsedTime = u25.elapsedTime % u25.totalDuration
            end

            local v302 = nil
            local v303 = nil

            for v304 = 1, #u25.keyframes - 1 do
                if u25.elapsedTime >= u25.keyframes[v304].Time then
                    if u25.elapsedTime < u25.keyframes[v304 + 1].Time then
                        v302 = u25.keyframes[v304]
                        v303 = u25.keyframes[v304 + 1]

                        break
                    end
                end
            end

            if not v302 then
                v302 = u25.keyframes[#u25.keyframes]
                v303 = u25.keyframes[1]
            end

            local v305 = v303.Time - v302.Time

            if v305 <= 0 then
                v305 = u25.totalDuration
            end

            local v306 = u25.elapsedTime - v302.Time
            local v307 = 0 < v305 and v306 / v305 or 0
            local v308 = math.clamp(v307, 0, 1)

            if v302.Data then
                local v309, v310, v311 = pairs(v302.Data)

                while true do
                    local v312

                    v311, v312 = v309(v310, v311)

                    if v311 == nil then
                        break
                    end

                    local v313 = u291[v311]

                    if v313 and (u18 and u18[v313]) then
                        local v314 = u18[v313].C0 * v312
                        local _Data = v303.Data

                        if _Data then
                            _Data = v303.Data[v311]
                        end
                        if _Data then
                            v313.C0 = v314:Lerp(u18[v313].C0 * _Data, v308)
                        else
                            v313.C0 = v314
                        end
                    end
                end
            else
                local v316, v317, v318 = pairs(v302:GetDescendants())

                while true do
                    local v319

                    v318, v319 = v316(v317, v318)

                    if v318 == nil then
                        break
                    end
                    if v319:IsA('Pose') then
                        local v320 = u291[v319.Name]

                        if v320 and (u18 and u18[v320]) then
                            local v321 = u18[v320].C0 * v319.CFrame
                            local v322 = v303:FindFirstChild(v319.Name, true)

                            if v322 and v322:IsA('Pose') then
                                v320.C0 = v321:Lerp(u18[v320].C0 * v322.CFrame, v308)
                            else
                                v320.C0 = v321
                            end
                        end
                    end
                end
            end
        end)
    end
end
local function u335(p324)
    if not (u12 and u10) then
        return
    end

    local u325 = u21[p324]

    if u325 and u325 ~= '' then
        if not u12:FindFirstChildWhichIsA('Humanoid') then
            return
        end
        if u25.isRunning and u25.currentId then
            local v326, v327, v328 = pairs(u21)
            local v329 = false

            while true do
                local v330

                v328, v330 = v326(v327, v328)

                if v328 == nil then
                    break
                end
                if v330 and tostring(v330) == tostring(u25.currentId) then
                    v329 = true

                    break
                end
            end

            if not v329 then
                return
            end
            if tostring(u25.currentId) == tostring(u325) then
                return
            end
        end

        pcall(function()
            u323(tostring(u325))
        end)
    elseif u25.isRunning and u25.currentId then
        local v331, v332, v333 = pairs(u21)

        while true do
            local v334

            v333, v334 = v331(v332, v333)

            if v333 == nil then
                break
            end
            if v334 and tostring(v334) == tostring(u25.currentId) then
                u232()

                break
            end
        end
    end
end
local function u352()
    if u12 and u10 then
        if u12:FindFirstChildWhichIsA('Humanoid') then
            local v336, v337, v338 = pairs(u23)

            while true do
                local v339, v340 = v336(v337, v338)

                if v339 == nil then
                    break
                end

                v338 = v339

                if v340 then
                    v340:Disconnect()
                end
            end

            u23 = {}

            local u341 = 'idle'
            local u342 = 0.1
            local u343 = 0
            local u344 = 0
            local u345 = 0.5

            if u21.idle and u21.idle ~= '' then
                task.defer(function()
                    u335('idle')

                    u344 = tick()
                end)
            end

            u23.stateMonitor = _RunService.Heartbeat:Connect(function(p346)
                if u12 and u10 then
                    local _Humanoid6 = u12:FindFirstChildWhichIsA('Humanoid')

                    if _Humanoid6 then
                        u343 = u343 + p346

                        if u343 >= u342 then
                            u343 = 0

                            local _Magnitude = _Humanoid6.MoveDirection.Magnitude
                            local v349 = _Humanoid6:GetState()
                            local v350 = (v349 == Enum.HumanoidStateType.Jumping or v349 == Enum.HumanoidStateType.Freefall) and 'jumping' or (_Magnitude > 0.1 and 'walking' or 'idle')

                            if v350 ~= u341 then
                                local v351 = tick()

                                if u345 <= v351 - u344 then
                                    u341 = v350

                                    if u21[v350] and u21[v350] ~= '' then
                                        u335(v350)

                                        u344 = v351
                                    end
                                end
                            end
                        end
                    else
                        return
                    end
                else
                    if u23.stateMonitor then
                        u23.stateMonitor:Disconnect()

                        u23.stateMonitor = nil
                    end

                    return
                end
            end)
        end
    else
        return
    end
end
local function u571()
    local _PlayerGui2 = _LocalPlayer:WaitForChild('PlayerGui')

    if not _PlayerGui2:FindFirstChild('AKReanimGUI') then
        local _ScreenGui = Instance.new('ScreenGui')

        _ScreenGui.Name = 'AKReanimGUI'
        _ScreenGui.ResetOnSpawn = false
        _ScreenGui.Parent = _PlayerGui2

        local _Frame = Instance.new('Frame')

        _Frame.Size = UDim2.new(0, 280, 0, 395)
        _Frame.Position = UDim2.new(0.5, -140, 0.5, -197.5)
        _Frame.BackgroundColor3 = Color3.new(0, 0, 0)
        _Frame.BackgroundTransparency = 0.6
        _Frame.BorderSizePixel = 0
        _Frame.Parent = _ScreenGui

        local _UICorner = Instance.new('UICorner')

        _UICorner.CornerRadius = UDim.new(0, 15)
        _UICorner.Parent = _Frame

        local _Frame2 = Instance.new('Frame')

        _Frame2.Size = UDim2.new(1, 0, 0, 30)
        _Frame2.Position = UDim2.new(0, 0, 0, 0)
        _Frame2.BackgroundTransparency = 1
        _Frame2.BorderSizePixel = 0
        _Frame2.Parent = _Frame

        local _TextLabel = Instance.new('TextLabel')

        _TextLabel.Size = UDim2.new(1, -100, 1, 0)
        _TextLabel.Position = UDim2.new(0, 50, 0, 0)
        _TextLabel.BackgroundTransparency = 1
        _TextLabel.Text = 'AK REANIMATION'
        _TextLabel.TextColor3 = Color3.new(1, 1, 1)
        _TextLabel.TextSize = 16
        _TextLabel.Font = Enum.Font.Gotham
        _TextLabel.TextXAlignment = Enum.TextXAlignment.Center
        _TextLabel.Parent = _Frame2

        local _Frame3 = Instance.new('Frame')

        _Frame3.Size = UDim2.new(0, 40, 0, 18)
        _Frame3.Position = UDim2.new(0, 6, 0, 6)
        _Frame3.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        _Frame3.BorderSizePixel = 0
        _Frame3.Parent = _Frame2

        local _UICorner2 = Instance.new('UICorner')

        _UICorner2.CornerRadius = UDim.new(0, 9)
        _UICorner2.Parent = _Frame3

        local _Frame4 = Instance.new('Frame')

        _Frame4.Size = UDim2.new(0, 14, 0, 14)
        _Frame4.Position = UDim2.new(0, 2, 0, 2)
        _Frame4.BackgroundColor3 = Color3.new(0.7, 0.7, 0.7)
        _Frame4.BorderSizePixel = 0
        _Frame4.Parent = _Frame3

        local _UICorner3 = Instance.new('UICorner')

        _UICorner3.CornerRadius = UDim.new(0, 7)
        _UICorner3.Parent = _Frame4

        local _TextButton = Instance.new('TextButton')

        _TextButton.Size = UDim2.new(1, 0, 1, 0)
        _TextButton.BackgroundTransparency = 1
        _TextButton.Text = ''
        _TextButton.Parent = _Frame3

        local u364 = false
        local u365 = false
        local u366 = 0

        _TextButton.MouseButton1Click:Connect(function()
            if u365 then
                return
            else
                local v367 = tick()

                if v367 - u366 >= 3 then
                    u365 = true
                    u366 = v367
                    u364 = not u364

                    local v368 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

                    if u364 then
                        _TweenService:Create(_Frame3, v368, {
                            BackgroundColor3 = Color3.fromRGB(0, 150, 255),
                        }):Play()
                        _TweenService:Create(_Frame4, v368, {
                            Position = UDim2.new(1, -16, 0, 2),
                            BackgroundColor3 = Color3.new(1, 1, 1),
                        }):Play()
                    else
                        _TweenService:Create(_Frame3, v368, {
                            BackgroundColor3 = Color3.new(0.2, 0.2, 0.2),
                        }):Play()
                        _TweenService:Create(_Frame4, v368, {
                            Position = UDim2.new(0, 2, 0, 2),
                            BackgroundColor3 = Color3.new(0.7, 0.7, 0.7),
                        }):Play()
                    end

                    u217(u364)
                    spawn(function()
                        wait(3)

                        u365 = false
                    end)
                end
            end
        end)

        local _TextButton2 = Instance.new('TextButton')

        _TextButton2.Size = UDim2.new(0, 22, 0, 22)
        _TextButton2.Position = UDim2.new(1, -48, 0, 4)
        _TextButton2.BackgroundColor3 = Color3.new(0, 0, 0)
        _TextButton2.BackgroundTransparency = 0.7
        _TextButton2.Text = '\u{2212}'
        _TextButton2.TextColor3 = Color3.new(1, 1, 1)
        _TextButton2.TextScaled = true
        _TextButton2.Font = Enum.Font.Gotham
        _TextButton2.BorderSizePixel = 0
        _TextButton2.Parent = _Frame2

        local _UICorner4 = Instance.new('UICorner')

        _UICorner4.CornerRadius = UDim.new(0, 10)
        _UICorner4.Parent = _TextButton2

        local _TextButton3 = Instance.new('TextButton')

        _TextButton3.Size = UDim2.new(0, 22, 0, 22)
        _TextButton3.Position = UDim2.new(1, -24, 0, 4)
        _TextButton3.BackgroundColor3 = Color3.new(0, 0, 0)
        _TextButton3.BackgroundTransparency = 0.7
        _TextButton3.Text = '\u{d7}'
        _TextButton3.TextColor3 = Color3.new(1, 1, 1)
        _TextButton3.TextScaled = true
        _TextButton3.Font = Enum.Font.Gotham
        _TextButton3.BorderSizePixel = 0
        _TextButton3.Parent = _Frame2

        local _UICorner5 = Instance.new('UICorner')

        _UICorner5.CornerRadius = UDim.new(0, 10)
        _UICorner5.Parent = _TextButton3

        local _TextLabel2 = Instance.new('TextLabel')

        _TextLabel2.Size = UDim2.new(1, -16, 0, 12)
        _TextLabel2.Position = UDim2.new(0, 8, 0, 32)
        _TextLabel2.BackgroundTransparency = 1
        _TextLabel2.Text = 'Ready'
        _TextLabel2.TextColor3 = Color3.new(0.7, 0.7, 0.7)
        _TextLabel2.TextSize = 10
        _TextLabel2.Font = Enum.Font.Gotham
        _TextLabel2.Parent = _Frame

        local _Frame5 = Instance.new('Frame')

        _Frame5.Size = UDim2.new(1, -16, 0, 25)
        _Frame5.Position = UDim2.new(0, 8, 0, 48)
        _Frame5.BackgroundTransparency = 1
        _Frame5.Parent = _Frame

        local _TextButton4 = Instance.new('TextButton')

        _TextButton4.Size = UDim2.new(0.25, -3, 1, 0)
        _TextButton4.Position = UDim2.new(0, 0, 0, 0)
        _TextButton4.BackgroundColor3 = Color3.new(0, 0, 0)
        _TextButton4.BackgroundTransparency = 0.5
        _TextButton4.Text = 'All'
        _TextButton4.TextColor3 = Color3.new(1, 1, 1)
        _TextButton4.TextSize = 11
        _TextButton4.Font = Enum.Font.Gotham
        _TextButton4.BorderSizePixel = 0
        _TextButton4.Parent = _Frame5

        local _TextButton5 = Instance.new('TextButton')

        _TextButton5.Size = UDim2.new(0.25, -3, 1, 0)
        _TextButton5.Position = UDim2.new(0.25, 2, 0, 0)
        _TextButton5.BackgroundColor3 = Color3.new(0, 0, 0)
        _TextButton5.BackgroundTransparency = 0.8
        _TextButton5.Text = 'Favs'
        _TextButton5.TextColor3 = Color3.new(1, 1, 1)
        _TextButton5.TextSize = 11
        _TextButton5.Font = Enum.Font.Gotham
        _TextButton5.BorderSizePixel = 0
        _TextButton5.Parent = _Frame5

        local _TextButton6 = Instance.new('TextButton')

        _TextButton6.Size = UDim2.new(0.25, -3, 1, 0)
        _TextButton6.Position = UDim2.new(0.5, 4, 0, 0)
        _TextButton6.BackgroundColor3 = Color3.new(0, 0, 0)
        _TextButton6.BackgroundTransparency = 0.8
        _TextButton6.Text = 'Custom'
        _TextButton6.TextColor3 = Color3.new(1, 1, 1)
        _TextButton6.TextSize = 11
        _TextButton6.Font = Enum.Font.Gotham
        _TextButton6.BorderSizePixel = 0
        _TextButton6.Parent = _Frame5

        local _TextButton7 = Instance.new('TextButton')

        _TextButton7.Size = UDim2.new(0.25, -3, 1, 0)
        _TextButton7.Position = UDim2.new(0.75, 6, 0, 0)
        _TextButton7.BackgroundColor3 = Color3.new(0, 0, 0)
        _TextButton7.BackgroundTransparency = 0.8
        _TextButton7.Text = 'States'
        _TextButton7.TextColor3 = Color3.new(1, 1, 1)
        _TextButton7.TextSize = 11
        _TextButton7.Font = Enum.Font.Gotham
        _TextButton7.BorderSizePixel = 0
        _TextButton7.Parent = _Frame5

        local _UICorner6 = Instance.new('UICorner')

        _UICorner6.CornerRadius = UDim.new(0, 10)
        _UICorner6.Parent = _TextButton4

        local _UICorner7 = Instance.new('UICorner')

        _UICorner7.CornerRadius = UDim.new(0, 10)
        _UICorner7.Parent = _TextButton5

        local _UICorner8 = Instance.new('UICorner')

        _UICorner8.CornerRadius = UDim.new(0, 10)
        _UICorner8.Parent = _TextButton6

        local _UICorner9 = Instance.new('UICorner')

        _UICorner9.CornerRadius = UDim.new(0, 10)
        _UICorner9.Parent = _TextButton7

        local _TextBox = Instance.new('TextBox')

        _TextBox.Size = UDim2.new(1, -16, 0, 22)
        _TextBox.Position = UDim2.new(0, 8, 0, 78)
        _TextBox.BackgroundColor3 = Color3.new(0, 0, 0)
        _TextBox.BackgroundTransparency = 0.5
        _TextBox.Text = ''
        _TextBox.PlaceholderText = 'Search...'
        _TextBox.TextColor3 = Color3.new(1, 1, 1)
        _TextBox.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
        _TextBox.TextSize = 11
        _TextBox.Font = Enum.Font.Gotham
        _TextBox.BorderSizePixel = 0
        _TextBox.Parent = _Frame

        local _UICorner10 = Instance.new('UICorner')

        _UICorner10.CornerRadius = UDim.new(0, 10)
        _UICorner10.Parent = _TextBox

        local _ScrollingFrame = Instance.new('ScrollingFrame')

        _ScrollingFrame.Size = UDim2.new(1, -16, 1, -175)
        _ScrollingFrame.Position = UDim2.new(0, 8, 0, 105)
        _ScrollingFrame.BackgroundTransparency = 1
        _ScrollingFrame.ScrollBarThickness = 4
        _ScrollingFrame.ScrollBarImageColor3 = Color3.new(1, 1, 1)
        _ScrollingFrame.ScrollBarImageTransparency = 0.5
        _ScrollingFrame.BorderSizePixel = 0
        _ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
        _ScrollingFrame.Parent = _Frame

        local _UIListLayout = Instance.new('UIListLayout')

        _UIListLayout.Padding = UDim.new(0, 3)
        _UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        _UIListLayout.Parent = _ScrollingFrame

        local _Frame6 = Instance.new('Frame')

        _Frame6.Size = UDim2.new(1, -16, 0, 80)
        _Frame6.Position = UDim2.new(0, 8, 0, 105)
        _Frame6.BackgroundTransparency = 1
        _Frame6.Visible = false
        _Frame6.Parent = _Frame

        local _TextBox2 = Instance.new('TextBox')

        _TextBox2.Size = UDim2.new(1, 0, 0, 22)
        _TextBox2.Position = UDim2.new(0, 0, 0, 0)
        _TextBox2.BackgroundColor3 = Color3.new(0, 0, 0)
        _TextBox2.BackgroundTransparency = 0.5
        _TextBox2.Text = ''
        _TextBox2.PlaceholderText = 'Animation Name...'
        _TextBox2.TextColor3 = Color3.new(1, 1, 1)
        _TextBox2.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
        _TextBox2.TextSize = 11
        _TextBox2.Font = Enum.Font.Gotham
        _TextBox2.BorderSizePixel = 0
        _TextBox2.Parent = _Frame6

        local _UICorner11 = Instance.new('UICorner')

        _UICorner11.CornerRadius = UDim.new(0, 10)
        _UICorner11.Parent = _TextBox2

        local _TextBox3 = Instance.new('TextBox')

        _TextBox3.Size = UDim2.new(1, 0, 0, 45)
        _TextBox3.Position = UDim2.new(0, 0, 0, 27)
        _TextBox3.BackgroundColor3 = Color3.new(0, 0, 0)
        _TextBox3.BackgroundTransparency = 0.5
        _TextBox3.Text = ''
        _TextBox3.PlaceholderText = 'Keyframe Code...'
        _TextBox3.TextColor3 = Color3.new(1, 1, 1)
        _TextBox3.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
        _TextBox3.TextSize = 9
        _TextBox3.Font = Enum.Font.Code
        _TextBox3.TextWrapped = true
        _TextBox3.TextXAlignment = Enum.TextXAlignment.Left
        _TextBox3.TextYAlignment = Enum.TextYAlignment.Top
        _TextBox3.ClearTextOnFocus = false
        _TextBox3.MultiLine = true
        _TextBox3.BorderSizePixel = 0
        _TextBox3.Parent = _Frame6

        local _UICorner12 = Instance.new('UICorner')

        _UICorner12.CornerRadius = UDim.new(0, 10)
        _UICorner12.Parent = _TextBox3

        local _Frame7 = Instance.new('Frame')

        _Frame7.Size = UDim2.new(1, -16, 1, -175)
        _Frame7.Position = UDim2.new(0, 8, 0, 105)
        _Frame7.BackgroundTransparency = 1
        _Frame7.Visible = false
        _Frame7.Parent = _Frame

        local _ScrollingFrame2 = Instance.new('ScrollingFrame')

        _ScrollingFrame2.Size = UDim2.new(1, 0, 1, 0)
        _ScrollingFrame2.Position = UDim2.new(0, 0, 0, 0)
        _ScrollingFrame2.BackgroundTransparency = 1
        _ScrollingFrame2.ScrollBarThickness = 4
        _ScrollingFrame2.ScrollBarImageColor3 = Color3.new(1, 1, 1)
        _ScrollingFrame2.ScrollBarImageTransparency = 0.5
        _ScrollingFrame2.BorderSizePixel = 0
        _ScrollingFrame2.Parent = _Frame7

        local _UIListLayout2 = Instance.new('UIListLayout')

        _UIListLayout2.Padding = UDim.new(0, 10)
        _UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
        _UIListLayout2.Parent = _ScrollingFrame2

        local function v440(p395, p396, p397)
            local _Frame8 = Instance.new('Frame')

            _Frame8.Size = UDim2.new(1, 0, 0, 110)
            _Frame8.BackgroundColor3 = Color3.new(0, 0, 0)
            _Frame8.BackgroundTransparency = 0.7
            _Frame8.BorderSizePixel = 0
            _Frame8.LayoutOrder = p397
            _Frame8.Parent = _ScrollingFrame2

            local _UICorner13 = Instance.new('UICorner')

            _UICorner13.CornerRadius = UDim.new(0, 10)
            _UICorner13.Parent = _Frame8

            local _TextLabel3 = Instance.new('TextLabel')

            _TextLabel3.Size = UDim2.new(1, -10, 0, 20)
            _TextLabel3.Position = UDim2.new(0, 5, 0, 5)
            _TextLabel3.BackgroundTransparency = 1
            _TextLabel3.Text = p396
            _TextLabel3.TextColor3 = Color3.new(1, 1, 1)
            _TextLabel3.TextSize = 12
            _TextLabel3.Font = Enum.Font.GothamBold
            _TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
            _TextLabel3.Parent = _Frame8

            local _TextButton8 = Instance.new('TextButton')

            _TextButton8.Size = UDim2.new(1, -10, 0, 25)
            _TextButton8.Position = UDim2.new(0, 5, 0, 30)
            _TextButton8.BackgroundColor3 = Color3.new(0, 0, 0)
            _TextButton8.BackgroundTransparency = 0.5
            _TextButton8.Text = u21[p395] and 'Animation Selected' or 'Select Animation...'
            _TextButton8.TextColor3 = Color3.new(1, 1, 1)
            _TextButton8.TextSize = 10
            _TextButton8.Font = Enum.Font.Gotham
            _TextButton8.TextXAlignment = Enum.TextXAlignment.Left
            _TextButton8.BorderSizePixel = 0
            _TextButton8.Parent = _Frame8

            local _UICorner14 = Instance.new('UICorner')

            _UICorner14.CornerRadius = UDim.new(0, 8)
            _UICorner14.Parent = _TextButton8

            local _UIPadding = Instance.new('UIPadding')

            _UIPadding.PaddingLeft = UDim.new(0, 8)
            _UIPadding.Parent = _TextButton8

            local _TextBox4 = Instance.new('TextBox')

            _TextBox4.Size = UDim2.new(1, -10, 0, 40)
            _TextBox4.Position = UDim2.new(0, 5, 0, 60)
            _TextBox4.BackgroundColor3 = Color3.new(0, 0, 0)
            _TextBox4.BackgroundTransparency = 0.5
            _TextBox4.Text = ''
            _TextBox4.PlaceholderText = 'Or paste keyframe code...'
            _TextBox4.TextColor3 = Color3.new(1, 1, 1)
            _TextBox4.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
            _TextBox4.TextSize = 9
            _TextBox4.Font = Enum.Font.Code
            _TextBox4.TextWrapped = true
            _TextBox4.TextXAlignment = Enum.TextXAlignment.Left
            _TextBox4.TextYAlignment = Enum.TextYAlignment.Top
            _TextBox4.ClearTextOnFocus = false
            _TextBox4.MultiLine = true
            _TextBox4.BorderSizePixel = 0
            _TextBox4.Parent = _Frame8

            local _UICorner15 = Instance.new('UICorner')

            _UICorner15.CornerRadius = UDim.new(0, 8)
            _UICorner15.Parent = _TextBox4

            local u406 = false
            local u407 = nil

            _TextButton8.MouseButton1Click:Connect(function()
                if u406 then
                    if u407 then
                        u407:Destroy()
                    end

                    u406 = false
                else
                    u406 = true
                    u407 = Instance.new('Frame')
                    u407.Size = UDim2.new(1, 0, 0, 180)
                    u407.Position = UDim2.new(0, 0, 1, 2)
                    u407.BackgroundColor3 = Color3.new(0, 0, 0)
                    u407.BackgroundTransparency = 0.3
                    u407.BorderSizePixel = 0
                    u407.ZIndex = 10
                    u407.Parent = _TextButton8

                    local _UICorner16 = Instance.new('UICorner')

                    _UICorner16.CornerRadius = UDim.new(0, 8)
                    _UICorner16.Parent = u407

                    local _TextBox5 = Instance.new('TextBox')

                    _TextBox5.Size = UDim2.new(1, -8, 0, 22)
                    _TextBox5.Position = UDim2.new(0, 4, 0, 4)
                    _TextBox5.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
                    _TextBox5.BackgroundTransparency = 0.3
                    _TextBox5.Text = ''
                    _TextBox5.PlaceholderText = 'Search...'
                    _TextBox5.TextColor3 = Color3.new(1, 1, 1)
                    _TextBox5.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
                    _TextBox5.TextSize = 10
                    _TextBox5.Font = Enum.Font.Gotham
                    _TextBox5.BorderSizePixel = 0
                    _TextBox5.ZIndex = 10
                    _TextBox5.ClearTextOnFocus = false
                    _TextBox5.Parent = u407

                    local _UICorner17 = Instance.new('UICorner')

                    _UICorner17.CornerRadius = UDim.new(0, 6)
                    _UICorner17.Parent = _TextBox5

                    local _ScrollingFrame3 = Instance.new('ScrollingFrame')

                    _ScrollingFrame3.Size = UDim2.new(1, -4, 1, -30)
                    _ScrollingFrame3.Position = UDim2.new(0, 2, 0, 28)
                    _ScrollingFrame3.BackgroundTransparency = 1
                    _ScrollingFrame3.ScrollBarThickness = 3
                    _ScrollingFrame3.ScrollBarImageColor3 = Color3.new(1, 1, 1)
                    _ScrollingFrame3.ScrollBarImageTransparency = 0.5
                    _ScrollingFrame3.BorderSizePixel = 0
                    _ScrollingFrame3.ZIndex = 10
                    _ScrollingFrame3.Parent = u407

                    local _UIListLayout3 = Instance.new('UIListLayout')

                    _UIListLayout3.Padding = UDim.new(0, 2)
                    _UIListLayout3.SortOrder = Enum.SortOrder.Name
                    _UIListLayout3.Parent = _ScrollingFrame3

                    local u413 = {}

                    local function u434()
                        local v414, v415, v416 = pairs(u413)

                        while true do
                            local v417

                            v416, v417 = v414(v415, v416)

                            if v416 == nil then
                                break
                            end

                            v417:Destroy()
                        end

                        u413 = {}

                        local v418 = _TextBox5.Text:lower()
                        local _TextButton9 = Instance.new('TextButton')

                        _TextButton9.Size = UDim2.new(1, 0, 0, 22)
                        _TextButton9.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
                        _TextButton9.BackgroundTransparency = 0.3
                        _TextButton9.Text = 'None'
                        _TextButton9.TextColor3 = Color3.new(1, 0.5, 0.5)
                        _TextButton9.TextSize = 10
                        _TextButton9.Font = Enum.Font.Gotham
                        _TextButton9.BorderSizePixel = 0
                        _TextButton9.ZIndex = 10
                        _TextButton9.Parent = _ScrollingFrame3

                        table.insert(u413, _TextButton9)
                        _TextButton9.MouseButton1Click:Connect(function()
                            u21[p395] = nil

                            u98()

                            _TextButton8.Text = 'Select Animation...'
                            _TextBox4.Text = ''

                            if u407 then
                                u407:Destroy()
                            end

                            u406 = false
                            _TextLabel2.Text = p396 .. ' cleared'
                            _TextLabel2.TextColor3 = Color3.new(1, 0.7, 0.3)

                            spawn(function()
                                wait(2)

                                _TextLabel2.Text = 'Ready'
                                _TextLabel2.TextColor3 = Color3.new(0.7, 0.7, 0.7)
                            end)

                            if u10 and u25.isRunning then
                                u232()
                            end
                            if u10 then
                                local v420, v421, v422 = pairs(u23)

                                while true do
                                    local v423

                                    v422, v423 = v420(v421, v422)

                                    if v422 == nil then
                                        break
                                    end
                                    if v423 then
                                        v423:Disconnect()
                                    end
                                end

                                u23 = {}

                                u352()
                            end
                        end)

                        local v424, v425, v426 = pairs(u26)

                        while true do
                            local u427, u428 = v424(v425, v426)

                            if u427 == nil then
                                break
                            end

                            v426 = u427

                            if v418 == '' or u427:lower():find(v418, 1, true) then
                                local _TextButton10 = Instance.new('TextButton')

                                _TextButton10.Size = UDim2.new(1, 0, 0, 22)
                                _TextButton10.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
                                _TextButton10.BackgroundTransparency = 0.3
                                _TextButton10.Text = ' ' .. u427
                                _TextButton10.TextColor3 = Color3.new(1, 1, 1)
                                _TextButton10.TextSize = 10
                                _TextButton10.Font = Enum.Font.Gotham
                                _TextButton10.TextXAlignment = Enum.TextXAlignment.Left
                                _TextButton10.BorderSizePixel = 0
                                _TextButton10.ZIndex = 10
                                _TextButton10.Parent = _ScrollingFrame3

                                table.insert(u413, _TextButton10)
                                _TextButton10.MouseButton1Click:Connect(function()
                                    u21[p395] = tostring(u428)

                                    u98()

                                    _TextButton8.Text = u427
                                    _TextBox4.Text = ''

                                    if u407 then
                                        u407:Destroy()
                                    end

                                    u406 = false
                                    _TextLabel2.Text = p396 .. ' set to ' .. u427
                                    _TextLabel2.TextColor3 = Color3.new(0.5, 1, 0.5)

                                    spawn(function()
                                        wait(2)

                                        _TextLabel2.Text = 'Ready'
                                        _TextLabel2.TextColor3 = Color3.new(0.7, 0.7, 0.7)
                                    end)

                                    if u10 then
                                        local v430, v431, v432 = pairs(u23)

                                        while true do
                                            local v433

                                            v432, v433 = v430(v431, v432)

                                            if v432 == nil then
                                                break
                                            end
                                            if v433 then
                                                v433:Disconnect()
                                            end
                                        end

                                        u23 = {}

                                        u352()
                                    end
                                end)
                            end
                        end

                        spawn(function()
                            wait(0.1)

                            _ScrollingFrame3.CanvasSize = UDim2.new(0, 0, 0, _UIListLayout3.AbsoluteContentSize.Y)
                        end)
                    end

                    u434()

                    local v435 = _TextBox5

                    _TextBox5.GetPropertyChangedSignal(v435, 'Text'):Connect(function()
                        u434()
                    end)
                end
            end)
            _TextBox4.FocusLost:Connect(function(_)
                if _TextBox4.Text ~= '' then
                    u21[p395] = _TextBox4.Text

                    u98()

                    _TextButton8.Text = 'Custom Keyframes'
                    _TextLabel2.Text = p396 .. ' set to custom keyframes'
                    _TextLabel2.TextColor3 = Color3.new(0.5, 1, 0.5)

                    spawn(function()
                        wait(2)

                        _TextLabel2.Text = 'Ready'
                        _TextLabel2.TextColor3 = Color3.new(0.7, 0.7, 0.7)
                    end)

                    if u10 then
                        local v436, v437, v438 = pairs(u23)

                        while true do
                            local v439

                            v438, v439 = v436(v437, v438)

                            if v438 == nil then
                                break
                            end
                            if v439 then
                                v439:Disconnect()
                            end
                        end

                        u23 = {}

                        u352()
                    end
                end
            end)
        end

        v440('idle', 'IDLE Animation', 1)
        v440('walking', 'WALKING Animation', 2)
        v440('jumping', 'JUMPING Animation', 3)
        spawn(function()
            wait(0.1)

            _ScrollingFrame2.CanvasSize = UDim2.new(0, 0, 0, _UIListLayout2.AbsoluteContentSize.Y + 10)
        end)

        local _TextButton11 = Instance.new('TextButton')

        _TextButton11.Size = UDim2.new(0, 60, 0, 18)
        _TextButton11.Position = UDim2.new(1, -62, 0, 77)
        _TextButton11.BackgroundColor3 = Color3.new(0, 0, 0)
        _TextButton11.BackgroundTransparency = 0.5
        _TextButton11.Text = 'Add'
        _TextButton11.TextColor3 = Color3.new(1, 1, 1)
        _TextButton11.TextSize = 10
        _TextButton11.Font = Enum.Font.Gotham
        _TextButton11.BorderSizePixel = 0
        _TextButton11.Parent = _Frame6

        local _UICorner18 = Instance.new('UICorner')

        _UICorner18.CornerRadius = UDim.new(0, 9)
        _UICorner18.Parent = _TextButton11

        local u443 = 'all'
        local u444 = false
        local u445 = false
        local u446 = false
        local u447 = nil

        Instance.new('TextButton')

        local _TextButton12 = Instance.new('TextButton')

        _TextButton12.Size = UDim2.new(0, 25, 0, 25)
        _TextButton12.Position = UDim2.new(1, -33, 1, -33)
        _TextButton12.BackgroundColor3 = Color3.new(0, 0, 0)
        _TextButton12.BackgroundTransparency = 0.5
        _TextButton12.Text = 'i'
        _TextButton12.TextColor3 = Color3.new(1, 1, 1)
        _TextButton12.TextSize = 14
        _TextButton12.Font = Enum.Font.GothamBold
        _TextButton12.BorderSizePixel = 0
        _TextButton12.ZIndex = 10
        _TextButton12.Visible = false
        _TextButton12.Parent = _Frame

        task.defer(function()
            _TextButton12.Visible = u443 == 'custom' or u443 == 'states'
        end)

        local _UICorner19 = Instance.new('UICorner')

        _UICorner19.CornerRadius = UDim.new(1, 0)
        _UICorner19.Parent = _TextButton12

        _TextButton12.MouseEnter:Connect(function()
            _TextButton12.BackgroundTransparency = 0.3
        end)
        _TextButton12.MouseLeave:Connect(function()
            _TextButton12.BackgroundTransparency = 0.5
        end)

        local u450 = nil

        local function u462()
            if u450 then
                u450:Destroy()
            end

            u450 = Instance.new('Frame')
            u450.Size = UDim2.new(0, 380, 0, 300)
            u450.Position = UDim2.new(0.5, -190, 0.5, -150)
            u450.BackgroundColor3 = Color3.new(0, 0, 0)
            u450.BackgroundTransparency = 0.6
            u450.BorderSizePixel = 0
            u450.ZIndex = 100
            u450.Parent = _ScreenGui

            local _UICorner20 = Instance.new('UICorner')

            _UICorner20.CornerRadius = UDim.new(0, 15)
            _UICorner20.Parent = u450

            local _TextLabel4 = Instance.new('TextLabel')

            _TextLabel4.Size = UDim2.new(1, -40, 0, 30)
            _TextLabel4.Position = UDim2.new(0, 10, 0, 5)
            _TextLabel4.BackgroundTransparency = 1
            _TextLabel4.Text = 'How to Convert Animations'
            _TextLabel4.TextColor3 = Color3.new(1, 1, 1)
            _TextLabel4.TextSize = 14
            _TextLabel4.Font = Enum.Font.GothamBold
            _TextLabel4.TextXAlignment = Enum.TextXAlignment.Left
            _TextLabel4.ZIndex = 101
            _TextLabel4.Parent = u450

            local _TextButton13 = Instance.new('TextButton')

            _TextButton13.Size = UDim2.new(0, 25, 0, 25)
            _TextButton13.Position = UDim2.new(1, -30, 0, 5)
            _TextButton13.BackgroundColor3 = Color3.new(0, 0, 0)
            _TextButton13.BackgroundTransparency = 0.7
            _TextButton13.Text = '\u{d7}'
            _TextButton13.TextColor3 = Color3.new(1, 1, 1)
            _TextButton13.TextSize = 18
            _TextButton13.Font = Enum.Font.Gotham
            _TextButton13.BorderSizePixel = 0
            _TextButton13.ZIndex = 101
            _TextButton13.Parent = u450

            local _UICorner21 = Instance.new('UICorner')

            _UICorner21.CornerRadius = UDim.new(0, 10)
            _UICorner21.Parent = _TextButton13

            _TextButton13.MouseButton1Click:Connect(function()
                u450:Destroy()

                u450 = nil
            end)

            local _TextLabel5 = Instance.new('TextLabel')

            _TextLabel5.Size = UDim2.new(1, -20, 0, 150)
            _TextLabel5.Position = UDim2.new(0, 10, 0, 40)
            _TextLabel5.BackgroundTransparency = 1
            _TextLabel5.Text = [[1. Open Roblox Studio and create a new game

2. Create a Folder in Workspace named "Keyframes"

3. Put all your KeyframeSequences in the folder
   (Each animation should be named differently)

4. Publish your game to Roblox

5. Join the published game with your executor

6. Execute the converter script below:]]
            _TextLabel5.TextColor3 = Color3.new(1, 1, 1)
            _TextLabel5.TextSize = 11
            _TextLabel5.Font = Enum.Font.Gotham
            _TextLabel5.TextXAlignment = Enum.TextXAlignment.Left
            _TextLabel5.TextYAlignment = Enum.TextYAlignment.Top
            _TextLabel5.TextWrapped = true
            _TextLabel5.ZIndex = 101
            _TextLabel5.Parent = u450

            local _Frame9 = Instance.new('Frame')

            _Frame9.Size = UDim2.new(1, -20, 0, 50)
            _Frame9.Position = UDim2.new(0, 10, 0, 195)
            _Frame9.BackgroundColor3 = Color3.new(0, 0, 0)
            _Frame9.BackgroundTransparency = 0.5
            _Frame9.BorderSizePixel = 0
            _Frame9.ZIndex = 101
            _Frame9.Parent = u450

            local _UICorner22 = Instance.new('UICorner')

            _UICorner22.CornerRadius = UDim.new(0, 10)
            _UICorner22.Parent = _Frame9

            local _TextBox6 = Instance.new('TextBox')

            _TextBox6.Size = UDim2.new(1, -10, 1, -10)
            _TextBox6.Position = UDim2.new(0, 10, 0, 5)
            _TextBox6.BackgroundTransparency = 1
            _TextBox6.Text = 'loadstring(game:HttpGet("https://yourscoper.pages.dev/scripts/reanimation/conversion.lua"))()'
            _TextBox6.TextColor3 = Color3.new(0.8, 1, 0.8)
            _TextBox6.TextSize = 10
            _TextBox6.Font = Enum.Font.Code
            _TextBox6.TextWrapped = true
            _TextBox6.TextEditable = false
            _TextBox6.TextXAlignment = Enum.TextXAlignment.Left
            _TextBox6.TextYAlignment = Enum.TextYAlignment.Center
            _TextBox6.ClearTextOnFocus = false
            _TextBox6.ZIndex = 102
            _TextBox6.Parent = _Frame9

            local _TextButton14 = Instance.new('TextButton')

            _TextButton14.Size = UDim2.new(0, 60, 0, 25)
            _TextButton14.Position = UDim2.new(0.5, -30, 1, 15)
            _TextButton14.BackgroundColor3 = Color3.new(0, 0, 0)
            _TextButton14.BackgroundTransparency = 0.3
            _TextButton14.Text = 'Copy'
            _TextButton14.TextColor3 = Color3.new(1, 1, 1)
            _TextButton14.TextSize = 11
            _TextButton14.Font = Enum.Font.Gotham
            _TextButton14.BorderSizePixel = 0
            _TextButton14.ZIndex = 102
            _TextButton14.Parent = _Frame9

            local _UICorner23 = Instance.new('UICorner')

            _UICorner23.CornerRadius = UDim.new(0, 8)
            _UICorner23.Parent = _TextButton14

            _TextButton14.MouseEnter:Connect(function()
                _TextButton14.BackgroundTransparency = 0.1
            end)
            _TextButton14.MouseLeave:Connect(function()
                _TextButton14.BackgroundTransparency = 0.3
            end)
            _TextButton14.MouseButton1Click:Connect(function()
                setclipboard(_TextBox6.Text)

                _TextButton14.Text = 'Copied!'

                spawn(function()
                    wait(1.5)

                    _TextButton14.Text = 'Copy'
                end)
            end)

            local _TextLabel6 = Instance.new('TextLabel')

            _TextLabel6.Size = UDim2.new(1, -20, 0, 25)
            _TextLabel6.Position = UDim2.new(0, 10, 0, 240)
            _TextLabel6.BackgroundTransparency = 1
            _TextLabel6.Text = "After converting, find keyframe codes in your executor's workspace folder"
            _TextLabel6.TextColor3 = Color3.new(0.8, 0.8, 0.8)
            _TextLabel6.TextSize = 9
            _TextLabel6.Font = Enum.Font.Gotham
            _TextLabel6.TextWrapped = true
            _TextLabel6.TextXAlignment = Enum.TextXAlignment.Center
            _TextLabel6.ZIndex = 101
            _TextLabel6.Parent = u450
        end

        _TextButton12.MouseButton1Click:Connect(function()
            u462()
        end)

        local function u463()
            if u443 == 'custom' or u443 == 'states' then
                _TextButton12.Visible = true
            else
                _TextButton12.Visible = false
            end
        end

        local _Frame10 = Instance.new('Frame')

        _Frame10.Size = UDim2.new(1, -16, 0, 60)
        _Frame10.Position = UDim2.new(0, 8, 1, -65)
        _Frame10.BackgroundTransparency = 1
        _Frame10.Parent = _Frame

        local _TextLabel7 = Instance.new('TextLabel')

        _TextLabel7.Size = UDim2.new(0, 40, 0, 20)
        _TextLabel7.Position = UDim2.new(0, 0, 0, 0)
        _TextLabel7.BackgroundTransparency = 1
        _TextLabel7.Text = 'Speed:'
        _TextLabel7.TextColor3 = Color3.new(1, 1, 1)
        _TextLabel7.TextSize = 10
        _TextLabel7.Font = Enum.Font.Gotham
        _TextLabel7.TextXAlignment = Enum.TextXAlignment.Left
        _TextLabel7.Parent = _Frame10

        local _Frame11 = Instance.new('Frame')

        _Frame11.Size = UDim2.new(1, -130, 0, 4)
        _Frame11.Position = UDim2.new(0, 45, 0, 10)
        _Frame11.BackgroundColor3 = Color3.new(0, 0, 0)
        _Frame11.BackgroundTransparency = 0.5
        _Frame11.BorderSizePixel = 0
        _Frame11.Parent = _Frame10

        local _UICorner24 = Instance.new('UICorner')

        _UICorner24.CornerRadius = UDim.new(0, 2)
        _UICorner24.Parent = _Frame11

        local _Frame12 = Instance.new('Frame')

        _Frame12.Size = UDim2.new(0, 12, 0, 12)
        _Frame12.Position = UDim2.new(0.5, -6, 0.5, -6)
        _Frame12.BackgroundColor3 = Color3.new(1, 1, 1)
        _Frame12.BackgroundTransparency = 0.2
        _Frame12.BorderSizePixel = 0
        _Frame12.Parent = _Frame11

        local _UICorner25 = Instance.new('UICorner')

        _UICorner25.CornerRadius = UDim.new(0, 6)
        _UICorner25.Parent = _Frame12

        local _Frame13 = Instance.new('Frame')

        _Frame13.Size = UDim2.new(0, 3, 0, 20)
        _Frame13.Position = UDim2.new(u48.SlowMarker.ratio, -1.5, 0, 0)
        _Frame13.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
        _Frame13.BackgroundTransparency = 0.5
        _Frame13.BorderSizePixel = 0
        _Frame13.Parent = _Frame11

        local _UICorner26 = Instance.new('UICorner')

        _UICorner26.CornerRadius = UDim.new(1, 0)
        _UICorner26.Parent = _Frame13

        local _TextButton15 = Instance.new('TextButton')

        _TextButton15.Size = UDim2.new(0, 30, 0, 16)
        _TextButton15.Position = UDim2.new(0, -15, 1, 10)
        _TextButton15.BackgroundColor3 = Color3.new(0, 0, 0)
        _TextButton15.BackgroundTransparency = 0.5
        _TextButton15.Text = u48.SlowMarker.key == '' and 'Key' or (u48.SlowMarker.key:sub(1, 3) or 'Key')
        _TextButton15.TextColor3 = Color3.new(1, 1, 1)
        _TextButton15.TextSize = 8
        _TextButton15.Font = Enum.Font.Gotham
        _TextButton15.BorderSizePixel = 0
        _TextButton15.Parent = _Frame13

        local _UICorner27 = Instance.new('UICorner')

        _UICorner27.CornerRadius = UDim.new(0, 6)
        _UICorner27.Parent = _TextButton15

        local _Frame14 = Instance.new('Frame')

        _Frame14.Size = UDim2.new(0, 3, 0, 20)
        _Frame14.Position = UDim2.new(u48.FastMarker.ratio, -1.5, 0, 0)
        _Frame14.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
        _Frame14.BackgroundTransparency = 0.5
        _Frame14.BorderSizePixel = 0
        _Frame14.Parent = _Frame11

        local _UICorner28 = Instance.new('UICorner')

        _UICorner28.CornerRadius = UDim.new(1, 0)
        _UICorner28.Parent = _Frame14

        local _TextButton16 = Instance.new('TextButton')

        _TextButton16.Size = UDim2.new(0, 30, 0, 16)
        _TextButton16.Position = UDim2.new(0, -15, 1, 10)
        _TextButton16.BackgroundColor3 = Color3.new(0, 0, 0)
        _TextButton16.BackgroundTransparency = 0.5
        _TextButton16.Text = u48.FastMarker.key == '' and 'Key' or (u48.FastMarker.key:sub(1, 3) or 'Key')
        _TextButton16.TextColor3 = Color3.new(1, 1, 1)
        _TextButton16.TextSize = 8
        _TextButton16.Font = Enum.Font.Gotham
        _TextButton16.BorderSizePixel = 0
        _TextButton16.Parent = _Frame14

        local _UICorner29 = Instance.new('UICorner')

        _UICorner29.CornerRadius = UDim.new(0, 6)
        _UICorner29.Parent = _TextButton16

        local _TextLabel8 = Instance.new('TextLabel')

        _TextLabel8.Size = UDim2.new(0, 35, 0, 20)
        _TextLabel8.Position = UDim2.new(1, -70, 0, 0)
        _TextLabel8.BackgroundTransparency = 1
        _TextLabel8.Text = '1.0x'
        _TextLabel8.TextColor3 = Color3.new(1, 1, 1)
        _TextLabel8.TextSize = 10
        _TextLabel8.Font = Enum.Font.Gotham
        _TextLabel8.TextXAlignment = Enum.TextXAlignment.Right
        _TextLabel8.Parent = _Frame10

        local _TextButton17 = Instance.new('TextButton')

        _TextButton17.Size = UDim2.new(0, 30, 0, 16)
        _TextButton17.Position = UDim2.new(1, -30, 0, 2)
        _TextButton17.BackgroundColor3 = Color3.new(0, 0, 0)
        _TextButton17.BackgroundTransparency = 0.5
        _TextButton17.Text = 'Reset'
        _TextButton17.TextColor3 = Color3.new(1, 1, 1)
        _TextButton17.TextSize = 8
        _TextButton17.Font = Enum.Font.Gotham
        _TextButton17.BorderSizePixel = 0
        _TextButton17.Parent = _Frame10

        local _UICorner30 = Instance.new('UICorner')

        _UICorner30.CornerRadius = UDim.new(0, 8)
        _UICorner30.Parent = _TextButton17

        local u481 = {
            _TextLabel2,
            _Frame5,
            _TextBox,
            _ScrollingFrame,
            _Frame10,
            _Frame6,
            _Frame7,
            _TextButton12,
        }

        local function u494(p482)
            local _Frame15 = Instance.new('Frame')

            _Frame15.Size = UDim2.new(1, 0, 0, 35)
            _Frame15.BackgroundTransparency = 1
            _Frame15.Parent = _ScrollingFrame

            local v484 = u45[p482.name] ~= nil
            local v485 = v484 and (u443 == 'custom' and -102 or -70) or -70
            local _TextButton18 = Instance.new('TextButton')

            _TextButton18.Size = UDim2.new(1, v485, 1, 0)
            _TextButton18.Position = UDim2.new(0, 0, 0, 0)
            _TextButton18.BackgroundColor3 = Color3.new(0, 0, 0)
            _TextButton18.BackgroundTransparency = 0.5
            _TextButton18.Text = ' ' .. p482.name
            _TextButton18.TextColor3 = Color3.new(1, 1, 1)
            _TextButton18.TextSize = 12
            _TextButton18.Font = Enum.Font.Gotham
            _TextButton18.TextXAlignment = Enum.TextXAlignment.Left
            _TextButton18.BorderSizePixel = 0
            _TextButton18.Parent = _Frame15

            local _UICorner31 = Instance.new('UICorner')

            _UICorner31.CornerRadius = UDim.new(0, 12)
            _UICorner31.Parent = _TextButton18

            local v488

            if v484 and u443 == 'custom' then
                v488 = Instance.new('TextButton')
                v488.Size = UDim2.new(0, 32, 1, 0)
                v488.Position = UDim2.new(1, -98, 0, 0)
                v488.BackgroundTransparency = 1
                v488.Text = 'X'
                v488.TextColor3 = Color3.new(1, 0.3, 0.3)
                v488.TextSize = 16
                v488.BorderSizePixel = 0
                v488.Parent = _Frame15
            else
                v488 = nil
            end

            local _TextButton19 = Instance.new('TextButton')

            _TextButton19.Size = UDim2.new(0, 32, 1, 0)
            _TextButton19.Position = UDim2.new(1, -66, 0, 0)
            _TextButton19.BackgroundTransparency = 1
            _TextButton19.Text = u43[p482.name] and '\u{2605}' or '\u{2606}'
            _TextButton19.TextColor3 = u43[p482.name] and Color3.new(1, 0.8, 0) or Color3.new(0.7, 0.7, 0.7)
            _TextButton19.TextSize = 16
            _TextButton19.BorderSizePixel = 0
            _TextButton19.Parent = _Frame15

            local _TextButton20 = Instance.new('TextButton')

            _TextButton20.Size = UDim2.new(0, 32, 1, 0)
            _TextButton20.Position = UDim2.new(1, -32, 0, 0)
            _TextButton20.BackgroundTransparency = 1
            _TextButton20.Text = u44[p482.name] and (u44[p482.name].Name:gsub('KeyCode%.', ''):sub(1, 3) or 'Bind') or 'Bind'
            _TextButton20.TextColor3 = u44[p482.name] and Color3.new(1, 1, 1) or Color3.new(0.8, 0.8, 0.8)
            _TextButton20.TextSize = 8
            _TextButton20.Font = Enum.Font.Gotham
            _TextButton20.BorderSizePixel = 0
            _TextButton20.Parent = _Frame15

            _TextButton18.MouseEnter:Connect(function()
                _TextButton18.BackgroundTransparency = 0.3
            end)
            _TextButton18.MouseLeave:Connect(function()
                _TextButton18.BackgroundTransparency = 0.5
            end)
            _TextButton18.MouseButton1Click:Connect(function()
                u323(tostring(p482.id))
            end)

            if v488 then
                v488.MouseButton1Click:Connect(function()
                    u45[p482.name] = nil
                    u26[p482.name] = nil
                    u44[p482.name] = nil
                    u43[p482.name] = nil

                    u111()
                    u75()
                    u58()
                    loadGUI()
                end)
            end

            _TextButton19.MouseButton1Click:Connect(function()
                if u43[p482.name] then
                    u43[p482.name] = nil
                    _TextButton19.Text = '\u{2606}'
                    _TextButton19.TextColor3 = Color3.new(0.7, 0.7, 0.7)
                else
                    u43[p482.name] = tostring(p482.id)
                    _TextButton19.Text = '\u{2605}'
                    _TextButton19.TextColor3 = Color3.new(1, 0.8, 0)
                end

                u58()

                if u443 == 'favorites' then
                    spawn(function()
                        wait(0.1)
                        loadGUI()
                    end)
                end
            end)
            _TextButton20.MouseButton1Click:Connect(function()
                if u44[p482.name] then
                    u44[p482.name] = nil

                    u75()

                    _TextButton20.Text = 'Bind'
                    _TextButton20.TextColor3 = Color3.new(0.8, 0.8, 0.8)
                    _TextLabel2.Text = 'Unbound ' .. p482.name
                    _TextLabel2.TextColor3 = Color3.new(1, 0.5, 0.5)

                    spawn(function()
                        wait(2)

                        _TextLabel2.Text = 'Ready'
                        _TextLabel2.TextColor3 = Color3.new(0.7, 0.7, 0.7)
                    end)

                    return
                elseif not u446 then
                    u446 = true
                    u447 = p482.name
                    _TextLabel2.Text = 'Press any key to bind...'
                    _TextLabel2.TextColor3 = Color3.new(1, 1, 0.5)
                    _TextButton20.Text = '...'

                    local u491 = nil

                    u491 = _UserInputService.InputBegan:Connect(function(p492, p493)
                        if p493 then
                            return
                        elseif u446 and u447 == p482.name then
                            if p492.KeyCode == Enum.KeyCode.Escape or p492.KeyCode == Enum.KeyCode.Backspace then
                                _TextButton20.Text = 'Bind'
                                _TextButton20.TextColor3 = Color3.new(0.8, 0.8, 0.8)
                                _TextLabel2.Text = 'Binding cancelled'
                                _TextLabel2.TextColor3 = Color3.new(0.7, 0.7, 0.7)

                                spawn(function()
                                    wait(2)

                                    _TextLabel2.Text = 'Ready'
                                end)

                                u446 = false
                                u447 = nil

                                u491:Disconnect()
                            elseif p492.KeyCode ~= Enum.KeyCode.Unknown then
                                u44[p482.name] = p492.KeyCode

                                u75()

                                _TextButton20.Text = p492.KeyCode.Name:gsub('KeyCode%.', ''):sub(1, 3)
                                _TextButton20.TextColor3 = Color3.new(1, 1, 1)
                                _TextLabel2.Text = 'Bound to ' .. p492.KeyCode.Name:gsub('KeyCode%.', '')
                                _TextLabel2.TextColor3 = Color3.new(0.5, 1, 0.5)

                                spawn(function()
                                    wait(2)

                                    _TextLabel2.Text = 'Ready'
                                    _TextLabel2.TextColor3 = Color3.new(0.7, 0.7, 0.7)
                                end)

                                u446 = false
                                u447 = nil

                                u491:Disconnect()
                            end
                        else
                            u491:Disconnect()
                        end
                    end)
                end
            end)

            u218[p482.name] = {
                Container = _Frame15,
                NameButton = _TextButton18,
                FavoriteButton = _TextButton19,
                KeybindButton = _TextButton20,
                DeleteButton = v488,
            }
        end

        function loadGUI()
            local v495 = _ScrollingFrame
            local v496, v497, v498 = pairs(v495:GetChildren())

            while true do
                local v499

                v498, v499 = v496(v497, v498)

                if v498 == nil then
                    break
                end
                if v499:IsA('Frame') then
                    v499:Destroy()
                end
            end

            u218 = {}
            _Frame6.Visible = u443 == 'custom'
            _Frame7.Visible = u443 == 'states'
            _ScrollingFrame.Visible = u443 ~= 'states'
            _TextBox.Visible = u443 ~= 'states'

            if u443 ~= 'states' then
                if u443 ~= 'custom' then
                    _ScrollingFrame.Size = UDim2.new(1, -16, 1, -175)
                    _ScrollingFrame.Position = UDim2.new(0, 8, 0, 105)
                else
                    _ScrollingFrame.Size = UDim2.new(1, -16, 1, -270)
                    _ScrollingFrame.Position = UDim2.new(0, 8, 0, 195)
                end

                local v500 = {}
                local v501 = _TextBox.Text:lower()
                local v502 = u26

                if u443 == 'custom' then
                    v502 = u45
                end

                local v503, v504, v505 = pairs(v502)

                while true do
                    local v506

                    v505, v506 = v503(v504, v505)

                    if v505 == nil then
                        break
                    end
                    if (u443 ~= 'favorites' or u43[v505] ~= nil) and (v501 == '' or v505:lower():find(v501)) then
                        table.insert(v500, {
                            name = v505,
                            id = v506,
                        })
                    end
                end

                table.sort(v500, function(p507, p508)
                    return p507.name < p508.name
                end)

                local v509, v510, v511 = pairs(v500)

                while true do
                    local v512

                    v511, v512 = v509(v510, v511)

                    if v511 == nil then
                        break
                    end

                    u494(v512)
                end

                spawn(function()
                    wait(0.1)

                    _ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, _UIListLayout.AbsoluteContentSize.Y)
                end)
            end
        end

        local u513 = false
        local u514 = nil

        local function u516(p515)
            if p515 <= 0.5 then
                u25.speed = 0.01 + p515 * 2 * 0.99
            else
                u25.speed = 1 + (p515 - 0.5) * 2 * 9
            end

            _Frame12.Position = UDim2.new(p515, -6, 0.5, -6)
            _TextLabel8.Text = string.format('%.2fx', u25.speed)
        end
        local function u518(p517)
            u516((math.clamp((p517.Position.X - _Frame11.AbsolutePosition.X) / _Frame11.AbsoluteSize.X, 0, 1)))
        end
        local function u522(p519, p520)
            local v521 = math.clamp((p520.Position.X - _Frame11.AbsolutePosition.X) / _Frame11.AbsoluteSize.X, 0, 1)

            p519.Position = UDim2.new(v521, -1.5, 0, 0)

            if p519 ~= _Frame13 then
                u48.FastMarker.ratio = v521
            else
                u48.SlowMarker.ratio = v521
            end
        end
        local function u523()
            u25.speed = 1
            _Frame12.Position = UDim2.new(0.5, -6, 0.5, -6)
            _TextLabel8.Text = '1.00x'
        end

        local u524 = false
        local u525 = nil

        _TextButton15.MouseButton1Click:Connect(function()
            if not u524 then
                u524 = true
                u525 = _TextButton15
                _TextButton15.Text = '...'
                _TextLabel2.Text = 'Press any key for slow marker...'
                _TextLabel2.TextColor3 = Color3.new(1, 1, 0.5)

                local u526 = nil

                u526 = _UserInputService.InputBegan:Connect(function(p527, p528)
                    if p528 then
                        return
                    elseif u524 and u525 == _TextButton15 then
                        if p527.KeyCode ~= Enum.KeyCode.Unknown then
                            u48.SlowMarker.key = p527.KeyCode.Name
                            _TextButton15.Text = p527.KeyCode.Name:sub(1, 3)

                            u89()

                            if u49.SlowMarker then
                                u49.SlowMarker:Disconnect()
                            end

                            u49.SlowMarker = _UserInputService.InputBegan:Connect(function(p529, p530)
                                if not p530 then
                                    if p529.KeyCode == p527.KeyCode then
                                        u516(u48.SlowMarker.ratio)
                                    end
                                end
                            end)
                            _TextLabel2.Text = 'Slow marker bound to ' .. p527.KeyCode.Name
                            _TextLabel2.TextColor3 = Color3.new(0.5, 1, 0.5)

                            spawn(function()
                                wait(2)

                                _TextLabel2.Text = 'Ready'
                                _TextLabel2.TextColor3 = Color3.new(0.7, 0.7, 0.7)
                            end)

                            u524 = false
                            u525 = nil

                            u526:Disconnect()
                        end
                    else
                        u526:Disconnect()
                    end
                end)
            end
        end)
        _TextButton16.MouseButton1Click:Connect(function()
            if not u524 then
                u524 = true
                u525 = _TextButton16
                _TextButton16.Text = '...'
                _TextLabel2.Text = 'Press any key for fast marker...'
                _TextLabel2.TextColor3 = Color3.new(1, 1, 0.5)

                local u531 = nil

                u531 = _UserInputService.InputBegan:Connect(function(p532, p533)
                    if p533 then
                        return
                    elseif u524 and u525 == _TextButton16 then
                        if p532.KeyCode ~= Enum.KeyCode.Unknown then
                            u48.FastMarker.key = p532.KeyCode.Name
                            _TextButton16.Text = p532.KeyCode.Name:sub(1, 3)

                            u89()

                            if u49.FastMarker then
                                u49.FastMarker:Disconnect()
                            end

                            u49.FastMarker = _UserInputService.InputBegan:Connect(function(p534, p535)
                                if not p535 then
                                    if p534.KeyCode == p532.KeyCode then
                                        u516(u48.FastMarker.ratio)
                                    end
                                end
                            end)
                            _TextLabel2.Text = 'Fast marker bound to ' .. p532.KeyCode.Name
                            _TextLabel2.TextColor3 = Color3.new(0.5, 1, 0.5)

                            spawn(function()
                                wait(2)

                                _TextLabel2.Text = 'Ready'
                                _TextLabel2.TextColor3 = Color3.new(0.7, 0.7, 0.7)
                            end)

                            u524 = false
                            u525 = nil

                            u531:Disconnect()
                        end
                    else
                        u531:Disconnect()
                    end
                end)
            end
        end)

        local u536 = u48.SlowMarker.key ~= '' and Enum.KeyCode[u48.SlowMarker.key]

        if u536 then
            u49.SlowMarker = _UserInputService.InputBegan:Connect(function(p537, p538)
                if not p538 then
                    if p537.KeyCode == u536 then
                        u516(u48.SlowMarker.ratio)
                    end
                end
            end)
        end

        local u539 = u48.FastMarker.key ~= '' and Enum.KeyCode[u48.FastMarker.key]

        if u539 then
            u49.FastMarker = _UserInputService.InputBegan:Connect(function(p540, p541)
                if not p541 then
                    if p540.KeyCode == u539 then
                        u516(u48.FastMarker.ratio)
                    end
                end
            end)
        end

        _Frame13.InputBegan:Connect(function(p542)
            if p542.UserInputType == Enum.UserInputType.MouseButton1 or p542.UserInputType == Enum.UserInputType.Touch then
                u514 = _Frame13
            end
        end)
        _Frame14.InputBegan:Connect(function(p543)
            if p543.UserInputType == Enum.UserInputType.MouseButton1 or p543.UserInputType == Enum.UserInputType.Touch then
                u514 = _Frame14
            end
        end)
        spawn(function()
            wait(0.1)

            _Frame12.Position = UDim2.new(0.5, -6, 0.5, -6)
            _TextLabel8.Text = '1.00x'
        end)
        _Frame11.InputBegan:Connect(function(p544)
            if p544.UserInputType == Enum.UserInputType.MouseButton1 or p544.UserInputType == Enum.UserInputType.Touch then
                u513 = true

                u518(p544)
            end
        end)
        _UserInputService.InputChanged:Connect(function(p545)
            if u513 and (p545.UserInputType == Enum.UserInputType.MouseMovement or p545.UserInputType == Enum.UserInputType.Touch) then
                u518(p545)
            end
            if u514 and (p545.UserInputType == Enum.UserInputType.MouseMovement or p545.UserInputType == Enum.UserInputType.Touch) then
                u522(u514, p545)
            end
        end)
        _UserInputService.InputEnded:Connect(function(p546)
            if p546.UserInputType == Enum.UserInputType.MouseButton1 or p546.UserInputType == Enum.UserInputType.Touch then
                if u513 then
                    u513 = false
                end
                if u514 then
                    u89()

                    u514 = nil
                end
            end
        end)
        _TextButton17.MouseButton1Click:Connect(function()
            u523()
        end)
        _TextButton17.MouseEnter:Connect(function()
            _TextButton17.BackgroundTransparency = 0.3
        end)
        _TextButton17.MouseLeave:Connect(function()
            _TextButton17.BackgroundTransparency = 0.5
        end)
        _TextButton3.MouseButton1Click:Connect(function()
            u232()

            if u10 then
                u217(false)
            end

            _ScreenGui:Destroy()
        end)
        _TextButton2.MouseButton1Click:Connect(function()
            if not u445 then
                u445 = true

                if u444 then
                    local v547 = _TweenService:Create(_Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0, 280, 0, 395),
                    })

                    _TextButton2.Text = '\u{2212}'
                    u444 = false

                    v547:Play()
                    v547.Completed:Connect(function()
                        local v548, v549, v550 = pairs(u481)

                        while true do
                            local v551

                            v550, v551 = v548(v549, v550)

                            if v550 == nil then
                                break
                            end
                            if v551 ~= _Frame6 then
                                if v551 ~= _Frame7 then
                                    if v551 ~= _TextButton12 then
                                        if v551 == _ScrollingFrame or v551 == _TextBox then
                                            v551.Visible = u443 ~= 'states'
                                        else
                                            v551.Visible = true
                                        end
                                    else
                                        v551.Visible = u443 == 'custom' or u443 == 'states'
                                    end
                                else
                                    v551.Visible = u443 == 'states'
                                end
                            else
                                v551.Visible = u443 == 'custom'
                            end
                        end

                        u445 = false
                    end)
                else
                    local v552, v553, v554 = pairs(u481)

                    while true do
                        local v555

                        v554, v555 = v552(v553, v554)

                        if v554 == nil then
                            break
                        end

                        v555.Visible = false
                    end

                    local v556 = _TweenService:Create(_Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0, 280, 0, 30),
                    })

                    _TextButton2.Text = '+'
                    u444 = true

                    v556:Play()
                    v556.Completed:Connect(function()
                        u445 = false
                    end)
                end
            end
        end)
        _TextBox:GetPropertyChangedSignal('Text'):Connect(loadGUI)
        _TextButton4.MouseButton1Click:Connect(function()
            u443 = 'all'
            _TextButton4.BackgroundTransparency = 0.5
            _TextButton5.BackgroundTransparency = 0.8
            _TextButton6.BackgroundTransparency = 0.8
            _TextButton7.BackgroundTransparency = 0.8

            u463()
            loadGUI()
        end)
        _TextButton5.MouseButton1Click:Connect(function()
            u443 = 'favorites'
            _TextButton5.BackgroundTransparency = 0.5
            _TextButton4.BackgroundTransparency = 0.8
            _TextButton6.BackgroundTransparency = 0.8
            _TextButton7.BackgroundTransparency = 0.8

            u463()
            loadGUI()
        end)
        _TextButton6.MouseButton1Click:Connect(function()
            u443 = 'custom'
            _TextButton6.BackgroundTransparency = 0.5
            _TextButton4.BackgroundTransparency = 0.8
            _TextButton5.BackgroundTransparency = 0.8
            _TextButton7.BackgroundTransparency = 0.8

            u463()
            loadGUI()
        end)
        _TextButton7.MouseButton1Click:Connect(function()
            u443 = 'states'
            _TextButton7.BackgroundTransparency = 0.5
            _TextButton4.BackgroundTransparency = 0.8
            _TextButton5.BackgroundTransparency = 0.8
            _TextButton6.BackgroundTransparency = 0.8

            u463()
            loadGUI()
        end)
        _TextButton11.MouseButton1Click:Connect(function()
            local _Text = _TextBox2.Text
            local _Text2 = _TextBox3.Text

            if _Text == '' or _Text2 == '' then
                _TextLabel2.Text = 'Name and code required!'
                _TextLabel2.TextColor3 = Color3.new(1, 0.3, 0.3)

                spawn(function()
                    wait(2)

                    _TextLabel2.Text = 'Ready'
                    _TextLabel2.TextColor3 = Color3.new(0.7, 0.7, 0.7)
                end)
            else
                u45[_Text] = _Text2
                u26[_Text] = _Text2

                u111()

                _TextBox2.Text = ''
                _TextBox3.Text = ''
                _TextLabel2.Text = 'Added: ' .. _Text
                _TextLabel2.TextColor3 = Color3.new(0.5, 1, 0.5)

                spawn(function()
                    wait(2)

                    _TextLabel2.Text = 'Ready'
                    _TextLabel2.TextColor3 = Color3.new(0.7, 0.7, 0.7)
                end)
                loadGUI()
            end
        end)
        _TextButton11.MouseEnter:Connect(function()
            _TextButton11.BackgroundTransparency = 0.3
        end)
        _TextButton11.MouseLeave:Connect(function()
            _TextButton11.BackgroundTransparency = 0.5
        end)

        local u559 = false
        local u560 = nil
        local u561 = nil

        local function u563(p562)
            u559 = true
            u560 = p562.Position
            u561 = _Frame.Position
        end
        local function u566(p564)
            if u559 then
                local v565 = p564.Position - u560

                _Frame.Position = UDim2.new(u561.X.Scale, u561.X.Offset + v565.X, u561.Y.Scale, u561.Y.Offset + v565.Y)
            end
        end
        local function u567()
            u559 = false
        end

        _Frame2.InputBegan:Connect(function(p568)
            if p568.UserInputType == Enum.UserInputType.MouseButton1 or p568.UserInputType == Enum.UserInputType.Touch then
                u563(p568)
            end
        end)
        _UserInputService.InputChanged:Connect(function(p569)
            if p569.UserInputType == Enum.UserInputType.MouseMovement or p569.UserInputType == Enum.UserInputType.Touch then
                u566(p569)
            end
        end)
        _UserInputService.InputEnded:Connect(function(p570)
            if p570.UserInputType == Enum.UserInputType.MouseButton1 or p570.UserInputType == Enum.UserInputType.Touch then
                u567()
            end
        end)

        _TextLabel2.Text = 'Loading animations...'

        spawn(function()
            wait(1)

            _TextLabel2.Text = 'Loaded ' .. #u26 .. ' animations'
            _TextLabel2.TextColor3 = Color3.new(0.5, 1, 0.5)

            loadGUI()
            spawn(function()
                wait(2)

                _TextLabel2.Text = 'Ready'
                _TextLabel2.TextColor3 = Color3.new(0.7, 0.7, 0.7)
            end)
        end)
    end
end

_UserInputService.InputBegan:Connect(function(p572, p573)
    if p573 then
        return
    end

    local v574, v575, v576 = pairs(u44)

    while true do
        local v577

        v576, v577 = v574(v575, v576)

        if v576 == nil then
            break
        end
        if p572.KeyCode == v577 then
            local v578 = u26[v576] or u43[v576]

            if v578 then
                u323(tostring(v578))
            end

            break
        end
    end
end)
task.spawn(function()
    u140()
    u94()
    u571()
end)
print('AK Reanim loaded!')
