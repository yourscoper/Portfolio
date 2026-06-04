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
		end
	elseif v:IsA("BasePart") and v:IsDescendantOf(map.booth)
		and v.Size == Vector3.new(27, 0.25, 27) then
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
		v.Color = (v.Name == "Speaker" and Color3.fromRGB(26,56,20))
			or ((v.Name == "Base" or v.Name == "Part") and Color3.fromRGB(0,0,0))
			or v.Color
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
		local parent = v.Parent

		if v.Material == Enum.Material.Foil then
			v.Color = Color3.fromRGB(115, 157, 240)

			for _, p in ipairs(parent:GetChildren()) do
				if p:IsA("BasePart") and p.Material ~= Enum.Material.Foil then
					p.Color = Color3.fromRGB(255,255,255)
				end
			end

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
		and v.Parent ~= map.conveyer then
		v:Destroy()
	end
end

for _, v in ipairs(map.conveyer:GetDescendants()) do
	if v:IsA("BasePart") and v:FindFirstChild("Texture") then
		v.Texture.Color3 = Color3.fromRGB(255,255,255)
	end
end
