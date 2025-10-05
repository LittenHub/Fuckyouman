--[[ 
Hello Again guys, sorry for the TurtleUiLib no new update now.
but i found another UI lib Called SimpleUI.
Credits to hm5650 on Github.
]]

--[[
How To use This Lib?

// Here the function: \\

-- really cool gui this is a WIP tho :>
-- Config

-- local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hm5650/SimpleGui/refs/heads/main/SimpleGui.lua"))()
-- you can use the original link or my link
-- if hm5650 update the gui, this script update too.

local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/LittenHub/Fuckyouman/refs/heads/main/SimpleGui.lua"))()
local ui = UILibrary.new({
    TitleText = "My Really cool gui", -- change title text
    Size = UDim2.new(0, 175, 0, 225), -- change Size
    Position = UDim2.new(0.5, -140, 0.5, -190), -- change position when UI starts
    TitleHeight = 30,
    CornerRadius = 6,
    ElementPadding = 6,
    Font = Enum.Font.GothamSemibold,
    TextSize = 12,
    SectionHeight = 20,
    UIStrokeThickness = 1
})

-- Elements

local section1 = ui:AddSection("Basic Controls") -- section

-- Button
ui:AddButton({
    Text = "Button Sample",
    Callback = function()
        print("Clicked!")
    end
})

-- Toggle
local toggle = ui:AddToggle({
    Text = "ToggleGetState",
    Default = false, -- change default true Toggled On / False Toggled Off
    Callback = function(state)
        print("Toggle state changed to:", state)
    end
})

-- Toggle with GetState
local toggle, getToggleState = ui:AddToggle({
    Text = "Toggle Sample",
    Default = true,
    Callback = function(state)
        print("Toggle state changed to:", state)
    end
})

-- Button to check GetState
ui:AddButton({
    Text = "Check Toggle State",
    Callback = function()
        print("Current toggle state:", getToggleState())
    end
})

ui:AddSeparator() -- Separator/Divider
local section2 = ui:AddSection("TextBoxz")

-- Simple Textbox
local textBox = ui:AddTextBox({
    Text = "Type Me!",
    Default = "stuff",
    Placeholder = "Type Me!",
    Callback = function(text)
        print("entered:", text)
    end
})

ui:AddTextBox({
    Text = "Password",
    Default = "Stuff",
    Placeholder = "Enter password",
    Callback = function(text)
        print("nice pass:", text)
    end
})

ui:AddSeparator()
local section3 = ui:AddSection("Stuff")

-- UI controlz

ui:AddButton({
    Text = "Change UI Title",
    Callback = function()
        ui:SetTitle("New Title - " .. os.date("%X"))
    end
})

ui:AddButton({
    Text = "ByeBye",
    Callback = function()
        ui:Destroy()
    end
})

ui:AddSeparator()
local section4 = ui:AddSection("Labels")

-- the Sliders is buggy now.
local slider = ui:AddSlider({
    Text = "Speed Changer",
    Default = 16,
    Min = 1,
    Max = 100,
    Round = 0,
    Callback = function(value)
        print("speed change to: ", value)
    end
})

ui:AddSeparator()
local section4 = ui:AddSection("Labels")

-- labelz

ui:AddLabel("I'm a label")
ui:AddLabel("Today: " .. os.date("%B %d, %Y"))
]]

--[[
you can look the original github
here the link:
https://github.com/hm5650/SimpleGui/blob/main/Example.lua

]]
-- local Service 
local UILibrary = {}
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Fungsi Lerp sederhana
local function Lerp(a, b, t)
	return a + (b - a) * t
end
-- // Color Config \\ --
UILibrary.DefaultColors = {
    TitleColor = Color3.fromRGB(255, 255, 255),
    CollapseBtnColor = Color3.fromRGB(25, 25, 25),
    ButtonColor = Color3.fromRGB(45, 45, 45),
    ButtonHoverColor = Color3.fromRGB(60, 60, 60),
    ToggleColor = Color3.fromRGB(45, 45, 45),
    ToggleColorOFF = Color3.fromRGB(200, 60, 60),
    ToggleColorON = Color3.fromRGB(60, 200, 60),
    MainFrameColor = Color3.fromRGB(35, 35, 35),
    SeparatorColor = Color3.fromRGB(70, 70, 70),
    TextBoxColor = Color3.fromRGB(45, 45, 45),
    AccentColor = Color3.fromRGB(0, 120, 215),
    SectionColor = Color3.fromRGB(90, 90, 90),
    LabelColor = Color3.fromRGB(200, 200, 200),
    SliderColor = Color3.fromRGB(70, 70, 70),
    SliderHandleColor = Color3.fromRGB(100, 100, 100),
    UIStrokeColor = Color3.fromRGB(60, 60, 60)
}

-- Config stuff
UILibrary.DefaultConfig = {
    Title = "UI Library",
    TitleText = "UI Library",
    Size = UDim2.new(0, 250, 0, 350),
    Position = UDim2.new(0.5, -125, 0.5, -175),
    TitleHeight = 30,
    CornerRadius = 6,
    ElementPadding = 6,
    Font = Enum.Font.GothamSemibold,
    TextSize = 12,
    SectionHeight = 20,
    UIStrokeThickness = 1,
    UIStrokeEnabled = true,
    -- ToggleUI = true -- this is for make the gui invisible
}
-- // Config function \\ --
function UILibrary.new(config)
    local self = setmetatable({}, { __index = UILibrary })
    
    self.Config = {}
    for k, v in pairs(UILibrary.DefaultConfig) do
        self.Config[k] = config[k] or v
    end
    
    self.Colors = {}
    for colorName, defaultColor in pairs(UILibrary.DefaultColors) do
        self.Colors[colorName] = config[colorName] or defaultColor
    end
    
    self.Elements = {}
    self.Visible = true
    self.Minimized = false
    
    self:CreateUI()
    
    return self
end

-- // Main Function for Create the Gui \\ --
function UILibrary:CreateUI()
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "UILibrary"
    self.ScreenGui.Parent = game:GetService("CoreGui")
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.Size = self.Config.Size
    self.MainFrame.Position = self.Config.Position
    self.MainFrame.BackgroundColor3 = self.Colors.MainFrameColor
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Active = true
    self.MainFrame.Draggable = true
    self.MainFrame.ClipsDescendants = true
    self.MainFrame.Parent = self.ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.Config.CornerRadius)
    corner.Parent = self.MainFrame
    
    -- Add UI Stroke to main frame
    if self.Config.UIStrokeEnabled then
        local uiStroke = Instance.new("UIStroke")
        uiStroke.Thickness = self.Config.UIStrokeThickness
        uiStroke.Color = self.Colors.UIStrokeColor
        uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        uiStroke.Parent = self.MainFrame
    end
    
    self.TitleBar = Instance.new("Frame")
    self.TitleBar.Name = "TitleBar"
    self.TitleBar.Size = UDim2.new(1, 0, 0, self.Config.TitleHeight)
    self.TitleBar.Position = UDim2.new(0, 0, 0, 0)
    self.TitleBar.BackgroundColor3 = self.Colors.CollapseBtnColor
    self.TitleBar.BorderSizePixel = 0
    self.TitleBar.ZIndex = 2
    self.TitleBar.Parent = self.MainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, self.Config.CornerRadius)
    titleCorner.Parent = self.TitleBar
    
    self.TitleText = Instance.new("TextLabel")
    self.TitleText.Name = "TitleText"
    self.TitleText.Size = UDim2.new(0.7, 0, 1, 0)
    self.TitleText.Position = UDim2.new(0, 12, 0, 0)
    self.TitleText.BackgroundTransparency = 1
    self.TitleText.Text = self.Config.TitleText
    self.TitleText.TextColor3 = self.Colors.TitleColor
    self.TitleText.TextXAlignment = Enum.TextXAlignment.Left
    self.TitleText.Font = Enum.Font.GothamBold
    self.TitleText.TextSize = 14
    self.TitleText.ZIndex = 3
    self.TitleText.Parent = self.TitleBar
    
    self.MinimizeButton = Instance.new("TextButton")
    self.MinimizeButton.Name = "MinimizeButton"
    self.MinimizeButton.Size = UDim2.new(0, self.Config.TitleHeight, 0, self.Config.TitleHeight)
    self.MinimizeButton.Position = UDim2.new(1, -self.Config.TitleHeight, 0, 0)
    self.MinimizeButton.BackgroundColor3 = self.Colors.CollapseBtnColor
    self.MinimizeButton.BorderSizePixel = 0
    self.MinimizeButton.Text = "-"
    self.MinimizeButton.TextColor3 = self.Colors.TitleColor
    self.MinimizeButton.Font = Enum.Font.GothamBold
    self.MinimizeButton.TextSize = 18
    self.MinimizeButton.ZIndex = 3
    self.MinimizeButton.Parent = self.TitleBar
    
    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, self.Config.CornerRadius)
    minCorner.Parent = self.MinimizeButton
    
    self.ScrollingFrame = Instance.new("ScrollingFrame")
    self.ScrollingFrame.Name = "ContentFrame"
    self.ScrollingFrame.Size = UDim2.new(1, 0, 1, -self.Config.TitleHeight)
    self.ScrollingFrame.Position = UDim2.new(0, 0, 0, self.Config.TitleHeight)
    self.ScrollingFrame.BackgroundTransparency = 1
    self.ScrollingFrame.BorderSizePixel = 0
    self.ScrollingFrame.ScrollBarThickness = 4
    self.ScrollingFrame.ScrollBarImageColor3 = self.Colors.AccentColor
    self.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.ScrollingFrame.Parent = self.MainFrame
    
    self.UIListLayout = Instance.new("UIListLayout")
    self.UIListLayout.Padding = UDim.new(0, self.Config.ElementPadding)
    self.UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.UIListLayout.Parent = self.ScrollingFrame
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 12)
    padding.PaddingRight = UDim.new(0, 12)
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingBottom = UDim.new(0, 10)
    padding.Parent = self.ScrollingFrame
    
    self.OriginalSize = self.MainFrame.Size
    self.OriginalPosition = self.MainFrame.Position
    
    self.MinimizeButton.MouseButton1Click:Connect(function()
        self:ToggleMinimize()
    end)
    
    self.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, self.UIListLayout.AbsoluteContentSize.Y + 15)
    end)
    
    self.TitleBar.MouseEnter:Connect(function()
        self.TitleBar.BackgroundColor3 = Color3.new(
            self.Colors.CollapseBtnColor.R * 1.2,
            self.Colors.CollapseBtnColor.G * 1.2,
            self.Colors.CollapseBtnColor.B * 1.2
        )
    end)
    
    self.TitleBar.MouseLeave:Connect(function()
        self.TitleBar.BackgroundColor3 = self.Colors.CollapseBtnColor
    end)
end

function UILibrary:ToggleMinimize()
    self.Minimized = not self.Minimized
    if self.Minimized then
        self.MainFrame.Size = UDim2.new(0, self.OriginalSize.X.Offset, 0, self.Config.TitleHeight)
        self.MinimizeButton.Text = "+"
        self.ScrollingFrame.Visible = false
    else
        self.MainFrame.Size = self.OriginalSize
        self.MinimizeButton.Text = "-"
        self.ScrollingFrame.Visible = true
    end
end

-- // Function for set the Visibility \\ --
function UILibrary:ToggleVisibility()
    self.Visible = not self.Visible
    self.ScreenGui.Enabled = self.Visible
end

-- // Function for change the title \\ --
function UILibrary:SetTitle(newTitle)
    self.Config.TitleText = newTitle
    self.TitleText.Text = newTitle
end

-- // Function for make a section \\ --
function UILibrary:AddSection(text)
    local section = Instance.new("Frame")
    section.Name = "Section_" .. text
    section.Size = UDim2.new(1, -24, 0, self.Config.SectionHeight)
    section.Position = UDim2.new(0, 12, 0, 0)
    section.BackgroundTransparency = 1
    section.LayoutOrder = #self.Elements + 1
    section.Parent = self.ScrollingFrame
    
    local sectionText = Instance.new("TextLabel")
    sectionText.Name = "TextLabel"
    sectionText.Size = UDim2.new(1, 0, 1, 0)
    sectionText.Position = UDim2.new(0, 0, 0, 0)
    sectionText.BackgroundTransparency = 1
    sectionText.Text = text
    sectionText.TextColor3 = self.Colors.SectionColor
    sectionText.TextXAlignment = Enum.TextXAlignment.Left
    sectionText.Font = Enum.Font.GothamBold
    sectionText.TextSize = self.Config.TextSize + 1
    sectionText.Parent = section
    
    table.insert(self.Elements, section)
    return section
end

-- // Function for make a Label \\ --
function UILibrary:AddLabel(text)
    local label = Instance.new("TextLabel")
    label.Name = "Label_" .. text
    label.Size = UDim2.new(1, -24, 0, 18)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = self.Colors.LabelColor
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = self.Config.Font
    label.TextSize = self.Config.TextSize
    label.LayoutOrder = #self.Elements + 1
    label.Parent = self.ScrollingFrame
    
    table.insert(self.Elements, label)
    return label
end

-- // Function for make a Button \\ --
function UILibrary:AddButton(config)
    local button = Instance.new("TextButton")
    button.Name = "Button_" .. config.Text
    button.Size = UDim2.new(1, -24, 0, 30)
    button.Position = UDim2.new(0, 12, 0, 0)
    button.BackgroundColor3 = self.Colors.ButtonColor
    button.BorderSizePixel = 0
    button.Text = config.Text
    button.TextColor3 = self.Colors.TitleColor
    button.Font = self.Config.Font
    button.TextSize = self.Config.TextSize
    button.LayoutOrder = #self.Elements + 1
    button.AutoButtonColor = false
    button.Parent = self.ScrollingFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = button
    
    -- Add UI Stroke to button
    if self.Config.UIStrokeEnabled then
        local buttonStroke = Instance.new("UIStroke")
        buttonStroke.Thickness = self.Config.UIStrokeThickness
        buttonStroke.Color = self.Colors.UIStrokeColor
        buttonStroke.Parent = button
    end
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = self.Colors.ButtonHoverColor
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = self.Colors.ButtonColor
    end)
    
    if config.Callback then
        button.MouseButton1Click:Connect(function()
            local originalSize = button.Size
            button.Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, originalSize.Y.Scale, originalSize.Y.Offset - 2)
            task.wait(0.08)
            button.Size = originalSize
            
            config.Callback()
        end)
    end
    
    table.insert(self.Elements, button)
    return button
end

-- // Function for make a Toggle \\ --
function UILibrary:AddToggle(config)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = "Toggle_" .. config.Text
    toggleFrame.Size = UDim2.new(1, -24, 0, 32)
    toggleFrame.Position = UDim2.new(0, 12, 0, 0)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.LayoutOrder = #self.Elements + 1
    toggleFrame.Parent = self.ScrollingFrame
    
    local toggleText = Instance.new("TextLabel")
    toggleText.Name = "TextLabel"
    toggleText.Size = UDim2.new(0.65, 0, 1, 0)
    toggleText.Position = UDim2.new(0, 0, 0, 0)
    toggleText.BackgroundTransparency = 1
    toggleText.Text = config.Text
    toggleText.TextColor3 = self.Colors.TitleColor
    toggleText.TextXAlignment = Enum.TextXAlignment.Left
    toggleText.Font = self.Config.Font
    toggleText.TextSize = self.Config.TextSize
    toggleText.Parent = toggleFrame
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0.3, 0, 0.75, 0)
    toggleButton.Position = UDim2.new(0.68, 0, 0.125, 0)
    toggleButton.BackgroundColor3 = self.Colors.ToggleColor
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = config.Default and "ON" or "OFF"
    toggleButton.TextColor3 = config.Default and self.Colors.ToggleColorON or self.Colors.ToggleColorOFF
    toggleButton.Font = self.Config.Font
    toggleButton.TextSize = self.Config.TextSize
    toggleButton.AutoButtonColor = false
    toggleButton.Parent = toggleFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = toggleButton
    
    -- Add UI Stroke to toggle button
    if self.Config.UIStrokeEnabled then
        local toggleStroke = Instance.new("UIStroke")
        toggleStroke.Thickness = self.Config.UIStrokeThickness
        toggleStroke.Color = self.Colors.UIStrokeColor
        toggleStroke.Parent = toggleButton
    end
    
    local state = config.Default or false
    
    toggleButton.MouseEnter:Connect(function()
        toggleButton.BackgroundColor3 = Color3.new(
            self.Colors.ToggleColor.R * 1.1,
            self.Colors.ToggleColor.G * 1.1,
            self.Colors.ToggleColor.B * 1.1
        )
    end)
    
    toggleButton.MouseLeave:Connect(function()
        toggleButton.BackgroundColor3 = self.Colors.ToggleColor
    end)
    
    toggleButton.MouseButton1Click:Connect(function()
        state = not state
        if state then
            toggleButton.Text = "ON"
            toggleButton.TextColor3 = self.Colors.ToggleColorON
        else
            toggleButton.Text = "OFF"
            toggleButton.TextColor3 = self.Colors.ToggleColorOFF
        end
        
        if config.Callback then
            config.Callback(state)
        end
    end)
    
    table.insert(self.Elements, toggleFrame)
    return toggleFrame, function() return state end
end

-- // Function for make a Textbox \\ --
function UILibrary:AddTextBox(config)
    local textBoxFrame = Instance.new("Frame")
    textBoxFrame.Name = "TextBox_" .. config.Text
    textBoxFrame.Size = UDim2.new(1, -24, 0, 50)
    textBoxFrame.Position = UDim2.new(0, 12, 0, 0)
    textBoxFrame.BackgroundTransparency = 1
    textBoxFrame.LayoutOrder = #self.Elements + 1
    textBoxFrame.Parent = self.ScrollingFrame
    
    local textBoxLabel = Instance.new("TextLabel")
    textBoxLabel.Name = "TextLabel"
    textBoxLabel.Size = UDim2.new(1, 0, 0.4, 0)
    textBoxLabel.Position = UDim2.new(0, 0, 0, 0)
    textBoxLabel.BackgroundTransparency = 1
    textBoxLabel.Text = config.Text
    textBoxLabel.TextColor3 = self.Colors.TitleColor
    textBoxLabel.TextXAlignment = Enum.TextXAlignment.Left
    textBoxLabel.Font = self.Config.Font
    textBoxLabel.TextSize = self.Config.TextSize
    textBoxLabel.Parent = textBoxFrame
    
    local textBox = Instance.new("TextBox")
    textBox.Name = "TextBox"
    textBox.Size = UDim2.new(1, 0, 0.6, 0)
    textBox.Position = UDim2.new(0, 0, 0.4, 0)
    textBox.BackgroundColor3 = self.Colors.TextBoxColor
    textBox.BorderSizePixel = 0
    textBox.Text = config.Default or ""
    textBox.TextColor3 = self.Colors.TitleColor
    textBox.Font = self.Config.Font
    textBox.TextSize = self.Config.TextSize
    textBox.PlaceholderText = config.Placeholder or ""
    textBox.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
    textBox.Parent = textBoxFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = textBox
    
    -- Add UI Stroke to text box
    if self.Config.UIStrokeEnabled then
        local textBoxStroke = Instance.new("UIStroke")
        textBoxStroke.Thickness = self.Config.UIStrokeThickness
        textBoxStroke.Color = self.Colors.UIStrokeColor
        textBoxStroke.Parent = textBox
    end
    
    if config.Callback then
        textBox.FocusLost:Connect(function(enterPressed)
            if not enterPressed and config.RequireEnter then return end
            config.Callback(textBox.Text)
        end)
    end
    
    table.insert(self.Elements, textBoxFrame)
    return textBoxFrame
end

-- // Function for make a Divider \\ --
function UILibrary:AddSeparator()
    local separator = Instance.new("Frame")
    separator.Name = "Separator"
    separator.Size = UDim2.new(1, -24, 0, 1)
    separator.Position = UDim2.new(0, 12, 0, 0)
    separator.BackgroundColor3 = self.Colors.SeparatorColor
    separator.BorderSizePixel = 0
    separator.LayoutOrder = #self.Elements + 1
    separator.Parent = self.ScrollingFrame
    
    table.insert(self.Elements, separator)
    return separator
end

-- // Function for make a Slider \\ --

function UILibrary:AddSlider(config)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = "Slider_" .. config.Text
    sliderFrame.Size = UDim2.new(1, -24, 0, 70)
    sliderFrame.Position = UDim2.new(0, 12, 0, 0)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.LayoutOrder = #self.Elements + 1
    sliderFrame.Parent = self.ScrollingFrame

    local sliderText = Instance.new("TextLabel")
    sliderText.Size = UDim2.new(0.7, 0, 0.4, 0)
    sliderText.Position = UDim2.new(0, 0, 0, 0)
    sliderText.BackgroundTransparency = 1
    sliderText.Text = config.Text .. ":"
    sliderText.TextColor3 = self.Colors.TitleColor
    sliderText.TextXAlignment = Enum.TextXAlignment.Left
    sliderText.Font = self.Config.Font
    sliderText.TextSize = self.Config.TextSize
    sliderText.Parent = sliderFrame

    local valueBox = Instance.new("TextBox")
    valueBox.Size = UDim2.new(0.25, 0, 0.4, 0)
    valueBox.Position = UDim2.new(0.75, 0, 0, 0)
    valueBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    valueBox.Text = tostring(config.Default)
    valueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    valueBox.Font = self.Config.Font
    valueBox.TextSize = self.Config.TextSize
    valueBox.ClearTextOnFocus = false
    valueBox.Parent = sliderFrame
	
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 6)
    boxCorner.Parent = valueBox

    local minLabel = Instance.new("TextLabel")
    minLabel.Size = UDim2.new(0, 50, 0, 16)
    minLabel.Position = UDim2.new(0, 0, 0.5, 0)
    minLabel.BackgroundTransparency = 1
    minLabel.Text = tostring(config.Min)
    minLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    minLabel.TextXAlignment = Enum.TextXAlignment.Left
    minLabel.Font = self.Config.Font
    minLabel.TextSize = 12
    minLabel.Parent = sliderFrame

    local maxLabel = Instance.new("TextLabel")
    maxLabel.Size = UDim2.new(0, 50, 0, 16)
    maxLabel.Position = UDim2.new(1, -50, 0.5, 0)
    maxLabel.BackgroundTransparency = 1
    maxLabel.Text = tostring(config.Max)
    maxLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    maxLabel.TextXAlignment = Enum.TextXAlignment.Right
    maxLabel.Font = self.Config.Font
    maxLabel.TextSize = 12
    maxLabel.Parent = sliderFrame
	
    local sliderTrack = Instance.new("Frame")
    sliderTrack.Name = "Track"
    sliderTrack.Size = UDim2.new(1, 0, 0, 6)
    sliderTrack.Position = UDim2.new(0, 0, 0.75, 0)
    sliderTrack.BackgroundColor3 = self.Colors.SliderColor
    sliderTrack.BorderSizePixel = 0
    sliderTrack.ZIndex = 0
    sliderTrack.Parent = sliderFrame
	
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = sliderTrack

    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "Fill"
    sliderFill.Size = UDim2.new((config.Default - config.Min) / (config.Max - config.Min), 0, 1, 0)
    sliderFill.BackgroundColor3 = self.Colors.AccentColor
    sliderFill.BorderSizePixel = 0
    sliderFill.ZIndex = 1
    sliderFill.Parent = sliderTrack
	
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = sliderFill

    local sliderHandle = Instance.new("TextButton")
    sliderHandle.Name = "Handle"
    sliderHandle.Size = UDim2.new(0, 16, 0, 16)
    sliderHandle.Position = UDim2.new(sliderFill.Size.X.Scale, -8, 0.5, -8)
    sliderHandle.BackgroundColor3 = self.Colors.SliderHandleColor
    sliderHandle.BorderSizePixel = 0
    sliderHandle.Text = ""
    sliderHandle.AutoButtonColor = false
    sliderHandle.ZIndex = 2
    sliderHandle.Parent = sliderTrack
	
    local handleCorner = Instance.new("UICorner")
    handleCorner.CornerRadius = UDim.new(1, 0)
    handleCorner.Parent = sliderHandle

    if self.Config.UIStrokeEnabled then
        local handleStroke = Instance.new("UIStroke")
        handleStroke.Thickness = self.Config.UIStrokeThickness
        handleStroke.Color = self.Colors.UIStrokeColor
        handleStroke.Parent = sliderHandle
    end

-- Fungsi untuk update posisi slider dari value
local function SetSliderValue(value)
	value = math.clamp(value, SliConfig.Min, SliConfig.Max)
	local ratio = (value - SliConfig.Min) / (SliConfig.Max - SliConfig.Min)
	local xOffset = ratio * (Slider.Size.X.Offset - 5)
	SliderButton.Position = UDim2.new(0, xOffset, -1.33333337, 0)
	SliderFiller.Size = UDim2.new(0, xOffset, 0, 6)

	if SliConfig.Round and SliConfig.Round > 0 then
		value = tonumber(string.format("%."..SliConfig.Round.."f", value))
	else
		value = math.round(value)
	end

	TextBox.Text = tostring(value)
	Current.Text = tostring(value)
end

	local isDragging = false
	local stepped = RunService.RenderStepped
	
function SliderMovement(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isDragging = true
		local initial = SliderButton.Position.X.Offset
		local delta1 = SliderButton.AbsolutePosition.X - initial
		local connection

		connection = stepped:Connect(function()
			if isDragging then
				local mouseX = UserInputService:GetMouseLocation().X
				local xOffset = mouseX - delta1 - 3

				-- Batasi posisi slider
				xOffset = math.clamp(xOffset, 0, Slider.Size.X.Offset)

				SliderButton.Position = UDim2.new(0, xOffset, -1.33333337, 0)
				SliderFiller.Size = UDim2.new(0, xOffset, 0, 6)

				local value = Lerp(SliConfig.Min, SliConfig.Max, xOffset / (Slider.Size.X.Offset - 5))
				if SliConfig.Round and SliConfig.Round > 0 then
					value = tonumber(string.format("%."..SliConfig.Round.."f", value))
				else
					value = math.round(value)
				end

				TextBox.Text = tostring(value)
				Current.Text = tostring(value)
			else
				connection:Disconnect()
			end
		end)

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				isDragging = false
			end
		end)
	end
end

	function SliderEnd(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			local value = Lerp(SliConfig.Min, SliConfig.Max, SliderButton.Position.X.Offset / (Slider.Size.X.Offset - 5))
			if SliConfig.Round and SliConfig.Round > 0 then
			value = tonumber(string.format("%."..SliConfig.Round.."f", value))
		else
			value = math.round(value)
		end
			TextBox.Text = tostring(value)
			Current.Text = tostring(value)
			SliConfig.Callback(value)
		end
	end
	
-- Event untuk update slider saat TextBox diubah
	TextBox.FocusLost:Connect(function()
		local num = tonumber(TextBox.Text)
		if num then	
			SetSliderValue(num)
			SliConfig.Callback(num)
		else
			TextBox.Text = Current.Text
		end
	end)

    sliderTrack.InputBegan:Connect(SliderMovement)
	sliderTrack.InputEnded:Connect(SliderEnd)

	sliderHandle.InputBegan:Connect(SliderMovement)
	sliderHandle.InputEnded:Connect(SliderEnd)
    
    table.insert(self.Elements, sliderFrame)
    return sliderFrame, function() return currentValue end
end

-- // Function to destroy the UI \\ --
function UILibrary:Destroy()
    if self.ScreenGui then
        self.ScreenGui:Destroy()
    end
    self = nil
end

return UILibrary
