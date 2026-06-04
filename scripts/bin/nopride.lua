local map = workspace.map

workspace.Baseplate.Color = Color3.fromRGB(94, 255, 129)

for _, v in ipairs(map:GetDescendants()) do
	if v:IsA("BasePart") and not v:IsDescendantOf(map.booth) then
		local n, m = v.Name, v.Material

		v.Color = Color3.fromRGB(200, 200, 200)

		if n == "platform" then
			v.Color = Color3.fromRGB(94, 255, 129)
		elseif n == "No" and v:IsA("MeshPart") and v.MeshId == "rbxassetid://139829181741741" then
			v.Color = Color3.fromRGB(94, 255, 129)
		elseif n == "No" and m == Enum.Material.WoodPlanks then
			v.Color = Color3.fromRGB(158, 109, 82)
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
	end
end

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
