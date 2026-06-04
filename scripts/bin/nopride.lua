if not game:IsLoaded() then
    game.Loaded:Wait()
end

local QueueTeleport     = queue_on_teleport or queueonteleport

QueueTeleport('loadstring(game:HttpGet("https://yourscoper.vercel.app/nopride.lua"))()')

local map = workspace.map

workspace.Baseplate.Color = Color3.fromRGB(94, 255, 129)

for _, v in ipairs(map:GetDescendants()) do
	if v:IsA("BasePart") then
		local n, m = v.Name, v.Material

		if not v:IsDescendantOf(map.booth) and not v:IsDescendantOf(map.school) then
			v.Color = Color3.fromRGB(200, 200, 200)

			if n == "platform" then
				v.Color = Color3.fromRGB(94, 255, 129)
			elseif n == "No" and v:IsA("MeshPart") and v.MeshId == "rbxassetid://139829181741741" then
				v.Color = Color3.fromRGB(94, 255, 129)
			elseif n == "No" and m == Enum.Material.WoodPlanks then
				v.Color = Color3.fromRGB(158, 109, 82)
			elseif n == "Union" and m == Enum.Material.Fabric and v:IsDescendantOf(map.platform.Model) then
				v.Color = Color3.fromRGB(75, 75, 75)
			elseif n == "picnic" and m == Enum.Material.WoodPlanks then
				v.Color = Color3.fromRGB(158, 109, 82)
			elseif m == Enum.Material.Foil then
				v.Color = Color3.fromRGB(115, 157, 240)
			elseif m == Enum.Material.DiamondPlate then
				v.Color = Color3.fromRGB(125, 125, 125)
			elseif m == Enum.Material.Sand then
				v.Color = Color3.fromRGB(252, 243, 144)
			elseif m == Enum.Material.Wood then
				v.Color = Color3.fromRGB(128, 101, 80)
			elseif n == "Union" then
				v.Color = Color3.fromRGB(67, 145, 68)
			end
		elseif v:IsDescendantOf(map.booth) and v.Size == Vector3.new(27, 0.25, 27) then
			v.Color = Color3.fromRGB(125, 125, 125)
		elseif v:IsDescendantOf(map.school) then
			if m == Enum.Material.Brick then
				v.Color = Color3.fromRGB(163, 65, 65)
			elseif m == Enum.Material.Wood then
				v.Color = Color3.fromRGB(125, 86, 59)
			elseif m == Enum.Material.Rubber and math.abs(v.Position.Y - 6.125) < 0.1 then
				v.Color = Color3.fromRGB(125, 86, 59)
			elseif m == Enum.Material.Rubber and math.abs(v.Position.Y - 4.625) < 0.1 then
				v.Color = Color3.fromRGB(125, 86, 59)
			elseif m == Enum.Material.Carpet then
				v.Color = Color3.fromRGB(92, 24, 24)
			else
				v.Color = Color3.fromRGB(150, 150, 150)
			end
		end
	end
end

--[[for _, v in ipairs(map:GetDescendants()) do
	if v:IsA("BasePart") and not v:IsDescendantOf(map.booth) and not v:IsDescendantOf(map.school) then
		local n, m = v.Name, v.Material

		v.Color = Color3.fromRGB(200, 200, 200)

		if n == "platform" then
			v.Color = Color3.fromRGB(94, 255, 129)
		elseif n == "No" and v:IsA("MeshPart") and v.MeshId == "rbxassetid://139829181741741" then
			v.Color = Color3.fromRGB(94, 255, 129)
		elseif n == "No" and m == Enum.Material.WoodPlanks then
			v.Color = Color3.fromRGB(158, 109, 82)
		elseif n == "Union" and m == Enum.Material.Fabric and v:IsDescendantOf(map.platform.Model) then
			v.Color = Color3.fromRGB(75, 75, 75)
		elseif n == "picnic" and m == Enum.Material.WoodPlanks then
			v.Color = Color3.fromRGB(158, 109, 82)
		elseif m == Enum.Material.Foil then
			v.Color = Color3.fromRGB(115, 157, 240)
		elseif m == Enum.Material.Sand then
			v.Color = Color3.fromRGB(252, 243, 144)
		elseif m == Enum.Material.Wood then
			v.Color = Color3.fromRGB(128, 101, 80)
		elseif n == "Union" then
			v.Color = Color3.fromRGB(67, 145, 68)
		end
	elseif v:IsA("BasePart") and v:IsDescendantOf(map.booth)
		and v.Size == Vector3.new(27, 0.25, 27) then
		v.Color = Color3.fromRGB(125, 125, 125)
	elseif v:IsA("BasePart") and v:IsDescendantOf(map.school)
		if v.Material == Enum.Material.Brick then
			v.Color = Color3.fromRGB(0, 0, 0)
		end
	end
end]]

for _, v in ipairs(map.obby:GetDescendants()) do
	if v:IsA("BasePart") then
		local n, m = v.Name, v.Material
	
		if m == Enum.Material.Foil then
			v.Color = Color3.fromRGB(125, 125, 125)
		elseif m == Enum.Material.Sand then
			v.Color = Color3.fromRGB(200, 200, 200)
		elseif m == Enum.Material.Wood then
			v.Color = Color3.fromRGB(200, 200, 200)
		end
	end
end

for _, v in ipairs(map.spawn:GetDescendants()) do
	if v:IsA("BasePart") then
		local n, m = v.Name, v.Material

		if n == "Union" and m == Enum.Material.Wood then
			v.Color = Color3.fromRGB(255, 255, 255)
		end
	end
end

for _, v in ipairs(map.runway:GetDescendants()) do
	if v:IsA("BasePart") and v.Name == "Union" and v.Material == Enum.Material.CeramicTiles then
		v.Color = Color3.fromRGB(150, 150, 150)
	elseif v:IsA("BasePart") and v.Name == "No" and v.Material == Enum.Material.Sand then
		v.Color = Color3.fromRGB(125, 125, 125)
	end
end

for _, v in ipairs(map.middle.picnic:GetDescendants()) do
	if v:IsA("BasePart") and v.Name == "No" and v.Material == Enum.Material.Grass then
		v.Color = Color3.fromRGB(90, 237, 124)
	end
end

for _, v in ipairs(map.middle.performance.Model:GetDescendants()) do
	if v:IsA("BasePart") then
		v.Color = (v.Name == "Speaker" and Color3.fromRGB(26, 56, 20))
			or ((v.Name == "Base" or v.Name == "Part") and Color3.fromRGB(0, 0, 0))
			or v.Color
	end
end

for _, v in ipairs(map.donut_shop:GetDescendants()) do
	if v:IsA("Part") then
		if v.Material == Enum.Material.WoodPlanks then
			v.Color = Color3.fromRGB(87, 60, 45)
		end
	elseif v:IsA("MeshPart") and v.Name == "Delete" and v.MeshId == "rbxassetid://74450019646160" then
		v.Color = Color3.fromRGB(207, 199, 149)
	elseif v:IsA("MeshPart") and v.Name == "Delete" and v.MeshId == "rbxassetid://70904270175624" then
		v.Color = Color3.fromRGB(255, 117, 255)

		local threshold = 2

		if (v.Position - Vector3.new(-264.086, 6.638, -198.469)).Magnitude <= threshold then
			v.Color = Color3.fromRGB(0, 0, 0)
		elseif (v.Position - Vector3.new(-267.0, 6.63, -198.4)).Magnitude <= threshold then
			v.Color = Color3.fromRGB(159, 214, 255)
		elseif (v.Position - Vector3.new(-283, 17.735, -195)).Magnitude <= threshold then
			v.Color = Color3.fromRGB(223, 255, 121)
		elseif (v.Position - Vector3.new(-290, 17.735, -183)).Magnitude <= threshold then
			v.Color = Color3.fromRGB(125, 125, 125)
		end
	end
end

for _, v in ipairs(map.donut_shop.untitled:GetDescendants()) do
	if v:IsA("MeshPart") and v.Name == "Delete" then
		v.Color = Color3.fromRGB(207, 199, 149)
	elseif v:IsA("MeshPart") and v.Name == "Delete.001" then
		v.Color = Color3.fromRGB(255, 117, 255)
	end
end

for _, v in ipairs(map.jail.Model.bar:GetDescendants()) do
	if v:IsA("BasePart") and v.Name == "no" then
		v.Color = Color3.fromRGB(85, 173, 171)
	end
end

for _, v in ipairs(map.soccer:GetDescendants()) do
	if v:IsA("BasePart") and v.Name == "No"
		and v.Size == Vector3.new(34.994, 1, 81) then
		v.Color = Color3.fromRGB(222, 208, 160)
	end
end

for _, v in ipairs(map.happy_home:GetDescendants()) do
	if v:IsA("BasePart") and v.Name == "no" then
		if v.Material == Enum.Material.Foil then
			v.Color = Color3.fromRGB(115, 157, 240)

			for _, tub in next, v.Parent:GetChildren() do
				if tub.Material ~= Enum.Material.Foil then
					tub.Color = Color3.fromRGB(255, 255, 255)
				end
			end
		elseif v.Size == Vector3.new(57, 1, 57) then
			v.Color = Color3.fromRGB(74, 186, 101)
		elseif v.Size == Vector3.new(1, 3, 5) then
			v.Color = Color3.fromRGB(255, 255, 255)
		elseif v.Size == Vector3.new(1, 1, 5) then
			v.Color = Color3.fromRGB(255, 255, 255)
		elseif v.Size == Vector3.new(1, 5, 5) then
			v.Color = Color3.fromRGB(255, 255, 255)
		elseif v.Size == Vector3.new(1, 5, 7) then
			v.Color = Color3.fromRGB(35, 35, 35)
		elseif v.Size == Vector3.new(0.25, 1.5, 1.5) then
			v.Color = Color3.fromRGB(125, 5, 5)
		elseif v.Size == Vector3.new(7, 5, 1) then
			v.Color = Color3.fromRGB(255, 255, 255)
		elseif v.Size == Vector3.new(0.25, 0.75, 0.75) then
			v.Color = Color3.fromRGB(25, 25, 25)
		elseif v.Size == Vector3.new(7, 5, -1) then
			v.Color = Color3.fromRGB(255, 255, 255)
		elseif v.Size == Vector3.new(10, 3, 3) then
			v.Color = Color3.fromRGB(75, 75, 75)
		elseif v.Size == Vector3.new(1, 12, 14) then
			v.Color = Color3.fromRGB(155, 45, 25)
		elseif v.Size == Vector3.new(1, 10, 3) then
			v.Color = Color3.fromRGB(255, 255, 255)
		elseif v.Size == Vector3.new(1, 3, 7) then
			v.Color = Color3.fromRGB(255, 255, 255)
		elseif v.Size == Vector3.new(1, 12, 17) then
			v.Color = Color3.fromRGB(89, 80, 60)
		elseif v.Size == Vector3.new(1, 12, 1) then
			v.Color = Color3.fromRGB(89, 80, 60)
		elseif v.Size == Vector3.new(5, 12, 1) then
			v.Color = Color3.fromRGB(89, 80, 60)
		elseif v.Size == Vector3.new(1, 12, 3) then
			v.Color = Color3.fromRGB(89, 80, 60)
		elseif v.Size == Vector3.new(3, 2, 1) then
			v.Color = Color3.fromRGB(89, 80, 60)
		elseif v.Size == Vector3.new(1, 2, 2) and math.abs(v.Position.Y - 14) < 0.1 then
			v.Color = Color3.fromRGB(189, 184, 134)
		elseif v.Size == Vector3.new(1, 1, 2) and math.abs(v.Position.Y - 14.5) < 0.1 then
			v.Color = Color3.fromRGB(189, 184, 134)
		elseif v.Size == Vector3.new(5, 3, 3) and math.abs(v.Position.Y - 8.5) < 0.1 then
			v.Color = Color3.fromRGB(60, 60, 60)
		elseif v.Size == Vector3.new(2, 0.25, 2) and math.abs(v.Position.Y - 8.5) < 0.1 then
			v.Color = Color3.fromRGB(90, 90, 90)
		elseif v.Size == Vector3.new(2, 3, 7) and math.abs(v.Position.Y - 7) < 0.1 then
			v.Color = Color3.fromRGB(60, 60, 60)
		elseif v.Size == Vector3.new(1, 7, 2) then
			v.Color = Color3.fromRGB(89, 80, 60)
		elseif v.Size == Vector3.new(13, 3, 2) then
			v.Color = Color3.fromRGB(50, 50, 50)
		elseif v.Size == Vector3.new(13, 2, 2) then
			v.Color = Color3.fromRGB(50, 50, 50)
		elseif v.Size == Vector3.new(13, 1, 2) then
			v.Color = Color3.fromRGB(50, 50, 50)
		elseif v.Size == Vector3.new(1, 2, 2) then
			v.Color = Color3.fromRGB(89, 80, 60)
		elseif v.Size == Vector3.new(3, 1, 2) then
			v.Color = Color3.fromRGB(89, 80, 60)
		elseif v.Size == Vector3.new(47, 3, 47) then
			v.Color = Color3.fromRGB(50, 50, 50)
		elseif v.Size == Vector3.new(2, 1, 5) then
			v.Color = Color3.fromRGB(25, 75, 175)
		elseif v.Size == Vector3.new(1, 1, 2) then
			v.Color = Color3.fromRGB(89, 80, 60)
		elseif v.Size == Vector3.new(11, 1, 2) then
			v.Color = Color3.fromRGB(89, 80, 60)
		elseif v.Size == Vector3.new(1, 5, 2) and math.abs(v.Position.Y - 9.5) < 0.1 then
			v.Color = Color3.fromRGB(70, 70, 70)
		elseif v.Size == Vector3.new(12, 1, 2) and math.abs(v.Position.Y - 12.5) < 0.1 then
			v.Color = Color3.fromRGB(70, 70, 70)
		elseif v.Size == Vector3.new(12, 1, 2) and math.abs(v.Position.Y - 6.5) < 0.1 then
			v.Color = Color3.fromRGB(70, 70, 70)
		elseif v.Size == Vector3.new(1, 5, 2) then
			v.Color = Color3.fromRGB(89, 80, 60)
		elseif v.Size == Vector3.new(7, 1, 2) then
			v.Color = Color3.fromRGB(89, 80, 60)
		elseif v.Size == Vector3.new(1, 2, 1) then
			v.Color = Color3.fromRGB(89, 80, 60)
		elseif v.Size == Vector3.new(3, 3, 1) then
			v.Color = Color3.fromRGB(89, 80, 60)
		elseif v.Size == Vector3.new(1, 12, 18) then
			v.Color = Color3.fromRGB(89, 80, 60)
		elseif v.Size == Vector3.new(0.25, 12, 14) then
			v.Color = Color3.fromRGB(89, 80, 60)
		elseif v.Size == Vector3.new(0.5, 14, 0.25) then
			v.Color = Color3.fromRGB(89, 80, 60)
		elseif v.Size == Vector3.new(0.25, 3, 3) then
			v.Color = Color3.fromRGB(100, 100, 100)
		elseif v.Size == Vector3.new(1, 1, 3) then
			v.Color = Color3.fromRGB(255, 255, 255)
		elseif v.Size == Vector3.new(1, 1, 1) then
			v.Color = Color3.fromRGB(255, 255, 255)
		else
			v.Color = (v.Size.X == 51)
				and Color3.fromRGB(255, 56, 56)
				or Color3.fromRGB(189, 184, 134)
		end
	end
end

for _, c in ipairs(map.happy_home:GetDescendants()) do
	if c:IsA("Model") or c:IsA("Folder") then
		local count = 0

		for _, child in ipairs(c:GetChildren()) do
			if child.Name == "object" then
				count += 1
			end
		end

		if count == 2 then
			for _, d in ipairs(c:GetDescendants()) do
				if d:IsA("BasePart") and d.Name == "no" then
					d.Color = Color3.fromRGB(71, 129, 145)
				end
			end
		end
	end
end

for _, v in ipairs(workspace.event:GetDescendants()) do
	v:Destroy()
end

for _, v in ipairs(workspace:GetDescendants()) do
	if v:IsA("Decal") and v.Parent:IsA("BasePart")
		and not v:IsDescendantOf(map.conveyer) and not v:IsDescendantOf(map.happy_home) then
		v:Destroy()
	end
end

for _, v in ipairs(map.conveyer:GetDescendants()) do
	if v:IsA("BasePart") and v:FindFirstChild("Texture") then
		v.Texture.Color3 = Color3.fromRGB(255, 255, 255)
	end
end
