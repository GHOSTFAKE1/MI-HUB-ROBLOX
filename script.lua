-- // GHOST FAKE - SCRIPT MEGA COMPLETO (VERSION CORREGIDA Y OPTIMIZADA) // --

-- NOTIFICACION
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "✓ CARGADO",
        Text = "GHOST FAKE 💀 | Version Estable",
        Duration = 3
    })
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local ContextActionService = game:GetService("ContextActionService")

-- SONIDO
local openSound = Instance.new("Sound", SoundService)
openSound.SoundId = "rbxassetid://9118828565"
openSound.Volume = 2

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "GhostFakeUI"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- INTENTAR PONER EN COREGUI PRIMERO (COMO DIJISTE)
pcall(function()
    gui.Parent = game.CoreGui
end)
if not gui.Parent then
    pcall(function() gui.Parent = LocalPlayer.PlayerGui end)
end

-- BOTON FLOTANTE
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0,55,0,55)
toggle.Position = UDim2.new(0,15,0,200)
toggle.BackgroundColor3 = Color3.fromRGB(10,10,10)
toggle.BackgroundTransparency = 0.2
toggle.Text = "🌑"
toggle.TextScaled = true
toggle.Font = Enum.Font.GothamBold

local toggleCorner = Instance.new("UICorner", toggle)
toggleCorner.CornerRadius = UDim.new(0,12)
local toggleStroke = Instance.new("UIStroke", toggle)
toggleStroke.Thickness = 2
toggleStroke.Color = Color3.fromRGB(0,170,255)

-- SISTEMA DE ARRASTRE MANUAL (PARA QUE NO FALLE)
local draggingToggle, dragStartToggle, startPosToggle
toggle.MouseButton1Down:Connect(function()
    draggingToggle = true
    dragStartToggle = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    startPosToggle = toggle.Position
end)
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and draggingToggle then
        local Delta = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - dragStartToggle
        toggle.Position = UDim2.new(startPosToggle.X.Scale, startPosToggle.X.Offset + Delta.X, startPosToggle.Y.Scale, startPosToggle.Y.Offset + Delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingToggle = false
    end
end)

-- MENU PRINCIPAL
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,300,0,520) -- MAS GRANDE
main.Position = UDim2.new(0.5,-150,0.5,-260)
main.BackgroundColor3 = Color3.fromRGB(15,15,25)
main.BackgroundTransparency = 0.3 -- TRANSPARENTE
main.Visible = false
main.ClipsDescendants = true

-- ARRASTRE MENU
local dragging, dragStart, startPos
main.MouseButton1Down:Connect(function()
    dragging = true
    dragStart = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    startPos = main.Position
end)
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local Delta = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- BORDES Y ESTILO
local outline = Instance.new("UIStroke", main)
outline.Thickness = 2.5
outline.Color = Color3.fromRGB(0,200,255)
local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0,12)
local gradient = Instance.new("UIGradient", main)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
gradient.Rotation = 45
gradient.Transparency = NumberSequence.new(0.85)

-- ABRIR MENU
local menuOpen = false
toggle.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    main.Visible = menuOpen
    if menuOpen then openSound:Play() end
end)

task.delay(1.5, function() main.Visible = true menuOpen = true end)

-- TITULO
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,0)
title.Text = "🌑 GHOST FAKE 🌑"
title.BackgroundColor3 = Color3.fromRGB(0,0,0)
title.BackgroundTransparency = 0.5
title.TextColor3 = Color3.fromRGB(0,200,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- TABS
local tabs = {"COMBAT","VISUAL","OTROS"}
local frames = {}
for i,v in pairs(tabs) do
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(0.33,0,0,30)
    b.Position = UDim2.new((i-1)*0.33,0,0,40)
    b.Text = v
    b.BackgroundColor3 = Color3.fromRGB(0,0,0)
    b.BackgroundTransparency = 0.6
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    local tabCorner = Instance.new("UICorner", b)
    tabCorner.CornerRadius = UDim.new(0,5)

    frames[v] = Instance.new("Frame", main)
    frames[v].Size = UDim2.new(1,0,0.78,0)
    frames[v].Position = UDim2.new(0,0,0,72)
    frames[v].BackgroundTransparency = 1
    frames[v].Visible = false

    b.MouseButton1Click:Connect(function()
        for _,f in pairs(frames) do f.Visible=false end
        frames[v].Visible=true
    end)
end
frames["COMBAT"].Visible = true

-- FUNCIONES BOTON Y SLIDER
local function btn(parent,text,y,func)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0.92,0,0,32)
    b.Position = UDim2.new(0.04,0,0,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(0,30,60)
    b.BackgroundTransparency = 0.4
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    local btnCorner = Instance.new("UICorner", b)
    btnCorner.CornerRadius = UDim.new(0,6)
    b.MouseButton1Click:Connect(func)
    return b
end
local function slider(parent, text, y, minVal, maxVal, initialVal, func)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(0.92,0,0,40)
    frame.Position = UDim2.new(0.04,0,0,y)
    frame.BackgroundTransparency = 1
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1,0,0,20)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(150,220,255)
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = text .. ": " .. initialVal
    local sliderFrame = Instance.new("Frame", frame)
    sliderFrame.Size = UDim2.new(1,0,0,10)
    sliderFrame.Position = UDim2.new(0,0,0,25)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
    local sliderCorner = Instance.new("UICorner", sliderFrame)
    sliderCorner.CornerRadius = UDim.new(0,5)
    local fill = Instance.new("Frame", sliderFrame)
    fill.Size = UDim2.new((initialVal-minVal)/(maxVal-minVal),0,1,0)
    fill.BackgroundColor3 = Color3.fromRGB(0,200,255)
    local fillCorner = Instance.new("UICorner", fill)
    fillCorner.CornerRadius = UDim.new(0,5)
    sliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local connection
            connection = UserInputService.InputChanged:Connect(function(input2)
                if input2.UserInputType == Enum.UserInputType.MouseMovement or input2.UserInputType == Enum.UserInputType.TouchMoved then
                    local pos = UserInputService:GetMouseLocation().X - sliderFrame.AbsolutePosition.X
                    local ratio = math.clamp(pos / sliderFrame.AbsoluteSize.X, 0, 1)
                    local val = math.round(minVal + (maxVal - minVal) * ratio)
                    fill.Size = UDim2.new(ratio,0,1,0)
                    label.Text = text .. ": " .. val
                    func(val)
                end
            end)
            UserInputService.InputEnded:Connect(function(input3)
                if input3.UserInputType == Enum.UserInputType.MouseButton1 or input3.UserInputType == Enum.UserInputType.TouchEnded then
                    connection:Disconnect()
                end
            end)
        end
    end)
    return frame
end
local function inputField(parent, text, y, initialText, func)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(0.92,0,0,40)
    frame.Position = UDim2.new(0.04,0,0,y)
    frame.BackgroundTransparency = 1
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1,0,0,20)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(150,220,255)
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = text
    local textbox = Instance.new("TextBox", frame)
    textbox.Size = UDim2.new(1,0,0,20)
    textbox.Position = UDim2.new(0,0,0,20)
    textbox.BackgroundColor3 = Color3.fromRGB(0,30,60)
    textbox.BackgroundTransparency = 0.4
    textbox.TextColor3 = Color3.new(1,1,1)
    textbox.Font = Enum.Font.Gotham
    textbox.TextSize = 13
    textbox.Text = initialText
    local tbCorner = Instance.new("UICorner", textbox)
    tbCorner.CornerRadius = UDim.new(0,6)
    textbox.FocusLost:Connect(function()
        func(textbox.Text)
    end)
    return textbox
end

-- ==============================================
-- VARIABLES GLOBALES
-- ==============================================
local speed=16
local jump=50
local espEnabled=false
local hitboxEnabled=false
local hitboxRadius = 25
local autoAttackEnabled = false
local autoFarmEnabled = false
local flyEnabled = false
local rotateSpeed = 10
local antiDamageEnabled = false
local fovVisualEnabled = false
local fovRadius = 50
local antiFallEnabled = false
local lastSafePos = nil
local closestEnemyDist = 0

-- ==============================================
-- FUNCION CORREGIDA (LA QUE TU DIJISTE)
-- ==============================================
local function getClosestTarget(range)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    
    local closest = nil
    local dist = range
    
    for _,v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            if v.Humanoid.Health > 0 and Players:GetPlayerFromCharacter(v) == nil then -- Solo NPCs para farm
                local d = (char.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d
                    closest = v.HumanoidRootPart
                end
            end
        end
    end
    -- Buscar Jugadores
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") then
            if plr.Character.Humanoid.Health > 0 then
                local d = (char.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d
                    closest = plr.Character.HumanoidRootPart
                end
            end
        end
    end
    
    closestEnemyDist = dist
    return closest
end

-- ==============================================
-- LOOP PRINCIPAL (RenderStepped)
-- ==============================================
RunService.RenderStepped:Connect(function(delta)
    
    -- VELOCIDAD Y SALTO
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = speed
        LocalPlayer.Character.Humanoid.JumpPower = jump
    end

    -- ANTI CAIDA
    if antiFallEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        if hrp.Position.Y < -50 then
            if lastSafePos then
                hrp.CFrame = lastSafePos
            end
        else
            if hrp.Velocity.Y > -2 then
                lastSafePos = hrp.CFrame
            end
        end
    end

    -- FLY SIMPLE
    if flyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local camCF = workspace.CurrentCamera.CFrame
        local moveV = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveV += camCF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveV -= camCF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveV -= camCF.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveV += camCF.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveV += Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveV -= Vector3.new(0,1,0) end
        hrp.Velocity = moveV * 50
    end

    -- GIRAR LO
        
