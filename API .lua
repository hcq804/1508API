-- 1508 API V1
-- ALL RIGHT RESERVED








-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local ImageLabel = Instance.new("ImageLabel")
local TitleLabel = Instance.new("TextLabel")
local _1508Label = Instance.new("TextLabel")
local ButtonFrame = Instance.new("Frame")
local TextButton = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local ImageLabel_2 = Instance.new("ImageLabel")
local TitleLabel_2 = Instance.new("TextLabel")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 1.000
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.285990953, 0, 0.278290987, 0)
Frame.Size = UDim2.new(0, 663, 0, 383)

UICorner.Parent = Frame

ImageLabel.Parent = Frame
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BackgroundTransparency = 1.000
ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel.BorderSizePixel = 0
ImageLabel.Position = UDim2.new(-0.0108146379, 0, -0.43338117, 0)
ImageLabel.Size = UDim2.new(0, 676, 0, 676)
ImageLabel.Image = "http://www.roblox.com/asset/?id=115266099717402"

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = ImageLabel
TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.BackgroundTransparency = 1.000
TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.BorderSizePixel = 0
TitleLabel.Position = UDim2.new(0.017896574, 0, 0.255133092, 0)
TitleLabel.Size = UDim2.new(0, 239, 0, 30)
TitleLabel.Font = Enum.Font.Unknown
TitleLabel.Text = "The 1508 api is so cool wow"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextScaled = true
TitleLabel.TextSize = 14.000
TitleLabel.TextWrapped = true

_1508Label.Name = "1508Label"
_1508Label.Parent = ImageLabel
_1508Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_1508Label.BackgroundTransparency = 1.000
_1508Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
_1508Label.BorderSizePixel = 0
_1508Label.Position = UDim2.new(0.322630286, 0, 0.283239603, 0)
_1508Label.Size = UDim2.new(0, 239, 0, 11)
_1508Label.Font = Enum.Font.Code
_1508Label.Text = "powered by 1508 API"
_1508Label.TextColor3 = Color3.fromRGB(122, 122, 122)
_1508Label.TextScaled = true
_1508Label.TextSize = 14.000
_1508Label.TextWrapped = true

ButtonFrame.Name = "ButtonFrame"
ButtonFrame.Parent = ImageLabel
ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ButtonFrame.BackgroundTransparency = 1.000
ButtonFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
ButtonFrame.BorderSizePixel = 0
ButtonFrame.Position = UDim2.new(0.0384614468, 0, 0.396449715, 0)
ButtonFrame.Size = UDim2.new(0, 216, 0, 49)

TextButton.Parent = ButtonFrame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 0.500
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.0372113846, 0, 0.12799944, 0)
TextButton.Size = UDim2.new(0, 217, 0, 50)
TextButton.Font = Enum.Font.SourceSans
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextSize = 14.000

UICorner_2.CornerRadius = UDim.new(1, 0)
UICorner_2.Parent = TextButton

ImageLabel_2.Parent = TextButton
ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_2.BackgroundTransparency = 1.000
ImageLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_2.BorderSizePixel = 0
ImageLabel_2.Position = UDim2.new(-0.0536470897, 0, -1.93138731, 0)
ImageLabel_2.Size = UDim2.new(0, 239, 0, 239)
ImageLabel_2.Image = "http://www.roblox.com/asset/?id=110845549464980"

TitleLabel_2.Name = "TitleLabel"
TitleLabel_2.Parent = ImageLabel_2
TitleLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel_2.BackgroundTransparency = 1.000
TitleLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel_2.BorderSizePixel = 0
TitleLabel_2.Position = UDim2.new(0.0932103842, 0, 0.429160535, 0)
TitleLabel_2.Size = UDim2.new(0, 192, 0, 32)
TitleLabel_2.Font = Enum.Font.Unknown
TitleLabel_2.Text = "Buttons are wow"
TitleLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel_2.TextScaled = true
TitleLabel_2.TextSize = 14.000
TitleLabel_2.TextWrapped = true

-- Scripts:

local function QEXQ_fake_script() -- Frame.DragScript 
	local script = Instance.new('LocalScript', Frame)

	-- LocalScript dans le Frame à rendre déplaçable
	local UIS = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	
	local frame = script.Parent
	frame.Active = true
	
	local dragging = false
	local dragStart
	local startPos
	
	local targetPosition
	local smoothSpeed = 0.2 -- Plus c’est bas, plus le mouvement est fluide/lent
	
	-- Fonction appelée pendant le drag
	local function update(input)
		local delta = input.Position - dragStart
		targetPosition = startPos + UDim2.new(0, delta.X, 0, delta.Y)
	end
	
	-- Suivi du rendu (interpolation vers targetPosition)
	RunService.RenderStepped:Connect(function()
		if targetPosition then
			frame.Position = frame.Position:Lerp(targetPosition, smoothSpeed)
		end
	end)
	
	-- Début du drag
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	-- Suivi de la souris
	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			update(input)
		end
	end)
	
end
coroutine.wrap(QEXQ_fake_script)()
