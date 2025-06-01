-- 1508 API Enhanced - Modern Dynamic UI Library for Roblox
-- Enhanced with dynamic glow effects and smooth window motion
-- Version 2.1.0 - Dynamic Edition

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

-- Enhanced Dynamic Configuration
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
        Glow = Color3.fromRGB(255, 255, 255),         -- Glow color
        GlowTransparent = Color3.fromRGB(255, 255, 255), -- Transparent glow
    },
    Animations = {
        Duration = 0.15,
        SlowDuration = 0.25,
        FastDuration = 0.08,
        EasingStyle = Enum.EasingStyle.Sine,
        EasingDirection = Enum.EasingDirection.Out,
        MotionBlur = {
            Intensity = 0.3,
            Duration = 0.4
        }
    },
    Effects = {
        GlowSize = 20,
        GlowIntensity = 0.6,
        MotionLatency = 0.12,
        BlurRadius = 8
    },
    Spacing = {
        Small = 8,
        Medium = 16,
        Large = 24
    }
}

-- Enhanced Utility Functions
local function CreateTween(object, properties, duration, easingStyle, easingDirection)
    duration = duration or Config.Animations.Duration
    easingStyle = easingStyle or Config.Animations.EasingStyle
    easingDirection = easingDirection or Config.Animations.EasingDirection
    
    local tweenInfo = TweenInfo.new(duration, easingStyle, easingDirection)
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

-- Dynamic Glow Effect Function
local function CreateDynamicGlow(button, glowColor)
    glowColor = glowColor or Config.Colors.Glow
    
    -- Create glow frame
    local glowFrame = Instance.new("Frame")
    glowFrame.Name = "DynamicGlow"
    glowFrame.Size = UDim2.new(1, Config.Effects.GlowSize * 2, 1, Config.Effects.GlowSize * 2)
    glowFrame.Position = UDim2.new(0, -Config.Effects.GlowSize, 0, -Config.Effects.GlowSize)
    glowFrame.BackgroundColor3 = glowColor
    glowFrame.BackgroundTransparency = 1
    glowFrame.BorderSizePixel = 0
    glowFrame.ZIndex = button.ZIndex - 1
    glowFrame.Parent = button.Parent
    
    CreateCorner(glowFrame, (button:FindFirstChild("UICorner") and button.UICorner.CornerRadius.Offset + Config.Effects.GlowSize) or 12)
    
    -- Create gradient for glow effect
    local gradient = Instance.new("UIGradient")
    gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.7, Config.Effects.GlowIntensity),
        NumberSequenceKeypoint.new(1, 1)
    })
    gradient.Parent = glowFrame
    
    local glowConnection
    local isHovering = false
    
    -- Mouse tracking for dynamic glow
    local function updateGlowPosition()
        if not isHovering or not button.Parent then
            return
        end
        
        local mousePos = Vector2.new(Mouse.X, Mouse.Y)
        local buttonPos = Vector2.new(button.AbsolutePosition.X, button.AbsolutePosition.Y)
        local buttonSize = Vector2.new(button.AbsoluteSize.X, button.AbsoluteSize.Y)
        local buttonCenter = buttonPos + buttonSize * 0.5
        
        -- Calculate relative position
        local relativePos = mousePos - buttonCenter
        local distance = relativePos.Magnitude
        local maxDistance = math.max(buttonSize.X, buttonSize.Y) * 0.7
        
        if distance < maxDistance then
            -- Mouse is near the button, create directional glow
            local normalizedPos = relativePos / maxDistance
            gradient.Offset = Vector2.new(normalizedPos.X * 0.3, normalizedPos.Y * 0.3)
            
            -- Adjust glow intensity based on distance
            local intensity = math.max(0.2, 1 - (distance / maxDistance))
            gradient.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.5, 1 - (Config.Effects.GlowIntensity * intensity)),
                NumberSequenceKeypoint.new(1, 1)
            })
        end
    end
    
    -- Hover events
    button.MouseEnter:Connect(function()
        isHovering = true
        glowFrame.BackgroundTransparency = 0.4
        
        CreateTween(glowFrame, {
            BackgroundTransparency = 0.7,
            Size = UDim2.new(1, Config.Effects.GlowSize * 3, 1, Config.Effects.GlowSize * 3),
            Position = UDim2.new(0, -Config.Effects.GlowSize * 1.5, 0, -Config.Effects.GlowSize * 1.5)
        }, Config.Animations.SlowDuration):Play()
        
        glowConnection = RunService.Heartbeat:Connect(updateGlowPosition)
    end)
    
    button.MouseLeave:Connect(function()
        isHovering = false
        if glowConnection then
            glowConnection:Disconnect()
            glowConnection = nil
        end
        
        CreateTween(glowFrame, {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, Config.Effects.GlowSize * 2, 1, Config.Effects.GlowSize * 2),
            Position = UDim2.new(0, -Config.Effects.GlowSize, 0, -Config.Effects.GlowSize)
        }, Config.Animations.Duration):Play()
        
        -- Reset gradient
        gradient.Offset = Vector2.new(0, 0)
        gradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.7, Config.Effects.GlowIntensity),
            NumberSequenceKeypoint.new(1, 1)
        })
    end)
    
    return glowFrame
end

-- Enhanced Window Motion with Latency and Blur
local function CreateMotionEffects(mainFrame)
    local targetPosition = mainFrame.Position
    local currentVelocity = Vector2.new(0, 0)
    local lastPosition = Vector2.new(mainFrame.AbsolutePosition.X, mainFrame.AbsolutePosition.Y)
    
    -- Motion blur effect container
    local blurContainer = Instance.new("Frame")
    blurContainer.Name = "MotionBlurContainer"
    blurContainer.Size = UDim2.new(1, 20, 1, 20)
    blurContainer.Position = UDim2.new(0, -10, 0, -10)
    blurContainer.BackgroundTransparency = 1
    blurContainer.BorderSizePixel = 0
    blurContainer.ZIndex = mainFrame.ZIndex - 1
    blurContainer.Parent = mainFrame.Parent
    
    local motionConnection
    local isDragging = false
    local dragStart = nil
    local frameTrails = {}
    
    -- Create trail frames for motion blur
    for i = 1, 3 do
        local trail = Instance.new("Frame")
        trail.Name = "Trail" .. i
        trail.Size = mainFrame.Size
        trail.BackgroundColor3 = Config.Colors.Background
        trail.BackgroundTransparency = 0.7 + (i * 0.1)
        trail.BorderSizePixel = 0
        trail.Visible = false
        trail.ZIndex = mainFrame.ZIndex - i
        trail.Parent = blurContainer
        
        CreateCorner(trail, 8)
        CreateStroke(trail, Config.Colors.Border, 1)
        
        frameTrails[i] = {
            frame = trail,
            position = mainFrame.Position,
            transparency = 0.7 + (i * 0.1)
        }
    end
    
    -- Detect dragging start
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            dragStart = tick()
            
            -- Start motion effects
            motionConnection = RunService.Heartbeat:Connect(function()
                local currentPos = Vector2.new(mainFrame.AbsolutePosition.X, mainFrame.AbsolutePosition.Y)
                local velocity = currentPos - lastPosition
                local speed = velocity.Magnitude
                
                -- Update trails for motion blur
                if speed > 2 then
                    for i, trail in pairs(frameTrails) do
                        trail.frame.Visible = true
                        trail.frame.Position = UDim2.new(
                            trail.position.X.Scale - (velocity.X * i * 0.003),
                            trail.position.X.Offset - (velocity.X * i * 0.3),
                            trail.position.Y.Scale - (velocity.Y * i * 0.003),
                            trail.position.Y.Offset - (velocity.Y * i * 0.3)
                        )
                        
                        -- Fade trails
                        CreateTween(trail.frame, {
                            BackgroundTransparency = trail.transparency + (speed * 0.01)
                        }, Config.Animations.FastDuration):Play()
                        
                        trail.position = mainFrame.Position
                    end
                else
                    -- Hide trails when not moving fast
                    for _, trail in pairs(frameTrails) do
                        CreateTween(trail.frame, {
                            BackgroundTransparency = 1
                        }, Config.Animations.Duration):Play()
                        
                        wait(Config.Animations.Duration)
                        if trail.frame.BackgroundTransparency >= 0.99 then
                            trail.frame.Visible = false
                        end
                    end
                end
                
                lastPosition = currentPos
            end)
        end
    end)
    
    -- Detect dragging end
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and isDragging then
            isDragging = false
            
            if motionConnection then
                motionConnection:Disconnect()
                motionConnection = nil
            end
            
            -- Smooth settling animation with latency
            local settleTime = Config.Effects.MotionLatency
            CreateTween(mainFrame, {
                Position = mainFrame.Position
            }, settleTime, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out):Play()
            
            -- Fade out all trails
            for _, trail in pairs(frameTrails) do
                CreateTween(trail.frame, {
                    BackgroundTransparency = 1
                }, Config.Animations.SlowDuration):Play()
                
                spawn(function()
                    wait(Config.Animations.SlowDuration)
                    trail.frame.Visible = false
                end)
            end
        end
    end)
end

-- Main Library with Enhanced Effects
function API1508:CreateWindow(options)
    options = options or {}
    
    local Window = {
        Title = options.Title or "Modern UI Enhanced",
        Subtitle = options.Subtitle or "",
        ConfigurationSaving = options.ConfigurationSaving or false,
        FileName = options.FileName or "ModernConfig",
        KeybindTitle = options.KeybindTitle or "Modern UI",
        Tabs = {},
        CurrentTab = nil
    }
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ModernUI_Enhanced_" .. math.random(1000, 9999)
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame with enhanced design
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
    
    -- Add motion effects to the main frame
    CreateMotionEffects(MainFrame)
    
    -- Enhanced Top Bar with glow
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.Position = UDim2.new(0, 0, 0, 0)
    TopBar.BackgroundColor3 = Config.Colors.Secondary
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    CreateCorner(TopBar, 8)
    
    -- Top bar gradient effect
    local topBarGradient = Instance.new("UIGradient")
    topBarGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Config.Colors.Secondary),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
    })
    topBarGradient.Rotation = 90
    topBarGradient.Parent = TopBar
    
    -- Fix corner for top only
    local TopBarMask = Instance.new("Frame")
    TopBarMask.Size = UDim2.new(1, 0, 0.5, 0)
    TopBarMask.Position = UDim2.new(0, 0, 0.5, 0)
    TopBarMask.BackgroundColor3 = Config.Colors.Secondary
    TopBarMask.BorderSizePixel = 0
    TopBarMask.Parent = TopBar
    
    -- Enhanced Title with glow effect
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
    TitleLabel.TextStrokeTransparency = 0.8
    TitleLabel.TextStrokeColor3 = Config.Colors.Accent
    TitleLabel.Parent = TopBar
    
    -- Enhanced Close Button with dynamic glow
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
    CreateDynamicGlow(CloseButton, Color3.fromRGB(255, 100, 100))
    
    CloseButton.MouseEnter:Connect(function()
        CreateTween(CloseButton, {
            BackgroundColor3 = Color3.fromRGB(255, 60, 60),
            TextColor3 = Config.Colors.Text,
            Size = UDim2.new(0, 32, 0, 32)
        }, Config.Animations.FastDuration):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        CreateTween(CloseButton, {
            BackgroundColor3 = Config.Colors.Tertiary,
            TextColor3 = Config.Colors.TextSecondary,
            Size = UDim2.new(0, 30, 0, 30)
        }, Config.Animations.Duration):Play()
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        CreateTween(CloseButton, {
            Size = UDim2.new(0, 28, 0, 28),
            BackgroundColor3 = Color3.fromRGB(200, 40, 40)
        }, 0.1):Play()
        
        wait(0.1)
        
        local closeTween = CreateTween(MainFrame, {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        closeTween:Play()
        closeTween.Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end)
    
    -- Enhanced Tab Container
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
    
    -- Enhanced Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -160, 1, -68)
    ContentContainer.Position = UDim2.new(0, 156, 0, 58)
    ContentContainer.BackgroundColor3 = Config.Colors.Secondary
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = MainFrame
    
    CreateCorner(ContentContainer, 6)
    
    -- Content container gradient
    local contentGradient = Instance.new("UIGradient")
    contentGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Config.Colors.Secondary),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
    })
    contentGradient.Rotation = 45
    contentGradient.Parent = ContentContainer
    
    -- Enhanced Window Functions
    function Window:CreateTab(options)
        options = options or {}
        
        local Tab = {
            Name = options.Name or "Tab",
            Icon = options.Icon or "",
            Elements = {}
        }
        
        -- Enhanced Tab Button with dynamic glow
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
        CreateDynamicGlow(TabButton, Config.Colors.Accent)
        
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
        
        -- Enhanced Tab Selection Logic
        local function SelectTab()
            for _, tab in pairs(Window.Tabs) do
                local otherButton = TabContainer:FindFirstChild("TabButton_" .. tab.Name)
                local otherContent = ContentContainer:FindFirstChild("TabContent_" .. tab.Name)
                
                if otherButton and otherContent then
                    CreateTween(otherButton, {
                        BackgroundColor3 = Config.Colors.Tertiary,
                        TextColor3 = Config.Colors.TextSecondary,
                        Size = UDim2.new(1, 0, 0, 32)
                    }, Config.Animations.Duration):Play()
                    otherContent.Visible = false
                end
            end
            
            CreateTween(TabButton, {
                BackgroundColor3 = Config.Colors.Accent,
                TextColor3 = Config.Colors.Background,
                Size = UDim2.new(1, 2, 0, 34)
            }, Config.Animations.SlowDuration, Enum.EasingStyle.Back):Play()
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end
        
        TabButton.MouseButton1Click:Connect(SelectTab)
        
        -- Enhanced hover effects
        TabButton.MouseEnter:Connect(function()
            if Window.CurrentTab ~= Tab then
                CreateTween(TabButton, {
                    BackgroundColor3 = Config.Colors.Border,
                    Size = UDim2.new(1, 1, 0, 33)
                }, Config.Animations.FastDuration):Play()
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if Window.CurrentTab ~= Tab then
                CreateTween(TabButton, {
                    BackgroundColor3 = Config.Colors.Tertiary,
                    Size = UDim2.new(1, 0, 0, 32)
                }, Config.Animations.Duration):Play()
            end
        end)
        
        -- Select first tab by default
        if #Window.Tabs == 0 then
            SelectTab()
        end
        
        -- Enhanced Tab Element Functions
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
            
            CreateCorner(ToggleButton, 8)
            CreateDynamicGlow(ToggleButton, Config.Colors.Accent)
            
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
                    CreateTween(ToggleButton, {
                        BackgroundColor3 = Config.Colors.Accent,
                        Size = UDim2.new(0, 34, 0, 18)
                    }, Config.Animations.SlowDuration, Enum.EasingStyle.Back):Play()
                    CreateTween(ToggleIndicator, {
                        Position = UDim2.new(1, -14, 0.5, -6),
                        BackgroundColor3 = Config.Colors.Background,
                        Size = UDim2.new(0, 14, 0, 14)
                    }, Config.Animations.SlowDuration, Enum.EasingStyle.Back):Play()
                else
                    CreateTween(ToggleButton, {
                        BackgroundColor3 = Config.Colors.Tertiary,
                        Size = UDim2.new(0, 32, 0, 16)
                    }, Config.Animations.Duration):Play()
                    CreateTween(ToggleIndicator, {
                        Position = UDim2.new(0, 2, 0.5, -6),
                        BackgroundColor3 = Config.Colors.TextMuted,
                        Size = UDim2.new(0, 12, 0, 12)
                    }, Config.Animations.Duration):Play()
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
            CreateDynamicGlow(SliderFrame, Config.Colors.Accent)
            
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
            
            -- Enhanced slider fill with gradient
            local fillGradient = Instance.new("UIGradient")
            fillGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Config.Colors.Accent),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
            })
            fillGradient.Parent = SliderFill
            
            local SliderHandle = Instance.new("TextButton")
            SliderHandle.Name = "Handle"
            SliderHandle.Size = UDim2.new(0, 12, 0, 12)
            SliderHandle.Position = UDim2.new(0, -6, 0.5, -6)
            SliderHandle.BackgroundColor3 = Config.Colors.Accent
            SliderHandle.BorderSizePixel = 0
            SliderHandle.Text = ""
            SliderHandle.Parent = SliderTrack
            
            CreateCorner(SliderHandle, 6)
            CreateDynamicGlow(SliderHandle, Config.Colors.Accent)
            
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
                
                CreateTween(SliderFill, {Size = UDim2.new(percentage, 0, 1, 0)}, Config.Animations.FastDuration):Play()
                CreateTween(SliderHandle, {
                    Position = UDim2.new(percentage, -6, 0.5, -6),
                    Size = UDim2.new(0, 14, 0, 14)
                }, Config.Animations.FastDuration):Play()
                
                -- Animate value change
                CreateTween(ValueLabel, {TextSize = 16}, 0.1):Play()
                wait(0.1)
                CreateTween(ValueLabel, {TextSize = 14}, 0.1):Play()
                
                ValueLabel.Text = tostring(currentValue)
                
                if options.Callback then
                    options.Callback(currentValue)
                end
            end
            
            local dragging = false
            
            SliderHandle.MouseButton1Down:Connect(function()
                dragging = true
                CreateTween(SliderHandle, {Size = UDim2.new(0, 16, 0, 16)}, Config.Animations.FastDuration):Play()
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                    CreateTween(SliderHandle, {Size = UDim2.new(0, 12, 0, 12)}, Config.Animations.Duration):Play()
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
            CreateDynamicGlow(TextboxFrame, Config.Colors.Accent)
            
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
                CreateStroke(TextboxFrame, Config.Colors.Accent, 2)
                CreateTween(TextboxFrame, {
                    BackgroundColor3 = Config.Colors.Tertiary,
                    Size = UDim2.new(1, 0, 0, 38)
                }, Config.Animations.FastDuration):Play()
                CreateTween(Textbox, {TextSize = 15}, Config.Animations.FastDuration):Play()
            end)
            
            Textbox.FocusLost:Connect(function(enterPressed)
                CreateStroke(TextboxFrame, Config.Colors.Border, 1)
                CreateTween(TextboxFrame, {
                    BackgroundColor3 = Config.Colors.Background,
                    Size = UDim2.new(1, 0, 0, 36)
                }, Config.Animations.Duration):Play()
                CreateTween(Textbox, {TextSize = 14}, Config.Animations.Duration):Play()
                
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
            
            -- Subtle glow effect for important labels
            if options.Important then
                Label.TextStrokeTransparency = 0.9
                Label.TextStrokeColor3 = Config.Colors.Accent
                Label.TextColor3 = Config.Colors.Text
            end
            
            return {
                Set = function(text)
                    Label.Text = text
                    -- Animate text change
                    CreateTween(Label, {TextSize = 16}, 0.1):Play()
                    wait(0.1)
                    CreateTween(Label, {TextSize = 14}, 0.1):Play()
                end
            }
        end
        
        -- Additional enhanced elements
        function Tab:CreateDropdown(options)
            options = options or {}
            
            local DropdownFrame = Instance.new("Frame")
            DropdownFrame.Name = "DropdownFrame"
            DropdownFrame.Size = UDim2.new(1, 0, 0, 36)
            DropdownFrame.BackgroundColor3 = Config.Colors.Background
            DropdownFrame.BorderSizePixel = 0
            DropdownFrame.Parent = TabContent
            
            CreateCorner(DropdownFrame, 4)
            CreateStroke(DropdownFrame, Config.Colors.Border, 1)
            CreateDynamicGlow(DropdownFrame, Config.Colors.Accent)
            
            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Name = "DropdownButton"
            DropdownButton.Size = UDim2.new(1, -24, 1, 0)
            DropdownButton.Position = UDim2.new(0, 12, 0, 0)
            DropdownButton.BackgroundTransparency = 1
            DropdownButton.Text = options.Default or options.Options[1] or "Select..."
            DropdownButton.TextColor3 = Config.Colors.Text
            DropdownButton.TextSize = 14
            DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
            DropdownButton.Font = Enum.Font.Gotham
            DropdownButton.Parent = DropdownFrame
            
            local DropdownArrow = Instance.new("TextLabel")
            DropdownArrow.Name = "Arrow"
            DropdownArrow.Size = UDim2.new(0, 20, 1, 0)
            DropdownArrow.Position = UDim2.new(1, -32, 0, 0)
            DropdownArrow.BackgroundTransparency = 1
            DropdownArrow.Text = "▼"
            DropdownArrow.TextColor3 = Config.Colors.TextSecondary
            DropdownArrow.TextSize = 12
            DropdownArrow.TextXAlignment = Enum.TextXAlignment.Center
            DropdownArrow.Font = Enum.Font.Gotham
            DropdownArrow.Parent = DropdownFrame
            
            local isOpen = false
            local DropdownList = Instance.new("Frame")
            DropdownList.Name = "DropdownList"
            DropdownList.Size = UDim2.new(1, 0, 0, 0)
            DropdownList.Position = UDim2.new(0, 0, 1, 2)
            DropdownList.BackgroundColor3 = Config.Colors.Secondary
            DropdownList.BorderSizePixel = 0
            DropdownList.Visible = false
            DropdownList.ZIndex = 10
            DropdownList.Parent = DropdownFrame
            
            CreateCorner(DropdownList, 4)
            CreateStroke(DropdownList, Config.Colors.Border, 1)
            
            local ListLayout = Instance.new("UIListLayout")
            ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ListLayout.Parent = DropdownList
            
            local function ToggleDropdown()
                isOpen = not isOpen
                if isOpen then
                    DropdownList.Visible = true
                    CreateTween(DropdownList, {
                        Size = UDim2.new(1, 0, 0, math.min(#options.Options * 30, 120))
                    }, Config.Animations.SlowDuration, Enum.EasingStyle.Back):Play()
                    CreateTween(DropdownArrow, {
                        Rotation = 180,
                        TextColor3 = Config.Colors.Accent
                    }, Config.Animations.Duration):Play()
                else
                    CreateTween(DropdownList, {
                        Size = UDim2.new(1, 0, 0, 0)
                    }, Config.Animations.Duration):Play()
                    CreateTween(DropdownArrow, {
                        Rotation = 0,
                        TextColor3 = Config.Colors.TextSecondary
                    }, Config.Animations.Duration):Play()
                    
                    wait(Config.Animations.Duration)
                    DropdownList.Visible = false
                end
            end
            
            DropdownButton.MouseButton1Click:Connect(ToggleDropdown)
            
            -- Create options
            for i, option in pairs(options.Options or {}) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Name = "Option_" .. i
                OptionButton.Size = UDim2.new(1, 0, 0, 30)
                OptionButton.BackgroundColor3 = Config.Colors.Secondary
                OptionButton.BorderSizePixel = 0
                OptionButton.Text = option
                OptionButton.TextColor3 = Config.Colors.TextSecondary
                OptionButton.TextSize = 14
                OptionButton.TextXAlignment = Enum.TextXAlignment.Left
                OptionButton.Font = Enum.Font.Gotham
                OptionButton.Parent = DropdownList
                
                local OptionPadding = Instance.new("UIPadding")
                OptionPadding.PaddingLeft = UDim.new(0, 12)
                OptionPadding.Parent = OptionButton
                
                OptionButton.MouseEnter:Connect(function()
                    CreateTween(OptionButton, {
                        BackgroundColor3 = Config.Colors.Tertiary,
                        TextColor3 = Config.Colors.Text
                    }, Config.Animations.FastDuration):Play()
                end)
                
                OptionButton.MouseLeave:Connect(function()
                    CreateTween(OptionButton, {
                        BackgroundColor3 = Config.Colors.Secondary,
                        TextColor3 = Config.Colors.TextSecondary
                    }, Config.Animations.FastDuration):Play()
                end)
                
                OptionButton.MouseButton1Click:Connect(function()
                    DropdownButton.Text = option
                    ToggleDropdown()
                    
                    if options.Callback then
                        options.Callback(option)
                    end
                end)
            end
            
            return {
                Set = function(value)
                    DropdownButton.Text = value
                end
            }
        end
        
        Window.Tabs[#Window.Tabs + 1] = Tab
        return Tab
    end
    
    -- Enhanced smooth window animation with bouncy effect
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.BackgroundTransparency = 1
    
    local openTween = CreateTween(MainFrame, {
        Size = Config.WindowSize,
        BackgroundTransparency = 0
    }, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    openTween:Play()
    
    -- Add floating animation
    spawn(function()
        while MainFrame.Parent do
            CreateTween(MainFrame, {
                Position = UDim2.new(0.5, math.random(-2, 2), 0.5, math.random(-1, 1))
            }, 3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut):Play()
            wait(3)
        end
    end)
    
    return Window
end

return API1508ner(Button, 4)
            CreateStroke(Button, Config.Colors.Border, 1)
            CreateDynamicGlow(Button, Config.Colors.Accent)
            
            local ButtonPadding = Instance.new("UIPadding")
            ButtonPadding.PaddingLeft = UDim.new(0, 12)
            ButtonPadding.PaddingRight = UDim.new(0, 12)
            ButtonPadding.Parent = Button
            
            Button.MouseEnter:Connect(function()
                CreateTween(Button, {
                    BackgroundColor3 = Config.Colors.Tertiary,
                    Size = UDim2.new(1, 0, 0, 38),
                    TextSize = 15
                }, Config.Animations.FastDuration):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                CreateTween(Button, {
                    BackgroundColor3 = Config.Colors.Background,
                    Size = UDim2.new(1, 0, 0, 36),
                    TextSize = 14
                }, Config.Animations.Duration):Play()
            end)
            
            Button.MouseButton1Click:Connect(function()
                CreateTween(Button, {Size = UDim2.new(1, 0, 0, 34)}, 0.05):Play()
                wait(0.05)
                CreateTween(Button, {Size = UDim2.new(1, 0, 0, 38)}, 0.1):Play()
                
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
            CreateDynamicGlow(ToggleFrame, Config.Colors.Accent)
            
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
            
            CreateCor
