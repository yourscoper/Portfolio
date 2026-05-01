local InputService              = Game:GetService("UserInputService");
local TweenService              = Game:GetService("TweenService");
local CoreGui                   = Game:GetService("CoreGui");
local Players                   = Game:GetService("Players");

local CurrentCamera             = Workspace.CurrentCamera
local Terrain                   = Workspace.Terrain
local Camera                    = Workspace.Camera

local Player                    = Players.LocalPlayer

local ScopersUILibrary = {
    Pages = {},
    Visible = true,
    ToggleKey = nil,
    OnUnload = nil,
    OnCustomAction = nil,

    ScopersUIDragSettings = {
        Colors = {
            Background = Color3.fromRGB(25, 25, 25),
            Surface = Color3.fromRGB(26, 26, 32),
            SurfaceHover = Color3.fromRGB(45, 45, 45),
            Elevated = Color3.fromRGB(32, 32, 40),
            AccentDim = Color3.fromRGB(55, 55, 55),
            Danger = Color3.fromRGB(200, 68, 68),
            Border = Color3.fromRGB(50, 50, 65),
            BorderActive = Color3.fromRGB(90, 90, 90),
            ScopersUIMainStrokeColor = Color3.fromRGB(255, 255, 255),
            TextPrimary = Color3.fromRGB(240, 240, 255),
            TextSecondary = Color3.fromRGB(255, 255, 255),
            TextMuted = Color3.fromRGB(85, 85, 105),
            SectionBg = Color3.fromRGB(22, 22, 28),
            ToggleOn = Color3.fromRGB(100, 100, 110),
            SliderFill = Color3.fromRGB(110, 110, 130),
            Neutral = Color3.fromRGB(70, 70, 70),
            NeutralHover = Color3.fromRGB(90, 90, 90),
            NeutralPress = Color3.fromRGB(55, 55, 55)
        },

        Speed = 0.05,
        Toggle = false,
        Start = nil,
        InitialPosition = nil
    }
}

local ScopersCommands = CoreGui and CoreGui:FindFirstChild("ScopersCommands");

local function ScopersUILibraryTween(obj, props, t, style, dir)
	TweenService:Create(obj, TweenInfo.new(t or 0.18, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out), props):Play()
end

local function UpdateDragV3(input, frame)
    pcall(function()
        local CBaseX = ScopersUILibrary.ScopersUIDragSettings.InitialPosition.X.Scale * frame.Parent.AbsoluteSize.X + ScopersUILibrary.ScopersUIDragSettings.InitialPosition.X.Offset
        local CBaseY = ScopersUILibrary.ScopersUIDragSettings.InitialPosition.Y.Scale * frame.Parent.AbsoluteSize.Y + ScopersUILibrary.ScopersUIDragSettings.InitialPosition.Y.Offset

        local UpdateXAxis = CBaseX + (input.Position - ScopersUILibrary.ScopersUIDragSettings.Start).X
        local UpdateYAxis = CBaseY + (input.Position - ScopersUILibrary.ScopersUIDragSettings.Start).Y

        UpdateXAxis = math.clamp(UpdateXAxis, 5, frame.Parent.AbsoluteSize.X - frame.AbsoluteSize.X - 5)
        UpdateYAxis = math.clamp(UpdateYAxis, -50, frame.Parent.AbsoluteSize.Y - frame.AbsoluteSize.Y - 5)

        TweenService:Create(frame, TweenInfo.new(ScopersUILibrary.ScopersUIDragSettings.Speed), {Position = UDim2.new(0, UpdateXAxis, 0, UpdateYAxis)}):Play()
    end)
end

local ScopersUI = Instance.new("Frame", ScopersCommands)
ScopersUI.Name = "ScopersUI"
ScopersUI.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Background
ScopersUI.BackgroundTransparency = 0.5
ScopersUI.Size = UDim2.fromOffset(780, 0)
ScopersUI.Position = UDim2.fromScale(0.35, 0.25)
ScopersUI.ClipsDescendants = true

Instance.new("UICorner", ScopersUI).CornerRadius = UDim.new(0, 12)

local ScopersUIMainStroke = Instance.new("UIStroke", ScopersUI)
ScopersUIMainStroke.Color = ScopersUILibrary.ScopersUIDragSettings.Colors.ScopersUIMainStrokeColor
ScopersUIMainStroke.Thickness = 1.5

local ScopersUIMainSidebar = Instance.new("Frame")
ScopersUIMainSidebar.Size = UDim2.new(0, 180, 1, 0)
ScopersUIMainSidebar.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Surface
ScopersUIMainSidebar.BackgroundTransparency = 0.5
ScopersUIMainSidebar.BorderSizePixel = 0
ScopersUIMainSidebar.Parent = ScopersUI

Instance.new("UICorner", ScopersUIMainSidebar).CornerRadius = UDim.new(0, 12)

local ScopersUISidebarCover = Instance.new("Frame")
ScopersUISidebarCover.Size = UDim2.new(0, 12, 1, 0)
ScopersUISidebarCover.Position = UDim2.new(1, -12, 0, 0)
ScopersUISidebarCover.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Surface
ScopersUISidebarCover.BackgroundTransparency = 0.5
ScopersUISidebarCover.BorderSizePixel = 0
ScopersUISidebarCover.Parent = ScopersUIMainSidebar

local SetDescendant = ScopersUIMainSidebar:FindFirstChildWhichIsA("Frame", true)

if SetDescendant and SetDescendant ~= ScopersUISidebarCover then
	SetDescendant.Position = UDim2.new(1, 0, 0, 0)
	SetDescendant.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Border
	SetDescendant.BorderSizePixel = 0
end

local ScopersUILogoFrame = Instance.new("Frame")
ScopersUILogoFrame.Size = UDim2.new(1, 0, 0, 60)
ScopersUILogoFrame.BackgroundTransparency = 1
ScopersUILogoFrame.Parent = ScopersUIMainSidebar

local ScopersUILogoText = Instance.new("TextLabel")
ScopersUILogoText.Size = UDim2.new(1, -20, 1, 0)
ScopersUILogoText.Position = UDim2.new(0, 10, 0, 0)
ScopersUILogoText.BackgroundTransparency = 1
ScopersUILogoText.Text = "◈  Scoper's Commands"
ScopersUILogoText.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
ScopersUILogoText.TextSize = 14
ScopersUILogoText.TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextPrimary
ScopersUILogoText.TextXAlignment = Enum.TextXAlignment.Left
ScopersUILogoText.Parent = ScopersUILogoFrame

local ScopersUILogoDivider = Instance.new("Frame")
ScopersUILogoDivider.Size = UDim2.new(1, -20, 0, 1)
ScopersUILogoDivider.Position = UDim2.new(0, 10, 1, -1)
ScopersUILogoDivider.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Border
ScopersUILogoDivider.BorderSizePixel = 0
ScopersUILogoDivider.Parent = ScopersUILogoFrame

local ScopersUITabList = Instance.new("ScrollingFrame")
ScopersUITabList.Size = UDim2.new(1, 0, 1, -70)
ScopersUITabList.Position = UDim2.new(0, 0, 0, 65)
ScopersUITabList.BackgroundTransparency = 1
ScopersUITabList.ScrollBarThickness = 2
ScopersUITabList.ScrollBarImageColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Neutral
ScopersUITabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScopersUITabList.CanvasSize = UDim2.new()
ScopersUITabList.Parent = ScopersUIMainSidebar

local ScopersUITabListLayout = Instance.new("UIListLayout", ScopersUITabList)
ScopersUITabListLayout.Padding = UDim.new(0, 4)

local ScopersUITabListPad = Instance.new("UIPadding", ScopersUITabList)

ScopersUITabListPad.PaddingLeft = UDim.new(0, 10)
ScopersUITabListPad.PaddingRight = UDim.new(0, 10)
ScopersUITabListPad.PaddingTop = UDim.new(0, 4)

local ScopersUIContentFrame = Instance.new("Frame")
ScopersUIContentFrame.Size = UDim2.new(1, -181, 1, 0)
ScopersUIContentFrame.Position = UDim2.new(0, 181, 0, 0)
ScopersUIContentFrame.BackgroundTransparency = 1
ScopersUIContentFrame.Parent = ScopersUI

local ScopersUITopBar = Instance.new("Frame")

ScopersUITopBar.Size = UDim2.new(1, 0, 0, 50)
ScopersUITopBar.BackgroundTransparency = 1
ScopersUITopBar.Parent = ScopersUIContentFrame

local ScopersUIPageTitle = Instance.new("TextLabel")

ScopersUIPageTitle.Size = UDim2.new(1, -210, 1, 0)
ScopersUIPageTitle.Position = UDim2.new(0, 16, 0, 0)
ScopersUIPageTitle.BackgroundTransparency = 1
ScopersUIPageTitle.Text = "Home"
ScopersUIPageTitle.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
ScopersUIPageTitle.TextSize = 18
ScopersUIPageTitle.TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextPrimary
ScopersUIPageTitle.TextXAlignment = Enum.TextXAlignment.Left
ScopersUIPageTitle.Parent = ScopersUITopBar

local ScopersUITopDivider = Instance.new("Frame")

ScopersUITopDivider.Size = UDim2.new(1, -16, 0, 1)
ScopersUITopDivider.Position = UDim2.new(0, 0, 1, -1)
ScopersUITopDivider.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Border
ScopersUITopDivider.BorderSizePixel = 0
ScopersUITopDivider.Parent = ScopersUITopBar

local ScopersUIButtonHolder = Instance.new("Frame")
ScopersUIButtonHolder.Size = UDim2.new(0, 200, 0, 28)
ScopersUIButtonHolder.Position = UDim2.new(1, -206, 0.5, -14)
ScopersUIButtonHolder.BackgroundTransparency = 1
ScopersUIButtonHolder.Parent = ScopersUITopBar

local ScopersUIButtonHolderLayout = Instance.new("UIListLayout", ScopersUIButtonHolder)

ScopersUIButtonHolderLayout.FillDirection = Enum.FillDirection.Horizontal
ScopersUIButtonHolderLayout.VerticalAlignment = Enum.VerticalAlignment.Center
ScopersUIButtonHolderLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
ScopersUIButtonHolderLayout.Padding = UDim.new(0, 5)

local function ScoperMakeTopButton(CheckLabel, Widget, InsertOrder, CheckImage, callback)
	local ScopersButtonConnection
	if CheckImage then
		ScopersButtonConnection = Instance.new("ImageButton")
		ScopersButtonConnection.Image = "http://www.roblox.com/asset/?id=84826198167974"
		ScopersButtonConnection.ScaleType = Enum.ScaleType.Fit
	else
		ScopersButtonConnection = Instance.new("TextButton")
		ScopersButtonConnection.Text = CheckLabel
		ScopersButtonConnection.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json")
		ScopersButtonConnection.TextSize = 11
		ScopersButtonConnection.TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextSecondary
		ScopersButtonConnection.AutoButtonColor = false
	end
	
    ScopersButtonConnection.Size = UDim2.fromOffset(Widget, 28)
	ScopersButtonConnection.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
	ScopersButtonConnection.BackgroundTransparency = 0
	ScopersButtonConnection.LayoutOrder = InsertOrder
	ScopersButtonConnection.Parent = ScopersUIButtonHolder
	
    Instance.new("UICorner", ScopersButtonConnection).CornerRadius = UDim.new(0, 6)
	
    local ScoperCreateStroke = Instance.new("UIStroke", ScopersButtonConnection)
	ScoperCreateStroke.Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Border
	ScoperCreateStroke.Thickness = 1
    
	ScopersButtonConnection.MouseEnter:Connect(function()
		ScopersUILibraryTween(ScopersButtonConnection, {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}, 0.12)
		ScopersUILibraryTween(ScoperCreateStroke, {Color = ScopersUILibrary.ScopersUIDragSettings.Colors.BorderActive}, 0.12)
	end)
	ScopersButtonConnection.MouseLeave:Connect(function()
		ScopersUILibraryTween(ScopersButtonConnection, {BackgroundColor3 = Color3.fromRGB(30, 30, 38)}, 0.12)
		ScopersUILibraryTween(ScoperCreateStroke, {Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Border}, 0.12)
	end)
	return ScopersButtonConnection, ScoperCreateStroke
end

local ScopersCustomButton, _ = ScoperMakeTopButton("", 28, 1, true)
ScopersCustomButton.MouseButton1Click:Connect(function()
	if ScopersUILibrary.OnCustomAction then ScopersUILibrary.OnCustomAction() end
end)

local ScopersUnloadButton, unloadStroke = ScoperMakeTopButton("Unload", 58, 2, false)
ScopersUnloadButton.MouseEnter:Connect(function()
	ScopersUILibraryTween(ScopersUnloadButton, {BackgroundColor3 = Color3.fromRGB(70, 25, 25)}, 0.12)
	ScopersUILibraryTween(unloadStroke, {Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Danger}, 0.12)
	ScopersUILibraryTween(ScopersUnloadButton, {TextColor3 = Color3.fromRGB(230, 90, 90)}, 0.12)
end)
ScopersUnloadButton.MouseLeave:Connect(function()
	ScopersUILibraryTween(ScopersUnloadButton, {BackgroundColor3 = Color3.fromRGB(30, 30, 38)}, 0.12)
	ScopersUILibraryTween(unloadStroke, {Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Border}, 0.12)
	ScopersUILibraryTween(ScopersUnloadButton, {TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextSecondary}, 0.12)
end)
ScopersUnloadButton.MouseButton1Click:Connect(function()
	if ScopersUILibrary.OnUnload then ScopersUILibrary.OnUnload() end
end)

local ScopersToggleHintButton, ScopersToggleHintStroke = ScoperMakeTopButton("Toggle: T", 72, 3, false)

local ScopersUIKeyListen = false

local Scopers_Ignored_Keys = {
	[Enum.KeyCode.Unknown] = true,
	[Enum.KeyCode.Backspace] = true,
	[Enum.KeyCode.Return] = true,
	[Enum.KeyCode.Escape] = true,
	[Enum.KeyCode.CapsLock] = true,
	[Enum.KeyCode.Tab] = true,
	[Enum.KeyCode.LeftShift] = true,
	[Enum.KeyCode.RightShift] = true,
	[Enum.KeyCode.LeftControl] = true,
	[Enum.KeyCode.RightControl] = true,
	[Enum.KeyCode.LeftAlt] = true,
	[Enum.KeyCode.RightAlt] = true,
	[Enum.KeyCode.LeftMeta] = true,
	[Enum.KeyCode.RightMeta] = true,
}

ScopersToggleHintButton.MouseButton1Click:Connect(function()
	if ScopersUIKeyListen then
        return
    end
	
    ScopersUIKeyListen = true
	ScopersToggleHintButton.Text = "Press a key..."
	
    ScopersUILibraryTween(ScopersToggleHintButton, {BackgroundColor3 = Color3.fromRGB(55, 55, 30)}, 0.12)
	ScopersUILibraryTween(ScopersToggleHintStroke, {Color = Color3.fromRGB(125, 125, 255)}, 0.12)
end)

InputService.InputBegan:Connect(function(GetInput, GameProcessed)
	if ScopersUIKeyListen then
		if GetInput.UserInputType == Enum.UserInputType.Keyboard and not Scopers_Ignored_Keys[GetInput.KeyCode] then
			ScopersUIKeyListen = false
			ScopersUILibrary.ToggleKey = GetInput.KeyCode
			local KeyName = GetInput.KeyCode.Name
			ScopersToggleHintButton.Text = "Toggle: " .. KeyName
			ScopersUILibraryTween(ScopersToggleHintButton, {BackgroundColor3 = Color3.fromRGB(30, 30, 38)}, 0.18)
			ScopersUILibraryTween(ScopersToggleHintStroke, {Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Border}, 0.18)
		end
		return
	end

	if GameProcessed then
        return
    end

	if GetInput.KeyCode == ScopersUILibrary.ToggleKey then
		local GetVisibility = not ScopersUILibrary.Visible
		ScopersUILibrary.Visible = GetVisibility
		if GetVisibility then
			ScopersUI.Visible = true
			ScopersUILibraryTween(ScopersUI, {Size = UDim2.fromOffset(780, 520)}, 0.25, Enum.EasingStyle.Back)
		else
			ScopersUILibraryTween(ScopersUI, {Size = UDim2.fromOffset(780, 0)}, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
			
            task.delay(0.22, function()
                ScopersUI.Visible = false
            end)
		end
	end
end)

local ScopersUIContainer = Instance.new("Frame")

ScopersUIContainer.Size = UDim2.new(1, 0, 1, -51)
ScopersUIContainer.Position = UDim2.new(0, 0, 0, 51)
ScopersUIContainer.BackgroundTransparency = 1
ScopersUIContainer.ClipsDescendants = true
ScopersUIContainer.Parent = ScopersUIContentFrame

--makeDraggable(ScopersUI, ScopersUILogoFrame)

ScopersUILibrary.ActiveTab = nil

function ScopersUILibrary:SetToggleKey(GetKeyCode)
	ScopersUILibrary.ToggleKey = GetKeyCode
	ScopersToggleHintButton.Text = "Toggle: " .. GetKeyCode.Name
end

function ScopersUILibrary:Unload(fn)
    ScopersUILibrary.OnUnload = fn
end

function ScopersUILibrary:NameTagToggle(fn)
    ScopersUILibrary.OnCustomAction = fn
end

function ScopersUILibrary:SwitchPage(name)
	for _, v in pairs(ScopersUILibrary.Pages) do
		v.Frame.Visible = false
		if v.Tab then
			ScopersUILibraryTween(v.Tab, {BackgroundColor3 = Color3.fromRGB(0, 0, 0)}, 0.1)
			v.Tab.BackgroundTransparency = 1
			v.TabLabel.TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextSecondary
			if v.TabAccent then v.TabAccent.BackgroundTransparency = 1 end
		end
	end
	if ScopersUILibrary.Pages[name] then
		ScopersUILibrary.Pages[name].Frame.Visible = true
		ScopersUIPageTitle.Text = name
		local tab = ScopersUILibrary.Pages[name].Tab
		if tab then
			ScopersUILibraryTween(tab, {BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Elevated}, 0.15)
			tab.BackgroundTransparency = 0
			ScopersUILibrary.Pages[name].TabLabel.TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextPrimary
			if ScopersUILibrary.Pages[name].TabAccent then ScopersUILibrary.Pages[name].TabAccent.BackgroundTransparency = 0 end
		end
	end
	ScopersUILibrary.ActiveTab = name
end

function ScopersUILibrary:CreatePage(name)
	local pageFrame = Instance.new("ScrollingFrame")
	pageFrame.Name = name
	pageFrame.Size = UDim2.new(1, 0, 1, 0)
	pageFrame.BackgroundTransparency = 1
	pageFrame.ScrollBarThickness = 4
	pageFrame.ScrollBarImageColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Neutral
	pageFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	pageFrame.CanvasSize = UDim2.new()
	pageFrame.Visible = false
	pageFrame.Parent = ScopersUIContainer
	local pl = Instance.new("UIListLayout", pageFrame)
	pl.Padding = UDim.new(0, 8)
	local pp = Instance.new("UIPadding", pageFrame)
	pp.PaddingLeft = UDim.new(0, 14)
	pp.PaddingRight = UDim.new(0, 14)
	pp.PaddingTop = UDim.new(0, 10)
	pp.PaddingBottom = UDim.new(0, 10)

	local tab = Instance.new("TextButton")
	tab.Size = UDim2.new(1, 0, 0, 36)
	tab.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Elevated
	tab.BackgroundTransparency = 1
	tab.AutoButtonColor = false
	tab.Text = ""
	tab.Parent = ScopersUITabList
	Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 8)

	local tabAccent = Instance.new("Frame")
	tabAccent.Size = UDim2.new(0, 3, 0, 18)
	tabAccent.Position = UDim2.new(0, 0, 0.5, -9)
	tabAccent.BackgroundColor3 = Color3.fromRGB(160, 160, 180)
	tabAccent.BackgroundTransparency = 1
	tabAccent.BorderSizePixel = 0
	tabAccent.Parent = tab
	Instance.new("UICorner", tabAccent).CornerRadius = UDim.new(0, 2)

	local tabLabel = Instance.new("TextLabel")
	tabLabel.Size = UDim2.new(1, -14, 1, 0)
	tabLabel.Position = UDim2.new(0, 14, 0, 0)
	tabLabel.BackgroundTransparency = 1
	tabLabel.Text = name
	tabLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	tabLabel.TextSize = 14
	tabLabel.TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextSecondary
	tabLabel.TextXAlignment = Enum.TextXAlignment.Left
	tabLabel.Parent = tab

	tab.MouseEnter:Connect(function()
		if ScopersUILibrary.ActiveTab ~= name then
			ScopersUILibraryTween(tab, {BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.SurfaceHover}, 0.12)
			tab.BackgroundTransparency = 0
		end
	end)
	tab.MouseLeave:Connect(function()
		if ScopersUILibrary.ActiveTab ~= name then
			ScopersUILibraryTween(tab, {BackgroundColor3 = Color3.fromRGB(0, 0, 0)}, 0.12)
			tab.BackgroundTransparency = 1
		end
	end)
	tab.MouseButton1Click:Connect(function() ScopersUILibrary:SwitchPage(name) end)

	ScopersUILibrary.Pages[name] = { Frame = pageFrame, Tab = tab, TabLabel = tabLabel, TabAccent = tabAccent }

	local PageLib = {}

	function PageLib:CreateSection(sectionName)
		local sectionHolder = Instance.new("Frame")
		sectionHolder.Size = UDim2.new(1, 0, 0, 0)
		sectionHolder.AutomaticSize = Enum.AutomaticSize.Y
		sectionHolder.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.SectionBg
		sectionHolder.BackgroundTransparency = 0.5
		sectionHolder.BorderSizePixel = 0
		sectionHolder.Parent = pageFrame
		Instance.new("UICorner", sectionHolder).CornerRadius = UDim.new(0, 10)
		local sectionStroke = Instance.new("UIStroke", sectionHolder)
		sectionStroke.Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Border
		sectionStroke.Thickness = 1

		local sectionHeader = Instance.new("Frame")
		sectionHeader.Size = UDim2.new(1, 0, 0, 36)
		sectionHeader.BackgroundTransparency = 1
		sectionHeader.Parent = sectionHolder

		local sectionTitle = Instance.new("TextLabel")
		sectionTitle.Size = UDim2.new(1, -24, 1, 0)
		sectionTitle.Position = UDim2.new(0, 14, 0, 0)
		sectionTitle.BackgroundTransparency = 1
		sectionTitle.Text = sectionName
		sectionTitle.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
		sectionTitle.TextSize = 12
		sectionTitle.TextColor3 = Color3.fromRGB(160, 160, 180)
		sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
		sectionTitle.Parent = sectionHeader

		local sectionDivider = Instance.new("Frame")
		sectionDivider.Size = UDim2.new(1, -28, 0, 1)
		sectionDivider.Position = UDim2.new(0, 14, 1, 0)
		sectionDivider.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Border
		sectionDivider.BorderSizePixel = 0
		sectionDivider.Parent = sectionHeader

		local sectionContent = Instance.new("Frame")
		sectionContent.Size = UDim2.new(1, 0, 0, 0)
		sectionContent.AutomaticSize = Enum.AutomaticSize.Y
		sectionContent.BackgroundTransparency = 1
		sectionContent.Parent = sectionHolder
		local scl = Instance.new("UIListLayout", sectionContent)
		scl.Padding = UDim.new(0, 6)
		local scp = Instance.new("UIPadding", sectionContent)
		scp.PaddingLeft = UDim.new(0, 10)
		scp.PaddingRight = UDim.new(0, 10)
		scp.PaddingTop = UDim.new(0, 8)
		scp.PaddingBottom = UDim.new(0, 10)

		local SectionLib = {}

		function SectionLib:CreateLabel(text)
			local row = Instance.new("Frame")
			row.Size = UDim2.new(1, 0, 0, 28)
			row.BackgroundTransparency = 1
			row.Parent = sectionContent
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, 0, 1, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = "\n" .. text
			lbl.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
			lbl.TextSize = 13
			lbl.TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextSecondary
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Parent = row
		end

		function SectionLib:CreateButton(text, callback)
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, 0, 0, 38)
			btn.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Elevated
			btn.BackgroundTransparency = 0.5
			btn.AutoButtonColor = false
			btn.Text = ""
			btn.Parent = sectionContent
			Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
			local btnStroke = Instance.new("UIStroke", btn)
			btnStroke.Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Border
			btnStroke.Thickness = 1

			local btnLabel = Instance.new("TextLabel")
			btnLabel.Size = UDim2.new(1, -16, 1, 0)
			btnLabel.Position = UDim2.new(0, 14, 0, 0)
			btnLabel.BackgroundTransparency = 1
			btnLabel.Text = text
			btnLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
			btnLabel.TextSize = 14
			btnLabel.TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextPrimary
			btnLabel.TextXAlignment = Enum.TextXAlignment.Left
			btnLabel.Parent = btn

			local arrow = Instance.new("TextLabel")
			arrow.Size = UDim2.fromOffset(24, 24)
			arrow.Position = UDim2.new(1, -30, 0.5, -12)
			arrow.BackgroundTransparency = 1
			arrow.Text = "›"
			arrow.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
			arrow.TextSize = 18
			arrow.TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextMuted
			arrow.Parent = btn

			btn.MouseEnter:Connect(function()
				ScopersUILibraryTween(btn, {BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Neutral}, 0.12)
				btn.BackgroundTransparency = 0
				ScopersUILibraryTween(btnStroke, {Color = ScopersUILibrary.ScopersUIDragSettings.Colors.BorderActive}, 0.12)
				ScopersUILibraryTween(arrow, {TextColor3 = Color3.fromRGB(200, 200, 200)}, 0.12)
			end)
			btn.MouseLeave:Connect(function()
				ScopersUILibraryTween(btn, {BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Elevated}, 0.12)
				btn.BackgroundTransparency = 0.5
				ScopersUILibraryTween(btnStroke, {Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Border}, 0.12)
				ScopersUILibraryTween(arrow, {TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextMuted}, 0.12)
			end)
			btn.MouseButton1Down:Connect(function()
				ScopersUILibraryTween(btn, {BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.NeutralPress}, 0.08)
				btn.BackgroundTransparency = 0
			end)
			btn.MouseButton1Up:Connect(function()
				ScopersUILibraryTween(btn, {BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Neutral}, 0.1)
				if callback then callback() end
			end)
		end

		function SectionLib:CreateToggle(text, default, callback)
			local state = default or false
			local row = Instance.new("Frame")
			row.Size = UDim2.new(1, 0, 0, 38)
			row.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Elevated
			row.BackgroundTransparency = 0.5
			row.BorderSizePixel = 0
			row.Parent = sectionContent
			Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
			local rowStroke = Instance.new("UIStroke", row)
			rowStroke.Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Border
			rowStroke.Thickness = 1

			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, -80, 1, 0)
			lbl.Position = UDim2.new(0, 14, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = text
			lbl.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
			lbl.TextSize = 14
			lbl.TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextPrimary
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Parent = row

			local trackBg = Instance.new("Frame")
			trackBg.Size = UDim2.fromOffset(46, 24)
			trackBg.Position = UDim2.new(1, -58, 0.5, -12)
			trackBg.BackgroundColor3 = state and ScopersUILibrary.ScopersUIDragSettings.Colors.ToggleOn or ScopersUILibrary.ScopersUIDragSettings.Colors.Border
			trackBg.BorderSizePixel = 0
			trackBg.Parent = row
			Instance.new("UICorner", trackBg).CornerRadius = UDim.new(1, 0)

			local knob = Instance.new("Frame")
			knob.Size = UDim2.fromOffset(18, 18)
			knob.Position = state and UDim2.fromOffset(25, 3) or UDim2.fromOffset(3, 3)
			knob.BackgroundColor3 = Color3.new(1, 1, 1)
			knob.BorderSizePixel = 0
			knob.Parent = trackBg
			Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

			local clickArea = Instance.new("TextButton")
			clickArea.Size = UDim2.new(1, 0, 1, 0)
			clickArea.BackgroundTransparency = 1
			clickArea.Text = ""
			clickArea.Parent = row

			clickArea.MouseButton1Click:Connect(function()
				state = not state
				ScopersUILibraryTween(trackBg, {BackgroundColor3 = state and ScopersUILibrary.ScopersUIDragSettings.Colors.ToggleOn or ScopersUILibrary.ScopersUIDragSettings.Colors.Border}, 0.18)
				ScopersUILibraryTween(knob, {Position = state and UDim2.fromOffset(25, 3) or UDim2.fromOffset(3, 3)}, 0.18, Enum.EasingStyle.Back)
				ScopersUILibraryTween(rowStroke, {Color = state and ScopersUILibrary.ScopersUIDragSettings.Colors.BorderActive or ScopersUILibrary.ScopersUIDragSettings.Colors.Border}, 0.15)
				if callback then callback(state) end
			end)

			return {
				SetValue = function(_, val)
					state = val
					ScopersUILibraryTween(trackBg, {BackgroundColor3 = state and ScopersUILibrary.ScopersUIDragSettings.Colors.ToggleOn or ScopersUILibrary.ScopersUIDragSettings.Colors.Border}, 0.18)
					ScopersUILibraryTween(knob, {Position = state and UDim2.fromOffset(25, 3) or UDim2.fromOffset(3, 3)}, 0.18, Enum.EasingStyle.Back)
					if callback then callback(state) end
				end,
				GetValue = function() return state end,
			}
		end

		function SectionLib:CreateSlider(text, min, max, default, callback)
			min = min or 0
			max = max or 100
			local value = math.clamp(default or min, min, max)

			local holder = Instance.new("Frame")
			holder.Size = UDim2.new(1, 0, 0, 56)
			holder.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Elevated
			holder.BackgroundTransparency = 0.5
			holder.BorderSizePixel = 0
			holder.Parent = sectionContent
			Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 8)
			local holderStroke = Instance.new("UIStroke", holder)
			holderStroke.Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Border
			holderStroke.Thickness = 1

			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(0.7, 0, 0, 24)
			lbl.Position = UDim2.new(0, 14, 0, 6)
			lbl.BackgroundTransparency = 1
			lbl.Text = text
			lbl.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
			lbl.TextSize = 14
			lbl.TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextPrimary
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Parent = holder

			local valLabel = Instance.new("TextLabel")
			valLabel.Size = UDim2.new(0.3, -14, 0, 24)
			valLabel.Position = UDim2.new(0.7, 0, 0, 6)
			valLabel.BackgroundTransparency = 1
			valLabel.Text = tostring(value)
			valLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
			valLabel.TextSize = 13
			valLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
			valLabel.TextXAlignment = Enum.TextXAlignment.Right
			valLabel.Parent = holder

			local track = Instance.new("Frame")
			track.Size = UDim2.new(1, -28, 0, 6)
			track.Position = UDim2.new(0, 14, 0, 38)
			track.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Border
			track.BorderSizePixel = 0
			track.Parent = holder
			Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

			local fill = Instance.new("Frame")
			fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
			fill.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.SliderFill
			fill.BorderSizePixel = 0
			fill.Parent = track
			Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

			local thumb = Instance.new("Frame")
			thumb.Size = UDim2.fromOffset(14, 14)
			thumb.Position = UDim2.new((value - min) / (max - min), -7, 0.5, -7)
			thumb.BackgroundColor3 = Color3.new(1, 1, 1)
			thumb.BorderSizePixel = 0
			thumb.Parent = track
			Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)

			local sliderDragging = false
			local hitbox = Instance.new("TextButton")
			hitbox.Size = UDim2.new(1, 0, 0, 20)
			hitbox.Position = UDim2.new(0, 0, 0.5, -10)
			hitbox.BackgroundTransparency = 1
			hitbox.Text = ""
			hitbox.ZIndex = 5
			hitbox.Parent = track

			local function updateSlider(input)
				local rel = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
				value = math.floor(min + (max - min) * rel)
				valLabel.Text = tostring(value)
				ScopersUILibraryTween(fill, {Size = UDim2.new(rel, 0, 1, 0)}, 0.05)
				ScopersUILibraryTween(thumb, {Position = UDim2.new(rel, -7, 0.5, -7)}, 0.05)
				if callback then callback(value) end
			end

			hitbox.MouseButton1Down:Connect(function()
				sliderDragging = true
				ScopersUILibraryTween(thumb, {Size = UDim2.fromOffset(16, 16)}, 0.1)
				ScopersUILibraryTween(holderStroke, {Color = ScopersUILibrary.ScopersUIDragSettings.Colors.BorderActive}, 0.12)
			end)
			InputService.InputChanged:Connect(function(i)
				if sliderDragging and i.UserInputType == Enum.UserInputType.MouseMovement then
					updateSlider(i)
				end
			end)
			InputService.InputEnded:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 and sliderDragging then
					sliderDragging = false
					ScopersUILibraryTween(thumb, {Size = UDim2.fromOffset(14, 14)}, 0.1)
					ScopersUILibraryTween(holderStroke, {Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Border}, 0.12)
				end
			end)

			return {
				SetValue = function(_, v)
					value = math.clamp(v, min, max)
					local rel = (value - min) / (max - min)
					valLabel.Text = tostring(value)
					ScopersUILibraryTween(fill, {Size = UDim2.new(rel, 0, 1, 0)}, 0.12)
					ScopersUILibraryTween(thumb, {Position = UDim2.new(rel, -7, 0.5, -7)}, 0.12)
					if callback then callback(value) end
				end,
				GetValue = function() return value end,
			}
		end

		function SectionLib:CreateTextbox(text, placeholder, callback)
			local holder = Instance.new("Frame")
			holder.Size = UDim2.new(1, 0, 0, 56)
			holder.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Elevated
			holder.BackgroundTransparency = 0.5
			holder.BorderSizePixel = 0
			holder.Parent = sectionContent
			Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 8)
			local holderStroke = Instance.new("UIStroke", holder)
			holderStroke.Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Border
			holderStroke.Thickness = 1

			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, -14, 0, 22)
			lbl.Position = UDim2.new(0, 14, 0, 5)
			lbl.BackgroundTransparency = 1
			lbl.Text = text
			lbl.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
			lbl.TextSize = 12
			lbl.TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextSecondary
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Parent = holder

			local inputBg = Instance.new("Frame")
			inputBg.Size = UDim2.new(1, -28, 0, 22)
			inputBg.Position = UDim2.new(0, 14, 0, 28)
			inputBg.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Background
			inputBg.BackgroundTransparency = 0.5
			inputBg.BorderSizePixel = 0
			inputBg.Parent = holder
			Instance.new("UICorner", inputBg).CornerRadius = UDim.new(0, 5)
			local inputStroke = Instance.new("UIStroke", inputBg)
			inputStroke.Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Border
			inputStroke.Thickness = 1

			local tb = Instance.new("TextBox")
			tb.Size = UDim2.new(1, -16, 1, 0)
			tb.Position = UDim2.new(0, 8, 0, 0)
			tb.BackgroundTransparency = 1
			tb.PlaceholderText = placeholder or ""
			tb.PlaceholderColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextMuted
			tb.Text = ""
			tb.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
			tb.TextSize = 13
			tb.TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextPrimary
			tb.TextXAlignment = Enum.TextXAlignment.Left
			tb.ClearTextOnFocus = false
			tb.Parent = inputBg

			tb.Focused:Connect(function()
				ScopersUILibraryTween(holderStroke, {Color = ScopersUILibrary.ScopersUIDragSettings.Colors.BorderActive}, 0.15)
				ScopersUILibraryTween(inputStroke, {Color = Color3.fromRGB(120, 120, 140)}, 0.15)
			end)
			tb.FocusLost:Connect(function(enter)
				ScopersUILibraryTween(holderStroke, {Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Border}, 0.15)
				ScopersUILibraryTween(inputStroke, {Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Border}, 0.15)
				if callback then callback(tb.Text, enter) end
			end)

			return {
				SetValue = function(_, v) tb.Text = v end,
				GetValue = function() return tb.Text end,
			}
		end

		function SectionLib:CreateDropdown(text, options, default, callback)
			options = options or {}
			local selected = default or options[1] or ""
			local open = false

			local holder = Instance.new("Frame")
			holder.Size = UDim2.new(1, 0, 0, 38)
			holder.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Elevated
			holder.BackgroundTransparency = 0.5
			holder.BorderSizePixel = 0
			holder.ClipsDescendants = false
			holder.ZIndex = 10
			holder.Parent = sectionContent
			Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 8)
			local holderStroke = Instance.new("UIStroke", holder)
			holderStroke.Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Border
			holderStroke.Thickness = 1
			holderStroke.ZIndex = 10

			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(0.55, 0, 1, 0)
			lbl.Position = UDim2.new(0, 14, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = text
			lbl.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
			lbl.TextSize = 14
			lbl.TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextPrimary
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.ZIndex = 11
			lbl.Parent = holder

			local selectedLabel = Instance.new("TextLabel")
			selectedLabel.Size = UDim2.new(0.45, -38, 1, 0)
			selectedLabel.Position = UDim2.new(0.55, 0, 0, 0)
			selectedLabel.BackgroundTransparency = 1
			selectedLabel.Text = selected
			selectedLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
			selectedLabel.TextSize = 13
			selectedLabel.TextColor3 = Color3.fromRGB(160, 160, 180)
			selectedLabel.TextXAlignment = Enum.TextXAlignment.Right
			selectedLabel.ZIndex = 11
			selectedLabel.Parent = holder

			local arrow = Instance.new("TextLabel")
			arrow.Size = UDim2.fromOffset(24, 24)
			arrow.Position = UDim2.new(1, -30, 0.5, -12)
			arrow.BackgroundTransparency = 1
			arrow.Text = "⌄"
			arrow.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
			arrow.TextSize = 16
			arrow.TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextMuted
			arrow.ZIndex = 11
			arrow.Parent = holder

			local dropFrame = Instance.new("Frame")
			dropFrame.Size = UDim2.new(1, 0, 0, 0)
			dropFrame.Position = UDim2.new(0, 0, 1, 4)
			dropFrame.BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Surface
			dropFrame.BackgroundTransparency = 0.4
			dropFrame.BorderSizePixel = 0
			dropFrame.ClipsDescendants = true
			dropFrame.ZIndex = 20
			dropFrame.Parent = holder
			Instance.new("UICorner", dropFrame).CornerRadius = UDim.new(0, 8)
			local dropStroke = Instance.new("UIStroke", dropFrame)
			dropStroke.Color = ScopersUILibrary.ScopersUIDragSettings.Colors.BorderActive
			dropStroke.Thickness = 1
			dropStroke.ZIndex = 20

			local dropLayout = Instance.new("UIListLayout", dropFrame)
			dropLayout.Padding = UDim.new(0, 2)
			local dropPad = Instance.new("UIPadding", dropFrame)
			dropPad.PaddingTop = UDim.new(0, 4)
			dropPad.PaddingBottom = UDim.new(0, 4)
			dropPad.PaddingLeft = UDim.new(0, 4)
			dropPad.PaddingRight = UDim.new(0, 4)

			local itemHeight = 30
			local maxVisible = 5
			local totalHeight = math.min(#options, maxVisible) * (itemHeight + 2) + 10

			local function buildOptions()
				for _, child in pairs(dropFrame:GetChildren()) do
					if child:IsA("TextButton") then child:Destroy() end
				end
				for _, opt in ipairs(options) do
					local optBtn = Instance.new("TextButton")
					optBtn.Size = UDim2.new(1, 0, 0, itemHeight)
					optBtn.BackgroundColor3 = opt == selected and ScopersUILibrary.ScopersUIDragSettings.Colors.Neutral or ScopersUILibrary.ScopersUIDragSettings.Colors.Elevated
					optBtn.BackgroundTransparency = opt == selected and 0 or 0.5
					optBtn.AutoButtonColor = false
					optBtn.Text = opt
					optBtn.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
					optBtn.TextSize = 13
					optBtn.TextColor3 = opt == selected and ScopersUILibrary.ScopersUIDragSettings.Colors.TextPrimary or ScopersUILibrary.ScopersUIDragSettings.Colors.TextSecondary
					optBtn.ZIndex = 21
					optBtn.Parent = dropFrame
					Instance.new("UICorner", optBtn).CornerRadius = UDim.new(0, 6)

					optBtn.MouseEnter:Connect(function()
						if opt ~= selected then
							ScopersUILibraryTween(optBtn, {BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Neutral}, 0.1)
							optBtn.BackgroundTransparency = 0
							optBtn.TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextPrimary
						end
					end)
					optBtn.MouseLeave:Connect(function()
						if opt ~= selected then
							ScopersUILibraryTween(optBtn, {BackgroundColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.Elevated}, 0.1)
							optBtn.BackgroundTransparency = 0.5
							optBtn.TextColor3 = ScopersUILibrary.ScopersUIDragSettings.Colors.TextSecondary
						end
					end)
					optBtn.MouseButton1Click:Connect(function()
						selected = opt
						selectedLabel.Text = selected
						open = false
						ScopersUILibraryTween(dropFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.18, Enum.EasingStyle.Quart)
						ScopersUILibraryTween(arrow, {Rotation = 0}, 0.18)
						ScopersUILibraryTween(holderStroke, {Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Border}, 0.15)
						buildOptions()
						if callback then callback(selected) end
					end)
				end
			end

			buildOptions()

			local ddToggleBtn = Instance.new("TextButton")
			ddToggleBtn.Size = UDim2.new(1, 0, 1, 0)
			ddToggleBtn.BackgroundTransparency = 1
			ddToggleBtn.Text = ""
			ddToggleBtn.ZIndex = 12
			ddToggleBtn.Parent = holder

			ddToggleBtn.MouseButton1Click:Connect(function()
				open = not open
				if open then
					ScopersUILibraryTween(dropFrame, {Size = UDim2.new(1, 0, 0, totalHeight)}, 0.2, Enum.EasingStyle.Back)
					ScopersUILibraryTween(arrow, {Rotation = 180}, 0.18)
					ScopersUILibraryTween(holderStroke, {Color = ScopersUILibrary.ScopersUIDragSettings.Colors.BorderActive}, 0.15)
				else
					ScopersUILibraryTween(dropFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.18, Enum.EasingStyle.Quart)
					ScopersUILibraryTween(arrow, {Rotation = 0}, 0.18)
					ScopersUILibraryTween(holderStroke, {Color = ScopersUILibrary.ScopersUIDragSettings.Colors.Border}, 0.15)
				end
			end)

			return {
				SetOptions = function(_, newOptions)
					options = newOptions
					totalHeight = math.min(#options, maxVisible) * (itemHeight + 2) + 10
					buildOptions()
				end,
				SetValue = function(_, val)
					selected = val
					selectedLabel.Text = val
					buildOptions()
					if callback then callback(selected) end
				end,
				GetValue = function() return selected end,
			}
		end

		return SectionLib
	end

	return PageLib
end

ScopersUI.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        ScopersUILibrary.ScopersUIDragSettings.Toggle = true
        ScopersUILibrary.ScopersUIDragSettings.Start = input.Position
        ScopersUILibrary.ScopersUIDragSettings.InitialPosition = ScopersUI.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                ScopersUILibrary.ScopersUIDragSettings.Toggle = false
            end
        end)
    end
end)

InputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if ScopersUILibrary.ScopersUIDragSettings.Toggle then
            UpdateDragV3(input, ScopersUI)
        end
    end
end)

ScopersUILibraryTween(ScopersUI, {Size = UDim2.fromOffset(780, 520)}, 0.3, Enum.EasingStyle.Back)

return ScopersUILibrary
