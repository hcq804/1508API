-- 1508 API - Modern UI Library for Roblox
-- Inspired by Rayfield UI Library
-- Version 1.0.0

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

-- Configuration
local Config = {
    WindowSize = UDim2.new(0, 580, 0, 460),
    Colors = {
        Background = Color3.fromRGB(15, 15, 15),
        Secondary = Color3.fromRGB(25, 25, 25),
        Accent = Color3.fromRGB(88, 101, 242), -- Discord Blurple
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(180, 180, 180),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(240, 71, 71)
    },
    Animations = {
        Duration = 0.3,
        EasingStyle = Enum.EasingStyle.Quint,
        EasingDirection = Enum.EasingDirection.Out
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
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Config.Colors.Secondary
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

-- Main Library
function API1508:CreateWindow(options)
    options = options or {}
    
    local Window = {
        Title = options.Title or "1508 API",
        Subtitle = options.Subtitle or "Modern UI Library",
        ConfigurationSaving = options.ConfigurationSaving or false,
        FileName = options.FileName or "1508Config",
        KeybindTitle = options.KeybindTitle or "1508 API",
        Tabs = {},
        CurrentTab = nil
    }
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "1508API_" .. math.random(1000, 9999)
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame
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
    
    CreateCorner(MainFrame, 12)
    CreateStroke(MainFrame, Config.Colors.Secondary, 2)
    
    -- Drop Shadow
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 40, 1, 40)
    Shadow.Position = UDim2.new(0, -20, 0, -20)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://1316045217"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.8
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    Shadow.ZIndex = MainFrame.ZIndex - 1
    Shadow.Parent = MainFrame
    
    -- Top Bar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 60)
    TopBar.Position = UDim2.new(0, 0, 0, 0)
    TopBar.BackgroundColor3 = Config.Colors.Secondary
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    CreateCorner(TopBar, 12)
    
    -- Fix corner for top only
    local TopBarMask = Instance.new("Frame")
    TopBarMask.Size = UDim2.new(1, 0, 0.5, 0)
    TopBarMask.Position = UDim2.new(0, 0, 0.5, 0)
    TopBarMask.BackgroundColor3 = Config.Colors.Secondary
    TopBarMask.BorderSizePixel = 0
    TopBarMask.Parent = TopBar
    
    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(0.7, 0, 0.6, 0)
    TitleLabel.Position = UDim2.new(0, 20, 0.2, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = Window.Title
    TitleLabel.TextColor3 = Config.Colors.Text
    TitleLabel.TextScaled = true
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.GothamMedium
    TitleLabel.Parent = TopBar
    
    -- Subtitle
    local SubtitleLabel = Instance.new("TextLabel")
    SubtitleLabel.Name = "Subtitle"
    SubtitleLabel.Size = UDim2.new(0.7, 0, 0.3, 0)
    SubtitleLabel.Position = UDim2.new(0, 20, 0.7, 0)
    SubtitleLabel.BackgroundTransparency = 1
    SubtitleLabel.Text = Window.Subtitle
    SubtitleLabel.TextColor3 = Config.Colors.TextDark
    SubtitleLabel.TextScaled = true
    SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    SubtitleLabel.Font = Enum.Font.Gotham
    SubtitleLabel.Parent = TopBar
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 40, 0, 40)
    CloseButton.Position = UDim2.new(1, -50, 0.5, -20)
    CloseButton.BackgroundColor3 = Config.Colors.Error
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Config.Colors.Text
    CloseButton.TextScaled = true
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TopBar
    
    CreateCorner(CloseButton, 8)
    
    CloseButton.MouseButton1Click:Connect(function()
        local closeTween = CreateTween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
        closeTween:Play()
        closeTween.Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end)
    
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 180, 1, -80)
    TabContainer.Position = UDim2.new(0, 10, 0, 70)
    TabContainer.BackgroundColor3 = Config.Colors.Secondary
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainFrame
    
    CreateCorner(TabContainer, 8)
    
    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)
    TabList.Parent = TabContainer
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 10)
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.PaddingRight = UDim.new(0, 10)
    TabPadding.Parent = TabContainer
    
    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -210, 1, -80)
    ContentContainer.Position = UDim2.new(0, 200, 0, 70)
    ContentContainer.BackgroundColor3 = Config.Colors.Secondary
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = MainFrame
    
    CreateCorner(ContentContainer, 8)
    
    -- Window Functions
    function Window:CreateTab(options)
        options = options or {}
        
        local Tab = {
            Name = options.Name or "Tab",
            Icon = options.Icon or "rbxassetid://4483345998",
            Elements = {}
        }
        
        -- Tab Button
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "TabButton_" .. Tab.Name
        TabButton.Size = UDim2.new(1, 0, 0, 40)
        TabButton.BackgroundColor3 = Config.Colors.Background
        TabButton.BorderSizePixel = 0
        TabButton.Text = ""
        TabButton.Parent = TabContainer
        
        CreateCorner(TabButton, 6)
        
        -- Tab Icon
        local TabIcon = Instance.new("ImageLabel")
        TabIcon.Name = "Icon"
        TabIcon.Size = UDim2.new(0, 20, 0, 20)
        TabIcon.Position = UDim2.new(0, 10, 0.5, -10)
        TabIcon.BackgroundTransparency = 1
        TabIcon.Image = Tab.Icon
        TabIcon.ImageColor3 = Config.Colors.TextDark
        TabIcon.Parent = TabButton
        
        -- Tab Label
        local TabLabel = Instance.new("TextLabel")
        TabLabel.Name = "Label"
        TabLabel.Size = UDim2.new(1, -45, 1, 0)
        TabLabel.Position = UDim2.new(0, 40, 0, 0)
        TabLabel.BackgroundTransparency = 1
        TabLabel.Text = Tab.Name
        TabLabel.TextColor3 = Config.Colors.TextDark
        TabLabel.TextScaled = true
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left
        TabLabel.Font = Enum.Font.Gotham
        TabLabel.Parent = TabButton
        
        -- Tab Content
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = "TabContent_" .. Tab.Name
        TabContent.Size = UDim2.new(1, -20, 1, -20)
        TabContent.Position = UDim2.new(0, 10, 0, 10)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 3
        TabContent.ScrollBarImageColor3 = Config.Colors.Accent
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.Visible = false
        TabContent.Parent = ContentContainer
        
        local ContentList = Instance.new("UIListLayout")
        ContentList.SortOrder = Enum.SortOrder.LayoutOrder
        ContentList.Padding = UDim.new(0, 8)
        ContentList.Parent = TabContent
        
        -- Update canvas size when content changes
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 20)
        end)
        
        -- Tab Selection Logic
        local function SelectTab()
            for _, tab in pairs(Window.Tabs) do
                local otherButton = TabContainer:FindFirstChild("TabButton_" .. tab.Name)
                local otherContent = ContentContainer:FindFirstChild("TabContent_" .. tab.Name)
                
                if otherButton and otherContent then
                    CreateTween(otherButton, {BackgroundColor3 = Config.Colors.Background}):Play()
                    CreateTween(otherButton.Icon, {ImageColor3 = Config.Colors.TextDark}):Play()
                    CreateTween(otherButton.Label, {TextColor3 = Config.Colors.TextDark}):Play()
                    otherContent.Visible = false
                end
            end
            
            CreateTween(TabButton, {BackgroundColor3 = Config.Colors.Accent}):Play()
            CreateTween(TabIcon, {ImageColor3 = Config.Colors.Text}):Play()
            CreateTween(TabLabel, {TextColor3 = Config.Colors.Text}):Play()
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end
        
        TabButton.MouseButton1Click:Connect(SelectTab)
        
        -- Select first tab by default
        if #Window.Tabs == 0 then
            SelectTab()
        end
        
        -- Tab Element Functions
        function Tab:CreateButton(options)
            options = options or {}
            
            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Size = UDim2.new(1, 0, 0, 45)
            Button.BackgroundColor3 = Config.Colors.Background
            Button.BorderSizePixel = 0
            Button.Text = options.Text or "Button"
            Button.TextColor3 = Config.Colors.Text
            Button.TextScaled = true
            Button.Font = Enum.Font.Gotham
            Button.Parent = TabContent
            
            CreateCorner(Button, 6)
            
            local ButtonPadding = Instance.new("UIPadding")
            ButtonPadding.PaddingLeft = UDim.new(0, 15)
            ButtonPadding.PaddingRight = UDim.new(0, 15)
            ButtonPadding.Parent = Button
            
            Button.MouseEnter:Connect(function()
                CreateTween(Button, {BackgroundColor3 = Config.Colors.Accent}):Play()
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
            ToggleFrame.Size = UDim2.new(1, 0, 0, 45)
            ToggleFrame.BackgroundColor3 = Config.Colors.Background
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = TabContent
            
            CreateCorner(ToggleFrame, 6)
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Name = "Label"
            ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = options.Text or "Toggle"
            ToggleLabel.TextColor3 = Config.Colors.Text
            ToggleLabel.TextScaled = true
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.Parent = ToggleFrame
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Name = "Toggle"
            ToggleButton.Size = UDim2.new(0, 40, 0, 20)
            ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
            ToggleButton.BackgroundColor3 = Config.Colors.Secondary
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = ""
            ToggleButton.Parent = ToggleFrame
            
            CreateCorner(ToggleButton, 10)
            
            local ToggleIndicator = Instance.new("Frame")
            ToggleIndicator.Name = "Indicator"
            ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
            ToggleIndicator.Position = UDim2.new(0, 2, 0.5, -8)
            ToggleIndicator.BackgroundColor3 = Config.Colors.TextDark
            ToggleIndicator.BorderSizePixel = 0
            ToggleIndicator.Parent = ToggleButton
            
            CreateCorner(ToggleIndicator, 8)
            
            local isToggled = options.Default or false
            
            local function UpdateToggle()
                if isToggled then
                    CreateTween(ToggleButton, {BackgroundColor3 = Config.Colors.Accent}):Play()
                    CreateTween(ToggleIndicator, {
                        Position = UDim2.new(1, -18, 0.5, -8),
                        BackgroundColor3 = Config.Colors.Text
                    }):Play()
                else
                    CreateTween(ToggleButton, {BackgroundColor3 = Config.Colors.Secondary}):Play()
                    CreateTween(ToggleIndicator, {
                        Position = UDim2.new(0, 2, 0.5, -8),
                        BackgroundColor3 = Config.Colors.TextDark
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
            SliderFrame.Size = UDim2.new(1, 0, 0, 65)
            SliderFrame.BackgroundColor3 = Config.Colors.Background
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Parent = TabContent
            
            CreateCorner(SliderFrame, 6)
            
            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Name = "Label"
            SliderLabel.Size = UDim2.new(0.7, 0, 0, 25)
            SliderLabel.Position = UDim2.new(0, 15, 0, 10)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = options.Text or "Slider"
            SliderLabel.TextColor3 = Config.Colors.Text
            SliderLabel.TextScaled = true
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Font = Enum.Font.Gotham
            SliderLabel.Parent = SliderFrame
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Name = "Value"
            ValueLabel.Size = UDim2.new(0.3, -15, 0, 25)
            ValueLabel.Position = UDim2.new(0.7, 0, 0, 10)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Text = tostring(options.Min or 0)
            ValueLabel.TextColor3 = Config.Colors.Accent
            ValueLabel.TextScaled = true
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValueLabel.Font = Enum.Font.GothamMedium
            ValueLabel.Parent = SliderFrame
            
            local SliderTrack = Instance.new("Frame")
            SliderTrack.Name = "Track"
            SliderTrack.Size = UDim2.new(1, -30, 0, 6)
            SliderTrack.Position = UDim2.new(0, 15, 1, -20)
            SliderTrack.BackgroundColor3 = Config.Colors.Secondary
            SliderTrack.BorderSizePixel = 0
            SliderTrack.Parent = SliderFrame
            
            CreateCorner(SliderTrack, 3)
            
            local SliderFill = Instance.new("Frame")
            SliderFill.Name = "Fill"
            SliderFill.Size = UDim2.new(0, 0, 1, 0)
            SliderFill.Position = UDim2.new(0, 0, 0, 0)
            SliderFill.BackgroundColor3 = Config.Colors.Accent
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderTrack
            
            CreateCorner(SliderFill, 3)
            
            local SliderHandle = Instance.new("TextButton")
            SliderHandle.Name = "Handle"
            SliderHandle.Size = UDim2.new(0, 16, 0, 16)
            SliderHandle.Position = UDim2.new(0, -8, 0.5, -8)
            SliderHandle.BackgroundColor3 = Config.Colors.Text
            SliderHandle.BorderSizePixel = 0
            SliderHandle.Text = ""
            SliderHandle.Parent = SliderTrack
            
            CreateCorner(SliderHandle, 8)
            
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
                CreateTween(SliderHandle, {Position = UDim2.new(percentage, -8, 0.5, -8)}):Play()
                
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
            TextboxFrame.Size = UDim2.new(1, 0, 0, 45)
            TextboxFrame.BackgroundColor3 = Config.Colors.Background
            TextboxFrame.BorderSizePixel = 0
            TextboxFrame.Parent = TabContent
            
            CreateCorner(TextboxFrame, 6)
            
            local Textbox = Instance.new("TextBox")
            Textbox.Name = "Textbox"
            Textbox.Size = UDim2.new(1, -30, 1, 0)
            Textbox.Position = UDim2.new(0, 15, 0, 0)
            Textbox.BackgroundTransparency = 1
            Textbox.Text = options.Default or ""
            Textbox.PlaceholderText = options.Text or "Enter text..."
            Textbox.TextColor3 = Config.Colors.Text
            Textbox.PlaceholderColor3 = Config.Colors.TextDark
            Textbox.TextScaled = true
            Textbox.TextXAlignment = Enum.TextXAlignment.Left
            Textbox.Font = Enum.Font.Gotham
            Textbox.ClearTextOnFocus = false
            Textbox.Parent = TextboxFrame
            
            Textbox.FocusLost:Connect(function(enterPressed)
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
            Label.Size = UDim2.new(1, 0, 0, 35)
            Label.BackgroundTransparency = 1
            Label.Text = options.Text or "Label"
            Label.TextColor3 = Config.Colors.Text
            Label.TextScaled = true
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Font = Enum.Font.Gotham
            Label.Parent = TabContent
            
            local LabelPadding = Instance.new("UIPadding")
            LabelPadding.PaddingLeft = UDim.new(0, 15)
            LabelPadding.PaddingRight = UDim.new(0, 15)
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
    
    -- Window animation
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    local openTween = CreateTween(MainFrame, {Size = Config.WindowSize}, 0.5)
    openTween:Play()
    
    return Window
end

-- Configuration Saving (if needed)
function API1508:LoadConfiguration()
    -- Configuration loading logic would go here
    -- This would interface with Roblox's DataStore or file system
end

return API1508
