local v1 = game:GetService("Players")
local v_u_2 = game:GetService("Workspace")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("ReplicatedStorage")
local v_u_6 = game:GetService("TweenService")
local v_u_7 = v1.LocalPlayer
local v_u_8 = nil
local v_u_9 = game:GetService("HttpService")
local v_u_10 = false
local v_u_11 = nil
local v_u_12 = nil
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = {}
local v_u_18 = {}
local v_u_19 = {}
local v_u_20 = {
	["idle"] = nil,
	["walking"] = nil,
	["jumping"] = nil
}
local v_u_21 = "ak/state_animations.json"
local v_u_22 = {}
local v_u_23 = {
	["heightScale"] = 1,
	["widthScale"] = 1
}
local v_u_24 = "ak/animation_list_cache.json"
_G.hiddenBodyParts = _G.hiddenBodyParts or {}
local _ = _G.hiddenBodyParts
local v_u_25 = {
	"Head",
	"UpperTorso",
	"LowerTorso",
	"LeftUpperArm",
	"LeftLowerArm",
	"LeftHand",
	"RightUpperArm",
	"RightLowerArm",
	"RightHand",
	"LeftUpperLeg",
	"LeftLowerLeg",
	"LeftFoot",
	"RightUpperLeg",
	"RightLowerLeg",
	"RightFoot",
	"Torso",
	"Left Arm",
	"Right Arm",
	"Left Leg",
	"Right Leg",
	"HumanoidRootPart"
}
local v_u_26 = false
local v_u_27 = 1
local v_u_28 = 0.1
local v_u_29 = true
local v_u_30 = false
local v_u_31 = {
	["Head"] = Vector3.new(101, 3, -2152),
	["UpperTorso"] = Vector3.new(101, 3, -2150002),
	["LowerTorso"] = Vector3.new(101, 3, -2150002),
	["Torso"] = Vector3.new(101, 3, -2150002),
	["LeftUpperArm"] = Vector3.new(0, 3, 0),
	["LeftLowerArm"] = Vector3.new(0, 3, 0),
	["LeftHand"] = Vector3.new(0, 3, 0),
	["Left Arm"] = Vector3.new(0, 3, 0),
	["RightUpperArm"] = Vector3.new(999999, 3, 0),
	["RightLowerArm"] = Vector3.new(0, 3, 0),
	["RightHand"] = Vector3.new(0, 3, 0),
	["Right Arm"] = Vector3.new(999999, 3, 0),
	["LeftUpperLeg"] = Vector3.new(-10000000, 3, 25000000),
	["LeftLowerLeg"] = Vector3.new(-10000000, 3, -25000000),
	["LeftFoot"] = Vector3.new(0, 3, 0),
	["Left Leg"] = Vector3.new(-10000000, 3, 25000000),
	["RightUpperLeg"] = Vector3.new(10000000, 3, 25000000),
	["RightLowerLeg"] = Vector3.new(10000000, 3, -25000000),
	["RightFoot"] = Vector3.new(0, 3, 0),
	["Right Leg"] = Vector3.new(10000000, 3, 25000000)
}
local v_u_32 = {
	["Head"] = Vector3.new(101, 1003, -2152),
	["UpperTorso"] = Vector3.new(101, 1015, -2150002),
	["LowerTorso"] = Vector3.new(101, 996.8, -2150002),
	["Torso"] = Vector3.new(101, 1015, -2150002),
	["LeftUpperArm"] = Vector3.new(0, 1000, 0),
	["LeftLowerArm"] = Vector3.new(0, 1000, 0),
	["LeftHand"] = Vector3.new(0, 1000, 0),
	["Left Arm"] = Vector3.new(0, 1000, 0),
	["RightUpperArm"] = Vector3.new(999999, 1000, 0),
	["RightLowerArm"] = Vector3.new(0, 1000, 0),
	["RightHand"] = Vector3.new(0, 1000, 0),
	["Right Arm"] = Vector3.new(999999, 1000, 0),
	["LeftUpperLeg"] = Vector3.new(-10000000, 1015, 25000000),
	["LeftLowerLeg"] = Vector3.new(-10000000, 1015, -25000000),
	["LeftFoot"] = Vector3.new(0, 1000, 0),
	["Left Leg"] = Vector3.new(-10000000, 1015, 25000000),
	["RightUpperLeg"] = Vector3.new(10000000, 1015, 25000000),
	["RightLowerLeg"] = Vector3.new(10000000, 1015, -25000000),
	["RightFoot"] = Vector3.new(0, 1000, 0),
	["Right Leg"] = Vector3.new(10000000, 1015, 25000000)
}
local v_u_33 = {}
local v_u_34 = {}
local v_u_35 = {}
local v_u_36 = 3000
local v_u_37 = {
	"Head",
	"UpperTorso",
	"LowerTorso",
	"LeftUpperArm",
	"LeftLowerArm",
	"LeftHand",
	"RightUpperArm",
	"RightLowerArm",
	"RightHand",
	"LeftUpperLeg",
	"LeftLowerLeg",
	"LeftFoot",
	"RightUpperLeg",
	"RightLowerLeg",
	"RightFoot"
}
local v_u_38 = {
	["isRunning"] = false,
	["currentId"] = nil,
	["keyframes"] = nil,
	["totalDuration"] = 0,
	["elapsedTime"] = 0,
	["speed"] = 1,
	["connection"] = nil
}
local v_u_39 = {}
local v_u_40 = {}
local v_u_41 = false
(function()
	-- upvalues: (ref) v_u_8, (ref) v_u_7
	local function v46(p_u_42)
		-- upvalues: (ref) v_u_8
		if v_u_8 then
			local v43 = p_u_42:WaitForChild("HumanoidRootPart", 5)
			if v43 then
				v43.CFrame = v_u_8
			end
			v_u_8 = nil
		end
		local v44 = p_u_42:FindFirstChildOfClass("Humanoid")
		if v44 then
			v44.Died:Connect(function()
				-- upvalues: (ref) p_u_42, (ref) v_u_8
				local v45 = p_u_42:FindFirstChild("HumanoidRootPart")
				if v45 then
					v_u_8 = v45.CFrame
				end
			end)
		end
	end
	if v_u_7.Character then
		v46(v_u_7.Character)
	end
	v_u_7.CharacterAdded:Connect(v46)
end)()
local v_u_47 = {}
local v_u_48 = {}
local v_u_49 = {}
local v_u_50 = "ak/custom_animations.json"
local v_u_51 = "ak/speed_keybinds.json"
local v_u_52 = {}
local function v_u_53()
	if not isfolder("ak") then
		makefolder("ak")
	end
end
local function v_u_57()
	-- upvalues: (ref) v_u_53, (ref) v_u_39, (ref) v_u_40, (ref) v_u_9, (ref) v_u_24
	v_u_53()
	local v54 = {
		["animations"] = v_u_39,
		["order"] = v_u_40,
		["timestamp"] = os.time()
	}
	local v55, v_u_56 = pcall(v_u_9.JSONEncode, v_u_9, v54)
	if v55 then
		pcall(function()
			-- upvalues: (ref) v_u_24, (ref) v_u_56
			writefile(v_u_24, v_u_56)
		end)
	end
end
local function v_u_62()
	-- upvalues: (ref) v_u_53, (ref) v_u_24, (ref) v_u_9, (ref) v_u_39, (ref) v_u_40
	v_u_53()
	local v58, v59 = pcall(readfile, v_u_24)
	if v58 then
		local v60, v61 = pcall(v_u_9.JSONDecode, v_u_9, v59)
		if v60 and (typeof(v61) == "table" and (v61.animations and v61.order)) then
			v_u_39 = v61.animations
			v_u_40 = v61.order
			return true
		end
	end
	return false
end
local function v_u_71()
	-- upvalues: (ref) v_u_41, (ref) v_u_39, (ref) v_u_57
	if v_u_41 then
		return
	else
		v_u_41 = true
		local v63, v64 = pcall(game.HttpGet, game, "https://yourscoper.vercel.app/scripts/akadmin/animlist.lua", true)
		if v63 then
			local v65, v66 = pcall(loadstring(v64))
			if v65 and type(v66) == "table" then
				v_u_39 = {}
				local v67, v68, v69 = pairs(v66)
				while true do
					local v70
					v69, v70 = v67(v68, v69)
					if v69 == nil then
						break
					end
					v_u_39[v69] = v70
				end
				v_u_57()
			end
		else
			return
		end
	end
end
local function v_u_79()
	-- upvalues: (ref) v_u_53, (ref) v_u_47, (ref) v_u_9
	v_u_53()
	local v72, v73, v74 = pairs(v_u_47)
	local v75 = {}
	while true do
		local v76
		v74, v76 = v72(v73, v74)
		if v74 == nil then
			break
		end
		v75[v74] = tostring(v76)
	end
	local v77, v_u_78 = pcall(v_u_9.JSONEncode, v_u_9, v75)
	if v77 then
		pcall(function()
			-- upvalues: (ref) v_u_78
			writefile("ak/favorite_animations.json", v_u_78)
		end)
	end
end
local function v_u_88()
	-- upvalues: (ref) v_u_53, (ref) v_u_9, (ref) v_u_47, (ref) v_u_39, (ref) v_u_40
	v_u_53()
	local v80, v81 = pcall(readfile, "ak/favorite_animations.json")
	if v80 then
		local v82, v83 = pcall(v_u_9.JSONDecode, v_u_9, v81)
		if v82 and typeof(v83) == "table" then
			v_u_47 = {}
			local v84, v85, v86 = pairs(v83)
			while true do
				local v87
				v86, v87 = v84(v85, v86)
				if v86 == nil then
					break
				end
				v_u_47[v86] = v87
				if not v_u_39[v86] then
					v_u_39[v86] = v87
					if not table.find(v_u_40, v86) then
						table.insert(v_u_40, v86)
					end
				end
			end
		else
			v_u_47 = {}
		end
	else
		v_u_47 = {}
	end
end
local function v_u_96()
	-- upvalues: (ref) v_u_53, (ref) v_u_48, (ref) v_u_9
	v_u_53()
	local v89, v90, v91 = pairs(v_u_48)
	local v92 = {}
	while true do
		local v93
		v91, v93 = v89(v90, v91)
		if v91 == nil then
			break
		end
		v92[v91] = v93.Name
	end
	local v94, v_u_95 = pcall(v_u_9.JSONEncode, v_u_9, v92)
	if v94 then
		pcall(function()
			-- upvalues: (ref) v_u_95
			writefile("ak/animation_keybinds.json", v_u_95)
		end)
	end
end
local function v_u_106()
	-- upvalues: (ref) v_u_53, (ref) v_u_9, (ref) v_u_48
	v_u_53()
	local v97, v98 = pcall(readfile, "ak/animation_keybinds.json")
	if v97 then
		local v99, v100 = pcall(v_u_9.JSONDecode, v_u_9, v98)
		if v99 and typeof(v100) == "table" then
			v_u_48 = {}
			local v101, v102, v103 = pairs(v100)
			while true do
				local v104
				v103, v104 = v101(v102, v103)
				if v103 == nil then
					break
				end
				local v105 = Enum.KeyCode[v104]
				if v105 then
					v_u_48[v103] = v105
				end
			end
		else
			v_u_48 = {}
		end
	else
		v_u_48 = {}
	end
end
local function v_u_111()
	-- upvalues: (ref) v_u_53, (ref) v_u_52, (ref) v_u_9, (ref) v_u_51
	v_u_53()
	local v107 = {}
	for v108 = 1, 5 do
		if v_u_52[v108] then
			v107["slot" .. v108] = {
				["speed"] = v_u_52[v108].speed or v108 * 2 - 1,
				["key"] = v_u_52[v108].key or ""
			}
		end
	end
	local v109, v_u_110 = pcall(v_u_9.JSONEncode, v_u_9, v107)
	if v109 then
		pcall(function()
			-- upvalues: (ref) v_u_51, (ref) v_u_110
			writefile(v_u_51, v_u_110)
		end)
	end
end
local function v_u_118()
	-- upvalues: (ref) v_u_53, (ref) v_u_51, (ref) v_u_9, (ref) v_u_52
	v_u_53()
	local v112, v113 = pcall(readfile, v_u_51)
	if v112 then
		local v114, v115 = pcall(v_u_9.JSONDecode, v_u_9, v113)
		if v114 and typeof(v115) == "table" then
			for v116 = 1, 5 do
				local v117 = "slot" .. v116
				if v115[v117] then
					v_u_52[v116] = {
						["speed"] = v115[v117].speed or v116 * 2 - 1,
						["key"] = v115[v117].key or ""
					}
				end
			end
		end
	end
end
local function v_u_122()
	-- upvalues: (ref) v_u_53, (ref) v_u_20, (ref) v_u_9, (ref) v_u_21
	v_u_53()
	local v119 = {
		["idle"] = v_u_20.idle,
		["walking"] = v_u_20.walking,
		["jumping"] = v_u_20.jumping
	}
	local v120, v_u_121 = pcall(v_u_9.JSONEncode, v_u_9, v119)
	if v120 then
		pcall(function()
			-- upvalues: (ref) v_u_21, (ref) v_u_121
			writefile(v_u_21, v_u_121)
		end)
	end
end
local function v_u_127()
	-- upvalues: (ref) v_u_53, (ref) v_u_21, (ref) v_u_9, (ref) v_u_20
	v_u_53()
	local v123, v124 = pcall(readfile, v_u_21)
	if v123 then
		local v125, v126 = pcall(v_u_9.JSONDecode, v_u_9, v124)
		if v125 and typeof(v126) == "table" then
			v_u_20.idle = v126.idle
			v_u_20.walking = v126.walking
			v_u_20.jumping = v126.jumping
		end
	end
end
local function v_u_135()
	-- upvalues: (ref) v_u_53, (ref) v_u_49, (ref) v_u_9, (ref) v_u_50
	v_u_53()
	local v128, v129, v130 = pairs(v_u_49)
	local v131 = {}
	while true do
		local v132
		v130, v132 = v128(v129, v130)
		if v130 == nil then
			break
		end
		v131[v130] = v132
	end
	local v133, v_u_134 = pcall(v_u_9.JSONEncode, v_u_9, v131)
	if v133 then
		pcall(function()
			-- upvalues: (ref) v_u_50, (ref) v_u_134
			writefile(v_u_50, v_u_134)
		end)
	end
end
local function v_u_144()
	-- upvalues: (ref) v_u_53, (ref) v_u_50, (ref) v_u_9, (ref) v_u_49, (ref) v_u_39, (ref) v_u_40
	v_u_53()
	local v136, v137 = pcall(readfile, v_u_50)
	if v136 then
		local v138, v139 = pcall(v_u_9.JSONDecode, v_u_9, v137)
		if v138 and typeof(v139) == "table" then
			v_u_49 = {}
			local v140, v141, v142 = pairs(v139)
			while true do
				local v143
				v142, v143 = v140(v141, v142)
				if v142 == nil then
					break
				end
				v_u_49[v142] = v143
				v_u_39[v142] = v143
				if not table.find(v_u_40, v142) then
					table.insert(v_u_40, v142)
				end
			end
		else
			v_u_49 = {}
		end
	else
		v_u_49 = {}
	end
end
local function v_u_145()
	-- upvalues: (ref) v_u_53, (ref) v_u_62, (ref) v_u_106, (ref) v_u_88, (ref) v_u_144, (ref) v_u_127, (ref) v_u_118, (ref) v_u_24, (ref) v_u_71
	v_u_53()
	v_u_62()
	v_u_106()
	v_u_88()
	v_u_144()
	v_u_127()
	v_u_118()
	task.spawn(function()
		-- upvalues: (ref) v_u_24, (ref) v_u_71, (ref) v_u_144
		wait(2)
		if isfile(v_u_24) then
			pcall(function()
				-- upvalues: (ref) v_u_24
				delfile(v_u_24)
			end)
			print("Deleted old animation cache")
		end
		v_u_71()
		v_u_144()
	end)
end
local v_u_146 = {}
local function v_u_152()
	-- upvalues: (ref) v_u_7, (ref) v_u_146
	local v147 = v_u_7:FindFirstChildWhichIsA("PlayerGui")
	if v147 then
		local v148, v149, v150 = ipairs(v147:GetChildren())
		while true do
			local v151
			v150, v151 = v148(v149, v150)
			if v150 == nil then
				break
			end
			if v151:IsA("ScreenGui") and v151.ResetOnSpawn then
				table.insert(v_u_146, v151)
				v151.ResetOnSpawn = false
			end
		end
	end
end
local function v_u_157()
	-- upvalues: (ref) v_u_146
	local v153, v154, v155 = ipairs(v_u_146)
	while true do
		local v156
		v155, v156 = v153(v154, v155)
		if v155 == nil then
			break
		end
		v156.ResetOnSpawn = true
	end
	table.clear(v_u_146)
end
local function v_u_168()
	-- upvalues: (ref) v_u_12
	if v_u_12 then
		local v158 = v_u_12
		local v159, v160, v161 = pairs(v158:GetDescendants())
		while true do
			local v162
			v161, v162 = v159(v160, v161)
			if v161 == nil then
				break
			end
			if v162:IsA("BasePart") then
				v162.Transparency = 1
			end
		end
		local v163 = v_u_12:FindFirstChild("Head")
		if v163 then
			local v164, v165, v166 = ipairs(v163:GetChildren())
			while true do
				local v167
				v166, v167 = v164(v165, v166)
				if v166 == nil then
					break
				end
				if v167:IsA("Decal") then
					v167.Transparency = 1
				end
			end
		end
	end
end
local function v_u_209(_)
	-- upvalues: (ref) v_u_10, (ref) v_u_11, (ref) v_u_12, (ref) v_u_26, (ref) v_u_34, (ref) v_u_33, (ref) v_u_37, (ref) v_u_35, (ref) v_u_36, (ref) v_u_29, (ref) v_u_28, (ref) v_u_27
	if not (v_u_10 and (v_u_11 and (v_u_11.Parent and (v_u_12 and v_u_12.Parent)))) then
		return
	end
	if not v_u_26 then
		return
	end
	local v169 = v_u_12:FindFirstChild("HumanoidRootPart")
	if not v169 then
		return
	end
	if not v_u_34 then
		v_u_34 = {}
	end
	if not v_u_33 then
		v_u_33 = {}
	end
	local v170 = v_u_37
	if #v170 == 0 then
		return
	end
	local v171 = v169.AssemblyLinearVelocity.Magnitude > 0.1
	if not v_u_35 then
		v_u_35 = {}
	end
	table.insert(v_u_35, 1, {
		["pos"] = v169.Position,
		["rot"] = v169.CFrame - v169.Position
	})
	if v_u_36 < #v_u_35 then
		table.remove(v_u_35)
	end
	if v_u_29 then
		local v172 = v170[1]
		local v173 = v_u_11:FindFirstChild(v172)
		if v173 then
			if not v_u_34[v172] then
				v_u_34[v172] = v173.CFrame
			end
			if not v_u_33[v172] then
				v_u_33[v172] = v173.CFrame
			end
			if v171 then
				local v174 = v169.Position
				local v175 = v169.CFrame - v169.Position
				v_u_34[v172] = CFrame.new(v174) * v175
			end
			local v176 = v_u_33[v172]:Lerp(v_u_34[v172], v_u_28)
			v173.CFrame = v176
			v173.AssemblyLinearVelocity = Vector3.zero
			v173.AssemblyAngularVelocity = Vector3.zero
			v_u_33[v172] = v176
			for v177 = 2, #v170 do
				local v178 = v170[v177]
				local v179 = v_u_11:FindFirstChild(v178)
				local v180 = v_u_11:FindFirstChild(v170[v177 - 1])
				if v179 then
					if v180 then
						if not v_u_34[v178] then
							v_u_34[v178] = v179.CFrame
						end
						if not v_u_33[v178] then
							v_u_33[v178] = v179.CFrame
						end
						if v171 then
							local v181 = v180.Position
							local v182 = v180.CFrame - v180.Position
							local v183
							if v177 == 2 then
								v183 = (v181 - v169.Position).Unit
							else
								local v184 = v_u_11:FindFirstChild(v170[v177 - 2])
								if v184 then
									v183 = (v181 - v184.Position).Unit
								else
									v183 = v182.LookVector
								end
							end
							if v183.Magnitude < 0.1 then
								v183 = v182.LookVector
							end
							local v185 = v181 + v183 * v_u_27
							v_u_34[v178] = CFrame.new(v185) * v182
						end
						local v186 = v_u_33[v178]:Lerp(v_u_34[v178], v_u_28)
						v179.CFrame = v186
						v179.AssemblyLinearVelocity = Vector3.zero
						v179.AssemblyAngularVelocity = Vector3.zero
						v_u_33[v178] = v186
					end
				end
			end
		end
	else
		local v187 = #v_u_35
		local v188 = { 0 }
		for v189 = 2, v187 do
			v188[v189] = v188[v189 - 1] + (v_u_35[v189 - 1].pos - v_u_35[v189].pos).Magnitude
		end
		for v197 = 1, #v170 do
			local v191 = v170[v197]
			local v192 = v_u_11:FindFirstChild(v191)
			if v192 then
				local v193 = (v197 - 1) * v_u_27
				local v194 = v197
				local v195 = nil
				for v196 = 2, v187 do
					if v193 <= v188[v196] then
						v195 = v196
						break
					end
				end
				local v197
				if v195 and (v_u_35[v195] and v_u_35[v195 - 1]) then
					local v198 = v188[v195 - 1]
					local v199 = v188[v195]
					local v200 = (v193 - v198) / math.max(1e-6, v199 - v198)
					local v201 = v_u_35[v195 - 1].pos
					local v202 = v_u_35[v195].pos
					local v203 = v_u_35[v195 - 1].rot
					local v204 = v201:Lerp(v202, v200)
					local v205 = CFrame.new(v204) * v203
					if not v_u_33[v191] then
						v_u_33[v191] = v192.CFrame
					end
					if not v_u_34[v191] then
						v_u_34[v191] = v192.CFrame
					end
					v_u_34[v191] = v205
					local v206 = v_u_33[v191]:Lerp(v_u_34[v191], v_u_28)
					v192.CFrame = v206
					v192.AssemblyLinearVelocity = Vector3.zero
					v192.AssemblyAngularVelocity = Vector3.zero
					v_u_33[v191] = v206
					v197 = v194
				else
					local v207 = v169.CFrame
					local v208 = v207 + v207.LookVector * (-(v197 - 1) * v_u_27)
					v192.CFrame = v208
					v_u_33[v191] = v208
					v197 = v194
				end
			end
		end
	end
end
local function v_u_231(p210)
	-- upvalues: (ref) v_u_10, (ref) v_u_11, (ref) v_u_12, (ref) v_u_26, (ref) v_u_209, (ref) v_u_31, (ref) v_u_30, (ref) v_u_32, (ref) v_u_25, (ref) v_u_23, (ref) v_u_16
	if v_u_10 and (v_u_11 and (v_u_11.Parent and (v_u_12 and v_u_12.Parent))) then
		if v_u_26 then
			v_u_209(p210)
			return
		elseif groundModeEnabled then
			local v211, v212, v213 = pairs(v_u_31)
			while true do
				local v214
				v213, v214 = v211(v212, v213)
				if v213 == nil then
					break
				end
				local v215 = v_u_11:FindFirstChild(v213)
				if v215 and v215:IsA("BasePart") then
					v215.CFrame = CFrame.new(v214)
					v215.AssemblyLinearVelocity = Vector3.zero
					v215.AssemblyAngularVelocity = Vector3.zero
				end
			end
			return
		elseif v_u_30 then
			local v216, v217, v218 = pairs(v_u_32)
			while true do
				local v219
				v218, v219 = v216(v217, v218)
				if v218 == nil then
					break
				end
				local v220 = v_u_11:FindFirstChild(v218)
				if v220 and v220:IsA("BasePart") then
					v220.CFrame = CFrame.new(v219)
					v220.AssemblyLinearVelocity = Vector3.zero
					v220.AssemblyAngularVelocity = Vector3.zero
				end
			end
		else
			local v221, v222, v223 = ipairs(v_u_25)
			while true do
				local v224
				v223, v224 = v221(v222, v223)
				if v223 == nil then
					break
				end
				local v225 = v_u_11:FindFirstChild(v224)
				local v226 = v_u_12:FindFirstChild(v224)
				if v225 and v226 then
					if _G.hiddenBodyParts[v224] then
						if not _G.hiddenBodyPartPositions then
							_G.hiddenBodyPartPositions = {}
						end
						if not _G.hiddenBodyPartPositions[v224] then
							local v227 = Vector3.new(0, -500, 0)
							local v228 = v225.CFrame - v225.Position
							_G.hiddenBodyPartPositions[v224] = CFrame.new(v227) * v228
						end
						v225.CFrame = _G.hiddenBodyPartPositions[v224]
					else
						if _G.hiddenBodyPartPositions then
							_G.hiddenBodyPartPositions[v224] = nil
						end
						v225.Anchored = false
						v225.CFrame = v226.CFrame
					end
					v225.AssemblyLinearVelocity = Vector3.zero
					v225.AssemblyAngularVelocity = Vector3.zero
				end
			end
			local v229 = v_u_12:FindFirstChildWhichIsA("Humanoid")
			if v229 and (v_u_23.heightScale ~= 1 or v_u_23.widthScale ~= 1) then
				local v230 = v_u_16 * v_u_23.heightScale - 0.5
				v229.HipHeight = math.max(v230, 0.2)
			end
		end
	else
		return
	end
end
local function v_u_246()
	-- upvalues: (ref) v_u_10, (ref) v_u_12, (ref) v_u_16, (ref) v_u_23, (ref) v_u_17, (ref) v_u_18
	if v_u_10 and v_u_12 then
		local v232 = v_u_12:FindFirstChildWhichIsA("Humanoid")
		if v232 then
			local v233 = v_u_16 * v_u_23.heightScale - 0.5
			v232.HipHeight = math.max(v233, 0.2)
			local v234, v235, v236 = pairs(v_u_17)
			while true do
				local v237
				v236, v237 = v234(v235, v236)
				if v236 == nil then
					break
				end
				if v236 and v236:IsA("BasePart") then
					v236.Size = Vector3.new(v237.X * v_u_23.widthScale, v237.Y * v_u_23.heightScale, v237.Z * v_u_23.widthScale)
				end
			end
			local v238, v239, v240 = pairs(v_u_18)
			while true do
				local v241
				v240, v241 = v238(v239, v240)
				if v240 == nil then
					break
				end
				if v240 and v240:IsA("Motor6D") then
					local v242 = v241.C0.Position
					local v243 = Vector3.new(v242.X * v_u_23.widthScale, v242.Y * v_u_23.heightScale, v242.Z * v_u_23.widthScale)
					v240.C0 = CFrame.new(v243) * (v241.C0 - v241.C0.Position)
					local v244 = v241.C1.Position
					local v245 = Vector3.new(v244.X * v_u_23.widthScale, v244.Y * v_u_23.heightScale, v244.Z * v_u_23.widthScale)
					v240.C1 = CFrame.new(v245) * (v241.C1 - v241.C1.Position)
				end
			end
		end
	else
		return
	end
end
local function v_u_249()
	-- upvalues: (ref) v_u_2, (ref) v_u_7
	pcall(function()
		-- upvalues: (ref) v_u_2, (ref) v_u_7
		local v247 = v_u_2:FindFirstChild("VirtuallyNad")
		if v247 then
			local v248 = v247:FindFirstChild("HeadMovement")
			if v248 and v248:IsA("LocalScript") then
				v248.Disabled = true
			end
		end
		v_u_7:SetAttribute("TurnHead", false)
	end)
end
local function v_u_252()
	-- upvalues: (ref) v_u_2
	pcall(function()
		-- upvalues: (ref) v_u_2
		local v250 = v_u_2:FindFirstChild("VirtuallyNad")
		if v250 then
			local v251 = v250:FindFirstChild("HeadMovement")
			if v251 and v251:IsA("LocalScript") then
				v251.Disabled = false
			end
		end
	end)
end
local v_u_253 = nil
local function v_u_289(p254)
	-- upvalues: (ref) v_u_10, (ref) v_u_5, (ref) v_u_7, (ref) v_u_11, (ref) v_u_13, (ref) v_u_12, (ref) v_u_16, (ref) v_u_23, (ref) v_u_168, (ref) v_u_17, (ref) v_u_18, (ref) v_u_14, (ref) v_u_152, (ref) v_u_2, (ref) v_u_157, (ref) v_u_249, (ref) v_u_15, (ref) v_u_4, (ref) v_u_231, (ref) v_u_22, (ref) v_u_38, (ref) v_u_252, (ref) v_u_253
	v_u_10 = p254
	local v_u_255 = game:GetService("ReplicatedStorage"):FindFirstChild("event_rag")
	local v_u_256 = game:GetService("ReplicatedStorage"):FindFirstChild("Ragdoll")
	local v_u_257 = game:GetService("ReplicatedStorage"):FindFirstChild("Unragdoll")
	local v_u_258 = nil
	if not (v_u_255 or v_u_256) then
		local v261, v262 = pcall(function()
			-- upvalues: (ref) v_u_5
			local v259 = v_u_5:FindFirstChild("LocalModules", true)
			local v260 = v259 and v259:FindFirstChild("Backend")
			if v260 then
				local _ = require
				local _ = v260.FindFirstChild
			end
		end)
		v_u_258 = v261 and v262 and v262 or v_u_258
	end
	if v_u_10 then
		local v263 = v_u_7.Character
		if not v263 then
			return
		end
		local v264 = v263:FindFirstChildOfClass("Humanoid")
		local v265 = v263:FindFirstChild("HumanoidRootPart")
		if not (v264 and v265) then
			return
		end
		v_u_11 = v263
		v_u_13 = v265.CFrame
		v263.Archivable = true
		v_u_12 = v263:Clone()
		v263.Archivable = false
		local v266 = v_u_11.Name
		v_u_12.Name = v266 .. "Celeste"
		local v267 = v_u_12:FindFirstChildWhichIsA("Humanoid")
		if v267 then
			v267.DisplayName = v266 .. "Celeste"
			v_u_16 = v267.HipHeight
			v_u_23 = {
				["heightScale"] = 1,
				["widthScale"] = 1
			}
			v267.WalkSpeed = v264.WalkSpeed
			v267.JumpPower = v264.JumpPower
		end
		local v268 = not v_u_12.PrimaryPart and v_u_12:FindFirstChild("HumanoidRootPart")
		if v268 then
			v_u_12.PrimaryPart = v268
		end
		v_u_168()
		v_u_17 = {}
		v_u_18 = {}
		local v269 = v_u_12
		local v270, v271, v272 = ipairs(v269:GetDescendants())
		while true do
			local v273
			v272, v273 = v270(v271, v272)
			if v272 == nil then
				break
			end
			if v273:IsA("BasePart") then
				v_u_17[v273] = v273.Size
			elseif v273:IsA("Motor6D") then
				v_u_18[v273] = {
					["C0"] = v273.C0,
					["C1"] = v273.C1
				}
			end
		end
		local v274 = v_u_11:FindFirstChild("Animate")
		if v274 then
			v_u_14 = v274:Clone()
			v_u_14.Parent = v_u_12
			v_u_14.Disabled = true
		end
		v_u_152()
		v_u_12.Parent = v_u_2
		v_u_7.Character = v_u_12
		if v267 then
			v_u_2.CurrentCamera.CameraSubject = v267
		end
		v_u_157()
		if v_u_14 then
			v_u_14.Disabled = false
		end
		if v267 then
			v267:ChangeState(Enum.HumanoidStateType.Running)
		end
		task.spawn(function()
			-- upvalues: (ref) v_u_10, (ref) v_u_255, (ref) v_u_11, (ref) v_u_256, (ref) v_u_258, (ref) v_u_249, (ref) v_u_15, (ref) v_u_4, (ref) v_u_231
			if v_u_10 then
				if v_u_255 then
					pcall(function()
						-- upvalues: (ref) v_u_11
						local v275 = game:GetService("ReplicatedStorage"):FindFirstChild("event_rag")
						if v275 then
							local v276 = v_u_11 and (v_u_11:FindFirstChildOfClass("Humanoid") and v_u_11:FindFirstChildOfClass("Humanoid"))
							if v276 then
								game.Players.LocalPlayer.Character.Humanoid.HipHeight = v276.HipHeight
							end
							v275:FireServer(unpack({ "Hinge" }))
						end
					end)
				elseif v_u_256 then
					pcall(function()
						local v277 = game:GetService("ReplicatedStorage"):FindFirstChild("Ragdoll")
						if v277 then
							v277:FireServer(unpack({ "Ball" }))
						end
					end)
				elseif v_u_258 then
					pcall(function()
						-- upvalues: (ref) v_u_258, (ref) v_u_249
						v_u_258.Ragdoll:Fire(true)
						v_u_249()
					end)
				end
				if v_u_15 then
					v_u_15:Disconnect()
				end
				v_u_15 = v_u_4.Heartbeat:Connect(v_u_231)
			end
		end)
	else
		local v278, v279, v280 = pairs(v_u_22)
		while true do
			local v281
			v280, v281 = v278(v279, v280)
			if v280 == nil then
				break
			end
			if v281 then
				v281:Disconnect()
			end
		end
		v_u_22 = {}
		if v_u_15 then
			v_u_15:Disconnect()
			v_u_15 = nil
		end
		if v_u_38.connection then
			v_u_38.connection:Disconnect()
			v_u_38.connection = nil
		end
		v_u_38.isRunning = false
		if not (v_u_11 and v_u_12) then
			return
		end
		for _ = 1, 3 do
			pcall(function()
				-- upvalues: (ref) v_u_255, (ref) v_u_257, (ref) v_u_258, (ref) v_u_252
				if v_u_255 then
					local v282 = game:GetService("ReplicatedStorage"):FindFirstChild("event_rag")
					if v282 then
						v282:FireServer(unpack({ "Hinge" }))
					end
				elseif v_u_257 then
					local v283 = game:GetService("ReplicatedStorage"):FindFirstChild("Unragdoll")
					if v283 then
						v283:FireServer()
					end
				elseif v_u_258 then
					v_u_258.Ragdoll:Fire(false)
					v_u_252()
				end
			end)
			task.wait(0.1)
		end
		local v284 = v_u_11:FindFirstChild("HumanoidRootPart")
		local v285 = v_u_12:FindFirstChild("HumanoidRootPart")
		local v286 = v285 and v285.CFrame or v_u_13
		local v287 = v_u_12:FindFirstChild("Animate")
		if v287 then
			v287.Parent = v_u_11
			v287.Disabled = true
		end
		v_u_12:Destroy()
		if v284 then
			v284.CFrame = v286
		end
		local v288 = v_u_11:FindFirstChildWhichIsA("Humanoid")
		v_u_152()
		v_u_7.Character = v_u_11
		if v288 then
			v_u_2.CurrentCamera.CameraSubject = v288
		end
		v_u_157()
		if v287 then
			task.wait(0.1)
			v287.Disabled = false
		end
		v_u_253 = nil
	end
end
local v_u_290 = {}
local function v_u_304()
	-- upvalues: (ref) v_u_38, (ref) v_u_12, (ref) v_u_18, (ref) v_u_14, (ref) v_u_290
	v_u_38.isRunning = false
	if v_u_12 then
		local v291, v292, v293 = pairs(v_u_18)
		while true do
			local v294
			v293, v294 = v291(v292, v293)
			if v293 == nil then
				break
			end
			if v293 and v293:IsA("Motor6D") then
				v293.C0 = v294.C0
			end
		end
		local v295 = v_u_12
		local v296, v297, v298 = pairs(v295:GetChildren())
		while true do
			local v299
			v298, v299 = v296(v297, v298)
			if v298 == nil then
				break
			end
			if v299:IsA("LocalScript") and (not v299.Enabled and v299 ~= v_u_14) then
				v299.Enabled = true
			end
		end
		if v_u_14 then
			v_u_14.Disabled = false
		end
	end
	if v_u_38.connection then
		v_u_38.connection:Disconnect()
		v_u_38.connection = nil
	end
	local v300, v301, v302 = pairs(v_u_290)
	while true do
		local v303
		v302, v303 = v300(v301, v302)
		if v302 == nil then
			break
		end
		v303.NameButton.BackgroundColor3 = Color3.new(0, 0, 0)
	end
end
local function v_u_402(p_u_305)
	-- upvalues: (ref) v_u_12, (ref) v_u_38, (ref) v_u_304, (ref) v_u_290, (ref) v_u_39, (ref) v_u_47, (ref) v_u_14, (ref) v_u_19, (ref) v_u_18, (ref) v_u_4, (ref) v_u_23
	if not v_u_12 then
		warn("Reanimate first!")
		return
	end
	if p_u_305 == "" then
		return
	end
	local v306 = v_u_12:FindFirstChildWhichIsA("Humanoid")
	if not v306 then
		return
	end
	local v307 = v_u_12:FindFirstChild("LowerTorso") ~= nil
	if not (v307 and v_u_12:FindFirstChild("LowerTorso") or v_u_12:FindFirstChild("Torso")) then
		return
	end
	if v_u_38.isRunning and v_u_38.currentId == p_u_305 then
		v_u_304()
		v_u_38.currentId = nil
		return
	end
	local v308, v309, v310 = pairs(v_u_290)
	while true do
		local v311
		v310, v311 = v308(v309, v310)
		if v310 == nil then
			break
		end
		v311.NameButton.BackgroundColor3 = Color3.new(0, 0, 0)
	end
	local v312 = { v_u_39, v_u_47 }
	local v313, v314, v315 = pairs(v312)
	local v316 = nil
	while true do
		local v317
		v315, v317 = v313(v314, v315)
		if v315 == nil then
			v320 = v316
		end
		local v318, v319, v320 = pairs(v317)
		while true do
			local v321
			v320, v321 = v318(v319, v320)
			if v320 == nil then
				v320 = v316
				break
			end
			if tostring(v321) == p_u_305 then
				break
			end
		end
		if v320 then
			break
		end
		v316 = v320
	end
	if v320 and v_u_290[v320] then
		v_u_290[v320].NameButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
	end
	if v_u_14 and (v306.MoveDirection.Magnitude > 0 or v306:GetState() == Enum.HumanoidStateType.Running) then
		v_u_14.Disabled = true
		local v322, v323, v324 = pairs(v306:GetPlayingAnimationTracks())
		while true do
			local v325
			v324, v325 = v322(v323, v324)
			if v324 == nil then
				break
			end
			v325:Stop()
		end
	end
	local v326 = v_u_19[p_u_305]
	if not v326 then
		local v327 = nil
		local v328 = nil
		if tostring(p_u_305):match("^http") then
			local v329, v_u_330 = pcall(function()
				-- upvalues: (ref) p_u_305
				return game:HttpGet(p_u_305)
			end)
			if v329 then
				local v331
				v331, v326 = pcall(function()
					-- upvalues: (ref) v_u_330
					return loadstring(v_u_330)()
				end)
				if v331 and type(v326) == "table" then
					v327 = true
				else
					v326 = v328
				end
			else
				v326 = v328
			end
		elseif tonumber(p_u_305) then
			v327, v326 = pcall(function()
				-- upvalues: (ref) p_u_305
				return game:GetObjects("rbxassetid://" .. p_u_305)[1]
			end)
		else
			local v332
			v332, v326 = pcall(function()
				-- upvalues: (ref) p_u_305
				return loadstring(p_u_305)()
			end)
			if v332 and type(v326) == "table" then
				v327 = true
			else
				v326 = v328
			end
		end
		if not (v327 and v326) then
			return
		end
		v_u_19[p_u_305] = v326
	end
	if type(v326) ~= "table" then
		v326.Priority = Enum.AnimationPriority.Action
		v_u_38.keyframes = v326:GetKeyframes()
		if not v_u_38.keyframes or #v_u_38.keyframes == 0 then
			return
		end
		v_u_38.totalDuration = v_u_38.keyframes[#v_u_38.keyframes].Time
	else
		local v333 = next(v326)
		if not v333 then
			return
		end
		v_u_38.keyframes = v326[v333]
		if not v_u_38.keyframes or #v_u_38.keyframes == 0 then
			return
		end
		v_u_38.totalDuration = v_u_38.keyframes[#v_u_38.keyframes].Time
	end
	v_u_38.currentId = p_u_305
	v_u_38.elapsedTime = 0
	v_u_38.isRunning = true
	local v334 = v_u_12
	local v335
	if v307 then
		local v336 = v334:FindFirstChild("HumanoidRootPart")
		local v337 = v334:FindFirstChild("Head")
		local v338 = v334:FindFirstChild("LeftUpperArm")
		local v339 = v334:FindFirstChild("RightUpperArm")
		local v340 = v334:FindFirstChild("LeftUpperLeg")
		local v341 = v334:FindFirstChild("RightUpperLeg")
		local v342 = v334:FindFirstChild("LeftFoot")
		local v343 = v334:FindFirstChild("RightFoot")
		local v344 = v334:FindFirstChild("LeftHand")
		local v345 = v334:FindFirstChild("RightHand")
		local v346 = v334:FindFirstChild("LeftLowerArm")
		local v347 = v334:FindFirstChild("RightLowerArm")
		local v348 = v334:FindFirstChild("LeftLowerLeg")
		local v349 = v334:FindFirstChild("RightLowerLeg")
		local v350 = v334:FindFirstChild("LowerTorso")
		local v351 = v334:FindFirstChild("UpperTorso")
		v335 = {}
		if v336 then
			v336 = v336:FindFirstChild("RootJoint")
		end
		v335.Torso = v336
		if v337 then
			v337 = v337:FindFirstChild("Neck")
		end
		v335.Head = v337
		if v338 then
			v338 = v338:FindFirstChild("LeftShoulder")
		end
		v335.LeftUpperArm = v338
		if v339 then
			v339 = v339:FindFirstChild("RightShoulder")
		end
		v335.RightUpperArm = v339
		if v340 then
			v340 = v340:FindFirstChild("LeftHip")
		end
		v335.LeftUpperLeg = v340
		if v341 then
			v341 = v341:FindFirstChild("RightHip")
		end
		v335.RightUpperLeg = v341
		if v342 then
			v342 = v342:FindFirstChild("LeftAnkle")
		end
		v335.LeftFoot = v342
		if v343 then
			v343 = v343:FindFirstChild("RightAnkle")
		end
		v335.RightFoot = v343
		if v344 then
			v344 = v344:FindFirstChild("LeftWrist")
		end
		v335.LeftHand = v344
		if v345 then
			v345 = v345:FindFirstChild("RightWrist")
		end
		v335.RightHand = v345
		if v346 then
			v346 = v346:FindFirstChild("LeftElbow")
		end
		v335.LeftLowerArm = v346
		if v347 then
			v347 = v347:FindFirstChild("RightElbow")
		end
		v335.RightLowerArm = v347
		if v348 then
			v348 = v348:FindFirstChild("LeftKnee")
		end
		v335.LeftLowerLeg = v348
		if v349 then
			v349 = v349:FindFirstChild("RightKnee")
		end
		v335.RightLowerLeg = v349
		if v350 then
			v350 = v350:FindFirstChild("Root")
		end
		v335.LowerTorso = v350
		if v351 then
			v351 = v351:FindFirstChild("Waist")
		end
		v335.UpperTorso = v351
	else
		v335 = (function(p352)
			local v353, v354, v355 = pairs(p352:GetChildren())
			local v356 = {}
			while true do
				local v357
				v355, v357 = v353(v354, v355)
				if v355 == nil then
					break
				end
				if v357:IsA("BasePart") then
					local v358, v359, v360 = pairs(v357:GetChildren())
					while true do
						local v361
						v360, v361 = v358(v359, v360)
						if v360 == nil then
							break
						end
						if v361:IsA("Motor6D") and (v361.Part1 and v361.Part1.Parent == p352) then
							local v362 = v361.Part1.Name
							v356[v362] = v361
							if v362 == "Left Arm" then
								v356.LeftArm = v361
							elseif v362 == "Right Arm" then
								v356.RightArm = v361
							elseif v362 == "Left Leg" then
								v356.LeftLeg = v361
							elseif v362 == "Right Leg" then
								v356.RightLeg = v361
							elseif v362 == "Head" then
								v356.Head = v361
							elseif v362 == "HumanoidRootPart" then
								v356.Torso = v361
							end
						end
					end
				end
			end
			return v356
		end)(v334)
	end
	local v_u_363 = {}
	if not v_u_18 then
		v_u_18 = {}
	end
	local v364, v365, v366 = pairs(v335)
	while true do
		local v367
		v366, v367 = v364(v365, v366)
		if v366 == nil then
			break
		end
		if v367 and v367:IsA("Motor6D") then
			v_u_363[v366] = v367
			if not v_u_18[v367] then
				v_u_18[v367] = {
					["C0"] = v367.C0,
					["C1"] = v367.C1
				}
			end
		end
	end
	if not v_u_38.connection then
		local v368 = v_u_12
		local v369, v370, v371 = pairs(v368:GetChildren())
		while true do
			local v372
			v371, v372 = v369(v370, v371)
			if v371 == nil then
				break
			end
			if v372:IsA("LocalScript") and (v372.Enabled and v372 ~= v_u_14) then
				v372.Enabled = false
			end
		end
		v_u_38.connection = v_u_4.Heartbeat:Connect(function(p373)
			-- upvalues: (ref) v_u_38, (ref) v_u_12, (ref) v_u_304, (ref) v_u_363, (ref) v_u_18, (ref) v_u_23
			if not (v_u_38.isRunning and v_u_12) then
				v_u_304()
				return
			end
			if not v_u_38.keyframes then
				return
			end
			v_u_38.elapsedTime = v_u_38.elapsedTime + p373 * v_u_38.speed
			if v_u_38.totalDuration > 0 then
				v_u_38.elapsedTime = v_u_38.elapsedTime % v_u_38.totalDuration
			end
			local v374 = nil
			local v375 = nil
			for v376 = 1, #v_u_38.keyframes - 1 do
				if v_u_38.elapsedTime >= v_u_38.keyframes[v376].Time then
					if v_u_38.elapsedTime < v_u_38.keyframes[v376 + 1].Time then
						v374 = v_u_38.keyframes[v376]
						v375 = v_u_38.keyframes[v376 + 1]
						break
					end
				end
			end
			if not v374 then
				v374 = v_u_38.keyframes[#v_u_38.keyframes]
				v375 = v_u_38.keyframes[1]
			end
			local v377 = v375.Time - v374.Time
			if v377 <= 0 then
				v377 = v_u_38.totalDuration
			end
			local v378 = v_u_38.elapsedTime - v374.Time
			local v379 = 0 < v377 and v378 / v377 or 0
			local v380 = math.clamp(v379, 0, 1)
			if v374.Data then
				local v381, v382, v383 = pairs(v374.Data)
				while true do
					local v384
					v383, v384 = v381(v382, v383)
					if v383 == nil then
						break
					end
					local v385 = v_u_363[v383]
					if v385 and (v_u_18 and v_u_18[v385]) then
						local v386 = v_u_18[v385].C0 * v384
						local v387 = v375.Data
						if v387 then
							v387 = v375.Data[v383]
						end
						if v387 then
							v385.C0 = v386:Lerp(v_u_18[v385].C0 * v387, v380)
						else
							v385.C0 = v386
						end
					end
				end
			else
				local v388, v389, v390 = pairs(v374:GetDescendants())
				while true do
					local v391
					v390, v391 = v388(v389, v390)
					if v390 == nil then
						break
					end
					if v391:IsA("Pose") then
						local v392 = v_u_363[v391.Name]
						if v392 and (v_u_18 and v_u_18[v392]) then
							local v393 = v_u_18[v392].C0 * v391.CFrame
							local v394 = v375:FindFirstChild(v391.Name, true)
							if v394 and v394:IsA("Pose") then
								v392.C0 = v393:Lerp(v_u_18[v392].C0 * v394.CFrame, v380)
							else
								v392.C0 = v393
							end
						end
					end
				end
			end
			if v_u_23.heightScale ~= 1 or v_u_23.widthScale ~= 1 then
				local v395, v396, v397 = pairs(v_u_18)
				while true do
					local v398
					v397, v398 = v395(v396, v397)
					if v397 == nil then
						break
					end
					if v397 and v397:IsA("Motor6D") then
						local v399 = v397.C0 - v397.C0.Position
						local v400 = v398.C0.Position
						local v401 = Vector3.new(v400.X * v_u_23.widthScale, v400.Y * v_u_23.heightScale, v400.Z * v_u_23.widthScale)
						v397.C0 = CFrame.new(v401) * v399
					end
				end
			end
		end)
	end
end
local function v_u_410(p403)
	-- upvalues: (ref) v_u_12, (ref) v_u_10, (ref) v_u_20, (ref) v_u_38, (ref) v_u_304, (ref) v_u_402
	if not (v_u_12 and v_u_10) then
		return
	end
	local v_u_404 = v_u_20[p403]
	local v405 = false
	if v_u_38.isRunning and v_u_38.currentId then
		local v406, v407, v408 = pairs(v_u_20)
		while true do
			local v409
			v408, v409 = v406(v407, v408)
			if v408 == nil then
				break
			end
			if v409 and (v409 ~= "" and tostring(v409) == tostring(v_u_38.currentId)) then
				v405 = true
				break
			end
		end
	end
	if v_u_404 and v_u_404 ~= "" then
		if v_u_12 then
			if v_u_12:FindFirstChildWhichIsA("Humanoid") then
				if v_u_38.isRunning and v_u_38.currentId then
					if not v405 then
						return
					end
					if tostring(v_u_38.currentId) == tostring(v_u_404) then
						return
					end
				end
				if v_u_38.isRunning then
					v_u_304()
					task.wait(0.05)
				end
				if v_u_12 and v_u_10 then
					pcall(function()
						-- upvalues: (ref) v_u_402, (ref) v_u_404
						v_u_402(tostring(v_u_404))
					end)
				end
			else
				return
			end
		else
			return
		end
	else
		if v405 then
			v_u_304()
		end
		return
	end
end
local function v_u_441()
	-- upvalues: (ref) v_u_12, (ref) v_u_10, (ref) v_u_22, (ref) v_u_38, (ref) v_u_20, (ref) v_u_304, (ref) v_u_410, (ref) v_u_4, (ref) v_u_23, (ref) v_u_18
	if not (v_u_12 and v_u_10) then
		return
	end
	if not v_u_12:FindFirstChildWhichIsA("Humanoid") then
		return
	end
	local v411, v412, v413 = pairs(v_u_22)
	while true do
		local v414, v_u_415 = v411(v412, v413)
		if v414 == nil then
			break
		end
		v413 = v414
		if v_u_415 then
			pcall(function()
				-- upvalues: (ref) v_u_415
				v_u_415:Disconnect()
			end)
		end
	end
	v_u_22 = {}
	if v_u_38.isRunning and v_u_38.currentId then
		local v416, v417, v418 = pairs(v_u_20)
		while true do
			local v419
			v418, v419 = v416(v417, v418)
			if v418 == nil then
				break
			end
			if v419 and (v419 ~= "" and tostring(v419) == tostring(v_u_38.currentId)) then
				v_u_304()
				break
			end
		end
	end
	local function v_u_424()
		-- upvalues: (ref) v_u_12
		if not v_u_12 then
			return "idle"
		end
		local v_u_420 = v_u_12:FindFirstChildWhichIsA("Humanoid")
		if not v_u_420 then
			return "idle"
		end
		local v421 = v_u_420.MoveDirection.Magnitude
		local v422, v423 = pcall(function()
			-- upvalues: (ref) v_u_420
			return v_u_420:GetState()
		end)
		return v422 and ((v423 == Enum.HumanoidStateType.Jumping or v423 == Enum.HumanoidStateType.Freefall) and "jumping" or (0.1 < v421 and "walking" or "idle")) or "idle"
	end
	local v_u_425 = v_u_424()
	local v_u_426 = v_u_425
	local v_u_427 = v_u_425
	if v_u_20[v_u_425] and v_u_20[v_u_425] ~= "" then
		task.defer(function()
			-- upvalues: (ref) v_u_12, (ref) v_u_10, (ref) v_u_410, (ref) v_u_425
			if v_u_12 and v_u_10 then
				v_u_410(v_u_425)
			end
		end)
	end
	v_u_22.stateMonitor = v_u_4.Heartbeat:Connect(function(_)
		-- upvalues: (ref) v_u_12, (ref) v_u_10, (ref) v_u_22, (ref) v_u_424, (ref) v_u_427, (ref) v_u_38, (ref) v_u_20, (ref) v_u_304, (ref) v_u_410, (ref) v_u_426, (ref) v_u_23, (ref) v_u_18
		if not (v_u_12 and v_u_10) then
			if v_u_22.stateMonitor then
				pcall(function()
					-- upvalues: (ref) v_u_22
					v_u_22.stateMonitor:Disconnect()
				end)
				v_u_22.stateMonitor = nil
			end
			return
		end
		if not v_u_12:FindFirstChildWhichIsA("Humanoid") then
			if v_u_22.stateMonitor then
				pcall(function()
					-- upvalues: (ref) v_u_22
					v_u_22.stateMonitor:Disconnect()
				end)
				v_u_22.stateMonitor = nil
			end
			return
		end
		local v_u_428 = v_u_424()
		if v_u_428 ~= v_u_427 then
			v_u_427 = v_u_428
			local v429 = false
			if v_u_38.isRunning and v_u_38.currentId then
				local v430, v431, v432 = pairs(v_u_20)
				while true do
					local v433
					v432, v433 = v430(v431, v432)
					if v432 == nil then
						break
					end
					if v433 and (v433 ~= "" and tostring(v433) == tostring(v_u_38.currentId)) then
						v429 = true
						break
					end
				end
			end
			if v429 then
				v_u_304()
			end
			if v_u_20[v_u_428] and (v_u_20[v_u_428] ~= "" and (v_u_12 and v_u_10)) then
				task.defer(function()
					-- upvalues: (ref) v_u_12, (ref) v_u_10, (ref) v_u_410, (ref) v_u_428
					if v_u_12 and v_u_10 then
						v_u_410(v_u_428)
					end
				end)
			end
		end
		v_u_426 = v_u_428
		if (v_u_23.heightScale ~= 1 or v_u_23.widthScale ~= 1) and v_u_18 then
			local v434, v435, v436 = pairs(v_u_18)
			while true do
				local v437
				v436, v437 = v434(v435, v436)
				if v436 == nil then
					break
				end
				if v436 and (v436:IsA("Motor6D") and v436.Parent) then
					local v438 = v436.C0 - v436.C0.Position
					local v439 = v437.C0.Position
					local v440 = Vector3.new(v439.X * v_u_23.widthScale, v439.Y * v_u_23.heightScale, v439.Z * v_u_23.widthScale)
					v436.C0 = CFrame.new(v440) * v438
				end
			end
		end
	end)
end
local function v_u_773()
	-- upvalues: (ref) v_u_7, (ref) v_u_6, (ref) v_u_289, (ref) v_u_10, (ref) v_u_12, (ref) v_u_441, (ref) v_u_20, (ref) v_u_39, (ref) v_u_122, (ref) v_u_22, (ref) v_u_38, (ref) v_u_304, (ref) v_u_23, (ref) v_u_246, (ref) v_u_3, (ref) v_u_11, (ref) v_u_26, (ref) v_u_33, (ref) v_u_34, (ref) v_u_35, (ref) v_u_27, (ref) v_u_30, (ref) v_u_52, (ref) v_u_111, (ref) v_u_49, (ref) v_u_47, (ref) v_u_48, (ref) v_u_402, (ref) v_u_135, (ref) v_u_96, (ref) v_u_79, (ref) v_u_290
	local v442 = v_u_7:WaitForChild("PlayerGui")
	if not v442:FindFirstChild("AKReanimGUI") then
		local v_u_443 = Instance.new("ScreenGui")
		v_u_443.Name = "AKReanimGUI"
		v_u_443.ResetOnSpawn = false
		v_u_443.Parent = v442
		local v_u_444 = Instance.new("Frame")
		v_u_444.Size = UDim2.new(0, 280, 0, 395)
		v_u_444.Position = UDim2.new(0.5, -140, 0.5, -197.5)
		v_u_444.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_444.BackgroundTransparency = 0.6
		v_u_444.BorderSizePixel = 0
		v_u_444.Parent = v_u_443
		local v445 = Instance.new("UICorner")
		v445.CornerRadius = UDim.new(0, 15)
		v445.Parent = v_u_444
		local v446 = Instance.new("Frame")
		v446.Size = UDim2.new(1, 0, 0, 30)
		v446.Position = UDim2.new(0, 0, 0, 0)
		v446.BackgroundTransparency = 1
		v446.BorderSizePixel = 0
		v446.Parent = v_u_444
		local v447 = Instance.new("TextLabel")
		v447.Size = UDim2.new(1, -100, 1, 0)
		v447.Position = UDim2.new(0, 50, 0, 0)
		v447.BackgroundTransparency = 1
		v447.Text = "AK REANIMATION"
		v447.TextColor3 = Color3.new(1, 1, 1)
		v447.TextSize = 16
		v447.Font = Enum.Font.Gotham
		v447.TextXAlignment = Enum.TextXAlignment.Center
		v447.Parent = v446
		local v_u_448 = Instance.new("Frame")
		v_u_448.Size = UDim2.new(0, 40, 0, 18)
		v_u_448.Position = UDim2.new(0, 6, 0, 6)
		v_u_448.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
		v_u_448.BorderSizePixel = 0
		v_u_448.Parent = v446
		local v449 = Instance.new("UICorner")
		v449.CornerRadius = UDim.new(0, 9)
		v449.Parent = v_u_448
		local v_u_450 = Instance.new("Frame")
		v_u_450.Size = UDim2.new(0, 14, 0, 14)
		v_u_450.Position = UDim2.new(0, 2, 0, 2)
		v_u_450.BackgroundColor3 = Color3.new(0.7, 0.7, 0.7)
		v_u_450.BorderSizePixel = 0
		v_u_450.Parent = v_u_448
		local v451 = Instance.new("UICorner")
		v451.CornerRadius = UDim.new(0, 7)
		v451.Parent = v_u_450
		local v452 = Instance.new("TextButton")
		v452.Size = UDim2.new(1, 0, 1, 0)
		v452.BackgroundTransparency = 1
		v452.Text = ""
		v452.Parent = v_u_448
		local v_u_453 = false
		local v_u_454 = false
		local v_u_455 = 0
		v452.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_454, (ref) v_u_455, (ref) v_u_453, (ref) v_u_6, (ref) v_u_448, (ref) v_u_450, (ref) v_u_289, (ref) v_u_10, (ref) v_u_12, (ref) v_u_441
			if v_u_454 then
				return
			else
				local v456 = tick()
				if v456 - v_u_455 >= 3 then
					v_u_454 = true
					v_u_455 = v456
					v_u_453 = not v_u_453
					local v457 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
					if v_u_453 then
						v_u_6:Create(v_u_448, v457, {
							["BackgroundColor3"] = Color3.fromRGB(0, 150, 255)
						}):Play()
						v_u_6:Create(v_u_450, v457, {
							["Position"] = UDim2.new(1, -16, 0, 2),
							["BackgroundColor3"] = Color3.new(1, 1, 1)
						}):Play()
					else
						v_u_6:Create(v_u_448, v457, {
							["BackgroundColor3"] = Color3.new(0.2, 0.2, 0.2)
						}):Play()
						v_u_6:Create(v_u_450, v457, {
							["Position"] = UDim2.new(0, 2, 0, 2),
							["BackgroundColor3"] = Color3.new(0.7, 0.7, 0.7)
						}):Play()
					end
					v_u_289(v_u_453)
					if v_u_453 then
						spawn(function()
							-- upvalues: (ref) v_u_10, (ref) v_u_12, (ref) v_u_441
							wait(0.3)
							if v_u_10 and v_u_12 then
								v_u_441()
							end
						end)
					end
					spawn(function()
						-- upvalues: (ref) v_u_454
						wait(3)
						v_u_454 = false
					end)
				end
			end
		end)
		local v_u_458 = Instance.new("TextButton")
		v_u_458.Size = UDim2.new(0, 22, 0, 22)
		v_u_458.Position = UDim2.new(1, -48, 0, 4)
		v_u_458.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_458.BackgroundTransparency = 0.7
		v_u_458.Text = "\226\136\146"
		v_u_458.TextColor3 = Color3.new(1, 1, 1)
		v_u_458.TextScaled = true
		v_u_458.Font = Enum.Font.Gotham
		v_u_458.BorderSizePixel = 0
		v_u_458.Parent = v446
		local v459 = Instance.new("UICorner")
		v459.CornerRadius = UDim.new(0, 10)
		v459.Parent = v_u_458
		local v460 = Instance.new("TextButton")
		v460.Size = UDim2.new(0, 22, 0, 22)
		v460.Position = UDim2.new(1, -24, 0, 4)
		v460.BackgroundColor3 = Color3.new(0, 0, 0)
		v460.BackgroundTransparency = 0.7
		v460.Text = "\195\151"
		v460.TextColor3 = Color3.new(1, 1, 1)
		v460.TextScaled = true
		v460.Font = Enum.Font.Gotham
		v460.BorderSizePixel = 0
		v460.Parent = v446
		local v461 = Instance.new("UICorner")
		v461.CornerRadius = UDim.new(0, 10)
		v461.Parent = v460
		local v_u_462 = Instance.new("TextLabel")
		v_u_462.Size = UDim2.new(1, -16, 0, 12)
		v_u_462.Position = UDim2.new(0, 8, 0, 32)
		v_u_462.BackgroundTransparency = 1
		v_u_462.Text = "Ready"
		v_u_462.TextColor3 = Color3.new(0.7, 0.7, 0.7)
		v_u_462.TextSize = 10
		v_u_462.Font = Enum.Font.Gotham
		v_u_462.Parent = v_u_444
		local v463 = Instance.new("Frame")
		v463.Size = UDim2.new(1, -16, 0, 25)
		v463.Position = UDim2.new(0, 8, 0, 48)
		v463.BackgroundTransparency = 1
		v463.Parent = v_u_444
		local v_u_464 = Instance.new("TextButton")
		v_u_464.Size = UDim2.new(0.166, -2, 1, 0)
		v_u_464.Position = UDim2.new(0, 0, 0, 0)
		v_u_464.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_464.BackgroundTransparency = 0.5
		v_u_464.Text = "All"
		v_u_464.TextColor3 = Color3.new(1, 1, 1)
		v_u_464.TextSize = 11
		v_u_464.Font = Enum.Font.Gotham
		v_u_464.BorderSizePixel = 0
		v_u_464.Parent = v463
		local v_u_465 = Instance.new("TextButton")
		v_u_465.Size = UDim2.new(0.166, -2, 1, 0)
		v_u_465.Position = UDim2.new(0.166, 2, 0, 0)
		v_u_465.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_465.BackgroundTransparency = 0.8
		v_u_465.Text = "Favs"
		v_u_465.TextColor3 = Color3.new(1, 1, 1)
		v_u_465.TextSize = 11
		v_u_465.Font = Enum.Font.Gotham
		v_u_465.BorderSizePixel = 0
		v_u_465.Parent = v463
		local v_u_466 = Instance.new("TextButton")
		v_u_466.Size = UDim2.new(0.166, -2, 1, 0)
		v_u_466.Position = UDim2.new(0.332, 4, 0, 0)
		v_u_466.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_466.BackgroundTransparency = 0.8
		v_u_466.Text = "Custom"
		v_u_466.TextColor3 = Color3.new(1, 1, 1)
		v_u_466.TextSize = 11
		v_u_466.Font = Enum.Font.Gotham
		v_u_466.BorderSizePixel = 0
		v_u_466.Parent = v463
		local v_u_467 = Instance.new("TextButton")
		v_u_467.Size = UDim2.new(0.166, -2, 1, 0)
		v_u_467.Position = UDim2.new(0.498, 6, 0, 0)
		v_u_467.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_467.BackgroundTransparency = 0.8
		v_u_467.Text = "States"
		v_u_467.TextColor3 = Color3.new(1, 1, 1)
		v_u_467.TextSize = 11
		v_u_467.Font = Enum.Font.Gotham
		v_u_467.BorderSizePixel = 0
		v_u_467.Parent = v463
		local v_u_468 = Instance.new("TextButton")
		v_u_468.Size = UDim2.new(0.166, -2, 1, 0)
		v_u_468.Position = UDim2.new(0.664, 8, 0, 0)
		v_u_468.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_468.BackgroundTransparency = 0.8
		v_u_468.Text = "Size"
		v_u_468.TextColor3 = Color3.new(1, 1, 1)
		v_u_468.TextSize = 11
		v_u_468.Font = Enum.Font.Gotham
		v_u_468.BorderSizePixel = 0
		v_u_468.Parent = v463
		local v469 = Instance.new("UICorner")
		v469.CornerRadius = UDim.new(0, 10)
		v469.Parent = v_u_468
		local v_u_470 = Instance.new("TextButton")
		v_u_470.Size = UDim2.new(0.166, -2, 1, 0)
		v_u_470.Position = UDim2.new(0.83, 10, 0, 0)
		v_u_470.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_470.BackgroundTransparency = 0.8
		v_u_470.Text = "Others"
		v_u_470.TextColor3 = Color3.new(1, 1, 1)
		v_u_470.TextSize = 11
		v_u_470.Font = Enum.Font.Gotham
		v_u_470.BorderSizePixel = 0
		v_u_470.Parent = v463
		local v471 = Instance.new("UICorner")
		v471.CornerRadius = UDim.new(0, 10)
		v471.Parent = v_u_470
		local v472 = Instance.new("UICorner")
		v472.CornerRadius = UDim.new(0, 10)
		v472.Parent = v_u_464
		local v473 = Instance.new("UICorner")
		v473.CornerRadius = UDim.new(0, 10)
		v473.Parent = v_u_465
		local v474 = Instance.new("UICorner")
		v474.CornerRadius = UDim.new(0, 10)
		v474.Parent = v_u_466
		local v475 = Instance.new("UICorner")
		v475.CornerRadius = UDim.new(0, 10)
		v475.Parent = v_u_467
		local v_u_476 = Instance.new("TextBox")
		v_u_476.Size = UDim2.new(1, -16, 0, 22)
		v_u_476.Position = UDim2.new(0, 8, 0, 78)
		v_u_476.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_476.BackgroundTransparency = 0.5
		v_u_476.Text = ""
		v_u_476.PlaceholderText = "Search..."
		v_u_476.TextColor3 = Color3.new(1, 1, 1)
		v_u_476.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
		v_u_476.TextSize = 11
		v_u_476.Font = Enum.Font.Gotham
		v_u_476.BorderSizePixel = 0
		v_u_476.Parent = v_u_444
		local v477 = Instance.new("UICorner")
		v477.CornerRadius = UDim.new(0, 10)
		v477.Parent = v_u_476
		local v_u_478 = Instance.new("ScrollingFrame")
		v_u_478.Size = UDim2.new(1, -16, 1, -175)
		v_u_478.Position = UDim2.new(0, 8, 0, 105)
		v_u_478.BackgroundTransparency = 1
		v_u_478.ScrollBarThickness = 4
		v_u_478.ScrollBarImageColor3 = Color3.new(1, 1, 1)
		v_u_478.ScrollBarImageTransparency = 0.5
		v_u_478.BorderSizePixel = 0
		v_u_478.ScrollingDirection = Enum.ScrollingDirection.Y
		v_u_478.Parent = v_u_444
		local v_u_479 = Instance.new("UIListLayout")
		v_u_479.Padding = UDim.new(0, 3)
		v_u_479.SortOrder = Enum.SortOrder.LayoutOrder
		v_u_479.Parent = v_u_478
		local v_u_480 = Instance.new("Frame")
		v_u_480.Size = UDim2.new(1, -16, 0, 80)
		v_u_480.Position = UDim2.new(0, 8, 0, 105)
		v_u_480.BackgroundTransparency = 1
		v_u_480.Visible = false
		v_u_480.Parent = v_u_444
		local v_u_481 = Instance.new("TextBox")
		v_u_481.Size = UDim2.new(1, 0, 0, 22)
		v_u_481.Position = UDim2.new(0, 0, 0, 0)
		v_u_481.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_481.BackgroundTransparency = 0.5
		v_u_481.Text = ""
		v_u_481.PlaceholderText = "Animation Name..."
		v_u_481.TextColor3 = Color3.new(1, 1, 1)
		v_u_481.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
		v_u_481.TextSize = 11
		v_u_481.Font = Enum.Font.Gotham
		v_u_481.BorderSizePixel = 0
		v_u_481.Parent = v_u_480
		local v482 = Instance.new("UICorner")
		v482.CornerRadius = UDim.new(0, 10)
		v482.Parent = v_u_481
		local v_u_483 = Instance.new("TextBox")
		v_u_483.Size = UDim2.new(1, 0, 0, 45)
		v_u_483.Position = UDim2.new(0, 0, 0, 27)
		v_u_483.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_483.BackgroundTransparency = 0.5
		v_u_483.Text = ""
		v_u_483.PlaceholderText = "Keyframe Code..."
		v_u_483.TextColor3 = Color3.new(1, 1, 1)
		v_u_483.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
		v_u_483.TextSize = 9
		v_u_483.Font = Enum.Font.Code
		v_u_483.TextWrapped = true
		v_u_483.TextXAlignment = Enum.TextXAlignment.Left
		v_u_483.TextYAlignment = Enum.TextYAlignment.Top
		v_u_483.ClearTextOnFocus = false
		v_u_483.MultiLine = true
		v_u_483.BorderSizePixel = 0
		v_u_483.Parent = v_u_480
		local v484 = Instance.new("UICorner")
		v484.CornerRadius = UDim.new(0, 10)
		v484.Parent = v_u_483
		local v_u_485 = Instance.new("Frame")
		v_u_485.Size = UDim2.new(1, -16, 1, -175)
		v_u_485.Position = UDim2.new(0, 8, 0, 105)
		v_u_485.BackgroundTransparency = 1
		v_u_485.Visible = false
		v_u_485.Parent = v_u_444
		local v_u_486 = Instance.new("ScrollingFrame")
		v_u_486.Size = UDim2.new(1, 0, 1, 0)
		v_u_486.Position = UDim2.new(0, 0, 0, 0)
		v_u_486.BackgroundTransparency = 1
		v_u_486.ScrollBarThickness = 4
		v_u_486.ScrollBarImageColor3 = Color3.new(1, 1, 1)
		v_u_486.ScrollBarImageTransparency = 0.5
		v_u_486.BorderSizePixel = 0
		v_u_486.Parent = v_u_485
		local v_u_487 = Instance.new("UIListLayout")
		v_u_487.Padding = UDim.new(0, 10)
		v_u_487.SortOrder = Enum.SortOrder.LayoutOrder
		v_u_487.Parent = v_u_486
		local function v547(p_u_488, p_u_489, p490)
			-- upvalues: (ref) v_u_486, (ref) v_u_20, (ref) v_u_39, (ref) v_u_122, (ref) v_u_462, (ref) v_u_10, (ref) v_u_22, (ref) v_u_38, (ref) v_u_304, (ref) v_u_441
			local v491 = Instance.new("Frame")
			v491.Size = UDim2.new(1, 0, 0, 110)
			v491.BackgroundColor3 = Color3.new(0, 0, 0)
			v491.BackgroundTransparency = 0.7
			v491.BorderSizePixel = 0
			v491.LayoutOrder = p490
			v491.Parent = v_u_486
			local v492 = Instance.new("UICorner")
			v492.CornerRadius = UDim.new(0, 10)
			v492.Parent = v491
			local v493 = Instance.new("TextLabel")
			v493.Size = UDim2.new(1, -10, 0, 20)
			v493.Position = UDim2.new(0, 5, 0, 5)
			v493.BackgroundTransparency = 1
			v493.Text = p_u_489
			v493.TextColor3 = Color3.new(1, 1, 1)
			v493.TextSize = 12
			v493.Font = Enum.Font.GothamBold
			v493.TextXAlignment = Enum.TextXAlignment.Left
			v493.Parent = v491
			local v_u_494 = Instance.new("TextButton")
			v_u_494.Size = UDim2.new(1, -10, 0, 25)
			v_u_494.Position = UDim2.new(0, 5, 0, 30)
			v_u_494.BackgroundColor3 = Color3.new(0, 0, 0)
			v_u_494.BackgroundTransparency = 0.5
			local v495 = "Select Animation..."
			local v496
			if v_u_20[p_u_488] and v_u_20[p_u_488] ~= "" then
				local v497, v498
				v497, v498, v496 = pairs(v_u_39)
				while true do
					local v499
					v496, v499 = v497(v498, v496)
					if v496 == nil then
						v496 = v495
						break
					end
					if tostring(v499) == tostring(v_u_20[p_u_488]) then
						break
					end
				end
				if v496 == "Select Animation..." then
					v496 = "Custom Keyframes"
				end
			else
				v496 = v495
			end
			v_u_494.Text = v496
			v_u_494.TextColor3 = Color3.new(1, 1, 1)
			v_u_494.TextSize = 10
			v_u_494.Font = Enum.Font.Gotham
			v_u_494.TextXAlignment = Enum.TextXAlignment.Left
			v_u_494.BorderSizePixel = 0
			v_u_494.Parent = v491
			local v500 = Instance.new("UICorner")
			v500.CornerRadius = UDim.new(0, 8)
			v500.Parent = v_u_494
			local v501 = Instance.new("UIPadding")
			v501.PaddingLeft = UDim.new(0, 8)
			v501.Parent = v_u_494
			local v_u_502 = Instance.new("TextBox")
			v_u_502.Size = UDim2.new(1, -10, 0, 40)
			v_u_502.Position = UDim2.new(0, 5, 0, 60)
			v_u_502.BackgroundColor3 = Color3.new(0, 0, 0)
			v_u_502.BackgroundTransparency = 0.5
			v_u_502.Text = ""
			v_u_502.PlaceholderText = "Or paste keyframe code..."
			v_u_502.TextColor3 = Color3.new(1, 1, 1)
			v_u_502.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
			v_u_502.TextSize = 9
			v_u_502.Font = Enum.Font.Code
			v_u_502.TextWrapped = true
			v_u_502.TextXAlignment = Enum.TextXAlignment.Left
			v_u_502.TextYAlignment = Enum.TextYAlignment.Top
			v_u_502.ClearTextOnFocus = false
			v_u_502.MultiLine = true
			v_u_502.BorderSizePixel = 0
			v_u_502.Parent = v491
			local v503 = Instance.new("UICorner")
			v503.CornerRadius = UDim.new(0, 8)
			v503.Parent = v_u_502
			local v_u_504 = false
			local v_u_505 = nil
			v_u_494.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_504, (ref) v_u_505, (ref) v_u_494, (ref) v_u_20, (ref) p_u_488, (ref) v_u_122, (ref) v_u_502, (ref) v_u_462, (ref) p_u_489, (ref) v_u_10, (ref) v_u_22, (ref) v_u_38, (ref) v_u_304, (ref) v_u_441, (ref) v_u_39
				if v_u_504 then
					if v_u_505 then
						v_u_505:Destroy()
					end
					v_u_504 = false
				else
					v_u_504 = true
					v_u_505 = Instance.new("Frame")
					v_u_505.Size = UDim2.new(1, 0, 0, 180)
					v_u_505.Position = UDim2.new(0, 0, 1, 2)
					v_u_505.BackgroundColor3 = Color3.new(0, 0, 0)
					v_u_505.BackgroundTransparency = 0.3
					v_u_505.BorderSizePixel = 0
					v_u_505.ZIndex = 10
					v_u_505.Parent = v_u_494
					local v506 = Instance.new("UICorner")
					v506.CornerRadius = UDim.new(0, 8)
					v506.Parent = v_u_505
					local v_u_507 = Instance.new("TextBox")
					v_u_507.Size = UDim2.new(1, -8, 0, 22)
					v_u_507.Position = UDim2.new(0, 4, 0, 4)
					v_u_507.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
					v_u_507.BackgroundTransparency = 0.3
					v_u_507.Text = ""
					v_u_507.PlaceholderText = "Search..."
					v_u_507.TextColor3 = Color3.new(1, 1, 1)
					v_u_507.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
					v_u_507.TextSize = 10
					v_u_507.Font = Enum.Font.Gotham
					v_u_507.BorderSizePixel = 0
					v_u_507.ZIndex = 10
					v_u_507.ClearTextOnFocus = false
					v_u_507.Parent = v_u_505
					local v508 = Instance.new("UICorner")
					v508.CornerRadius = UDim.new(0, 6)
					v508.Parent = v_u_507
					local v_u_509 = Instance.new("ScrollingFrame")
					v_u_509.Size = UDim2.new(1, -4, 1, -30)
					v_u_509.Position = UDim2.new(0, 2, 0, 28)
					v_u_509.BackgroundTransparency = 1
					v_u_509.ScrollBarThickness = 3
					v_u_509.ScrollBarImageColor3 = Color3.new(1, 1, 1)
					v_u_509.ScrollBarImageTransparency = 0.5
					v_u_509.BorderSizePixel = 0
					v_u_509.ZIndex = 10
					v_u_509.Parent = v_u_505
					local v_u_510 = Instance.new("UIListLayout")
					v_u_510.Padding = UDim.new(0, 2)
					v_u_510.SortOrder = Enum.SortOrder.Name
					v_u_510.Parent = v_u_509
					local v_u_511 = {}
					local function v_u_540()
						-- upvalues: (ref) v_u_511, (ref) v_u_507, (ref) v_u_509, (ref) v_u_20, (ref) p_u_488, (ref) v_u_122, (ref) v_u_494, (ref) v_u_502, (ref) v_u_505, (ref) v_u_504, (ref) v_u_462, (ref) p_u_489, (ref) v_u_10, (ref) v_u_22, (ref) v_u_38, (ref) v_u_304, (ref) v_u_441, (ref) v_u_39, (ref) v_u_510
						local v512, v513, v514 = pairs(v_u_511)
						while true do
							local v515
							v514, v515 = v512(v513, v514)
							if v514 == nil then
								break
							end
							v515:Destroy()
						end
						v_u_511 = {}
						local v516 = v_u_507.Text:lower()
						local v517 = Instance.new("TextButton")
						v517.Size = UDim2.new(1, 0, 0, 22)
						v517.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
						v517.BackgroundTransparency = 0.3
						v517.Text = " [None]"
						v517.TextColor3 = Color3.new(1, 0.5, 0.5)
						v517.TextSize = 10
						v517.Font = Enum.Font.GothamBold
						v517.TextXAlignment = Enum.TextXAlignment.Left
						v517.BorderSizePixel = 0
						v517.ZIndex = 10
						v517.LayoutOrder = -1
						v517.Parent = v_u_509
						table.insert(v_u_511, v517)
						v517.MouseButton1Click:Connect(function()
							-- upvalues: (ref) v_u_20, (ref) p_u_488, (ref) v_u_122, (ref) v_u_494, (ref) v_u_502, (ref) v_u_505, (ref) v_u_504, (ref) v_u_462, (ref) p_u_489, (ref) v_u_10, (ref) v_u_22, (ref) v_u_38, (ref) v_u_304, (ref) v_u_441
							v_u_20[p_u_488] = ""
							v_u_122()
							v_u_494.Text = "Select Animation..."
							v_u_502.Text = ""
							if v_u_505 then
								v_u_505:Destroy()
							end
							v_u_504 = false
							v_u_462.Text = p_u_489 .. " cleared"
							v_u_462.TextColor3 = Color3.new(1, 0.7, 0.3)
							spawn(function()
								-- upvalues: (ref) v_u_462
								wait(2)
								v_u_462.Text = "Ready"
								v_u_462.TextColor3 = Color3.new(0.7, 0.7, 0.7)
							end)
							if v_u_10 then
								local v518, v519, v520 = pairs(v_u_22)
								while true do
									local v_u_521
									v520, v_u_521 = v518(v519, v520)
									if v520 == nil then
										break
									end
									if v_u_521 then
										pcall(function()
											-- upvalues: (ref) v_u_521
											v_u_521:Disconnect()
										end)
									end
								end
								v_u_22 = {}
								if v_u_38.isRunning then
									v_u_304()
								end
								task.wait(0.1)
								if v_u_10 then
									v_u_441()
								end
							end
						end)
						local v522, v523, v524 = pairs(v_u_39)
						local v525 = {}
						local v526 = 0
						local v527 = 50
						while true do
							local v528
							v524, v528 = v522(v523, v524)
							if v524 == nil then
								break
							end
							if v516 == "" or v524:lower():find(v516, 1, true) then
								table.insert(v525, {
									["name"] = v524,
									["id"] = v528
								})
								v526 = v526 + 1
								if v527 <= v526 then
									break
								end
							end
						end
						table.sort(v525, function(p529, p530)
							return p529.name < p530.name
						end)
						local v531, v532, v533 = ipairs(v525)
						while true do
							local v_u_534
							v533, v_u_534 = v531(v532, v533)
							if v533 == nil then
								break
							end
							local v535 = Instance.new("TextButton")
							v535.Size = UDim2.new(1, 0, 0, 22)
							v535.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
							v535.BackgroundTransparency = 0.3
							v535.Text = " " .. v_u_534.name
							v535.TextColor3 = Color3.new(1, 1, 1)
							v535.TextSize = 10
							v535.Font = Enum.Font.Gotham
							v535.TextXAlignment = Enum.TextXAlignment.Left
							v535.BorderSizePixel = 0
							v535.ZIndex = 10
							v535.Parent = v_u_509
							table.insert(v_u_511, v535)
							v535.MouseButton1Click:Connect(function()
								-- upvalues: (ref) v_u_20, (ref) p_u_488, (ref) v_u_534, (ref) v_u_122, (ref) v_u_494, (ref) v_u_502, (ref) v_u_505, (ref) v_u_504, (ref) v_u_462, (ref) p_u_489, (ref) v_u_10, (ref) v_u_22, (ref) v_u_38, (ref) v_u_304, (ref) v_u_441
								v_u_20[p_u_488] = tostring(v_u_534.id)
								v_u_122()
								v_u_494.Text = v_u_534.name
								v_u_502.Text = ""
								if v_u_505 then
									v_u_505:Destroy()
								end
								v_u_504 = false
								v_u_462.Text = p_u_489 .. " set to " .. v_u_534.name
								v_u_462.TextColor3 = Color3.new(0.5, 1, 0.5)
								spawn(function()
									-- upvalues: (ref) v_u_462
									wait(2)
									v_u_462.Text = "Ready"
									v_u_462.TextColor3 = Color3.new(0.7, 0.7, 0.7)
								end)
								if v_u_10 then
									local v536, v537, v538 = pairs(v_u_22)
									while true do
										local v_u_539
										v538, v_u_539 = v536(v537, v538)
										if v538 == nil then
											break
										end
										if v_u_539 then
											pcall(function()
												-- upvalues: (ref) v_u_539
												v_u_539:Disconnect()
											end)
										end
									end
									v_u_22 = {}
									if v_u_38.isRunning then
										v_u_304()
									end
									task.wait(0.1)
									if v_u_10 then
										v_u_441()
									end
								end
							end)
						end
						task.defer(function()
							-- upvalues: (ref) v_u_509, (ref) v_u_510
							v_u_509.CanvasSize = UDim2.new(0, 0, 0, v_u_510.AbsoluteContentSize.Y)
						end)
					end
					v_u_540()
					local v_u_541 = false
					local v542 = v_u_507
					v_u_507.GetPropertyChangedSignal(v542, "Text"):Connect(function()
						-- upvalues: (ref) v_u_541, (ref) v_u_540
						if not v_u_541 then
							v_u_541 = true
							task.wait(0.2)
							v_u_540()
							v_u_541 = false
						end
					end)
				end
			end)
			v_u_502.FocusLost:Connect(function(_)
				-- upvalues: (ref) v_u_502, (ref) v_u_20, (ref) p_u_488, (ref) v_u_122, (ref) v_u_494, (ref) v_u_462, (ref) p_u_489, (ref) v_u_10, (ref) v_u_22, (ref) v_u_38, (ref) v_u_304, (ref) v_u_441
				if v_u_502.Text ~= "" then
					v_u_20[p_u_488] = v_u_502.Text
					v_u_122()
					v_u_494.Text = "Custom Keyframes"
					v_u_462.Text = p_u_489 .. " set to custom keyframes"
					v_u_462.TextColor3 = Color3.new(0.5, 1, 0.5)
					spawn(function()
						-- upvalues: (ref) v_u_462
						wait(2)
						v_u_462.Text = "Ready"
						v_u_462.TextColor3 = Color3.new(0.7, 0.7, 0.7)
					end)
					if v_u_10 then
						local v543, v544, v545 = pairs(v_u_22)
						while true do
							local v_u_546
							v545, v_u_546 = v543(v544, v545)
							if v545 == nil then
								break
							end
							if v_u_546 then
								pcall(function()
									-- upvalues: (ref) v_u_546
									v_u_546:Disconnect()
								end)
							end
						end
						v_u_22 = {}
						if v_u_38.isRunning then
							v_u_304()
						end
						task.wait(0.1)
						if v_u_10 then
							v_u_441()
						end
					end
				end
			end)
		end
		v547("idle", "IDLE Animation", 1)
		v547("walking", "WALKING Animation", 2)
		v547("jumping", "JUMPING Animation", 3)
		spawn(function()
			-- upvalues: (ref) v_u_486, (ref) v_u_487
			wait(0.1)
			v_u_486.CanvasSize = UDim2.new(0, 0, 0, v_u_487.AbsoluteContentSize.Y + 10)
		end)
		local v_u_548 = Instance.new("Frame")
		v_u_548.Size = UDim2.new(1, -16, 1, -175)
		v_u_548.Position = UDim2.new(0, 8, 0, 105)
		v_u_548.BackgroundTransparency = 1
		v_u_548.Visible = false
		v_u_548.Parent = v_u_444
		local v_u_549 = Instance.new("TextLabel")
		v_u_549.Size = UDim2.new(1, 0, 0, 25)
		v_u_549.Position = UDim2.new(0, 0, 0, 10)
		v_u_549.BackgroundTransparency = 1
		v_u_549.Text = "Height: 1.00x"
		v_u_549.TextColor3 = Color3.new(1, 1, 1)
		v_u_549.TextSize = 12
		v_u_549.Font = Enum.Font.GothamBold
		v_u_549.TextXAlignment = Enum.TextXAlignment.Left
		v_u_549.Parent = v_u_548
		local v_u_550 = Instance.new("Frame")
		v_u_550.Size = UDim2.new(1, -20, 0, 6)
		v_u_550.Position = UDim2.new(0, 10, 0, 45)
		v_u_550.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_550.BackgroundTransparency = 0.5
		v_u_550.BorderSizePixel = 0
		v_u_550.Parent = v_u_548
		local v551 = Instance.new("UICorner")
		v551.CornerRadius = UDim.new(0, 3)
		v551.Parent = v_u_550
		local v_u_552 = Instance.new("Frame")
		v_u_552.Size = UDim2.new(0, 14, 0, 14)
		v_u_552.Position = UDim2.new(0.5, -7, 0.5, -7)
		v_u_552.BackgroundColor3 = Color3.new(1, 1, 1)
		v_u_552.BackgroundTransparency = 0.2
		v_u_552.BorderSizePixel = 0
		v_u_552.Parent = v_u_550
		local v553 = Instance.new("UICorner")
		v553.CornerRadius = UDim.new(0, 7)
		v553.Parent = v_u_552
		local v_u_554 = Instance.new("TextLabel")
		v_u_554.Size = UDim2.new(1, 0, 0, 25)
		v_u_554.Position = UDim2.new(0, 0, 0, 80)
		v_u_554.BackgroundTransparency = 1
		v_u_554.Text = "Width: 1.00x"
		v_u_554.TextColor3 = Color3.new(1, 1, 1)
		v_u_554.TextSize = 12
		v_u_554.Font = Enum.Font.GothamBold
		v_u_554.TextXAlignment = Enum.TextXAlignment.Left
		v_u_554.Parent = v_u_548
		local v_u_555 = Instance.new("Frame")
		v_u_555.Size = UDim2.new(1, -20, 0, 6)
		v_u_555.Position = UDim2.new(0, 10, 0, 115)
		v_u_555.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_555.BackgroundTransparency = 0.5
		v_u_555.BorderSizePixel = 0
		v_u_555.Parent = v_u_548
		local v556 = Instance.new("UICorner")
		v556.CornerRadius = UDim.new(0, 3)
		v556.Parent = v_u_555
		local v_u_557 = Instance.new("Frame")
		v_u_557.Size = UDim2.new(0, 14, 0, 14)
		v_u_557.Position = UDim2.new(0.5, -7, 0.5, -7)
		v_u_557.BackgroundColor3 = Color3.new(1, 1, 1)
		v_u_557.BackgroundTransparency = 0.2
		v_u_557.BorderSizePixel = 0
		v_u_557.Parent = v_u_555
		local v558 = Instance.new("UICorner")
		v558.CornerRadius = UDim.new(0, 7)
		v558.Parent = v_u_557
		local v_u_559 = Instance.new("TextButton")
		v_u_559.Size = UDim2.new(0, 100, 0, 30)
		v_u_559.Position = UDim2.new(0.5, -50, 0, 160)
		v_u_559.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_559.BackgroundTransparency = 0.5
		v_u_559.Text = "Reset Size"
		v_u_559.TextColor3 = Color3.new(1, 1, 1)
		v_u_559.TextSize = 11
		v_u_559.Font = Enum.Font.Gotham
		v_u_559.BorderSizePixel = 0
		v_u_559.Parent = v_u_548
		local v560 = Instance.new("UICorner")
		v560.CornerRadius = UDim.new(0, 10)
		v560.Parent = v_u_559
		local v_u_561 = false
		local v_u_562 = false
		local function v_u_565(p563)
			-- upvalues: (ref) v_u_23, (ref) v_u_552, (ref) v_u_549, (ref) v_u_10, (ref) v_u_246
			local v564 = 0.1
			v_u_23.heightScale = v564 * math.pow(100 / v564, p563)
			v_u_552.Position = UDim2.new(p563, -7, 0.5, -7)
			v_u_549.Text = string.format("Height: %.2fx", v_u_23.heightScale)
			if v_u_10 then
				v_u_246()
			end
		end
		local function v_u_568(p566)
			-- upvalues: (ref) v_u_23, (ref) v_u_557, (ref) v_u_554, (ref) v_u_10, (ref) v_u_246
			local v567 = 0.1
			v_u_23.widthScale = v567 * math.pow(100 / v567, p566)
			v_u_557.Position = UDim2.new(p566, -7, 0.5, -7)
			v_u_554.Text = string.format("Width: %.2fx", v_u_23.widthScale)
			if v_u_10 then
				v_u_246()
			end
		end
		local function v_u_570(p569)
			-- upvalues: (ref) v_u_550, (ref) v_u_565
			v_u_565((math.clamp((p569.Position.X - v_u_550.AbsolutePosition.X) / v_u_550.AbsoluteSize.X, 0, 1)))
		end
		local function v_u_572(p571)
			-- upvalues: (ref) v_u_555, (ref) v_u_568
			v_u_568((math.clamp((p571.Position.X - v_u_555.AbsolutePosition.X) / v_u_555.AbsoluteSize.X, 0, 1)))
		end
		v_u_552.InputBegan:Connect(function(p573)
			-- upvalues: (ref) v_u_561, (ref) v_u_570
			if p573.UserInputType == Enum.UserInputType.MouseButton1 or p573.UserInputType == Enum.UserInputType.Touch then
				v_u_561 = true
				v_u_570(p573)
			end
		end)
		v_u_557.InputBegan:Connect(function(p574)
			-- upvalues: (ref) v_u_562, (ref) v_u_572
			if p574.UserInputType == Enum.UserInputType.MouseButton1 or p574.UserInputType == Enum.UserInputType.Touch then
				v_u_562 = true
				v_u_572(p574)
			end
		end)
		v_u_3.InputChanged:Connect(function(p575)
			-- upvalues: (ref) v_u_561, (ref) v_u_570, (ref) v_u_562, (ref) v_u_572
			if v_u_561 and (p575.UserInputType == Enum.UserInputType.MouseMovement or p575.UserInputType == Enum.UserInputType.Touch) then
				v_u_570(p575)
			end
			if v_u_562 and (p575.UserInputType == Enum.UserInputType.MouseMovement or p575.UserInputType == Enum.UserInputType.Touch) then
				v_u_572(p575)
			end
		end)
		v_u_3.InputEnded:Connect(function(p576)
			-- upvalues: (ref) v_u_561, (ref) v_u_562
			if p576.UserInputType == Enum.UserInputType.MouseButton1 or p576.UserInputType == Enum.UserInputType.Touch then
				v_u_561 = false
				v_u_562 = false
			end
		end)
		v_u_559.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_23, (ref) v_u_552, (ref) v_u_557, (ref) v_u_549, (ref) v_u_554, (ref) v_u_10, (ref) v_u_246
			v_u_23.heightScale = 1
			v_u_23.widthScale = 1
			v_u_552.Position = UDim2.new(0.5, -7, 0.5, -7)
			v_u_557.Position = UDim2.new(0.5, -7, 0.5, -7)
			v_u_549.Text = "Height: 1.00x"
			v_u_554.Text = "Width: 1.00x"
			if v_u_10 then
				v_u_246()
			end
		end)
		v_u_559.MouseEnter:Connect(function()
			-- upvalues: (ref) v_u_559
			v_u_559.BackgroundTransparency = 0.3
		end)
		v_u_559.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u_559
			v_u_559.BackgroundTransparency = 0.5
		end)
		local v_u_577 = Instance.new("Frame")
		v_u_577.Size = UDim2.new(1, -16, 1, -175)
		v_u_577.Position = UDim2.new(0, 8, 0, 105)
		v_u_577.BackgroundTransparency = 1
		v_u_577.Visible = false
		v_u_577.Parent = v_u_444
		local v578 = Instance.new("TextLabel")
		v578.Size = UDim2.new(1, 0, 0, 20)
		v578.Position = UDim2.new(0, 0, 0, 0)
		v578.BackgroundTransparency = 1
		v578.Text = "Hide Bodyparts"
		v578.TextColor3 = Color3.new(1, 1, 1)
		v578.TextSize = 12
		v578.Font = Enum.Font.GothamBold
		v578.TextXAlignment = Enum.TextXAlignment.Left
		v578.Parent = v_u_577
		local v_u_579 = Instance.new("TextButton")
		v_u_579.Size = UDim2.new(1, 0, 0, 28)
		v_u_579.Position = UDim2.new(0, 0, 0, 25)
		v_u_579.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_579.BackgroundTransparency = 0.5
		v_u_579.Text = " Select Body Parts..."
		v_u_579.TextColor3 = Color3.new(1, 1, 1)
		v_u_579.TextSize = 10
		v_u_579.Font = Enum.Font.Gotham
		v_u_579.TextXAlignment = Enum.TextXAlignment.Left
		v_u_579.BorderSizePixel = 0
		v_u_579.Parent = v_u_577
		local v580 = Instance.new("UICorner")
		v580.CornerRadius = UDim.new(0, 10)
		v580.Parent = v_u_579
		local v581 = Instance.new("UIPadding")
		v581.PaddingLeft = UDim.new(0, 10)
		v581.Parent = v_u_579
		local v_u_582 = {
			"Head",
			"UpperTorso",
			"LowerTorso",
			"LeftUpperArm",
			"LeftLowerArm",
			"LeftHand",
			"RightUpperArm",
			"RightLowerArm",
			"RightHand",
			"LeftUpperLeg",
			"LeftLowerLeg",
			"LeftFoot",
			"RightUpperLeg",
			"RightLowerLeg",
			"RightFoot",
			"Torso",
			"Left Arm",
			"Right Arm",
			"Left Leg",
			"Right Leg"
		}
		local function v_u_590(p583)
			-- upvalues: (ref) v_u_10, (ref) v_u_12, (ref) v_u_11
			if v_u_10 and (v_u_12 and v_u_11) then
				local v584 = v_u_12:FindFirstChild(p583)
				local v585 = v_u_11:FindFirstChild(p583)
				if v584 and v584:IsA("BasePart") then
					if v585 and v585:IsA("BasePart") then
						v584.Transparency = 1
						v584.CanCollide = false
						if p583 == "Head" then
							local v586, v587, v588 = ipairs(v584:GetChildren())
							while true do
								local v589
								v588, v589 = v586(v587, v588)
								if v588 == nil then
									break
								end
								if v589:IsA("Decal") then
									v589.Transparency = 1
								end
							end
						end
						_G.hiddenBodyParts[p583] = true
						print("\226\156\147 Hidden:", p583)
					end
				else
					return
				end
			else
				return
			end
		end
		local function v_u_592(p591)
			_G.hiddenBodyParts[p591] = nil
			print("\226\156\147 Shown:", p591)
		end
		local v_u_593 = false
		local v_u_594 = nil
		v_u_579.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_593, (ref) v_u_594, (ref) v_u_10, (ref) v_u_12, (ref) v_u_462, (ref) v_u_579, (ref) v_u_582, (ref) v_u_592, (ref) v_u_590
			if v_u_593 then
				if v_u_594 then
					v_u_594:Destroy()
				end
				v_u_593 = false
				return
			elseif v_u_10 and v_u_12 then
				v_u_593 = true
				v_u_594 = Instance.new("Frame")
				v_u_594.Size = UDim2.new(1, 0, 0, 150)
				v_u_594.Position = UDim2.new(0, 0, 1, 3)
				v_u_594.BackgroundColor3 = Color3.new(0, 0, 0)
				v_u_594.BackgroundTransparency = 0.3
				v_u_594.BorderSizePixel = 0
				v_u_594.ZIndex = 10
				v_u_594.Parent = v_u_579
				local v595 = Instance.new("UICorner")
				v595.CornerRadius = UDim.new(0, 10)
				v595.Parent = v_u_594
				local v_u_596 = Instance.new("ScrollingFrame")
				v_u_596.Size = UDim2.new(1, -6, 1, -6)
				v_u_596.Position = UDim2.new(0, 3, 0, 3)
				v_u_596.BackgroundTransparency = 1
				v_u_596.ScrollBarThickness = 3
				v_u_596.ScrollBarImageColor3 = Color3.new(1, 1, 1)
				v_u_596.ScrollBarImageTransparency = 0.5
				v_u_596.BorderSizePixel = 0
				v_u_596.ZIndex = 10
				v_u_596.Parent = v_u_594
				local v_u_597 = Instance.new("UIListLayout")
				v_u_597.Padding = UDim.new(0, 2)
				v_u_597.SortOrder = Enum.SortOrder.Name
				v_u_597.Parent = v_u_596
				local v598, v599, v600 = ipairs(v_u_582)
				while true do
					local v_u_601
					v600, v_u_601 = v598(v599, v600)
					if v600 == nil then
						break
					end
					if v_u_12:FindFirstChild(v_u_601) ~= nil then
						local v_u_602 = Instance.new("TextButton")
						v_u_602.Size = UDim2.new(1, 0, 0, 24)
						v_u_602.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
						v_u_602.BackgroundTransparency = 0.3
						v_u_602.Text = (_G.hiddenBodyParts[v_u_601] and "\226\156\147 " or "   ") .. v_u_601
						v_u_602.TextColor3 = _G.hiddenBodyParts[v_u_601] and Color3.fromRGB(100, 200, 255) or Color3.new(1, 1, 1)
						v_u_602.TextSize = 9
						v_u_602.Font = Enum.Font.Gotham
						v_u_602.TextXAlignment = Enum.TextXAlignment.Left
						v_u_602.BorderSizePixel = 0
						v_u_602.ZIndex = 10
						v_u_602.Parent = v_u_596
						local v603 = Instance.new("UIPadding")
						v603.PaddingLeft = UDim.new(0, 5)
						v603.Parent = v_u_602
						v_u_602.MouseButton1Click:Connect(function()
							-- upvalues: (ref) v_u_601, (ref) v_u_592, (ref) v_u_462, (ref) v_u_590, (ref) v_u_602
							if _G.hiddenBodyParts[v_u_601] then
								v_u_592(v_u_601)
								v_u_462.Text = v_u_601 .. " shown"
								v_u_462.TextColor3 = Color3.new(1, 0.7, 0.3)
							else
								v_u_590(v_u_601)
								v_u_462.Text = v_u_601 .. " hidden"
								v_u_462.TextColor3 = Color3.new(0.5, 1, 0.5)
							end
							spawn(function()
								-- upvalues: (ref) v_u_462
								wait(2)
								v_u_462.Text = "Ready"
								v_u_462.TextColor3 = Color3.new(0.7, 0.7, 0.7)
							end)
							v_u_602.Text = (_G.hiddenBodyParts[v_u_601] and "\226\156\147 " or "   ") .. v_u_601
							v_u_602.TextColor3 = _G.hiddenBodyParts[v_u_601] and Color3.fromRGB(100, 200, 255) or Color3.new(1, 1, 1)
						end)
					end
				end
				spawn(function()
					-- upvalues: (ref) v_u_596, (ref) v_u_597
					wait(0.05)
					v_u_596.CanvasSize = UDim2.new(0, 0, 0, v_u_597.AbsoluteContentSize.Y)
				end)
			else
				v_u_462.Text = "Enable reanimation first!"
				v_u_462.TextColor3 = Color3.new(1, 0.3, 0.3)
				spawn(function()
					-- upvalues: (ref) v_u_462
					wait(2)
					v_u_462.Text = "Ready"
					v_u_462.TextColor3 = Color3.new(0.7, 0.7, 0.7)
				end)
			end
		end)
		local v604 = 60
		local v605 = Instance.new("TextLabel")
		v605.Size = UDim2.new(1, 0, 0, 20)
		v605.Position = UDim2.new(0, 0, 0, v604)
		v605.BackgroundTransparency = 1
		v605.Text = "Snake Mode"
		v605.TextColor3 = Color3.new(1, 1, 1)
		v605.TextSize = 12
		v605.Font = Enum.Font.GothamBold
		v605.TextXAlignment = Enum.TextXAlignment.Left
		v605.Parent = v_u_577
		local v_u_606 = Instance.new("Frame")
		v_u_606.Size = UDim2.new(0, 40, 0, 18)
		v_u_606.Position = UDim2.new(1, -45, 0, v604 + 1)
		v_u_606.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
		v_u_606.BorderSizePixel = 0
		v_u_606.Parent = v_u_577
		local v607 = Instance.new("UICorner")
		v607.CornerRadius = UDim.new(0, 9)
		v607.Parent = v_u_606
		local v_u_608 = Instance.new("Frame")
		v_u_608.Size = UDim2.new(0, 14, 0, 14)
		v_u_608.Position = UDim2.new(0, 2, 0, 2)
		v_u_608.BackgroundColor3 = Color3.new(0.7, 0.7, 0.7)
		v_u_608.BorderSizePixel = 0
		v_u_608.Parent = v_u_606
		local v609 = Instance.new("UICorner")
		v609.CornerRadius = UDim.new(0, 7)
		v609.Parent = v_u_608
		local v610 = Instance.new("TextButton")
		v610.Size = UDim2.new(1, 0, 1, 0)
		v610.BackgroundTransparency = 1
		v610.Text = ""
		v610.Parent = v_u_606
		v610.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_10, (ref) v_u_462, (ref) v_u_26, (ref) v_u_33, (ref) v_u_34, (ref) v_u_35, (ref) v_u_6, (ref) v_u_606, (ref) v_u_608
			if v_u_10 then
				v_u_26 = not v_u_26
				v_u_33 = {}
				v_u_34 = {}
				v_u_35 = {}
				local v611 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				if v_u_26 then
					v_u_6:Create(v_u_606, v611, {
						["BackgroundColor3"] = Color3.fromRGB(0, 150, 255)
					}):Play()
					v_u_6:Create(v_u_608, v611, {
						["Position"] = UDim2.new(1, -16, 0, 2),
						["BackgroundColor3"] = Color3.new(1, 1, 1)
					}):Play()
					v_u_462.Text = "Snake mode enabled"
					v_u_462.TextColor3 = Color3.new(0.5, 1, 0.5)
				else
					v_u_6:Create(v_u_606, v611, {
						["BackgroundColor3"] = Color3.new(0.2, 0.2, 0.2)
					}):Play()
					v_u_6:Create(v_u_608, v611, {
						["Position"] = UDim2.new(0, 2, 0, 2),
						["BackgroundColor3"] = Color3.new(0.7, 0.7, 0.7)
					}):Play()
					v_u_462.Text = "Snake mode disabled"
					v_u_462.TextColor3 = Color3.new(1, 0.7, 0.3)
				end
				spawn(function()
					-- upvalues: (ref) v_u_462
					wait(2)
					v_u_462.Text = "Ready"
					v_u_462.TextColor3 = Color3.new(0.7, 0.7, 0.7)
				end)
			else
				v_u_462.Text = "Enable reanimation first!"
				v_u_462.TextColor3 = Color3.new(1, 0.3, 0.3)
				spawn(function()
					-- upvalues: (ref) v_u_462
					wait(2)
					v_u_462.Text = "Ready"
					v_u_462.TextColor3 = Color3.new(0.7, 0.7, 0.7)
				end)
			end
		end)
		local v_u_612 = Instance.new("TextLabel")
		v_u_612.Size = UDim2.new(1, -60, 0, 18)
		v_u_612.Position = UDim2.new(0, 0, 0, v604 + 25)
		v_u_612.BackgroundTransparency = 1
		v_u_612.Text = "Distance: 1.00"
		v_u_612.TextColor3 = Color3.new(0.9, 0.9, 0.9)
		v_u_612.TextSize = 10
		v_u_612.Font = Enum.Font.Gotham
		v_u_612.TextXAlignment = Enum.TextXAlignment.Left
		v_u_612.Parent = v_u_577
		local v_u_613 = Instance.new("Frame")
		v_u_613.Size = UDim2.new(1, -10, 0, 4)
		v_u_613.Position = UDim2.new(0, 5, 0, v604 + 45)
		v_u_613.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_613.BackgroundTransparency = 0.5
		v_u_613.BorderSizePixel = 0
		v_u_613.Parent = v_u_577
		local v614 = Instance.new("UICorner")
		v614.CornerRadius = UDim.new(0, 2)
		v614.Parent = v_u_613
		local v_u_615 = Instance.new("Frame")
		v_u_615.Size = UDim2.new(0, 12, 0, 12)
		v_u_615.Position = UDim2.new(0.18, -6, 0.5, -6)
		v_u_615.BackgroundColor3 = Color3.new(1, 1, 1)
		v_u_615.BackgroundTransparency = 0.2
		v_u_615.BorderSizePixel = 0
		v_u_615.Parent = v_u_613
		local v616 = Instance.new("UICorner")
		v616.CornerRadius = UDim.new(0, 6)
		v616.Parent = v_u_615
		local v_u_617 = false
		local function v_u_619(p618)
			-- upvalues: (ref) v_u_27, (ref) v_u_615, (ref) v_u_612
			v_u_27 = 0.2 + p618 * 4.8
			v_u_615.Position = UDim2.new(p618, -6, 0.5, -6)
			v_u_612.Text = string.format("Distance: %.2f", v_u_27)
		end
		local function v_u_621(p620)
			-- upvalues: (ref) v_u_613, (ref) v_u_619
			v_u_619((math.clamp((p620.Position.X - v_u_613.AbsolutePosition.X) / v_u_613.AbsoluteSize.X, 0, 1)))
		end
		v_u_615.InputBegan:Connect(function(p622)
			-- upvalues: (ref) v_u_617, (ref) v_u_621
			if p622.UserInputType == Enum.UserInputType.MouseButton1 or p622.UserInputType == Enum.UserInputType.Touch then
				v_u_617 = true
				v_u_621(p622)
			end
		end)
		v_u_3.InputChanged:Connect(function(p623)
			-- upvalues: (ref) v_u_617, (ref) v_u_621
			if v_u_617 and (p623.UserInputType == Enum.UserInputType.MouseMovement or p623.UserInputType == Enum.UserInputType.Touch) then
				v_u_621(p623)
			end
		end)
		v_u_3.InputEnded:Connect(function(p624)
			-- upvalues: (ref) v_u_617
			if p624.UserInputType == Enum.UserInputType.MouseButton1 or p624.UserInputType == Enum.UserInputType.Touch then
				v_u_617 = false
			end
		end)
		local v625 = 140
		local v626 = Instance.new("TextLabel")
		v626.Size = UDim2.new(1, 0, 0, 20)
		v626.Position = UDim2.new(0, 0, 0, v625)
		v626.BackgroundTransparency = 1
		v626.Text = "Cover Sky (need layered clothing)"
		v626.TextColor3 = Color3.new(1, 1, 1)
		v626.TextSize = 12
		v626.Font = Enum.Font.GothamBold
		v626.TextXAlignment = Enum.TextXAlignment.Left
		v626.Parent = v_u_577
		local v_u_627 = Instance.new("Frame")
		v_u_627.Size = UDim2.new(0, 40, 0, 18)
		v_u_627.Position = UDim2.new(1, -45, 0, v625 + 1)
		v_u_627.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
		v_u_627.BorderSizePixel = 0
		v_u_627.Parent = v_u_577
		local v628 = Instance.new("UICorner")
		v628.CornerRadius = UDim.new(0, 9)
		v628.Parent = v_u_627
		local v_u_629 = Instance.new("Frame")
		v_u_629.Size = UDim2.new(0, 14, 0, 14)
		v_u_629.Position = UDim2.new(0, 2, 0, 2)
		v_u_629.BackgroundColor3 = Color3.new(0.7, 0.7, 0.7)
		v_u_629.BorderSizePixel = 0
		v_u_629.Parent = v_u_627
		local v630 = Instance.new("UICorner")
		v630.CornerRadius = UDim.new(0, 7)
		v630.Parent = v_u_629
		local v631 = Instance.new("TextButton")
		v631.Size = UDim2.new(1, 0, 1, 0)
		v631.BackgroundTransparency = 1
		v631.Text = ""
		v631.Parent = v_u_627
		v631.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_10, (ref) v_u_462, (ref) v_u_30, (ref) v_u_6, (ref) v_u_627, (ref) v_u_629
			if v_u_10 then
				v_u_30 = not v_u_30
				local v632 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				if v_u_30 then
					v_u_6:Create(v_u_627, v632, {
						["BackgroundColor3"] = Color3.fromRGB(0, 150, 255)
					}):Play()
					v_u_6:Create(v_u_629, v632, {
						["Position"] = UDim2.new(1, -16, 0, 2),
						["BackgroundColor3"] = Color3.new(1, 1, 1)
					}):Play()
					v_u_462.Text = "Cover Sky enabled"
					v_u_462.TextColor3 = Color3.new(0.5, 1, 0.5)
				else
					v_u_6:Create(v_u_627, v632, {
						["BackgroundColor3"] = Color3.new(0.2, 0.2, 0.2)
					}):Play()
					v_u_6:Create(v_u_629, v632, {
						["Position"] = UDim2.new(0, 2, 0, 2),
						["BackgroundColor3"] = Color3.new(0.7, 0.7, 0.7)
					}):Play()
					v_u_462.Text = "Cover Sky disabled"
					v_u_462.TextColor3 = Color3.new(1, 0.7, 0.3)
				end
				spawn(function()
					-- upvalues: (ref) v_u_462
					wait(2)
					v_u_462.Text = "Ready"
					v_u_462.TextColor3 = Color3.new(0.7, 0.7, 0.7)
				end)
			else
				v_u_462.Text = "Enable reanimation first!"
				v_u_462.TextColor3 = Color3.new(1, 0.3, 0.3)
				spawn(function()
					-- upvalues: (ref) v_u_462
					wait(2)
					v_u_462.Text = "Ready"
					v_u_462.TextColor3 = Color3.new(0.7, 0.7, 0.7)
				end)
			end
		end)
		local v633 = v625 + 30
		local v634 = Instance.new("TextLabel")
		v634.Size = UDim2.new(1, 0, 0, 20)
		v634.Position = UDim2.new(0, 0, 0, v633)
		v634.BackgroundTransparency = 1
		v634.Text = "Cover Ground (need layered clothing)"
		v634.TextColor3 = Color3.new(1, 1, 1)
		v634.TextSize = 12
		v634.Font = Enum.Font.GothamBold
		v634.TextXAlignment = Enum.TextXAlignment.Left
		v634.Parent = v_u_577
		local v_u_635 = Instance.new("Frame")
		v_u_635.Size = UDim2.new(0, 40, 0, 18)
		v_u_635.Position = UDim2.new(1, -45, 0, v633 + 1)
		v_u_635.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
		v_u_635.BorderSizePixel = 0
		v_u_635.Parent = v_u_577
		local v636 = Instance.new("UICorner")
		v636.CornerRadius = UDim.new(0, 9)
		v636.Parent = v_u_635
		local v_u_637 = Instance.new("Frame")
		v_u_637.Size = UDim2.new(0, 14, 0, 14)
		v_u_637.Position = UDim2.new(0, 2, 0, 2)
		v_u_637.BackgroundColor3 = Color3.new(0.7, 0.7, 0.7)
		v_u_637.BorderSizePixel = 0
		v_u_637.Parent = v_u_635
		local v638 = Instance.new("UICorner")
		v638.CornerRadius = UDim.new(0, 7)
		v638.Parent = v_u_637
		local v639 = Instance.new("TextButton")
		v639.Size = UDim2.new(1, 0, 1, 0)
		v639.BackgroundTransparency = 1
		v639.Text = ""
		v639.Parent = v_u_635
		v639.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_10, (ref) v_u_462, (ref) v_u_6, (ref) v_u_635, (ref) v_u_637
			if v_u_10 then
				groundModeEnabled = not groundModeEnabled
				local v640 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				if groundModeEnabled then
					v_u_6:Create(v_u_635, v640, {
						["BackgroundColor3"] = Color3.fromRGB(0, 150, 255)
					}):Play()
					v_u_6:Create(v_u_637, v640, {
						["Position"] = UDim2.new(1, -16, 0, 2),
						["BackgroundColor3"] = Color3.new(1, 1, 1)
					}):Play()
					v_u_462.Text = "Cover Ground enabled"
					v_u_462.TextColor3 = Color3.new(0.5, 1, 0.5)
				else
					v_u_6:Create(v_u_635, v640, {
						["BackgroundColor3"] = Color3.new(0.2, 0.2, 0.2)
					}):Play()
					v_u_6:Create(v_u_637, v640, {
						["Position"] = UDim2.new(0, 2, 0, 2),
						["BackgroundColor3"] = Color3.new(0.7, 0.7, 0.7)
					}):Play()
					v_u_462.Text = "Cover Ground disabled"
					v_u_462.TextColor3 = Color3.new(1, 0.7, 0.3)
				end
				spawn(function()
					-- upvalues: (ref) v_u_462
					wait(2)
					v_u_462.Text = "Ready"
					v_u_462.TextColor3 = Color3.new(0.7, 0.7, 0.7)
				end)
			else
				v_u_462.Text = "Enable reanimation first!"
				v_u_462.TextColor3 = Color3.new(1, 0.3, 0.3)
				spawn(function()
					-- upvalues: (ref) v_u_462
					wait(2)
					v_u_462.Text = "Ready"
					v_u_462.TextColor3 = Color3.new(0.7, 0.7, 0.7)
				end)
			end
		end)
		local v_u_641 = Instance.new("TextButton")
		v_u_641.Size = UDim2.new(0, 60, 0, 22)
		v_u_641.Position = UDim2.new(0, 8, 0, 105)
		v_u_641.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_641.BackgroundTransparency = 0.5
		v_u_641.Text = "Add"
		v_u_641.TextColor3 = Color3.new(1, 1, 1)
		v_u_641.TextSize = 10
		v_u_641.Font = Enum.Font.Gotham
		v_u_641.BorderSizePixel = 0
		v_u_641.Parent = v_u_444
		local v642 = Instance.new("UICorner")
		v642.CornerRadius = UDim.new(0, 9)
		v642.Parent = v_u_641
		local v_u_643 = "all"
		local v_u_644 = false
		local v_u_645 = false
		local v_u_646 = false
		local v_u_647 = nil
		local v_u_648 = false
		Instance.new("TextButton")
		local v_u_649 = Instance.new("TextButton")
		v_u_649.Size = UDim2.new(0, 25, 0, 25)
		v_u_649.Position = UDim2.new(1, -33, 1, -33)
		v_u_649.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_649.BackgroundTransparency = 0.5
		v_u_649.Text = "i"
		v_u_649.TextColor3 = Color3.new(1, 1, 1)
		v_u_649.TextSize = 14
		v_u_649.Font = Enum.Font.GothamBold
		v_u_649.BorderSizePixel = 0
		v_u_649.ZIndex = 10
		v_u_649.Visible = false
		v_u_649.Parent = v_u_444
		task.defer(function()
			-- upvalues: (ref) v_u_649, (ref) v_u_643
			v_u_649.Visible = v_u_643 == "custom" or v_u_643 == "states"
		end)
		local v650 = Instance.new("UICorner")
		v650.CornerRadius = UDim.new(1, 0)
		v650.Parent = v_u_649
		v_u_649.MouseEnter:Connect(function()
			-- upvalues: (ref) v_u_649
			v_u_649.BackgroundTransparency = 0.3
		end)
		v_u_649.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u_649
			v_u_649.BackgroundTransparency = 0.5
		end)
		local v_u_651 = nil
		local function v_u_663()
			-- upvalues: (ref) v_u_651, (ref) v_u_443
			if v_u_651 then
				v_u_651:Destroy()
			end
			v_u_651 = Instance.new("Frame")
			v_u_651.Size = UDim2.new(0, 380, 0, 300)
			v_u_651.Position = UDim2.new(0.5, -190, 0.5, -150)
			v_u_651.BackgroundColor3 = Color3.new(0, 0, 0)
			v_u_651.BackgroundTransparency = 0.6
			v_u_651.BorderSizePixel = 0
			v_u_651.ZIndex = 100
			v_u_651.Parent = v_u_443
			local v652 = Instance.new("UICorner")
			v652.CornerRadius = UDim.new(0, 15)
			v652.Parent = v_u_651
			local v653 = Instance.new("TextLabel")
			v653.Size = UDim2.new(1, -40, 0, 30)
			v653.Position = UDim2.new(0, 10, 0, 5)
			v653.BackgroundTransparency = 1
			v653.Text = "How to Convert Animations"
			v653.TextColor3 = Color3.new(1, 1, 1)
			v653.TextSize = 14
			v653.Font = Enum.Font.GothamBold
			v653.TextXAlignment = Enum.TextXAlignment.Left
			v653.ZIndex = 101
			v653.Parent = v_u_651
			local v654 = Instance.new("TextButton")
			v654.Size = UDim2.new(0, 25, 0, 25)
			v654.Position = UDim2.new(1, -30, 0, 5)
			v654.BackgroundColor3 = Color3.new(0, 0, 0)
			v654.BackgroundTransparency = 0.7
			v654.Text = "\195\151"
			v654.TextColor3 = Color3.new(1, 1, 1)
			v654.TextSize = 18
			v654.Font = Enum.Font.Gotham
			v654.BorderSizePixel = 0
			v654.ZIndex = 101
			v654.Parent = v_u_651
			local v655 = Instance.new("UICorner")
			v655.CornerRadius = UDim.new(0, 10)
			v655.Parent = v654
			v654.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_651
				v_u_651:Destroy()
				v_u_651 = nil
			end)
			local v656 = Instance.new("TextLabel")
			v656.Size = UDim2.new(1, -20, 0, 150)
			v656.Position = UDim2.new(0, 10, 0, 40)
			v656.BackgroundTransparency = 1
			v656.Text = "1. Open Roblox Studio and create a new game\r\n\r\n2. Create a Folder in Workspace named \"Keyframes\"\r\n\r\n3. Put all your KeyframeSequences in the folder\r\n   (Each animation should be named differently)\r\n\r\n4. Publish your game to Roblox\r\n\r\n5. Join the published game with your executor\r\n\r\n6. Execute the converter script below:"
			v656.TextColor3 = Color3.new(1, 1, 1)
			v656.TextSize = 11
			v656.Font = Enum.Font.Gotham
			v656.TextXAlignment = Enum.TextXAlignment.Left
			v656.TextYAlignment = Enum.TextYAlignment.Top
			v656.TextWrapped = true
			v656.ZIndex = 101
			v656.Parent = v_u_651
			local v657 = Instance.new("Frame")
			v657.Size = UDim2.new(1, -20, 0, 50)
			v657.Position = UDim2.new(0, 10, 0, 195)
			v657.BackgroundColor3 = Color3.new(0, 0, 0)
			v657.BackgroundTransparency = 0.5
			v657.BorderSizePixel = 0
			v657.ZIndex = 101
			v657.Parent = v_u_651
			local v658 = Instance.new("UICorner")
			v658.CornerRadius = UDim.new(0, 10)
			v658.Parent = v657
			local v_u_659 = Instance.new("TextBox")
			v_u_659.Size = UDim2.new(1, -10, 1, -10)
			v_u_659.Position = UDim2.new(0, 10, 0, 5)
			v_u_659.BackgroundTransparency = 1
			v_u_659.Text = "loadstring(game:HttpGet(\"https://akadmin-bzk.pages.dev/Converter.lua\"))()"
			v_u_659.TextColor3 = Color3.new(0.8, 1, 0.8)
			v_u_659.TextSize = 10
			v_u_659.Font = Enum.Font.Code
			v_u_659.TextWrapped = true
			v_u_659.TextEditable = false
			v_u_659.TextXAlignment = Enum.TextXAlignment.Left
			v_u_659.TextYAlignment = Enum.TextYAlignment.Center
			v_u_659.ClearTextOnFocus = false
			v_u_659.ZIndex = 102
			v_u_659.Parent = v657
			local v_u_660 = Instance.new("TextButton")
			v_u_660.Size = UDim2.new(0, 60, 0, 25)
			v_u_660.Position = UDim2.new(0.5, -30, 1, 15)
			v_u_660.BackgroundColor3 = Color3.new(0, 0, 0)
			v_u_660.BackgroundTransparency = 0.3
			v_u_660.Text = "Copy"
			v_u_660.TextColor3 = Color3.new(1, 1, 1)
			v_u_660.TextSize = 11
			v_u_660.Font = Enum.Font.Gotham
			v_u_660.BorderSizePixel = 0
			v_u_660.ZIndex = 102
			v_u_660.Parent = v657
			local v661 = Instance.new("UICorner")
			v661.CornerRadius = UDim.new(0, 8)
			v661.Parent = v_u_660
			v_u_660.MouseEnter:Connect(function()
				-- upvalues: (ref) v_u_660
				v_u_660.BackgroundTransparency = 0.1
			end)
			v_u_660.MouseLeave:Connect(function()
				-- upvalues: (ref) v_u_660
				v_u_660.BackgroundTransparency = 0.3
			end)
			v_u_660.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_659, (ref) v_u_660
				setclipboard(v_u_659.Text)
				v_u_660.Text = "Copied!"
				spawn(function()
					-- upvalues: (ref) v_u_660
					wait(1.5)
					v_u_660.Text = "Copy"
				end)
			end)
			local v662 = Instance.new("TextLabel")
			v662.Size = UDim2.new(1, -20, 0, 25)
			v662.Position = UDim2.new(0, 10, 0, 240)
			v662.BackgroundTransparency = 1
			v662.Text = "After converting, find keyframe codes in your executor\'s workspace folder"
			v662.TextColor3 = Color3.new(0.8, 0.8, 0.8)
			v662.TextSize = 9
			v662.Font = Enum.Font.Gotham
			v662.TextWrapped = true
			v662.TextXAlignment = Enum.TextXAlignment.Center
			v662.ZIndex = 101
			v662.Parent = v_u_651
		end
		v_u_649.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_663
			v_u_663()
		end)
		local function v_u_664()
			-- upvalues: (ref) v_u_643, (ref) v_u_649
			if v_u_643 == "custom" or v_u_643 == "states" then
				v_u_649.Visible = true
			else
				v_u_649.Visible = false
			end
		end
		local v665 = Instance.new("Frame")
		v665.Size = UDim2.new(1, -16, 0, 65)
		v665.Position = UDim2.new(0, 8, 1, -70)
		v665.BackgroundTransparency = 1
		v665.Parent = v_u_444
		local v666 = Instance.new("TextLabel")
		v666.Size = UDim2.new(0, 40, 0, 18)
		v666.Position = UDim2.new(0, 0, 0, 0)
		v666.BackgroundTransparency = 1
		v666.Text = "Speed:"
		v666.TextColor3 = Color3.new(1, 1, 1)
		v666.TextSize = 9
		v666.Font = Enum.Font.Gotham
		v666.TextXAlignment = Enum.TextXAlignment.Left
		v666.Parent = v665
		local v_u_667 = Instance.new("Frame")
		v_u_667.Size = UDim2.new(1, -100, 0, 6)
		v_u_667.Position = UDim2.new(0, 45, 0, 7)
		v_u_667.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_667.BackgroundTransparency = 0.5
		v_u_667.BorderSizePixel = 0
		v_u_667.Parent = v665
		local v668 = Instance.new("UICorner")
		v668.CornerRadius = UDim.new(0, 3)
		v668.Parent = v_u_667
		local v_u_669 = Instance.new("Frame")
		v_u_669.Size = UDim2.new(0, 12, 0, 12)
		v_u_669.Position = UDim2.new(0.5, -6, 0.5, -6)
		v_u_669.BackgroundColor3 = Color3.new(1, 1, 1)
		v_u_669.BackgroundTransparency = 0.2
		v_u_669.BorderSizePixel = 0
		v_u_669.Parent = v_u_667
		local v670 = Instance.new("UICorner")
		v670.CornerRadius = UDim.new(0, 6)
		v670.Parent = v_u_669
		local v_u_671 = Instance.new("TextLabel")
		v_u_671.Size = UDim2.new(0, 40, 0, 18)
		v_u_671.Position = UDim2.new(0, 215, 0, 0)
		v_u_671.BackgroundTransparency = 1
		v_u_671.Text = "5"
		v_u_671.TextColor3 = Color3.new(1, 1, 1)
		v_u_671.TextSize = 9
		v_u_671.Font = Enum.Font.Gotham
		v_u_671.TextXAlignment = Enum.TextXAlignment.Left
		v_u_671.Parent = v665
		local v_u_672 = Instance.new("TextButton")
		v_u_672.Size = UDim2.new(0, 30, 0, 14)
		v_u_672.Position = UDim2.new(1, -30, 0, 2)
		v_u_672.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_672.BackgroundTransparency = 0.5
		v_u_672.Text = "Reset"
		v_u_672.TextColor3 = Color3.new(1, 1, 1)
		v_u_672.TextSize = 7
		v_u_672.Font = Enum.Font.Gotham
		v_u_672.BorderSizePixel = 0
		v_u_672.Parent = v665
		local v673 = Instance.new("UICorner")
		v673.CornerRadius = UDim.new(0, 8)
		v673.Parent = v_u_672
		local v674 = Instance.new("Frame")
		v674.Size = UDim2.new(1, 0, 0, 38)
		v674.Position = UDim2.new(0, 0, 0, 22)
		v674.BackgroundTransparency = 1
		v674.Parent = v665
		local v_u_675 = v_u_643
		local v_u_676 = v_u_649
		local v_u_677 = v_u_443
		local v_u_678 = v_u_462
		local v_u_679 = {}
		for v680 = 1, 5 do
			local v_u_681 = v680
			local v682 = Instance.new("Frame")
			v682.Size = UDim2.new(0.18, 0, 1, 0)
			v682.Position = UDim2.new((v_u_681 - 1) * 0.2 + 0.01, 0, 0, 0)
			v682.BackgroundTransparency = 1
			v682.Parent = v674
			local v_u_683 = Instance.new("TextBox")
			v_u_683.Size = UDim2.new(1, 0, 0, 16)
			v_u_683.Position = UDim2.new(0, 0, 0, 0)
			v_u_683.BackgroundColor3 = Color3.new(0, 0, 0)
			v_u_683.BackgroundTransparency = 0.5
			v_u_683.Text = v_u_52 and v_u_52[v_u_681] and tostring(v_u_52[v_u_681].speed) or tostring(v_u_681 * 2 - 1)
			v_u_683.TextColor3 = Color3.new(1, 1, 1)
			v_u_683.TextSize = 8
			v_u_683.Font = Enum.Font.Gotham
			v_u_683.BorderSizePixel = 0
			v_u_683.Parent = v682
			local v684 = Instance.new("UICorner")
			v684.CornerRadius = UDim.new(0, 6)
			v684.Parent = v_u_683
			local v_u_685 = Instance.new("TextButton")
			v_u_685.Size = UDim2.new(1, 0, 0, 16)
			v_u_685.Position = UDim2.new(0, 0, 0, 20)
			v_u_685.BackgroundColor3 = Color3.new(0, 0, 0)
			v_u_685.BackgroundTransparency = 0.5
			v_u_685.Text = "Key"
			v_u_685.TextColor3 = Color3.new(0.8, 0.8, 0.8)
			v_u_685.TextSize = 7
			v_u_685.Font = Enum.Font.Gotham
			v_u_685.BorderSizePixel = 0
			v_u_685.Parent = v682
			local v686 = Instance.new("UICorner")
			v686.CornerRadius = UDim.new(0, 6)
			v686.Parent = v_u_685
			v_u_679[v_u_681] = {
				["speedInput"] = v_u_683,
				["keybindButton"] = v_u_685,
				["connection"] = nil
			}
			v_u_683.FocusLost:Connect(function()
				-- upvalues: (ref) v_u_52, (ref) v_u_681, (ref) v_u_683, (ref) v_u_111
				if not v_u_52[v_u_681] then
					v_u_52[v_u_681] = {
						["speed"] = v_u_681 * 2 - 1,
						["key"] = ""
					}
				end
				local v687 = tonumber(v_u_683.Text)
				if v687 and (0 <= v687 and v687 <= 10) then
					v_u_52[v_u_681].speed = v687
					v_u_111()
				else
					v_u_683.Text = tostring(v_u_52[v_u_681].speed)
				end
			end)
			v_u_685.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_52, (ref) v_u_681, (ref) v_u_685, (ref) v_u_111, (ref) v_u_679, (ref) v_u_678, (ref) v_u_3, (ref) v_u_38, (ref) v_u_669, (ref) v_u_671
				if not v_u_52[v_u_681] then
					v_u_52[v_u_681] = {
						["speed"] = v_u_681 * 2 - 1,
						["key"] = ""
					}
				end
				if v_u_52[v_u_681].key == "" then
					v_u_685.Text = "..."
					v_u_678.Text = "Press any key for slot " .. v_u_681 .. "..."
					v_u_678.TextColor3 = Color3.new(1, 1, 0.5)
					local v_u_688 = nil
					v_u_688 = v_u_3.InputBegan:Connect(function(p_u_689, p690)
						-- upvalues: (ref) v_u_685, (ref) v_u_678, (ref) v_u_688, (ref) v_u_52, (ref) v_u_681, (ref) v_u_111, (ref) v_u_679, (ref) v_u_3, (ref) v_u_38, (ref) v_u_669, (ref) v_u_671
						if not p690 then
							if p_u_689.KeyCode == Enum.KeyCode.Escape or p_u_689.KeyCode == Enum.KeyCode.Backspace then
								v_u_685.Text = "Key"
								v_u_678.Text = "Cancelled"
								v_u_678.TextColor3 = Color3.new(0.7, 0.7, 0.7)
								spawn(function()
									-- upvalues: (ref) v_u_678
									wait(2)
									v_u_678.Text = "Ready"
								end)
								v_u_688:Disconnect()
							elseif p_u_689.KeyCode ~= Enum.KeyCode.Unknown then
								v_u_52[v_u_681].key = p_u_689.KeyCode.Name
								v_u_685.Text = p_u_689.KeyCode.Name:sub(1, 3)
								v_u_685.TextColor3 = Color3.new(1, 1, 1)
								v_u_111()
								if v_u_679[v_u_681].connection then
									v_u_679[v_u_681].connection:Disconnect()
								end
								v_u_679[v_u_681].connection = v_u_3.InputBegan:Connect(function(p691, p692)
									-- upvalues: (ref) p_u_689, (ref) v_u_52, (ref) v_u_681, (ref) v_u_38, (ref) v_u_669, (ref) v_u_671
									if not p692 then
										if p691.KeyCode == p_u_689.KeyCode then
											local v693 = v_u_52[v_u_681].speed / 10
											v_u_38.speed = v_u_52[v_u_681].speed / 5
											v_u_669.Position = UDim2.new(v693, -6, 0.5, -6)
											v_u_671.Text = string.format("%d", v_u_52[v_u_681].speed)
										end
									end
								end)
								v_u_678.Text = "Bound slot " .. v_u_681 .. " to " .. p_u_689.KeyCode.Name
								v_u_678.TextColor3 = Color3.new(0.5, 1, 0.5)
								spawn(function()
									-- upvalues: (ref) v_u_678
									wait(2)
									v_u_678.Text = "Ready"
									v_u_678.TextColor3 = Color3.new(0.7, 0.7, 0.7)
								end)
								v_u_688:Disconnect()
							end
						end
					end)
				else
					v_u_52[v_u_681].key = ""
					v_u_685.Text = "Key"
					v_u_685.TextColor3 = Color3.new(0.8, 0.8, 0.8)
					v_u_111()
					if v_u_679[v_u_681].connection then
						v_u_679[v_u_681].connection:Disconnect()
						v_u_679[v_u_681].connection = nil
					end
					v_u_678.Text = "Unbound slot " .. v_u_681
					v_u_678.TextColor3 = Color3.new(1, 0.5, 0.5)
					spawn(function()
						-- upvalues: (ref) v_u_678
						wait(2)
						v_u_678.Text = "Ready"
						v_u_678.TextColor3 = Color3.new(0.7, 0.7, 0.7)
					end)
				end
			end)
		end
		for v694 = 1, 5 do
			local v_u_695 = v694
			if v_u_52[v_u_695] then
				v_u_679[v_u_695].speedInput.Text = tostring(v_u_52[v_u_695].speed)
				if v_u_52[v_u_695].key and v_u_52[v_u_695].key ~= "" then
					v_u_679[v_u_695].keybindButton.Text = v_u_52[v_u_695].key:sub(1, 3)
					v_u_679[v_u_695].keybindButton.TextColor3 = Color3.new(1, 1, 1)
					local v_u_696 = Enum.KeyCode[v_u_52[v_u_695].key]
					if v_u_696 then
						v_u_679[v_u_695].connection = v_u_3.InputBegan:Connect(function(p697, p698)
							-- upvalues: (ref) v_u_696, (ref) v_u_52, (ref) v_u_695, (ref) v_u_38, (ref) v_u_669, (ref) v_u_671
							if not p698 then
								if p697.KeyCode == v_u_696 then
									local v699 = v_u_52[v_u_695].speed / 10
									v_u_38.speed = v_u_52[v_u_695].speed / 5
									v_u_669.Position = UDim2.new(v699, -6, 0.5, -6)
									v_u_671.Text = string.format("%d", v_u_52[v_u_695].speed)
								end
							end
						end)
					end
				end
			end
		end
		local v_u_700 = {
			v_u_678,
			v463,
			v_u_476,
			v_u_478,
			v665,
			v_u_480,
			v_u_485,
			v_u_676,
			v_u_641,
			v_u_548,
			v_u_577
		}
		local function v_u_713(p_u_701)
			-- upvalues: (ref) v_u_478, (ref) v_u_49, (ref) v_u_675, (ref) v_u_47, (ref) v_u_48, (ref) v_u_402, (ref) v_u_39, (ref) v_u_135, (ref) v_u_96, (ref) v_u_79, (ref) v_u_678, (ref) v_u_646, (ref) v_u_647, (ref) v_u_3, (ref) v_u_290
			local v702 = Instance.new("Frame")
			v702.Size = UDim2.new(1, 0, 0, 35)
			v702.BackgroundTransparency = 1
			v702.Parent = v_u_478
			local v703 = v_u_49[p_u_701.name] ~= nil
			local v704 = v703 and (v_u_675 == "custom" and -102 or -70) or -70
			local v_u_705 = Instance.new("TextButton")
			v_u_705.Size = UDim2.new(1, v704, 1, 0)
			v_u_705.Position = UDim2.new(0, 0, 0, 0)
			v_u_705.BackgroundColor3 = Color3.new(0, 0, 0)
			v_u_705.BackgroundTransparency = 0.5
			v_u_705.Text = " " .. p_u_701.name
			v_u_705.TextColor3 = Color3.new(1, 1, 1)
			v_u_705.TextSize = 12
			v_u_705.Font = Enum.Font.Gotham
			v_u_705.TextXAlignment = Enum.TextXAlignment.Left
			v_u_705.BorderSizePixel = 0
			v_u_705.Parent = v702
			local v706 = Instance.new("UICorner")
			v706.CornerRadius = UDim.new(0, 12)
			v706.Parent = v_u_705
			local v707
			if v703 and v_u_675 == "custom" then
				v707 = Instance.new("TextButton")
				v707.Size = UDim2.new(0, 32, 1, 0)
				v707.Position = UDim2.new(1, -98, 0, 0)
				v707.BackgroundTransparency = 1
				v707.Text = "X"
				v707.TextColor3 = Color3.new(1, 0.3, 0.3)
				v707.TextSize = 16
				v707.BorderSizePixel = 0
				v707.Parent = v702
			else
				v707 = nil
			end
			local v_u_708 = Instance.new("TextButton")
			v_u_708.Size = UDim2.new(0, 32, 1, 0)
			v_u_708.Position = UDim2.new(1, -66, 0, 0)
			v_u_708.BackgroundTransparency = 1
			v_u_708.Text = v_u_47[p_u_701.name] and "\226\152\133" or "\226\152\134"
			v_u_708.TextColor3 = v_u_47[p_u_701.name] and Color3.new(1, 0.8, 0) or Color3.new(0.7, 0.7, 0.7)
			v_u_708.TextSize = 16
			v_u_708.BorderSizePixel = 0
			v_u_708.Parent = v702
			local v_u_709 = Instance.new("TextButton")
			v_u_709.Size = UDim2.new(0, 32, 1, 0)
			v_u_709.Position = UDim2.new(1, -32, 0, 0)
			v_u_709.BackgroundTransparency = 1
			v_u_709.Text = v_u_48[p_u_701.name] and (v_u_48[p_u_701.name].Name:gsub("KeyCode%.", ""):sub(1, 3) or "Bind") or "Bind"
			v_u_709.TextColor3 = v_u_48[p_u_701.name] and Color3.new(1, 1, 1) or Color3.new(0.8, 0.8, 0.8)
			v_u_709.TextSize = 8
			v_u_709.Font = Enum.Font.Gotham
			v_u_709.BorderSizePixel = 0
			v_u_709.Parent = v702
			v_u_705.MouseEnter:Connect(function()
				-- upvalues: (ref) v_u_705
				v_u_705.BackgroundTransparency = 0.3
			end)
			v_u_705.MouseLeave:Connect(function()
				-- upvalues: (ref) v_u_705
				v_u_705.BackgroundTransparency = 0.5
			end)
			v_u_705.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_402, (ref) p_u_701
				v_u_402(tostring(p_u_701.id))
			end)
			if v707 then
				v707.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_49, (ref) p_u_701, (ref) v_u_39, (ref) v_u_48, (ref) v_u_47, (ref) v_u_135, (ref) v_u_96, (ref) v_u_79
					v_u_49[p_u_701.name] = nil
					v_u_39[p_u_701.name] = nil
					v_u_48[p_u_701.name] = nil
					v_u_47[p_u_701.name] = nil
					v_u_135()
					v_u_96()
					v_u_79()
					loadGUI()
				end)
			end
			v_u_708.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_47, (ref) p_u_701, (ref) v_u_708, (ref) v_u_79, (ref) v_u_675
				if v_u_47[p_u_701.name] then
					v_u_47[p_u_701.name] = nil
					v_u_708.Text = "\226\152\134"
					v_u_708.TextColor3 = Color3.new(0.7, 0.7, 0.7)
				else
					v_u_47[p_u_701.name] = tostring(p_u_701.id)
					v_u_708.Text = "\226\152\133"
					v_u_708.TextColor3 = Color3.new(1, 0.8, 0)
				end
				v_u_79()
				if v_u_675 == "favorites" then
					spawn(function()
						wait(0.1)
						loadGUI()
					end)
				end
			end)
			v_u_709.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_48, (ref) p_u_701, (ref) v_u_96, (ref) v_u_709, (ref) v_u_678, (ref) v_u_646, (ref) v_u_647, (ref) v_u_3
				if v_u_48[p_u_701.name] then
					v_u_48[p_u_701.name] = nil
					v_u_96()
					v_u_709.Text = "Bind"
					v_u_709.TextColor3 = Color3.new(0.8, 0.8, 0.8)
					v_u_678.Text = "Unbound " .. p_u_701.name
					v_u_678.TextColor3 = Color3.new(1, 0.5, 0.5)
					spawn(function()
						-- upvalues: (ref) v_u_678
						wait(2)
						v_u_678.Text = "Ready"
						v_u_678.TextColor3 = Color3.new(0.7, 0.7, 0.7)
					end)
					return
				elseif not v_u_646 then
					v_u_646 = true
					v_u_647 = p_u_701.name
					v_u_678.Text = "Press any key to bind..."
					v_u_678.TextColor3 = Color3.new(1, 1, 0.5)
					v_u_709.Text = "..."
					local v_u_710 = nil
					v_u_710 = v_u_3.InputBegan:Connect(function(p711, p712)
						-- upvalues: (ref) v_u_646, (ref) v_u_647, (ref) p_u_701, (ref) v_u_710, (ref) v_u_709, (ref) v_u_678, (ref) v_u_48, (ref) v_u_96
						if p712 then
							return
						elseif v_u_646 and v_u_647 == p_u_701.name then
							if p711.KeyCode == Enum.KeyCode.Escape or p711.KeyCode == Enum.KeyCode.Backspace then
								v_u_709.Text = "Bind"
								v_u_709.TextColor3 = Color3.new(0.8, 0.8, 0.8)
								v_u_678.Text = "Binding cancelled"
								v_u_678.TextColor3 = Color3.new(0.7, 0.7, 0.7)
								spawn(function()
									-- upvalues: (ref) v_u_678
									wait(2)
									v_u_678.Text = "Ready"
								end)
								v_u_646 = false
								v_u_647 = nil
								v_u_710:Disconnect()
							elseif p711.KeyCode ~= Enum.KeyCode.Unknown then
								v_u_48[p_u_701.name] = p711.KeyCode
								v_u_96()
								v_u_709.Text = p711.KeyCode.Name:gsub("KeyCode%.", ""):sub(1, 3)
								v_u_709.TextColor3 = Color3.new(1, 1, 1)
								v_u_678.Text = "Bound to " .. p711.KeyCode.Name:gsub("KeyCode%.", "")
								v_u_678.TextColor3 = Color3.new(0.5, 1, 0.5)
								spawn(function()
									-- upvalues: (ref) v_u_678
									wait(2)
									v_u_678.Text = "Ready"
									v_u_678.TextColor3 = Color3.new(0.7, 0.7, 0.7)
								end)
								v_u_646 = false
								v_u_647 = nil
								v_u_710:Disconnect()
							end
						else
							v_u_710:Disconnect()
						end
					end)
				end
			end)
			v_u_290[p_u_701.name] = {
				["Container"] = v702,
				["NameButton"] = v_u_705,
				["FavoriteButton"] = v_u_708,
				["KeybindButton"] = v_u_709,
				["DeleteButton"] = v707
			}
		end
		function loadGUI()
			-- upvalues: (ref) v_u_478, (ref) v_u_290, (ref) v_u_480, (ref) v_u_675, (ref) v_u_648, (ref) v_u_641, (ref) v_u_485, (ref) v_u_548, (ref) v_u_577, (ref) v_u_476, (ref) v_u_39, (ref) v_u_49, (ref) v_u_47, (ref) v_u_713, (ref) v_u_479
			local v714 = v_u_478
			local v715, v716, v717 = pairs(v714:GetChildren())
			while true do
				local v718
				v717, v718 = v715(v716, v717)
				if v717 == nil then
					break
				end
				if v718:IsA("Frame") then
					v718:Destroy()
				end
			end
			v_u_290 = {}
			local v719 = v_u_480
			local v720
			if v_u_675 ~= "custom" then
				v720 = false
			else
				v720 = v_u_648
			end
			v719.Visible = v720
			v_u_641.Visible = v_u_675 == "custom"
			v_u_485.Visible = v_u_675 == "states"
			v_u_548.Visible = v_u_675 == "size"
			v_u_577.Visible = v_u_675 == "others"
			v_u_478.Visible = v_u_675 ~= "states" and (v_u_675 ~= "size" and v_u_675 ~= "others")
			v_u_476.Visible = v_u_675 ~= "states" and (v_u_675 ~= "size" and v_u_675 ~= "others")
			if v_u_675 ~= "states" and (v_u_675 ~= "size" and v_u_675 ~= "others") then
				if v_u_675 ~= "custom" then
					v_u_478.Size = UDim2.new(1, -16, 1, -175)
					v_u_478.Position = UDim2.new(0, 8, 0, 105)
				elseif v_u_648 then
					v_u_478.Size = UDim2.new(1, -16, 1, -270)
					v_u_478.Position = UDim2.new(0, 8, 0, 195)
				else
					v_u_478.Size = UDim2.new(1, -16, 1, -205)
					v_u_478.Position = UDim2.new(0, 8, 0, 135)
				end
				local v721 = {}
				local v722 = v_u_476.Text:lower()
				local v723 = v_u_39
				if v_u_675 == "custom" then
					v723 = v_u_49
				end
				local v724, v725, v726 = pairs(v723)
				while true do
					local v727
					v726, v727 = v724(v725, v726)
					if v726 == nil then
						break
					end
					if (v_u_675 ~= "favorites" or v_u_47[v726] ~= nil) and (v722 == "" or v726:lower():find(v722)) then
						table.insert(v721, {
							["name"] = v726,
							["id"] = v727
						})
					end
				end
				table.sort(v721, function(p728, p729)
					return p728.name < p729.name
				end)
				local v730, v731, v732 = pairs(v721)
				while true do
					local v733
					v732, v733 = v730(v731, v732)
					if v732 == nil then
						break
					end
					v_u_713(v733)
				end
				spawn(function()
					-- upvalues: (ref) v_u_478, (ref) v_u_479
					wait(0.1)
					v_u_478.CanvasSize = UDim2.new(0, 0, 0, v_u_479.AbsoluteContentSize.Y + 10)
				end)
			end
		end
		local v_u_734 = false
		local function v_u_737(p735)
			-- upvalues: (ref) v_u_38, (ref) v_u_669, (ref) v_u_671
			local v736 = math.floor(p735 * 10 + 0.5)
			v_u_38.speed = v736 / 5
			v_u_669.Position = UDim2.new(p735, -6, 0.5, -6)
			v_u_671.Text = string.format("%d", v736)
		end
		local function v_u_739(p738)
			-- upvalues: (ref) v_u_667, (ref) v_u_737
			v_u_737((math.clamp((p738.Position.X - v_u_667.AbsolutePosition.X) / v_u_667.AbsoluteSize.X, 0, 1)))
		end
		local function v_u_740()
			-- upvalues: (ref) v_u_38, (ref) v_u_669, (ref) v_u_671
			v_u_38.speed = 1
			v_u_669.Position = UDim2.new(0.5, -6, 0.5, -6)
			v_u_671.Text = "5"
		end
		spawn(function()
			-- upvalues: (ref) v_u_669, (ref) v_u_671
			wait(0.1)
			v_u_669.Position = UDim2.new(0.5, -6, 0.5, -6)
			v_u_671.Text = "5"
		end)
		v_u_667.InputBegan:Connect(function(p741)
			-- upvalues: (ref) v_u_734, (ref) v_u_739
			if p741.UserInputType == Enum.UserInputType.MouseButton1 or p741.UserInputType == Enum.UserInputType.Touch then
				v_u_734 = true
				v_u_739(p741)
			end
		end)
		v_u_3.InputChanged:Connect(function(p742)
			-- upvalues: (ref) v_u_734, (ref) v_u_739
			if v_u_734 and (p742.UserInputType == Enum.UserInputType.MouseMovement or p742.UserInputType == Enum.UserInputType.Touch) then
				v_u_739(p742)
			end
		end)
		v_u_3.InputEnded:Connect(function(p743)
			-- upvalues: (ref) v_u_734
			if p743.UserInputType == Enum.UserInputType.MouseButton1 or p743.UserInputType == Enum.UserInputType.Touch then
				v_u_734 = false
			end
		end)
		v_u_672.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_740
			v_u_740()
		end)
		v_u_672.MouseEnter:Connect(function()
			-- upvalues: (ref) v_u_672
			v_u_672.BackgroundTransparency = 0.3
		end)
		v_u_672.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u_672
			v_u_672.BackgroundTransparency = 0.5
		end)
		v460.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_304, (ref) v_u_10, (ref) v_u_289, (ref) v_u_677
			v_u_304()
			if v_u_10 then
				v_u_289(false)
			end
			v_u_677:Destroy()
		end)
		v_u_458.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_645, (ref) v_u_644, (ref) v_u_700, (ref) v_u_6, (ref) v_u_444, (ref) v_u_458, (ref) v_u_480, (ref) v_u_675, (ref) v_u_648, (ref) v_u_641, (ref) v_u_485, (ref) v_u_548, (ref) v_u_577, (ref) v_u_676, (ref) v_u_478, (ref) v_u_476
			if not v_u_645 then
				v_u_645 = true
				if v_u_644 then
					local v744 = v_u_6:Create(v_u_444, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						["Size"] = UDim2.new(0, 280, 0, 395)
					})
					v_u_458.Text = "\226\136\146"
					v_u_644 = false
					v744:Play()
					v744.Completed:Connect(function()
						-- upvalues: (ref) v_u_700, (ref) v_u_480, (ref) v_u_675, (ref) v_u_648, (ref) v_u_641, (ref) v_u_485, (ref) v_u_548, (ref) v_u_577, (ref) v_u_676, (ref) v_u_478, (ref) v_u_476, (ref) v_u_645
						local v745, v746, v747 = pairs(v_u_700)
						while true do
							local v748
							v747, v748 = v745(v746, v747)
							if v747 == nil then
								break
							end
							if v748 ~= v_u_480 then
								if v748 ~= v_u_641 then
									if v748 ~= v_u_485 then
										if v748 ~= v_u_548 then
											if v748 ~= v_u_577 then
												if v748 ~= v_u_676 then
													if v748 == v_u_478 or v748 == v_u_476 then
														v748.Visible = v_u_675 ~= "states" and (v_u_675 ~= "size" and v_u_675 ~= "others")
													else
														v748.Visible = true
													end
												else
													v748.Visible = v_u_675 == "custom" or v_u_675 == "states"
												end
											else
												v748.Visible = v_u_675 == "others"
											end
										else
											v748.Visible = v_u_675 == "size"
										end
									else
										v748.Visible = v_u_675 == "states"
									end
								else
									v748.Visible = v_u_675 == "custom"
								end
							else
								local v749
								if v_u_675 ~= "custom" then
									v749 = false
								else
									v749 = v_u_648
								end
								v748.Visible = v749
							end
						end
						v_u_645 = false
					end)
				else
					local v750, v751, v752 = pairs(v_u_700)
					while true do
						local v753
						v752, v753 = v750(v751, v752)
						if v752 == nil then
							break
						end
						v753.Visible = false
					end
					local v754 = v_u_6:Create(v_u_444, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						["Size"] = UDim2.new(0, 280, 0, 30)
					})
					v_u_458.Text = "+"
					v_u_644 = true
					v754:Play()
					v754.Completed:Connect(function()
						-- upvalues: (ref) v_u_645
						v_u_645 = false
					end)
				end
			end
		end)
		v_u_476:GetPropertyChangedSignal("Text"):Connect(loadGUI)
		v_u_464.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_675, (ref) v_u_648, (ref) v_u_464, (ref) v_u_465, (ref) v_u_466, (ref) v_u_467, (ref) v_u_468, (ref) v_u_470, (ref) v_u_664
			v_u_675 = "all"
			v_u_648 = false
			v_u_464.BackgroundTransparency = 0.5
			v_u_465.BackgroundTransparency = 0.8
			v_u_466.BackgroundTransparency = 0.8
			v_u_467.BackgroundTransparency = 0.8
			v_u_468.BackgroundTransparency = 0.8
			v_u_470.BackgroundTransparency = 0.8
			v_u_664()
			loadGUI()
		end)
		v_u_465.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_675, (ref) v_u_465, (ref) v_u_464, (ref) v_u_466, (ref) v_u_467, (ref) v_u_470, (ref) v_u_664
			v_u_675 = "favorites"
			v_u_465.BackgroundTransparency = 0.5
			v_u_464.BackgroundTransparency = 0.8
			v_u_466.BackgroundTransparency = 0.8
			v_u_467.BackgroundTransparency = 0.8
			v_u_470.BackgroundTransparency = 0.8
			v_u_664()
			loadGUI()
		end)
		v_u_466.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_675, (ref) v_u_466, (ref) v_u_464, (ref) v_u_465, (ref) v_u_467, (ref) v_u_470, (ref) v_u_664
			v_u_675 = "custom"
			v_u_466.BackgroundTransparency = 0.5
			v_u_464.BackgroundTransparency = 0.8
			v_u_465.BackgroundTransparency = 0.8
			v_u_467.BackgroundTransparency = 0.8
			v_u_470.BackgroundTransparency = 0.8
			v_u_664()
			loadGUI()
		end)
		v_u_467.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_675, (ref) v_u_467, (ref) v_u_464, (ref) v_u_465, (ref) v_u_466, (ref) v_u_468, (ref) v_u_470, (ref) v_u_664
			v_u_675 = "states"
			v_u_467.BackgroundTransparency = 0.5
			v_u_464.BackgroundTransparency = 0.8
			v_u_465.BackgroundTransparency = 0.8
			v_u_466.BackgroundTransparency = 0.8
			v_u_468.BackgroundTransparency = 0.8
			v_u_470.BackgroundTransparency = 0.8
			v_u_664()
			loadGUI()
		end)
		v_u_468.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_675, (ref) v_u_468, (ref) v_u_464, (ref) v_u_465, (ref) v_u_466, (ref) v_u_467, (ref) v_u_470, (ref) v_u_664
			v_u_675 = "size"
			v_u_468.BackgroundTransparency = 0.5
			v_u_464.BackgroundTransparency = 0.8
			v_u_465.BackgroundTransparency = 0.8
			v_u_466.BackgroundTransparency = 0.8
			v_u_467.BackgroundTransparency = 0.8
			v_u_470.BackgroundTransparency = 0.8
			v_u_470.BackgroundTransparency = 0.8
			v_u_664()
			loadGUI()
		end)
		v_u_470.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_675, (ref) v_u_470, (ref) v_u_464, (ref) v_u_465, (ref) v_u_466, (ref) v_u_467, (ref) v_u_468, (ref) v_u_664
			v_u_675 = "others"
			v_u_470.BackgroundTransparency = 0.5
			v_u_464.BackgroundTransparency = 0.8
			v_u_465.BackgroundTransparency = 0.8
			v_u_466.BackgroundTransparency = 0.8
			v_u_467.BackgroundTransparency = 0.8
			v_u_468.BackgroundTransparency = 0.8
			v_u_664()
			loadGUI()
		end)
		v_u_641.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_648, (ref) v_u_480, (ref) v_u_641, (ref) v_u_478, (ref) v_u_481, (ref) v_u_483, (ref) v_u_678, (ref) v_u_49, (ref) v_u_39, (ref) v_u_135
			if v_u_648 then
				local v755 = v_u_481.Text
				local v756 = v_u_483.Text
				if v755 == "" or v756 == "" then
					v_u_678.Text = "Name and code required!"
					v_u_678.TextColor3 = Color3.new(1, 0.3, 0.3)
					spawn(function()
						-- upvalues: (ref) v_u_678
						wait(2)
						v_u_678.Text = "Ready"
						v_u_678.TextColor3 = Color3.new(0.7, 0.7, 0.7)
					end)
					return
				end
				v_u_49[v755] = v756
				v_u_39[v755] = v756
				v_u_135()
				v_u_481.Text = ""
				v_u_483.Text = ""
				v_u_648 = false
				v_u_480.Visible = false
				v_u_641.Text = "Add"
				v_u_641.BackgroundColor3 = Color3.new(0, 0, 0)
				v_u_478.Size = UDim2.new(1, -16, 1, -175)
				v_u_478.Position = UDim2.new(0, 8, 0, 105)
				v_u_678.Text = "Added: " .. v755
				v_u_678.TextColor3 = Color3.new(0.5, 1, 0.5)
				spawn(function()
					-- upvalues: (ref) v_u_678
					wait(2)
					v_u_678.Text = "Ready"
					v_u_678.TextColor3 = Color3.new(0.7, 0.7, 0.7)
				end)
				loadGUI()
			else
				v_u_648 = true
				v_u_480.Visible = true
				v_u_641.Text = "Save"
				v_u_641.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
				v_u_478.Size = UDim2.new(1, -16, 1, -270)
				v_u_478.Position = UDim2.new(0, 8, 0, 195)
			end
		end)
		v_u_641.MouseEnter:Connect(function()
			-- upvalues: (ref) v_u_641
			v_u_641.BackgroundTransparency = 0.3
		end)
		v_u_641.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u_641
			v_u_641.BackgroundTransparency = 0.5
		end)
		local v_u_757 = false
		local v_u_758 = nil
		local v_u_759 = nil
		local function v_u_761(p760)
			-- upvalues: (ref) v_u_757, (ref) v_u_758, (ref) v_u_759, (ref) v_u_444
			v_u_757 = true
			v_u_758 = p760.Position
			v_u_759 = v_u_444.Position
		end
		local function v_u_764(p762)
			-- upvalues: (ref) v_u_757, (ref) v_u_758, (ref) v_u_444, (ref) v_u_759
			if v_u_757 then
				local v763 = p762.Position - v_u_758
				v_u_444.Position = UDim2.new(v_u_759.X.Scale, v_u_759.X.Offset + v763.X, v_u_759.Y.Scale, v_u_759.Y.Offset + v763.Y)
			end
		end
		local function v_u_765()
			-- upvalues: (ref) v_u_757
			v_u_757 = false
		end
		v446.InputBegan:Connect(function(p766)
			-- upvalues: (ref) v_u_761
			if p766.UserInputType == Enum.UserInputType.MouseButton1 or p766.UserInputType == Enum.UserInputType.Touch then
				v_u_761(p766)
			end
		end)
		v_u_3.InputChanged:Connect(function(p767)
			-- upvalues: (ref) v_u_764
			if p767.UserInputType == Enum.UserInputType.MouseMovement or p767.UserInputType == Enum.UserInputType.Touch then
				v_u_764(p767)
			end
		end)
		v_u_3.InputEnded:Connect(function(p768)
			-- upvalues: (ref) v_u_765
			if p768.UserInputType == Enum.UserInputType.MouseButton1 or p768.UserInputType == Enum.UserInputType.Touch then
				v_u_765()
			end
		end)
		v_u_678.Text = "Loading animations..."
		spawn(function()
			-- upvalues: (ref) v_u_39, (ref) v_u_678
			wait(1)
			local v769, v770, v771 = pairs(v_u_39)
			local v772 = 0
			while true do
				v771 = v769(v770, v771)
				if v771 == nil then
					break
				end
				v772 = v772 + 1
			end
			v_u_678.Text = "Loaded " .. v772 .. " animations"
			v_u_678.TextColor3 = Color3.new(0.5, 1, 0.5)
			loadGUI()
			spawn(function()
				-- upvalues: (ref) v_u_678
				wait(2)
				v_u_678.Text = "Ready"
				v_u_678.TextColor3 = Color3.new(0.7, 0.7, 0.7)
			end)
		end)
	end
end
v_u_3.InputBegan:Connect(function(p774, p775)
	-- upvalues: (ref) v_u_48, (ref) v_u_49, (ref) v_u_39, (ref) v_u_47, (ref) v_u_402
	if p775 then
		return
	end
	local v776, v777, v778 = pairs(v_u_48)
	while true do
		local v779
		v778, v779 = v776(v777, v778)
		if v778 == nil then
			break
		end
		if p774.KeyCode == v779 then
			local v780 = v_u_49[v778] or (v_u_39[v778] or v_u_47[v778])
			if v780 then
				v_u_402(tostring(v780))
			end
			break
		end
	end
end)
task.spawn(function()
	-- upvalues: (ref) v_u_145, (ref) v_u_118, (ref) v_u_773
	v_u_145()
	v_u_118()
	v_u_773()
end)
print("AK Reanim loaded!")
