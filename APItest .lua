-- 1508 API - Modern Minimalist UI Library for Roblox
-- Redesigned with clean, minimal aesthetics
-- Version 2.0.0

local API1508 = {}
API1508.__index = API1508

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- Variables
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Minimal Modern Configuration
local Config = {
    WindowSize = UDim2.new(0, 520, 0, 400),
    Colors = {
        Background = Color3.fromRGB(10, 10, 10),      -- #0a0a0a
        Secondary = Color3.fromRGB(17, 17, 17),       -- #111111
        Tertiary = Color3.fromRGB(25, 25, 25),        -- #191919
        Border = Color3.fromRGB(34, 34, 34),          -- #222222
        Text = Color3.fromRGB(255, 255, 255),         -- #ffffff
        TextSecondary = Color3.fromRGB(187, 187, 187), -- #bbbbbb
        TextMuted = Color3.fromRGB(136, 136, 136),    -- #888888
        Accent = Color3.fromRGB(255, 255, 255),       -- Clean white accent
        AccentHover = Color3.fromRGB(240, 240, 240),  -- Subtle hover
    },
    Animations = {
        Duration = 0.15,
        EasingStyle = Enum.EasingStyle.Sine,
        EasingDirection = Enum.EasingDirection.Out
    },
    Spacing = {
        Small = 8,
        Medium = 16,
        Large = 24
    }
}

-- Utility Functions
local function CreateTween(object, properties, duration)
    duration = duration or Config.Animations.Duration
    local tweenInfo = TweenInfo.new(
        duration,
        Config.Animations.EasingStyle,
        Config.Animations.EasingDirection
    )
    return TweenService:Create(object, tweenInfo, properties)
end

local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 4)
    corner.Parent = parent
    return corner
end

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Config.Colors.Border
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

-- Main Library
function API1508:CreateWindow(options)
    options = options or {}
    
    local Window = {
        Title = options.Title or "Modern UI",
        Subtitle = options.Subtitle or "",
        ConfigurationSaving = options.ConfigurationSaving or false,
        FileName = options.FileName or "ModernConfig",
        KeybindTitle = options.KeybindTitle or "Modern UI",
        Tabs = {},
        CurrentTab = nil
    }
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ModernUI_" .. math.random(1000, 9999)
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame - Ultra minimal design
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
    
    -- Minimal Top Bar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.Position = UDim2.new(0, 0, 0, 0)
    TopBar.BackgroundColor3 = Config.Colors.Secondary
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    CreateCorner(TopBar, 8)
    
    -- Fix corner for top only
    local TopBarMask = Instance.new("Frame")
    TopBarMask.Size = UDim2.new(1, 0, 0.5, 0)
    TopBarMask.Position = UDim2.new(0, 0, 0.5, 0)
    TopBarMask.BackgroundColor3 = Config.Colors.Secondary
    TopBarMask.BorderSizePixel = 0
    TopBarMask.Parent = TopBar
    
    -- Clean Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(1, -60, 1, 0)
    TitleLabel.Position = UDim2.new(0, Config.Spacing.Medium, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = Window.Title
    TitleLabel.TextColor3 = Config.Colors.Text
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.GothamMedium
    TitleLabel.Parent = TopBar
    
    -- Minimal Close Button
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
    
    CloseButton.MouseEnter:Connect(function()
        CreateTween(CloseButton, {BackgroundColor3 = Config.Colors.Border}):Play()
        CreateTween(CloseButton, {TextColor3 = Config.Colors.Text}):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        CreateTween(CloseButton, {BackgroundColor3 = Config.Colors.Tertiary}):Play()
        CreateTween(CloseButton, {TextColor3 = Config.Colors.TextSecondary}):Play()
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        local closeTween = CreateTween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.2)
        closeTween:Play()
        closeTween.Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end)
    
    -- Clean Tab Container
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
    
    -- Clean Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -160, 1, -68)
    ContentContainer.Position = UDim2.new(0, 156, 0, 58)
    ContentContainer.BackgroundColor3 = Config.Colors.Secondary
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = MainFrame
    
    CreateCorner(ContentContainer, 6)
    
    -- Window Functions
    function Window:CreateTab(options)
        options = options or {}
        
        local Tab = {
            Name = options.Name or "Tab",
            Icon = options.Icon or "",
            Elements = {}
        }
        
        -- Minimal Tab Button
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
        
        local TabPadding = Instance.new("UIPadding")
        TabPadding.PaddingLeft = UDim.new(0, 12)
        TabPadding.Parent = TabButton
        
        -- Tab Content
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
        ContentList.Padding = UDim.new(0, Config.Spacing.Small)
        ContentList.Parent = TabContent
        
        -- Update canvas size
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 16)
        end)
        
        -- Tab Selection Logic
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
        
        -- Hover effects
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
        
        -- Select first tab by default
        if #Window.Tabs == 0 then
            SelectTab()
        end
        
        -- Tab Element Functions
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
            
            local ButtonPadding = Instance.new("UIPadding")
            ButtonPadding.PaddingLeft = UDim.new(0, 12)
            ButtonPadding.PaddingRight = UDim.new(0, 12)
            ButtonPadding.Parent = Button
            
            Button.MouseEnter:Connect(function()
                CreateTween(Button, {BackgroundColor3 = Config.Colors.Tertiary}):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                CreateTween(Button, {BackgroundColor3 = Config.Colors.Background}):Play()
            end)
            
            Button.MouseButton1Click:Connect(function()
                if options.Callback then
                    options.Callback()
                end
            end)
            
            return Button
        end
        
        function Tab:CreateToggle(options)
            options = options or {}
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Size = UDim2.new(1, 0, 0, 36)
            ToggleFrame.BackgroundColor3 = Config.Colors.Background
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = TabContent
            
            CreateCorner(ToggleFrame, 4)
            CreateStroke(ToggleFrame, Config.Colors.Border, 1)
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Name = "Label"
            ToggleLabel.Size = UDim2.new(1, -50, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 12, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = options.Text or "Toggle"
            ToggleLabel.TextColor3 = Config.Colors.Text
            ToggleLabel.TextSize = 14
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.Parent = ToggleFrame
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Name = "Toggle"
            ToggleButton.Size = UDim2.new(0, 32, 0, 16)
            ToggleButton.Position = UDim2.new(1, -40, 0.5, -8)
            ToggleButton.BackgroundColor3 = Config.Colors.Tertiary
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = ""
            ToggleButton.Parent = ToggleFrame
            
            CreateCorner(ToggleButton, 8)
            
            local ToggleIndicator = Instance.new("Frame")
            ToggleIndicator.Name = "Indicator"
            ToggleIndicator.Size = UDim2.new(0, 12, 0, 12)
            ToggleIndicator.Position = UDim2.new(0, 2, 0.5, -6)
            ToggleIndicator.BackgroundColor3 = Config.Colors.TextMuted
            ToggleIndicator.BorderSizePixel = 0
            ToggleIndicator.Parent = ToggleButton
            
            CreateCorner(ToggleIndicator, 6)
            
            local isToggled = options.Default or false
            
            local function UpdateToggle()
                if isToggled then
                    CreateTween(ToggleButton, {BackgroundColor3 = Config.Colors.Accent}):Play()
                    CreateTween(ToggleIndicator, {
                        Position = UDim2.new(1, -14, 0.5, -6),
                        BackgroundColor3 = Config.Colors.Background
                    }):Play()
                else
                    CreateTween(ToggleButton, {BackgroundColor3 = Config.Colors.Tertiary}):Play()
                    CreateTween(ToggleIndicator, {
                        Position = UDim2.new(0, 2, 0.5, -6),
                        BackgroundColor3 = Config.Colors.TextMuted
                    }):Play()
                end
                
                if options.Callback then
                    options.Callback(isToggled)
                end
            end
            
            ToggleButton.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                UpdateToggle()
            end)
            
            UpdateToggle()
            
            return {
                Set = function(value)
                    isToggled = value
                    UpdateToggle()
                end
            }
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
        
        function Tab:CreateTextbox(options)
            options = options or {}
            
            local TextboxFrame = Instance.new("Frame")
            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Size = UDim2.new(1, 0, 0, 36)
            TextboxFrame.BackgroundColor3 = Config.Colors.Background
            TextboxFrame.BorderSizePixel = 0
            TextboxFrame.Parent = TabContent
            
            CreateCorner(TextboxFrame, 4)
            CreateStroke(TextboxFrame, Config.Colors.Border, 1)
            
            local Textbox = Instance.new("TextBox")
            Textbox.Name = "Textbox"
            Textbox.Size = UDim2.new(1, -24, 1, 0)
            Textbox.Position = UDim2.new(0, 12, 0, 0)
            Textbox.BackgroundTransparency = 1
            Textbox.Text = options.Default or ""
            Textbox.PlaceholderText = options.Text or "Enter text..."
            Textbox.TextColor3 = Config.Colors.Text
            Textbox.PlaceholderColor3 = Config.Colors.TextMuted
            Textbox.TextSize = 14
            Textbox.TextXAlignment = Enum.TextXAlignment.Left
            Textbox.Font = Enum.Font.Gotham
            Textbox.ClearTextOnFocus = false
            Textbox.Parent = TextboxFrame
            
            Textbox.Focused:Connect(function()
                CreateStroke(TextboxFrame, Config.Colors.Accent, 1)
            end)
            
            Textbox.FocusLost:Connect(function(enterPressed)
                CreateStroke(TextboxFrame, Config.Colors.Border, 1)
                if enterPressed and options.Callback then
                    options.Callback(Textbox.Text)
                end
            end)
            
            return {
                Set = function(text)
                    Textbox.Text = text
                end
            }
        end
        
        function Tab:CreateLabel(options)
            options = options or {}
            
            local Label = Instance.new("TextLabel")
            Label.Name = "Label"
            Label.Size = UDim2.new(1, 0, 0, 28)
            Label.BackgroundTransparency = 1
            Label.Text = options.Text or "Label"
            Label.TextColor3 = Config.Colors.TextSecondary
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Font = Enum.Font.Gotham
            Label.Parent = TabContent
            
            local LabelPadding = Instance.new("UIPadding")
            LabelPadding.PaddingLeft = UDim.new(0, 12)
            LabelPadding.PaddingRight = UDim.new(0, 12)
            LabelPadding.Parent = Label
            
            return {
                Set = function(text)
                    Label.Text = text
                end
            }
        end
        
        Window.Tabs[#Window.Tabs + 1] = Tab
        return Tab
    end
    
    -- Smooth window animation
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    local openTween = CreateTween(MainFrame, {Size = Config.WindowSize}, 0.3)
    openTween:Play()
    
    return Window
end

return API1508
