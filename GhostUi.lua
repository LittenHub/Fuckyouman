local GhostUI = {
  Window = {}
}

if game.CoreGui:FindFirstChild("GhostUI") then
  game.CoreGui:FindFirstChild("GhostUI"):Destroy()
end

local ScreenGui1 = Instance.new("ScreenGui")
ScreenGui1.Parent = game.CoreGui
ScreenGui1.Name = "GhostUI"

local function GhostUI:MakeWindow(WindowConfig)
  WindowConfig = WindowConfig or {}
  WindowConfig.Title = WindowConfig.Title or "Title here!"
  
  local Frame1 = Instance.new("Frame")
  Frame1.Parent = ScreenGui1
  Frame1.Name = "MainFrame"
  Frame1.BackgroundColor3 = Color3.fromRGB(17,17,17)
  Frame1.Position = UDim2.new(0.3,0,0.05)
  Frame1.Size = UDim2.new(0,185,0,34,0)
  Frame1.Active = true
  Frame1.Draggable = true
  
  local UICorner1 = Instance.new("UICorner")
  UICorner1.Parent = Frame1
  UICorner1.CornerRadius = UDim.new(0.15,0)
  
  local TextLabel1 = Instance.new("TextLabel")
  TextLabel1.Parent = Frame1
  TextLabel1.Name = "Title"
  TextLabel1.BackgroundTransparency = 1
  TextLabel1.Position = UDim2.new(0,0,0)
  TextLabel1.Size = UDim2.new(1,0,1,0)
  TextLabel1.Font = Enum.Font.SourceSansBold
  TextLabel1.TextColor3 = Color3.fromRGB(248,248,248)
  TextLabel1.Text = WindowConfig.Title
  TextLabel1.TextSize = 18
  TextLabel1.TextScaled = false
  TextLabel1.TextWrapped = true
  
  local Frame2 = Instance.new("Frame")
  Frame2.Parent = Frame1
  Frame2.Name = "ContentsFrame"
  Frame2.BackgroundColor3 = Color3.fromRGB(33,33,33)
  Frame2.BorderSizePixel = 0
  Frame2.Position = UDim2.new(0,0,0.9)
  Frame2.Size = UDim2.new(1,0,0.1,0)
  Frame2.Visible = false
  
  local Frame2UICorner = UICorner1:Clone()
  Frame2UICorner.Parent = Frame2
  
  local TextButton1 = Instance.new("TextButton")
  TextButton1.Parent = Frame1
  TextButton1.Name = "Open"
  TextButton1.BackgroundTransparency = 1
  TextButton1.Position = UDim2.new(0.85,0,0.05)
  TextButton1.Size = UDim2.new(0.15,0,0.8,0)
  TextButton1.Font = Enum.Font.SourceSansBold
  TextButton1.TextColor3 = Color3.fromRGB(248,248,248)
  TextButton1.Text = "v"
  TextButton1.TextSize = 18
  TextButton1.TextScaled = true
  TextButton1.TextWrapped = false
  
  TextButton1.MouseButton1Click:Connect(function()
    if TextButton1.Text == "v" then
      TextButton1.Text = "â€“"
      Frame2.Visible = true
    else
      TextButton1.Text = "v"
      Frame2.Visible = false
    end
  end)
  
  local Frame = Instance.new("ScrollingFrame")
  Frame.Name = ""
  Frame.Parent = Frame2
  Frame.BackgroundColor3 = Color3.fromRGB(33,33,33)
  Frame.BorderSizePixel = 0
  Frame.ScrollBarSize = 1
  Frame.CanvasSize = UDim2.new(0,0,0,0)
  Frame.ScrollingDirection = Enum.ScrollingDirection.Y
  Frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
  Frame.AutomaticSize = Enum.AutomaticSize.Y
  Frame.Position = UDim2.new(0,0,1,0)
  Frame.Size = UDim2.new(1,0,11,0)
    
  local UICorner = Instance.new("UICorner")
  UICorner.Parent = Frame
  UICorner.CornerRadius = UDim.new(0.15,0)
  
  local scrollLayout = Instance.new("UIListLayout")
  scrollLayout.Padding = UDim.new(0,0)
  scrollLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
  
  local ContentPositionZ = 0
  local TargetPositionZ = 93
  
  function GhostUI.Window:AddContent(ContentConfig)
    ContentConfig = ContentConfig or {}
    ContentConfig.Type = ContentConfig.Type or ""
    ContentConfig.Text = ContentConfig.Text or "Text"
    ContentConfig.Callback = ContentConfig.Callback or function() end
    ContentConfig.Callback2 = ContentConfig.Callback2 or function() end
    
    local RETURN = nil
    
    if ContentConfig.Type == "TextLabel" then
      local TextLabel = Instance.new("TextLabel")
      TextLabel.Parent = Frame
      TextLabel.BackgroundTransparency = 1
      TextLabel.Position = UDim2.new(0.1,0,0.15)
      TextLabel.Size = UDim2.new(0.8,0,0.7,0)
      TextLabel.Font = Enum.Font.SourceSansBold
      TextLabel.TextColor3 = Color3.fromRGB(248,248,248)
      TextLabel.Text = ContentConfig.Text
      TextLabel.TextSize = 18
      TextLabel.TextScaled = false
      TextLabel.TextWrapped = true
      RETURN = TextLabel
    elseif ContentConfig.Type == "TextBox" then
      local TextBox = Instance.new("TextBox")
      TextBox.Parent = Frame
      TextBox.BackgroundTransparency = 0.25
      TextBox.Position = UDim2.new(0.1,0,0.15)
      TextBox.Size = UDim2.new(0.8,0,0.7,0)
      TextBox.Font = Enum.Font.SourceSansBold
      TextBox.TextColor3 = Color3.fromRGB(248,248,248)
      TextBox.PlaceholderText = ContentConfig.Text
      TextBox.Text = ""
      TextBox.TextSize = 18
      TextBox.TextScaled = false
      TextBox.TextWrapped = true
      
      local UICorner = Instance.new("UICorner")
      UICorner.Parent = TextButton
      UICorner.CornerRadius = UDim.new(0.15,0)
      
      TextBox.FocusLost:Connect(function()
        ContentConfig.Callback(TextBox.Text)
      end)
      
      RETURN = TextBox
    elseif ContentConfig.Type == "TextButton" then
      local TextButton = Instance.new("TextButton")
      TextButton.Parent = Frame
      TextButton.BackgroundTransparency = 0
      TextButton.Position = UDim2.new(0.1,0,0.15)
      TextButton.Size = UDim2.new(0.8,0,0.7,0)
      TextButton.Font = Enum.Font.SourceSansBold
      TextButton.TextColor3 = Color3.fromRGB(248,248,248)
      TextButton.Text = ContentConfig.Text
      TextButton.TextSize = 18
      TextButton.TextScaled = false
      TextButton.TextWrapped = true

      local UICorner = Instance.new("UICorner") 
      UICorner.Parent = TextButton
      UICorner.CornerRadius = UDim.new(0.15,0)

      TextButton.MouseButton1Click:Connect(function()
        local success, result = pcall(ContentConfig.Callback)
      
        if not success then
          print("Ghost UI | Callback error on button:" .. ContentConfig.Text .. ", Error: " .. tostring(result))
        end
      end)
    elseif ContentConfig.Type == "Toogle" then
      local TextLabel = Instance.new("TextLabel") 
      TextLabel.Parent = Frame
      TextLabel.BackgroundTransparency = 1
      TextLabel.Position = UDim2.new(0.1,0,0.15)
      TextLabel.Size = UDim2.new(0.7,0,0.7,0)
      TextLabel.Font = Enum.Font.SourceSansBold
      TextLabel.TextColor3 = Color3.fromRGB(248,248,248)
      TextLabel.TextXAlignment = Enum.TextXAlignment.Left
      TextLabel.Text = ContentConfig.Text
      TextLabel.TextSize = 18
      TextLabel.TextScaled = false
      TextLabel.TextWrapped = true

      local TextButton = Instance.new("TextButton") 
      TextButton.Parent = Frame
      TextButton.BackgroundTransparency = 1
      TextButton.Position = UDim2.new(0.805,0,0.15)
      TextButton.Size = UDim2.new(0.15,0,0.7,0)
      TextButton.Font = Enum.Font.SourceSansBold
      TextButton.TextColor3 = Color3.fromRGB(248,248,248)
      TextButton.Text = "â–¡"
      TextButton.TextSize = 24
      TextButton.TextScaled = false
      TextButton.TextWrapped = true
      
      local Toogle = false
      TextButton.MouseButton1Click:Connect(function()
        if TextButton.Text == "â–¡" then
          TextButton.Text = "â– "
          TextButton.TextSize = 22
          TextButton.Position = UDim2.new(0.8103,0,0.148)
          Toogle = true
        else
          TextButton.Text = "â–¡"
          TextButton.TextSize = 24
          TextButton.Position = UDim2.new(0.805,0,0.15)
          Toogle = false
        end
      end)
      local BetterLoopOperator = false
      game:GetService("RunService").RenderStepped:Connect(function()
        if Toogle == true and BetterLoopOperator == false then
          BetterLoopOperator = true
          pcall(ContentConfig.Callback)
          BetterLoopOperator = false
        end
      end)
    elseif ContentConfig.Type == "Switch" then
      local TextLabel = Instance.new("TextLabel")
      TextLabel.Parent = Frame
      TextLabel.BackgroundTransparency = 1
      TextLabel.Position = UDim2.new(0.1,0,0.15)
      TextLabel.Size = UDim2.new(0.7,0,0.7,0)
      TextLabel.Font = Enum.Font.SourceSansBold
      TextLabel.TextColor3 = Color3.fromRGB(248,248,248)
      TextLabel.TextXAlignment = Enum.TextXAlignment.Left
      TextLabel.Text = ContentConfig.Text
      TextLabel.TextSize = 18
      TextLabel.TextScaled = false
      TextLabel.TextWrapped = true

      local ImageButton = Instance.new("ImageButton")
      ImageButton.Parent = Frame
      ImageButton.BackgroundTransparency = 1
      ImageButton.Position = UDim2.new(0.785,0,0.05)
      ImageButton.Size = UDim2.new(0.2,0,0.9,0)
      ImageButton.Image = "rbxassetid://85429087203738"
      ImageButton.Rotation = 180
      ImageButton.Draggable = false
      ImageButton.Visible = true

      ImageButton.MouseButton1Click:Connect(function()
        if ImageButton.Rotation == 180 then
          ImageButton.Rotation = 0
          pcall(ContentConfig.Callback)
        else
          ImageButton.Rotation = 180
          pcall(ContentConfig.Callback2)
        end
      end)
    end
    if ContentPositionZ ~= TargetPositionZ then
      ContentPositionZ += 9.3
      Frame.Size = UDim2.new(1,0,11 + ContentPositionZ,0)
    else
      Frame.AutomaticSize = Enum.AutomaticSize.None
    end
    if RETURN ~= nil then
      return RETURN
    end
  end
  
  return GhostUI.Window
end

function GhostUI:Destroy()
  ScreeGui1:Destroy()
end

return GhostUI
