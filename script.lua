-- // GHOST FAKE - SCRIPT MEGA COMPLETO CYBERPUNK (RE-INTENTO DE FIX PARA EXECUTOR) // --

-- NOTIFICACION DE CARGA
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "✓ CARGADO",
        Text = "GHOST FAKE 💀 (Iniciando GUI...) Por favor, espera.",
        Duration = 5
    })
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

-- Esperar hasta que el PlayerGui esté disponible de forma segura
local playerGui = LocalPlayer:WaitForChild("PlayerGui")

-- SONIDO
local openSound = Instance.new("Sound", SoundService)
openSound.SoundId = "rbxassetid://9118828565"
openSound.Volume = 2

-- GUI (AHORA EN PLAYERGUI)
local gui = Instance.new("ScreenGui")
gui.Name = "GhostFakeUI"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- BOTON FLOTANTE
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0,55,0,55)
toggle.Position = UDim2.new(0,15,0,200)
toggle.BackgroundColor3 = Color3.fromRGB(10,10,10)
toggle.BackgroundTransparency = 0.2
toggle.Text = "🌑"
toggle.TextScaled = true
toggle.Draggable = true
toggle.Font = Enum.Font.GothamBold

local toggleCorner = Instance.new("UICorner", toggle)
toggleCorner.CornerRadius = UDim.new(0,12)

local toggleStroke = Instance.new("UIStroke", toggle)
toggleStroke.Thickness = 2
toggleStroke.Color = Color3.fromRGB(0,170,255)

toggle.Parent = gui -- Asignar padre

-- MENU PRINCIPAL
local main = Instance.new("Frame")
main.Size = UDim2.new(0,280,0,450) -- Aumentamos el tamaño para más botones
main.Position = UDim2.new(0.5,-140,0.5,-225) -- Centrar
main.BackgroundColor3 = Color3.fromRGB(15,15,25)
main.BackgroundTransparency = 0.35 -- TRANSPARENCIA
main.Visible = false -- Inicialmente invisible
main.Draggable = true
main.ClipsDescendants = true

-- BORDE BRILLOSO AZUL
local outline = Instance.new("UIStroke", main)
outline.Thickness = 2.5
outline.Color = Color3.fromRGB(0,200,255)

-- ESQUINAS REDONDEADAS
local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0,12)

-- GRADIENTE DE FONDO
local gradient = Instance.new("UIGradient", main)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
gradient.Rotation = 45
gradient.Transparency = NumberSequence.new(0.85)

main.Parent = gui -- Asignar padre

-- Intentar asignar la ScreenGui a PlayerGui
local success, errorMessage = pcall(function()
    gui.Parent = playerGui
end)

if not success then
    warn("Error al asignar GUI a PlayerGui:", errorMessage)
    -- Si falla en PlayerGui, intentar con CoreGui como último recurso (poco probable que funcione)
    pcall(function()
        gui.Parent = game.CoreGui
    end)
    game.StarterGui:SetCore("SendNotification", {
        Title = "⚠️ ADVERTENCIA",
        Text = "La GUI no se pudo inyectar en PlayerGui. Intentando CoreGui (podría no funcionar).",
        Duration = 7
    })
end

-- LÓGICA DE ABRIR/CERRAR MENÚ
local menuOpen = false

local function setMenuVisibility(isVisible)
    menuOpen = isVisible
    main.Visible = isVisible
    if isVisible then
        pcall(function() openSound:Play() end)
    end
end

-- Abrir automáticamente al cargar (después de 2 segundos)
task.delay(2,function()
    setMenuVisibility(true)
end)

-- Conectar el botón flotante para alternar visibilidad
toggle.MouseButton1Click:Connect(function()
    setMenuVisibility(not menuOpen)
end)

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
local tabs = {"COMBAT","VISUAL","STATS","OTROS"}
local frames = {}

for i,v in pairs(tabs) do
    local b = Instance.new("TextButton", main)
    b.Name = v .. "TabButton" -- Nombre único para el botón
    b.Size = UDim2.new(0.25,0,0,30)
    b.Position = UDim2.new((i-1)*0.25,0,0,40)
    b.Text = v
    b.BackgroundColor3 = Color3.fromRGB(0,0,0)
    b.BackgroundTransparency = 0.6
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 13

    local tabCorner = Instance.new("UICorner", b)
    tabCorner.CornerRadius = UDim.new(0,5)

    frames[v] = Instance.new("Frame", main)
    frames[v].Name = v .. "Frame" -- Nombre único para el frame
    frames[v].Size = UDim2.new(1,0,0.78,0) -- Ajustamos el tamaño para más botones
    frames[v].Position = UDim2.new(0,0,0,72)
    frames[v].BackgroundTransparency = 1
    frames[v].Visible = false

    b.MouseButton1Click:Connect(function()
        for _,f in pairs(frames) do f.Visible=false end
        frames[v].Visible=true
    end)
end

frames["COMBAT"].Visible = true -- Mostrar la primera pestaña por defecto

-- FUNCION BOTON
local function btn(parent,text,y,func)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0.92,0,0,30)
    b.Position = UDim2.new(0.04,0,0,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(0,30,60)
    b.BackgroundTransparency = 0.4
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    local btnCorner = Instance.new("UICorner", b)
    btnCorner.CornerRadius = UDim.new(0,6)
    b.MouseButton1Click:Connect(func)
    return b
end

-- FUNCION SLIDER (Deslizador)
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

    local currentVal = initialVal

    local function updateValue(input)
        local pos = input.Position.X - sliderFrame.AbsolutePosition.X
        local ratio = math.clamp(pos / sliderFrame.AbsoluteSize.X, 0, 1)
        currentVal = math.round(minVal + (maxVal - minVal) * ratio)
        fill.Size = UDim2.new((currentVal-minVal)/(maxVal-minVal),0,1,0)
        label.Text = text .. ": " .. currentVal
        func(currentVal)
    end

    sliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            updateValue(input)
            local mouse = LocalPlayer:GetMouse()
            local connection
            connection = mouse.Move:Connect(function()
                updateValue(mouse)
            end)
            sliderFrame.InputEnded:Connect(function(input2)
                if input2.UserInputType == Enum.UserInputType.MouseButton1 or input2.UserInputType == Enum.UserInputType.Touch then
                    connection:Disconnect()
                end
            end)
        end
    end)
    return frame
end

-- FUNCION INPUT FIELD
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
    textbox.TextColor3 = Color3.fromRGB(255,255,255)
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

-- VARIABLES GLOBALES DEL SCRIPT
local speed=16
local jump=50
local voice=false
local espEnabled=false
local hitboxEnabled=false
local hitboxRadius = 25
local autoAttackEnabled = false
local autoFarmEnabled = false
local flyEnabled = false
local rotateSpeed = 10 -- Velocidad de giro inicial
local antiDamageEnabled = false
local fovVisualEnabled = false
local fovRadius = 50 -- Radio inicial del FOV visual
local currentThemeColor = Color3.fromRGB(0,200,255) -- Color inicial del tema
local lastSafePosition = nil -- Para Anti Caída
local isFalling = false -- Para Anti Caída

-- FUNCIÓN PARA OBTENER EL JUGADOR MÁS CERCANO (O NPC)
local function getClosestTarget(range, includeNPCs)
    local lpChar = LocalPlayer.Character
    if not lpChar or not lpChar:FindFirstChild("HumanoidRootPart") then return nil end
    local lpPos = lpChar.HumanoidRootPart.Position

    local closestTarget = nil
    local minDistance = range

    -- Buscar jugadores
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local targetPos = player.Character.HumanoidRootPart.Position
            local distance = (lpPos - targetPos).magnitude
            if distance < minDistance then
                minDistance = distance
                closestTarget = player.Character.HumanoidRootPart
            end
        end
    end

    -- Buscar NPCs (si está activado el auto farm, por ejemplo)
    if includeNPCs then
        for _, descendant in pairs(Workspace:GetDescendants()) do
            if descendant:IsA("Model") and descendant:FindFirstChild("Humanoid") and descendant:FindFirstChild("HumanoidRootPart") and descendant.Humanoid.Health > 0 then
                -- Asegurarse de que no sea un jugador
                if not Players:GetPlayerFromCharacter(descendant) then
                    local targetPos = descendant.HumanoidRootPart.Position
                    local distance = (lpPos - targetPos).magnitude
                    if distance < minDistance then
                        minDistance = distance
                        closestTarget = descendant.HumanoidRootPart
                    end
                end
            end
        end
    end

    return closestTarget
end

-- Inicializar lastSafePosition al inicio o al cargar el personaje
if LocalPlayer.Character then
    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    
