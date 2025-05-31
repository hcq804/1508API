-- Enhanced 1508 API with Mouse Tilting, Glow Effects, and Hide/Show
local API1508 = {}
API1508.__index = API1508

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

local Config = {
    WindowSize = UDim2.new(0, 520, 0, 400),
    Colors = {
        Background = Color3.fromRGB(10, 10, 10),
        Secondary = Color3.fromRGB(17, 17, 17),
        Tertiary = Color3.fromRGB(25, 25, 25),
        Border = Color3.fromRGB(34, 34, 34),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(187, 187, 187),
        TextMuted = Color3.fromRGB(136, 136, 136),
        Accent = Color3.fromRGB(255, 255, 255),
        AccentHover = Color3.fromRGB(240, 240, 240),
        TopBar = Color3.fromRGB(22, 22, 22), -- Lighter top bar
        Glow = Color3.fromRGB(255, 255, 255),
    },
    Animations = {
        Duration = 0.15,
        EasingStyle = Enum.EasingStyle.Sine,
        EasingDirection = Enum.EasingDirection.Out
    },
    Tilting = {
        MaxRotation = 3,
        Sensitivity = 0.8
    }
}

local function CreateTween(object, properties, duration)
    duration = duration or Config.Animations.Duration
    local tweenInfo = TweenInfo.new(duration, Config.Animations.EasingStyle, Config.Animations.EasingDirection)
    return TweenService:Create(object, tweenInfo, properties)
end

local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 4)
    corner.Parent = parent
end

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Config.Colors.Border
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
end

local function CreateGlow(parent, size, color)
    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.Size = UDim2.new(1, size, 1, size)
    glow.Position = UDim2.new(0, -size/2, 0, -size/2)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    glow.ImageColor3 = color or Config.Colors.Glow
    glow.ImageTransparency = 0.8
    glow.ZIndex = parent.ZIndex - 1
    glow.Parent = parent.Parent
    return glow
end

local function AddTilting(element, maxRotation)
    maxRotation = maxRotation or Config.Tilting.MaxRotation
    
    local connection
    element.MouseEnter:Connect(function()
        connection = RunService.Heartbeat:Connect(function()
            local mousePos = UserInputService:GetMouseLocation()
            local elementPos = element.AbsolutePosition
            local elementSize = element.AbsoluteSize
            
            local centerX = elementPos.X + elementSize.X / 2
            local centerY = elementPos.Y + elementSize.Y / 2
            
            local deltaX = (mousePos.X - centerX) / (elementSize.X / 2)
            local deltaY = (mousePos.Y - centerY) / (elementSize.Y / 2)
            
            local rotationX = math.clamp(deltaY * maxRotation * Config.Tilting.Sensitivity, -maxRotation, maxRotation)
            local rotationY = math.clamp(-deltaX * maxRotation * Config.Tilting.Sensitivity, -maxRotation, maxRotation)
            
            CreateTween(element, {Rotation = rotationY}, 0.1):Play()
        end)
    end)
    
    element.MouseLeave:Connect(function()
        if connection then
            connection:Disconnect()
        end
        CreateTween(element, {Rotation = 0}, 0.2):Play()
    end)
end

function API1508:CreateWindow(options)
    options = options or {}
    
    local Window = {
        Title = options.Title or "Modern UI",
        Subtitle = options.Subtitle or "",
        Tabs = {},
        CurrentTab = nil,
        IsHidden = false
    }
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ModernUI_" .. math.random(1000, 9999)
    ScreenGui.Parent = CoreGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = Config.WindowSize
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Config.Colors.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    
    CreateCorner(MainFrame, 8)
    CreateStroke(MainFrame, Config.Colors.Border, 1)
    local mainGlow = CreateGlow(MainFrame, 20, Config.Colors.Glow)
    mainGlow.ImageTransparency = 0.9
    
    -- Lighter Top Bar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.Position = UDim2.new(0, 0, 0, 0)
    TopBar.BackgroundColor3 = Config.Colors.TopBar
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    CreateCorner(TopBar, 8)
    
    local TopBarMask = Instance.new("Frame")
    TopBarMask.Size = UDim2.new(1, 0, 0.5, 0)
    TopBarMask.Position = UDim2.new(0, 0, 0.5, 0)
    TopBarMask.BackgroundColor3 = Config.Colors.TopBar
    TopBarMask.BorderSizePixel = 0
    TopBarMask.Parent = TopBar
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(1, -100, 1, 0)
    TitleLabel.Position = UDim2.new(0, 16, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = Window.Title
    TitleLabel.TextColor3 = Config.Colors.Text
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.GothamMedium
    TitleLabel.Parent = TopBar
    
    -- Hide Button
    local HideButton = Instance.new("TextButton")
    HideButton.Name = "HideButton"
    HideButton.Size = UDim2.new(0, 30, 0, 30)
    HideButton.Position = UDim2.new(1, -75, 0.5, -15)
    HideButton.BackgroundColor3 = Config.Colors.Tertiary
    HideButton.BorderSizePixel = 0
    HideButton.Text = "_"
    HideButton.TextColor3 = Config.Colors.TextSecondary
    HideButton.TextSize = 16
    HideButton.Font = Enum.Font.GothamMedium
    HideButton.Parent = TopBar
    
    CreateCorner(HideButton, 4)
    AddTilting(HideButton)
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -40, 0.5, -15)
    CloseButton.BackgroundColor3 = Config.Colors.Tertiary
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Config.Colors.TextSecondary
    CloseButton.TextSize = 18
    CloseButton.Font = Enum.Font.GothamMedium
    CloseButton.Parent = TopBar
    
    CreateCorner(CloseButton, 4)
    AddTilting(CloseButton)
    
    -- Show Button (hidden by default)
    local ShowButton = Instance.new("TextButton")
    ShowButton.Name = "ShowButton"
    ShowButton.Size = UDim2.new(0, 80, 0, 30)
    ShowButton.Position = UDim2.new(0.5, -40, 0.1, 0)
    ShowButton.BackgroundColor3 = Config.Colors.Accent
    ShowButton.BorderSizePixel = 0
    ShowButton.Text = "Show UI"
    ShowButton.TextColor3 = Config.Colors.Background
    ShowButton.TextSize = 14
    ShowButton.Font = Enum.Font.GothamMedium
    ShowButton.Visible = false
    ShowButton.Parent = ScreenGui
    
    CreateCorner(ShowButton, 4)
    AddTilting(ShowButton)
    
    -- Button Events
    local function ToggleHide()
        Window.IsHidden = not Window.IsHidden
        if Window.IsHidden then
            CreateTween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3):Play()
            CreateTween(mainGlow, {ImageTransparency = 1}, 0.3):Play()
            ShowButton.Visible = true
        else
            CreateTween(MainFrame, {Size = Config.WindowSize}, 0.3):Play()
            CreateTween(mainGlow, {ImageTransparency = 0.9}, 0.3):Play()
            ShowButton.Visible = false
        end
    end
    
    HideButton.MouseButton1Click:Connect(ToggleHide)
    ShowButton.MouseButton1Click:Connect(ToggleHide)
    
    CloseButton.MouseButton1Click:Connect(function()
        CreateTween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.2):Play()
        CreateTween(ShowButton, {Size = UDim2.new(0, 0, 0, 0)}, 0.2):Play()
        wait(0.2)
        ScreenGui:Destroy()
    end)
    
    -- Hover effects for buttons
    for _, button in pairs({HideButton, CloseButton}) do
        button.MouseEnter:Connect(function()
            CreateTween(button, {BackgroundColor3 = Config.Colors.Border}):Play()
            CreateTween(button, {TextColor3 = Config.Colors.Text}):Play()
        end)
        
        button.MouseLeave:Connect(function()
            CreateTween(button, {BackgroundColor3 = Config.Colors.Tertiary}):Play()
            CreateTween(button, {TextColor3 = Config.Colors.TextSecondary}):Play()
        end)
    end
    
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 140, 1, -60)
    TabContainer.Position = UDim2.new(0, 8, 0, 58)
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainFrame
    
    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 4)
    TabList.Parent = TabContainer
    
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -160, 1, -68)
    ContentContainer.Position = UDim2.new(0, 156, 0, 58)
    ContentContainer.BackgroundColor3 = Config.Colors.Secondary
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = MainFrame
    
    CreateCorner(ContentContainer, 6)
    
    function Window:CreateTab(options)
        options = options or {}
        
        local Tab = {
            Name = options.Name or "Tab",
            Icon = options.Icon or "",
            Elements = {}
        }
        
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "TabButton_" .. Tab.Name
        TabButton.Size = UDim2.new(1, 0, 0, 32)
        TabButton.BackgroundColor3 = Config.Colors.Tertiary
        TabButton.BorderSizePixel = 0
        TabButton.Text = Tab.Name
        TabButton.TextColor3 = Config.Colors.TextSecondary
        TabButton.TextSize = 14
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.Font = Enum.Font.Gotham
        TabButton.Parent = TabContainer
        
        CreateCorner(TabButton, 4)
        AddTilting(TabButton, 2)
        
        local TabPadding = Instance.new("UIPadding")
        TabPadding.PaddingLeft = UDim.new(0, 12)
        TabPadding.Parent = TabButton
        
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = "TabContent_" .. Tab.Name
        TabContent.Size = UDim2.new(1, -16, 1, -16)
        TabContent.Position = UDim2.new(0, 8, 0, 8)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 2
        TabContent.ScrollBarImageColor3 = Config.Colors.Border
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.Visible = false
        TabContent.Parent = ContentContainer
        
        local ContentList = Instance.new("UIListLayout")
        ContentList.SortOrder = Enum.SortOrder.LayoutOrder
        ContentList.Padding = UDim.new(0, 8)
        ContentList.Parent = TabContent
        
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 16)
        end)
        
        local function SelectTab()
            for _, tab in pairs(Window.Tabs) do
                local otherButton = TabContainer:FindFirstChild("TabButton_" .. tab.Name)
                local otherContent = ContentContainer:FindFirstChild("TabContent_" .. tab.Name)
                
                if otherButton and otherContent then
                    CreateTween(otherButton, {BackgroundColor3 = Config.Colors.Tertiary}):Play()
                    CreateTween(otherButton, {TextColor3 = Config.Colors.TextSecondary}):Play()
                    otherContent.Visible = false
                end
            end
            
            CreateTween(TabButton, {BackgroundColor3 = Config.Colors.Accent}):Play()
            CreateTween(TabButton, {TextColor3 = Config.Colors.Background}):Play()
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end
        
        TabButton.MouseButton1Click:Connect(SelectTab)
        
        TabButton.MouseEnter:Connect(function()
            if Window.CurrentTab ~= Tab then
                CreateTween(TabButton, {BackgroundColor3 = Config.Colors.Border}):Play()
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if Window.CurrentTab ~= Tab then
                CreateTween(TabButton, {BackgroundColor3 = Config.Colors.Tertiary}):Play()
            end
        end)
        
        if #Window.Tabs == 0 then
            SelectTab()
        end
        
        function Tab:CreateButton(options)
            options = options or {}
            
            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Size = UDim2.new(1, 0, 0, 36)
            Button.BackgroundColor3 = Config.Colors.Background
            Button.BorderSizePixel = 0
            Button.Text = options.Text or "Button"
            Button.TextColor3 = Config.Colors.Text
            Button.TextSize = 14
            Button.Font = Enum.Font.Gotham
            Button.Parent = TabContent
            
            CreateCorner(Button, 4)
            CreateStroke(Button, Config.Colors.Border, 1)
            AddTilting(Button, 1.5)
            
            local buttonGlow = CreateGlow(Button, 10, Config.Colors.Glow)
            buttonGlow.ImageTransparency = 1
            
            Button.MouseEnter:Connect(function()
                CreateTween(Button, {BackgroundColor3 = Config.Colors.Tertiary}):Play()
                CreateTween(buttonGlow, {ImageTransparency = 0.85}):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                CreateTween(Button, {BackgroundColor3 = Config.Colors.Background}):Play()
                CreateTween(buttonGlow, {ImageTransparency = 1}):Play()
            end)
            
            Button.MouseButton1Click:Connect(function()
                if options.Callback then
                    options.Callback()
                end
            end)
            
            return Button
        end
        
        function Tab:CreateSlider(options)
            options = options or {}
            
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Name = "SliderFrame"
            SliderFrame.Size = UDim2.new(1, 0, 0, 52)
            SliderFrame.BackgroundColor3 = Config.Colors.Background
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Parent = TabContent
            
            CreateCorner(SliderFrame, 4)
            CreateStroke(SliderFrame, Config.Colors.Border, 1)
            AddTilting(SliderFrame, 1)
            
            local sliderGlow = CreateGlow(SliderFrame, 8, Config.Colors.Glow)
            sliderGlow.ImageTransparency = 1
            
            SliderFrame.MouseEnter:Connect(function()
                CreateTween(sliderGlow, {ImageTransparency = 0.9}):Play()
            end)
            
            SliderFrame.MouseLeave:Connect(function()
                CreateTween(sliderGlow, {ImageTransparency = 1}):Play()
            end)
            
            -- [Rest of slider code remains the same as original...]
            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Name = "Label"
            SliderLabel.Size = UDim2.new(0.7, 0, 0, 20)
            SliderLabel.Position = UDim2.new(0, 12, 0, 8)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = options.Text or "Slider"
            SliderLabel.TextColor3 = Config.Colors.Text
            SliderLabel.TextSize = 14
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Font = Enum.Font.Gotham
            SliderLabel.Parent = SliderFrame
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Name = "Value"
            ValueLabel.Size = UDim2.new(0.3, -12, 0, 20)
            ValueLabel.Position = UDim2.new(0.7, 0, 0, 8)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Text = tostring(options.Min or 0)
            ValueLabel.TextColor3 = Config.Colors.TextSecondary
            ValueLabel.TextSize = 14
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValueLabel.Font = Enum.Font.Gotham
            ValueLabel.Parent = SliderFrame
            
            local SliderTrack = Instance.new("Frame")
            SliderTrack.Name = "Track"
            SliderTrack.Size = UDim2.new(1, -24, 0, 4)
            SliderTrack.Position = UDim2.new(0, 12, 1, -16)
            SliderTrack.BackgroundColor3 = Config.Colors.Tertiary
            SliderTrack.BorderSizePixel = 0
            SliderTrack.Parent = SliderFrame
            
            CreateCorner(SliderTrack, 2)
            
            local SliderFill = Instance.new("Frame")
            SliderFill.Name = "Fill"
            SliderFill.Size = UDim2.new(0, 0, 1, 0)
            SliderFill.Position = UDim2.new(0, 0, 0, 0)
            SliderFill.BackgroundColor3 = Config.Colors.Accent
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderTrack
            
            CreateCorner(SliderFill, 2)
            
            local SliderHandle = Instance.new("TextButton")
            SliderHandle.Name = "Handle"
            SliderHandle.Size = UDim2.new(0, 12, 0, 12)
            SliderHandle.Position = UDim2.new(0, -6, 0.5, -6)
            SliderHandle.BackgroundColor3 = Config.Colors.Accent
            SliderHandle.BorderSizePixel = 0
            SliderHandle.Text = ""
            SliderHandle.Parent = SliderTrack
            
            CreateCorner(SliderHandle, 6)
            
            local min = options.Min or 0
            local max = options.Max or 100
            local default = options.Default or min
            local increment = options.Increment or 1
            local currentValue = default
            
            local function UpdateSlider(value)
                currentValue = math.clamp(value, min, max)
                if increment > 0 then
                    currentValue = math.round(currentValue / increment) * increment
                end
                
                local percentage = (currentValue - min) / (max - min)
                
                CreateTween(SliderFill, {Size = UDim2.new(percentage, 0, 1, 0)}):Play()
                CreateTween(SliderHandle, {Position = UDim2.new(percentage, -6, 0.5, -6)}):Play()
                
                ValueLabel.Text = tostring(currentValue)
                
                if options.Callback then
                    options.Callback(currentValue)
                end
            end
            
            local dragging = false
            
            SliderHandle.MouseButton1Down:Connect(function()
                dragging = true
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            SliderTrack.MouseButton1Down:Connect(function()
                local percentage = math.clamp((Mouse.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                local value = min + (percentage * (max - min))
                UpdateSlider(value)
            end)
            
            RunService.Heartbeat:Connect(function()
                if dragging then
                    local percentage = math.clamp((Mouse.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                    local value = min + (percentage * (max - min))
                    UpdateSlider(value)
                end
            end)
            
            UpdateSlider(currentValue)
            
            return {
                Set = function(value)
                    UpdateSlider(value)
                end
            }
        end
        
        Window.Tabs[#Window.Tabs + 1] = Tab
        return Tab
    end
    
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    CreateTween(MainFrame, {Size = Config.WindowSize}, 0.3):Play()
    
    return Window
end

return API1508
