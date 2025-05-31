-- 1508 API Enhanced - Ultra Modern UI with Glow Effects
-- Version 2.1.0 - Avec effets visuels avancés

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

-- Configuration avec effets Glow
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
        Accent = Color3.fromRGB(0, 150, 255),      -- Bleu électrique
        AccentHover = Color3.fromRGB(50, 170, 255),
        Glow = Color3.fromRGB(0, 100, 200),       -- Couleur glow
        Success = Color3.fromRGB(0, 255, 100),
        Warning = Color3.fromRGB(255, 150, 0),
        Error = Color3.fromRGB(255, 50, 50),
    },
    Animations = {
        Duration = 0.2,
        GlowDuration = 0.3,
        EasingStyle = Enum.EasingStyle.Quad,
        EasingDirection = Enum.EasingDirection.Out
    },
    Spacing = { Small = 8, Medium = 16, Large = 24 },
    Glow = {
        Enabled = true,
        Intensity = 0.8,
        Size = 20,
        Transparency = 0.7
    }
}

-- Fonction pour créer un effet Glow
local function CreateGlow(parent, color, size)
    if not Config.Glow.Enabled then return end
    
    local glow = Instance.new("ImageLabel")
    glow.Name = "GlowEffect"
    glow.Size = UDim2.new(1, size*2, 1, size*2)
    glow.Position = UDim2.new(0, -size, 0, -size)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxasset://textures/ui/Glow.png"
    glow.ImageColor3 = color or Config.Colors.Glow
    glow.ImageTransparency = Config.Glow.Transparency
    glow.ScaleType = Enum.ScaleType.Slice
    glow.SliceCenter = Rect.new(10, 10, 118, 118)
    glow.ZIndex = parent.ZIndex - 1
    glow.Parent = parent
    
    return glow
end

-- Fonction pour animer le glow
local function AnimateGlow(glow, intensity)
    if not glow then return end
    
    local pulse = TweenService:Create(glow, 
        TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {ImageTransparency = Config.Glow.Transparency + (intensity or 0.2)}
    )
    pulse:Play()
    return pulse
end

-- Utilitaires optimisés
local function CreateTween(object, properties, duration)
    return TweenService:Create(object, TweenInfo.new(
        duration or Config.Animations.Duration,
        Config.Animations.EasingStyle,
        Config.Animations.EasingDirection
    ), properties)
end

local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 6)
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

-- Fonction principale
function API1508:CreateWindow(options)
    options = options or {}
    
    local Window = {
        Title = options.Title or "Enhanced UI",
        Subtitle = options.Subtitle or "",
        ConfigurationSaving = options.ConfigurationSaving or false,
        FileName = options.FileName or "EnhancedConfig",
        KeybindTitle = options.KeybindTitle or "Enhanced UI",
        Tabs = {},
        CurrentTab = nil
    }
    
    -- ScreenGui principal
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "EnhancedUI_" .. math.random(1000, 9999)
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Frame principal avec glow
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
    CreateStroke(MainFrame, Config.Colors.Accent, 1)
    local mainGlow = CreateGlow(MainFrame, Config.Colors.Glow, Config.Glow.Size)
    AnimateGlow(mainGlow, 0.1)
    
    -- Barre du haut avec gradient
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.Position = UDim2.new(0, 0, 0, 0)
    TopBar.BackgroundColor3 = Config.Colors.Secondary
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    CreateCorner(TopBar, 12)
    
    -- Gradient pour la barre
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Config.Colors.Secondary),
        ColorSequenceKeypoint.new(1, Config.Colors.Tertiary)
    }
    gradient.Rotation = 45
    gradient.Parent = TopBar
    
    -- Masque pour les coins
    local TopBarMask = Instance.new("Frame")
    TopBarMask.Size = UDim2.new(1, 0, 0.5, 0)
    TopBarMask.Position = UDim2.new(0, 0, 0.5, 0)
    TopBarMask.BackgroundColor3 = Config.Colors.Secondary
    TopBarMask.BorderSizePixel = 0
    TopBarMask.Parent = TopBar
    
    -- Titre avec effet
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(1, -60, 1, 0)
    TitleLabel.Position = UDim2.new(0, Config.Spacing.Medium, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = Window.Title
    TitleLabel.TextColor3 = Config.Colors.Text
    TitleLabel.TextSize = 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Parent = TopBar
    
    -- Effet de stroke sur le texte
    local titleStroke = Instance.new("UIStroke")
    titleStroke.Color = Config.Colors.Accent
    titleStroke.Thickness = 0.5
    titleStroke.Transparency = 0.8
    titleStroke.Parent = TitleLabel
    
    -- Bouton fermer stylisé
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 32, 0, 32)
    CloseButton.Position = UDim2.new(1, -42, 0.5, -16)
    CloseButton.BackgroundColor3 = Config.Colors.Error
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Config.Colors.Text
    CloseButton.TextSize = 16
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TopBar
    
    CreateCorner(CloseButton, 8)
    local closeGlow = CreateGlow(CloseButton, Config.Colors.Error, 8)
    
    CloseButton.MouseEnter:Connect(function()
        CreateTween(CloseButton, {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play()
        CreateTween(CloseButton, {Size = UDim2.new(0, 36, 0, 36)}):Play()
        AnimateGlow(closeGlow, 0.3)
    end)
    
    CloseButton.MouseLeave:Connect(function()
        CreateTween(CloseButton, {BackgroundColor3 = Config.Colors.Error}):Play()
        CreateTween(CloseButton, {Size = UDim2.new(0, 32, 0, 32)}):Play()
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        local closeTween = CreateTween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
        closeTween:Play()
        closeTween.Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end)
    
    -- Container des onglets
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 140, 1, -60)
    TabContainer.Position = UDim2.new(0, 8, 0, 58)
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainFrame
    
    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 6)
    TabList.Parent = TabContainer
    
    -- Container du contenu
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -160, 1, -68)
    ContentContainer.Position = UDim2.new(0, 156, 0, 58)
    ContentContainer.BackgroundColor3 = Config.Colors.Secondary
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = MainFrame
    
    CreateCorner(ContentContainer, 8)
    CreateStroke(ContentContainer, Config.Colors.Border, 1)
    
    -- Fonctions des onglets
    function Window:CreateTab(options)
        options = options or {}
        
        local Tab = {
            Name = options.Name or "Tab",
            Icon = options.Icon or "★",
            Elements = {}
        }
        
        -- Bouton d'onglet avec effets
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "TabButton_" .. Tab.Name
        TabButton.Size = UDim2.new(1, 0, 0, 38)
        TabButton.BackgroundColor3 = Config.Colors.Tertiary
        TabButton.BorderSizePixel = 0
        TabButton.Text = Tab.Icon .. " " .. Tab.Name
        TabButton.TextColor3 = Config.Colors.TextSecondary
        TabButton.TextSize = 14
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.Font = Enum.Font.GothamMedium
        TabButton.Parent = TabContainer
        
        CreateCorner(TabButton, 6)
        local tabGlow = CreateGlow(TabButton, Config.Colors.Accent, 6)
        
        local TabPadding = Instance.new("UIPadding")
        TabPadding.PaddingLeft = UDim.new(0, 14)
        TabPadding.Parent = TabButton
        
        -- Contenu de l'onglet
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = "TabContent_" .. Tab.Name
        TabContent.Size = UDim2.new(1, -16, 1, -16)
        TabContent.Position = UDim2.new(0, 8, 0, 8)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 3
        TabContent.ScrollBarImageColor3 = Config.Colors.Accent
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.Visible = false
        TabContent.Parent = ContentContainer
        
        local ContentList = Instance.new("UIListLayout")
        ContentList.SortOrder = Enum.SortOrder.LayoutOrder
        ContentList.Padding = UDim.new(0, Config.Spacing.Small)
        ContentList.Parent = TabContent
        
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 16)
        end)
        
        -- Logique de sélection d'onglet
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
            CreateTween(TabButton, {TextColor3 = Config.Colors.Text}):Play()
            TabContent.Visible = true
            Window.CurrentTab = Tab
            AnimateGlow(tabGlow, 0.4)
        end
        
        TabButton.MouseButton1Click:Connect(SelectTab)
        
        TabButton.MouseEnter:Connect(function()
            if Window.CurrentTab ~= Tab then
                CreateTween(TabButton, {BackgroundColor3 = Config.Colors.Border}):Play()
                CreateTween(TabButton, {Size = UDim2.new(1, 4, 0, 40)}):Play()
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if Window.CurrentTab ~= Tab then
                CreateTween(TabButton, {BackgroundColor3 = Config.Colors.Tertiary}):Play()
                CreateTween(TabButton, {Size = UDim2.new(1, 0, 0, 38)}):Play()
            end
        end)
        
        if #Window.Tabs == 0 then SelectTab() end
        
        -- Fonction pour créer un bouton
        function Tab:CreateButton(options)
            options = options or {}
            
            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Size = UDim2.new(1, 0, 0, 40)
            Button.BackgroundColor3 = Config.Colors.Background
            Button.BorderSizePixel = 0
            Button.Text = options.Text or "Button"
            Button.TextColor3 = Config.Colors.Text
            Button.TextSize = 14
            Button.Font = Enum.Font.GothamMedium
            Button.Parent = TabContent
            
            CreateCorner(Button, 6)
            CreateStroke(Button, Config.Colors.Border, 1)
            local buttonGlow = CreateGlow(Button, Config.Colors.Success, 8)
            
            local ButtonPadding = Instance.new("UIPadding")
            ButtonPadding.PaddingLeft = UDim.new(0, 12)
            ButtonPadding.PaddingRight = UDim.new(0, 12)
            ButtonPadding.Parent = Button
            
            Button.MouseEnter:Connect(function()
                CreateTween(Button, {BackgroundColor3 = Config.Colors.Success}):Play()
                CreateTween(Button, {TextColor3 = Config.Colors.Background}):Play()
                AnimateGlow(buttonGlow, 0.3)
            end)
            
            Button.MouseLeave:Connect(function()
                CreateTween(Button, {BackgroundColor3 = Config.Colors.Background}):Play()
                CreateTween(Button, {TextColor3 = Config.Colors.Text}):Play()
            end)
            
            Button.MouseButton1Click:Connect(function()
                CreateTween(Button, {Size = UDim2.new(1, -4, 0, 36)}):Play()
                wait(0.1)
                CreateTween(Button, {Size = UDim2.new(1, 0, 0, 40)}):Play()
                if options.Callback then options.Callback() end
            end)
            
            return Button
        end
        
        -- Fonction pour créer un toggle
        function Tab:CreateToggle(options)
            options = options or {}
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
            ToggleFrame.BackgroundColor3 = Config.Colors.Background
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = TabContent
            
            CreateCorner(ToggleFrame, 6)
            CreateStroke(ToggleFrame, Config.Colors.Border, 1)
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Name = "Label"
            ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
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
            ToggleButton.Size = UDim2.new(0, 40, 0, 20)
            ToggleButton.Position = UDim2.new(1, -48, 0.5, -10)
            ToggleButton.BackgroundColor3 = Config.Colors.Tertiary
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = ""
            ToggleButton.Parent = ToggleFrame
            
            CreateCorner(ToggleButton, 10)
            local toggleGlow = CreateGlow(ToggleButton, Config.Colors.Success, 6)
            
            local ToggleIndicator = Instance.new("Frame")
            ToggleIndicator.Name = "Indicator"
            ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
            ToggleIndicator.Position = UDim2.new(0, 2, 0.5, -8)
            ToggleIndicator.BackgroundColor3 = Config.Colors.TextMuted
            ToggleIndicator.BorderSizePixel = 0
            ToggleIndicator.Parent = ToggleButton
            
            CreateCorner(ToggleIndicator, 8)
            local indicatorGlow = CreateGlow(ToggleIndicator, Config.Colors.Success, 4)
            
            local isToggled = options.Default or false
            
            local function UpdateToggle()
                if isToggled then
                    CreateTween(ToggleButton, {BackgroundColor3 = Config.Colors.Success}):Play()
                    CreateTween(ToggleIndicator, {
                        Position = UDim2.new(1, -18, 0.5, -8),
                        BackgroundColor3 = Config.Colors.Text
                    }):Play()
                    AnimateGlow(toggleGlow, 0.4)
                    AnimateGlow(indicatorGlow, 0.3)
                else
                    CreateTween(ToggleButton, {BackgroundColor3 = Config.Colors.Tertiary}):Play()
                    CreateTween(ToggleIndicator, {
                        Position = UDim2.new(0, 2, 0.5, -8),
                        BackgroundColor3 = Config.Colors.TextMuted
                    }):Play()
                end
                
                if options.Callback then options.Callback(isToggled) end
            end
            
            ToggleButton.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                UpdateToggle()
            end)
            
            UpdateToggle()
            
            return { Set = function(value) isToggled = value; UpdateToggle() end }
        end
        
        -- Autres fonctions (Slider, Textbox, Label) similaires avec glow...
        -- [Code raccourci pour la taille - les autres fonctions suivent le même pattern avec des effets glow]
        
        Window.Tabs[#Window.Tabs + 1] = Tab
        return Tab
    end
    
    -- Animation d'ouverture
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    local openTween = CreateTween(MainFrame, {Size = Config.WindowSize}, 0.4)
    openTween:Play()
    
    return Window
end

return API1508
