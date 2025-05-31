-- Enhanced GUI Library v2 with Tilting, Glow Effects, and Hide/Show
-- Features: Mouse-dependent tilting, glow effects, hide/show buttons, lighter top bar

local GuiLibrary = {}
GuiLibrary.__index = GuiLibrary

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Configuration
local Config = {
    Colors = {
        Primary = Color3.fromRGB(45, 45, 55),
        Secondary = Color3.fromRGB(35, 35, 45),
        Accent = Color3.fromRGB(85, 170, 255),
        TopBar = Color3.fromRGB(55, 55, 65), -- Lighter top bar
        Text = Color3.fromRGB(255, 255, 255),
        Glow = Color3.fromRGB(85, 170, 255),
        Success = Color3.fromRGB(76, 175, 80),
        Warning = Color3.fromRGB(255, 193, 7),
        Error = Color3.fromRGB(244, 67, 54)
    },
    Animations = {
        TiltStrength = 15, -- Maximum tilt angle in degrees
        GlowIntensity = 0.8,
        TransitionTime = 0.2,
        HoverTime = 0.15
    },
    Font = Enum.Font.Gotham,
    CornerRadius = UDim.new(0, 8)
}

-- Utility Functions
local function createCorner(radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = radius or Config.CornerRadius
    return corner
end

local function createGlow(parent, color, intensity)
    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.Parent = parent
    glow.BackgroundTransparency = 1
    glow.Image = "rbxasset://textures/ui/Glow/CircleGlow.png"
    glow.ImageColor3 = color or Config.Colors.Glow
    glow.ImageTransparency = 1 - (intensity or Config.Animations.GlowIntensity)
    glow.Size = UDim2.new(1.2, 0, 1.2, 0)
    glow.Position = UDim2.new(-0.1, 0, -0.1, 0)
    glow.ZIndex = parent.ZIndex - 1
    return glow
end

local function calculateTilt(element, mousePos)
    local elementPos = element.AbsolutePosition
    local elementSize = element.AbsoluteSize
    local center = Vector2.new(
        elementPos.X + elementSize.X / 2,
        elementPos.Y + elementSize.Y / 2
    )
    
    local offset = mousePos - center
    local maxOffset = math.max(elementSize.X, elementSize.Y) / 2
    
    local tiltX = math.clamp(offset.Y / maxOffset * Config.Animations.TiltStrength, -Config.Animations.TiltStrength, Config.Animations.TiltStrength)
    local tiltY = math.clamp(-offset.X / maxOffset * Config.Animations.TiltStrength, -Config.Animations.TiltStrength, Config.Animations.TiltStrength)
    
    return tiltX, tiltY
end

local function addTiltEffect(element)
    local originalRotation = element.Rotation
    
    element.MouseEnter:Connect(function()
        local connection
        connection = RunService.Heartbeat:Connect(function()
            local mousePos = UserInputService:GetMouseLocation()
            local tiltX, tiltY = calculateTilt(element, mousePos)
            
            local tiltInfo = TweenInfo.new(Config.Animations.HoverTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tiltTween = TweenService:Create(element, tiltInfo, {
                Rotation = originalRotation + tiltY * 0.5
            })
            tiltTween:Play()
        end)
        
        element.MouseLeave:Connect(function()
            connection:Disconnect()
            local resetInfo = TweenInfo.new(Config.Animations.TransitionTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local resetTween = TweenService:Create(element, resetInfo, {
                Rotation = originalRotation
            })
            resetTween:Play()
        end)
    end)
end

local function addGlowEffect(element, glowColor)
    local glow = createGlow(element.Parent, glowColor)
    glow.ImageTransparency = 1
    
    element.MouseEnter:Connect(function()
        local glowInfo = TweenInfo.new(Config.Animations.HoverTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local glowTween = TweenService:Create(glow, glowInfo, {
            ImageTransparency = 1 - Config.Animations.GlowIntensity
        })
        glowTween:Play()
    end)
    
    element.MouseLeave:Connect(function()
        local fadeInfo = TweenInfo.new(Config.Animations.TransitionTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local fadeTween = TweenService:Create(glow, fadeInfo, {
            ImageTransparency = 1
        })
        fadeTween:Play()
    end)
end

-- Main Library Functions
function GuiLibrary.new(title)
    local self = setmetatable({}, GuiLibrary)
    
    -- Create ScreenGui
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "EnhancedGUI"
    self.ScreenGui.Parent = PlayerGui
    self.ScreenGui.ResetOnSpawn = false
    
    -- Main Frame
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.Parent = self.ScreenGui
    self.MainFrame.BackgroundColor3 = Config.Colors.Primary
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
    self.MainFrame.Size = UDim2.new(0, 500, 0, 400)
    self.MainFrame.Active = true
    self.MainFrame.Draggable = true
    
    createCorner().Parent = self.MainFrame
    
    -- Top Bar (Lighter)
    self.TopBar = Instance.new("Frame")
    self.TopBar.Name = "TopBar"
    self.TopBar.Parent = self.MainFrame
    self.TopBar.BackgroundColor3 = Config.Colors.TopBar
    self.TopBar.BorderSizePixel = 0
    self.TopBar.Size = UDim2.new(1, 0, 0, 40)
    
    createCorner().Parent = self.TopBar
    
    -- Top Bar Bottom Cover
    local topBarCover = Instance.new("Frame")
    topBarCover.Name = "TopBarCover"
    topBarCover.Parent = self.TopBar
    topBarCover.BackgroundColor3 = Config.Colors.TopBar
    topBarCover.BorderSizePixel = 0
    topBarCover.Position = UDim2.new(0, 0, 0.5, 0)
    topBarCover.Size = UDim2.new(1, 0, 0.5, 0)
    
    -- Title
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Name = "Title"
    self.TitleLabel.Parent = self.TopBar
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    self.TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    self.TitleLabel.Font = Config.Font
    self.TitleLabel.Text = title or "Enhanced GUI"
    self.TitleLabel.TextColor3 = Config.Colors.Text
    self.TitleLabel.TextScaled = true
    self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Hide Button
    self.HideButton = Instance.new("TextButton")
    self.HideButton.Name = "HideButton"
    self.HideButton.Parent = self.TopBar
    self.HideButton.BackgroundColor3 = Config.Colors.Warning
    self.HideButton.BorderSizePixel = 0
    self.HideButton.Position = UDim2.new(1, -75, 0.125, 0)
    self.HideButton.Size = UDim2.new(0, 30, 0.75, 0)
    self.HideButton.Font = Config.Font
    self.HideButton.Text = "−"
    self.HideButton.TextColor3 = Config.Colors.Text
    self.HideButton.TextScaled = true
    
    createCorner(UDim.new(0, 4)).Parent = self.HideButton
    addTiltEffect(self.HideButton)
    addGlowEffect(self.HideButton, Config.Colors.Warning)
    
    -- Close Button
    self.CloseButton = Instance.new("TextButton")
    self.CloseButton.Name = "CloseButton"
    self.CloseButton.Parent = self.TopBar
    self.CloseButton.BackgroundColor3 = Config.Colors.Error
    self.CloseButton.BorderSizePixel = 0
    self.CloseButton.Position = UDim2.new(1, -40, 0.125, 0)
    self.CloseButton.Size = UDim2.new(0, 30, 0.75, 0)
    self.CloseButton.Font = Config.Font
    self.CloseButton.Text = "×"
    self.CloseButton.TextColor3 = Config.Colors.Text
    self.CloseButton.TextScaled = true
    
    createCorner(UDim.new(0, 4)).Parent = self.CloseButton
    addTiltEffect(self.CloseButton)
    addGlowEffect(self.CloseButton, Config.Colors.Error)
    
    -- Show Button (Initially Hidden)
    self.ShowButton = Instance.new("TextButton")
    self.ShowButton.Name = "ShowButton"
    self.ShowButton.Parent = self.ScreenGui
    self.ShowButton.BackgroundColor3 = Config.Colors.Accent
    self.ShowButton.BorderSizePixel = 0
    self.ShowButton.Position = UDim2.new(0, 10, 0.5, -25)
    self.ShowButton.Size = UDim2.new(0, 50, 0, 50)
    self.ShowButton.Font = Config.Font
    self.ShowButton.Text = "+"
    self.ShowButton.TextColor3 = Config.Colors.Text
    self.ShowButton.TextScaled = true
    self.ShowButton.Visible = false
    
    createCorner().Parent = self.ShowButton
    addTiltEffect(self.ShowButton)
    addGlowEffect(self.ShowButton, Config.Colors.Accent)
    
    -- Content Frame
    self.ContentFrame = Instance.new("Frame")
    self.ContentFrame.Name = "Content"
    self.ContentFrame.Parent = self.MainFrame
    self.ContentFrame.BackgroundTransparency = 1
    self.ContentFrame.Position = UDim2.new(0, 10, 0, 50)
    self.ContentFrame.Size = UDim2.new(1, -20, 1, -60)
    
    -- Scroll Frame for content
    self.ScrollFrame = Instance.new("ScrollingFrame")
    self.ScrollFrame.Name = "ScrollFrame"
    self.ScrollFrame.Parent = self.ContentFrame
    self.ScrollFrame.BackgroundTransparency = 1
    self.ScrollFrame.BorderSizePixel = 0
    self.ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
    self.ScrollFrame.ScrollBarThickness = 4
    self.ScrollFrame.ScrollBarImageColor3 = Config.Colors.Accent
    
    -- UI Layout for content
    self.UIListLayout = Instance.new("UIListLayout")
    self.UIListLayout.Parent = self.ScrollFrame
    self.UIListLayout.Padding = UDim.new(0, 8)
    self.UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    -- Hide/Show functionality
    self.IsHidden = false
    
    self.HideButton.MouseButton1Click:Connect(function()
        self:Hide()
    end)
    
    self.ShowButton.MouseButton1Click:Connect(function()
        self:Show()
    end)
    
    self.CloseButton.MouseButton1Click:Connect(function()
        self:Destroy()
    end)
    
    return self
end

function GuiLibrary:Hide()
    if self.IsHidden then return end
    
    self.IsHidden = true
    local hideInfo = TweenInfo.new(Config.Animations.TransitionTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local hideTween = TweenService:Create(self.MainFrame, hideInfo, {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    
    hideTween:Play()
    hideTween.Completed:Connect(function()
        self.MainFrame.Visible = false
        self.ShowButton.Visible = true
        
        local showButtonInfo = TweenInfo.new(Config.Animations.TransitionTime, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local showButtonTween = TweenService:Create(self.ShowButton, showButtonInfo, {
            Size = UDim2.new(0, 50, 0, 50)
        })
        showButtonTween:Play()
    end)
end

function GuiLibrary:Show()
    if not self.IsHidden then return end
    
    self.IsHidden = false
    self.MainFrame.Visible = true
    self.ShowButton.Visible = false
    
    local showInfo = TweenInfo.new(Config.Animations.TransitionTime, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local showTween = TweenService:Create(self.MainFrame, showInfo, {
        Size = UDim2.new(0, 500, 0, 400),
        Position = UDim2.new(0.3, 0, 0.2, 0)
    })
    showTween:Play()
end

function GuiLibrary:Destroy()
    self.ScreenGui:Destroy()
end

-- Tab System
function GuiLibrary:CreateTab(name)
    local tab = {}
    
    -- Tab Button
    local tabButton = Instance.new("TextButton")
    tabButton.Name = name .. "Tab"
    tabButton.Parent = self.TopBar
    tabButton.BackgroundColor3 = Config.Colors.Secondary
    tabButton.BorderSizePixel = 0
    tabButton.Size = UDim2.new(0, 80, 0.6, 0)
    tabButton.Position = UDim2.new(0, 100 + (#self.TopBar:GetChildren() - 4) * 85, 0.2, 0)
    tabButton.Font = Config.Font
    tabButton.Text = name
    tabButton.TextColor3 = Config.Colors.Text
    tabButton.TextScaled = true
    
    createCorner(UDim.new(0, 4)).Parent = tabButton
    addTiltEffect(tabButton)
    addGlowEffect(tabButton, Config.Colors.Accent)
    
    -- Tab Content Frame
    local tabFrame = Instance.new("Frame")
    tabFrame.Name = name .. "Content"
    tabFrame.Parent = self.ScrollFrame
    tabFrame.BackgroundTransparency = 1
    tabFrame.Size = UDim2.new(1, 0, 0, 0)
    tabFrame.Visible = false
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Parent = tabFrame
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    tab.Frame = tabFrame
    tab.Button = tabButton
    tab.Layout = tabLayout
    
    -- Tab switching logic
    tabButton.MouseButton1Click:Connect(function()
        -- Hide all tabs
        for _, child in pairs(self.ScrollFrame:GetChildren()) do
            if child:IsA("Frame") and child.Name:match("Content$") then
                child.Visible = false
            end
        end
        
        -- Show current tab
        tabFrame.Visible = true
        
        -- Update button colors
        for _, child in pairs(self.TopBar:GetChildren()) do
            if child:IsA("TextButton") and child.Name:match("Tab$") then
                child.BackgroundColor3 = Config.Colors.Secondary
            end
        end
        tabButton.BackgroundColor3 = Config.Colors.Accent
    end)
    
    return tab
end

-- Button
function GuiLibrary:CreateButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Name = text .. "Button"
    button.Parent = parent.Frame or parent
    button.BackgroundColor3 = Config.Colors.Secondary
    button.BorderSizePixel = 0
    button.Size = UDim2.new(1, 0, 0, 35)
    button.Font = Config.Font
    button.Text = text
    button.TextColor3 = Config.Colors.Text
    button.TextScaled = true
    
    createCorner().Parent = button
    addTiltEffect(button)
    addGlowEffect(button, Config.Colors.Accent)
    
    if callback then
        button.MouseButton1Click:Connect(callback)
    end
    
    return button
end

-- Toggle
function GuiLibrary:CreateToggle(parent, text, defaultValue, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = text .. "Toggle"
    toggleFrame.Parent = parent.Frame or parent
    toggleFrame.BackgroundColor3 = Config.Colors.Secondary
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Size = UDim2.new(1, 0, 0, 35)
    
    createCorner().Parent = toggleFrame
    addTiltEffect(toggleFrame)
    addGlowEffect(toggleFrame, Config.Colors.Accent)
    
    local label = Instance.new("TextLabel")
    label.Parent = toggleFrame
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Font = Config.Font
    label.Text = text
    label.TextColor3 = Config.Colors.Text
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Parent = toggleFrame
    toggleButton.BackgroundColor3 = defaultValue and Config.Colors.Success or Config.Colors.Error
    toggleButton.BorderSizePixel = 0
    toggleButton.Position = UDim2.new(1, -60, 0.15, 0)
    toggleButton.Size = UDim2.new(0, 50, 0.7, 0)
    toggleButton.Font = Config.Font
    toggleButton.Text = defaultValue and "ON" or "OFF"
    toggleButton.TextColor3 = Config.Colors.Text
    toggleButton.TextScaled = true
    
    createCorner(UDim.new(0, 4)).Parent = toggleButton
    addTiltEffect(toggleButton)
    
    local isToggled = defaultValue
    
    toggleButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        toggleButton.Text = isToggled and "ON" or "OFF"
        toggleButton.BackgroundColor3 = isToggled and Config.Colors.Success or Config.Colors.Error
        
        if callback then
            callback(isToggled)
        end
    end)
    
    return toggleFrame
end

-- Slider
function GuiLibrary:CreateSlider(parent, text, min, max, defaultValue, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = text .. "Slider"
    sliderFrame.Parent = parent.Frame or parent
    sliderFrame.BackgroundColor3 = Config.Colors.Secondary
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Size = UDim2.new(1, 0, 0, 50)
    
    createCorner().Parent = sliderFrame
    addTiltEffect(sliderFrame)
    addGlowEffect(sliderFrame, Config.Colors.Accent)
    
    local label = Instance.new("TextLabel")
    label.Parent = sliderFrame
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Size = UDim2.new(0.5, 0, 0.5, 0)
    label.Font = Config.Font
    label.Text = text
    label.TextColor3 = Config.Colors.Text
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Parent = sliderFrame
    valueLabel.BackgroundTransparency = 1
    valueLabel.Position = UDim2.new(0.5, 0, 0, 0)
    valueLabel.Size = UDim2.new(0.5, -10, 0.5, 0)
    valueLabel.Font = Config.Font
    valueLabel.Text = defaultValue
    valueLabel.TextColor3 = Config.Colors.Accent
    valueLabel.TextScaled = true
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    
    local sliderBack = Instance.new("Frame")
    sliderBack.Parent = sliderFrame
    sliderBack.BackgroundColor3 = Config.Colors.Primary
    sliderBack.BorderSizePixel = 0
    sliderBack.Position = UDim2.new(0, 10, 0.6, 0)
    sliderBack.Size = UDim2.new(1, -20, 0, 6)
    
    createCorner(UDim.new(0, 3)).Parent = sliderBack
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Parent = sliderBack
    sliderFill.BackgroundColor3 = Config.Colors.Accent
    sliderFill.BorderSizePixel = 0
    sliderFill.Size = UDim2.new((defaultValue - min) / (max - min), 0, 1, 0)
    
    createCorner(UDim.new(0, 3)).Parent = sliderFill
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Parent = sliderBack
    sliderButton.BackgroundColor3 = Config.Colors.Text
    sliderButton.BorderSizePixel = 0
    sliderButton.Position = UDim2.new((defaultValue - min) / (max - min), -8, 0.5, -8)
    sliderButton.Size = UDim2.new(0, 16, 0, 16)
    sliderButton.Text = ""
    
    createCorner(UDim.new(0, 8)).Parent = sliderButton
    addTiltEffect(sliderButton)
    
    local currentValue = defaultValue
    local dragging = false
    
    sliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mouseX = input.Position.X
            local sliderX = sliderBack.AbsolutePosition.X
            local sliderWidth = sliderBack.AbsoluteSize.X
            
            local percentage = math.clamp((mouseX - sliderX) / sliderWidth, 0, 1)
            currentValue = min + (max - min) * percentage
            
            valueLabel.Text = math.floor(currentValue * 10) / 10
            sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
            sliderButton.Position = UDim2.new(percentage, -8, 0.5, -8)
            
            if callback then
                callback(currentValue)
            end
        end
    end)
    
    return sliderFrame
end

-- Input Field
function GuiLibrary:CreateInput(parent, placeholder, callback)
    local inputFrame = Instance.new("Frame")
    inputFrame.Name = placeholder .. "Input"
    inputFrame.Parent = parent.Frame or parent
    inputFrame.BackgroundColor3 = Config.Colors.Secondary
    inputFrame.BorderSizePixel = 0
    inputFrame.Size = UDim2.new(1, 0, 0, 35)
    
    createCorner().Parent = inputFrame
    addTiltEffect(inputFrame)
    addGlowEffect(inputFrame, Config.Colors.Accent)
    
    local textBox = Instance.new("TextBox")
    textBox.Parent = inputFrame
    textBox.BackgroundTransparency = 1
    textBox.Position = UDim2.new(0, 10, 0, 0)
    textBox.Size = UDim2.new(1, -20, 1, 0)
    textBox.Font = Config.Font
    textBox.PlaceholderText = placeholder
    textBox.Text = ""
    textBox.TextColor3 = Config.Colors.Text
    textBox.TextScaled = true
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    
    if callback then
        textBox.FocusLost:Connect(function()
            callback(textBox.Text)
        end)
    end
    
    return inputFrame
end

return GuiLibrary
