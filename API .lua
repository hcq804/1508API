-- 1508 API V1
-- ALL RIGHT RESERVED

_G.Main = {}

function _G.Main:New(Title)

	-- Instances:
	local ScreenGui = Instance.new("ScreenGui")
	local FramMaine = Instance.new("Frame")
	local MainUICorner = Instance.new("UICorner")
	local MainImageLabel = Instance.new("ImageLabel")
	local TitleLabel = Instance.new("TextLabel")
	local _1508Label = Instance.new("TextLabel")

	--Properties:
	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	FramMaine.Name = "FramMaine"
	FramMaine.Parent = ScreenGui
	FramMaine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	FramMaine.BackgroundTransparency = 1.000
	FramMaine.BorderColor3 = Color3.fromRGB(0, 0, 0)
	FramMaine.BorderSizePixel = 0
	FramMaine.Position = UDim2.new(0.285990953, 0, 0.278290987, 0)
	FramMaine.Size = UDim2.new(0, 663, 0, 383)

	MainUICorner.Name = "MainUICorner"
	MainUICorner.Parent = FramMaine

	MainImageLabel.Name = "MainImageLabel"
	MainImageLabel.Parent = FramMaine
	MainImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MainImageLabel.BackgroundTransparency = 1.000
	MainImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MainImageLabel.BorderSizePixel = 0
	MainImageLabel.Position = UDim2.new(-0.0108146379, 0, -0.43338117, 0)
	MainImageLabel.Size = UDim2.new(0, 676, 0, 676)
	MainImageLabel.Image = "http://www.roblox.com/asset/?id=115266099717402"

	TitleLabel.Name = "TitleLabel"
	TitleLabel.Parent = MainImageLabel
	TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.BackgroundTransparency = 1.000
	TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TitleLabel.BorderSizePixel = 0
	TitleLabel.Position = UDim2.new(0.017896574, 0, 0.255133092, 0)
	TitleLabel.Size = UDim2.new(0, 239, 0, 30)
	TitleLabel.Font = Enum.Font.Code
	TitleLabel.Text = Title
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextScaled = true
	TitleLabel.TextSize = 14.000
	TitleLabel.TextWrapped = true

	_1508Label.Name = "1508Label"
	_1508Label.Parent = MainImageLabel
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

	-- Scripts:
	local function VHLIJT_fake_script() -- FramMaine.DragScript 
		-- LocalScript dans le Frame à rendre déplaçable
		local UIS = game:GetService("UserInputService")
		local RunService = game:GetService("RunService")

		local frame = FramMaine
		frame.Active = true

		local dragging = false
		local dragStart
		local startPos

		local targetPosition
		local smoothSpeed = 0.2 -- Plus c'est bas, plus le mouvement est fluide/lent

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
	VHLIJT_fake_script()

	_G.Frame = {}
	
	-- Keep track of button count for positioning
	local buttonCount = 0
	
	function _G.Frame:Button(Name, Call)

		local ButtonFrame = Instance.new("Frame")
		local ButtonTesxtB = Instance.new("TextButton")
		local ButtonUICorner = Instance.new("UICorner")
		local ButtonImage = Instance.new("ImageLabel")
		local ButtonLabel = Instance.new("TextLabel")
		
		-- Calculate position based on button count
		local yOffset = 0.396449715 + (buttonCount * 0.1) -- Adjust spacing as needed
		
		ButtonFrame.Name = "ButtonFrame"
		ButtonFrame.Parent = MainImageLabel
		ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonFrame.BackgroundTransparency = 1.000
		ButtonFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ButtonFrame.BorderSizePixel = 0
		ButtonFrame.Position = UDim2.new(0.0384614468, 0, yOffset, 0)
		ButtonFrame.Size = UDim2.new(0, 216, 0, 49)

		ButtonTesxtB.Name = "ButtonTesxtB"
		ButtonTesxtB.Parent = ButtonFrame
		ButtonTesxtB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonTesxtB.BackgroundTransparency = 0.500
		ButtonTesxtB.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ButtonTesxtB.BorderSizePixel = 0
		ButtonTesxtB.Position = UDim2.new(0.0372113846, 0, 0.12799944, 0)
		ButtonTesxtB.Size = UDim2.new(0, 217, 0, 50)
		ButtonTesxtB.Font = Enum.Font.SourceSans
		ButtonTesxtB.TextColor3 = Color3.fromRGB(0, 0, 0)
		ButtonTesxtB.TextSize = 14.000
		ButtonTesxtB.Text = "" -- Clear default text since we use a label

		ButtonUICorner.CornerRadius = UDim.new(1, 0)
		ButtonUICorner.Name = "ButtonUICorner"
		ButtonUICorner.Parent = ButtonTesxtB

		ButtonImage.Name = "ButtonImage"
		ButtonImage.Parent = ButtonTesxtB
		ButtonImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonImage.BackgroundTransparency = 1.000
		ButtonImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ButtonImage.BorderSizePixel = 0
		ButtonImage.Position = UDim2.new(-0.0536470897, 0, -1.93138731, 0)
		ButtonImage.Size = UDim2.new(0, 239, 0, 239)
		ButtonImage.Image = "http://www.roblox.com/asset/?id=110845549464980"
		
		ButtonLabel.Name = "ButtonLabel"
		ButtonLabel.Parent = ButtonImage
		ButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonLabel.BackgroundTransparency = 1.000
		ButtonLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ButtonLabel.BorderSizePixel = 0
		ButtonLabel.Position = UDim2.new(0.0932103842, 0, 0.429160535, 0)
		ButtonLabel.Size = UDim2.new(0, 192, 0, 32)
		ButtonLabel.Font = Enum.Font.Code
		ButtonLabel.Text = Name
		ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ButtonLabel.TextScaled = true
		ButtonLabel.TextSize = 14.000
		ButtonLabel.TextWrapped = true

		-- FIXED: Connect to the correct button instance
		ButtonTesxtB.MouseButton1Click:Connect(function()
			pcall(Call)
		end)
		
		-- Increment button count for next button positioning
		buttonCount = buttonCount + 1

	end

	return _G.Frame

end

