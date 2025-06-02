--1508 api

--all rights reserved

--educational purposes only

--credit us if you are opening our script for anything for your own purposes or to publish it

_G.Window = {}
function _G.Window:New(Title)

	-- Local button count for this specific window
	local buttonCount = 0

	-- Base Window

	local ScreenGui = Instance.new("ScreenGui")
	local MainFrame = Instance.new("Frame")
	local MainUICorner = Instance.new("UICorner")
	local DragZoneFrame = Instance.new("Frame")
	local MainImageLabel = Instance.new("ImageLabel")
	local CloseFrame = Instance.new("Frame")
	local CloseButtonTxt = Instance.new("TextButton")
	local CloseUICorner = Instance.new("UICorner")
	local CloseImage = Instance.new("ImageLabel")
	local _1508Label = Instance.new("TextLabel")
	local TitleLabel = Instance.new("TextLabel")

	--Properties:

	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	DragZoneFrame.Name = "DragZoneFrame"
	DragZoneFrame.Parent = MainFrame
	DragZoneFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	DragZoneFrame.BackgroundTransparency = 1.000
	DragZoneFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DragZoneFrame.BorderSizePixel = 0
	DragZoneFrame.Size = UDim2.new(0, 664, 0, 384)

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

	MainFrame.Name = "MainFrame"
	MainFrame.Parent = ScreenGui
	MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MainFrame.BackgroundTransparency = 1.000
	MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MainFrame.BorderSizePixel = 0
	MainFrame.Position = UDim2.new(0.285990953, 0, 0.278290987, 0)
	MainFrame.Size = UDim2.new(0, 663, 0, 383)

	MainUICorner.Name = "MainUICorner"
	MainUICorner.Parent = MainFrame

	MainImageLabel.Name = "MainImageLabel"
	MainImageLabel.Parent = DragZoneFrame
	MainImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MainImageLabel.BackgroundTransparency = 1.000
	MainImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MainImageLabel.BorderSizePixel = 0
	MainImageLabel.Position = UDim2.new(-0.0108146379, 0, -0.43338117, 0)
	MainImageLabel.Size = UDim2.new(0, 676, 0, 676)
	MainImageLabel.Image = "http://www.roblox.com/asset/?id=115266099717402"

	CloseFrame.Name = "CloseFrame"
	CloseFrame.Parent = MainImageLabel
	CloseFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CloseFrame.BackgroundTransparency = 1.000
	CloseFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	CloseFrame.BorderSizePixel = 0
	CloseFrame.Position = UDim2.new(0.938855886, 0, 0.272183657, 0)
	CloseFrame.Size = UDim2.new(0, 28, 0, 31)

	CloseButtonTxt.Name = "CloseButtonTxt"
	CloseButtonTxt.Parent = CloseFrame
	CloseButtonTxt.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CloseButtonTxt.BackgroundTransparency = 1.000
	CloseButtonTxt.BorderColor3 = Color3.fromRGB(0, 0, 0)
	CloseButtonTxt.BorderSizePixel = 0
	CloseButtonTxt.Position = UDim2.new(-0.500013053, 0, -0.369752944, 0)
	CloseButtonTxt.Size = UDim2.new(0, 35, 0, 34)
	CloseButtonTxt.Font = Enum.Font.SourceSans
	CloseButtonTxt.TextColor3 = Color3.fromRGB(0, 0, 0)
	CloseButtonTxt.TextSize = 0.0000000000000000000000000000000000000000000000000000000000000001

	CloseUICorner.CornerRadius = UDim.new(1, 0)
	CloseUICorner.Name = "CloseUICorner"
	CloseUICorner.Parent = CloseButtonTxt

	CloseImage.Name = "CloseImage"
	CloseImage.Parent = CloseButtonTxt
	CloseImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CloseImage.BackgroundTransparency = 1.000
	CloseImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	CloseImage.BorderSizePixel = 0
	CloseImage.Position = UDim2.new(0.0861746669, 0, 0.0273742676, 0)
	CloseImage.Size = UDim2.new(0, 31, 0, 31)
	CloseImage.Image = "http://www.roblox.com/asset/?id=98563743970946"
	CloseImage.ImageColor3 = Color3.fromRGB(255, 255, 255)

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

	local function IIHJXR_fake_script() -- DragZoneFrame.DragScript 
		local script = Instance.new('LocalScript', DragZoneFrame)

		-- LocalScript in the Frame to make it draggable
		local UIS = game:GetService("UserInputService")
		local RunService = game:GetService("RunService")

		local frame = script.Parent
		frame.Active = true

		local dragging = false
		local dragStart
		local startPos

		local targetPosition
		local smoothSpeed = 0.0001

		local function update(input)
			local delta = input.Position - dragStart
			targetPosition = startPos + UDim2.new(0, delta.X, 0, delta.Y)
		end

		RunService.RenderStepped:Connect(function()
			if targetPosition then
				frame.Position = frame.Position:Lerp(targetPosition, smoothSpeed)
			end
		end)

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

		UIS.InputChanged:Connect(function(input)
			if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
				update(input)
			end
		end)

	end
	coroutine.wrap(IIHJXR_fake_script)()

	local function VTXYJ_fake_script() -- CloseButtonTxt.CloseScript 
		local script = Instance.new('LocalScript', CloseButtonTxt)

		--CloseFrame

		local button = script.Parent -- The button that is clicked
		local screenGui = button:FindFirstAncestorOfClass("ScreenGui") -- Find the parent ScreenGui

		button.MouseButton1Click:Connect(function()
			if screenGui then
				screenGui:Destroy()
			end
		end)

	end
	coroutine.wrap(VTXYJ_fake_script)()

	local Button = {}
	function Button:Button(Name, Call)

		-- Calculate position based on button count for this window
		local yOffset = 0.396449715 + (buttonCount * 0.1) -- Adjust spacing between buttons

		local ButtonFrame = Instance.new("Frame")
		local ButtonButtonTxt = Instance.new("TextButton")
		local ButtonUICorner = Instance.new("UICorner")
		local ButtonImage = Instance.new("ImageLabel")
		local ButtonLabel = Instance.new("TextLabel")

		ButtonFrame.Name = "ButtonFrame"
		ButtonFrame.Parent = MainImageLabel
		ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonFrame.BackgroundTransparency = 1.000
		ButtonFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ButtonFrame.BorderSizePixel = 0
		-- FIXED: Now using the calculated yOffset instead of hardcoded value
		ButtonFrame.Position = UDim2.new(0.0340235792, 0, yOffset, 0)
		ButtonFrame.Size = UDim2.new(0, 216, 0, 49)

		ButtonButtonTxt.Name = "ButtonButtonTxt"
		ButtonButtonTxt.Parent = ButtonFrame
		ButtonButtonTxt.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonButtonTxt.BackgroundTransparency = 1.000
		ButtonButtonTxt.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ButtonButtonTxt.BorderSizePixel = 0
		ButtonButtonTxt.Size = UDim2.new(0, 200, 0, 50)
		ButtonButtonTxt.Font = Enum.Font.SourceSans
		ButtonButtonTxt.TextColor3 = Color3.fromRGB(0, 0, 0)
		ButtonButtonTxt.TextSize = 14.000

		ButtonUICorner.CornerRadius = UDim.new(1, 0)
		ButtonUICorner.Name = "ButtonUICorner"
		ButtonUICorner.Parent = ButtonButtonTxt

		ButtonImage.Name = "ButtonImage"
		ButtonImage.Parent = ButtonButtonTxt
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

		ButtonButtonTxt.MouseButton1Click:Connect(function()
			pcall(Call)
		end)

		buttonCount = buttonCount + 1

	end

	return Button

end
